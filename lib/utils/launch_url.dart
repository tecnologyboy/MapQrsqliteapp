import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart' as lurl;

Future launchUrl(BuildContext context, ScanModel scans) async {
  final Uri _url = Uri.parse(scans.value);

  if (scans.type == 'https') {
    if (!await lurl.launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scans);
  }
}
