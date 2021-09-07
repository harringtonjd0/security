package main

/*
	Continually list active TCP connections and display geolocation and owning organization
	for each remote IP.  Requires API key to ipgeolocation.io.  Displays output to terminal
	on both Windows and Linux.
*/

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"os/exec"
	"runtime"
	"strings"
	"time"

	"github.com/cakturk/go-netstat/netstat"
)

func err_check(message string, e error) {
	// Print error message and die
	if e != nil {
		log.Fatalln(message, e)
		return
	}
}

type IP_Response struct {
	// Struct for JSON response with IP Geolocation data
	IP            string
	City          string
	Country_Code3 string
	Organization  string
}

func align_column(text string) string {
	// Add tabs to text entries to align colums in terminal output
	if len(text) < 8 {
		text = text + "\t\t"
	} else if len(text) < 16 {
		text = text + "\t"
	} else if len(text) > 23 {
		text = text[0:21]
	}
	return text
}

func geolocate_IP(key string, address string) IP_Response {

	// Check if IP is Class C, if yes mark as localnet
	if address[0:7] == "192.168" || address[0:6] == "172.16" || address[0:3] == "10." {
		return IP_Response{address, "", "LAN", "LAN"}
	}

	// Query ipgeolocation.io for IP geo data
	// Only requests city, country code, and owning organization
	url := fmt.Sprintf("https://api.ipgeolocation.io/ipgeo?apiKey=%s&ip=%s&fields=city,country_code3,organization",
		key, address)
	resp, err := http.Get(url)
	err_check("GET Request failed: ", err)

	// Read the response body
	json_from_http, err := ioutil.ReadAll(resp.Body)
	err_check("Failed to read HTTP response: ", err)

	// Parse JSON response
	var json_data IP_Response
	err = json.Unmarshal([]byte(json_from_http), &json_data)
	err_check("Failed to parse JSON: ", err)
	return json_data
}

func clear_terminal() {
	// Clear terminal output on either windows or linux
	if runtime.GOOS == "linux" {
		cmd := exec.Command("clear")
		cmd.Stdout = os.Stdout
		cmd.Run()
	} else if runtime.GOOS == "windows" {
		cmd := exec.Command("cmd", "/c", "cls")
		cmd.Stdout = os.Stdout
		cmd.Run()
	}

}

func list_TCP_connections() []netstat.SockTabEntry {
	// List TCP sockets.  List EST conns first, then any others
	// Ignore any listeners or localhost connections

	// TODO: Dedup final array, improve the sorting

	// Use go-netstat tolist TCP connections to remote hosts
	socks, err := netstat.TCPSocks(netstat.NoopFilter)
	err_check("Failed to list TCP sockets: ", err)

	var combined_array, established_array, other_array []netstat.SockTabEntry

	for _, entry := range socks {

		// skip listening sockets
		if entry.State == netstat.Listen {
			continue
		}

		// skip localhost
		remote_addr := fmt.Sprintf("%s", entry.RemoteAddr)
		if remote_addr[0:3] == "127" {
			continue
		}

		// put address info into respective arrays
		if entry.State == netstat.Established {
			established_array = append(established_array, entry)
		} else {
			other_array = append(other_array, entry)
		}

	}

	// Combine EST and other array into final array
	for _, entry := range established_array {
		combined_array = append(combined_array, entry)
	}
	for _, entry := range other_array {
		combined_array = append(combined_array, entry)
	}

	return combined_array
}

func display_TCP_conns(key string) {
	// Get TCP conns, get geolocation and organization data on remote IPs,
	// and display to terminal

	socket_array := list_TCP_connections()

	fmt.Println("  Remote Addr\t\t    Location\t\t  Organization\t\t  Process")
	fmt.Println("---------------\t\t-----------------\t------------------\t-------------")

	// Loop through sockets, get geo and org data, and print to terminal
	for _, entry := range socket_array {

		// Get IP from socket array entry and get geolocation data
		remote_IP_port := fmt.Sprintf("%s", entry.RemoteAddr)
		remote_addr := strings.Split(remote_IP_port, ":")[0]

		json_data := geolocate_IP(key, remote_addr)

		// If city was returned, add comma between city and country code
		city := ""
		if json_data.City != "" {
			city = json_data.City + ", "
		}

		// Get country code, process name and PID
		country := json_data.Country_Code3
		process_str := fmt.Sprintf("%s", entry.Process)

		// Align text entries with tabs
		address := align_column(remote_IP_port)
		location := align_column(city + country)
		org := align_column(json_data.Organization)
		process := align_column(process_str)

		// Print everything to terminal
		fmt.Printf("%s\t%s\t%s\t%s\n", address, location, org, process)
	}

}

func main() {

	// Read ipgeolocation.io API key from local file
	dat, err := ioutil.ReadFile("key.txt")
	err_check("Failed to get API key: ", err)

	key_with_newline := string(dat)
	key := strings.TrimSuffix(key_with_newline, "\n")

	// Clear terminal and display TCP conns with geolocation data every x minutes
	refresh_interval := time.Minute * 5
	for {
		clear_terminal()
		display_TCP_conns(key)
		time.Sleep(refresh_interval)
	}
}
