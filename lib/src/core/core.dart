import 'package:nearby_city/nearby_city.dart';
import 'package:nearby_city/src/core/utils/utils.dart';

class Core {
  Core() {
    _networkRequest = NetworkRequest();
  }

  static String version = '0.0.2';

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
      "시도명": nearestTown[0],
      "시군구명": nearestTown[1],
      "읍면동명": nearestTown[2],
      "경도": nearestTown[3],
      "위도": nearestTown[4],
      "근처동네": []
    };

    List<dynamic> nearbyResult = [];
    for (var i = 0; i < nearestTown[5].length; i++) {
      var nearbyTown = nearestTown[5][i];

      // Filter by options
      if (limit <= i) break;
      if (distance * 1000 < nearbyTown[1]) break;

      var index = nearbyTown[0];
      var nearbyObj = {
        "시도명": townData[index][0],
        "시군구명": townData[index][1],
        "읍면동명": townData[index][2],
        "경도": townData[index][3],
        "위도": townData[index][4],
        "거리": nearbyTown[1],
      };

      nearbyResult.add(nearbyObj);
    }

    townObj['근처동네'] = nearbyResult;
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
          "시도명": town_[0],
          "시군구명": town_[1],
          "읍면동명": town_[2],
          "경도": town_[3],
          "위도": town_[4],
          "근처동네": []
        };

        // Parse more specifically with city param
        if (city != '' &&
            townObj['시군구명'].trim().replaceAll(' ', '') !=
                city.trim().replaceAll(' ', '')) continue;

        List<dynamic> nearbyResult = [];
        for (var i = 0; i < town_[5].length; i++) {
          var nearbyTown = town_[5][i];

          // Filter by options
          if (limit <= i) break;
          if (distance * 1000 < nearbyTown[1]) break;

          var index = nearbyTown[0];
          var nearbyObj = {
            "시도명": townData[index][0],
            "시군구명": townData[index][1],
            "읍면동명": townData[index][2],
            "경도": townData[index][3],
            "위도": townData[index][4],
            "거리": nearbyTown[1],
          };

          nearbyResult.add(nearbyObj);
        }

        townObj['근처동네'] = nearbyResult;
        result.add(townObj);
      }
    }

    return result;
  }
}
