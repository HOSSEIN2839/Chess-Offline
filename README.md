# Open Chess — شطرنج آفلاین فارسی

بازی شطرنج در مرورگر، برای اجرای محلی با XAMPP و بدون حساب یا سرور آنلاین.

## حالت‌ها
- تک‌نفره در برابر موتور Stockfish
- دونفره محلی روی یک دستگاه

## امکانات
قوانین استاندارد شامل حرکت قانونی، کیش و مات، پات، قلعه، آن‌پاسان، ترفیع، ثبت حرکات، ساعت، چرخش صفحه، بازگشت و تکرار حرکت، PGN و FEN، ذخیره محلی و راهنمایی/تحلیل Stockfish.

## اجرا با XAMPP
1. دانلود ZIP یا Clone این مخزن.
2. پوشه پروژه را در `C:\xampp\htdocs\Open-Chess` قرار بده.
3. وابستگی‌های بخش بعد را در پوشه `vendor` آماده کن.
4. Apache را روشن و `http://localhost/Open-Chess/` را باز کن.

## آماده‌سازی وابستگی‌ها (یک‌بار)
از chess.js برای قوانین شطرنج و Stockfish WebAssembly برای بازی هوشمند استفاده می‌شود. برای اجرای کاملاً آفلاین، فایل‌ها باید در مخزن/پوشه محلی قرار بگیرند:
- `vendor/chess.js` — نسخه ESM کتابخانه chess.js
- `vendor/stockfish.js` — loader موتور Stockfish Lite single-thread
- فایل WASM متناظر که loader درخواست می‌کند (اسکریپت نصب به‌طور پیش‌فرض Stockfish Full single-thread حدود 94MB را می‌گیرد؛ نسخه Lite حدود 1.7MB است اما ضعیف‌تر)

اگر Node.js/npm نصب است، PowerShell را در ریشه پروژه باز و اجرا کن:
```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\setup-dependencies.ps1
```
اگر npm در PowerShell مسدود است، فایل‌های رسمی پکیج‌ها را با مرورگر دریافت و در مسیرهای vendor قرار بده؛ دستور بالا نیازمند دسترسی npm در زمان نصب است.

## نکته‌ها
- از `file://` اجرا نکن؛ برای ES Modules و Worker از localhost استفاده کن.
- قدرت موتور به CPU و عمق جست‌وجو بستگی دارد.
- chess.js تحت BSD-2-Clause و Stockfish تحت GPL-3.0 است؛ هنگام انتشار، شرایط مجوزها را رعایت کن.
