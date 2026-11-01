import 'package:flutter/material.dart';

void main() {
  runApp(const EdmanCyberAcademy());
}

// ==================== COLORS ====================

const Color matrixGreen = Color(0xFF39FF14);
const Color neonGreen = Color(0xFF00D084);
const Color background = Color(0xFF070B09);
const Color panel = Color(0xFF101813);
const Color muted = Color(0xFF9AA9A0);

// ==================== APP ====================

class EdmanCyberAcademy extends StatelessWidget {
  const EdmanCyberAcademy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edman Cyber Academy',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          primary: matrixGreen,
          secondary: neonGreen,
          surface: panel,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainShell(),
    );
  }
}

// ==================== COURSE MODEL ====================

class Course {
  final String title;
  final String subtitle;
  final String level;
  final String duration;
  final IconData icon;
  final double progress;
  final List<String> lessons;

  const Course({
    required this.title,
    required this.subtitle,
    required this.level,
    required this.duration,
    required this.icon,
    required this.progress,
    required this.lessons,
  });
}

// ==================== COURSES DATA ====================

const List<Course> courses = [
  Course(
    title: 'مدخل إلى الأمن السيبراني',
    subtitle: 'افهم المجال ومبادئ الحماية والأخلاقيات',
    level: 'مبتدئ',
    duration: '6 دروس',
    icon: Icons.shield_outlined,
    progress: 0.25,
    lessons: [
      'ما هو الأمن السيبراني؟',
      'الفرق بين الاختبار الأخلاقي والهجوم غير المصرح',
      'مبادئ السرية والسلامة والتوافر',
      'نطاق الاختبار والحصول على الإذن',
      'أنواع التهديدات الرقمية',
      'مراجعة واختبار قصير',
    ],
  ),
  Course(
    title: 'Linux و Termux',
    subtitle: 'تعرف على سطر الأوامر وإدارة الملفات',
    level: 'مبتدئ',
    duration: '8 دروس',
    icon: Icons.terminal,
    progress: 0.0,
    lessons: [
      'التعرف على Linux وTermux',
      'التنقل بين المجلدات',
      'إنشاء الملفات والمجلدات',
      'إدارة الحزم والتحديثات',
      'الصلاحيات والمستخدمون',
      'قراءة صفحات المساعدة',
      'إدارة العمليات',
      'تحدي مراجعة',
    ],
  ),
  Course(
    title: 'أساسيات الشبكات',
    subtitle: 'IP وDNS وPorts وطرق عمل الشبكات',
    level: 'مبتدئ',
    duration: '7 دروس',
    icon: Icons.lan_outlined,
    progress: 0.0,
    lessons: [
      'كيف تعمل الشبكات؟',
      'عنوان IP',
      'الفرق بين TCP وUDP',
      'ما هو DNS؟',
      'المنافذ والخدمات',
      'قراءة مخطط شبكة',
      'اختبار قصير',
    ],
  ),
  Course(
    title: 'فحص الأمان وتحليل النتائج',
    subtitle: 'مفاهيم الفحص داخل مختبر تملكه أو لديك إذن به',
    level: 'متوسط',
    duration: '5 دروس',
    icon: Icons.manage_search,
    progress: 0.0,
    lessons: [
      'مفهوم تقييم الثغرات',
      'تحديد النطاق المصرح',
      'قراءة نتائج فحص تجريبي',
      'تمييز النتائج المهمة والإيجابيات الكاذبة',
      'كتابة ملخص أمني',
    ],
  ),
  Course(
    title: 'أمن تطبيقات الويب',
    subtitle: 'تعرف على الثغرات الشائعة وطرق منعها',
    level: 'متوسط',
    duration: '6 دروس',
    icon: Icons.language,
    progress: 0.0,
    lessons: [
      'كيف يعمل تطبيق الويب؟',
      'التحقق من المدخلات',
      'مفهوم SQL Injection',
      'مفهوم XSS',
      'المصادقة وإدارة الجلسات',
      'طرق الوقاية والاختبار الآمن',
    ],
  ),
  Course(
    title: 'التقارير والمسار المهني',
    subtitle: 'حوّل نتائج التعلم إلى تقرير واضح',
    level: 'متقدم',
    duration: '4 دروس',
    icon: Icons.workspace_premium_outlined,
    progress: 0.0,
    lessons: [
      'كتابة تقرير ثغرة مسؤول',
      'تقييم الخطورة بصورة عامة',
      'اقتراح خطوات المعالجة',
      'مشروع التخرج',
    ],
  ),
];

