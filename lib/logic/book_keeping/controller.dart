import 'package:xiao_yu_ji_zhang/logic/book_keeping/manager.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';

class DetailListController extends GetxController {
    var outcomeList = [].obs;
    var incomeList = [].obs;
    var detailList = [].obs;
    var outcomeAmount = 0.0.obs;
    var incomeAmount = 0.0.obs;
    void sync() {
        outcomeList.value = BookKeepingManager.instance.outcomeList;
        incomeList.value = BookKeepingManager.instance.incomeList;
        detailList.value = BookKeepingManager.instance.detailList;
        outcomeAmount.value = BookKeepingManager.instance.outcomeAmount;
        incomeAmount.value = BookKeepingManager.instance.incomeAmount;
    }
}