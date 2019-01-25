#!/bin/bash
#source /usr/bin/android7_env.sh

echo " ./update.sh 	  (new)   	  make userdebug version, First time with new param"
echo " ./update.sh user  (new)    make user version, First time with new param"



export PATH=/usr/local/bin/Kaios:$PATH
#export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
#export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:/usr/local/bin/Kaios:$PATH
#export CLASSPATH=$CLASSPATH:.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

type=$1
is_new=$2

BPATH=`pwd`
BPATH2=${BPATH%/build/*}
echo $BPATH2

build_type="userdebug"
#echo "$type    is_new=$is_new 123"

if [ -n "$type" ] && [ -n "$is_new" ];then
	if [ "$type" = "user" ];then
	  build_type="user"
	fi
	#echo " 1111111"
elif [ -n "$type" ];then
 	if [ "$type" = "user" ];then
	     build_type="user"
	elif [ "$type" = "userdebug" ];then
		 build_type="userdebug"
	elif [ "$type" = "new" ];then
		is_new=$type
	elif [ "$type" = "env" ];then
		echo "set Java env"
		java -version
		exit 0
	else
		echo "****************bad param"
		read
	fi
	#echo "2222222222222"
	
else
    echo ""
fi

if [ "$build_type" = "userdebug" ];then
	`cp -f $BPATH2/gaia/build/config/common-settings.json.debug $BPATH2/gaia/build/config/common-settings.json`
else
	`cp -f $BPATH2/gaia/build/config/common-settings.json.user $BPATH2/gaia/build/config/common-settings.json`
fi

#	platform="sp9820e_13c10_k_native"
#	ZIP_NAME="proprietories-sp9820e_13c10_k_native"
	
	platform="sp9820e_2c10_k_native"
	ZIP_NAME="proprietories-sp9820e_2c10_k_native"
#	build_type="userdebug"
	
 
	
	echo "build type is: $build_type"
	java -version
	
    env

    source build/envsetup.sh
    choosecombo release ${platform} ${build_type}
	
    if [ -n "$is_new" ] && [ "$is_new" = "new" ]; then
        echo "unzip _proprietories files & update api"
        unzip -o device/sprd/proprietories/${ZIP_NAME}-${build_type}.zip 2>/dev/null
		make -j6 update-api 
    fi
	
    kheader

       echo "+++++++++++++++++++++++++++++ start to make"
       #make update-api 2>&1 | tee build_update_api.log
       make -j6 2>&1 | tee new.log
	   #make buildsymbols 2>&1 | tee make-symbols.log
	 #  make otapackage -j4 2>&1 | tee ota.log

#./mk_aliphone.sh $build_type $is_new 2>&1 | tee new.log


 
