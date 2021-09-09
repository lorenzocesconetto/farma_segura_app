import 'package:farma_segura_app/models/profile.dart';
import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:farma_segura_app/providers/profiles.dart';
import 'package:farma_segura_app/widgets/adaptive_appbar.dart';
import 'package:farma_segura_app/widgets/adaptive_scaffold.dart';
import 'package:farma_segura_app/widgets/cpf_text_field_builder.dart';
import 'package:farma_segura_app/widgets/error_dialog_builder.dart';
import 'package:farma_segura_app/widgets/name_text_field_builder.dart';
import 'package:farma_segura_app/widgets/submit_button.dart';
import 'package:farma_segura_app/widgets/text_field_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ScreenAddSubProfile extends StatefulWidget {
  static const routeName = 'add_sub_profile';

  @override
  _ScreenAddSubProfileState createState() => _ScreenAddSubProfileState();
}

class _ScreenAddSubProfileState extends State<ScreenAddSubProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  String _subProfileCpf;
  String _subProfileUsername;
  String _subProfileFirstName;
  String _subProfileLastName;
  String validateUsernameResult;
  final _usernameController = TextEditingController();

  Future<String> _validateUsername(BuildContext context) async {
    if (_usernameController.text.isEmpty || _usernameController.text.length < 3)
      return '  Deve ter pelo menos 3 caracteres';
    final isAvailable = await Provider.of<BackendApi>(context, listen: false)
        .checkUsername(_usernameController.text);
    if (isAvailable == null) return '  Sem conexão de internet';
    if (isAvailable) return null;
    return '  Nome de usuário não disponível';
  }

  void _submit(BuildContext context) async {
    setState(() => _isLoading = true);
    validateUsernameResult = await _validateUsername(context);
    if (!_formKey.currentState.validate()) {
      setState(() => _isLoading = false);
      return;
    }
    _formKey.currentState.save();
    final Profile profile = Profile(
      id: null,
      firstName: _subProfileFirstName,
      lastName: _subProfileLastName,
      username: _subProfileUsername,
      cpf: _subProfileCpf,
      notificationsOn: true,
      isOwner: true,
    );
    final wasSuccessful =
        await Provider.of<Profiles>(context, listen: false).addProfile(profile);
    setState(() => _isLoading = false);
    if (wasSuccessful) {
      Navigator.of(context).pop();
    } else {
      errorDialogBuilder(
          message: 'Tente novamente mais tarde', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBarBuilder('Criar perfil'),
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
                          'Novo perfil',
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
                              nameTextFieldBuilder(
                                keyboardType: TextInputType.text,
                                inputFormatters: [
                                  LowerCaseTextFormatter(),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9a-zA-Z\._]")),
                                ],
                                controller: _usernameController,
                                label: 'Nome de usuário',
                                hintLabel: 'Usuário',
                                validator: (value) => validateUsernameResult,
                                onSaved: (value) => _subProfileUsername = value,
                              ),
                              SizedBox(height: 30.0),
                              cpfTextFieldBuilder(
                                onSaved: (value) => _subProfileCpf = value,
                              ),
                              SizedBox(height: 30.0),
                              nameTextFieldBuilder(
                                onSaved: (value) =>
                                    _subProfileFirstName = value,
                              ),
                              SizedBox(height: 30.0),
                              nameTextFieldBuilder(
                                label: 'Sobrenome',
                                hintLabel: 'Sobrenome',
                                onSaved: (value) => _subProfileLastName = value,
                              ),
                              SubmitButton(
                                label: 'CRIAR PERFIL',
                                onPressed: () => _submit(context),
                                isLoading: _isLoading,
                                backgroundColor:
                                    Color.fromRGBO(71, 141, 224, 1),
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                        )
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
