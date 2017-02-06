# git操作
echo "|=====> STARTING THE GIT ACTION <=====|"
git add .
git commit -m "[$(date +'%Y-%m-%d %H:%M:%S')][v${version}][陈超邦]"
git push origin master
echo "|=====> THE PUSH IS DONE，START ADDING THE TAG <=====|"
git tag "${version}"
git push --tags
echo "|=====> THE GIT ACTION IS DONE, TRY TRUNK PUSH NOW <=====|"
# pod trunk push
pod trunk push "${CURRENT_DIR}/BmobSDK.podspec" --allow-warnings
