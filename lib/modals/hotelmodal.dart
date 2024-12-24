class HotelModal {
  String? hotelName;
  List<String>? hotelImg;
  String? hotelNum;
  String? hotelEmail;
  String? userId;

  HotelModal(
      {this.hotelName,
      this.hotelImg,
      this.hotelNum,
      this.hotelEmail,
      this.userId});
  Map<String, dynamic> toJson() {
    return {
      'hotelName': hotelName,
      'hotelNum': hotelNum,
      'hotelEmail': hotelEmail,
      'hotelImg': hotelImg,
      'userId': userId,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'hotelName': hotelName,
      'hotelNum': hotelNum,
      'hotelEmail': hotelEmail,
      'hotelImg': hotelImg,
      'userId': userId,
    };
  }
}
