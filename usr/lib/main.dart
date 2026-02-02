import 'package:flutter/material.dart';

void main() {
  runApp(const FinancialFreedomApp());
}

class FinancialFreedomApp extends StatelessWidget {
  const FinancialFreedomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Freedom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Using a financial green theme
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF10B981)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LessonScreen(),
      },
    );
  }
}

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Content derived from the user's script
  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'The Struggle',
      'icon': Icons.warning_amber_rounded,
      'content': 'Most Americans work hard their entire life… but still struggle with money.\n\nIt’s not because they don’t earn enough. It’s because no one ever taught them how money actually works.',
      'highlight': 'In this lesson, we\'ll show you why most people never build wealth and what to do differently.',
    },
    {
      'title': 'The Reality',
      'icon': Icons.trending_down,
      'content': '• Over 60% of Americans live paycheck to paycheck\n• Credit card debt keeps rising\n• Most people retire late — or never\n\nWe’re taught to go to school and get a job, but not how to manage money, invest, or escape debt.',
      'highlight': 'People think this is normal. It is not.',
    },
    {
      'title': 'Mistake #1: No System',
      'icon': Icons.account_balance_wallet,
      'content': 'Money comes in… Money goes out… Whatever is left gets spent.\n\nWealthy people pay themselves first:\n1. Savings\n2. Investing\n3. Spending',
      'highlight': 'No system = No control.',
    },
    {
      'title': 'Mistake #2: Fear of Investing',
      'icon': Icons.show_chart,
      'content': 'Most think stocks are risky or they need lots of money.\n\nTruth: Not investing is the biggest risk because inflation eats your money.\n\nIndex funds, 401(k)s, and Roth IRAs have built more millionaires than any job.',
      'highlight': 'Time in the market beats timing the market.',
    },
    {
      'title': 'Mistake #3: Bad Debt',
      'icon': Icons.credit_card_off,
      'content': 'High-interest debt like credit cards and lifestyle inflation kills wealth.\n\nRule to remember:\n✔️ Assets put money in your pocket\n❌ Liabilities take money out',
      'highlight': 'Use money as a tool, not a toy.',
    },
    {
      'title': 'The Solution',
      'icon': Icons.lightbulb,
      'content': '1️⃣ Create a simple money system\n2️⃣ Start investing early\n3️⃣ Control debt before it controls you',
      'highlight': 'You don’t need to be rich to start. You need to start to become rich.',
    },
    {
      'title': 'Next Steps',
      'icon': Icons.rocket_launch,
      'content': 'If you want simple money rules, smart investing tips, and financial freedom, start today.',
      'highlight': 'Your future self will thank you.',
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            LinearProgressIndicator(
              value: (_currentPage + 1) / _pages.length,
              backgroundColor: Colors.grey[200],
              color: Theme.of(context).colorScheme.primary,
              minHeight: 6,
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Icon(
                          page['icon'],
                          size: 80,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          page['title'],
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          page['content'],
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            page['highlight'],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    TextButton.icon(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                    )
                  else
                    const SizedBox(width: 80), // Spacer to keep layout balanced
                  
                  ElevatedButton(
                    onPressed: _currentPage == _pages.length - 1 ? () {
                      // Restart or finish action
                      _pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    } : _nextPage,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 2,
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'Restart' : 'Next',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
