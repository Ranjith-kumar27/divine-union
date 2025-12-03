// Dummy repo to simulate network calls. Replace these with real API calls.
class DummyAuthRepository {
  Future<String> sendOtp(String mobile) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return '123456'; // dummy OTP for local testing
  }

  Future<bool> verifyOtp(String mobile, String otp) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return otp == '123456';
  }

  Future<void> submitProfile(Map<String, dynamic> payload) async {
    await Future.delayed(const Duration(milliseconds: 700));
    // No-op for dummy
    return;
  }
}
