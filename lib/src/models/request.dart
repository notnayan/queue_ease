// {requester: 6644a89a16b4da2856e8d406, destination: Chahabil, price: 1500, status: pending, _id: 6648d7bc1d6d738d8aafc204, createdAt: 2024-05-18T16:30:52.846Z, __v: 0}

import 'package:queue_ease/src/models/user.dart';

class Request {
  final User requester;
  final String destination;
  final int price;
  final String status;
  final String id;
  final String createdAt;

  Request({
    required this.requester,
    required this.destination,
    required this.price,
    required this.status,
    required this.id,
    required this.createdAt,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      requester: User.fromJson(json['requester']),
      destination: json['destination'],
      price: json['price'],
      status: json['status'],
      id: json['_id'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requester': requester.toJson(),
      'destination': destination,
      'price': price,
      'status': status,
      '_id': id,
      'createdAt': createdAt,
    };
  }

  Request copyWith({
    User? requester,
    String? destination,
    int? price,
    String? status,
    String? id,
    String? createdAt,
  }) {
    return Request(
      requester: requester ?? this.requester,
      destination: destination ?? this.destination,
      price: price ?? this.price,
      status: status ?? this.status,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
