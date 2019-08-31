import 'package:path_provider/path_provider.dart';
import 'package:yun_dao/db_manager.dart';
import 'package:eso/entity/Rule_entity.dao.dart';

class SqlGlobal {

  Future<void> init() async {
    var appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print(appDocPath);
    DBManager dbManager = new DBManager();
    await dbManager.initByPath(1, appDocPath, "eso.db");

    //初始化表
    RuleDao.init();
  }
}