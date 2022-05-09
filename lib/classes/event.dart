class Event {
  final int id;
  final String description;
  final String title;
  final bool locationBased;
  final int latitude;
  final int longtitude;
  final int hostID;
  final int maxPeople;
  final int minPeople;
  final DateTime startEvent;
  final bool hasStarted;

  const Event({
    required this.id,
    required this.description,
    required this.title,
    required this.locationBased,
    required this.latitude,
    required this.longtitude,
    required this.hostID,
    required this.maxPeople,
    required this.minPeople,
    required this.startEvent,
    required this.hasStarted,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      description: json['description'],
      title: json['title'],
      locationBased: json['locationBased'],
      latitude: json['latitude'],
      longtitude: json['longtitude'],
      hostID: json['hostID'],
      maxPeople: json['maxPeople'],
      minPeople: json['minPeople'],
      startEvent: json['startEvent'],
      hasStarted: json['hasStarted'],
    );
  }
}

/*{
    "id": 1,
    "description": "Played at the stadium.",
    "interests": [3],
    "members": [4],
    "title": "Football",
    "locationBased": true,
    "latitude": 40.7127281,
    "longitude": -74.0060152,
    "hostID": 9,
    "maxPeople": 10,
    "minPeople": 2,
    "startEvent": "2022-03-22T08:39:02.619Z",
    "hasStarted": true
  },
*/