import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:farma_segura_app/widgets/email_text_field_builder.dart';
import 'package:farma_segura_app/widgets/error_dialog_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_text_field.dart';
import '../constants.dart';

enum FormStatus {
  editing,
  sending,
  successful,
}

class ForgotPasswordButton extends StatefulWidget {
  @override
  _ForgotPasswordButtonState createState() => _ForgotPasswordButtonState();
}

class _ForgotPasswordButtonState extends State<ForgotPasswordButton> {
  var _formStatus = FormStatus.editing;
  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) {
              final emailController = TextEditingController();
              final mediaQuery = MediaQuery.of(ctx);
              final keyboardPadding = mediaQuery.viewInsets.bottom;
              return SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: keyboardPadding + 20,
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    children: [
                      Text('Esqueci minha senha',
                          style: TextStyle(fontSize: 20)),
                      Text(
                        'Se o seu email estiver cadastrado, vamos lhe enviar um link para redefinição de senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                      Form(
                        key: _forgotPasswordFormKey,
                        child: emailTextFieldBuilder(
                          label: '',
                          hintTextColor: Colors.black26,
                          textColor: Colors.black54,
                          controller: emailController,
                          onSaved: null,
                          cursorColor: Colors.blue,
                          iconColor: Colors.blue,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      _formStatus == FormStatus.sending
                          ? CircularProgressIndicator.adaptive()
                          : _formStatus == FormStatus.successful
                              ? Container(
                                  padding: EdgeInsets.all(5),
                                  height: 55,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 35,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.green, width: 3),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (!_forgotPasswordFormKey.currentState
                                        .validate()) {
                                      return;
                                    }
                                    setState(
                                        () => _formStatus = FormStatus.sending);
                                    try {
                                      await Provider.of<BackendApi>(context,
                                              listen: false)
                                          .forgotPassword(emailController.text);
                                    } catch (error) {
                                      errorDialogBuilder(context: context);
                                    }
                                    setState(() =>
                                        _formStatus = FormStatus.successful);
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Redefinir senha'),
                                ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }),
        child: Text(
          'Esqueci minha senha',
          style: kLabelStyle,
        ),
      ),
    );
  }
}
