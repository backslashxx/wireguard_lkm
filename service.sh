#!/usr/bin/env sh
MODDIR="${0%/*}"
desription="description=wireguard.ko for xx kernels"
if [ -f $MODDIR/wg_enable ]; then
	getprop ro.product.name | grep -qE 'sunny|mojito' && insmod $MODDIR/mojito/wireguard.ko
	getprop ro.product.name | grep -qE 'daisy|sakura|ysl' && insmod $MODDIR/msm8953/wireguard.ko
fi

lsmod | grep -q wireguard && desription="description=wireguard.ko | status: active ✅"
lsmod | grep -q wireguard || desription="description=wireguard.ko | status: disabled ❌"
sed -i "s/^description=.*/$desription/g" $MODDIR/module.prop
