import 'package:shared_preferences/shared_preferences.dart';

class VerificationStorageService {
  static const String _verificationKey = 'is_verified';

  static Future<void> saveVerificationStatus(bool isVerified) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_verificationKey, isVerified);
    } catch (e) {
      // Silently fail if SharedPreferences is not available
      print('Error saving verification status: $e');
    }
  }

  static Future<bool> isVerified() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_verificationKey) ?? false;
    } catch (e) {
      print('Error getting verification status: $e');
      return false;
    }
  }

  static Future<void> clearVerification() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_verificationKey);
    } catch (e) {
      print('Error clearing verification: $e');
    }
  }
}
