import 'package:flutter/material.dart';

void main() {
  runApp(const EdmanApp());
}

class EdmanApp extends StatefulWidget {
  const EdmanApp({super.key});

  @override
  State<EdmanApp> createState() => _EdmanAppState();
}

class _EdmanAppState extends State<EdmanApp> {
  Color accent = const Color(0xFF8B5CF6);
  bool english = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edman Cyber Academy',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080D18),
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: AcademyHome(
        accent: accent,
        english: english,
        onTheme: (c) => setState(() => accent = c),
        onLanguage: (v) => setState(() => english = v),
      ),
    );
  }
}

class Lesson {
  final String title;
  final String description;
  final String content;
  final IconData icon;

  const Lesson(
    this.title,
    this.description,
    this.content,
    this.icon,
  );
}

class Course {
  final String title;
  final String description;
  final IconData icon;
  final List<Lesson> lessons;

  const Course(
    this.title,
    this.description,
    this.icon,
    this.lessons,
  );
}

final List<Course> courses = [
  Course(
    'أساسيات الأمن السيبراني',
    'ابدأ رحلتك في عالم الحماية الرقمية',
    Icons.security,
    [
      Lesson(
        'ما هو الأمن السيبراني؟',
        'المفاهيم الأساسية',
        'الأمن السيبراني هو مجموعة من الممارسات والتقنيات التي تهدف إلى حماية الأجهزة والشبكات والبيانات من الوصول غير المصرح به أو التغيير أو التعطيل.\n\n'
        'أهم ثلاثة مبادئ:\n\n'
        '1. السرية: حماية المعلومات من الأشخاص غير المصرح لهم.\n\n'
        '2. السلامة: التأكد من أن البيانات لم يتم تغييرها دون إذن.\n\n'
        '3. التوافر: ضمان إمكانية الوصول إلى الأنظمة وقت الحاجة.',
        Icons.shield,
      ),
      Lesson(
        'أنواع التهديدات',
        'تعرف على المخاطر الرقمية',
        'من أشهر التهديدات الرقمية:\n\n'
        'التصيد الإلكتروني: رسائل وروابط تحاول خداع المستخدم.\n\n'
        'الهندسة الاجتماعية: استغلال الثقة للحصول على معلومات.\n\n'
        'البرمجيات الضارة: برامج قد تضر الجهاز أو البيانات.\n\n'
        'تسريب البيانات: كشف معلومات خاصة دون تصريح.\n\n'
        'أفضل حماية تبدأ بالوعي والتحديثات والحذر.',
        Icons.warning_amber,
      ),
      Lesson(
        'كلمات المرور',
        'حماية الحسابات',
        'استخدم كلمة مرور طويلة وفريدة لكل حساب.\n\n'
        'لا تستخدم تاريخ ميلادك أو معلومات سهلة التخمين.\n\n'
        'فعّل المصادقة متعددة العوامل.\n\n'
        'لا تشارك رموز التحقق مع أي شخص.\n\n'
        'يمكنك استخدام مدير كلمات مرور موثوق.',
        Icons.password,
      ),
    ],
  ),
  Course(
    'الشبكات والإنترنت',
    'افهم طريقة اتصال الأجهزة',
    Icons.lan,
    [
      Lesson(
        'مقدمة الشبكات',
        'ما هي الشبكة؟',
        'الشبكة هي مجموعة من الأجهزة المتصلة ببعضها لتبادل البيانات.\n\n'
        'LAN: شبكة محلية داخل مكان محدود.\n\n'
        'WAN: شبكة واسعة تربط شبكات عبر مسافات كبيرة.\n\n'
        'Router: جهاز يربط الشبكات ويوجه البيانات.\n\n'
        'Switch: يربط أجهزة الشبكة المحلية.',
        Icons.router,
      ),
      Lesson(
        'عنوان IP',
        'هوية الجهاز على الشبكة',
        'عنوان IP هو عنوان منطقي يستخدم للتعرف على واجهة الجهاز داخل الشبكة.\n\n'
        'IPv4 يستخدم صيغة تتكون من أربعة أجزاء رقمية.\n\n'
        'IPv6 هو معيار أحدث يوفر مساحة عناوين أكبر.\n\n'
        'لا تشارك معلومات شبكتك الخاصة مع أشخاص مجهولين.',
        Icons.language,
      ),
      Lesson(
        'DNS و HTTPS',
        'كيف يعمل الإنترنت؟',
        'DNS يساعد في تحويل اسم الموقع إلى عنوان IP.\n\n'
        'HTTP بروتوكول يستخدم لنقل صفحات الويب.\n\n'
        'HTTPS يضيف طبقة تشفير لحماية الاتصال.\n\n'
        'تأكد دائماً من اسم الموقع قبل إدخال بياناتك.',
        Icons.public,
      ),
      Lesson(
        'المنافذ والخدمات',
        'مقدمة في Ports',
        'المنفذ رقم منطقي تستخدمه الخدمات للتواصل عبر الشبكة.\n\n'
        'وجود منفذ مفتوح لا يعني أن الجهاز مخترق.\n\n'
        'يجب معرفة الخدمة التي تستخدم المنفذ وسبب تشغيلها.\n\n'
        'افحص فقط الأجهزة التي تملكها أو لديك تصريح واضح لفحصها.',
        Icons.settings_ethernet,
      ),
    ],
  ),
  Course(
    'Linux و Termux',
    'تعلم بيئة الطرفية',
    Icons.terminal,
    [
      Lesson(
        'ما هو Linux؟',
        'مقدمة أنظمة لينكس',
        'Linux نظام يعتمد على نواة مفتوحة المصدر.\n\n'
        'يستخدم في الخوادم والحواسيب والأجهزة المختلفة.\n\n'
        'توجد توزيعات متعددة مثل Ubuntu و Debian.\n\n'
        'الطرفية تسمح بالتعامل مع النظام باستخدام الأوامر النصية.',
        Icons.computer,
      ),
      Lesson(
        'مقدمة Termux',
        'لينكس على أندرويد',
        'Termux يوفر بيئة طرفية على أجهزة أندرويد.\n\n'
        'يمكن استخدامه للتعلم وإدارة الملفات وتشغيل أدوات تعليمية.\n\n'
        'نزّل التطبيق من مصدر موثوق.\n\n'
        'لا تنفذ أوامر مجهولة ولا تستخدم الأدوات ضد أجهزة الآخرين.',
        Icons.phone_android,
      ),
      Lesson(
        'إدارة الملفات',
        'تنظيم الملفات والمجلدات',
        'المجلد يستخدم لتنظيم الملفات.\n\n'
        'المسار يحدد مكان الملف داخل النظام.\n\n'
        'النسخ الاحتياطي يحمي ملفاتك من الفقدان.\n\n'
        'تأكد من المسار قبل تنفيذ أي عملية حذف أو تعديل.',
        Icons.folder,
      ),
    ],
  ),
  Course(
    'البرمجة وتطوير الويب',
    'تعرف على أشهر لغات البرمجة',
    Icons.code,
    [
      Lesson(
        'HTML',
        'بناء صفحات الويب',
        'HTML هي لغة توصيف تستخدم لبناء هيكل صفحات الويب.\n\n'
        'تستخدم للعناوين والفقرات والصور والروابط.\n\n'
        'هيكل الصفحة الجيد يجعل المحتوى منظماً وسهل القراءة.',
        Icons.web,
      ),
      Lesson(
        'CSS',
        'تصميم واجهات المواقع',
        'CSS تتحكم في مظهر صفحات الويب.\n\n'
        'يمكنك استخدامها لتغيير الألوان والخطوط والمسافات.\n\n'
        'تساعدك على تصميم صفحات متجاوبة مع الهاتف والحاسوب.',
        Icons.palette,
      ),
      Lesson(
        'JavaScript',
        'إضافة التفاعل',
        'JavaScript لغة برمجة تضيف التفاعل إلى صفحات الويب.\n\n'
        'يمكن استخدامها للتعامل مع الأزرار والنماذج وتحديث محتوى الصفحة.\n\n'
        'لا تضع مفاتيح API السرية داخل كود المتصفح.',
        Icons.javascript,
      ),
      Lesson(
        'Python',
        'لغة البرمجة Python',
        'Python لغة سهلة القراءة ومناسبة للمبتدئين.\n\n'
        'تستخدم في تحليل البيانات والأتمتة وتطوير التطبيقات.\n\n'
        'ابدأ بتعلم المتغيرات والشروط والحلقات والدوال.',
        Icons.data_object,
      ),
      Lesson(
        'Java و C++',
        'مقدمة لغات البرمجة',
        'Java تستخدم في تطبيقات متعددة المنصات وتطوير تطبيقات أندرويد.\n\n'
        'C++ تستخدم في الأنظمة والألعاب والبرامج التي تحتاج أداء مرتفعاً.\n\n'
        'ابدأ بالمفاهيم الأساسية ثم انتقل للمشاريع الصغيرة.',
        Icons.developer_mode,
      ),
    ],
  ),
  Course(
    'البرمجيات الضارة والحماية',
    'افهم المخاطر وكيف تحمي نفسك',
    Icons.bug_report,
    [
      Lesson(
        'ما هي Malware؟',
        'مقدمة البرمجيات الضارة',
        'Malware مصطلح عام للبرمجيات المصممة لإيذاء الأجهزة أو سرقة البيانات أو تعطيل الخدمات.\n\n'
        'من أنواعها الفيروسات وبرامج التجسس وبرامج الفدية.\n\n'
        'لا تجرب عينات ضارة على جهازك الحقيقي.\n\n'
        'تعلم طرق اكتشافها والوقاية منها.',
        Icons.bug_report,
      ),
      Lesson(
        'التصيد الإلكتروني',
        'اكتشاف الروابط المزيفة',
        'التصيد محاولة لخداع المستخدم حتى يشارك معلوماته.\n\n'
        'احذر الرسائل التي تطلب منك التصرف بسرعة.\n\n'
        'تحقق من اسم النطاق قبل تسجيل الدخول.\n\n'
        'لا تدخل بياناتك في صفحات مجهولة.',
        Icons.link,
      ),
      Lesson(
        'النسخ الاحتياطي',
        'حماية ملفاتك',
        'النسخ الاحتياطي يساعدك على استعادة ملفاتك عند فقدانها.\n\n'
        'احتفظ بنسخة منفصلة عن الجهاز الأساسي.\n\n'
        'اختبر استعادة الملفات من وقت لآخر.\n\n'
        'حدّث النظام والتطبيقات باستمرار.',
        Icons.backup,
      ),
    ],
  ),
  Course(
    'الخصوصية والويب المظلم',
    'وعي رقمي وحماية الخصوصية',
    Icons.visibility_off,
    [
      Lesson(
        'الخصوصية الرقمية',
        'حماية معلوماتك الشخصية',
        'لا تشارك معلوماتك الشخصية دون داعٍ.\n\n'
        'راجع أذونات التطبيقات.\n\n'
        'انتبه للصور التي قد تكشف بيانات خاصة.\n\n'
        'استخدم إعدادات الخصوصية المتاحة في حساباتك.',
        Icons.privacy_tip,
      ),
      Lesson(
        'فهم الويب المظلم',
        'معلومات توعوية',
        'الويب المظلم يشير إلى خدمات لا تظهر عادة في محركات البحث التقليدية.\n\n'
        'قد توجد استخدامات مشروعة للخصوصية، لكن توجد أيضاً مخاطر احتيال ومحتويات غير قانونية.\n\n'
        'ابتعد عن الأسواق والخدمات غير القانونية.\n\n'
        'لا تحمل ملفات مجهولة أو تشارك بياناتك الشخصية.',
        Icons.visibility_off,
      ),
    ],
  ),
];

