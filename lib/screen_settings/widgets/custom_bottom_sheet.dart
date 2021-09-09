import 'package:farma_segura_app/models/profile.dart';
import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:farma_segura_app/widgets/email_text_field_builder.dart';
import 'package:farma_segura_app/widgets/error_dialog_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FormStatus {
  editing,
  sending,
  successful,
}

class CustomBottomSheet extends StatefulWidget {
  final Profile profile;
  CustomBottomSheet(this.profile);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  var _formStatus = FormStatus.editing;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _formEmail;

  void _submit() async {
    setState(() => _formStatus = FormStatus.sending);
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final message = await Provider.of<BackendApi>(context, listen: false)
        .shareProfile(profileId: widget.profile.id, email: _formEmail);
    setState(() => _formStatus = FormStatus.editing);
    if (message == null) {
      Navigator.of(context).pop();
    } else {
      errorDialogBuilder(context: context, message: message);
    }
  }

  void _showModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
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
                  Text('Compartilhar rotina', style: TextStyle(fontSize: 20)),
                  Text(
                    'Compartilhe com seu médico e familiares',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                  Form(
                    key: _formKey,
                    child: emailTextFieldBuilder(
                      label: '',
                      hintTextColor: Colors.black26,
                      hintLabel: 'Email',
                      textColor: Colors.black54,
                      onSaved: (value) => _formEmail = value,
                      cursorColor: Colors.blue,
                      iconColor: Colors.blue,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  _formStatus == FormStatus.sending
                      ? CircularProgressIndicator.adaptive()
                      : _formStatus == FormStatus.successful
                          ? SuccessIcon()
                          : ElevatedButton(
                              onPressed: _submit,
                              child: Text('Compartilhar'),
                            ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // onPressed: () => _showModal(widget.mediaQuery),
      onPressed: _showModal,
      child: Text('Compartilhar'),
    );
  }
}

class SuccessIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 55,
      child: Icon(
        Icons.check,
        color: Colors.green,
        size: 35,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.green, width: 3),
      ),
    );
  }
}
