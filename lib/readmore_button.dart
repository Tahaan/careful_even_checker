
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String READ_MORE_PAGE_URL =
    'https://www.reddit.com/r/programminghorror/comments/me6ndr/this_is_the_slowest_is_even_that_i_can_think_of/';

class ReadMoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('Why is this so damn slow?'),
      onPressed: () => goToPageAboutTheChallenge(READ_MORE_PAGE_URL),
    );
  }

  Future<void> goToPageAboutTheChallenge(String url) async {
    print('Open $url');
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
