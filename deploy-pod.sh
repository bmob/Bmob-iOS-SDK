# 当前脚本存储地点
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# 输出CURRENT_DIR
echo "${CURRENT_DIR}-hello"
# 更改工作目录到脚本存储地点
cd "${CURRENT_DIR}/../Bmob-iOS/Bmob_iOS_Source_New/BmobMutiSDK/BmobSDK/"
# 输入BmobSDK版本号
read -t 100 -p "INPUT THE VERSION OF THE BMOB_SDK : " version
# Sets the target folders and the final framework product.
echo "===> Start building the BmobSDK framework <==="
# 如果工程名称和Framework的Target名称不一样的话，要自定义FMKNAME
# 例如: FMK_NAME = "MyFramework",工程名
FMK_NAME='BmobSDK'
# Install dir will be the final output to the framework.
# The following line create it in the root folder of the current project.
# 存放的目录
INSTALL_DIR="${CURRENT_DIR}/${FMK_NAME}.framework"
# Working dir will be deleted after the framework creation.
# 设置生成针对模拟器的类库文件以及针对真机的类库的存放目录
WRK_DIR=build
DEVICE_DIR=${WRK_DIR}/Release-iphoneos/${FMK_NAME}.framework
SIMULATOR_DIR=${WRK_DIR}/Debug-iphonesimulator/${FMK_NAME}.framework
# -configuration ${CONFIGURATION}
# Clean and Building both architectures.
xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphoneos clean build
xcodebuild -configuration "Debug" -target "${FMK_NAME}" -sdk iphonesimulator clean build
# Cleaning the oldest.移除旧的类库文件，fi是if的结束标记
if [ -d "${INSTALL_DIR}" ]
then
rm -rf "${INSTALL_DIR}"
fi
mkdir -p "${INSTALL_DIR}"
# 这句用来作什么？合并的只是BmobSDK文件，其余文件需要先复制过去，其余文件真机和虚拟机都是一样的
cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"
# Uses the Lipo Tool to merge both binary files (i386 + armv6/armv7) into one Universal final product.
lipo -create "${DEVICE_DIR}/${FMK_NAME}" "${SIMULATOR_DIR}/${FMK_NAME}" -output "${INSTALL_DIR}/${FMK_NAME}"
# 移除 build 目录
# rm -r "${WRK_DIR}"
# 更改工作目录回脚本存储点
cd ${CURRENT_DIR}
echo ${CURRENT_DIR}
echo "===> BmobSDK framework is built, start modifing the CFBundleShortVersionString <==="
# 修改plist文件中的版本号
/usr/libexec/PlistBuddy -c "set :CFBundleShortVersionString ${version}" "${CURRENT_DIR}/BmobSDK.framework/Info.plist"
# git操作
# echo "|=====> STARTING THE GIT ACTION <=====|"
# git add .
# git commit -m "[$(date +'%Y-%m-%d %H:%M:%S')][VV][SDK${version}]"
# git push origin master
# echo "|=====> THE PUSH IS DONE，START ADDING THE TAG <=====|"
# git tag "${version}"
# git push --tags
# echo "|=====> THE GIT ACTION IS DONE, TRY TRUNK PUSH NOW <=====|"
# # pod trunk push
# pod trunk push "${CURRENT_DIR}/BmobSDK.podspec" --allow-warnings
