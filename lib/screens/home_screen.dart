// ignore_for_file: unnecessary_null_comparison
import 'dart:io';
import 'package:dispatch_checker/screens/despatch_checker.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  FilePickerResult? result;
  List sheetList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dispatch Checker'),
        ),
        body: (MediaQuery.of(context).size.width < 640)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        getFilepath();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                        ),
                      ),
                      child: const Text('Create Packing Sheet'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                      ),
                      child: const Text('Print Barcode'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(createRoute());
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      child: const Text('Dispatch Checker'),
                    )
                  ],
                ),
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        filePicker();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                        ),
                      ),
                      child: const Text('Create Packing Sheet'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                      ),
                      child: const Text('Print Barcode'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(createRoute());
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      child: const Text('Dispatch Checker'),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  // getFilepath() async {
  //   result = await FilePicker.platform.pickFiles(allowedExtensions: ['xlsx']);
  //   debugPrint(result.toString());
  //   if (result != null) {
  //     for (var element in result!.files) {
  //       debugPrint(element.path);
  //       var file = element.path;
  //       var bytes = File(file!).readAsBytesSync();
  //       var excel = Excel.decodeBytes(bytes);
  //       for (var table in excel.tables.keys) {
  //         debugPrint(table);
  //         for (var row in excel.tables[table]!.rows) {
  //           debugPrint(row.toString());
  //         }
  //       }
  //     }
  //   } else {
  //     debugPrint('file not selected');
  //   }
  // }

  getFilepath() async {
    result = await FilePicker.platform
        .pickFiles(allowMultiple: true, allowedExtensions: ['xlsx','pdf','jpg']);
    if (result != null) {
      for (var element in result!. files) {
        debugPrint(element.path);
        var file = element.path;
        var bytes = File(file!).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);
        for (var table in excel.tables.keys) {
          debugPrint(table);
          for (var row in excel.tables[table]!.rows) {
            debugPrint(row.toString());
          }
        }
      }
    } else {
      debugPrint('file not selected');
    }
  }

  filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      print('No file selected');
    }
  }

  Route createRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 1),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const DispatchChecker(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1, -1);
        const end = Offset.zero;
        var curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
