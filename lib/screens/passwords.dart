import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutterleaner/colors.dart';
import 'package:flutterleaner/db/db_service.dart';
import 'package:flutterleaner/model/password_model.dart';

class PasswordsScreens extends StatelessWidget {
  const PasswordsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text(
          "My Passwords",
          style: TextStyle(color: MyColors.secondaryColor),
        ),
      ),
      body: FutureBuilder(
        future: DataBaseHelper().getSavedPasswordsFromDataBase(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something Went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading.........."),
            );
          } else {
            final List<PasswordModel> passwords =
                snapshot.data as List<PasswordModel>;
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: Text(passwords[index].title),
                title: Text(passwords[index].password),
                trailing: IconButton(
                  onPressed: () {
                    FlutterClipboard.copy(passwords[index].password);
                  },
                  icon: const Icon(
                    Icons.copy,
                  ),
                ),
              ),
              itemCount: passwords.length,
            );
          }
        },
      ),
    );
  }
}
