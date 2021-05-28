#!/bin/bash

# start busybox httpd and kill it when this script terminates
trap "kill 0" EXIT
busybox httpd -vv -f -p 8081 &

while true; do
	# minify the css
	rm -f style.css style.min.css style.min.css.gz
	./minify_css.sh [0-9]*.css

	# wait for file changes
	inotifywait -e modify . 2> /dev/zero
done
