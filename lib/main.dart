import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MediEaseApp());
}

class MediEaseApp extends StatelessWidget {
  const MediEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediEase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF660033),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF660033),
          primary: const Color(0xFF660033),
          secondary: const Color(0xFF9E0059),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation Bar
            NavBar(),
            
            // Hero Section with Gradient Background and Wave Pattern
            HeroSection(),
            
            // Features Section
            FeaturesSection(),
            
            // Footer
            Footer(),
          ],
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF660033),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'MediEase',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              // Login Button with glow effect
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.white),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('LOGIN'),
                ),
              ),
              const SizedBox(width: 16),
              // Get Started button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF660033),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('GET STARTED', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF660033),
            const Color(0xFF450022),
          ],
        ),
      ),
      child: Column(
        children: [
          // Custom wave pattern
          CustomPaint(
            size: const Size(100, 20),
            painter: WavePainter(),
          ),
          const SizedBox(height: 30),
          
          // Main headline
          Text(
            'Fast. Simple. Easy.',
            style: GoogleFonts.poppins(
              fontSize: 54,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Subheading
          Text(
            'Seamless scheduling for healthcare professionals and patients.',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 40),
          
          // CTA Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF660033),
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Schedule Your First Appointment Today',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Bottom wave pattern
          CustomPaint(
            size: const Size(100, 20),
            painter: WavePainter(reverse: true),
          ),
        ],
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final bool reverse;
  
  WavePainter({this.reverse = false});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;
      
    final path = Path();
    
    if (reverse) {
      path.moveTo(0, size.height);
      
      for (int i = 0; i < 10; i++) {
        path.cubicTo(
          size.width * (i / 10),
          size.height - (i % 2 == 0 ? size.height * 0.2 : 0),
          size.width * (i / 10 + 0.05),
          size.height - (i % 2 == 0 ? 0 : size.height * 0.2),
          size.width * (i / 10 + 0.1),
          size.height - (i % 2 == 0 ? size.height * 0.2 : 0),
        );
      }
      
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(0, 0);
      
      for (int i = 0; i < 10; i++) {
        path.cubicTo(
          size.width * (i / 10),
          (i % 2 == 0 ? size.height * 0.2 : 0),
          size.width * (i / 10 + 0.05),
          (i % 2 == 0 ? 0 : size.height * 0.2),
          size.width * (i / 10 + 0.1),
          (i % 2 == 0 ? size.height * 0.2 : 0),
        );
      }
      
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    }
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive layout adjustment
    final isMobile = screenWidth < 800;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: Colors.white,
      child: Column(
        children: [
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              FeatureCard(
                icon: Icons.calendar_month,
                title: 'Effortless Appointment Booking',
                description: 'Book appointments online with just a few clicks',
                imagePath: 'assets/booking.png',
              ),
              FeatureCard(
                icon: Icons.chat,
                title: 'Chat Directly with Your Doctor',
                description: 'Secure messaging with your healthcare provider',
                imagePath: 'assets/chat.png',
              ),
              FeatureCard(
                icon: Icons.notifications_active,
                title: 'Never Miss an Appointment',
                description: 'Reminders, updates and more for your healthcare needs',
                imagePath: 'assets/reminder.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final String imagePath;

  const FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  bool isHovered = false;

  @override
Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 300,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.1 : 0.05),
              blurRadius: isHovered ? 10 : 5,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Transform(
          transform: isHovered ? Matrix4.translationValues(0, -5, 0) : Matrix4.identity(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon
              Icon(
                widget.icon,
                size: 36,
                color: const Color(0xFF660033),
              ),
              const SizedBox(height: 20),
              
              // Feature image placeholder
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 180,
                  width: 250,
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Text(
                      'Image: ${widget.imagePath}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Title
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: const Color(0xFF333333),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              
              // Description
              Text(
                widget.description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      color: const Color(0xFFF5F5F5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© 2025 MediEase. All rights reserved.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}