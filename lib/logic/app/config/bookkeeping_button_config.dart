import 'base_config.dart';

class BookKeepingButtonConfig extends BaseConfig {

  List<BookKeepingButtonConfigElement> bookKeepingButtonConfig;

  BookKeepingButtonConfig({this.bookKeepingButtonConfig});

  BookKeepingButtonConfig fromJson(Map<String, dynamic> json) {
    if (json["config"] != null) {
      this.bookKeepingButtonConfig = new List<BookKeepingButtonConfigElement>();
      json["config"].forEach((v) {
        this.bookKeepingButtonConfig.add(new BookKeepingButtonConfigElement.fromJson(v));
      });
      return this;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookKeepingButtonConfig != null) {
      data["config"] =
          this.bookKeepingButtonConfig.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookKeepingButtonConfigElement {
  String type;
  String icon;
  String iconSel;

  BookKeepingButtonConfigElement({this.type, this.icon, this.iconSel});

  BookKeepingButtonConfigElement.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    icon = json['icon'];
    iconSel = json['icon_sel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['icon'] = this.icon;
    data['icon_sel'] = this.iconSel;
    return data;
  }
}


class OutComeButtonConfig extends BookKeepingButtonConfig {
  @override
  String get fileName => "outcome_config.json";
}

class InComeButtonConfig extends BookKeepingButtonConfig {
  @override
  String get fileName => "income_config.json";
}
