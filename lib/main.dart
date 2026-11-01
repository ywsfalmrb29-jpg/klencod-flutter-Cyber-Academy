import 'dart:math';
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
  int themeIndex = 0;
  bool english = false;
  bool matrixEnabled = true;
  double matrixSpeed = 1.0;

  int selectedPage = 0;
  int xp = 0;

  final Set<String> completedLessons = {};
  final Set<String> favorites = {};

  final List<Color> themeColors = const [
    Color(0xFF00E676),
    Color(0xFF9C6BFF),
    Color(0xFFFFC247),
    Color(0xFFFF5252),
    Color(0xFF2196F3),
  ];

  Color get accent => themeColors[themeIndex];

  String tr(String ar, String en) {
    return english ? en : ar;
  }

  void earnXP(int amount) {
    setState(() {
      xp += amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edman Cyber Academy',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor:
            const Color(0xFF080D14),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF080D14),
          elevation: 0,
        ),
      ),
      home: Directionality(
        textDirection:
            english ? TextDirection.ltr : TextDirection.rtl,
        child: MainScreen(
          accent: accent,
          english: english,
          matrixEnabled: matrixEnabled,
          matrixSpeed: matrixSpeed,
          selectedPage: selectedPage,
          xp: xp,
          completedLessons: completedLessons,
          favorites: favorites,
          tr: tr,
          onPageChanged: (v) {
            setState(() => selectedPage = v);
          },
          onThemeChanged: (v) {
            setState(() => themeIndex = v);
          },
          onLanguageChanged: (v) {
            setState(() => english = v);
          },
          onMatrixChanged: (v) {
            setState(() => matrixEnabled = v);
          },
          onSpeedChanged: (v) {
            setState(() => matrixSpeed = v);
          },
          onCompleteLesson: (id) {
            if (completedLessons.add(id)) {
              earnXP(20);
            }
          },
          onFavorite: (id) {
            setState(() {
              if (!favorites.add(id)) {
                favorites.remove(id);
              }
            });
          },
        ),
      ),
    );
  }
}
class MainScreen extends StatelessWidget {
  final Color accent;
  final bool english;
  final bool matrixEnabled;
  final double matrixSpeed;
  final int selectedPage;
  final int xp;

  final Set<String> completedLessons;
  final Set<String> favorites;

  final String Function(String, String) tr;

  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onThemeChanged;
  final ValueChanged<bool> onLanguageChanged;
  final ValueChanged<bool> onMatrixChanged;
  final ValueChanged<double> onSpeedChanged;
  final ValueChanged<String> onCompleteLesson;
  final ValueChanged<String> onFavorite;

  const MainScreen({
    super.key,
    required this.accent,
    required this.english,
    required this.matrixEnabled,
    required this.matrixSpeed,
    required this.selectedPage,
    required this.xp,
    required this.completedLessons,
    required this.favorites,
    required this.tr,
    required this.onPageChanged,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.onMatrixChanged,
    required this.onSpeedChanged,
    required this.onCompleteLesson,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        accent: accent,
        xp: xp,
        completed: completedLessons.length,
        tr: tr,
        onNavigate: onPageChanged,
      ),
      AcademyScreen(
        accent: accent,
        completed: completedLessons,
        favorites: favorites,
        tr: tr,
        onComplete: onCompleteLesson,
        onFavorite: onFavorite,
      ),
      LabsScreen(
        accent: accent,
        tr: tr,
      ),
      SettingsScreen(
        accent: accent,
        english: english,
        matrixEnabled: matrixEnabled,
        matrixSpeed: matrixSpeed,
        tr: tr,
        onThemeChanged: onThemeChanged,
        onLanguageChanged: onLanguageChanged,
        onMatrixChanged: onMatrixChanged,
        onSpeedChanged: onSpeedChanged,
      ),
    ];

