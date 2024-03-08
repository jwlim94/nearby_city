import 'package:nearby_city/nearby_city.dart';

void main() async {
  // initialize instance
  var nearbyCityService = NearbyCityService();

  try {
    // get by only town(읍면동)
    List<dynamic> data1 = await nearbyCityService.getNearbyCity(
      town: '강남동',
    );
    print(data1);

    // get by town(읍면동) and city(시군구)
    List<dynamic> data2 = await nearbyCityService.getNearbyCity(
      town: '강남동',
      city: '강릉시',
    );
    print(data2);

    // get by town(읍면동) and city(시군구) when city has separate area by space
    List<dynamic> data3 = await nearbyCityService.getNearbyCity(
      town: '성복동',
      city: '용인시 수지구',
    );
    print(data3);

    // use "limit" param to limit the number of data
    List<dynamic> data4 = await nearbyCityService.getNearbyCity(
      town: '성복동',
      limit: 3,
    );
    print(data4);

    // use "distance" param to get only within that distance (unit -- km)
    List<dynamic> data5 = await nearbyCityService.getNearbyCity(
      town: '성복동',
      distance: 5,
    );
    print(data5);
  } catch (e) {
    print(e);
  }
}
