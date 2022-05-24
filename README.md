# Teamspeak Server for OpenwWRT

该库旨在集成teamsepak服务端到openwrt x86或x64架构中，由于teamspeak官方闭源的原因，不支持其他架构的linux（例如arm和rampis）。

This repository is an unofficial package for run ts3server on openwrt which base on x86 or x86_64.

Due to TeamSpeak official. Up to now, this repository cannot support other architecture.

## Build

将以下代码添加到 `feeds.conf.default` 中

Add this line into your `feeds.conf.default`

```
src-git ts3server https://github.com/catsimple/openwrt_ts3server
```

同时，为了满足teamspeak的运行环境，你还需要在编译openwrt固件时，将默认的`musl-libc`替换为`glibc`，这将会大大增加固件的体积，所以请确保你的根文件系统分区具有至少200MB的空间。

For satisfying teamspeak running enviroment, you must replace the default `musl-libc` with `glibc` while buliding openwrt, which will greatly increase the size of the openwrt firmware. Ensuring your Root filesystem partition size is more than 300 MB .

```
make menuconfig
Adcanced configuration options(for devlopers)[*]
Adcanced configuration options(for devlopers)-->Toolchain Options[*]
Adcanced configuration options(for devlopers)-->Toolchain Options-->C Libary implementation-->Use glibc[*]
Adcanced configuration options(for devlopers)-->Toolchain Options-->binutils version-->binutils 2.38[*]
Adcanced configuration options(for devlopers)-->Toolchain Options-->GCC compiler Version-->gcc 11.x[*]
Development-->gcc[*]
Development-->gcc-->Libraries-->Include static libc on target[*]
Development-->gcc-->Libraries-->include static libptread on target[*]
Development-->gcc-->Libraries-->include static libstdc++ on target[*]
Global build settings-->Compile with full langeuage support[*]
Global build settings-->preferred standard C++ library-->libstdc++[*]
```

## Usage
运行teamspeak3 server

初次运行，需要在终端中执行以下命令以接受ts3的使用条款
```
> /usr/bin/ts3server/.ts3server_license_accepted
```

服务已经注册到service中，可以使用`service ts3server start`或`/etc/init.d/ts3server`来启动

你也可以使用`service ts3server status`来检查ts3服务端的运行情况

## Contribution 
https://github.com/senayuki/openwrt_ts3server
