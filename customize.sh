#!/usr/bin/env sh
desription="description=wireguard.ko for xx kernels"
echo "# insmod wireguard.ko"

( getprop ro.product.name | grep -qE 'sunny|mojito' && insmod $MODPATH/mojito/wireguard.ko ) > /dev/null 2>&1 
( getprop ro.product.name | grep -qE 'daisy|sakura|ysl' && insmod $MODPATH/msm8953/wireguard.ko ) > /dev/null 2>&1 
lsmod | grep wireguard && desription="description=wireguard.ko | status: active ✅" 
sed -i "s/^description=.*/$desription/g" $MODPATH/module.prop

touch $MODPATH/wg_enable
