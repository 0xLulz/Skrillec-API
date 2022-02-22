module ip_tools

import os
import net.http

// importing this same module
import ip_tools

const (
	illegal_chars = [';', '|', '`', '||', '&', '&&', ',', '$', 'IFS']
)

/*
	Geo Locator using ip-api.com API
*/
pub fn geo(ip string) string {
	data := http.get_text("http://ip-api.com/json/${ip}")
	return ip_tools.parse_geo(data)
}

/*
	Custom JSON Parser
*/
pub fn parse_geo(geo_resp string) string {
	return geo_resp.replace(",", "\r\n").replace("\"", "").replace(":", ": ").replace("{", "").replace("}", "")
}

/*
	Nmap Port Scanner using system's package
*/
pub fn port_scan(ip string) string {
	sanitized := ip_tools.sanitize(ip)
	mut nmap_resp := os.execute("nmap ${sanitized}").output
	mut new := ""
	for i, line in nmap_resp.split("\n") {
		if line.contains("open") || line.contains("close") || line.contains("filter") {
			new += "${line}\r\n"
		}
	}
	return new
}

/*
	Custom Function to sanitize commands after user inputs
*/
pub fn sanitize(input string) string {
	mut n := ""
	for i in illegal_chars {
		n = input.replace(i, "")
	}
	return n
}