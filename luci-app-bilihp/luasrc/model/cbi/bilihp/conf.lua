--[[
LuCI - Lua Configuration Interface
]]--
require("luci.sys")
m = Map("bilihp", translate("Bilibili Helper"), translate("The plug-in USES C2CGO,provided by the BiliHP website(https://app.bilihp.com:444/)"))

m:section(SimpleSection).template  = "bilihp/bilihp_status"

s = m:section(NamedSection, "conf","bilihp", "","")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))

id = s:option(DummyValue, "id", translate("ID"))

name = s:option(Value, "name", translate("Name"))

pass = s:option(Value, "password", translate("Password"))
pass.password = true


base_urls=s:option(DynamicList, "base_urls", translate("Repository URL"), translate("A resource site for downloading C2C.Use the primary site(https://pandorabox.tuuz.cc:444/app/) by default"))

platforms = s:option(Value, "platforms", translate("Platforms"))
platforms:value("auto", translate("auto"))
platforms:value("c2c_linux", "c2c_linux")
platforms:value("c2c_32_linux", "c2c_32_linux")
platforms:value("c2c_arm_linux", "c2c_arm_linux")
platforms:value("c2c_router_linux", "c2c_router_linux")
platforms.default = "auto"

custom=s:option(Value, "custom", translate("Custom Download"), translate("Custom Program Download URL,support HTTP/HTTPS/FTP.NOTE:Program must be available.The Settings for 'Repository URL' and 'Platforms' will become invalid if this item is used.The value default is empty.Example: https://pandorabox.tuuz.cc:444/app/c2c_router_linux"))
custom.optional = true

log = s:option(Flag, "log", translate("Enable logging"))

logsize = s:option(Value, "logsize", translate("Log Size"), translate("Specify the size in Kib,default value is 64,Maximum is 10240"))
logsize:depends("log", "1")
logsize.datatype = "and(uinteger,max(10240))"

-- local apply = luci.http.formvalue("cbi.apply")
-- if apply then
-- 	io.popen("/etc/init.d/bilihp restart")
-- end

return m