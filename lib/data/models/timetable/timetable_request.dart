class TimetableRequest {
  final int groupId;
  final int roomId;
  final int dayId;
  final String startTime;
  final String endTime;

  const TimetableRequest({
    required this.groupId,
    required this.roomId,
    required this.dayId,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() => {
        "group_id": groupId,
        "room_id": roomId,
        "day_id": dayId,
        "start_time": startTime,
        "end_time": endTime,
      };
}
