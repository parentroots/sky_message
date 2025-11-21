class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime time;


  MessageModel({required this.id, required this.senderId, required this.receiverId, required this.text, required this.time});


  Map<String, dynamic> toMap() => {
    'senderId': senderId,
    'receiverId': receiverId,
    'message': text,
    'time': time.millisecondsSinceEpoch,
  };


  factory MessageModel.fromDoc(String id, Map<String, dynamic> data) => MessageModel(
    id: id,
    senderId: data['senderId'] ?? '',
    receiverId: data['receiverId'] ?? '',
    text: data['message'] ?? '',
    time: DateTime.fromMillisecondsSinceEpoch((data['time'] ?? 0)),
  );
}