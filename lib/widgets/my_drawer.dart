// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutterleaner/colors.dart';
import 'package:flutterleaner/db/db_service.dart';
import 'package:flutterleaner/logics/pin_verification.dart';
import 'package:flutterleaner/screens/info.dart';
import 'package:flutterleaner/screens/passwords.dart';
import 'package:flutterleaner/screens/settings.dart';
import 'package:pinput/pinput.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 50.0),
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      color: MyColors.secondaryColor,
      child: ListView(
        children: [
          ListTile(
            onTap: () async {
              int? myPin = await DataBaseHelper().myPin();
              if (myPin == null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PasswordsScreens()));
              } else {
                pinChecker(context: context);
              }
            },
            leading: const Icon(
              Icons.backup,
              color: MyColors.white,
              size: 30,
            ),
            title: const Text(
              'My Passwords',
              style: TextStyle(
                color: MyColors.white,
                fontSize: 20,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward,
              color: MyColors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const InfoScreen(),
              ),
            ),
            leading: const Icon(
              Icons.info,
              color: MyColors.white,
              size: 30,
            ),
            title: const Text(
              'Info',
              style: TextStyle(
                color: MyColors.white,
                fontSize: 20,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward,
              color: MyColors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: MyColors.white,
              size: 30,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                color: MyColors.white,
                fontSize: 20,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward,
              color: MyColors.white,
              size: 30,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SettingsScreen(),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const ListTile(
            leading: Icon(
              Icons.code,
              color: MyColors.white,
              size: 30,
            ),
            title: Text(
              'Github',
              style: TextStyle(
                color: MyColors.white,
                fontSize: 20,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: MyColors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

void pinChecker({required BuildContext context}) async {
  PinTheme pinTheme = PinTheme(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.transparent,
          border: Border.all(color: MyColors.secondaryColor)));
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
  return await showDialog(
    context: context,
    builder: (_) => Form(
      key: key,
      child: AlertDialog(
        insetPadding: const EdgeInsets.symmetric(vertical: 150),
        title: const Text("Pin"),
        content: Pinput(
          obscureText: true,
          errorPinTheme: errorTheme,
          defaultPinTheme: pinTheme,
          controller: pin,
          onSubmitted: (pin) =>
              PinVerification.validateSettingsPin(pin: pin, context: context),
        ),
      ),
    ),
  );
}
