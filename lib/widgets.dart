import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String GITHUB_URL = 'https://github.com/Tahaan/careful_even_checker/blob/master/lib/core/checker.dart';

// TODO: Add an about page.

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Column(
              children: [
                ListTile(
                  onTap: goToGithub,
                  title: Text('View App source'),
                  subtitle: Text('Open GitHub page'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> goToGithub() async {
    print('Open $GITHUB_URL');
    if (await canLaunch(GITHUB_URL)) {
      await launch(
        GITHUB_URL,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $GITHUB_URL';
    }
  }
}
