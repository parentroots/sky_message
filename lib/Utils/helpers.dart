String makeRoomId(String a, String b) => a.compareTo(b) > 0 ? "$a\_$b" : "$b\_$a";

String formatTimestamp(int ms) {
  final dt = DateTime.fromMillisecondsSinceEpoch(ms);
  return "${dt.hour}:${dt.minute.toString().padLeft(2,'0')} ${dt.day}/${dt.month}/${dt.year}";
}
