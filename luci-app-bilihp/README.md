luci-app-bilihp
===================
代码中只包含Lua和Bash脚本，启动后会去下载c2c_router_linux

c2c_router_linux下载地址为：
* http://pandorabox.tuuz.cc:8000/app/c2c_router_linux
* https://pandorabox.tuuz.cc:444/app/c2c_router_linux

编译需要po2lmo，如果编译时提示缺少，可以先编译`package/feeds/luci/luci-base`，或者自行编译安装po2lmo。

点击"Save&Apply"/"保存&重启"按钮会触发脚本自动重启，插件重启时会重新下载c2c_router_linux。

插件没有定时更新、定时重启功能，需要的可以在系统计划任务中自己设置，使用命令`/etc/init.d/bilihp restart`即可。
如：
```
0 2 * * * /etc/init.d/bilihp restart
```
每天2点重启bilihp
