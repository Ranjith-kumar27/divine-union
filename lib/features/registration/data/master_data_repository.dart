import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;

import '../../../services/token_storage_service.dart';
import 'master_data_model.dart';
import '../../../../core/constants/app_strings.dart'; // Assuming base URL might be here or just use the static one from Auth

class MasterDataRepository {
  static const String baseUrl = 'http://13.201.87.182/api';

  Future<MasterDataResponse> getMasterData() async {
    final token = await TokenStorageService.getToken();

    dev.log('🔄 Fetching Master Data');
    dev.log('🌐 API URL: $baseUrl/master-data');

    if (token == null) {
      dev.log('⚠️ No auth token found');
      throw Exception('Not authenticated');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/master-data'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      dev.log('📥 Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // dev.log('📊 Master Data Response: $data'); // Can be large

        return MasterDataResponse.fromJson(data);
      } else {
        dev.log('❌ Failed to fetch master data: ${response.body}');
        throw Exception('Failed to fetch master data: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      dev.log(
        '🚨 Exception in getMasterData: $e',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
