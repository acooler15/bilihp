module("luci.controller.bilihp", package.seeall)

function index()
	entry({"admin", "services", "bilihp"}, alias("admin", "services", "bilihp", "conf"), _("Bilibili Helper"), 100).dependent = true
	entry({"admin", "services", "bilihp", "conf"}, cbi("bilihp/conf"),_("Configure"), 10).leaf = true
	entry({"admin", "services", "bilihp", "log"},form("bilihp/log"),_("Log"), 30)
	entry({"admin", "services", "bilihp", "status"},call("act_status")).leaf=true
	end

function act_status()
	local e={}
	local running=luci.sys.call("busybox ps -w | grep /tmp/bilihp/bilihp_router | grep -v grep | grep -v 'bilihp_monitor.sh' | grep -v 'curl' | grep -v 'wget' >/dev/null")==0;
	if(running)
	then
		e.status=1
	elseif(luci.sys.call("ls /tmp/bilihp/downerr >/dev/null 2>&1")==0)
	then
		e.status=-1
	else
		e.status=0
	end
	-- e.status=luci.sys.call("busybox ps -w | grep /tmp/bilihp/bilihp_router | grep -v grep | grep -v 'bilihp_monitor.sh' | grep -v 'curl' | grep -v 'wget' >/dev/null")==0
	e.timestamp=luci.sys.exec("busybox cat /tmp/bilihp/timestamp")
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
	end
