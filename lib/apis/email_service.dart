import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class EmailService {
  static const String templateId = 'template_62gsbz4';
  static const String publicKey = 'H2WMZ8tWxj1PUO776';
  static const String serviceId = 'default_service';

  Future<bool> sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      final formattedTime = DateTime.now().toLocal().toString().split('.')[0];

      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'origin': 'http://localhost',
            },
            body: jsonEncode({
              'service_id': serviceId,
              'template_id': templateId,
              'user_id': publicKey,
              'template_params': {
                'from_name': name,
                'from_email': email,
                'time': formattedTime,
                'practice_name': subject,
                'monthly_revenue': '',
                'message': message,
              },
            }),
          )
          .timeout(const Duration(seconds: 10));

      debugPrint('EmailJS response code: ${response.statusCode}');
      debugPrint('EmailJS response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        debugPrint('EmailJS request returned non-200 status: ${response.statusCode}');
        return false;
      }
    } on TimeoutException catch (e) {
      debugPrint('EmailJS request timed out after 10 seconds: $e');
      return false;
    } catch (e, stackTrace) {
      debugPrint('Error sending email via EmailJS: $e');
      debugPrintStack(stackTrace: stackTrace);
      return false;
    }
  }
}
