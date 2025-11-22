import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:advanced_weather_app_03/core/themes/light_theme.dart';


Route<dynamic> errorRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (_) => Creative404Screen(routeName: settings.name ?? 'unknown'),
  );
}

class Creative404Screen extends StatefulWidget {
  final String routeName;

  const Creative404Screen({
    super.key,
    required this.routeName,
  });

  @override
  State<Creative404Screen> createState() => _Creative404ScreenState();
}

class _Creative404ScreenState extends State<Creative404Screen>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _rotateController;
  late AnimationController _fadeController;
  late AnimationController _floatController;

  late Animation<double> _bounceAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _floatAnimation;

  final List<String> _funMessages = [
    "Oops! This page went on vacation 🏖️",
    "Houston, we have a problem! 🚀",
    "This page is playing hide and seek 👻",
    "404: Page not found (but your sense of humor is!) 😄",
    "Looks like this page took a wrong turn 🗺️",
    "Page.exe has stopped working 💻",
    "This page is in another castle 🏰",
  ];

  late String _selectedMessage;

  @override
  void initState() {
    super.initState();

    _selectedMessage = _funMessages[math.Random().nextInt(_funMessages.length)];

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _rotateController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _rotateController,
      curve: Curves.linear,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _floatAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _bounceController.forward();
    _fadeController.forward();
    _rotateController.repeat();
    _floatController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rotateController.dispose();
    _fadeController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6366F1), // Indigo
              Color(0xFF8B5CF6), // Purple
              Color(0xFFEC4899), // Pink
              Color(0xFFEF4444), // Red
            ],
          ),
        ),
        child: Stack(
          children: [
            // Floating background elements
            ...List.generate(20, (index) => _buildFloatingElement(index)),

            // Main content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Custom App Bar
                    _buildCustomAppBar(context),

                    // Main 404 content
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Big 404 with animation
                              _build404Number(),

                              const SizedBox(height: 40),

                              // Fun message
                              _buildFunMessage(),

                              const SizedBox(height: 20),

                              // Route info
                              _buildRouteInfo(),

                              const SizedBox(height: 40),

                              // Action buttons
                              _buildActionButtons(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha:0.3),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Oops!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _build404Number() {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _bounceAnimation.value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glow effect
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha:0.3),
                      blurRadius: 60,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
              // 404 Text
              Text(
                '404',
                style: TextStyle(
                  fontSize: 120,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 20,
                      color: LightTheme.blackColors.withValues(alpha:0.3),
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
              ),
              // Rotating decoration
              AnimatedBuilder(
                animation: _rotateAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotateAnimation.value,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha:0.2),
                          width: 2,
                        ),
                      ),
                      child: const Stack(
                        children: [
                          Positioned(
                            top: 10,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: Icon(
                                Icons.circle,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: Icon(
                                Icons.diamond,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFunMessage() {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha:0.2),
                  width: 1,
                ),
              ),
              child: Text(
                _selectedMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRouteInfo() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: LightTheme.blackColors.withValues(alpha:0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha:0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.info_outline,
              color: Colors.white70,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              "Route '${widget.routeName}' not found",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          // Go Back Button
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            label: const Text(
              'Go Back',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha:0.2),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Colors.white.withValues(alpha:0.3),
                  width: 1,
                ),
              ),
              elevation: 0,
            ),
          ),

          const SizedBox(height: 16),

          // Try Again Button
          TextButton.icon(
            onPressed: () {
              // Refresh or try to navigate again
              setState(() {
                _selectedMessage =
                    _funMessages[math.Random().nextInt(_funMessages.length)];
              });
              _bounceController.reset();
              _bounceController.forward();
            },
            icon: const Icon(Icons.refresh, color: Colors.white70),
            label: const Text(
              'Try Again',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingElement(int index) {
    final random = math.Random(index);
    final size = 20.0 + random.nextDouble() * 40;
    final left = random.nextDouble() * MediaQuery.of(context).size.width;
    final top = random.nextDouble() * MediaQuery.of(context).size.height;
    final icons = [
      Icons.star,
      Icons.favorite,
      Icons.circle,
      Icons.diamond,
      Icons.hexagon,
      Icons.square,
    ];

    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final offset =
            math.sin((_floatController.value * 2 * math.pi) + (index * 0.5)) *
                30;
        return Positioned(
          left: left,
          top: top + offset,
          child: AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotateAnimation.value + (index * 0.3),
                child: Icon(
                  icons[index % icons.length],
                  size: size * 0.5,
                  color:
                      Colors.white.withValues(alpha:0.1 + random.nextDouble() * 0.2),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
