import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_welding_calcullator/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController totalLengthController;
  late final TextEditingController weldingLengthController;
  late final TextEditingController weldingCountsController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    totalLengthController = TextEditingController();
    weldingLengthController = TextEditingController();
    weldingCountsController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    totalLengthController.dispose();
    weldingLengthController.dispose();
    weldingCountsController.dispose();
    super.dispose();
  }

  List<String> intervals = [];
  double gapLength = 0;

  void _calculatePoints() {
    setState(() {
      intervals.clear();

      double totalLength = double.parse(totalLengthController.text);
      double weldingLength = double.parse(weldingLengthController.text);
      double weldingCount = double.parse(weldingCountsController.text);

      gapLength =
          (totalLength - (weldingLength * weldingCount)) / (weldingCount - 1);
      double initialLength = 0;
      for (var i = 0; i < weldingCount; i++) {
        intervals.add(
            '${initialLength.toStringAsFixed(2)} ~ ${(initialLength + weldingLength).toStringAsFixed(2)}');
        initialLength = initialLength + weldingLength + gapLength;
      }
    });
  }

  @override
  Widget build(BuildContext orginalContext) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('간단 용접계산기'),
          centerTitle: true,
          actions: [
            ValueListenableBuilder(
              valueListenable: isDark,
              builder: (context, value, _) {
                return IconButton(
                  onPressed: () {
                    changeTheme();
                  },
                  icon: value
                      ? const Icon(Icons.sunny)
                      : const Icon(Icons.nightlight_round_outlined),
                );
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        controller: totalLengthController,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          hintText: '총 길이',
                          suffixText: 'mm',
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        controller: weldingLengthController,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          hintText: '용접 부위',
                          suffixText: 'mm',
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        controller: weldingCountsController,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          hintText: '용접 개수',
                          suffixText: '개',
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculatePoints();
                      if (gapLength < 0.0) {
                        showDialog(
                          context: orginalContext,
                          builder: (_) {
                            return const AlertDialog(
                              contentPadding: EdgeInsets.all(8),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('용접 길이가 총 길이를 넘어갑니다.'),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      showDialog(
                        context: orginalContext,
                        builder: (_) {
                          return const AlertDialog(
                            contentPadding: EdgeInsets.all(8),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('빈칸 없이 채워주세요'),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text('계산하기'),
                ),
                const SizedBox(height: 30),
                // if (intervals.isNotEmpty && gapLength >= 0)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (itemBuilderContext, index) {
                        final item = intervals[index];
                        return Builder(
                          builder: (context) {
                            return Text(
                              item,
                              // key: Key(item),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                        );
                      },
                      separatorBuilder: (context2, index) {
                        print('분리빌더');
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Divider(),
                            Text(
                              textAlign: TextAlign.center,
                              '+ ${gapLength.toStringAsFixed(2)}',
                              style: Theme.of(context2)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Divider(),
                          ],
                        );
                      },
                      itemCount: intervals.length,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
