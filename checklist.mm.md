# osep
## office钓鱼
### word钓鱼
- 下载exe执行
- VBA Shellcode Loader
- VBA powershell runner
- VBA powershell runner encrypt（reverse xor sleep 拼接）
- 在内存中执行

### HTA钓鱼（js）

## bypass
- bypass asmi 
- bypass applocker (lolbas)
- bypass defender
- bypass clm
- obf execute
- 内存加载执行exe ps1
- 流量隐藏 （端口 useragent ）
- 关闭WD Set-MpPreference -DisableRealtimeMonitoring $true

## opsec
- msf 证书修改
- msf 添加set EnableStageEncoding true  set StageEncoder x64/zutto_dekiru 
- set EXITFUNC thread ;set AutoRunScript 'migrate -n explorer.exe'
- 域前置 ?? osep考试会用到？ 教材9.6.2 Empire

## 进程注入

## 投毒
- responder -I tun0 -A 
- Inveigh.exe Inveigh.ps1
- mitmdump

## 域枚举
- cme RID枚举域用户
- 匿名登录获取域用户
- Password Spray 密码喷洒
- 密码复用
- Kerberoast && ASREPRoast
- 用户名密码交叉爆破 （./username-anarchy -i user2.txt >user3.txt james.roberts）kerbrute_linux_amd64
- bloodhound && powerview && cme

## 提权


### windows
- WinPeas
- AdPeas
- PrivescCheck
- 敏感信息 LaZagne.exe Seatbelt.exe
- creds find (LAPS密码 )
- whoami /priv
- service to system (potato)
- Incognito 模拟令牌
### potato
- juicy potato (webshell ng)
- sweet potato
- rogue potato
- GodPotato-NET4.exe

### linux
- suid (find / -perm -u=s -type f 2>/dev/null) gtfobins
- sudo sudo版本提权
- pwnkit pkexec
- pspy64
- linpeas
- ubuntu cve-2023-32629
- gpg

## 横向
- psexec service
- wmiexec wmi 135
- SCShell
- PowerShell-Remoting
- evil-winrm
- atexec.py Scheduled-Tasks
- smbexec.py
- dcomexec.py dcom服务
- 机器账户hash登录，默认情况下，机器账户是不允许登录机器的，我们可以用
1.rbcd来获取票据，然后登录机器
2.Shadow Credentials （前提需要adcs服务）

## 域渗透

### 委派

- 非约束委派 （需要提前配置 rubeus.exe Rubeus.exe monitor /interval:5 /filteruser:DC03$）

- 约束委派 
1.只允许kerberos - Without protocol transition -详情可见HTB-Rebound
2.允许任何协议 约束委派 
直接用getST.py 模仿一个用户就行了

- S4U2self s4u2self- + -u2u 加上u2u协议可以用户对用户
 用户账户默认情况下没有 SPN
- [whoami u2u](https://whoamianony.top/posts/privilege-escalation-exploiting-rbcd-using-a-user-account/)

- rbcd



### 中继
- 
### DACL
- GenericAll 可以修改用户密码
- 组内权限 当你修改一个组的dacl权限时候，你需要添加继承权限，不然位于组内的用户还是不能继承组的权限

## 隧道
- ligolo-ng
- chisel
- ssh tunnel
- socat netsh
- frp nps

## mssql
- 模仿

## 集群管理工具
- docker
- k8s
- ansible
- 虚拟桌面 Citrix virtual desktop (Kiosk)
## 云
- aws
- Azure


## 主机枚举

## mssql
- xp_dirtree unc路径获取ntlm hash
- mssql-linked-servers 链接数据库
- mssql-file-read 
- 模仿用户 模仿sa用户 模仿其他用户（EXEC AS login= N'daedalus_admin'  EXECUTE AS LOGIN = 'sa'） 详情 HTB-Endgames-Ascension
- 使用python 等语言 getshell 
- EXEC sp_execute_external_script @language = N'Python', @script = N'import os; os.system("netstat -ano");';
- xp_cmdshell 被禁用 disable trigger ALERT_xp_cmdshell on all server
- clr 执行命令
- sp_OACreate sp_OAMethod  执行命令 （以上需要sysadmin权限，如果没有可以模仿 ）
- 如果密码不对，试试 -windows-auth
- mssql proxy 开启代理，需要下载dll htb-pivotapi