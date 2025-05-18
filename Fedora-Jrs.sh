#!/bin/bash

# التأكد من تشغيل السكربت بصلاحيات root
if [ "$EUID" -ne 0 ]; then
  echo "يرجى تشغيل السكربت باستخدام: sudo ./Fedora-Jrs.sh"
  exit
fi

# حفظ السجل الكامل للتنفيذ
exec > >(tee -a ~/post-install-log.txt) 2>&1

# بدء توقيت السكربت
START_TIME=$(date +%s)

echo ">> التحقق من بيئة الإقلاع (UEFI)"

# التحقق من وجود قسم EFI
if ! grep -q /boot/efi /proc/mounts; then
  echo "تحذير: قسم EFI غير مثبت. تأكد أنك على نظام UEFI."
  echo "تحذير: قسم EFI غير مثبت. تأكد أنك على نظام UEFI." >> ~/install-summary.txt
  echo -e "\033[1;31m[✗] فشل في تنفيذ هذه المرحلة\033[0m"
exit 1
fi

# التحقق من أن النظام يعمل بوضع UEFI
if [ ! -d /sys/firmware/efi ]; then
  echo "يبدو أن هذا النظام لا يعمل بوضع UEFI. سيتم إيقاف السكربت."
  echo -e "\033[1;31m[✗] فشل في تنفيذ هذه المرحلة\033[0m"
exit 1
fi

# التحقق من الاتصال بالإنترنت
echo ">> التحقق من الاتصال بالإنترنت..."
ping -q -c 1 1.1.1.1 > /dev/null
if [ $? -ne 0 ]; then
  echo "لا يوجد اتصال بالإنترنت. الرجاء التحقق قبل المتابعة."
  echo -e "\033[1;31m[✗] فشل في تنفيذ هذه المرحلة\033[0m"
exit 1
fi


echo "----------------------------------------"
echo -e "\n\033[1;34m[●] جاري تحديث النظام...\033[0m"
dnf upgrade --refresh -y
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"



echo "----------------------------------------"
echo -e "\n\033[1;34m[●] تفعيل مستودعات RPM Fusion...\033[0m"
dnf install -y \
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"

echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"

  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo ">> إعداد قائمة الحزم الثابتة"
basic_packages="git curl htop unzip wget chromium vlc"

echo ">> تحميل قائمة الحزم المتغيرة من GitHub..."
GITHUB_USER="YOUR_USERNAME"
GITHUB_REPO="Fedora-Jrs"
GITHUB_BRANCH="main"
curl -s https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO/$GITHUB_BRANCH/packages.txt -o /tmp/packages.txt

if [ -s /tmp/packages.txt ]; then
  extra_packages=$(cat /tmp/packages.txt)
  echo ">> الحزم المتغيرة:"
  echo "$extra_packages"
else
  echo ">> لم يتم العثور على حزم إضافية أو الملف فارغ."
  extra_packages=""
fi


read -p "هل تريد تثبيت الحزم الأساسية + الإضافية؟ (y/n): " install_pkgs
if [[ "$install_pkgs" == "y" ]]; then

  echo ">> تثبيت الحزم كاملة"
all_packages="$basic_packages $extra_packages"
echo ">> تثبيت الحزم: $all_packages"
  dnf install -y $all_packages || { echo "فشل تثبيت بعض الحزم"; echo -e "\033[1;31m[✗] فشل في تنفيذ هذه المرحلة\033[0m"
exit 1; }
fi


  echo -e "
