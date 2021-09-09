import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:farma_segura_app/widgets/name_text_field_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/cpf_text_field_builder.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/submit_button.dart';
import '../widgets/adaptive_appbar.dart';
import '../widgets/adaptive_scaffold.dart';
import '../widgets/email_text_field_builder.dart';
import '../widgets/password_text_field_builder.dart';

class ScreenRegistration extends StatefulWidget {
  @override
  _ScreenRegistrationState createState() => _ScreenRegistrationState();
}

class _ScreenRegistrationState extends State<ScreenRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _registrationPassword;
  String _registrationEmail;
  String _registrationLastName;
  String _registrationFirstName;
  String _registrationCpf;
  var _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState.validate()) return;
    setState(() => _isLoading = true);
    _formKey.currentState.save();

    try {
      // final response =
      await Provider.of<BackendApi>(context, listen: false).registerUser(
        email: _registrationEmail,
        password: _registrationPassword,
        firstName: _registrationFirstName,
        lastName: _registrationLastName,
        cpf: _registrationCpf,
      );
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    } catch (error) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBarBuilder(''),
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
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 50.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Cadastro',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                cpfTextFieldBuilder(
                                    onSaved: (value) =>
                                        _registrationCpf = value),
                                SizedBox(height: 30.0),
                                nameTextFieldBuilder(
                                  onSaved: (value) =>
                                      _registrationFirstName = value,
                                ),
                                SizedBox(height: 30.0),
                                nameTextFieldBuilder(
                                  label: 'Sobrenome',
                                  hintLabel: 'Sobrenome',
                                  onSaved: (value) =>
                                      _registrationLastName = value,
                                ),
                                SizedBox(height: 30.0),
                                emailTextFieldBuilder(
                                  onSaved: (val) => _registrationEmail = val,
                                  hintTextColor: Colors.black26,
                                  backgroundColor: Colors.white,
                                  cursorColor: Colors.black54,
                                  textColor: Colors.black54,
                                  iconColor: Colors.black54,
                                ),
                                SizedBox(height: 30.0),
                                passwordTextFieldBuilder(
                                  onSaved: (val) => _registrationPassword = val,
                                  hintTextColor: Colors.black26,
                                  backgroundColor: Colors.white,
                                  cursorColor: Colors.black54,
                                  textColor: Colors.black54,
                                  iconColor: Colors.black54,
                                ),
                                SubmitButton(
                                  label: 'ME CADASTRAR',
                                  onPressed: _submit,
                                  isLoading: _isLoading,
                                  // backgroundColor: Colors.blue,
                                  // backgroundColor:Color.fromRGBO(115, 174, 245, 1),
                                  // backgroundColor: Color.fromRGBO(97, 164, 241, 1),
                                  backgroundColor:
                                      Color.fromRGBO(71, 141, 224, 1),
                                  // backgroundColor: Color.fromRGBO(57, 138, 229, 1),
                                  textColor: Colors.white,
                                ),
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
