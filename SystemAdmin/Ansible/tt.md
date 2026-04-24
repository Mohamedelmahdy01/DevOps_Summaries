1. المقدمة والأساسيات (Introduction)
ما هو Ansible؟ (Architecture & Agentless concept)

مميزات الأداة (Idempotency & Declarative Language).

إعداد بيئة المعمل (Lab Setup: Control Node & Managed Nodes).

2. إدارة المخزون والاتصال (Inventory & Connectivity)
إعداد ملف الـ Inventory (INI vs YAML).

التعامل مع الـ SSH والـ Fingerprints.

اختبار الاتصال باستخدام الـ Ping Module.

3. التنفيذ المباشر والـ Playbooks
الأوامر المباشرة (Ad-hoc Commands).

بنية الـ Playbook وكتابة الـ YAML.

إدارة المهام (Tasks) وترتيب التنفيذ.

4. المحركات والوظائف (Ansible Modules)
Modules النظام (User, Service, Package).

Modules الملفات (Copy, Lineinfile, File).

Modules الأوامر والسكربتات (Command, Shell, Script).

5. المتغيرات والبيانات الحساسة (Variables & Secrets)
تعريف المتغيرات ومستويات الأولوية (Precedence).

استخدام الـ Facts (Dynamic System Info).

تأمين البيانات باستخدام Ansible Vault.

6. التحكم في سير العمل (Flow Control)
المشروطات (Conditionals: when statement).

الحلقات التكرارية (Loops: loop & with_items).

المعالجات (Handlers: notify).

7. القوالب المتقدمة (Templating)
محرك Jinja2 وكتابة القوالب الديناميكية.

استخدام الـ Filters لمعالجة البيانات.

8. تنظيم الكود (Ansible Roles)
هيكلية الـ Role (Tasks, Vars, Defaults, Templates).

إعادة استخدام الكود والموديلاريتي.

التعامل مع Ansible Galaxy.

9. إدارة الأخطاء والعمليات المتقدمة (Advanced Features)
Asynchronous Actions: التعامل مع المهام الطويلة في الخلفية.

Strategy: التحكم في سرعة وشكل التنفيذ على السيرفرات (free, linear, serial).

Error Handling: استخدام block, rescue, always وإدارة الفشل.

10. التعامل مع البيانات الخارجية (Lookups & Inventory)
Lookups: جلب البيانات من ملفات أو بيئات خارجية.

Dynamic Inventory: إدارة سيرفرات الـ Cloud (AWS, Azure) تلقائياً.

11. التوسع والبرمجة (Custom Modules)
مقدمة عن تطوير الـ Modules الخاصة باستخدام Python.

12. المشروع العملي (Applied Project)
نشر تطبيق متكامل (LAMP Stack E-commerce Application).

محاكاة بيئة الـ Production (Multi-node deployment).