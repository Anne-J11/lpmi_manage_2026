class Offer {
  final int id;
  final String title;
  final String description;
  final int time;
  final DateTime startDate;
  final String location;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.startDate,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "time": time,
      "startDate": startDate.toIso8601String(),
      "location": location,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      time: int.parse(map['time'].toString()),
      startDate: DateTime.parse(map['startDate'] as String),
      location: map['location'] as String,
    );
  }
}
