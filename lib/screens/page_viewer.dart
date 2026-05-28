import 'package:flutter/material.dart';
import 'get_started.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController controller = PageController();
  int pageIndex = 0;

  final Color primary = const Color(0xFFF06292);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDE4EC),
              Color(0xFFF8BBD0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              /// SKIP BUTTON
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    controller.jumpToPage(1);
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),

              ///  PAGE VIEW
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() => pageIndex = index);
                  },
                  children: [
                    buildPage(
                      image: "assets/images/fashion1.jpg",
                      title: "Welcome to LuxaCart",
                      subtitle:
                          "Discover trendy outfits and elevate your fashion style.",
                    ),
                    buildPage(
                      image: "assets/images/fashion2.jpg",
                      title: "Shop Your Style",
                      subtitle:
                          "Find the best collections for every occasion.",
                    ),
                  ],
                ),
              ),

              /// 🔘 INDICATOR + BUTTON
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    /// 🔹 DOT INDICATOR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(2, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: pageIndex == index ? 25 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: pageIndex == index
                                ? primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 25),

                    /// 🔥 BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          if (pageIndex == 0) {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const GetStarted(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          pageIndex == 0 ? "Next" : "Get Started",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// SINGLE PAGE DESIGN (CARD STYLE LIKE IMAGE)
  Widget buildPage({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// 🖼 IMAGE CARD
          Container(
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                )
              ],
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// 📝 TITLE
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          /// SUBTITLE
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
