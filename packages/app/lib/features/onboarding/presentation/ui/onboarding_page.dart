import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int _currentPage = 0;
  final steps = [
    const StepContent(
      currentStep: 1,
      title: 'Create a space and invite your partner',
      description:
          'Within a space, you can create and manage bank accounts, credit cards, transactions, and more.',
    ),
    // StepContent(
    //   currentStep: _currentPage + 1,
    //   title: 'Set up your accounts',
    //   description:
    //       'Add your bank accounts and credit cards to keep track of your finances.',
    // ),
    const StepContent(
      currentStep: 2,
      title: 'Start budgeting',
      description:
          'Create a budget and track your expenses to reach your financial goals.',
    ),
  ];
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  void _nextPage() {
    if (_currentPage == steps.length - 1) {
      context.push('${OBRoutes.onboarding}/${OBRoutes.createSpace}');
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (_currentPage == 0) {
              context.go(OBRoutes.intro);
            } else {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          icon: const Icon(Icons.chevron_left, size: 30),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: steps,
      ),
      bottomNavigationBar: _BottomWidget(
        currentPage: _currentPage,
        totalPages: steps.length,
        nextPage: _nextPage,
      ),
    );
  }
}

class StepContent extends StatelessWidget {
  const StepContent({
    required this.title,
    required this.description,
    required this.currentStep,
    super.key,
  });
  final String title;
  final String description;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Text(
                    'Step $currentStep',
                    style: theme.textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    description,
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _BottomWidget extends StatelessWidget {
  const _BottomWidget({
    required this.currentPage,
    required this.nextPage,
    required this.totalPages,
  });

  final int currentPage;
  final int totalPages;
  final VoidCallback nextPage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                ...List.generate(
                  totalPages,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.all(4),
                    width: currentPage == index ? 20 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: currentPage == index
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primary.withOpacity(0.3),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: nextPage,
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
