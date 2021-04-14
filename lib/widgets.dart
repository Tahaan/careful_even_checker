import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String GITHUB_URL = '';

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
    launch(GITHUB_URL);
  }
}
