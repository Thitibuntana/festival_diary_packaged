class Fest {
  int? festId;
  String? festName;
  String? festDetail;
  String? festState;
  double? festCost;
  int? userId;
  String? festImage;
  int? festNumDay;

  Fest(
      {this.festId,
      this.festName,
      this.festDetail,
      this.festState,
      this.festCost,
      this.userId,
      this.festImage,
      this.festNumDay});

  Fest.fromJson(Map<String, dynamic> json) {
    festId = json['festId'];
    festName = json['festName'];
    festDetail = json['festDetail'];
    festState = json['festState'];
    festCost = json['festCost'];
    userId = json['userId'];
    festImage = json['festImage'];
    festNumDay = json['festNumDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['festId'] = festId;
    data['festName'] = festName;
    data['festDetail'] = festDetail;
    data['festState'] = festState;
    data['festCost'] = festCost;
    data['userId'] = userId;
    data['festImage'] = festImage;
    data['festNumDay'] = festNumDay;
    return data;
  }
}
