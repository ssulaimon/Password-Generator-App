// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutterleaner/colors.dart';
import 'package:flutterleaner/db/db_service.dart';
import 'package:flutterleaner/logics/backup_validator.dart';
import 'package:flutterleaner/model/password_model.dart';
import 'package:flutterleaner/screens/info.dart';
import 'package:flutterleaner/screens/settings.dart';
import 'package:flutterleaner/widgets/action_widget.dart';
import 'package:flutterleaner/widgets/my_drawer.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> generatedPasswords = [];
  bool addNumber = false;
  bool addCharacter = false;

  void addNumberToPassword({required bool value}) {
    setState(() {
      addNumber = value;
    });
  }

  void addCharacterToPassword({required bool value}) {
    setState(() {
      addCharacter = value;
    });
  }

  String makePassword() {
    const List<String> upperCaseAlpha = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    const List<String> lowerCase = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z',
    ];
    List<String> characters = [
      '@',
      "#",
      '\$',
    ];
    List<String> numbers = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
    ];
    String password = '';

    for (int i = 0; i < 8; i++) {
      //Checks if the character and number switch is activated
      if (addCharacter == true && addNumber == true) {
        switch (i) {
          //At index of 3 a character is added to the list of password
          case 3:
            int selectCharacter = Random().nextInt(3);
            password += characters[selectCharacter];
            break;

          case 6:
            //At index of 6 a Number is added  to the list of password
            int selectNumber = Random().nextInt(9);
            password += numbers[selectNumber];
            break;
          default:
            int selectedCase = Random().nextInt(2);
            int selectedLetter = Random().nextInt(26);

            if (selectedCase == 0) {
              password += upperCaseAlpha[selectedLetter];
            } else {
              password += lowerCase[selectedLetter];
            }
            break;
        }
      } else if (addCharacter == true) {
        // this block of function run only if character is switch is activated
        switch (i) {
          case 5:
            int selectCharacter = Random().nextInt(3);
            password += characters[selectCharacter];
            break;
          default:
            int selectedCase = Random().nextInt(2);
            int selectedLetter = Random().nextInt(26);

            if (selectedCase == 0) {
              password += upperCaseAlpha[selectedLetter];
            } else {
              password += lowerCase[selectedLetter];
            }
            break;
        }
      } else if (addNumber == true) {
        // this block is run if number switch is activated
        switch (i) {
          case 5:
            int selectNumber = Random().nextInt(9);
            password += numbers[selectNumber];
            break;
          default:
            int selectedCase = Random().nextInt(2);
            int selectedLetter = Random().nextInt(26);

            if (selectedCase == 0) {
              password += upperCaseAlpha[selectedLetter];
            } else {
              password += lowerCase[selectedLetter];
            }
            break;
        }
      } else {
        int selectedCase = Random().nextInt(2);
        int selectedLetter = Random().nextInt(26);

        if (selectedCase == 0) {
          password += upperCaseAlpha[selectedLetter];
        } else {
          password += lowerCase[selectedLetter];
        }
      }
    }
    return password;
  }

  void passwordListAdd() {
    for (int i = 0; i < 4; i++) {
      String password = makePassword();
      generatedPasswords.add(password);
    }

    setState(() {});
  }

  copyFunction({required String value, required BuildContext context}) {
    FlutterClipboard.copy(value);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Password copied to clipboard.Remember to backup password",
        ),
      ),
    );
  }

  moreOptionsAlert(
      {required BuildContext context, required String password}) async {
    await showDialog(
        context: context,
        builder: (_) {
          return Container(
            color: MyColors.alertContainerColor.withOpacity(0.5),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 50.0,
                      horizontal: 20.0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: MyColors.alertContainerColor),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        color: MyColors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: MyColors.iconColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      ActionWidget(
                        icon: const Icon(
                          Icons.backup,
                          color: MyColors.secondaryColor,
                          size: 40.0,
                        ),
                        title: "Backup",
                        onclicked: () => backUpPasswordDialogue(
                            password: password, context: context),
                      ),
                      ActionWidget(
                        icon: const Icon(
                          Icons.settings,
                          color: MyColors.secondaryColor,
                          size: 40.0,
                        ),
                        title: "Settings",
                        onclicked: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        ),
                      ),
                      ActionWidget(
                        icon: const Icon(
                          Icons.info,
                          color: MyColors.secondaryColor,
                          size: 40.0,
                        ),
                        title: "Info",
                        onclicked: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const InfoScreen(),
                          ),
                        ),
                      ),
                      const ActionWidget(
                          icon: Icon(
                            Icons.star,
                            color: MyColors.secondaryColor,
                            size: 40.0,
                          ),
                          title: "Rate Us"),
                      const ActionWidget(
                          icon: Icon(
                            Icons.contact_mail,
                            color: MyColors.secondaryColor,
                            size: 40.0,
                          ),
                          title: "Contact Us"),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void backUpPasswordDialogue(
      {required String password, required BuildContext context}) {
    GlobalKey<FormState> key = GlobalKey<FormState>();
    TextEditingController title = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("BackUp Password"),
        content: Form(
          key: key,
          child: TextFormField(
            controller: title,
            validator: (text) => BackupValidator.backupValidator(text: text!),
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () async {
                final passwordModel =
                    PasswordModel(password: password, title: title.text);
                final int dataBase = await DataBaseHelper()
                    .insertPasswordToDatabase(passwordModel: passwordModel);
                if (dataBase == 1) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Password Backuped")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Something went wrong")));
                }
              },
              child: const Text("Backup"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HomePage",
      home: Scaffold(
        backgroundColor: MyColors.primaryColor,
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          elevation: 0.0,
          actions: [
            generatedPasswords.isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      generatedPasswords = [];
                      passwordListAdd();
                    },
                    icon: const Icon(Icons.refresh))
          ],
        ),
        drawer: const MyDrawerWidget(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Generate Passwords",
                  style: TextStyle(
                      color: MyColors.secondaryColor,
                      fontSize: 30.00,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                'Copy the desired password or perform other actions with it',
                style: TextStyle(
                  color: MyColors.secondaryColor,
                  fontSize: 18.00,
                ),
              ),
              const SizedBox(
                height: 30.00,
              ),
              generatedPasswords.isEmpty
                  ? ElevatedButton(
                      onPressed: () {
                        passwordListAdd();
                      },
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)))),
                      child: const Text(
                        "Generate Passwordwords",
                        style: TextStyle(
                          color: MyColors.secondaryColor,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5.0),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: MyColors.white,
                              borderRadius: BorderRadius.circular(40),
                              border:
                                  Border.all(color: MyColors.secondaryColor),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  generatedPasswords[index],
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: MyColors.secondaryColor),
                                ),
                                const Expanded(child: SizedBox()),
                                Container(
                                  decoration: BoxDecoration(
                                      color: MyColors.secondaryColor,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: IconButton(
                                    onPressed: () => copyFunction(
                                        context: context,
                                        value: generatedPasswords[index]),
                                    icon: const Icon(
                                      Icons.copy,
                                      color: MyColors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: MyColors.secondaryColor,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: IconButton(
                                    onPressed: () => moreOptionsAlert(
                                      password: generatedPasswords[index],
                                      context: context,
                                    ),
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: MyColors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: generatedPasswords.length,
                      ),
                    ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    color: MyColors.iconColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Numbers",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                          value: addNumber,
                          onChanged: (value) =>
                              addNumberToPassword(value: value),
                          activeColor: MyColors.primaryColor,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Unique Character",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Switch(
                          value: addCharacter,
                          onChanged: (value) =>
                              addCharacterToPassword(value: value),
                          activeColor: MyColors.primaryColor,
                        ),
                      ],
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
}
