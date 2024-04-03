class SocketUser {
  final int id;
  final String name;
  final String img;
  final String socketId;

  SocketUser({
    required this.id,
    required this.name,
    required this.img,
    required this.socketId,
  });

  factory SocketUser.fromJson(Map<String, dynamic> json) {
    return SocketUser(
      id: int.parse(json['id']),
      name: json['name'],
      img: json['img'],
      socketId: json['socketId'],
    );
  }
}