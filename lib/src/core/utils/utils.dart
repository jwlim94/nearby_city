import 'dart:math' as math;

double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
  // Convert degrees to radians
  double radLat1 = (lat1 * math.pi) / 180;
  double radLat2 = (lat2 * math.pi) / 180;
  double radLng1 = (lng1 * math.pi) / 180;
  double radLng2 = (lng2 * math.pi) / 180;

  // Earth radius in meters
  const double R = 6371000;

  // Difference in coordinates
  double dLat = radLat2 - radLat1;
  double dLng = radLng2 - radLng1;

  // Haversine formula
  double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(radLat1) *
          math.cos(radLat2) *
          math.sin(dLng / 2) *
          math.sin(dLng / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  double distance = R * c; // Distance in meters

  return distance;
}

dynamic getNearestTown(List<dynamic> townData, double lat, double lng) {
  // [0]: distance
  // [1]: town (return value)
  List<dynamic> result = [double.maxFinite, null];

  for (var town_ in townData) {
    double calculatedDistance = calculateDistance(
      lat,
      lng,
      double.parse(town_[3]),
      double.parse(town_[4]),
    );

    if (calculatedDistance < result[0]) {
      result[0] = calculatedDistance;
      result[1] = town_;
    }
  }

  return result[1];
}
