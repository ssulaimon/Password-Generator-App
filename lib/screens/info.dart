import 'package:flutter/material.dart';
import 'package:flutterleaner/colors.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text(
          "Info",
          style: TextStyle(
            color: MyColors.secondaryColor,
            fontSize: 30.0,
          ),
        ),
      ),
      body: ListView(
        children: const [
          ExpansionTile(
            title: Text("How Does Password Generation Work"),
            leading: Icon(
              Icons.question_mark,
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Text(
                  'Every generated passwords are generated through selection of random picking of each alphabets. Including numbers and character if this is activated by the user. Random picking of all character is done so it cannot be guessed by another human.',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionTile(
            title: Text('Password Access'),
            leading: Icon(Icons.question_mark),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Text(
                  'Does devs have access to password? Generated passwords are local stored on your device storage devs do not have access to passwords. Cloud storage for password is seen as a point of failure because devs would have access to the cloud storage and also security of the password can be compromised on cloud storage.',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionTile(
            title: Text('Lost My Phone'),
            leading: Icon(Icons.question_mark),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Text(
                  'Password backups are locally stored on the user device and cannot be access in situations of lost device, cleard app storage, stolen devices and so on. Please password should be written down in a piece of papper for better backups.',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
