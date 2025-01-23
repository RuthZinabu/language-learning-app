import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingContent(),
    );
  }
}

class OnboardingContent extends StatefulWidget {
  const OnboardingContent({super.key});

  @override
  _OnboardingContentState createState() => _OnboardingContentState();
}

class _OnboardingContentState extends State<OnboardingContent> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/img2.png",
      "title": "Confidence in your words",
      "subtitle":
          "With conversation-based learning, you'll be talking from lesson one.",
    },
    {
      "image": "assets/images/img3o.png",
      "title": "The lessons you need to learn",
      "subtitle": "Using a variety of learning styles to learn and retain.",
    },
    {
      "image": "assets/images/img4o.png",
      "title": "Track your progress",
      "subtitle": "Get better every day with detailed progress tracking.",
    },
  ];

  void _onNextPressed() {
    if (_currentPage == onboardingData.length - 1) {
      context.go('/login');
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return OnboardingSlide(
                image: onboardingData[index]["image"]!,
                title: onboardingData[index]["title"]!,
                subtitle: onboardingData[index]["subtitle"]!,
              );
            },
          ),
        ),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            onboardingData.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 8,
              width: _currentPage == index ? 20 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.deepPurple
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Next Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: _onNextPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              _currentPage == onboardingData.length - 1
                  ? "Get Started"
                  : "Next",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Log in Text
        TextButton(
          onPressed: () {
            context.go('/login');
          },
          child: const Text(
            "Already have an account? Log in",
            style: TextStyle(
                color: Colors.black, decoration: TextDecoration.underline),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class OnboardingSlide extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingSlide({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Image.asset(
            image,
            height: 250,
          ),
          const SizedBox(height: 30),
          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          // Subtitle
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
