import 'package:url_launcher/url_launcher.dart';

class AppLauncher{
  static Future<void> launchPhone({required phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<void> launchEmail({required email}) async {
    final Uri url = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {
          'subject': 'New Message',
          'body': 'Hello'
        }
    );
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}