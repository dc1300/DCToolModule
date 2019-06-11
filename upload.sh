#!/bin/bash

Cyan='\033[0;36m'
Default='\033[0;m'

version=""
confirmed="n"

getVersion() {
    read -p "请输入版本号: " version

    if test -z "$version"; then
        getVersion
    fi
}

getInfomation() {
getVersion

echo -e "\n${Default}================================================"
echo -e "  Version  :  ${Cyan}${version}${Default}"
echo -e "================================================\n"
}

echo -e "\n"
while [ "$confirmed" != "y" -a "$confirmed" != "Y" ]
do
if [ "$confirmed" == "n" -o "$confirmed" == "N" ]; then
getInfomation
fi
read -p "确定? (y/n):" confirmed
done

git add .
git commit -m "update to repo tag:${version}"
git tag $version
git push
git push --tags
pod repo push DCSpec DCToolModule.podspec --verbose --allow-warnings --use-libraries --use-modular-headers
say "finished"
echo "finished"
