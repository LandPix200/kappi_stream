// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_textfield_shape.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:kappi_stream/api/auth.dart';
import 'package:kappi_stream/logic/nav.dart';
import 'package:kappi_stream/pages/global.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      "Bienvenu sur\nKappi Stream",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Colors.deepOrange,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    GfFormField(
                      controller: email,
                      gfFormFieldType: GfFormFieldType.email,
                      editingbordercolor: Colors.deepOrange,
                      idlebordercolor: Colors.white24,
                      backgroundcolor: Colors.grey.shade100,
                      borderwidth: 1,
                      hintText: "Email",
                      shape: GFTextFieldShape.square,
                      iconPrefix: Icon(Icons.email),
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GfFormField(
                      controller: password,
                      gfFormFieldType: GfFormFieldType.password,
                      editingbordercolor: Colors.deepOrange,
                      idlebordercolor: Colors.white24,
                      borderwidth: 1,
                      backgroundcolor: Colors.grey.shade100,
                      hintText: "Mot de passe",
                      shape: GFTextFieldShape.square,
                      iconPrefix: Icon(Icons.lock),
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GFButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        context.loaderOverlay.show();
                        Future.delayed(Duration(seconds: 3)).then((value) {
                          context.loaderOverlay.hide();
                          pushR(GlobalPage(), context);
                        });
                      },
                      color: Colors.deepOrange,
                      text: "CONNEXION",
                      size: 40,
                      fullWidthButton: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "OU",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GFButton(
                      onPressed: () async {
                        final user = await GoogleSignInApi.login()
                            .onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Un probleme est survenu !"),
                            ),
                          );
                          return null;
                        });
                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Un probleme est survenu !"),
                            ),
                          );
                          return;
                        }
                        print(user);
                      },
                      color: Colors.grey.shade300,
                      text: "CONNEXION AVEC GOOGLE",
                      size: 40,
                      textColor: Colors.black,
                      fullWidthButton: true,
                      icon: Logo(
                        Logos.google,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
