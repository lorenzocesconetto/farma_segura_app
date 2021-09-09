import 'package:farma_segura_app/screen_login/widgets/logo.dart';
import 'package:farma_segura_app/widgets/email_text_field_builder.dart';
import 'package:farma_segura_app/widgets/password_text_field_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/backend_api.dart';
import '../widgets/error_dialog_builder.dart';
import './widgets/forgot_password_button.dart';
import '../widgets/submit_button.dart';
import './widgets/signup_button.dart';
import '../widgets/adaptive_scaffold.dart';

class ScreenLogin extends StatefulWidget {
  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  String _authEmail;
  String _authPassword;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() => _isLoading = true);
    try {
      final response =
          await Provider.of<BackendApi>(context, listen: false).loginUser(
        email: _authEmail,
        password: _authPassword,
      );
      if (response.statusCode != 200) {
        throw Exception('Login error');
      }
    } catch (error) {
      setState(() => _isLoading = false);
      errorDialogBuilder(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: null,
      body: Material(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF73AEF5),
                        Color(0xFF61A4F1),
                        Color(0xFF478DE0),
                        Color(0xFF398AE5),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: 85.0,
                      bottom: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Logo(),
                        SizedBox(height: 50),
                        Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                emailTextFieldBuilder(
                                    onSaved: (val) => _authEmail = val),
                                SizedBox(height: 30.0),
                                passwordTextFieldBuilder(
                                  hintLabel: 'Digite sua senha',
                                  onSaved: (val) => _authPassword = val,
                                ),
                                ForgotPasswordButton(),
                                SubmitButton(
                                    onPressed: _submit, isLoading: _isLoading),
                                SignupButton(),
                              ],
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
