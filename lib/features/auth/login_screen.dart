import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';
import '../../core/theme/string_extension.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.pageBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.pageBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 74, // 👈 important (gives space control)
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {
              Navigator.maybePop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent, // shadow color
                    blurRadius: 0, // softness
                    spreadRadius: 0, // size
                    offset: const Offset(0, 0), // position (x, y)
                  ),
                ],
              ),
              child: SvgPicture.asset(
                "assets/icons/back_arrow.svg",
                height: 20,
              ),
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          /// 🔹 Main Login UI
          // Center(
          //   child: ElevatedButton(
          //     onPressed: isLoading ? null : _handleGoogleLogin,
          //     child: const Text("Sign in with Google"),
          //   ),
          // ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                child: Form(
                  // key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back".capitalizeWords(),
                        style: AppTextStyles.loginHeadingText.copyWith(
                          color: AppColors.textBlackColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Welcome Back! Please Enter Your Details."
                            .capitalizeWords(),
                        style: AppTextStyles.loginSubHeadingText.copyWith(
                          color: AppColors.textGreyColor,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "Email",
                        style: AppTextStyles.labelText.copyWith(
                          color: AppColors.textBlackColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 55,
                        child: TextFormField(
                          // controller: emailController,
                          cursorColor: AppColors.textBlackColor,
                          style: AppTextStyles.inputText.copyWith(
                            color: AppColors.textBlackColor,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your email'.capitalizeWords(),
                            hintStyle: const TextStyle(
                              color: AppColors.textGreyColor,
                            ),
                            filled: true,
                            fillColor: Colors.white, // #fff
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // 5px
                              borderSide: BorderSide.none, // no border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // 5px
                              borderSide: BorderSide.none, // no border
                            ),
                          ),
                        ),
                      ),
                      // Error Message (separate)
                      // if (emailError != null)
                      //   Padding(
                      //     padding: const EdgeInsets.only(top: 6, left: 8),
                      //     child: Text(
                      //       emailError!,
                      //       style: TextStyle(color: Colors.red, fontSize: 12),
                      //     ),
                      //   ),
                      const SizedBox(height: 18),
                      Text(
                        "Password",
                        style: AppTextStyles.labelText.copyWith(
                          color: AppColors.textBlackColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 55,
                        child: TextFormField(
                          // controller: passwordController,
                          cursorColor: AppColors.textBlackColor,
                          obscureText: true,
                          style: AppTextStyles.inputText.copyWith(
                            color: AppColors.textBlackColor,
                          ),
                          decoration: InputDecoration(
                            hintText: '............',
                            // errorText: passwordError,
                            hintStyle: AppTextStyles.hintPassText.copyWith(
                              color: AppColors.textGreyColor,
                            ),
                            filled: true,
                            fillColor: Colors.white, // #fff
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // 5px
                              borderSide: BorderSide.none, // no border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // 5px
                              borderSide: BorderSide.none, // no border
                            ),
                          ),
                        ),
                      ),
                      // if (passwordError != null)
                      //   Padding(
                      //     padding: const EdgeInsets.only(top: 6, left: 8),
                      //     child: Text(
                      //       passwordError!,
                      //       style: TextStyle(color: Colors.red, fontSize: 12),
                      //     ),
                      //   ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: isChecked,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                side: const BorderSide(
                                  color: AppColors.textGreyColor,
                                  width: 1,
                                ),
                                activeColor: AppColors.primaryColor, // checked color
                                checkColor: Colors.white, // tick color
                                onChanged: (value) {
                                  // setState(() {
                                  //   isChecked = value!;
                                  // });
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  //   isChecked = !isChecked;
                                  // });
                                },
                                child: Text(
                                  "Remember For 30 Days".capitalizeWords(),
                                  style: AppTextStyles.inputText.copyWith(
                                    color: AppColors.textGreyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              print("Forgot Password clicked");
                            },
                            child: Text(
                              "forgot password?".capitalizeWords(),
                              style: AppTextStyles.labelText.copyWith(
                                color: AppColors.textGreyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            // setState(() {
                            //   emailError = null;
                            //   passwordError = null;
                            // });
                            //
                            // String email = emailController.text.trim();
                            // String password = passwordController.text.trim();
                            //
                            // // Email Validation
                            // if (email.isEmpty) {
                            //   emailError = "Email required".capitalizeWords();
                            // } else if (!RegExp(
                            //   r'\S+@\S+\.\S+',
                            // ).hasMatch(email)) {
                            //   emailError = "Enter valid email"
                            //       .capitalizeWords();
                            // }
                            //
                            // // Password Validation
                            // if (password.isEmpty) {
                            //   passwordError = "Password required"
                            //       .capitalizeWords();
                            // } else if (password.length < 6) {
                            //   passwordError = "Minimum 6 characters"
                            //       .capitalizeWords();
                            // }

                            setState(() {});
                          },
                          child: Text(
                            "Sign in".capitalizeWords(),
                            style: AppTextStyles.btnText.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            backgroundColor: AppColors.whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            // setState(() {
                            //   isLoading = true;
                            // });
                            // final user = await AuthService().signInWithGoogle();
                            //
                            // if (user != null) {
                            //   // Save login status
                            //   final prefs =
                            //   await SharedPreferences.getInstance();
                            //   await prefs.setBool("isLoggedIn", true);
                            //
                            //   Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (_) => const HomeScreen(),
                            //     ),
                            //   );
                            // }
                            // setState(() {
                            //   isLoading = false;
                            // });
                          },

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/ic_google.svg",
                                height: 22,
                              ),
                              // Image.asset(
                              //   "assets/icons/google.png",
                              //   height: 22,
                              // ),
                              const SizedBox(width: 10),
                              Text(
                                "Sign in with google".capitalizeWords(),
                                style: AppTextStyles.btnText.copyWith(
                                  color: AppColors.textBlackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            backgroundColor: AppColors.whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            // final authService = AuthService();
                            // final userCredential = await authService.signInWithFacebook();
                            //
                            // if (userCredential != null) {
                            //   final user = userCredential.user;
                            //   print('Logged in: ${user?.displayName}');
                            //   // Navigate to home screen
                            // }
                          },

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/ic_facebook.svg",
                                height: 22,
                              ),
                              // Image.asset(
                              //   "assets/icons/google.png",
                              //   height: 22,
                              // ),
                              const SizedBox(width: 10),
                              Text(
                                "Sign in with facebook".capitalizeWords(),
                                style: AppTextStyles.btnText.copyWith(
                                  color: AppColors.textBlackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account?".capitalizeWords(),
                            style: AppTextStyles.inputText.copyWith(
                              color: AppColors.textGreyColor,
                            ),
                          ),
                          SizedBox(width: 10),

                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const SignupScreen(),
                              //   ),
                              // );
                              // print("Sign Up for free clicked");
                            },
                            child: Text(
                              "Sign Up for free".capitalizeWords(),
                              style: AppTextStyles.inputText.copyWith(
                                color: AppColors.textBlackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          /// 🔹 Loader Overlay
          // if (isLoading)
          //   Container(
          //     color: Colors.black.withOpacity(0.4),
          //     child: const Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
