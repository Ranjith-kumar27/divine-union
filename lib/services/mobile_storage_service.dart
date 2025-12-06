import 'package:shared_preferences/shared_preferences.dart';

class MobileStorageService {
  static const String _mobileKey = 'registration_mobile';
  static const String _verifiedMobileKey = 'verified_mobile'; // New key

  static Future<void> saveMobile(String mobile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_mobileKey, mobile);
    } catch (e) {
      // Silently fail if SharedPreferences is not available
      print('Error saving mobile: $e');
    }
  }

  static Future<String?> getMobile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_mobileKey);
    } catch (e) {
      print('Error getting mobile: $e');
      return null;
    }
  }

  // New method to save verified mobile
  static Future<void> saveVerifiedMobile(String mobile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_verifiedMobileKey, mobile);
    } catch (e) {
      print('Error saving verified mobile: $e');
    }
  }

  // New method to get verified mobile
  static Future<String?> getVerifiedMobile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_verifiedMobileKey);
    } catch (e) {
      print('Error getting verified mobile: $e');
      return null;
    }
  }

  static Future<void> clearMobile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_mobileKey);
      await prefs.remove(_verifiedMobileKey); // Also clear verified mobile
    } catch (e) {
      print('Error clearing mobile: $e');
    }
  }
}
