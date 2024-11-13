import 'package:fluttertoast/fluttertoast.dart';

showToastMessage({required String msg}) {
  return Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.CENTER,
  );
}
