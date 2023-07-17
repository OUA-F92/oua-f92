import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentoru/utils/colors.dart';
import 'package:mentoru/ui/home/home_page.dart';
import 'package:mentoru/widgets/custom_nav_bar.dart';

import '../../services/auth_methods.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../login/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameSurnameController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _nameSurnameController.dispose();
    _locationController.dispose();
    _occupationController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        locaiton: _locationController.text,
        nameSurname: _nameSurnameController.text,
        occupation: _occupationController.text,
        imageUrl: _image!);
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const CustomNavBar(),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
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
            child: SingleChildScrollView(
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
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "Şimdi başlamak için,\n",
                                    style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w400, fontSize: Get.width / 16),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Kayıt ol!",
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: Get.width / 16),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              _image != null
                                  ? CircleAvatar(
                                      radius: 64,
                                      backgroundImage: MemoryImage(_image!),
                                      backgroundColor: Colors.red,
                                    )
                                  : const CircleAvatar(
                                      radius: 64,
                                      backgroundImage: NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                                      backgroundColor: Colors.red,
                                    ),
                              Positioned(
                                bottom: -10,
                                left: 80,
                                child: IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                              )
                            ],
                          ),
                          CustomTextField(
                            hintText: "İsim Soyisim",
                            controller: _nameSurnameController,
                          ),
                          CustomTextField(
                            hintText: "Kullanıcı adı",
                            controller: _usernameController,
                          ),
                          CustomTextField(
                            hintText: "E-mail",
                            controller: _emailController,
                          ),
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
                          CustomTextField(
                            hintText: "Meslek",
                            controller: _occupationController,
                          ),
                          CustomTextField(
                            hintText: "Nerede Çalışıyorsun",
                            controller: _locationController,
                          ),
                          CustomButton(
                            isBorder: false,
                            isFilled: true,
                            onTap: signUpUser,
                            child: Center(
                                child: _isLoading
                                    ? SizedBox(
                                        width: Get.width * 0.05,
                                        height: Get.width * 0.05,
                                        child: const CircularProgressIndicator(
                                          color: Colors.green,
                                        ),
                                      )
                                    : Text(
                                        "Kayıt ol",
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
                              Navigator.of(context)
                                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                            },
                            child: RichText(
                              text: TextSpan(
                                  text: "Zaten hesabın var mı? ",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    fontSize: Get.width / 30,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Giriş Yap",
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
              ),
            )),
      ),
    );
  }
}
