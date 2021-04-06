import 'package:get/get.dart';
import 'package:xiao_yu_ji_zhang/logic/account/manager.dart';
import 'package:xiao_yu_ji_zhang/page/main/page.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  Future login() async {
    if (_controller.text.length == 0) {
      BotToast.showText(text: "用户名不能为空");
      return;
    }
    BotToast.showLoading();
    var res = await AccountManager.instance.login(_controller.text);
    BotToast.closeAllLoading();
    if (res["success"]) {
      Get.offAll(() => MainPage());
    } else {
      BotToast.showText(text: res["message"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(icon: Icon(Icons.account_box_outlined), labelText: "用户名"),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: login , child: Text("登录"))
        ],
      ),),
    );
  }
}
