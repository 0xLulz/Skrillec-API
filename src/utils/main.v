module utils

import os

pub fn current_time() string {
	return (os.execute("date +\"%m/%d/%Y-%I:%M:%S\"").output).trim_space()
}