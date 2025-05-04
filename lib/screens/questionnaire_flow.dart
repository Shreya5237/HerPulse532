import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

/// Main entry for the question flow
class QuestionnaireFlow extends StatefulWidget {
  const QuestionnaireFlow({Key? key}) : super(key: key);

  @override
  _QuestionnaireFlowState createState() => _QuestionnaireFlowState();
}

class _QuestionnaireFlowState extends State<QuestionnaireFlow>
    with SingleTickerProviderStateMixin {
  int age = 18;
  String? lifePhase;

  late final AnimationController _controller;
  late final Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _bounceAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateNext() {
    if (age >= 8 && age <= 13 && lifePhase == 'Puberty') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PubertyStep(age: age),
      ));
    } else if (age > 17 && lifePhase == 'Menstrual cycling') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MenstrualBasicsStep(),
      ));
    } else if (age >= 18 && age <= 40 && lifePhase == 'Pre-pregnancy') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PregnancyPlanningStep(),
      ));
    } else {
      // default next or end
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No further questions for this phase.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ScaleTransition(
              scale: _bounceAnimation,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: const EdgeInsets.all(24.0),
                  child: _buildAgeStep(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgeStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'How young (or wise) are you?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              '$age years',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          children: [
            Slider(
              min: 8,
              max: 60,
              divisions: 52,
              value: age.toDouble(),
              label: '$age',
              onChanged: (val) => setState(() => age = val.round()),
            ),
            const SizedBox(height: 24),
            OpenContainer(
              closedElevation: 0,
              openElevation: 4,
              transitionDuration: const Duration(milliseconds: 600),
              closedBuilder: (context, action) => ElevatedButton(
                onPressed: action,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                  shape: const StadiumBorder(),
                ),
                child: const Text('Next'),
              ),
              openBuilder: (context, action) => LifePhaseStep(
                initialAge: age,
                onPhaseSelected: (phase) {
                  lifePhase = phase;
                  Navigator.of(context).pop();
                  _navigateNext();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Life Phase Step
class LifePhaseStep extends StatefulWidget {
  final int initialAge;
  final void Function(String) onPhaseSelected;
  static const phases = [
    'Puberty',
    'Menstrual cycling',
    'Pre-pregnancy',
    'Pregnancy',
    'Post-pregnancy',
    'Menopause',
  ];

  const LifePhaseStep({required this.initialAge, required this.onPhaseSelected, Key? key}) : super(key: key);

  @override
  _LifePhaseStepState createState() => _LifePhaseStepState();
}

class _LifePhaseStepState extends State<LifePhaseStep> {
  String selected = LifePhaseStep.phases.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Which life phase best describes you?',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ...LifePhaseStep.phases.map((phase) => RadioListTile<String>(
                              title: Text(phase),
                              value: phase,
                              groupValue: selected,
                              onChanged: (val) {
                                if (val != null) setState(() => selected = val);
                              },
                            )),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => widget.onPhaseSelected(selected),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Next'),
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

/// Puberty Step (8-13)
class PubertyStep extends StatelessWidget {
  final int age;
  const PubertyStep({required this.age, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(child: Text('Puberty questions for age \$age here...')),
    );
  }
}

/// Menstrual Basics Step (>17)
class MenstrualBasicsStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(child: Text('Menstrual basics questions here...')),
    );
  }
}

/// Pregnancy Planning Step (18-40, Pre-pregnancy)
class PregnancyPlanningStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(child: Text('Pregnancy planning questions here...')),
    );
  }
}