    return Stack(
      children: [
        const Positioned.fill(
          child: ColoredBox(
            color: Color(0xFF080D14),
          ),
        ),

        if (matrixEnabled)
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.19,
                child: MatrixBackground(
                  color: accent,
                  speed: matrixSpeed,
                ),
              ),
            ),
          ),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: pages[selectedPage],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedPage,
            onDestinationSelected: onPageChanged,
            backgroundColor: const Color(0xFF101722),
            indicatorColor: accent.withOpacity(0.20),
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: accent),
                label: tr('الرئيسية', 'Home'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.school_outlined),
                selectedIcon: Icon(Icons.school, color: accent),
                label: tr('الأكاديمية', 'Academy'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.science_outlined),
                selectedIcon: Icon(Icons.science, color: accent),
                label: tr('المعامل', 'Labs'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings, color: accent),
                label: tr('الإعدادات', 'Settings'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// MATRIX BACKGROUND

class MatrixBackground extends StatefulWidget {
  final Color color;
  final double speed;

  const MatrixBackground({
    super.key,
    required this.color,
    required this.speed,
  });

  @override
  State<MatrixBackground> createState() =>
      _MatrixBackgroundState();
}

class _MatrixBackgroundState
    extends State<MatrixBackground>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: (14000 / widget.speed).round(),
      ),
    )..repeat();
  }

  @override
  void didUpdateWidget(MatrixBackground oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.speed != widget.speed) {
      controller.duration = Duration(
        milliseconds: (14000 / widget.speed).round(),
      );

      controller
        ..stop()
        ..repeat();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: MatrixPainter(
            color: widget.color,
            progress: controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class MatrixPainter extends CustomPainter {
  final Color color;
  final double progress;

  MatrixPainter({
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const symbols = '01アイウエオカキクケコサシスセソ';

    const columnWidth = 20.0;

    final columns =
        (size.width / columnWidth).ceil();

    for (int i = 0; i < columns; i++) {
      final seed = i * 37 + 13;

      final start =
          (seed % 100) / 100 * size.height;

      final velocity =
          0.5 + (seed % 8) / 10;

      final y = (
        start + progress * size.height * velocity
      ) % (size.height + 60);

      final symbolIndex =
          (seed + (progress * 100).floor()) %
              symbols.length;

      final painter = TextPainter(
        text: TextSpan(
          text: symbols[symbolIndex],
          style: TextStyle(
            color: color.withOpacity(
              0.3 + (seed % 5) * 0.12,
            ),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      painter.layout();

      painter.paint(
        canvas,
        Offset(i * columnWidth, y),
      );
    }
  }

  @override
  bool shouldRepaint(covariant MatrixPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color;
  }
}

// HOME SCREEN

class HomeScreen extends StatelessWidget {
  final Color accent;
  final int xp;
  final int completed;
  final String Function(String, String) tr;
  final ValueChanged<int> onNavigate;

  const HomeScreen({
    super.key,
    required this.accent,
    required this.xp,
    required this.completed,
    required this.tr,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final level = xp ~/ 100 + 1;

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.security,
                color: accent,
                size: 30,
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EDMAN',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                  ),
                  Text(
                    'CYBER ACADEMY',
                    style: TextStyle(
                      color: Color(0xFF00E676),
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.notifications_none,
              color: accent,
              size: 27,
            ),
          ],
        ),

        const SizedBox(height: 28),

        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: accent.withOpacity(0.35),
            ),
            gradient: LinearGradient(
              colors: [
                accent.withOpacity(0.25),
                const Color(0xFF111B28),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
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
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                tr(
                  'ابدأ رحلتك التعليمية وطور مهاراتك خطوة بخطوة.',
                  'Start your learning journey and build your skills.',
                ),
                style: const TextStyle(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  _HomeStat(
                    title: tr('النقاط', 'XP'),
                    value: '$xp',
                    icon: Icons.bolt,
                    color: accent,
                  ),

                  const SizedBox(width: 10),

                  _HomeStat(
                    title: tr('المستوى', 'Level'),
                    value: '$level',
                    icon: Icons.military_tech,
                    color: accent,
                  ),

                  const SizedBox(width: 10),

                  _HomeStat(
                    title: tr('الدروس', 'Lessons'),
                    value: '$completed',
                    icon: Icons.menu_book,
                    color: accent,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        Text(
          tr('استكشف الأكاديمية', 'Explore the academy'),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        _HomeFeature(
          icon: Icons.school,
          title: tr('المسارات التعليمية', 'Learning paths'),
          subtitle: tr(
            'تعلم الأمن السيبراني والبرمجة والشبكات.',
            'Learn cybersecurity, programming and networking.',
          ),
          accent: accent,
          onTap: () => onNavigate(1),
        ),

        _HomeFeature(
          icon: Icons.science,
          title: tr('معامل التدريب', 'Practice labs'),
          subtitle: tr(
            'اختبر معلوماتك في معامل تفاعلية آمنة.',
            'Practice with safe interactive labs.',
          ),
          accent: accent,
          onTap: () => onNavigate(2),
        ),

        _HomeFeature(
          icon: Icons.settings,
          title: tr('تخصيص التطبيق', 'Customize app'),
          subtitle: tr(
            'غير الألوان واللغة وتأثير الماتريكس.',
            'Change colors, language and Matrix effect.',
          ),
          accent: accent,
          onTap: () => onNavigate(3),
        ),

        const SizedBox(height: 22),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF111B28),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Icon(
                Icons.shield_outlined,
                color: accent,
                size: 30,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  tr(
                    'تذكر: اختبر مهاراتك فقط في بيئات تملكها أو لديك تصريح باستخدامها.',
                    'Practice only in environments you own or are authorized to use.',
                  ),
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeStat extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _HomeStat({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;

  const _HomeFeature({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF111B28),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(13),
        leading: CircleAvatar(
          backgroundColor: accent.withOpacity(0.15),
          child: Icon(icon, color: accent),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
    );
  }
}
// ===============================
// ACADEMY LESSONS
// ===============================

class Lesson {
  final String id;
  final String title;
  final String category;
  final String description;
  final String content;
  final IconData icon;

  const Lesson({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.content,
    required this.icon,
  });
}

final List<Lesson> academyLessons = [
  Lesson(
    id: 'cyber1',
    title: 'مقدمة الأمن السيبراني',
    category: 'الأمن السيبراني',
    description: 'تعرف على أساسيات حماية المعلومات',
    content: '''
الأمن السيبراني هو مجال يهتم بحماية الأجهزة والشبكات والبيانات من التهديدات الرقمية.

أهم المبادئ:

1- السرية: منع الوصول غير المصرح به للمعلومات.
2- السلامة: الحفاظ على صحة البيانات وعدم تغييرها دون إذن.
3- التوافر: ضمان إمكانية الوصول للخدمات عند الحاجة.

مجالات الأمن السيبراني:
- أمن الشبكات.
- أمن التطبيقات.
- حماية البيانات.
- الاستجابة للحوادث.
- اختبار الاختراق المصرح به.
''',
    icon: Icons.security,
  ),
  Lesson(
    id: 'network1',
    title: 'أساسيات الشبكات',
    category: 'الشبكات',
    description: 'تعرف على IP و DNS و HTTP',
    content: '''
الشبكة هي مجموعة أجهزة تتبادل البيانات مع بعضها.

مصطلحات مهمة:

IP:
عنوان يستخدم للتعرف على الجهاز داخل الشبكة.

DNS:
يساعد في تحويل أسماء المواقع إلى عناوين IP.

HTTP:
بروتوكول لنقل بيانات صفحات الويب.

HTTPS:
نسخة مشفرة من HTTP.

Router:
جهاز يربط الشبكات ويوجه البيانات.

Port:
رقم يحدد الخدمة أو التطبيق الذي يستقبل الاتصال.
''',
    icon: Icons.router,
  ),
  Lesson(
    id: 'linux1',
    title: 'مقدمة Linux و Termux',
    category: 'Linux',
    description: 'تعلم التعامل مع الطرفية',
    content: '''
Linux نظام تشغيل مفتوح المصدر.

Termux تطبيق يوفر بيئة طرفية على Android.

أوامر أساسية:

pwd
عرض المسار الحالي.

ls
عرض الملفات والمجلدات.

cd
الانتقال إلى مجلد.

mkdir
إنشاء مجلد.

touch
إنشاء ملف.

cat
عرض محتويات ملف.

clear
مسح شاشة الطرفية.

ملاحظة:
استخدم الأوامر على جهازك أو بيئة تدريب تملكها.
''',
    icon: Icons.terminal,
  ),
  Lesson(
    id: 'python1',
    title: 'مقدمة Python',
    category: 'البرمجة',
    description: 'تعرف على لغة Python',
    content: '''
Python لغة برمجة سهلة القراءة والتعلم.

مثال:

print("Hello Edman")

المتغيرات:

name = "Edman"
age = 18

الشروط:

if age >= 18:
    print("Welcome")

الحلقات:

for i in range(5):
    print(i)

تستخدم Python في:
- تطوير التطبيقات.
- تحليل البيانات.
- الأتمتة.
- أدوات الأمن الدفاعية.
''',
    icon: Icons.code,
  ),
  Lesson(
    id: 'html1',
    title: 'أساسيات HTML',
    category: 'تطوير الويب',
    description: 'تعلم بناء صفحات الويب',
    content: '''
HTML هي لغة بناء هيكل صفحات الويب.

مثال:

<h1>Edman Academy</h1>
<p>Welcome to my website</p>
<button>Start</button>

أهم العناصر:
h1 للعناوين.
p للفقرات.
img للصور.
a للروابط.
button للأزرار.
input لحقول الإدخال.
''',
    icon: Icons.web,
  ),
  Lesson(
    id: 'css1',
    title: 'أساسيات CSS',
    category: 'تطوير الويب',
    description: 'تعلم تنسيق صفحات الويب',
    content: '''
CSS تستخدم لتنسيق صفحات HTML.

مثال:

body {
  background: #080D14;
  color: white;
  font-family: Arial;
}

h1 {
  color: #00E676;
}

button {
  background: #00E676;
  padding: 12px;
  border-radius: 10px;
}

يمكنك استخدام CSS لتغيير:
- الألوان.
- الأحجام.
- المسافات.
- الخلفيات.
- شكل الأزرار.
''',
    icon: Icons.palette,
  ),
  Lesson(
    id: 'javascript1',
    title: 'أساسيات JavaScript',
    category: 'البرمجة',
    description: 'تعرف على لغة JavaScript',
    content: '''
JavaScript تضيف التفاعل إلى صفحات الويب.

مثال:

let name = "Edman";

console.log(name);

الدوال:

function welcome() {
  alert("Welcome");
}

الشروط:

if (10 > 5) {
  console.log("True");
}

تستخدم JavaScript في:
- المواقع التفاعلية.
- تطبيقات الويب.
- الألعاب البسيطة.
''',
    icon: Icons.javascript,
  ),
  Lesson(
    id: 'malware1',
    title: 'التوعية بالبرمجيات الضارة',
    category: 'الحماية',
    description: 'تعرف على الفيروسات وطرق الوقاية',
    content: '''
البرمجيات الضارة هي برامج مصممة لإلحاق الضرر بالأجهزة أو البيانات.

أشهر الأنواع:

Virus:
برنامج ضار قد يرتبط بملفات أخرى.

Trojan:
برنامج يبدو طبيعيًا لكنه يخفي وظيفة ضارة.

Ransomware:
برنامج يهدف إلى منع الوصول للبيانات وابتزاز المستخدم.

Spyware:
برنامج يجمع معلومات عن المستخدم دون علمه.

طرق الوقاية:
- لا تفتح مرفقات مجهولة.
- لا تثبت تطبيقات من مصادر غير موثوقة.
- حدّث نظامك باستمرار.
- استخدم كلمات مرور قوية.
- احتفظ بنسخة احتياطية من بياناتك.
''',
    icon: Icons.bug_report,
  ),
  Lesson(
    id: 'darkweb1',
    title: 'التوعية بالويب المظلم',
    category: 'الثقافة الرقمية',
    description: 'افهم المفهوم والمخاطر',
    content: '''
الويب المظلم جزء من الإنترنت لا يظهر عادة في محركات البحث التقليدية.

معلومات مهمة:

- ليس كل محتواه غير قانوني.
- توجد به مخاطر تتعلق بالاحتيال والخصوصية.
- قد يحتوي على محتوى غير قانوني أو ضار.
- لا تشارك بياناتك الشخصية في مواقع مجهولة.

الهدف من هذا الدرس هو الفهم والتوعية وتجنب المخاطر.
''',
    icon: Icons.visibility_off,
  ),
];

class AcademyScreen extends StatelessWidget {
  final Color accent;
  final bool english;
  final Function(String, String) tr;
  final Set<String> completedLessons;
  final Set<String> favorites;
  final Function(String) onCompleteLesson;
  final Function(String) onFavorite;

  const AcademyScreen({
    super.key,
    required this.accent,
    required this.english,
    required this.tr,
    required this.completedLessons,
    required this.favorites,
    required this.onCompleteLesson,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          tr('الأكاديمية التعليمية', 'Learning Academy'),
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          tr(
            'اختر المجال وابدأ التعلم خطوة بخطوة',
            'Choose a track and start learning',
          ),
          style: const TextStyle(color: Colors.white60),
        ),
        const SizedBox(height: 20),
        ...academyLessons.map((lesson) {
          final done = completedLessons.contains(lesson.id);
          final favorite = favorites.contains(lesson.id);

          return Card(
            color: const Color(0xFF111B28),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                backgroundColor: accent.withOpacity(0.15),
                child: Icon(lesson.icon, color: accent),
              ),
              title: Text(
                english ? lesson.category : lesson.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                english ? lesson.description : lesson.description,
              ),
              trailing: Icon(
                done ? Icons.check_circle : Icons.arrow_forward_ios,
                color: done ? accent : Colors.white54,
                size: 18,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LessonDetailsScreen(
                      lesson: lesson,
                      accent: accent,
                      english: english,
                      tr: tr,
                      completed: done,
                      favorite: favorite,
                      onComplete: () => onCompleteLesson(lesson.id),
                      onFavorite: () => onFavorite(lesson.id),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

// ===============================
// LESSON DETAILS
// ===============================

class LessonDetailsScreen extends StatefulWidget {
  final Lesson lesson;
  final Color accent;
  final bool english;
  final Function(String, String) tr;
  final bool completed;
  final bool favorite;
  final VoidCallback onComplete;
  final VoidCallback onFavorite;

  const LessonDetailsScreen({
    super.key,
    required this.lesson,
    required this.accent,
    required this.english,
    required this.tr,
    required this.completed,
    required this.favorite,
    required this.onComplete,
    required this.onFavorite,
  });

  @override
  State<LessonDetailsScreen> createState() =>
      _LessonDetailsScreenState();
}

class _LessonDetailsScreenState
    extends State<LessonDetailsScreen> {
  late bool completed;
  late bool favorite;

  @override
  void initState() {
    super.initState();
    completed = widget.completed;
    favorite = widget.favorite;
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
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
          Icon(
            lesson.icon,
            size: 65,
            color: widget.accent,
          ),
          const SizedBox(height: 20),
          Text(
            lesson.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF111B28),
              borderRadius: BorderRadius.circular(16),
            ),
            child: SelectableText(
              lesson.content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.8,
              ),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.accent,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.all(15),
            ),
            onPressed: completed
                ? null
                : () {
                    widget.onComplete();
                    setState(() => completed = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.tr(
                            'أحسنت! حصلت على 20 XP',
                            'Great! You earned 20 XP',
                          ),
                        ),
                      ),
                    );
                  },
            icon: const Icon(Icons.check_circle),
            label: Text(
              completed
                  ? widget.tr('تم إكمال الدرس', 'Lesson completed')
                  : widget.tr('إكمال الدرس +20 XP', 'Complete lesson +20 XP'),
            ),
          ),
        ],
      ),
    );
  }
}

// ===============================
// SAFE INTERACTIVE LABS
// ===============================

class LabsScreen extends StatelessWidget {
  final Color accent;
  final bool english;
  final Function(String, String) tr;

  const LabsScreen({
    super.key,
    required this.accent,
    required this.english,
    required this.tr,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          tr('المختبر العملي', 'Practical Labs'),
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          tr(
            'تدريبات تعليمية آمنة داخل التطبيق',
            'Safe educational exercises inside the app',
          ),
          style: const TextStyle(color: Colors.white60),
        ),
        const SizedBox(height: 20),
        _LabCard(
          icon: Icons.password,
          title: tr('مختبر قوة كلمات المرور', 'Password Strength Lab'),
          subtitle: tr('تعلم تقييم قوة كلمة المرور', 'Learn password strength'),
          accent: accent,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PasswordLabScreen(accent: accent, tr: tr),
            ),
          ),
        ),
        _LabCard(
          icon: Icons.phishing,
          title: tr('اكتشاف رسائل التصيد', 'Phishing Awareness'),
          subtitle: tr('اختبر قدرتك على اكتشاف الرسائل المشبوهة', 'Spot suspicious messages'),
          accent: accent,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PhishingLabScreen(accent: accent, tr: tr),
            ),
          ),
        ),
        _LabCard(
          icon: Icons.lan,
          title: tr('محاكي الشبكات', 'Network Simulator'),
          subtitle: tr('تعرف على مكونات الشبكة', 'Learn network components'),
          accent: accent,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NetworkLabScreen(accent: accent, tr: tr),
            ),
          ),
        ),
      ],
    );
  }
}

class _LabCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;

  const _LabCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF111B28),
      margin: const EdgeInsets.only(bottom: 13),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(15),
        leading: Icon(icon, color: accent, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

// ===============================
// PASSWORD LAB
// ===============================

class PasswordLabScreen extends StatefulWidget {
  final Color accent;
  final Function(String, String) tr;

  const PasswordLabScreen({
    super.key,
    required this.accent,
    required this.tr,
  });

  @override
  State<PasswordLabScreen> createState() =>
      _PasswordLabScreenState();
}

class _PasswordLabScreenState extends State<PasswordLabScreen> {
  final controller = TextEditingController();
  bool visible = false;

  String get strength {
    final p = controller.text;
    if (p.isEmpty) return 'empty';

    int score = 0;
    if (p.length >= 12) score++;
    if (p.contains(RegExp(r'[A-Z]'))) score++;
    if (p.contains(RegExp(r'[a-z]'))) score++;
    if (p.contains(RegExp(r'[0-9]'))) score++;
    if (p.contains(RegExp(r'[^A-Za-z0-9]'))) score++;

    if (score <= 2) return 'weak';
    if (score <= 3) return 'medium';
    return 'strong';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String result;
    Color resultColor;

    switch (strength) {
      case 'weak':
        result = widget.tr('ضعيفة', 'Weak');
        resultColor = Colors.redAccent;
        break;
      case 'medium':
        result = widget.tr('متوسطة', 'Medium');
        resultColor = Colors.orangeAccent;
        break;
      case 'strong':
        result = widget.tr('قوية', 'Strong');
        resultColor = Colors.greenAccent;
        break;
      default:
        result = widget.tr('اكتب كلمة تجريبية', 'Enter a sample password');
        resultColor = Colors.white54;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tr('مختبر كلمات المرور', 'Password Lab')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.tr(
                'اكتب كلمة مرور تجريبية لتقييم قوتها.',
                'Enter a sample password to evaluate its strength.',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              obscureText: !visible,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: widget.tr('كلمة مرور تجريبية', 'Sample password'),
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    visible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => visible = !visible),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              result,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: resultColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.tr(
                'للحصول على كلمة أقوى: استخدم طولًا مناسبًا ومزيجًا من الحروف والأرقام والرموز.',
                'Use a longer password with a mix of letters, numbers and symbols.',
              ),
              style: const TextStyle(height: 1.6),
            ),
            const SizedBox(height: 15),
            Text(
              widget.tr(
                'تنبيه: لا تكتب كلمة مرورك الحقيقية هنا. هذا فحص تعليمي محلي ولا يحفظ النص.',
                'Warning: Never enter your real password. This is a local demo and does not save the text.',
              ),
              style: const TextStyle(color: Colors.orangeAccent),
            ),
          ],
        ),
      ),
    );
  }
}

