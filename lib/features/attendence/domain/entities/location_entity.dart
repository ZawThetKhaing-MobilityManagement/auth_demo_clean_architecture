class LocationEntity {
  const LocationEntity({
    required this.lat,
    required this.lon,
    required this.status,
    this.clockIn,
    this.clockOut,
    this.hour,
    this.minute,
    this.id,
  });

  final double lat;
  final double lon;
  final DateTime? clockIn;
  final DateTime? clockOut;
  final String status;
  final String? hour;
  final String? minute;
  final int? id;
}