[1;34m[●][0m جاري تثبيت البرامج الأساسية..."
dnf install -y \
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"

echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"

  vlc gparted htop git wget curl unzip p7zip p7zip-plugins \
  gnome-disk-utility filelight fastfetch zram-generator-defaults \
  lm_sensors preload flatpak chromium bleachbit timeshift plasma-discover-flatpak


echo "----------------------------------------"
echo -e "\n\033[1;34m[●] تفعيل preload...\033[0m"
systemctl enable --now preload
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"



echo "----------------------------------------"
echo -e "\n\033[1;34m[●] تفعيل Flatpak و Flathub...\033[0m"
flatpak remote-add --if-not-exists flathub
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"
 https://flathub.org/repo/flathub.flatpakrepo
flatpak update -y
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"



echo "----------------------------------------"
echo -e "\n\033[1;34m[●] تثبيت تطبيقات Flatpak...\033[0m"
flatpak install flathub com.obsproject.Studio -y
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"

flatpak install flathub com.discordapp.Discord -y
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"

flatpak install flathub org.telegram.desktop -y
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"



echo "----------------------------------------"
echo -e "\n\033[1;34m[●] تثبيت كودكس الوسائط...\033[0m"
dnf install -y \
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"

echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"

  gstreamer1-plugins-base \
  gstreamer1-plugins-good \
  gstreamer1-plugins-good-extras \
  gstreamer1-plugins-bad-free \
  gstreamer1-plugins-ugly \
  gstreamer1-plugins-bad-freeworld \
  gstreamer1-libav \
  lame \
  ffmpeg \
  --skip-broken


echo "----------------------------------------"
echo -e "\n\033[1;34m[●] إعداد حساس الحرارة...\033[0m"
sensors-detect --auto
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"



echo "----------------------------------------"
echo -e "\n\033[1;34m[●] تعطيل الخدمات غير الضرورية...\033[0m"
systemctl disable --now bluetooth.service
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"
 cups.service ModemManager.service avahi-daemon.service \
  abrtd.service abrt-oops.service abrt-vmcore.service abrt-xorg.service
systemctl mask cups.socket cups.path avahi-daemon.socket ModemManager.service


echo "----------------------------------------"
echo -e "\n\033[1;34m[●] تعطيل انتظار الشبكة...\033[0m"
systemctl disable NetworkManager-wait-online.service
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"



echo "----------------------------------------"
echo -e "\n\033[1;34m[●] تعديل إعدادات GRUB...\033[0m"
sed -i 's/^GRUB_TIMEOUT=.*
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"
/GRUB_TIMEOUT=2/' /etc/default/grub
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"



echo "----------------------------------------"
echo -e "\n\033[1;34m[●] حذف الحزم غير الضرورية...\033[0m"
dnf remove -y \
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"

  cheese gnome-contacts evolution gnome-tour abrt* \
  bluetooth cups ModemManager avahi


echo "----------------------------------------"
echo -e "\n\033[1;34m[●] تنظيف النظام...\033[0m"
dnf autoremove -y
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"

dnf clean all
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"



echo "----------------------------------------"
echo -e "\n\033[1;34m[●] حذف عناصر autostart...\033[0m"
AUTOSTART_DIR="/home/$SUDO_USER/.config/autostart"
if [ -d "$AUTOSTART_DIR" ]; then
  rm -f "$AUTOSTART_DIR"
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"
/discord.desktop
  rm -f "$AUTOSTART_DIR"
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"
/org.telegram.desktop.desktop
  rm -f "$AUTOSTART_DIR"
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"
/com.obsproject.Studio.desktop
fi


# إنشاء تقرير التثبيت النهائي

echo "----------------------------------------"
echo -e "\n\033[1;34m[●] إنشاء تقرير التثبيت...\033[0m"

summary_file=~/install-summary.txt
echo " - التقرير النهائي لتثبيت البرامج ($(date))" > $summary_file
echo "الحزم التي تم تثبيتها عبر DNF:" >> $summary_file

for pkg in $all_packages; do
  if rpm -q "$pkg" &>/dev/null; then
    echo "$pkg: تم التثبيت" >> $summary_file
  else
    echo "$pkg: لم يتم التثبيت" >> $summary_file
  fi
done

echo "" >> $summary_file
echo "الحزم التي تم تثبيتها عبر Flatpak:" >> $summary_file

flatpak_apps=("com.obsproject.Studio" "com.discordapp.Discord" "org.telegram.desktop")

for app in "${flatpak_apps[@]}"; do
  if flatpak list --app | grep -q "$app"; then
    echo "$app: تم التثبيت" >> $summary_file
  else
    echo "$app: لم يتم التثبيت" >> $summary_file
  fi
done



echo "" >> $summary_file
if [ -f ~/post-install-log.txt ]; then
  echo "- تم عرض سجل التنفيذ ثم حذفه من ~/post-install-log.txt" >> $summary_file
else
  echo "- لم يتم العثور على سجل تنفيذ عند التحقق." >> $summary_file
fi



# إنشاء تقرير التثبيت النهائي
echo ">> إنشاء تقرير التثبيت..."

summary_file=~/install-summary.txt
echo " - التقرير النهائي لتثبيت البرامج ($(date))" > $summary_file
echo "الحزم التي تم تثبيتها عبر DNF:" >> $summary_file

for pkg in $all_packages; do
  if rpm -q "$pkg" &>/dev/null; then
    echo "$pkg: ✓" >> $summary_file
  else
    echo "$pkg: ✗" >> $summary_file
  fi
done

echo "" >> $summary_file
echo "الحزم التي تم تثبيتها عبر Flatpak:" >> $summary_file
flatpak_apps=("com.obsproject.Studio" "com.discordapp.Discord" "org.telegram.desktop")

for app in "${flatpak_apps[@]}"; do
  if flatpak list --app | grep -q "$app"; then
    echo "$app: ✓" >> $summary_file
  else
    echo "$app: ✗" >> $summary_file
  fi
done

echo "" >> $summary_file
echo "----------------------------------------" >> $summary_file
if [ -f ~/post-install-log.txt ]; then
  echo "- تم عرض سجل التنفيذ ثم حذفه من ~/post-install-log.txt" >> $summary_file
else
  echo "- لم يتم العثور على سجل تنفيذ عند التحقق." >> $summary_file
fi


# عرض الوقت المستغرق
END_TIME=$(date +%s)
echo ">> الوقت المستغرق: $((END_TIME - START_TIME)) ثانية"

# إشعار صوتي ونهاية
echo -e "\a"

# عرض سجل التنفيذ إن وجد

echo "----------------------------------------"
echo -e "\n\033[1;34m[●] عرض سجل التنفيذ...\033[0m"
if [ -f ~/post-install-log.txt ]; then
  less ~/post-install-log.txt
echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"

else
  echo "لا يوجد سجل تنفيذ لعرضه."
fi


echo -e "\033[1;32m[✓] تم التنفيذ بنجاح\033[0m"
 && echo "تم حذف سجل التنفيذ."



# إعادة التشغيل (اختياري)
echo -e "\n\033[1;34m[●]\033[0m هل ترغب في إعادة التشغيل الآن؟ [y/n]"
read -rp "اختيارك: " reboot_choice
if [[ "$reboot_choice" =~ ^[Yy]$ ]]; then
  echo -e "\033[1;32m[✓] سيتم الآن إعادة تشغيل النظام...\033[0m"
  reboot
fi


echo ">> تمت جميع العمليات، النظام جاهز!"