// ===============================
// PHISHING AWARENESS LAB
// ===============================

class PhishingLabScreen extends StatefulWidget {
  final Color accent;
  final Function(String, String) tr;

  const PhishingLabScreen({
    super.key,
    required this.accent,
    required this.tr,
  });

  @override
  State<PhishingLabScreen> createState() =>
      _PhishingLabScreenState();
}

class _PhishingLabScreenState extends State<PhishingLabScreen> {
  int question = 0;
  int score = 0;
  bool answered = false;

  final questions = [
    {
      'text': 'وصلتك رسالة تطلب كلمة المرور فورًا. ماذا تفعل؟',
      'en': 'A message asks for your password urgently. What do you do?',
      'answer': 1,
      'explain': 'لا تشارك كلمة المرور وتحقق من الجهة عبر قنواتها الرسمية.',
      'explainEn': 'Never share your password. Verify through official channels.',
    },
    {
      'text': 'رابط به اسم موقع مكتوب بطريقة غريبة. هل تثق به؟',
      'en': 'A link has a strangely spelled website name. Do you trust it?',
      'answer': 1,
      'explain': 'افحص اسم النطاق ولا تفتح الروابط المشبوهة.',
      'explainEn': 'Check the domain and avoid suspicious links.',
    },
    {
      'text': 'مرفق غير متوقع من شخص مجهول. ما التصرف الصحيح؟',
      'en': 'An unexpected attachment from an unknown sender. What should you do?',
      'answer': 1,
      'explain': 'لا تفتح المرفق قبل التحقق من المرسل.',
      'explainEn': 'Do not open it before verifying the sender.',
    },
  ];

