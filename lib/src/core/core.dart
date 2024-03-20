import 'package:nearby_city/nearby_city.dart';
import 'package:nearby_city/src/core/utils/utils.dart';

class Core {
  Core() {
    _networkRequest = NetworkRequest();
  }

  static String version = '0.0.4';

  late NetworkRequest _networkRequest;

  List<dynamic>? _townData;

  Future<List<dynamic>> _getTownData() async {
    if (_townData == null) {
      _townData = await _networkRequest.fetchNearbyCity();
    }
    return _townData!;
  }

  Future<List<dynamic>> getNearbyCityByLatLng({
    required double lat,
    required double lng,
    int limit = 5,
    double distance = 10.0,
  }) async {
    List<dynamic> result = [];

    // fetch data
    List<dynamic> townData = await _getTownData();

    dynamic nearestTown = getNearestTown(townData, lat, lng);

    var townObj = {
      "state": nearestTown[0],
      "city": nearestTown[1],
      "town": nearestTown[2],
      "lat": nearestTown[3],
      "lng": nearestTown[4],
      "nearbyCity": []
    };

    List<dynamic> nearbyResult = [];
    for (var i = 0; i < nearestTown[5].length; i++) {
      var nearbyTown = nearestTown[5][i];

      // Filter by options
      if (limit <= i) break;
      if (distance * 1000 < nearbyTown[1]) break;

      var index = nearbyTown[0];
      var nearbyObj = {
        "state": townData[index][0],
        "city": townData[index][1],
        "town": townData[index][2],
        "lat": townData[index][3],
        "lng": townData[index][4],
        "distance": nearbyTown[1],
      };

      nearbyResult.add(nearbyObj);
    }

    townObj['nearbyCity'] = nearbyResult;
    result.add(townObj);

    return result;
  }

  Future<List<dynamic>> getNearbyCityByTown({
    required String town,
    String city = '',
    int limit = 5,
    double distance = 10.0,
  }) async {
    List<dynamic> result = [];

    // fetch data
    List<dynamic> townData = await _getTownData();

    // parse data
    for (var town_ in townData) {
      if (town_[2] == town) {
        var townObj = {
          "state": town_[0],
          "city": town_[1],
          "town": town_[2],
          "lat": town_[3],
          "lng": town_[4],
          "nearbyCity": []
        };

        // Parse more specifically with city param
        if (city != '' &&
            townObj['city'].trim().replaceAll(' ', '') !=
                city.trim().replaceAll(' ', '')) continue;

        List<dynamic> nearbyResult = [];
        for (var i = 0; i < town_[5].length; i++) {
          var nearbyTown = town_[5][i];

          // Filter by options
          if (limit <= i) break;
          if (distance * 1000 < nearbyTown[1]) break;

          var index = nearbyTown[0];
          var nearbyObj = {
            "state": townData[index][0],
            "city": townData[index][1],
            "town": townData[index][2],
            "lat": townData[index][3],
            "lng": townData[index][4],
            "distance": nearbyTown[1],
          };

          nearbyResult.add(nearbyObj);
        }

        townObj['nearbyCity'] = nearbyResult;
        result.add(townObj);
      }
    }

    return result;
  }
}
