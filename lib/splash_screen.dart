import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'navigation_bar.dart';
import 'signup_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  bool _showLogo = true;
  double _logoOpacity = 0.0;
  double _logoScale = 0.8;

  final List<Map<String, String>> slides = [
    {
      "image": "assets/images/fashion1.jpg",
      "title": "Welcome to LuxaCart",
      "subtitle": "Discover premium fashion\njust for you",
      "button": "Get Started"
    },
    {
      "image": "assets/images/fashion2.jpg",
      "title": "Your Appearance\nShows Your Quality",
      "subtitle": "Change The Quality Of Your\nAppearance With LuxaCart Now!",
      "button": "Sign Up"
    },
    {
      "image": "assets/images/fashion3.jpg",
      "title": "Trendy Collections",
      "subtitle": "Stay ahead with modern fashion styles",
      "button": "Sign Up"
    },
  ];

  @override
  void initState() {
    super.initState();
    _animateLogo();
  }

  void _animateLogo() async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        _logoOpacity = 1.0;
        _logoScale = 1.0;
      });
    }

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _logoOpacity = 0.0;
      });
    }

    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      final authVM = Provider.of<AuthViewModel>(context, listen: false);
      if (authVM.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NavBarPage()),
        );
        return;
      }

      setState(() {
        _showLogo = false;
      });
      autoSlide();
    }
  }

  void autoSlide() {
    if (_controller.hasClients) {
      int nextPage = currentIndex + 1;

      if (nextPage >= slides.length) {
        nextPage = 0;
      }

      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      Future.delayed(const Duration(seconds: 3), autoSlide);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isDarkSlide() {
    return currentIndex == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// SLIDES
          AnimatedOpacity(
            opacity: _showLogo ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 800),
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: slides.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.asset(
                      slides[index]["image"]!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    );
                  },
                ),

                /// GRADIENT
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDarkSlide()
                          ? [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.6),
                              Colors.black,
                            ]
                          : [
                              Colors.transparent,
                              Colors.white.withValues(alpha: 0.9),
                            ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),

                /// TOP BAR
                Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentIndex != 0)
                        GestureDetector(
                          onTap: () {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: isDarkSlide() ? Colors.white : Colors.black,
                          ),
                        )
                      else
                        const SizedBox(),
                      const Text(
                        "LuxaCart",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: isDarkSlide() ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                /// BOTTOM CONTENT
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      Text(
                        slides[currentIndex]["title"]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDarkSlide() ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        slides[currentIndex]["subtitle"]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              isDarkSlide() ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (currentIndex == 0) {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isDarkSlide() ? Colors.white : Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            slides[currentIndex]["button"]!,
                            style: TextStyle(
                              color:
                                  isDarkSlide() ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// LOGIN LINK
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login here",
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
              ],
            ),
          ),

          /// LOGO
          if (_showLogo)
            Container(
              color: Colors.white,
              child: Center(
                child: AnimatedScale(
                  scale: _logoScale,
                  duration: const Duration(milliseconds: 1500),
                  child: AnimatedOpacity(
                    opacity: _logoOpacity,
                    duration: const Duration(milliseconds: 1000),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/app_logo.png",
                          width: 200,
                        ),
                        const SizedBox(height: 20),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