class AcademyHome extends StatefulWidget {
  final Color accent;
  final bool english;
  final Function(Color) onTheme;
  final Function(bool) onLanguage;

  const AcademyHome({
    super.key,
    required this.accent,
    required this.english,
    required this.onTheme,
    required this.onLanguage,
  });

  @override
  State<AcademyHome> createState() => _AcademyHomeState();
}

class _AcademyHomeState extends State<AcademyHome> {
  int page = 0;
  int completed = 0;
  final Set<String> doneLessons = {};
  final Set<String> favorites = {};

  String tr(String ar, String en) =>
      widget.english ? en : ar;

  @override
  Widget build(BuildContext context) {
    final pages = [
      homePage(),
      coursesPage(),
      quizPage(),
      progressPage(),
      settingsPage(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[page]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: page,
        onDestinationSelected: (i) => setState(() => page = i),
        backgroundColor: const Color(0xFF101827),
        indicatorColor: widget.accent.withOpacity(.2),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: tr('الرئيسية', 'Home'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.school),
            label: tr('الدورات', 'Courses'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.quiz),
            label: tr('اختبار', 'Quiz'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.insights),
            label: tr('إنجازاتي', 'Progress'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: tr('الإعدادات', 'Settings'),
          ),
        ],
      ),
    );
  }

  Widget homePage() {
    final total = courses.fold<int>(
      0,
      (sum, course) => sum + course.lessons.length,
    );

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Row(
          children: [
            Icon(Icons.security, color: widget.accent, size: 38),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'EDMAN CYBER ACADEMY',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [
                widget.accent.withOpacity(.45),
                const Color(0xFF111B2B),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr(
                  'مرحباً بك في عالم الأمن السيبراني',
                  'Welcome to Cybersecurity',
                ),
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                tr(
                  'تعلم البرمجة والشبكات والحماية الرقمية من مكان واحد.',
                  'Learn programming, networking and digital security.',
                ),
              ),
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: () => setState(() => page = 1),
                icon: const Icon(Icons.play_arrow),
                label: Text(tr('ابدأ التعلم', 'Start learning')),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: statCard(
                '$total',
                tr('درس', 'Lessons'),
                Icons.menu_book,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: statCard(
                '${doneLessons.length}',
                tr('مكتمل', 'Completed'),
                Icons.check_circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: statCard(
                '${courses.length}',
                tr('مسارات', 'Tracks'),
                Icons.category,
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          'المسارات التعليمية',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...courses.map(
          (course) => courseCard(course),
        ),
      ],
    );
  }

  Widget statCard(String value, String label, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
            Icon(icon, color: widget.accent),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(label, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget courseCard(Course course) {
    final count = course.lessons
        .where((l) => doneLessons.contains(l.title))
        .length;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: widget.accent.withOpacity(.15),
          child: Icon(course.icon, color: widget.accent),
        ),
        title: Text(
          course.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$count / ${course.lessons.length} دروس مكتملة',
        ),
        children: course.lessons.map((lesson) {
          return ListTile(
            leading: Icon(
              doneLessons.contains(lesson.title)
                  ? Icons.check_circle
                  : lesson.icon,
              color: widget.accent,
            ),
            title: Text(lesson.title),
            subtitle: Text(lesson.description),
            trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            onTap: () => openLesson(lesson),
          );
        }).toList(),
      ),
    );
  }

  void openLesson(Lesson lesson) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LessonScreen(
          lesson: lesson,
          accent: widget.accent,
          isDone: doneLessons.contains(lesson.title),
          isFavorite: favorites.contains(lesson.title),
          onDone: () {
            setState(() => doneLessons.add(lesson.title));
          },
          onFavorite: () {
            setState(() {
              if (!favorites.add(lesson.title)) {
                favorites.remove(lesson.title);
              }
            });
          },
        ),
      ),
    );
  }

  Widget coursesPage() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'الأكاديمية التعليمية',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        ...courses.map((course) => courseCard(course)),
      ],
    );
  }

  Widget quizPage() {
    return QuizScreen(accent: widget.accent);
  }

  Widget progressPage() {
    final total = courses.fold<int>(
      0,
      (sum, course) => sum + course.lessons.length,
    );

    final percent = total == 0
        ? 0
        : (doneLessons.length / total * 100).round();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'إنجازاتي',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: total == 0 ? 0 : doneLessons.length / total,
                        strokeWidth: 12,
                        color: widget.accent,
                        backgroundColor: Colors.white12,
                      ),
                      Center(
                        child: Text(
                          '$percent%',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Text('نسبة إكمال الدروس'),
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.check_circle, color: widget.accent),
            title: const Text('الدروس المكتملة'),
            trailing: Text('${doneLessons.length}'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.bookmark, color: widget.accent),
            title: const Text('الدروس المفضلة'),
            trailing: Text('${favorites.length}'),
          ),
        ),
      ],
    );
  }

  Widget settingsPage() {
    final colors = [
      const Color(0xFF8B5CF6),
      const Color(0xFFE0AE35),
      const Color(0xFFEF4444),
      const Color(0xFF168BFF),
      const Color(0xFF00D084),
    ];

    final names = [
      'بنفسجي',
      'ذهبي',
      'أحمر',
      'أزرق',
      'أخضر Matrix',
    ];

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'الإعدادات',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Card(
          child: SwitchListTile(
            title: const Text('English language'),
            subtitle: const Text('التبديل بين العربية والإنجليزية'),
            value: widget.english,
            onChanged: widget.onLanguage,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'ألوان التطبيق',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(
            colors.length,
            (i) => InkWell(
              onTap: () => widget.onTheme(colors[i]),
              child: Container(
                width: 100,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colors[i].withOpacity(.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors[i]),
                ),
                child: Column(
                  children: [
                    CircleAvatar(backgroundColor: colors[i]),
                    const SizedBox(height: 8),
                    Text(names[i]),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          'تواصل معنا',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const ListTile(
          leading: Icon(Icons.telegram, color: Colors.lightBlue),
          title: Text('Telegram'),
          subtitle: Text('@youssef7_HAKER'),
        ),
        const ListTile(
          leading: Icon(Icons.play_circle_fill, color: Colors.red),
          title: Text('YouTube'),
          subtitle: Text('@Edman_haking-i4f'),
        ),
        const ListTile(
          leading: Icon(Icons.chat, color: Colors.green),
          title: Text('WhatsApp'),
          subtitle: Text('+201147144716'),
        ),
        const SizedBox(height: 20),
        const Card(
          child: ListTile(
            leading: Icon(Icons.star, color: Colors.amber),
            title: Text('قيّم التطبيق'),
            subtitle: Text('شكراً لدعمك وتقييمك لـ Edman.'),
          ),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'EDMAN CYBER ACADEMY • VERSION 1.0',
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ),
      ],
    );
  }
}

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  final Color accent;
  final bool isDone;
  final bool isFavorite;
  final VoidCallback onDone;
  final VoidCallback onFavorite;

  const LessonScreen({
    super.key,
    required this.lesson,
    required this.accent,
    required this.isDone,
    required this.isFavorite,
    required this.onDone,
    required this.onFavorite,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late bool done;
  late bool favorite;

  @override
  void initState() {
    super.initState();
    done = widget.isDone;
    favorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDMAN LESSON'),
        actions: [
          IconButton(
            onPressed: () {
              widget.onFavorite();
              setState(() => favorite = !favorite);
            },
            icon: Icon(
              favorite ? Icons.bookmark : Icons.bookmark_border,
              color: widget.accent,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Icon(widget.lesson.icon, size: 55, color: widget.accent),
          const SizedBox(height: 20),
          Text(
            widget.lesson.title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.lesson.description,
            style: const TextStyle(color: Colors.white60),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                widget.lesson.content,
                style: const TextStyle(fontSize: 17, height: 1.9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: done
                  ? null
                  : () {
                      widget.onDone();
                      setState(() => done = true);
                    },
              icon: const Icon(Icons.check_circle),
              label: Text(
                done ? 'تم إكمال الدرس' : 'تحديد الدرس كمكتمل',
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'تذكر: استخدم المعرفة لأغراض التعلم والحماية، واختبر فقط الأنظمة التي تملكها أو لديك تصريح واضح لاختبارها.',
            style: TextStyle(color: Colors.white54, height: 1.6),
          ),
        ],
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final Color accent;

  const QuizScreen({super.key, required this.accent});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int score = 0;
  int? selected;
  bool finished = false;

  final questions = [
    {
      'q': 'ما الهدف الأساسي من الأمن السيبراني؟',
      'a': [
        'حماية الأنظمة والبيانات',
        'زيادة سرعة الإنترنت',
        'تصميم الصور',
        'إلغاء كلمات المرور',
      ],
      'c': 0,
    },
    {
      'q': 'ما أفضل طريقة لزيادة حماية الحساب؟',
      'a': [
        'مشاركة كلمة المرور',
        'استخدام المصادقة متعددة العوامل',
        'استخدام كلمة مرور واحدة لكل الحسابات',
        'تعطيل التحديثات',
      ],
      'c': 1,
    },
    {
      'q': 'ما وظيفة DNS؟',
      'a': [
        'تغيير ألوان الشاشة',
        'تحويل أسماء المواقع إلى عناوين IP',
        'حذف الملفات',
        'زيادة مساحة الهاتف',
      ],
      'c': 1,
    },
    {
      'q': 'هل المنفذ المفتوح يعني اختراقاً مؤكداً؟',
      'a': [
        'نعم دائماً',
        'لا، يجب فهم الخدمة والسياق',
        'يعني أن الجهاز مغلق',
        'يعني عدم وجود شبكة',
      ],
      'c': 1,
    },
    {
      'q': 'أين يجب أن تتدرب على اختبار الأمان؟',
      'a': [
        'أي موقع عشوائي',
        'جهازك أو مختبر مصرح به',
        'شبكة الجيران',
        'حسابات الآخرين',
      ],
      'c': 1,
    },
  ];

  void answer(int choice) {
    if (selected != null) return;

    setState(() {
      selected = choice;
      if (choice == questions[index]['c']) {
        score++;
      }
    });
  }

  void next() {
    if (index == questions.length - 1) {
      setState(() => finished = true);
    } else {
      setState(() {
        index++;
        selected = null;
      });
    }
  }

  void restart() {
    setState(() {
      index = 0;
      score = 0;
      selected = null;
      finished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (finished) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.emoji_events, size: 75, color: widget.accent),
            const SizedBox(height: 20),
            const Text(
              'انتهى الاختبار!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'نتيجتك: $score من ${questions.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: restart,
              child: const Text('إعادة الاختبار'),
            ),
          ],
        ),
      );
    }

    final question = questions[index];
    final answers = question['a'] as List<String>;
    final correct = question['c'] as int;

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'اختبر معلوماتك',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text('السؤال ${index + 1} من ${questions.length}'),
        const SizedBox(height: 15),
        LinearProgressIndicator(
          value: (index + 1) / questions.length,
          color: widget.accent,
        ),
        const SizedBox(height: 25),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              question['q'] as String,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        ...List.generate(answers.length, (i) {
          Color? color;

          if (selected != null && i == correct) {
            color = Colors.green.withOpacity(.25);
          } else if (selected == i) {
            color = Colors.red.withOpacity(.25);
          }

          return Card(
            color: color,
            child: ListTile(
              title: Text(answers[i]),
              onTap: () => answer(i),
            ),
          );
        }),
        const SizedBox(height: 20),
        if (selected != null)
          FilledButton(
            onPressed: next,
            child: Text(
              index == questions.length - 1
                  ? 'عرض النتيجة'
                  : 'السؤال التالي',
            ),
          ),
      ],
    );
  }
}