// ==================== MAIN NAVIGATION ====================

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    CoursesPage(),
    LabPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: pages[selectedIndex],
        ),
        bottomNavigationBar: NavigationBar(
          height: 70,
          backgroundColor: const Color(0xFF0D130F),
          indicatorColor: matrixGreen.withOpacity(0.14),
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: matrixGreen),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book, color: matrixGreen),
              label: 'الدورات',
            ),
            NavigationDestination(
              icon: Icon(Icons.science_outlined),
              selectedIcon: Icon(Icons.science, color: matrixGreen),
              label: 'المختبر',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: matrixGreen),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== HOME PAGE ====================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
      children: [
        Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: matrixGreen.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: matrixGreen.withOpacity(0.45),
                ),
              ),
              child: const Icon(
                Icons.security,
                color: matrixGreen,
                size: 27,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '𝑬𝒅𝒎𝒂𝒏',
                    style: TextStyle(
                      color: matrixGreen,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'CYBER ACADEMY',
                    style: TextStyle(
                      color: muted,
                      fontSize: 10,
                      letterSpacing: 2.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                showAppMessage(context, 'الإشعارات قريباً');
              },
              icon: const Icon(
                Icons.notifications_none,
                color: muted,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Welcome Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF12351F),
                Color(0xFF0C1710),
                Color(0xFF101813),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            border: Border.all(
              color: matrixGreen.withOpacity(0.35),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: -8,
                top: -8,
                child: Icon(
                  Icons.memory,
                  size: 105,
                  color: matrixGreen.withOpacity(0.08),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'مستقبلك في الأمن يبدأ هنا',
                    style: TextStyle(
                      fontSize: 22,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'تعلّم، تدرب، واحمِ العالم الرقمي بمسؤولية.',
                    style: TextStyle(
                      color: Color(0xFFC1D0C5),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: matrixGreen,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          // تم إصلاح خطأ const هنا
                          builder: (_) => CourseDetailPage(
                            course: courses.first,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text(
                      'ابدأ التعلم',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        const SectionHeading(
          title: 'ملخص تقدمك',
          action: 'هذا الجهاز',
        ),

        const SizedBox(height: 12),

        Row(
          children: const [
            Expanded(
              child: StatCard(
                icon: Icons.menu_book,
                value: '6',
                label: 'دورات',
                color: matrixGreen,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: StatCard(
                icon: Icons.check_circle_outline,
                value: '0',
                label: 'دروس مكتملة',
                color: neonGreen,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: StatCard(
                icon: Icons.local_fire_department,
                value: '0',
                label: 'أيام متتالية',
                color: Color(0xFFFFB74D),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        const SectionHeading(
          title: 'ابدأ من هنا',
          action: 'عرض الكل',
        ),

        const SizedBox(height: 12),

        CourseTile(course: courses[0]),
        CourseTile(course: courses[1]),

        const SizedBox(height: 12),

        const SafetyNotice(),
      ],
    );
  }
}

// ==================== COURSES PAGE ====================

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const PageTitle(
          title: 'المسارات التعليمية',
          subtitle: 'اختر مسارك وتعلم خطوة بخطوة',
        ),
        const SizedBox(height: 18),
        ...courses.map(
          (course) => CourseTile(course: course),
        ),
        const SizedBox(height: 12),
        const SafetyNotice(),
      ],
    );
  }
}

// ==================== COURSE TILE ====================

class CourseTile extends StatelessWidget {
  final Course course;

  const CourseTile({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: panel,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.white.withOpacity(0.07),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CourseDetailPage(
                course: course,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: matrixGreen.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  course.icon,
                  color: matrixGreen,
                  size: 27,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      course.subtitle,
                      style: const TextStyle(
                        color: muted,
                        fontSize: 11,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        SmallTag(text: course.level),
                        const SizedBox(width: 7),
                        SmallTag(text: course.duration),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: course.progress,
                        minHeight: 5,
                        backgroundColor: Colors.white.withOpacity(0.08),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(
                          matrixGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_left,
                color: muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== COURSE DETAILS ====================

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          title: const Text('تفاصيل الدورة'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: panel,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: matrixGreen.withOpacity(0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    course.icon,
                    color: matrixGreen,
                    size: 38,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.subtitle,
                    style: const TextStyle(
                      color: muted,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      SmallTag(text: course.level),
                      const SizedBox(width: 8),
                      SmallTag(text: course.duration),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            const SectionHeading(
              title: 'محتويات الدورة',
            ),

            const SizedBox(height: 10),

            ...List.generate(
              course.lessons.length,
              (index) {
                return Card(
                  color: panel,
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 9),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: matrixGreen.withOpacity(0.12),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: matrixGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      course.lessons[index],
                      style: const TextStyle(fontSize: 13),
                    ),
                    trailing: const Icon(
                      Icons.lock_outline,
                      color: muted,
                      size: 18,
                    ),
                    onTap: () {
                      showAppMessage(
                        context,
                        'سيتم إضافة محتوى هذا الدرس في المرحلة القادمة',
                      );
                    },
                  ),
                );
              },
            ),

            const SafetyNotice(),
          ],
        ),
      ),
    );
  }
}

// ==================== LAB PAGE ====================

class LabPage extends StatelessWidget {
  const LabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const PageTitle(
          title: 'المختبر التدريبي',
          subtitle: 'تدريبات تعليمية آمنة داخل بيئة تجريبية',
        ),

        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: matrixGreen.withOpacity(0.25),
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.science_outlined,
                color: matrixGreen,
                size: 34,
              ),
              SizedBox(height: 12),
              Text(
                'مساحة التدريب قيد التجهيز',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'سنضيف تحديات لفهم الشبكات وتحليل سجلات تجريبية واكتشاف أخطاء تطبيقات تدريبية، دون استهداف أجهزة أو مواقع حقيقية.',
                style: TextStyle(
                  color: muted,
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        const LabChallenge(
          title: 'تحدي أساسيات الشبكات',
          description: 'تعرف على IP وDNS والمنافذ من خلال أسئلة تفاعلية.',
          icon: Icons.router,
        ),

        const LabChallenge(
          title: 'حلّل سجل دخول تجريبي',
          description: 'تعلم تمييز الأنشطة غير المعتادة في سجل افتراضي.',
          icon: Icons.receipt_long,
        ),

        const LabChallenge(
          title: 'اكتشف خطأ في صفحة تدريبية',
          description: 'تعرف على التحقق من المدخلات وطرق الحماية.',
          icon: Icons.bug_report_outlined,
        ),
      ],
    );
  }
}

// ==================== LAB CHALLENGE ====================

class LabChallenge extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const LabChallenge({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: panel,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: matrixGreen,
          size: 27,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            color: muted,
            fontSize: 12,
            height: 1.5,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_left,
          color: muted,
        ),
        onTap: () {
          showAppMessage(context, 'التحدي سيُتاح قريباً');
        },
      ),
    );
  }
}

// ==================== PROFILE PAGE ====================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const PageTitle(
          title: 'حسابي',
          subtitle: 'تابع تقدمك وإعدادات تجربتك التعليمية',
        ),

        const SizedBox(height: 22),

        Center(
          child: Container(
            height: 92,
            width: 92,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: matrixGreen.withOpacity(0.12),
              border: Border.all(
                color: matrixGreen.withOpacity(0.6),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person,
              color: matrixGreen,
              size: 48,
            ),
          ),
        ),

        const SizedBox(height: 12),

        const Center(
          child: Text(
            'متعلم جديد',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const Center(
          child: Text(
            'رحلتك في الأمن السيبراني تبدأ اليوم',
            style: TextStyle(
              color: muted,
              fontSize: 12,
            ),
          ),
        ),

        const SizedBox(height: 24),

        const ProfileOption(
          icon: Icons.emoji_events_outlined,
          title: 'إنجازاتي',
        ),

        const ProfileOption(
          icon: Icons.bookmark_border,
          title: 'الدروس المحفوظة',
        ),

        const ProfileOption(
          icon: Icons.settings_outlined,
          title: 'الإعدادات',
        ),

        const ProfileOption(
          icon: Icons.info_outline,
          title: 'عن Edman Cyber Academy',
        ),

        const SizedBox(height: 16),

        const SafetyNotice(),
      ],
    );
  }
}

