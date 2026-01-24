import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;

import '../../../services/token_storage_service.dart';

abstract class AuthRepository {
  Future<String> sendOtp(String mobile);

  Future<bool> verifyOtp(String mobile, String otp);

  Future<void> submitProfile(Map<String, dynamic> profile);
}

class ApiAuthRepository implements AuthRepository {
  static const String baseUrl = 'http://13.201.87.182/api';

  @override
  Future<String> sendOtp(String mobile) async {
    final cleanedMobile = mobile.replaceAll(RegExp(r'\s+'), '');

    dev.log('📱 Sending OTP to mobile: $cleanedMobile', name: 'AuthRepository');
    dev.log('🌐 API URL: $baseUrl/send-otp');
    dev.log('📤 Request body: {"mobile": "$cleanedMobile"}');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/send-otp'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({'mobile': cleanedMobile}),
      );

      dev.log('📥 Response status code: ${response.statusCode}');
      dev.log('📥 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        dev.log('📊 Response data: $data');

        // Check if response contains OTP (indicating success)
        if (data.containsKey('otp') || data['otp'] != null) {
          final otp = data['otp']?.toString() ?? _generateDummyOtp();
          dev.log('✅ OTP sent successfully. OTP: $otp');
          return otp;
        } else if (data['message']?.toString().toLowerCase().contains(
              'success',
            ) ==
            true) {
          // If message indicates success but no OTP
          final otp = _generateDummyOtp();
          dev.log(
            '✅ OTP sent successfully (from message). Generated OTP: $otp',
          );
          return otp;
        } else {
          // If API returns a message but not success, throw it as an error
          final errorMessage = data['message'] ?? 'Failed to send OTP';
          dev.log('❌ OTP send failed: $errorMessage');
          throw Exception(errorMessage);
        }
      } else {
        try {
          final errorData = json.decode(response.body);
          final errorMessage =
              errorData['message'] ??
              'Failed to send OTP: ${response.statusCode}';
          dev.log('❌ HTTP Error ${response.statusCode}: $errorMessage');
          throw Exception(errorMessage);
        } catch (e) {
          dev.log(
            '❌ HTTP Error ${response.statusCode}: Could not parse error response',
          );
          throw Exception('Failed to send OTP: ${response.statusCode}');
        }
      }
    } catch (e, stackTrace) {
      dev.log('🚨 Exception in sendOtp: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool> verifyOtp(String mobile, String otp) async {
    dev.log('🔐 Verifying OTP for mobile: $mobile');
    dev.log('🔢 OTP to verify: $otp');
    dev.log('🌐 API URL: $baseUrl/verify-otp');
    dev.log('📤 Request body: {"mobile": "$mobile", "otp": "$otp"}');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify-otp'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({'mobile': mobile, 'otp': otp}),
      );

      dev.log('📥 Response status code: ${response.statusCode}');
      dev.log('📥 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        dev.log('📊 Response data: $data');

        // Check different possible response formats
        if (data['status'] == 'success' ||
            data['success'] == true ||
            data['verified'] == true ||
            (data['message']?.toString().toLowerCase().contains('verified') ==
                true) ||
            (data['message']?.toString().toLowerCase().contains('success') ==
                true)) {
          dev.log('✅ OTP verification successful');

          // Extract and save token if available
          if (data['token'] != null) {
            final token = data['token'].toString();
            await TokenStorageService.saveToken(token);
            dev.log('🔑 Token saved successfully: $token');
          } else if (data['data'] != null && data['data']['token'] != null) {
            // Handle nested token structure if applicable
            final token = data['data']['token'].toString();
            await TokenStorageService.saveToken(token);
            dev.log('🔑 Token saved successfully (nested): $token');
          } else {
            dev.log(
              '⚠️ No token found in verification response. Using default token.',
            );
            // Fallback token provided by user
            const defaultToken =
                '4|iWKQJoYZmfKk67g4iHFhhszCMzu9M9ILKcM0DKG08e70f988';
            await TokenStorageService.saveToken(defaultToken);
            dev.log('🔑 Default Token saved: $defaultToken');
          }

          return true;
        } else {
          // Check for error message in response
          final errorMessage =
              data['message'] ?? data['error'] ?? 'Invalid OTP';
          dev.log('⚠️ OTP verification failed: $errorMessage');
          throw Exception(errorMessage);
        }
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        // Invalid OTP - get error message from response
        try {
          final errorData = json.decode(response.body);
          final errorMessage =
              errorData['message'] ?? errorData['error'] ?? 'Invalid OTP';
          dev.log('⚠️ Invalid OTP (${response.statusCode}): $errorMessage');
          throw Exception(errorMessage);
        } catch (_) {
          dev.log(
            '⚠️ Invalid OTP (${response.statusCode}): Could not parse error response',
          );
          throw Exception('Invalid OTP. Please try again.');
        }
      } else {
        dev.log('❌ Server error (${response.statusCode}): ${response.body}');
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      dev.log(
        '🚨 Exception in verifyOtp: $e',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> submitProfile(Map<String, dynamic> profile) async {
    final token = await TokenStorageService.getToken();

    dev.log('👤 Submitting profile data');
    dev.log('📊 Profile data: $profile');
    dev.log('🌐 API URL: $baseUrl/submit-profile');

    if (token == null) {
      dev.log('⚠️ No auth token found during profile submission');
      // We might proceed without token if that's the logic, or throw error.
      // Usually profile submission requires auth.
      // throw Exception('Not authenticated');
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/submit-profile'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: json.encode(profile),
      );

      dev.log('📥 Response status code: ${response.statusCode}');
      dev.log('📥 Response body: ${response.body}');

      if (response.statusCode == 200) {
        dev.log('✅ Profile submitted successfully');
        final Map<String, dynamic> data = json.decode(response.body);
        dev.log('📊 Response data: $data');
      } else {
        final errorData = json.decode(response.body);
        final errorMessage =
            errorData['message'] ??
            'Failed to submit profile: ${response.statusCode}';
        dev.log('❌ Profile submission failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e, stackTrace) {
      dev.log(
        '🚨 Exception in submitProfile: $e',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Failed to submit profile: $e');
    }
  }

  String _generateDummyOtp() {
    final dummyOtp = (100000 + DateTime.now().millisecondsSinceEpoch % 900000)
        .toString();
    dev.log('🎲 Generated dummy OTP: $dummyOtp');
    return dummyOtp;
  }
}

class DummyAuthRepository implements AuthRepository {
  @override
  Future<String> sendOtp(String mobile) async {
    dev.log('🧪 Dummy: Sending OTP to $mobile');
    await Future.delayed(const Duration(seconds: 1));
    final otp = _generateDummyOtp();
    dev.log('🧪 Dummy: Generated OTP: $otp');
    return otp;
  }

  @override
  Future<bool> verifyOtp(String mobile, String otp) async {
    dev.log('🧪 Dummy: Verifying OTP $otp for $mobile');
    await Future.delayed(const Duration(seconds: 1));
    final isValid = otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(otp);
    dev.log('🧪 Dummy: OTP verification result: $isValid');
    return isValid;
  }

  @override
  Future<void> submitProfile(Map<String, dynamic> profile) async {
    dev.log('🧪 Dummy: Submitting profile: $profile');
    await Future.delayed(const Duration(seconds: 2));
    dev.log('🧪 Dummy: Profile submitted successfully');
  }

  String _generateDummyOtp() {
    return (100000 + DateTime.now().millisecondsSinceEpoch % 900000).toString();
  }
}
