import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoru/ui/home/home_page.dart';
import 'package:mentoru/ui/register/register_page.dart';
import 'package:mentoru/utils/utils.dart';

import '../../utils/colors.dart';
import '../../services/auth_methods.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void login() async {
    _isLoading = true;

    String response = await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);

    if (response == "success") {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(response, context);
    }

    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          "assets/image/LOGO.png",
                          width: Get.width / 10,
                          height: Get.width / 10,
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Hoşgeldin,\n",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: Get.width / 16),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Seni görmek güzel!",
                                      style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w400, fontSize: Get.width / 16),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        CustomTextField(hintText: "E-mail", controller: _emailController),
                        CustomTextField(
                          hintText: "Şifre",
                          obscureText: true,
                          controller: _passwordController,
                          suffixIcon: Container(
                            margin: const EdgeInsets.all(15),
                            child: Image.asset(
                              "assets/icons/hide.png",
                              width: 5,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 35),
                            child: Text(
                              "Şifremi Unuttum",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Get.width / 30,
                              ),
                            ),
                          ),
                        ),
                        CustomButton(
                          isBorder: false,
                          isFilled: true,
                          onTap: login,
                          child: Center(
                              child: _isLoading
                                  ? SizedBox(
                                      width: Get.width * 0.05,
                                      height: Get.width * 0.05,
                                      child: const CircularProgressIndicator(
                                        color: Colors.green,
                                      ))
                                  : Text(
                                      "Giriş Yap",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: Get.width / 24),
                                    )),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(thickness: 1, color: Colors.black45),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  "Birlikte giriş yap",
                                  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black45),
                                ),
                              ),
                              Expanded(
                                child: Divider(thickness: 1, color: Colors.black45),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CustomButton(
                              isBorder: true,
                              isFilled: false,
                              onTap: () {},
                              child: Image.asset(
                                "assets/icons/google.png",
                                width: Get.width * 0.06,
                                height: Get.width * 0.06,
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: CustomButton(
                              isBorder: true,
                              isFilled: false,
                              onTap: () {},
                              child: Image.asset(
                                "assets/icons/apple-logo.png",
                                width: Get.width * 0.06,
                                height: Get.width * 0.06,
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 35),
                        child: GestureDetector(
                          onTap: () {
                            Get.offAll(const RegisterPage());
                          },
                          child: RichText(
                            text: TextSpan(
                                text: "Hesabın yok mu ",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.width / 30,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Şimdi Kayıt Ol",
                                    style: TextStyle(
                                      color: purpleColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: Get.width / 30,
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
