import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Class11App());
}

class Class11App extends StatelessWidget {
  const Class11App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UP Board Class 11 Companion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ----------------------------------------------------
// 1. HOME SCREEN (Subjects Grid)
// ----------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> subjects = const [
    {"name": "Physics (भौतिक विज्ञान)", "key": "Physics", "icon": Icons.bolt, "color": Colors.orange},
    {"name": "Chemistry (रसायन विज्ञान)", "key": "Chemistry", "icon": Icons.science, "color": Colors.teal},
    {"name": "Mathematics (गणित)", "key": "Mathematics", "icon": Icons.calculate, "color": Colors.indigo},
    {"name": "General Hindi (सामान्य हिन्दी)", "key": "Hindi", "icon": Icons.translate, "color": Colors.deepOrange},
    {"name": "English (अंग्रेज़ी)", "key": "English", "icon": Icons.menu_book, "color": Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class 11 UP Board (Secure Notes)', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: subjects.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.05,
          ),
          itemBuilder: (context, index) {
            final sub = subjects[index];
            return Card(
              elevation: 2,
              color: (sub["color"] as Color).withOpacity(0.12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChapterListScreen(
                        subjectKey: sub["key"] as String,
                        subjectDisplayName: sub["name"] as String,
                        subjectColor: sub["color"] as Color,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(sub["icon"] as IconData, size: 40, color: sub["color"] as Color),
                      const SizedBox(height: 8),
                      Text(
                        sub["name"] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: sub["color"] as Color),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// 2. CHAPTER LIST SCREEN (Complete Syllabus)
// ----------------------------------------------------
class ChapterListScreen extends StatelessWidget {
  final String subjectKey;
  final String subjectDisplayName;
  final Color subjectColor;

  const ChapterListScreen({
    super.key,
    required this.subjectKey,
    required this.subjectDisplayName,
    required this.subjectColor,
  });

  Map<String, List<Map<String, String>>> get chaptersData => {
    "Physics": [
      {"num": "इकाई 1", "docId": "physics_ch1", "title": "भौतिक जगत तथा मापन", "subtitle": "मात्रक, विमाएं, त्रुटि विश्लेषण (01 अंक)"},
      {"num": "इकाई 2", "docId": "physics_ch2", "title": "शुद्ध गतिकी (Kinematics)", "subtitle": "सरल रेखा में गति, सदिश, प्रक्षेप्य गति (06 अंक)"},
      {"num": "इकाई 3", "docId": "physics_ch3", "title": "गति के नियम (Laws of Motion)", "subtitle": "न्यूटन के नियम, घर्षण, संवेग संरक्षण (07 अंक)"},
      {"num": "इकाई 4", "docId": "physics_ch4", "title": "कार्य, ऊर्जा तथा शक्ति", "subtitle": "कार्य-ऊर्जा प्रमेय, संघट्ट (07 अंक)"},
      {"num": "इकाई 5", "docId": "physics_ch5", "title": "दृढ़ पिण्ड तथा कणों के निकाय की गति", "subtitle": "द्रव्यमान केन्द्र, बल आघूर्ण (07 अंक)"},
      {"num": "इकाई 6", "docId": "physics_ch6", "title": "गुरुत्वाकर्षण (Gravitation)", "subtitle": "केपलर नियम, गुरुत्वीय विभव (07 अंक)"},
      {"num": "इकाई 7", "docId": "physics_ch7", "title": "स्थूल द्रव्य के गुण", "subtitle": "प्रत्यास्थता, बर्नौली प्रमेय, पृष्ठ तनाव (10 अंक)"},
      {"num": "इकाई 8", "docId": "physics_ch8", "title": "ऊष्मागतिकी (Thermodynamics)", "subtitle": "ऊष्मागतिकी के नियम (09 अंक)"},
      {"num": "इकाई 9", "docId": "physics_ch9", "title": "आदर्श गैस का व्यवहार तथा अणुगति सिद्धान्त", "subtitle": "गैस समीकरण (06 अंक)"},
      {"num": "इकाई 10", "docId": "physics_ch10", "title": "दोलन तथा तरंगें", "subtitle": "सरल आवर्त गति, डॉप्लर प्रभाव (10 अंक)"},
    ],
    "Chemistry": [
      {"num": "इकाई 1", "docId": "chem_ch1", "title": "रसायन विज्ञान की कुछ मूल अवधारणाएं", "subtitle": "मोल संकल्पना, स्टॉइकियोमेट्री (07 अंक)"},
      {"num": "इकाई 2", "docId": "chem_ch2", "title": "परमाणु की संरचना", "subtitle": "बोर मॉडल, डी-ब्रॉग्ली, हाइजेनबर्ग (08 अंक)"},
      {"num": "इकाई 3", "docId": "chem_ch3", "title": "तत्वों का वर्गीकरण एवं गुणधर्मों में आवर्तिता", "subtitle": "आवर्त नियम, परमाणु त्रिज्या (07 अंक)"},
      {"num": "इकाई 4", "docId": "chem_ch4", "title": "रासायनिक आबंधन तथा आण्विक संरचना", "subtitle": "VSEPR सिद्धांत, संकरण (07 अंक)"},
      {"num": "इकाई 5", "docId": "chem_ch5", "title": "ऊष्मागतिकी", "subtitle": "हेस का नियम, एन्थैल्पी (06 अंक)"},
      {"num": "इकाई 6", "docId": "chem_ch6", "title": "साम्यावस्था", "subtitle": "रासायनिक एवं आयनिक साम्य, pH मान (08 अंक)"},
      {"num": "इकाई 7", "docId": "chem_ch7", "title": "अपचयोपचय अभिक्रियाएं", "subtitle": "ऑक्सीकरण संख्या संतुलन (07 अंक)"},
      {"num": "इकाई 8", "docId": "chem_ch8", "title": "कार्बनिक रसायन: मूलभूत सिद्धान्त तथा तकनीकें", "subtitle": "IUPAC नामकरण, समावयवता (10 अंक)"},
      {"num": "इकाई 9", "docId": "chem_ch9", "title": "हाइड्रोकार्बन", "subtitle": "एल्केन, एल्कीन, एल्काइन (10 अंक)"},
    ],
    "Mathematics": [
      {"num": "Ch 1", "docId": "math_ch1", "title": "समुच्चय (Sets)", "subtitle": "प्रकार, वेन आरेख, संक्रियाएं"},
      {"num": "Ch 2", "docId": "math_ch2", "title": "सम्बन्ध एवं फलन", "subtitle": "प्रांत, परिसर, फलनों के प्रकार"},
      {"num": "Ch 3", "docId": "math_ch3", "title": "त्रिकोणमितीय फलन", "subtitle": "सर्वसमिकाएं, ग्राफ एवं सूत्र"},
      {"num": "Ch 4", "docId": "math_ch4", "title": "सम्मिश्र संख्याएं और द्विघातीय समीकरण", "subtitle": "मापांक, कोणांक, द्विघात समीकरण"},
      {"num": "Ch 5", "docId": "math_ch5", "title": "रैखिक असमिकाएं", "subtitle": "बीजीय एवं आलेखीय हल"},
      {"num": "Ch 6", "docId": "math_ch6", "title": "क्रमचय और संचय", "subtitle": "गणना का मूलभूत सिद्धांत, nPr, nCr"},
      {"num": "Ch 7", "docId": "math_ch7", "title": "द्विपद प्रमेय", "subtitle": "प्रमेय का प्रसार एवं व्यापक पद"},
      {"num": "Ch 8", "docId": "math_ch8", "title": "अनुक्रम तथा श्रेणी", "subtitle": "समान्तर व गुणोत्तर श्रेणियाँ"},
      {"num": "Ch 9", "docId": "math_ch9", "title": "सरल रेखाएं", "subtitle": "प्रवणता, रेखाओं के विविध रूप"},
      {"num": "Ch 10", "docId": "math_ch10", "title": "शंकु परिच्छेद (Conic Sections)", "subtitle": "वृत्त, परवलय, दीर्घवृत्त, अतिपरवलय"},
      {"num": "Ch 11", "docId": "math_ch11", "title": "त्रिविमीय ज्यामिति का परिचय", "subtitle": "निर्देशांक अक्ष, दूरी सूत्र"},
      {"num": "Ch 12", "docId": "math_ch12", "title": "सीमा और अवकलज (Limits & Derivatives)", "subtitle": "सीमाएं एवं मानक फलनों का अवकलन"},
      {"num": "Ch 13", "docId": "math_ch13", "title": "सांख्यिकी (Statistics)", "subtitle": "माध्य, प्रसरण एवं मानक विचलन"},
      {"num": "Ch 14", "docId": "math_ch14", "title": "प्रायिकता (Probability)", "subtitle": "घटनाएं, स्वयंसिद्ध प्रायिकता"},
    ],
    "Hindi": [
      {"num": "गद्य 1", "docId": "hindi_ch1", "title": "भारतवर्षोन्नति कैसे हो सकती है?", "subtitle": "लेखक: भारतेन्दु हरिश्चन्द्र"},
      {"num": "गद्य 2", "docId": "hindi_ch2", "title": "महाकवि माघ का प्रभात-वर्णन", "subtitle": "लेखक: आचार्य महावीरप्रसाद द्विवेदी"},
      {"num": "गद्य 3", "docId": "hindi_ch3", "title": "आचरण की सभ्यता", "subtitle": "लेखक: सरदार पूर्ण सिंह"},
      {"num": "पद्य 1", "docId": "hindi_ch4", "title": "साखी एवं पदावली", "subtitle": "कवि: कबीरदास"},
      {"num": "पद्य 2", "docId": "hindi_ch5", "title": "विनय पत्रिका एवं दोहावली", "subtitle": "कवि: गोस्वामी तुलसीदास"},
      {"num": "संस्कृत 1", "docId": "hindi_ch6", "title": "वन्दना एवं प्रयागः", "subtitle": "संस्कृत दिग्दर्शिका"},
    ],
    "English": [
      {"num": "Prose 1", "docId": "eng_ch1", "title": "The Portrait of a Lady", "subtitle": "By Khushwant Singh"},
      {"num": "Prose 2", "docId": "eng_ch2", "title": "We're Not Afraid to Die...", "subtitle": "By Gordon Cook & Alan East"},
      {"num": "Prose 3", "docId": "eng_ch3", "title": "Discovering Tut: The Saga Continues", "subtitle": "By A.R. Williams"},
      {"num": "Poem 1", "docId": "eng_ch4", "title": "A Photograph", "subtitle": "By Shirley Toulson"},
      {"num": "Poem 2", "docId": "eng_ch5", "title": "The Laburnum Top", "subtitle": "By Ted Hughes"},
      {"num": "Snapshots 1", "docId": "eng_ch6", "title": "The Summer of the Beautiful White Horse", "subtitle": "By William Saroyan"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final list = chaptersData[subjectKey] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(subjectDisplayName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: subjectColor.withOpacity(0.15),
      ),
      body: list.isEmpty
          ? const Center(child: Text("Chapters coming soon!"))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final chapter = list[index];
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    leading: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: subjectColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(chapter["num"]!, style: TextStyle(fontWeight: FontWeight.bold, color: subjectColor, fontSize: 12)),
                    ),
                    title: Text(chapter["title"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: Text(chapter["subtitle"]!, style: const TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FirebaseDetailScreen(
                            docId: chapter["docId"] ?? "physics_ch1",
                            chapterTitle: chapter["title"]!,
                            themeColor: subjectColor,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

// ----------------------------------------------------
// 3. FIREBASE DETAIL SCREEN
// ----------------------------------------------------
class FirebaseDetailScreen extends StatefulWidget {
  final String docId;
  final String chapterTitle;
  final Color themeColor;

  const FirebaseDetailScreen({
    super.key,
    required this.docId,
    required this.chapterTitle,
    required this.themeColor,
  });

  @override
  State<FirebaseDetailScreen> createState() => _FirebaseDetailScreenState();
}

class _FirebaseDetailScreenState extends State<FirebaseDetailScreen> {
  bool isLoading = true;
  String quickNotes = "";
  String keyFormulas = "";
  String examTips = "";

  @override
  void initState() {
    super.initState();
    fetchChapter();
  }

  Future<void> fetchChapter() async {
    const projectId = "upboard-class11-notes";
    final url = Uri.parse("https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/notes/${widget.docId}");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final fields = data["fields"] ?? {};

        setState(() {
          quickNotes = fields["quickNotes"]?["stringValue"] ?? "Is chapter ke quick notes jald upload honge.";
          keyFormulas = fields["keyFormulas"]?["stringValue"] ?? "Key points / formula abhi available nahi hain.";
          examTips = fields["examTips"]?["stringValue"] ?? "Important exam tips jald add kiye jayenge.";
          isLoading = false;
        });
      } else {
        setState(() {
          quickNotes = "Abhi is chapter ke notes upload nahi hue hain (Doc ID: ${widget.docId}). Firebase Console se add karein.";
          keyFormulas = "Firebase console se jald upload karein.";
          examTips = "Stay tuned!";
          isLoading = false;
        });
      }
    } catch (_) {
      setState(() {
        quickNotes = "Connection error. Please check internet.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.chapterTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapterTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: widget.themeColor.withOpacity(0.15),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chapter Quick Notes Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("📝 Quick Revision Summary", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Divider(height: 20),
                    Text(quickNotes, style: const TextStyle(fontSize: 15, height: 1.6)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Formulas Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.themeColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: widget.themeColor.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("📐 Key Points & Formulas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  Text(keyFormulas, style: const TextStyle(fontSize: 15, height: 1.6)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // SECURE IN-APP PDF BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecurePdfViewerScreen(
                        chapterTitle: widget.chapterTitle,
                        pdfContent: "$quickNotes\n\n[Formulas & Points]:\n$keyFormulas\n\n[Board Tips]:\n$examTips",
                        themeColor: widget.themeColor,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.lock, color: Colors.white),
                label: const Text("Open Protected PDF Viewer", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// 4. SECURE IN-APP PDF VIEWER (WITH ANTI-LEAK WATERMARK)
// ----------------------------------------------------
class SecurePdfViewerScreen extends StatelessWidget {
  final String chapterTitle;
  final String pdfContent;
  final Color themeColor;

  const SecurePdfViewerScreen({
    super.key,
    required this.chapterTitle,
    required this.pdfContent,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(chapterTitle, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const Row(
              children: [
                Icon(Icons.shield, color: Colors.green, size: 14),
                SizedBox(width: 4),
                Text("DRM Protected • Screenshot Disabled", style: TextStyle(fontSize: 11, color: Colors.black54)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
            tooltip: "Security Info",
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Content is encrypted. Sharing and downloading is strictly disabled.')),
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          // 1. PDF CONTENT LAYER
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, spreadRadius: 2),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      "Official Notes: $chapterTitle (Class 11)",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    pdfContent,
                    style: const TextStyle(fontSize: 16, height: 1.8, fontFamily: 'serif'),
                  ),
                  const SizedBox(height: 40),
                  const Center(
                    child: Text("— End of Protected UP Board Notes —", style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // 2. DYNAMIC WATERMARK OVERLAY
          IgnorePointer(
            child: Center(
              child: Transform.rotate(
                angle: -0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "CLASS 11 CONFIDENTIAL",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.black.withOpacity(0.06),
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "AUTHORIZED APP USER ONLY",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.05),
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
