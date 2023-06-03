import 'package:flutter/material.dart';
import '../../styles/CommonTextStyle.dart';
import '../../styles/common Color.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: secondaryColor,
        centerTitle: true,
        leading: IconButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            color: Colors.white,
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: const Text(
          'Settings',
          style: appBar,
        ),
      ),
      body: DraggableScrollableSheet(
        snap: false,
        minChildSize: 0.75,
        initialChildSize: 1,
        maxChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) =>
            Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Divider(),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.lock_rounded,
                      color: secondaryColor,
                    ),
                    title: Text(
                      'Change Password',
                      style: textInputHeader,
                    ),
                    trailing: const Icon(
                      Icons.navigate_next_rounded,
                      color: secondaryColor,
                    ),
                  ),
                  Divider(),
                ])),
      ),
    );
  }
}
