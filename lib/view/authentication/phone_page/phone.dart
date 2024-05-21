import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/widgets/snack_bar_widgets.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget().text(
          data: "OTP",
          size: 24.0,
          weight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: colors().blue,
        elevation: 0,
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Consumer<AuthenticationProvider>(
                  builder: (context, value, child) => TextFormField(
                    controller: pro.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              countryListTheme: CountryListThemeData(
                                bottomSheetHeight: 500,
                              ),
                              onSelect: (value) {
                                pro.selectCountry = value;
                              },
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${value.selectCountry.flagEmoji}",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(width: size.width * .03),
                              Text(
                                "+${value.selectCountry.phoneCode}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      labelText: 'Enter Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: colors().blue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: colors().blue,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * .02),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      try {
                        if (pro.phoneController.text.length == 10) {
                          pro.getOtp(
                            "+${pro.selectCountry.phoneCode}${pro.phoneController.text}",
                          );
                          snackBarWidget().iconSnackSuccess(context,
                              label: "OTP sent Successfully");
                        } else {
                          snackBarWidget().iconSnackFail(context,
                              label: "Please check your mobile number");
                        }
                      } catch (e) {}
                    }
                    pro.showOtp();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors().blue,
                    // primary: ,
                    shape:
                        // Rounded
                        // style:
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  child: TextWidget().text(
                    data: "Send OTP",
                    size: 18.0,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0),
                Consumer<AuthenticationProvider>(
                  builder: (context, value, child) {
                    if (value.showOtpField == true) {
                      return Column(
                        children: [
                          TextFormField(
                            controller: pro.otpController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter OTP',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: colors().blue,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: colors().blue,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                try {
                                  pro.verifyOtp(
                                      pro.otpController.text, context);
                                } catch (e) {
                                  snackBarWidget().iconSnackAlert(context,
                                      label: "Invalid OTP $e");
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors().blue,
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: TextWidget().text(
                              data: 'Verify OTP',
                              size: 18.0,
                              weight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
