import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SupabaseApi {
  SupabaseApi({SupabaseClient? client})
      : supabase = client ?? Supabase.instance.client;

  static const String resumeBucket = 'pdfs';
  static const String resumeFileName = "Afan's_Resume.pdf";
  static const String screenshotBucket = 'images';
  static const String appsBucket = 'apps';

  static const Map<String, String> screenshotFolders = {
    'revora': 'revora',
    'chatto': 'chatto',
    'weather': 'weather_app',
    'portfolio': 'portfolio-website',
  };

  final SupabaseClient supabase;

  Future<bool> downloadResume() async {
    try {
      final resumeUrl = supabase.storage
          .from(resumeBucket)
          .getPublicUrl(resumeFileName);
      final downloadUrl = Uri.parse(resumeUrl).replace(
        queryParameters: {'download': resumeFileName},
      );

      return launchUrl(
        downloadUrl,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
    } catch (error, stackTrace) {
      debugPrint('Resume download failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> getApps() async {
    try {
      final downloadUrl = supabase.storage
          .from('apps')
          .getPublicUrl('portfolio.apk');

      return await launchUrl(
        Uri.parse(downloadUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Get apps failed: $e');
      return false;
    }
  }

  Future<dynamic> getImage() async{
    final image = await supabase.storage.from('images').getPublicUrl('my_pic.jpeg');
    return image;
  }

  Future<void> getPdfs() async {
    await supabase.from('pdfs').select();
  }

  Future<Map<String, List<String>>> getProjectScreenshots() async {
    final screenshots = <String, List<String>>{};

    for (final entry in screenshotFolders.entries) {
      try {
        final files = await supabase.storage
            .from(screenshotBucket)
            .list(path: entry.value);

        final imageFiles = files.where((file) => _isImage(file.name)).toList();
        imageFiles.sort((a, b) => a.name.compareTo(b.name));

        List<String> urls = imageFiles
            .map(
              (file) => supabase.storage
                  .from(screenshotBucket)
                  .getPublicUrl('${entry.value}/${file.name}'),
            )
            .toList();

        if (urls.isEmpty) {
          urls = _getFallbackUrls(entry.value);
        }

        screenshots[entry.key] = urls;
      } catch (e) {
        debugPrint('Error fetching screenshots for ${entry.key}: $e');
        screenshots[entry.key] = _getFallbackUrls(entry.value);
      }
    }

    return screenshots;
  }

  List<String> _getFallbackUrls(String folder) {
    if (folder == 'revora') {
      return List.generate(
        6,
        (i) => supabase.storage
            .from(screenshotBucket)
            .getPublicUrl('$folder/pic${i + 1}.png'),
      );
    }
    else if (folder == 'revora' || folder == 'chatto') {
      return List.generate(
        6,
            (i) => supabase.storage
            .from(screenshotBucket)
            .getPublicUrl('$folder/pic${i + 1}.jpeg'),
      );
    }
    return [];
  }

  bool _isImage(String fileName) {
    final extension = fileName.toLowerCase().split('.').last;
    return {'png', 'jpg', 'jpeg', 'webp', 'gif'}.contains(extension);
  }

  Future<void> savePerson() async {
    final id = DateTime.now().millisecondsSinceEpoch;

    await Supabase.instance.client
        .from('responses')
        .insert({
      'id': id,
      'Name': 'Afan Riaz',
    });

    print('Data saved successfully');
  }

  Future<bool> saveContactResponse({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;
      await supabase.from('responses').insert({
        'id': id,
        'Name': name,
        'Email': email,
        'Subject': subject,
        'message': message,
        'created_at': DateTime.now().toIso8601String(),
      }).timeout(const Duration(seconds: 10));
      debugPrint('Contact response uploaded to Supabase successfully.');
      return true;
    } on TimeoutException catch (e) {
      debugPrint('Supabase upload timed out after 10 seconds: $e');
      return false;
    } catch (e, stackTrace) {
      debugPrint('Failed to save contact response to Supabase: $e');
      debugPrintStack(stackTrace: stackTrace);
      return false;
    }
  }
}
