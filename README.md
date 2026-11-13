# how to

## launch

kamu bisa jalankan melalui TTY1

```
dbus-run-session mango
```

atau melaui GDM juga bisa kok.

## jika eror:

**JANGAN lakukan ini sebagai fix permanen**

```
sudo ln -s libutf8proc.so.3 /usr/lib64/libutf8proc.so.2
```

## brightness control

Langkah 1: Bikin udev rule biar grup video bisa nulis

Ini cara yang dipakai acpilight dan brightnessctl sendiri, yaitu aturan udev yang otomatis ganti grup file brightness jadi video saat device backlight terdeteksi.

Bikin file-nya:
```Bash

sudo nano /etc/udev/rules.d/90-backlight.rules
```

Isi dengan 2 baris ini persis:
```Code

ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
```

Save dengan Ctrl+O, Enter, Ctrl+X.

Aturan ini intinya: saat backlight ditambahkan, ganti grup file brightness jadi video, lalu kasih izin tulis untuk grup.
Langkah 2: Reload udev dan tes lagi tanpa sudo
```Bash

sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=backlight --action=add
ls -l /sys/class/backlight/intel_backlight/brightness
```

Sekarang harusnya berubah jadi:
```Code

-rw-rw-r-- 1 root video ... brightness
```

Grupnya sudah video, dan ada w untuk grup. Kalau sudah begitu, tes tanpa sudo:
```Bash

brightnessctl set 50%
brightnessctl set +10%
brightnessctl set 10%-
```
Harusnya langsung jalan tanpa sudo.
