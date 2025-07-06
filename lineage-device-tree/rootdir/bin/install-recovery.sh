#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):80740352:fecb9c0f3de1d139fb9c6d9d73f50705c026e797; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):33554432:2c6ad9f89f687af089c487e024466b1af3a36679 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):80740352:fecb9c0f3de1d139fb9c6d9d73f50705c026e797 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

