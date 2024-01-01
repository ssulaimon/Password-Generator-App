// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutterleaner/colors.dart';
import 'package:flutterleaner/db/db_service.dart';
import 'package:flutterleaner/logics/pin_verification.dart';
import 'package:pinput/pinput.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: MyColors.secondaryColor,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
              leading: const Icon(
                Icons.pin,
                color: MyColors.secondaryColor,
              ),
              title: const Text(
                "Create Security Pin",
                style:
                    TextStyle(fontSize: 20.0, color: MyColors.secondaryColor),
              ),
              trailing: const Icon(
                Icons.forward,
                color: MyColors.secondaryColor,
              ),
              onTap: () async {
                int? myPin = await DataBaseHelper().myPin();
                if (myPin == null) {
                  createPinDialogue(
                    context: context,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Pin already available")));
                }
              }),
          ListTile(
            leading: const Icon(
              Icons.restore,
              color: MyColors.secondaryColor,
            ),
            title: const Text(
              "Reset Pin",
              style: TextStyle(fontSize: 20.0, color: MyColors.secondaryColor),
            ),
            trailing: const Icon(
              Icons.forward,
              color: MyColors.secondaryColor,
            ),
            onTap: () => resetPin(
              context: context,
            ),
          )
        ],
      ),
    );
  }
}

void createPinDialogue({required BuildContext context}) async {
  PinTheme defaultPinTheme = PinTheme(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          border: Border.all(
            color: MyColors.white,
          )),
      textStyle: const TextStyle(
        fontSize: 20,
      ));
  PinTheme errorTheme = PinTheme(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          border: Border.all(
            color: MyColors.red,
          )),
      textStyle: const TextStyle(
        fontSize: 20,
      ));
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController pin = TextEditingController();
  TextEditingController verifyPin = TextEditingController();

  await showDialog(
      context: context,
      builder: (_) {
        return Form(
          key: key,
          child: Container(
            decoration: const BoxDecoration(
              color: MyColors.secondaryColor,
            ),
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.only(
              bottom: 40.0,
              right: 10,
              left: 10,
            ),
            child: Material(
              color: MyColors.transparent,
              child: Column(
                children: [
                  const Text(
                    'Input Your Security Pin',
                    style: TextStyle(
                      color: MyColors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Pinput(
                    errorPinTheme: errorTheme,
                    defaultPinTheme: defaultPinTheme,
                    controller: pin,
                    obscureText: true,
                    validator: (pin) => PinVerification.validatePin(pin: pin!),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Verify Pin",
                    style: TextStyle(
                      color: MyColors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Pinput(
                    errorPinTheme: errorTheme,
                    defaultPinTheme: defaultPinTheme,
                    controller: verifyPin,
                    obscureText: true,
                    validator: (pin) => PinVerification.validatePin(pin: pin!),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        if (pin.value.text == verifyPin.value.text) {
                          final databaseHelper = DataBaseHelper();
                          int createPin = await databaseHelper.createPin(
                              pin: int.parse(pin.value.text), id: 0);
                          switch (createPin) {
                            case 1:
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Pin Created")));

                              break;
                            default:
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Something went wrongPin Created")));

                              break;
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Pin does not match"),
                            ),
                          );
                        }
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        MyColors.white,
                      ),
                    ),
                    child: const Text(
                      'Create Pin',
                      style: TextStyle(
                        color: MyColors.secondaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

void resetPin({required BuildContext context}) async {
  PinTheme defaultPinTheme = PinTheme(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          border: Border.all(
            color: MyColors.white,
          )),
      textStyle: const TextStyle(
        fontSize: 20,
      ));
  PinTheme errorTheme = PinTheme(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          border: Border.all(
            color: MyColors.red,
          )),
      textStyle: const TextStyle(
        fontSize: 20,
      ));
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController pin = TextEditingController();
  TextEditingController newPin = TextEditingController();

  await showDialog(
      context: context,
      builder: (_) {
        return Form(
          key: key,
          child: Container(
            decoration: const BoxDecoration(
              color: MyColors.secondaryColor,
            ),
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.only(
              bottom: 40.0,
              right: 10,
              left: 10,
            ),
            child: Material(
              color: MyColors.transparent,
              child: Column(
                children: [
                  const Text(
                    'Previous Pin',
                    style: TextStyle(
                      color: MyColors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Pinput(
                    obscureText: true,
                    errorPinTheme: errorTheme,
                    defaultPinTheme: defaultPinTheme,
                    controller: pin,
                    validator: (pin) => PinVerification.validatePin(pin: pin!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'New Pin',
                    style: TextStyle(
                      color: MyColors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Pinput(
                    obscureText: true,
                    defaultPinTheme: defaultPinTheme,
                    errorPinTheme: errorTheme,
                    validator: (pin) => PinVerification.validatePin(pin: pin!),
                    controller: newPin,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        final dataBase = DataBaseHelper();
                        final pinInt = int.parse(pin.text);
                        final newPinInt = int.parse(newPin.text);

                        int? oldPin = await dataBase.myPin();
                        if (oldPin == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please Create Pin")));
                        } else if (oldPin != pinInt) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Previous pin does not match")));
                        } else {
                          if (pinInt == newPinInt) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Pin match")));
                          } else {
                            int updatePin =
                                await dataBase.updatePin(id: 0, pin: newPinInt);
                            switch (updatePin) {
                              case 1:
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Pin updated")));

                                break;
                              default:
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Something went wrongPin Created")));

                                break;
                            }
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        MyColors.white,
                      ),
                    ),
                    child: const Text(
                      'Reset Pin',
                      style: TextStyle(
                        color: MyColors.secondaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
