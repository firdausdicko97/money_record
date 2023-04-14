class History {
  History({
    this.idHistory,
    this.idUser,
    this.type,
    this.date,
    this.total,
    this.detail,
    this.createdAt,
    this.updatedAt,
  });

  String? idHistory;
  String? idUser;
  String? type;
  String? date;
  String? total;
  String? detail;
  String? createdAt;
  String? updatedAt;

  factory History.fromJson(Map<String, dynamic> json) => History(
        idHistory: json["id_history"],
        idUser: json["id_user"],
        type: json["type"],
        date: json["date"],
        total: json["total"],
        detail: json["detail"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_history": idHistory,
        "id_user": idUser,
        "type": type,
        "date": date,
        "total": total,
        "detail": detail,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
