import 'package:development/constants.dart';
import 'package:development/widgets/info_button.dart';
import 'package:development/widgets/length_bar.dart';
import 'package:development/widgets/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final startDate = DateTime(2022, 5);
  final endDate = DateTime(2023, 10, 31);

  final dateFormat = DateFormat.yMMMMd('de_DE');

  final colors = [
    Colors.pink.shade100,
    Colors.purple.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
    Colors.orange.shade100,
    Colors.red.shade100,
  ];

  int selectedColorIndex = 0;

  Color get selectedColor => colors[selectedColorIndex];

  double get progress {
    return (DateTime.now().difference(startDate).inDays / endDate.difference(startDate).inDays).clamp(0, 1);
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      selectedColorIndex = prefs.getInt(PrefKeys.selectedColorIndex) ?? 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
        openDialog();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 8,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (selectedColorIndex >= colors.length - 1) {
                        selectedColorIndex = 0;
                      } else {
                        selectedColorIndex += 1;
                      }
                      setState(() {});
                      SharedPreferences.getInstance().then((prefs) {
                        prefs.setInt(PrefKeys.selectedColorIndex, selectedColorIndex);
                      });
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: selectedColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color.lerp(selectedColor, Colors.black, .2)!,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  InfoIcon(
                    endDate: endDate,
                    onTap: openDialog,
                  ),
                ],
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final maxHeight = constraints.maxHeight - 48;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Start:', style: Theme.of(context).textTheme.bodyText1),
                                Text(dateFormat.format(startDate), style: Theme.of(context).textTheme.headline1),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Ziel:', style: Theme.of(context).textTheme.bodyText1),
                                Text(dateFormat.format(endDate), style: Theme.of(context).textTheme.headline1),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 32,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const LengthBar(),
                          Positioned(
                            top: 0,
                            child: ProgressBar(
                              maxHeight: maxHeight,
                              progress: progress,
                              color: selectedColor,
                            ),
                          ),
                          // create a round container
                          Positioned(
                            top: maxHeight * progress,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: selectedColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color.lerp(selectedColor, Colors.black, .2)!,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: FittedBox(
                                child: Text(
                                  '${(progress * 100).round()}%',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: Color.lerp(selectedColor, Colors.black, .5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            top: (maxHeight * progress) - 4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Heute:', style: Theme.of(context).textTheme.bodyText1),
                                Text(dateFormat.format(DateTime.now()), style: Theme.of(context).textTheme.headline1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void openDialog() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('️❤️🎉 Weiter so!  🎉️❤️'),
          content: Text(
            'Nur noch ${(endDate.difference(DateTime.now()).inDays / 7).ceil()} Wochen bis zum Ziel!'
            '\n \nDu bist toll! '
            'Die letzten Meter schaffst du auch noch!',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Ja!'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
