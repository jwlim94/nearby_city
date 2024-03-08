import 'package:nearby_city/nearby_city.dart';

class Core {
  Core() {
    _networkRequest = NetworkRequest();
  }

  static String version = '0.0.1';

  late NetworkRequest _networkRequest;

  Future<List<dynamic>> getNearbyCity({
    required String town,
    String city = '',
    int limit = 5,
    int distance = 5,
  }) async {
    List<dynamic> result = [];

    // fetch data
    List<dynamic> townData = await _networkRequest.fetchNearbyCity();

    // parse data
    for (var town_ in townData) {
      if (town_[2] == town) {
        var townObj = {
          "시도명": town_[0],
          "시군구명": town_[1],
          "읍면동명": town_[2],
          "위도": town_[3],
          "경도": town_[4],
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
            "위도": townData[index][3],
            "경도": townData[index][4],
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
