@echo off
echo input devices IP..........
set /p input="ip:"
set ip=%input%
adb disconnect
adb connect %ip%
pause

echo Install CtsEmptyDeviceAdmin..............
adb install -r "\\192.168.3.11\海外运营测试专用\平台测试\Google认证套件更新\Android Q\CTS-V\android-cts-verifier-10_r5-linux_x86-arm\android-cts-verifier\CtsEmptyDeviceAdmin.apk"
pause

echo Install CtsEmptyDeviceOwner..............
adb install -t "\\192.168.3.11\海外运营测试专用\平台测试\Google认证套件更新\Android Q\CTS-V\android-cts-verifier-10_r5-linux_x86-arm\android-cts-verifier\CtsEmptyDeviceOwner.apk"
pause

echo Install CtsForceStopHelper..............
adb install -r "\\192.168.3.11\海外运营测试专用\平台测试\Google认证套件更新\Android Q\CTS-V\android-cts-verifier-10_r5-linux_x86-arm\android-cts-verifier\CtsForceStopHelper.apk
pause

echo Install CtsPermissionApp..............
adb install -r "\\192.168.3.11\海外运营测试专用\平台测试\Google认证套件更新\Android Q\CTS-V\android-cts-verifier-10_r5-linux_x86-arm\android-cts-verifier\CtsPermissionApp.apk
pause

echo Install CtsVerifier..............
adb install -r "\\192.168.3.11\海外运营测试专用\平台测试\Google认证套件更新\Android Q\CTS-V\android-cts-verifier-10_r5-linux_x86-arm\android-cts-verifier\CtsVerifier.apk
pause

echo Install CtsVerifierInstantApp..............
adb install -r "\\192.168.3.11\海外运营测试专用\平台测试\Google认证套件更新\Android Q\CTS-V\android-cts-verifier-10_r5-linux_x86-arm\android-cts-verifier\CtsVerifierInstantApp.apk
pause

echo Install CtsVerifierUSBCompanion..............
adb install -r "\\192.168.3.11\海外运营测试专用\平台测试\Google认证套件更新\Android Q\CTS-V\android-cts-verifier-10_r5-linux_x86-arm\android-cts-verifier\CtsVerifierUSBCompanion.apk
pause

echo Install CtsVpnFirewallAppApi23..............
adb install -r "\\192.168.3.11\海外运营测试专用\平台测试\Google认证套件更新\Android Q\CTS-V\android-cts-verifier-10_r5-linux_x86-arm\android-cts-verifier\CtsVpnFirewallAppApi23.apk
pause

echo Install CtsVpnFirewallAppApi24..............
adb install -r "\\192.168.3.11\海外运营测试专用\平台测试\Google认证套件更新\Android Q\CTS-V\android-cts-verifier-10_r5-linux_x86-arm\android-cts-verifier\CtsVpnFirewallAppApi24.apk
pause

echo Install CtsVpnFirewallAppNotAlwaysOn..............
adb install -r "\\192.168.3.11\海外运营测试专用\平台测试\Google认证套件更新\Android Q\CTS-V\android-cts-verifier-10_r5-linux_x86-arm\android-cts-verifier\CtsVpnFirewallAppNotAlwaysOn.apk
pause

echo Install NotificationBot..............
adb install -r "\\192.168.3.11\海外运营测试专用\平台测试\Google认证套件更新\Android Q\CTS-V\android-cts-verifier-10_r5-linux_x86-arm\android-cts-verifier\NotificationBot.apk
pause

echo Please Reboot Devices...............