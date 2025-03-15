import 'package:basic_test/controllers/auth_controller.dart';
import 'package:basic_test/data/models/login_model.dart';
import 'package:basic_test/screens/main_layout.dart';
import 'package:basic_test/services/network_caller.dart';
import 'package:basic_test/services/network_response.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _isLoading = false;
  LoginModel loginModel = LoginModel();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login", style: textTheme.displaySmall),
            SizedBox(height: 40),
            _buildLoginForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        children: [
          /// Email text form field
          TextFormField(
            controller: _emailTEController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              label: Text("Email Address"),
              hintText: "Enter your Email",
            ),
          ),

          /// Password text form field
          TextFormField(
            controller: _passwordTEController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              label: Text("Password"),
              hintText: "Enter your Password",
            ),
          ),

          /// submit button
          Visibility(
            visible: !_isLoading,
            replacement: Center(child: CircularProgressIndicator()),
            child: ElevatedButton(
              onPressed: _onPressLoginButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: Size(double.maxFinite, 48),
              ),
              child: Text("Login"),
            ),
          ),
        ],
      ),
    );
  }

  void _onPressLoginButton() async {
    if (_formKey.currentState!.validate()) {
      _isLoading = true;
      setState(() {});
      Map<String, dynamic> loginData = {
        "email": _emailTEController.text.trim(),
        "password": _passwordTEController.text,
      };

      String url = "https://ecom-rs8e.onrender.com/api/auth/login";
      NetworkResponse response = await NetworkCaller().postRequest(
        url,
        loginData,
      );

      if (response.isSuccess) {
        loginModel = LoginModel.fromJson(response.responseData["data"]);
        await AuthController().saveData(loginModel.token!);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainLayout()),
          (_) => false,
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login failed")));
      }
      _isLoading = false;
      setState(() {});
    }
  }
}
