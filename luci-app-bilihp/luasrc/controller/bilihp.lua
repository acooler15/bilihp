module("luci.controller.bilihp", package.seeall)

function index()
	entry({"admin", "services", "bilihp"}, alias("admin", "services", "bilihp", "conf"), _("Bilibili Helper"), 100).dependent = true
	entry({"admin", "services", "bilihp", "conf"}, cbi("bilihp/conf"),_("Configure"), 10).leaf = true
	entry({"admin", "services", "bilihp", "log"},form("bilihp/log"),_("Log"), 30)
	entry({"admin", "services", "bilihp", "status"},call("act_status")).leaf=true
	end

function act_status()
	local e={}
	e.running=luci.sys.call("busybox ps -w | grep /tmp/bilihp/bilihp_router | grep -v grep | grep -v 'bilihp_monitor.sh' | grep -v 'curl' | grep -v 'wget' >/dev/null")==0
	e.timestamp=luci.sys.exec("busybox cat /tmp/bilihp/timestamp")
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
	end
