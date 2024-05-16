// To parse this JSON data, do
//
//     final newUserWallet = newUserWalletFromJson(jsonString);

import 'dart:convert';

NewUserWallet newUserWalletFromJson(String str) =>
    NewUserWallet.fromJson(json.decode(str));

String newUserWalletToJson(NewUserWallet data) => json.encode(data.toJson());

class NewUserWallet {
  List<Contribution> contributions;
  List<Withdrawal> withdrawals;

  NewUserWallet({
    required this.contributions,
    required this.withdrawals,
  });

  factory NewUserWallet.fromJson(Map<String, dynamic> json) => NewUserWallet(
        contributions: List<Contribution>.from(
            json["contributions"].map((x) => Contribution.fromJson(x))),
        withdrawals: List<Withdrawal>.from(
            json["withdrawals"].map((x) => Withdrawal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contributions":
            List<dynamic>.from(contributions.map((x) => x.toJson())),
        "withdrawals": List<dynamic>.from(withdrawals.map((x) => x.toJson())),
      };
}

class Contribution {
  Type type;
  MemberName memberName;
  Amount amount;
  DateTime date;
  ContributionType contributionType;
  int total;

  Contribution({
    required this.type,
    required this.memberName,
    required this.amount,
    required this.date,
    required this.contributionType,
    required this.total,
  });

  factory Contribution.fromJson(Map<String, dynamic> json) => Contribution(
        type: typeValues.map[json["type"]]!,
        memberName: memberNameValues.map[json["Member_Name"]]!,
        amount: amountValues.map[json["Amount"]]!,
        date: DateTime.parse(json["Date"]),
        contributionType:
            contributionTypeValues.map[json["contribution_type"]]!,
        total: json["Total"],
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "Member_Name": memberNameValues.reverse[memberName],
        "Amount": amountValues.reverse[amount],
        "Date": date.toIso8601String(),
        "contribution_type": contributionTypeValues.reverse[contributionType],
        "Total": total,
      };
}

enum Amount { THE_1000, THE_1500, THE_2000 }

final amountValues = EnumValues({
  "₦1000": Amount.THE_1000,
  "₦1500": Amount.THE_1500,
  "₦2000": Amount.THE_2000
});

enum ContributionType { REGULAR_SAVI }

final contributionTypeValues =
    EnumValues({"Regular Savi": ContributionType.REGULAR_SAVI});

enum MemberName { MEMBER_NAME_MRS_FAVOUR, MRS_FAVOUR }

final memberNameValues = EnumValues({
  "mrs favour": MemberName.MEMBER_NAME_MRS_FAVOUR,
  "mrs favour ": MemberName.MRS_FAVOUR
});

enum Type { CONTRIBUTION }

final typeValues = EnumValues({"contribution": Type.CONTRIBUTION});

class Withdrawal {
  String type;
  String amount;
  String approvedBy;
  String agentId;
  DateTime date;
  int total;

  Withdrawal({
    required this.type,
    required this.amount,
    required this.approvedBy,
    required this.agentId,
    required this.date,
    required this.total,
  });

  factory Withdrawal.fromJson(Map<String, dynamic> json) => Withdrawal(
        type: json["type"],
        amount: json["Amount"],
        approvedBy: json["Approved_By"],
        agentId: json["Agent_Id"],
        date: DateTime.parse(json["Date"]),
        total: json["Total"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "Amount": amount,
        "Approved_By": approvedBy,
        "Agent_Id": agentId,
        "Date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "Total": total,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
