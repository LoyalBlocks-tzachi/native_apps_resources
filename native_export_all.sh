#!/bin/bash

export JAVA_HOME='/c/Program Files (x86)/Java/jdk1.7.0_71'
export ANT_HOME=/c/apache-ant-1.9.4
export PATH=${PATH}:${ANT_HOME}/bin

resfolder="/c/native_apps_resources"
outfolder="/c/native_apps_apks/$(date +%Y_%m_%d__%H_%M_%S)"
mkdir -p "${outfolder}/logs"

cp "${resfolder}/ant.properties" .
cp "${resfolder}/local.properties" .

${resfolder}/native_prepare_app.sh

while IFS=# read pkg appname fbid           
do 
         
echo -e "converting to package $pkg name : $appname  \n"

${resfolder}/native_convert_app.sh $pkg "$appname" $fbid

echo -e "starting build for package $pkg \n"

ant clean release -l ${outfolder}/logs/log_${pkg}.txt

echo -e "finished build for package $pkg \n"

cp "${resfolder}/out_apk/$pkg/$pkg-release.apk" ${outfolder}          
         
done < ${resfolder}/native_data.txt
 