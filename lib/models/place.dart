import 'dart:convert';
import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  PlaceLocation copyWith({
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return PlaceLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'latitude': latitude});
    result.addAll({'longitude': longitude});
    if (address != null) {
      result.addAll({'address': address});
    }

    return result;
  }

  factory PlaceLocation.fromMap(Map<String, dynamic> map) {
    return PlaceLocation(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceLocation.fromJson(String source) =>
      PlaceLocation.fromMap(json.decode(source));

  @override
  String toString() =>
      'PlaceLocation(latitude: $latitude, longitude: $longitude, address: $address)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlaceLocation &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.address == address;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode ^ address.hashCode;
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });

  Place copyWith({
    String? id,
    String? title,
    PlaceLocation? location,
    File? image,
  }) {
    return Place(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'location': location.toMap()});
    result.addAll({'image': image.path});

    return result;
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      location: PlaceLocation.fromMap(map['location']),
      image: File.fromUri(map['image']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Places(id: $id, title: $title, location: $location, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Place &&
        other.id == id &&
        other.title == title &&
        other.location == location &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ location.hashCode ^ image.hashCode;
  }
}
