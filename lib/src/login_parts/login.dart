import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'authentication_error.dart';
import 'registration.dart';
import '../app.dart';

class Login extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<Login> {

  String login_Email = "";  // 入力されたメールアドレス
  String login_Password = "";  // 入力されたパスワード
  String infoText = "";  // ログインに関する情報を表示

  // Firebase Authenticationを利用するためのインスタンス
  final FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential result;
  late User user;

  // エラーメッセージを日本語化するためのクラス
  final auth_error = Authentication_error();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            // メールアドレスの入力フォーム
            Padding(
                padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child:TextFormField(
                  decoration: InputDecoration(
                      labelText: "メールアドレス"
                  ),
                  onChanged: (String value) {
                    login_Email = value;
                  },
                )
            ),

            // パスワードの入力フォーム
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 10.0),
              child:TextFormField(
                decoration: InputDecoration(
                    labelText: "パスワード（8～20文字）"
                ),
                obscureText: true,  // パスワードが見えないようRにする
                maxLength: 20,  // 入力可能な文字数
                maxLengthEnforcement: MaxLengthEnforcement.none,   // 入力可能な文字数の制限を超える場合の挙動の制御
                onChanged: (String value) {
                  login_Password= value;
                },
              ),
            ),

            // ログイン失敗時のエラーメッセージ
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
              child:Text(infoText,
                style: TextStyle(color: Colors.red),),
            ),

            ButtonTheme(
              minWidth: 350.0,
              // height: 100.0,
              child: ElevatedButton(
                  child: Text('ログイン',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: () async {
                    try {
                      // メール/パスワードでユーザー登録
                      result = await auth.signInWithEmailAndPassword(
                        email: login_Email,
                        password: login_Password,
                      );

                      // ログイン成功
                      // ログインユーザーのIDを取得
                      user = result.user!;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyStatefulWidget(user_id: user.uid),
                          )
                      );

                    } catch (e) {
                      // ログインに失敗した場合
                      setState(() {
                        infoText = auth_error.login_error_msg(e.toString());
                      });
                    }
                  }
              ),
            ),
          ],
        ),
      ),

      // 画面下にボタンの配置
      bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(8.0),
              child:ButtonTheme(
                minWidth: 350.0,
                // height: 100.0,
                child: ElevatedButton(
                    child: Text('アカウントを作成する',
                      style: TextStyle(fontWeight: FontWeight.bold),),

                    // ボタンクリック後にアカウント作成用の画面の遷移する。
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (BuildContext context) => Registration(),
                        ),
                      );
                    }

                ),
              ),
            ),
          ]),
    );
  }
} 