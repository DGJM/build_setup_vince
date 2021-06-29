# Copyright (C) 2021 PrajjuS, Sr. DGJM

#!/usr/bin/env bash
## Start ProjectSakura Script
## logger
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>build_log.txt 2>&1


## check if theres errors and terminates when detected
error_check () {
if [ $? -eq 0 ]; then
    echo OK
  else
	error_prompt >&3
	exit
  fi
}

error_prompt () {
echo -e "\e[0;31mBruh, Something Errored out lmao check log:P \e[0m"
read -p "Press Enter...."
exit
}

banner () {
clear
echo ""
echo "---------------------------------"
echo "Project Sakura Setup Script Vince"
echo "---------------------------------"
echo ""
}
banner >&3
## Full Build
if [[ ${1} == "--build" ]] ; then
      sleep 2
	  echo -e "\e[0;33mStarting Script.... \e[0m" >&3
      cd ../../
      sleep 1

## Sync ProjectSakura Rom Manifest
	  echo -e "\e[0;36mSyncing ProjectSakura rom manifest...\e[0m" >&3
      mkdir ProjectSakura && cd ProjectSakura
      repo init --depth=1 -u git://github.com/ProjectSakura/android.git -b 11
      repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j `nproc`
      sleep 2
	  
## Setup Device Side Repo
	  echo -e "\e[0;36mSetting up device side repo...\e[0m" >&3
      sleep 1
	  echo -e "\e[0;33mDevice Tree: \e[0m" >&3
      git clone https://github.com/PrajjuS/device_xiaomi_vince --single-branch -b sakura-11 device/xiaomi/vince
	  error_check
	  echo -e "\e[0;32mDone \e[0m" >&3
	  echo -e "\e[0;33mVendor Tree: \e[0m" >&3
      git clone https://github.com/PrajjuS/vendor_xiaomi_vince --single-branch -b sakura-11 vendor/xiaomi/vince
	  error_check
	  echo -e "\e[0;32mDone \e[0m" >&3
	  echo -e "\e[0;33mKernel Tree: \e[0m" >&3
      git clone https://github.com/Blacksuan19/kernel_dark_ages_vince.git --single-branch -b darky kernel/xiaomi/vince
	  error_check
	  echo -e "\e[0;32mDone \e[0m" >&3
      sleep 2
## Setup Hals   
	  echo ====================================
	  echo -e "\e[0;36mSetting up hals...\e[0m" >&3
      sleep 1
      rm -rf hardware/qcom-caf/msm8996
      git clone https://gitlab.com/PrajjuS/hardware_qcom_audio.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/audio
      git clone https://gitlab.com/PrajjuS/hardware_qcom_display.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/display
      git clone https://gitlab.com/PrajjuS/hardware_qcom_media.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/media
      echo -e "\e[0;32mDone \e[0m" >&3
      sleep 2

## Setup Miscellaneous Things
      echo -e "\e[0;36mSetting up miscellaneous things...\e[0m" >&3
      sleep 1
      rm -rf hardware/qcom-caf/wlan && git clone https://android.googlesource.com/platform/hardware/qcom/wlan hardware/qcom-caf/wlan
      cd kernel/xiaomi/vince && git checkout darky && git revert fec013b9f5bb70c1e51285aa6e042f21f4298447 --no-edit && cd ../../..
      echo -e "\e[0;32mDone \e[0m" >&3
      sleep 2

## Start Rom Build
      echo "Starting rom build.." >&3
      . build/envsetup.sh
	  error_check
      lunch lineage_vince-userdebug
      mka bacon
	  error_check
      sleep 2

## End Script
      banner
      echo "Finalizing...." >&3
      sleep 1
      echo "All done" >&3
      echo ""
      sleep 2
	  exit


## No Build
elif [[ ${1} == "--no-build" ]] ; then
      sleep 2
      echo "Starting Script...." >&3
      cd ../../
      sleep 1

## Sync ProjectSakura Rom Manifest
      banner
      echo -e "\e[0;36mSyncing ProjectSakura rom manifest...\e[0m" >&3
      mkdir ProjectSakura && cd ProjectSakura
      repo init --depth=1 -u git://github.com/ProjectSakura/android.git -b 11
      repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j `nproc`
      sleep 2

## Setup Device Side Repo
      banner
      echo "Setting up device side repo..." >&3
      sleep 1
      echo -e "\e[0;33mDevice Tree: \e[0m" >&3
      git clone https://github.com/PrajjuS/device_xiaomi_vince --single-branch -b sakura-11 device/xiaomi/vince
	  error_check
	  echo "Done" >&3
      echo -e "\e[0;33mVendor Tree: \e[0m" >&3
      git clone https://github.com/PrajjuS/vendor_xiaomi_vince --single-branch -b sakura-11 vendor/xiaomi/vince
	  error_check
	  echo "Done" >&3
      echo -e "\e[0;33mKernel Tree: \e[0m" >&3
      git clone https://github.com/Blacksuan19/kernel_dark_ages_vince.git --single-branch -b darky kernel/xiaomi/vince
	  error_check
      echo "Done" >&3
      sleep 2

## Setup Hals
      banner
      echo -e "\e[0;36mSetting up hals...\e[0m" >&3
      sleep 1
      rm -rf hardware/qcom-caf/msm8996
      git clone https://gitlab.com/PrajjuS/hardware_qcom_audio.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/>      git clone https://gitlab.com/PrajjuS/hardware_qcom_display.git --single-branch -b r11.0 hardware/qcom-caf/msm899>      git clone https://gitlab.com/PrajjuS/hardware_qcom_media.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/>      echo "Done"
      sleep 2

## Setup Miscellaneous Things
      banner
      echo -e "\e[0;36mSetting up miscellaneous things...\e[0m" >&3
      sleep 1
      rm -rf hardware/qcom-caf/wlan && git clone https://android.googlesource.com/platform/hardware/qcom/wlan hardware>      cd kernel/xiaomi/vince && git checkout darky && git revert fec013b9f5bb70c1e51285aa6e042f21f4298447 --no-edit &&>      echo "Done"
      sleep 2
	  
## End Script
      banner
      echo "Finalizing...."  >&3
      sleep 1
      echo "All done"  >&3
      echo ""
      sleep 2
	  exit

## Cleanup
elif [[ ${1} == "--clean" ]] ; then
      sleep 1
	  echo -e "\e[0;36mCleanup Job Started...... \e[0m" >&3
	  rm -rf ../../ProjectSakura/
	  echo -e "\e[0;32mDone \e[0m" >&3
      sleep 2
	  exit

## Help Script
elif [[ ${1} == "--help" ]] ; then
      sleep 1
      echo "Usage:" >&3
      echo "--help: to get this message" >&3
      echo "--no-build : to setup device side things only" >&3
      echo "--build : to setup device side things and start rom build" >&3
      echo "--clean : Does a Cleanup Job" >&3
      echo "" >&3

else
      sleep 1
      echo "Usage:" >&3
      echo "--help: to get this message" >&3
      echo "--no-build : to setup device side things only" >&3
      echo "--build : to setup device side things and start rom build" >&3
      echo "--clean : Does a Cleanup Job" >&3
      echo "" >&3
	  

fi
