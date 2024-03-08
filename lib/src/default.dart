import 'package:nearby_city/nearby_city.dart';

class NearbyCityService extends Core {
  static String version = Core.version;

  late String type;

  @override
  Future<List<dynamic>> getNearbyCityByTown({
    required String town,
    String city = '',
    int limit = 5,
    int distance = 10,
  }) =>
      super.getNearbyCityByTown(
        town: town,
        city: city,
        limit: limit,
        distance: distance,
      );

  @override
  Future<List<dynamic>> getNearbyCityByLatLng({
    required double lat,
    required double lng,
    int limit = 5,
    int distance = 10,
  }) =>
      super.getNearbyCityByLatLng(
        lat: lat,
        lng: lng,
        limit: limit,
        distance: distance,
      );
}
