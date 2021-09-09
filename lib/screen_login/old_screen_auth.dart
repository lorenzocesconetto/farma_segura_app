// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/backend_api.dart';

// enum AuthMode {
//   Signup,
//   Login,
// }

// class ScreenAuth extends StatelessWidget {
//   static const routeName = '/auth';

//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.blue.shade600,
//                   Colors.blue.withOpacity(.2),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 stops: [0, 1],
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Container(
//               height: deviceSize.height,
//               width: deviceSize.width,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Flexible(
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 20.0),
//                       padding:
//                           EdgeInsets.symmetric(vertical: 8.0, horizontal: 80.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.blue.shade500,
//                         // boxShadow: [
//                         //   BoxShadow(
//                         //     blurRadius: 8,
//                         //     color: Colors.black26,
//                         //     offset: Offset(0, 2),
//                         //   )
//                         // ],
//                       ),
//                       child: Text(
//                         'Farma Segura',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 30,
//                           fontFamily: 'Montserrat',
//                           // fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     flex: deviceSize.width > 600 ? 2 : 1,
//                     child: AuthCard(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AuthCard extends StatefulWidget {
//   @override
//   _AuthCardState createState() => _AuthCardState();
// }

// class _AuthCardState extends State<AuthCard> {
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   AuthMode _authMode = AuthMode.Signup;
//   Map<String, String> _authData = {'email': '', 'password': ''};
//   var _isLoading = false;
//   final _passwordController = TextEditingController();

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text('Ocorreu um erro'),
//         content: Text(message),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Ok'),
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState.validate()) {
//       return;
//     }
//     _formKey.currentState.save();
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       if (_authMode == AuthMode.Login) {
//         // Log user in
//         await Provider.of<BackendApi>(context, listen: false).loginUser(
//           email: _authData['email'],
//           password: _authData['password'],
//         );
//       } else {
//         // Sign user up
//         await Provider.of<BackendApi>(context, listen: false).registerUser(
//             email: _authData['email'],
//             password: _authData['password'],
//             firstName: 'Lorenzo');
//       }
//     } catch (error) {
//       setState(() => _isLoading = false);
//       const errorMessage = 'Tente novamente mais tarde.';
//       _showErrorDialog(errorMessage);
//     }
//   }

//   void _switchAuthMode() {
//     if (_authMode == AuthMode.Login) {
//       setState(() {
//         _authMode = AuthMode.Signup;
//       });
//     } else {
//       setState(() {
//         _authMode = AuthMode.Login;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       elevation: 10.0,
//       child: Container(
//         height: _authMode == AuthMode.Signup ? 340 : 280,
//         constraints:
//             BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 340 : 280),
//         width: deviceSize.width * 0.8,
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Text(
//                   _authMode == AuthMode.Login ? 'Entrar' : 'Cadastro',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'E-Mail'),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value.isEmpty || !value.contains('@')) {
//                       return 'E-mail inválido';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _authData['email'] = value;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Senha'),
//                   obscureText: true,
//                   controller: _passwordController,
//                   validator: (value) {
//                     if (value.isEmpty || value.length < 5) {
//                       return 'Senha deve ter pelo menos 6 caracteres!';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _authData['password'] = value;
//                   },
//                 ),
//                 if (_authMode == AuthMode.Signup)
//                   TextFormField(
//                     enabled: _authMode == AuthMode.Signup,
//                     decoration: InputDecoration(labelText: 'Confirmar senha'),
//                     obscureText: true,
//                     validator: _authMode == AuthMode.Signup
//                         ? (value) {
//                             if (value != _passwordController.text) {
//                               return 'As senhas precisam ser iguais!';
//                             }
//                             return null;
//                           }
//                         : null,
//                   ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 if (_isLoading)
//                   CircularProgressIndicator()
//                 else
//                   RaisedButton(
//                     child: Text(
//                         _authMode == AuthMode.Login ? 'ENTRAR' : 'CADASTRAR'),
//                     onPressed: _submit,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
//                     color: Theme.of(context).primaryColor,
//                     textColor: Theme.of(context).primaryTextTheme.button.color,
//                   ),
//                 FlatButton(
//                   child: Text(_authMode == AuthMode.Signup
//                       ? 'Já sou cadastrado'
//                       : 'Me cadastrar'),
//                   onPressed: _switchAuthMode,
//                   padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   textColor: Theme.of(context).primaryColor,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
