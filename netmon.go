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
	"sort"
	"strconv"
	"strings"
	"time"

	"github.com/cakturk/go-netstat/netstat"
)

func err_check(message string, e error) int {
	// Print error message and die
	if e != nil {
		log.Fatalln(message, e)
		return 1
	}
	return 0
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

// Type used for sorting
type socket_list []netstat.SockTabEntry

// Define funcs for sorting
func (l socket_list) Len() int {
	return len(l)
}

func (l socket_list) Swap(i, j int) {
	l[i], l[j] = l[j], l[i]
}

func (l socket_list) Less(i, j int) bool {
	// Sort by first quad of IP address
	// Could also sort by location, org, process, etc
	i_addr_string := fmt.Sprintf("%s", l[i].RemoteAddr)
	j_addr_string := fmt.Sprintf("%s", l[j].RemoteAddr)
	i_quad1_str := strings.Split(i_addr_string, ".")[0]
	j_quad1_str := strings.Split(j_addr_string, ".")[0]
	i_quad1_num, err := strconv.Atoi(i_quad1_str)
	err_check("Failed parsing IP string", err)
	j_quad1_num, err := strconv.Atoi(j_quad1_str)
	err_check("Failed parsing IP string", err)
	return i_quad1_num < j_quad1_num
}

func geolocate_IP(key string, address string, cached_addrs *map[string]IP_Response, queries *int) IP_Response {
	// Query ipgeolocate.io to get geolocation and organization information for address
	// Will check cached_addrs array to make sure address has not been queried recently
	// Increments queries val to keep track of total queries for this run

	// Check if IP is private, if yes mark as localnet
	if address[0:7] == "192.168" || address[0:6] == "172.16" || address[0:3] == "10." {
		return IP_Response{address, "", "LAN", "LAN"}
	}

	// Check if IP has been queried previously. If so, return cached geo/org data
	t := *cached_addrs
	val, present := t[address]
	if present {
		return val
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

	// Add IP data to cached addrs array
	t = *cached_addrs
	t[address] = json_data
	*queries = *queries + 1
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
	// List TCP sockets
	// Ignore any listeners or localhost connections

	// Use go-netstat tolist TCP connections to remote hosts
	socks, err := netstat.TCPSocks(netstat.NoopFilter)
	err_check("Failed to list TCP sockets: ", err)

	var sock_array []netstat.SockTabEntry

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

		sock_array = append(sock_array, entry)
	}

	// Cast as socket_list to sort
	f := socket_list(sock_array)
	sort.Sort(f)

	return sock_array
}

func display_TCP_conns(key string, cached_addrs *map[string]IP_Response, queries *int) {
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
		json_data := geolocate_IP(key, remote_addr, cached_addrs, queries)

		// If city was returned, add comma between city and country code
		city := ""
		if json_data.City != "" {
			city = json_data.City + ", "
		}

		// Get country code, process name and PID
		country := json_data.Country_Code3
		process_str := fmt.Sprintf("%s", entry.Process)
		if process_str == "<nil>" {
			// Not established, print state instead of process info
			state_str := fmt.Sprintf("N/A (State: %s)", entry.State)
			process_str = state_str
		}

		// Align text entries with tabs
		address := align_column(remote_IP_port)
		location := align_column(city + country)
		org := align_column(json_data.Organization)
		//process := align_column(process_str)

		// Print everything to terminal
		fmt.Printf("%s\t%s\t%s\t%s\n", address, location, org, process_str)
	}

}

func main() {
	// Read ipgeolocation.io API key from local file
	dat, err := ioutil.ReadFile("key.txt")
	err_check("Failed to get API key: ", err)

	key_with_newline := string(dat)
	key := strings.TrimSuffix(key_with_newline, "\n")

	// Keep track of total queries for each run
	queries := 0

	// Cached addresses.  Do not query for IP if it's been queried in the last query_interval mins
	cached_addrs := make(map[string]IP_Response)
	query_interval := time.Minute * 30

	// Clear terminal and display TCP conns with geolocation data every refresh_interval minutes
	refresh_interval := time.Second * 15

	rounds := int(query_interval / refresh_interval)

	i := 0
	for {
		clear_terminal()
		display_TCP_conns(key, &cached_addrs, &queries)
		fmt.Println("Queries for this run: ", queries)
		time.Sleep(refresh_interval)
		if i == rounds {
			cached_addrs = make(map[string]IP_Response)
			i = 0
		} else {
			i = i + 1
		}

	}
}
