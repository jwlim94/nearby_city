import 'package:nearby_city/nearby_city.dart';

class NetworkRequest extends NetworkHandler {
  NetworkRequest() {
    _remoteHandler = RemoteHandler();
  }

  late RemoteHandler _remoteHandler;

  @override
  Future<List<dynamic>> fetchNearbyCity() async {
    try {
      return await _remoteHandler.fetchNearbyCity();
    } catch (_) {
      throw Exception('Unable to fetch nearby city');
    }
  }
}
