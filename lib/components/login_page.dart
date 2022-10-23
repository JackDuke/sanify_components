// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_import, implementation_imports, unnecessary_new, sort_child_properties_last, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sanify_components/services/api_service.dart';

import '../model/login_model.dart';
import '../utils/progressHUD.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Usare NavigationContext
class _LoginPageState extends State<LoginPage> {
  //Global variables
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword = true;
  late LoginRequestModel requestModel;
  bool isApiCallProcess = false;

  final emailCon = new TextEditingController();
  final passCon = new TextEditingController();

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel(email: '', password: '');
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0, 10),
                              blurRadius: 20)
                        ]),
                    child: Form(
                      key: globalFormKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 25,
                          ),
                          Text('Login',
                              style: Theme.of(context).textTheme.headline2),
                          SizedBox(
                            height: 20,
                          ),
                          new TextFormField(
                            controller: emailCon,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => requestModel.email = input!,
                            validator: (input) => !input!.contains('@')
                                ? 'Email non valida'
                                : null,
                            decoration: new InputDecoration(
                              hintText: 'Email',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          new TextFormField(
                            controller: passCon,
                            keyboardType: TextInputType.text,
                            onSaved: (input) => requestModel.password = input!,
                            validator: (input) => input!.length < 3
                                ? 'La password deve contenere almeno 3 caratteri'
                                : null,
                            obscureText: hidePassword,
                            decoration: new InputDecoration(
                              hintText: 'Password',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.key,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.4),
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (validateAndSave()) {
                                setState(() {
                                  isApiCallProcess = true;
                                });

                                APIService apiService = new APIService();
                                apiService.login(requestModel).then((value) {
                                  setState(() {
                                    isApiCallProcess = false;
                                    emailCon.clear();
                                    passCon.clear();
                                  });
                                  print(value);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         HomePage(user: value),
                                  //   ),
                                  // );
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(200, 50),
                              backgroundColor: Colors.teal.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text('Login'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
