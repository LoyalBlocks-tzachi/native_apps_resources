
#!/bin/bash

PKG=$1
APP_NAME=$2
FB_ID=$3
# GCM_ID='828577731932'

PKG_PATH="/c/native_apps_resources/pics/${PKG}"

mkdir -p ./src/com/loyalblocks/${PKG}
mv src/com/loyalblocks/*/* src/com/loyalblocks/${PKG}
find ./src/com/loyalblocks/ -type d -empty | xargs rmdir

find ./src/ -type f | xargs sed -i  -e "s/com\.loyalblocks\.[A-Za-z]*/com\.loyalblocks\.${PKG}/g"
find ./src/ -type f | xargs sed -i  -e "s/com_loyalblocks_[A-Za-z]*/com_loyalblocks_${PKG}/g"

find ./res/ -type f | grep -v '\/drawable' | xargs sed -i  -e "s/com\.loyalblocks\.[A-Za-z]*/com\.loyalblocks\.${PKG}/g"
sed -i  -e "s/com\.loyalblocks\.[A-Za-z]*/com\.loyalblocks\.${PKG}/g" AndroidManifest.xml

sed -i  -e "s/<project name=\"[A-Za-z]*/<project name=\"${PKG}/g" build.xml
sed -i "5s|.*|out.dir=c:/native_apps_resources/out_apk/${PKG}|" ant.properties

sed -i  -e "s/\"app_name\">.*</\"app_name\">\"${APP_NAME}\"</g"  res/values/strings.xml
sed -i  -e "s/\"app_id\">.*</\"app_id\">${FB_ID}</g"  res/values/strings.xml

# sed -i  -e "s/\"gcm_sender_id\">.*</\"gcm_sender_id\">${GCM_ID}</g"  res/values/strings.xml

rm -f "res/drawable-ldpi/app_icon.png"
rm -f "res/drawable-mdpi/app_icon.png"
rm -f "res/drawable-hdpi/app_icon.png"
rm -f "res/drawable-xhdpi/app_icon.png"

cp "${PKG_PATH}/32.png" "res/drawable-ldpi/app_icon.png" 2>/dev/null
cp "${PKG_PATH}/48.png" "res/drawable-mdpi/app_icon.png" 2>/dev/null
cp "${PKG_PATH}/72.png" "res/drawable-hdpi/app_icon.png" 2>/dev/null
cp "${PKG_PATH}/96.png" "res/drawable-xhdpi/app_icon.png" 2>/dev/null
cp "${PKG_PATH}/native_splash.png" "res/drawable-xhdpi/native_splash.png" 2>/dev/null
cp "${PKG_PATH}/review_share_pic_3stars_mini.png" "res/drawable-xhdpi/review_share_pic_3stars_mini.png" 2>/dev/null
cp "${PKG_PATH}/review_share_pic_4stars_mini.png" "res/drawable-xhdpi/review_share_pic_4stars_mini.png" 2>/dev/null
cp "${PKG_PATH}/review_share_pic_5stars_mini.png" "res/drawable-xhdpi/review_share_pic_5stars_mini.png" 2>/dev/null



 