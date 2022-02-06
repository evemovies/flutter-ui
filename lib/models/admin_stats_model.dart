class AdminStats {
  final int usersAll;
  final int usersCreatedToday;
  final int usersActiveToday;

  AdminStats({required this.usersAll, required this.usersCreatedToday, required this.usersActiveToday});

  AdminStats.fromJson(Map<String, dynamic> json)
      : usersAll = json['allUsers'],
        usersCreatedToday = json['createdToday'],
        usersActiveToday = json['activeToday'];
}