  void choose(int value) {
    if (answered) return;
    setState(() {
      answered = true;
      if (value == questions[question]['answer']) score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[question];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tr('اختبار التصيد', 'Phishing Quiz')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${question + 1} / ${questions.length}',
              textAlign: TextAlign.center,
              style: TextStyle(color: widget.accent, fontSize: 18),
            ),
            const SizedBox(height: 25),
            Text(
              widget.tr(q['text'] as String, q['en'] as String),
              style: const TextStyle(fontSize: 20, height: 1.5),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => choose(1),
              child: Text(widget.tr('لا، أتحقق أولًا', 'No, verify first')),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => choose(0),
              child: Text(widget.tr('نعم، أنفذ الطلب', 'Yes, follow the request')),
            ),
            if (answered) ...[
              const SizedBox(height: 20),
              Text(
                widget.tr(
                  q['explain'] as String,
                  q['explainEn'] as String,
                ),
                style: const TextStyle(height: 1.6),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (question < questions.length - 1) {
                    setState(() {
                      question++;
                      answered = false;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(widget.tr('انتهى الاختبار', 'Quiz finished')),
                        content: Text(
                          widget.tr(
                            'نتيجتك: $score من ${questions.length}',
                            'Your score: $score of ${questions.length}',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text(
                  widget.tr('السؤال التالي', 'Next question'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ===============================
// NETWORK SIMULATOR
// ===============================

class NetworkLabScreen extends StatelessWidget {
  final Color accent;
  final Function(String, String) tr;

  const NetworkLabScreen({
    super.key,
    required this.accent,
    required this.tr,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      ['Router', 'جهاز يوجه البيانات بين الشبكات', 'Routes data between networks'],
      ['DNS', 'يحول أسماء المواقع إلى عناوين IP', 'Translates domain names into IP addresses'],
      ['IP Address', 'عنوان يميز الجهاز على الشبكة', 'Identifies a device on a network'],
      ['Firewall', 'يساعد على تنظيم الاتصالات وحمايتها', 'Helps filter and protect network traffic'],
      ['HTTPS', 'يوفر اتصالًا مشفرًا بالمواقع', 'Provides encrypted website communication'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('محاكي الشبكات', 'Network Simulator')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            tr(
              'تعرف على مكونات الشبكة بشكل مبسط.',
              'Explore basic network components.',
            ),
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 15),
          ...items.map((item) => Card(
                color: const Color(0xFF111B28),
                child: ListTile(
                  leading: Icon(Icons.hub, color: accent),
                  title: Text(item[0]),
                  subtitle: Text(tr(item[1], item[2])),
                ),
              )),
          const SizedBox(height: 12),
          Text(
            tr(
              'هذا محاكي تعليمي فقط، ولا يفحص أجهزة أو شبكات حقيقية.',
              'This is an educational simulator. It does not scan real devices or networks.',
            ),
            style: const TextStyle(color: Colors.orangeAccent),
          ),
        ],
      ),
    );
  }
}

// ===============================
// SETTINGS
// ===============================

class SettingsScreen extends StatelessWidget {
  final Color accent;
  final bool english;
  final bool matrixEnabled;
  final double matrixSpeed;
  final Function(String, String) tr;
  final Function(int) onThemeChanged;
  final Function(bool) onLanguageChanged;
  final Function(bool) onMatrixChanged;
  final Function(double) onSpeedChanged;

  const SettingsScreen({
    super.key,
    required this.accent,
    required this.english,
    required this.matrixEnabled,
    required this.matrixSpeed,
    required this.tr,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.onMatrixChanged,
    required this.onSpeedChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF00E676),
      const Color(0xFF9C6BFF),
      const Color(0xFFFFC247),
      const Color(0xFFFF5252),
      const Color(0xFF2196F3),
    ];

    final names = english
        ? ['Matrix Green', 'Purple', 'Gold', 'Red', 'Cyber Blue']
        : ['أخضر ماتريكس', 'بنفسجي', 'ذهبي', 'أحمر', 'أزرق سايبر'];

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(
          tr('الإعدادات', 'Settings'),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        // Language
        Card(
          color: const Color(0xFF111B28),
          child: SwitchListTile(
            secondary: Icon(Icons.language, color: accent),
            title: Text(tr('اللغة الإنجليزية', 'English language')),
            subtitle: Text(
              tr('التبديل بين العربية والإنجليزية', 'Switch Arabic / English'),
            ),
            value: english,
            onChanged: onLanguageChanged,
            activeColor: accent,
          ),
        ),

        const SizedBox(height: 15),
        Text(
          tr('اختيار لون التطبيق', 'Choose app theme'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(colors.length, (index) {
            return GestureDetector(
              onTap: () => onThemeChanged(index),
              child: Container(
                width: 145,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF111B28),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colors[index],
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 11,
                      backgroundColor: colors[index],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        names[index],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 22),

        // Matrix
        Card(
          color: const Color(0xFF111B28),
          child: SwitchListTile(
            secondary: Icon(Icons.blur_on, color: accent),
            title: Text(tr('تأثير Matrix', 'Matrix effect')),
            subtitle: Text(
              tr('تشغيل أو إيقاف المطر الرقمي', 'Enable or disable digital rain'),
            ),
            value: matrixEnabled,
            onChanged: onMatrixChanged,
            activeColor: accent,
          ),
        ),

        const SizedBox(height: 10),
        Text(
          tr('سرعة Matrix', 'Matrix speed'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Slider(
          value: matrixSpeed.clamp(0.5, 3.0),
          min: 0.5,
          max: 3.0,
          divisions: 5,
          activeColor: accent,
          label: '${matrixSpeed.toStringAsFixed(1)}x',
          onChanged: onSpeedChanged,
        ),

        const SizedBox(height: 20),
        Text(
          tr('تواصل معنا', 'Contact us'),
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        Card(
          color: const Color(0xFF111B28),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.telegram, color: Colors.lightBlue),
                title: const Text('Telegram'),
                subtitle: const Text('@youssef7_HAKER'),
                onTap: () => _copyText(context, 'https://t.me/youssef7_HAKER'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.play_circle_fill, color: Colors.red),
                title: const Text('YouTube'),
                subtitle: const Text('@Edman_haking-i4f'),
                onTap: () => _copyText(
                  context,
                  'https://www.youtube.com/@Edman_haking-i4f',
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.chat, color: Colors.green),
                title: const Text('WhatsApp'),
                subtitle: const Text('+201147144716'),
                onTap: () => _copyText(context, '+201147144716'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        Center(
          child: Column(
            children: [
              Text(
                'Edman Cyber Academy',
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Version 1.0',
                style: TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 10),
              Text(
                tr(
                  'تعلم • تدرب • احمِ نفسك',
                  'Learn • Practice • Protect',
                ),
                style: const TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _copyText(BuildContext context, String value) {
    // يعرض النص للمستخدم حتى ينسخه يدويًا.
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(tr('بيانات التواصل', 'Contact information')),
        content: SelectableText(value),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}