gcc -O2 -Wall -Wl,-E -o app init.c -I/usr/local/include/luajit-2.0/ -lluajit-5.1 -Wl,--whole-archive -Lmyluafiles -Wl,--no-whole-archive -Wl,-E