// ==================== PROFILE OPTION ====================

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: panel,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 9),
      child: ListTile(
        leading: Icon(
          icon,
          color: matrixGreen,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: const Icon(
          Icons.chevron_left,
          color: muted,
        ),
        onTap: () {
          showAppMessage(context, 'سيتم تفعيل هذا القسم لاحقاً');
        },
      ),
    );
  }
}

// ==================== PAGE TITLE ====================

class PageTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const PageTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            color: muted,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

// ==================== SECTION HEADING ====================

class SectionHeading extends StatelessWidget {
  final String title;
  final String? action;

  const SectionHeading({
    super.key,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 4,
          decoration: BoxDecoration(
            color: matrixGreen,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (action != null)
          Text(
            action!,
            style: const TextStyle(
              color: muted,
              fontSize: 11,
            ),
          ),
      ],
    );
  }
}

// ==================== STAT CARD ====================

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 7,
      ),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.06),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 21,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: muted,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== SMALL TAG ====================

class SmallTag extends StatelessWidget {
  final String text;

  const SmallTag({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: matrixGreen.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: matrixGreen.withOpacity(0.22),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: matrixGreen,
          fontSize: 10,
        ),
      ),
    );
  }
}

// ==================== SAFETY NOTICE ====================

class SafetyNotice extends StatelessWidget {
  const SafetyNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF172016),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF547A43).withOpacity(0.45),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: matrixGreen,
            size: 21,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'تنبيه أخلاقي: جميع التدريبات مخصصة للتعلم داخل مختبرات تملكها أو لديك تصريح واضح لاختبارها. لا تختبر أنظمة الآخرين دون إذن.',
              style: TextStyle(
                color: Color(0xFFC4D0C5),
                fontSize: 11,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== APP MESSAGE ====================

void showAppMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textDirection: TextDirection.rtl,
      ),
      backgroundColor: const Color(0xFF1D3022),
      behavior: SnackBarBehavior.floating,
    ),
  );
}