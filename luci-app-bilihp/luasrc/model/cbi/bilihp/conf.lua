--[[
LuCI - Lua Configuration Interface
]]--
require("luci.sys")
m = Map("bilihp", translate("Bilibili Helper"), translate("website: https://app.bilihp.com:444/"))

m:section(SimpleSection).template  = "bilihp/bilihp_status"

s = m:section(NamedSection, "conf","bilihp", "","")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))

id = s:option(DummyValue, "id", translate("ID"))

name = s:option(Value, "name", translate("Name"))

pass = s:option(Value, "password", translate("Password"))
pass.password = true

platforms = s:option(Value, "platforms", translate("Platforms"))
platforms:value("auto", translate("auto"))
platforms:value("c2c_linux", "c2c_linux")
platforms:value("c2c_32_linux", "c2c_32_linux")
platforms:value("c2c_arm_linux", "c2c_arm_linux")
platforms:value("c2c_router_linux", "c2c_router_linux")
platforms.default = "auto"

log = s:option(Flag, "log", translate("Enable logging"))

logsize = s:option(Value, "logsize", translate("Log Size"),translate("Specify the size in Kib,default value is 64,Maximum is 10240"))
logsize:depends("log", "1")
logsize.datatype = "and(uinteger,max(10240))"

local apply = luci.http.formvalue("cbi.apply")
if apply then
	io.popen("/etc/init.d/bilihp restart")
end

return m