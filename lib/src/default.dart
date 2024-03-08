import 'package:nearby_city/nearby_city.dart';

class NearbyCityService extends Core {
  static String version = Core.version;

  late String type;

  @override
  Future<List<dynamic>> getNearbyCity({
    required String town,
    String city = '',
    int limit = 5,
    int distance = 10,
  }) =>
      super.getNearbyCity(
        town: town,
        city: city,
        limit: limit,
        distance: distance,
      );
}
