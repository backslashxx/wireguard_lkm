#!/usr/bin/env sh
MODDIR="${0%/*}"
desription="description=wireguard.ko for xx kernels"
if [ -f $MODDIR/wg_enable ]; then
	rmmod wireguard > /dev/null 2>&1 && desription="description=wireguard.ko | status: disabled ❌" && echo "[+] module unloaded!" 
	rm $MODDIR/wg_enable > /dev/null 2>&1
else
	getprop ro.product.name | grep -qE 'sunny|mojito' > /dev/null 2>&1 && insmod $MODDIR/mojito/wireguard.ko && echo "[+] module loaded!"
	getprop ro.product.name | grep -qE 'daisy|sakura|ysl' > /dev/null 2>&1 && insmod $MODDIR/msm8953/wireguard.ko && echo "[+] module loaded!"
	touch $MODDIR/wg_enable
fi

lsmod | grep -q wireguard && desription="description=wireguard.ko | status: active ✅"
sed -i "s/^description=.*/$desription/g" $MODDIR/module.prop

sleep 3
