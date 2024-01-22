import 'dart:convert';

UserWallet userWalletFromJson(String str) =>
    UserWallet.fromJson(json.decode(str));

String userWalletToJson(UserWallet data) => json.encode(data.toJson());

class UserWallet {
  UserWallet({
    required this.memberName,
    required this.amount,
    required this.date,
    required this.contributionType,
    required this.total,
  });

  String memberName;
  String amount;
  DateTime date;
  String contributionType;
  String total;

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
        memberName: json["Member_Name"],
        amount: json["Amount"],
        date: DateTime.parse(json["Date"]),
        contributionType: json["contribution_type"],
        total: json["Total"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Member_Name": memberName,
        "Amount": amount,
        "Date": date.toIso8601String(),
        "contribution_type": contributionType,
        "Total": total,
      };
}
