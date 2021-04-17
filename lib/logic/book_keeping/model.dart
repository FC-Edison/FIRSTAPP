class DetailedListReply {
  bool success;
  String message;
  List<DetailListItem> incomeList;
  List<DetailListItem> outcomeList;

  DetailedListReply(
      {this.success, this.message, this.incomeList, this.outcomeList});

  DetailedListReply.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['incomeList'] != null) {
      incomeList = new List<DetailListItem>();
      json['incomeList'].forEach((v) {
        incomeList.add(new DetailListItem.fromJson(v));
      });
    }
    if (json['outcomeList'] != null) {
      outcomeList = new List<DetailListItem>();
      json['outcomeList'].forEach((v) {
        outcomeList.add(new DetailListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.incomeList != null) {
      data['incomeList'] = this.incomeList.map((v) => v.toJson()).toList();
    }
    if (this.outcomeList != null) {
      data['outcomeList'] = this.outcomeList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailListItem extends Comparable{
  int timeStamp;
  double amount;
  String type;
  String remarks;
  bool isOutcome;

  DetailListItem({this.timeStamp, this.amount, this.type, this.remarks,this.isOutcome});

  DetailListItem.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'];
    amount = json['amount'];
    type = json['type'];
    remarks = json['remarks'];
    isOutcome = json['isOutcome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeStamp'] = this.timeStamp;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['remarks'] = this.remarks;
    data['isOutcome'] = this.isOutcome;
    return data;
  }

  @override
  int compareTo(other) {
      if (this.timeStamp > other.timeStamp) {
        return -1;
      } else if (this.timeStamp < other.timeStamp) {
        return 1;
      }
      return 0;
  }
}
