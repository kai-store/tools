#!/bin/bash
#source /usr/bin/android7_env.sh

echo " ./sign_modem.sh  sign modem ; only sign 4 file"


IMG_DIR=`pwd`
product="sp9820e_2c10"
Project="$product-modem-sign"

MP="device/sprd/sharkle/sp9820e_2c10/modem_bins"

Modem_dat="$MP/ltemodem.bin"
Modem_ldsp="$MP/ltedsp.bin"
Modem_gdsp="$MP/ltegdsp.bin"
Modem_cm="$MP/pmsys.bin"

echo "IMG_DIR = $IMG_DIR"


if [ -e "$IMG_DIR/out/target/product/$product/PRODUCT_SECURE_BOOT_SPRD" ];then
			if [ -d $IMG_DIR/sps.image ];then
				rm -rfv $IMG_DIR/sps.image
			fi
			mkdir -p $IMG_DIR/sps.image/$Project
			cp $IMG_DIR/out/target/product/$product/PRODUCT_SECURE_BOOT_SPRD $IMG_DIR/sps.image/$Project
			vendor/sprd/release/IDH/SCRIPT/sign_modem_image.sh $IMG_DIR/sps.image $Project $Modem_dat $Modem_ldsp $Modem_gdsp $Modem_cm
			echo "Sign modem down"
else
	echo "Error!!! no PRODUCT_SECURE_BOOT_SPRD found"
fi


			 


 
