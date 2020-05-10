local fs = require "nixio.fs"

f = SimpleForm("logview")

t = f:field(TextValue, "conf")
t.rmempty = true
t.rows = 20
function t.cfgvalue()
  if fs.access("/tmp/bilihp/bilihp.log") then
    local logs = luci.util.execi("cat /tmp/bilihp/bilihp.log")
    local s = ""
    for line in logs do
      s = line .. "\n" .. s
      end
    return s
  end
end
t.readonly="readonly"

return f