// ignore_for_file: invalid_use_of_visible_for_testing_member,, invalid_use_of_protected_member
// invalid_use_of_protected_member, list_remove_unrelated_type

import 'dart:math';

import 'package:flutter/material.dart';

class DispatchChecker extends StatefulWidget {
  const DispatchChecker({super.key});

  @override
  State<DispatchChecker> createState() => _DispatchCheckerState();
}

class _DispatchCheckerState extends State<DispatchChecker> {
  final itemsList = List<String>.generate(11, (i) => "Item $i");
  bool isSelectedindex = false;

  List<Color> colors = [
    Colors.red[400]!,
    Colors.pink[400]!,
    Colors.purple[400]!,
    Colors.deepPurple[400]!,
    Colors.indigo[400]!,
    Colors.blue[400]!,
    Colors.lightBlue[400]!,
    Colors.cyan[400]!,
    Colors.green[400]!,
    Colors.lightGreen[400]!,
    Colors.yellow[400]!,
    Colors.amber[400]!,
    Colors.orange[400]!,
    Colors.deepOrange[400]!,
    Colors.brown[400]!,
    Colors.grey[400]!,
    Colors.blueGrey[400]!,
    Colors.orange[400]!,
  ];

  List? tempList;
  TextEditingController controller = TextEditingController();

  ValueNotifier<List>? itemsListNotifier;
  Random random = Random();
  Color? cardColor;
  bool isSearchCompleted = false;

  @override
  void initState() {
    super.initState();
    tempList = itemsList;
    cardColor = Colors.white;
    itemsListNotifier = ValueNotifier(itemsList);
    controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispatch Checker'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                if (controller.text != '') {
                  searchResult(value);
                }
                if (controller.text.isEmpty) {
                  setState(() {
                    isSearchCompleted = false;
                  });
                }
              },
              style: const TextStyle(),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: itemsListNotifier!,
              builder: (context, itemsList, child) => ListView.builder(
                itemCount: itemsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      color: (itemsList[index].contains('\u{2713}') &&
                              isSearchCompleted == true)
                          ? getRandomColor()
                          : cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          itemsList[index],
                          style: const TextStyle(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  bool searchResult(String query) {
    for (var i = 0; i < itemsList.length; i++) {
      if (query == itemsList[i]) {
        itemsList[i] = '${itemsList[i]}  \u{2713}';
        itemsListNotifier!.notifyListeners();
        setState(() {
          isSearchCompleted = true;
        });

        // controller.clear();
        debugPrint(itemsList.toString());
      }
      itemsList[i].replaceAll('\u{2713}', '');
      itemsListNotifier!.notifyListeners();
    }

    debugPrint(itemsList.toString());
    return false;
  }

  Color getRandomColor() {
    int choice = random.nextInt(colors.length);
    return colors[choice];
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    itemsListNotifier!.dispose();
  }
}
