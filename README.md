# Fedora-Jrs

    سكربت بعد تثبيت Fedora يقوم بتجهيز النظام تلقائيًا: تثبيت الحزم الأساسية، تحسين الأداء، تفعيل المستودعات، وتنظيف النظام.

    Post-install script for Fedora that automates system setup: installs essential packages, optimizes performance, enables repositories, and removes bloat.
---

## الملفات

- `Fedora-Jrs.sh` — السكربت الأساسي.
- `packages.txt` — قائمة الحزم الإضافية التي يتم تحميلها من GitHub وتثبيتها.

---

## طريقة التشغيل

1. افتح التيرمنال داخل مجلد السكربت.
2. نفّذ الأمر التالي:
```bash
chmod +x Fedora-Jrs.sh
sudo ./Fedora-Jrs.sh
```

> **ملاحظة**: تأكد من أنك على نظام UEFI، ومتصل بالإنترنت، وتشغل السكربت باستخدام `sudo`.

---

## الميزات:

- التثبيت التفاعلي للحزم (يسألك عن كل وحدة).
- تثبيت تطبيقات Flatpak الشائعة (OBS, Discord, Telegram).
- تفعيل المستودعات الرسمية و RPM Fusion.
- تحسين الأداء (Preload, ZRAM, حذف الخدمات الغير ضرورية).
- توليد تقرير مفصّل بالحزم المثبتة.
- تسجيل تنفيذ السكربت في ملف `post-install-log.txt`.
- إمكانية إعادة تشغيل النظام في النهاية.

---

## تخصيص الحزم

إذا رغبت بإضافة حزم خاصة بك، يمكنك تعديل ملف `packages.txt` الموجود في المستودع، وستُثبّت تلقائيًا عند تشغيل السكربت.
