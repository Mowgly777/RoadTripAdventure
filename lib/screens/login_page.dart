import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:road_trip_adventure/providers/loginProvider.dart';
import 'package:road_trip_adventure/screens/homePage/home_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool hidePass = true;

  void login({required String name, required String pass, required BuildContext context}) async {

    try {

      bool response = await loginReq(name, pass);
      if (context.mounted && response) {

        SnackBar snackBar = SnackBar(
          backgroundColor: Color(0x4000ff00),
          content: Flex(
            direction: Axis.vertical,
            children: [Text('Welcome!')],
            ),
          
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context) {
              return Homepage();
            },
          ),
        );
      }

    } catch(e) {
      print(e);
      
      if (context.mounted) {

        const snackBar = SnackBar(
          backgroundColor: Color(0x55ff0000),
          content: Flex(
            direction: Axis.vertical,
            children: [Text('Unable to log in')],
            ),

        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        print('AN ERROR OCCURRED');
      }
    }
  }

  void togglePassView () {
    setState(() {
      hidePass = !hidePass;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Username',
                      ),
                    ),
                    FormBuilderTextField(
                      name: 'pass',
                      keyboardType: TextInputType.text,
                      obscureText: hidePass,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
        
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: togglePassView,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            final Map<String, dynamic> formData = _formKey.currentState!.value;
                            login(name: formData['name'], pass: formData['pass'], context: context);
                          }
                        },
                        child: Text('login')),
                  ],
                ),
              )
            ]
          )
        ),
      )
    );
  }
}
