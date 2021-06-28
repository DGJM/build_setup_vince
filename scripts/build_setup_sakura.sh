# Copyright (C) 2021 PrajjuS

#!/usr/bin/env bash
## Start ProjectSakura Script
banner () {
clear
echo ""
echo "---------------------------------"
echo "Project Sakura Setup Script Vince"
echo "---------------------------------"
echo ""
}
banner
## Full Build
if [[ ${1} == "--build" ]] ; then
      sleep 3
      echo "Starting Script...."
      cd ../../
      sleep 2

## Sync ProjectSakura Rom Manifest
      banner
      echo "Syncing ProjectSakura rom manifest..."
      mkdir ProjectSakura && cd ProjectSakura
      repo init --depth=1 -u git://github.com/ProjectSakura/android.git -b 11
      repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j `nproc`
      sleep 2

## Setup Device Side Repo
      banner
      echo "Setting up device side repo..."
      sleep 1
      echo "Device Tree:"
      git clone https://github.com/PrajjuS/device_xiaomi_vince --single-branch -b sakura-11 device/xiaomi/vince
      echo "Vendor Tree:"
      git clone https://github.com/PrajjuS/vendor_xiaomi_vince --single-branch -b sakura-11 vendor/xiaomi/vince
      echo "Kernel Tree:"
      git clone https://github.com/Blacksuan19/kernel_dark_ages_vince.git --single-branch -b darky kernel/xiaomi/vince
      echo "Done"
      sleep 2

## Setup Hals
      banner
      echo "Setting up hals..."
      sleep 1
      rm -rf hardware/qcom-caf/msm8996
      git clone https://gitlab.com/PrajjuS/hardware_qcom_audio.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/audio
      git clone https://gitlab.com/PrajjuS/hardware_qcom_display.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/display
      git clone https://gitlab.com/PrajjuS/hardware_qcom_media.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/media
      echo "Done"
      sleep 2

## Setup Miscellaneous Things
      banner
      echo "Setting up miscellaneous things..."
      sleep 1
      rm -rf hardware/qcom-caf/wlan && git clone https://android.googlesource.com/platform/hardware/qcom/wlan hardware/qcom-caf/wlan
      cd kernel/xiaomi/vince && git checkout darky && git revert fec013b9f5bb70c1e51285aa6e042f21f4298447 --no-edit && cd ../../..
      echo "Done"
      sleep 2

## Start Rom Build
      banner
      echo "Starting rom build.."
      . build/envsetup.sh
      lunch lineage_vince-userdebug
      mka bacon
      sleep 2

## End Script
      banner
      echo "Finalizing...."
      sleep 1
      echo "All done"
      echo ""
      sleep 2

## No Build
elif [[ ${1} == "--no-build" ]] ; then
      sleep 3
      echo "Starting Script...." 
      cd ../../
      sleep 2

## Sync ProjectSakura Rom Manifest
      banner
      echo "Syncing ProjectSakura rom manifest..."
      mkdir ProjectSakura && cd ProjectSakura
      repo init --depth=1 -u git://github.com/ProjectSakura/android.git -b 11
      repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j `nproc`
      sleep 2

## Setup Device Side Repo
      banner
      echo "Setting up device side repo..."
      sleep 1
      echo "Device Tree:"
      git clone https://github.com/PrajjuS/device_xiaomi_vince --single-branch -b sakura-11 device/xiaomi/vince
      echo "Vendor Tree:"
      git clone https://github.com/PrajjuS/vendor_xiaomi_vince --single-branch -b sakura-11 vendor/xiaomi/vince
      echo "Kernel Tree:"
      git clone https://github.com/Blacksuan19/kernel_dark_ages_vince.git --single-branch -b darky kernel/xiaomi/vince
      echo "Done"
      sleep 2

## Setup Hals
      banner
      echo "Setting up hals..."
      sleep 1
      rm -rf hardware/qcom-caf/msm8996
      git clone https://gitlab.com/PrajjuS/hardware_qcom_audio.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/>      git clone https://gitlab.com/PrajjuS/hardware_qcom_display.git --single-branch -b r11.0 hardware/qcom-caf/msm899>      git clone https://gitlab.com/PrajjuS/hardware_qcom_media.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/>      echo "Done"
      sleep 2

## Setup Miscellaneous Things
      banner
      echo "Setting up miscellaneous things..."
      sleep 1
      rm -rf hardware/qcom-caf/wlan && git clone https://android.googlesource.com/platform/hardware/qcom/wlan hardware>      cd kernel/xiaomi/vince && git checkout darky && git revert fec013b9f5bb70c1e51285aa6e042f21f4298447 --no-edit &&>      echo "Done"
      sleep 2

## End Script
      banner
      echo "Finalizing...."
      sleep 1
      echo "All done"
      echo ""
      sleep 2

## Help Script
elif [[ ${1} == "--help" ]] ; then
      sleep 1
      echo "Usage:"
      echo "--help: to get this message"
      echo "--no-build : to setup device side things only"
      echo "--build : to setup device side things and start rom build"
      echo ""

else
      sleep 1
      echo "Usage:"
      echo "--help: to get this message"
      echo "--no-build : to setup device side things only"
      echo "--build : to setup device side things and start rom build"
      echo ""
fi
