import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediease/appointment_page.dart';
import 'profile_page.dart';
import 'login_page.dart';
import 'dart:math' as math;

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
      routes:{
        '/': (context) => const HomePage(),
        '/profile_page': (context) => const ProfilePage(),
        '/login_page': (context) => const LoginPage(),
        '/appointment_page': (context) => BookAppointmentPage(),
      },
        //home: const HomePage(),
      );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _scrollAnimationController;
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _scrollAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    
    _scrollController.addListener(() {
      setState(() {
        _scrollPosition = _scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    _scrollAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Navigation Bar with Slide-in Animation
            FadeTransition(
              opacity: CurvedAnimation(
                parent: _scrollAnimationController,
                curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _scrollAnimationController,
                  curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
                )),
                child: NavBar(),
              ),
            ),
            
            // Hero Section with Staggered Animation
            FadeTransition(
              opacity: CurvedAnimation(
                parent: _scrollAnimationController,
                curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _scrollAnimationController,
                  curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
                )),
                child: HeroSection(animationController: _scrollAnimationController),
              ),
            ),
            
            // Features Section with Scroll-triggered animations
            AnimatedBuilder(
              animation: _scrollController,
              builder: (context, child) {
                return FeaturesSection(scrollPosition: _scrollPosition);
              },
            ),
            
            // Footer
            Footer(),
          ],
        ),
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late AnimationController _hoverAnimationController;
  bool _isLoginHovered = false;
  bool _isGetStartedHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _hoverAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF660033),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo with pulse animation, now clickable
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/'); // Adjust route as needed
            },
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.95, end: 1.0),
              duration: const Duration(seconds: 2),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Text(
                'MediEase', // Now a link to the main page
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            children: [
              // Login Button with hover effect
              MouseRegion(
                onEnter: (_) => setState(() => _isLoginHovered = true),
                onExit: (_) => setState(() => _isLoginHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(_isLoginHovered ? 0.3 : 0.1),
                        spreadRadius: _isLoginHovered ? 2 : 1,
                        blurRadius: _isLoginHovered ? 15 : 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login_page');
                    },
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
              ),
              const SizedBox(width: 16),
              // Get Started button with hover animation
              MouseRegion(
                onEnter: (_) => setState(() => _isGetStartedHovered = true),
                onExit: (_) => setState(() => _isGetStartedHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: _isGetStartedHovered 
                      ? Matrix4.translationValues(0, -3, 0)
                      : Matrix4.identity(),
                  child: ElevatedButton(
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnimatedWavePainter extends CustomPainter {
  final bool reverse;
  final double animationValue;
  
  AnimatedWavePainter({this.reverse = false, required this.animationValue});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;
      
    final path = Path();
    
    if (reverse) {
      path.moveTo(0, size.height);
      
      for (int i = 0; i < 10; i++) {
        // Apply animation to the wave
        final waveHeight = size.height * 0.2 * (1 + math.sin(animationValue * math.pi * 2 + i * 0.3) * 0.1);
        
        path.cubicTo(
          size.width * (i / 10),
          size.height - (i % 2 == 0 ? waveHeight : 0),
          size.width * (i / 10 + 0.05),
          size.height - (i % 2 == 0 ? 0 : waveHeight),
          size.width * (i / 10 + 0.1),
          size.height - (i % 2 == 0 ? waveHeight : 0),
        );
      }
      
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(0, 0);
      
      for (int i = 0; i < 10; i++) {
        // Apply animation to the wave
        final waveHeight = size.height * 0.2 * (1 + math.sin(animationValue * math.pi * 2 + i * 0.3) * 0.1);
        
        path.cubicTo(
          size.width * (i / 10),
          (i % 2 == 0 ? waveHeight : 0),
          size.width * (i / 10 + 0.05),
          (i % 2 == 0 ? 0 : waveHeight),
          size.width * (i / 10 + 0.1),
          (i % 2 == 0 ? waveHeight : 0),
        );
      }
      
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    }
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class HeroSection extends StatefulWidget {
  final AnimationController animationController;
  
  const HeroSection({super.key, required this.animationController});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _waveAnimationController;
  bool _isCtaHovered = false;
  
  @override
  void initState() {
    super.initState();
    _waveAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }
  
  @override
  void dispose() {
    _waveAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF660033),
            Color(0xFF450022),
          ],
        ),
      ),
      child: Column(
        children: [
          // Animated wave pattern
          AnimatedBuilder(
            animation: _waveAnimationController,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(100, 20),
                painter: AnimatedWavePainter(
                  animationValue: _waveAnimationController.value,
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          
          // Staggered text animations
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: widget.animationController,
              curve: const Interval(0.4, 0.7, curve: Curves.easeOut),
            )),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: widget.animationController,
                curve: const Interval(0.4, 0.7, curve: Curves.easeOut),
              ),
              child: Text(
                'Fast. Simple. Easy.',
                style: GoogleFonts.poppins(
                  fontSize: 54,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Subheading with delayed animation
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: widget.animationController,
              curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
            )),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: widget.animationController,
                curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
              ),
              child: Text(
                'Seamless scheduling for healthcare professionals and patients.',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          const SizedBox(height: 40),
          
          // CTA Button with bounce animation
          ScaleTransition(
            scale: CurvedAnimation(
              parent: widget.animationController,
              curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
            ),
            child: MouseRegion(
              onEnter: (_) => setState(() => _isCtaHovered = true),
              onExit: (_) => setState(() => _isCtaHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: _isCtaHovered 
                    ? (Matrix4.identity()..scale(1.05))
                    : Matrix4.identity(),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login_page');
                  },
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
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Bottom animated wave pattern
          AnimatedBuilder(
            animation: _waveAnimationController,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(100, 20),
                painter: AnimatedWavePainter(
                  reverse: true,
                  animationValue: _waveAnimationController.value,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FeaturesSection extends StatelessWidget {
  final double scrollPosition;
  
  const FeaturesSection({super.key, required this.scrollPosition});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final triggerOffset = screenSize.height * 0.5;
    
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
              AnimatedFeatureCard(
                icon: Icons.calendar_month,
                title: 'Effortless Appointment Booking',
                description: 'Book appointments online with just a few clicks',
                imagePath: 'assets/booking.png',
                isVisible: scrollPosition > triggerOffset,
                delay: 0,
              ),
              AnimatedFeatureCard(
                icon: Icons.chat,
                title: 'Chat Directly with Your Doctor',
                description: 'Secure messaging with your healthcare provider',
                imagePath: 'assets/chat.png',
                isVisible: scrollPosition > triggerOffset,
                delay: 100,
              ),
              AnimatedFeatureCard(
                icon: Icons.notifications_active,
                title: 'Never Miss an Appointment',
                description: 'Reminders, updates and more for your healthcare needs',
                imagePath: 'assets/reminder.png',
                isVisible: scrollPosition > triggerOffset,
                delay: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnimatedFeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final String imagePath;
  final bool isVisible;
  final int delay;

  const AnimatedFeatureCard({super.key, 
    required this.icon,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isVisible,
    required this.delay,
  });

  @override
  State<AnimatedFeatureCard> createState() => _AnimatedFeatureCardState();
}

class _AnimatedFeatureCardState extends State<AnimatedFeatureCard> 
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: const Interval(0.4, 1.0),
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void didUpdateWidget(AnimatedFeatureCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isVisible && widget.isVisible) {
      // Add delay before starting the animation
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          _animationController.forward();
        }
      });
    } else if (oldWidget.isVisible && !widget.isVisible) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return MouseRegion(
    onEnter: (_) => setState(() => isHovered = true),
    onExit: (_) => setState(() => isHovered = false),
    child: SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
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
                  // Animated Icon
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: isHovered ? 1.0 : 0.5),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: isHovered ? value * 0.1 : 0,
                        child: Icon(
                          widget.icon,
                          size: 36 + (isHovered ? 4 : 0),
                          color: Color.lerp(
                            const Color(0xFF660033),
                            const Color(0xFF9E0059),
                            isHovered ? value : 0,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // Feature image with pulse animation when hovered
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 1.0, end: isHovered ? 1.03 : 1.0),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 180,
                            width: 250,
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Text(
                                'Image: ${widget.imagePath}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isHovered 
                          ? const Color(0xFF666666)
                          : Colors.grey.shade700,
                    ),
                    child: Text(
                      widget.description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      color: const Color(0xFF660033),  // Changed to match app theme
      child: Column(
        children: [
          // Add some content to make the footer more substantial
          Text(
            'MediEase',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final item in ['About', 'Services', 'Contact', 'Privacy Policy'])
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    item,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '© 2025 MediEase. All rights reserved.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}