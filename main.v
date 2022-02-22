import os
import vweb

import src.utils
import src.ip_tools
import src.stresser

struct App {
	vweb.Context
}

fn main() {
	mut args := (os.args).clone()
	if args.len < 1 {
		println("[x] Error, Invalid arguments\nUsage: ${args[0]} <port>")
		exit(0)
	}
	println("[+] Starting Skrillec API....!")
	vweb.run(&App{}, args[1].int())
}

pub fn (mut app App) index() vweb.Result {
	action := app.query['action']
	host := app.query['host']
	port := app.query['port']
	time := app.query['time']
	peer_addy := app.ip().replace("[::ffff:", "").replace("]:", ",").split(",")
	user_ip := peer_addy[0]
	user_port := peer_addy[1]
	println("[${utils.current_time()}] ${user_ip} | ${user_port}")
	mut geo_resp := []string
	
	match action {
		"geo" {
			println("[+] Geo Locating.... ${host}")
			geo_resp = ip_tools.geo(host).split("\n")
		}
		"portscan" {

		}
		"stresser" {

		} else {
			return app.text("[x] Invalid action.")
		}
	}
	return $vweb.html()
}

pub fn (mut app App) test() vweb.Result {
	app.text("Testing this bullshit")
	return $vweb.html()
}