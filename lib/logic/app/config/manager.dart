import 'dart:convert';
import 'package:xiao_yu_ji_zhang/logic/app/config/bookkeeping_button_config.dart';
import 'package:xiao_yu_ji_zhang/logic/hive/helper.dart';
import 'package:xiao_yu_ji_zhang/logic/network/static.dart';

import 'base_config.dart';

class AppConfigManager {
  static AppConfigManager _instance;
  static AppConfigManager get instance {
    if (_instance == null) {
      _instance = AppConfigManager._init();
    }
    return _instance;
  }
  AppConfigManager._init();

  List<BaseConfig> configs = [
    OutComeButtonConfig(),
    InComeButtonConfig()
  ];

  BaseConfig _configGet(BaseConfig config){
    if(HiveHelper.dBox.get(config.fileName) == null){
      return null;
    }else{
      return config.fromJson(jsonDecode(HiveHelper.dBox.get(config.fileName)));
    }
  }
  _configSet(BaseConfig v) => HiveHelper.dBox.put(v.fileName, jsonEncode(v.toJson()));
/*
 * 缓存所有配置文件
 */
  Future sync() async {
    for(int i = 0;i < configs.length;i++){
      if (configs[i] == null) {
        // TODO 处理config同步失败的情况
        await _syncImplement(configs[i]);
      } else {
        _syncImplement(configs[i]);
      }
    }
  }
  Future _syncImplement(BaseConfig config) async => _configSet(config.fromJson((await StaticApi(config.fileName).start()).data));

/*
 * 支出Icon配置文件
 */
  //支出Icon配置文件的get方法
  OutComeButtonConfig get outcomeConfig => _configGet(OutComeButtonConfig());

  //支出Icon配置文件的set方法
  set outcomeConfig(OutComeButtonConfig v) => _configSet(v);

/*
 * 收入Icon配置文件
 */
  //收入Icon配置文件的get方法
  InComeButtonConfig get incomeConfig => _configGet(InComeButtonConfig());

  //收入Icon配置文件的set方法
  set incomeConfig(InComeButtonConfig v) => _configSet(v);
}
