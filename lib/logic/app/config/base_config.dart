class BaseConfig {
  BaseConfig();
  String get fileName => "";
  BaseConfig fromJson(Map<String, dynamic> json) => this;
  Map<String, dynamic> toJson() => {};
}
