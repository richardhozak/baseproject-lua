#!/usr/bin/env sh

#set -o xtrace
## TODO create makefile

objs=""

for line in $(find . -type f -name \*.lua -printf "%P\n"); do
	#echo "Processing $line"
	module="$(dirname "$line" | tr / .)" # get module name by replacing folder separators by dot
	name="$(basename $line)" # get filename
	name=${name%.*} # remove extension from filename

	out="$line.o"
	objs="$objs $out"
	params=""

	if [ "$module" = "." ]; then
		module=$name
	else
		module="$module.$name"
	fi

	echo $module
	luajit -b -n $module $line $out
done

ar rcus build/libmyluafiles.a $objs

gcc -O2 -Wall -Wl,-E init.c -I/usr/local/include/luajit-2.0/ -lluajit-5.1 -Wl,--whole-archive -Lbuild -lappfiles -Wl,--no-whole-archive -Wl,-E -o build/app
