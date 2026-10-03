import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlOpening {
  Future<bool> linkedInUrl() async {
    try {
      final Uri url = Uri.parse(
        'https://www.linkedin.com/in/afan-riaz',
      );

      if (await canLaunchUrl(url)) {
        return await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      }

      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
  Future<bool> gitHubUrl() async {
    try {
      final Uri url = Uri.parse(
        'https://www.github.com/AfanRiaz',
      );

      if (await canLaunchUrl(url)) {
        return await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      }

      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
  Future<bool> emailUrl() async {
    try {
      final Uri url = Uri(
        scheme: 'mailto',
        path: 'cadetafan202@gmail.com',
      );

      return await launchUrl(
        url,
        webOnlyWindowName: '_blank',
      );
    } catch (e) {
      debugPrint('Email error: $e');
      return false;
    }
  }
  Future<bool> phoneUrl() async {
    try {
      final Uri url = Uri(
        scheme: 'tel',
        path: '923415035548',
      );

      return await launchUrl(
        url,
        webOnlyWindowName: '_blank',
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Email error: $e');
      return false;
    }
  }
  Future<bool> whatsappUrl() async {
    try{
      final Uri url = Uri.parse(
        'https://wa.me/923415035548',
      );
      return await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
    catch(e){
      debugPrint('Whatsapp error: $e');
      return false;
    }
  }
}