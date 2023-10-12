// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';


enum RequestType {
  GET('GET'),
  POST('POST'),
  PUT('PUT'),
  DELETE('DELETE');

  final String value;
  const RequestType(this.value);
}


class Request {
  final String id;
  final String url;
  final String body;
  final String response;
  final int responseCode;
  final bool running;
  final String name;
  final RequestType type;
  Request({
    String? existingId,
    this.url = "http://dartbucket.com",
    this.body = "",
    this.response = "",
    this.responseCode = 200,
    this.running = false,
    this.name = "New Request",
    this.type = RequestType.GET,
  }):id = existingId ?? const Uuid().v4();

  Request copyWith({
    String? url,
    String? body,
    String? response,
    int? responseCode,
    bool? running,
    String? name,
    RequestType? type,
  }) {
    return Request(
      existingId: id,
      url: url ?? this.url,
      body: body ?? this.body,
      response: response ?? this.response,
      responseCode: responseCode ?? this.responseCode,
      running: running ?? this.running,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'body': body,
      'response': response,
      'responseCode': responseCode,
      'running': running,
      'name': name,
      'type': type.value,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      url: map['url'] as String,
      body: map['body'] as String,
      response: map['response'] as String,
      responseCode: map['responseCode'] as int,
      running: map['running'] as bool,
      name: map['name'] as String,
      type: map['type'] as RequestType,
    );
  }

  String toJson() => json.encode(toMap());

  factory Request.fromJson(String source) => Request.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Request(id: $id, url: $url, body: $body, response: $response, responseCode: $responseCode, running: $running, name: $name, type: $type)';
  }

  @override
  bool operator ==(covariant Request other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.url == url &&
      other.body == body &&
      other.response == response &&
      other.responseCode == responseCode &&
      other.running == running &&
      other.name == name &&
      other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      url.hashCode ^
      body.hashCode ^
      response.hashCode ^
      responseCode.hashCode ^
      running.hashCode ^
      name.hashCode ^
      type.hashCode;
  }
}
