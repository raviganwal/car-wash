import 'package:beep/core/app_validators.dart';
import 'package:beep/core/model/my_team_machine_model.dart';
import 'package:beep/core/model/user_role_model.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/ui/widget/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../widget/button/app_button.dart';

class AddTeamMemberView extends StatefulWidget {
  const AddTeamMemberView({Key? key}) : super(key: key);

  @override
  State<AddTeamMemberView> createState() => _AddTeamMemberViewState();
}

class _AddTeamMemberViewState extends State<AddTeamMemberView> {
  final _formKey = GlobalKey<FormState>();
  final _firsNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.autoValidateModeAddTeamMember = AutovalidateMode.disabled;
      authViewModel.getRoleList();
      authViewModel.getAssignTo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4.0),
              blurRadius: 12.0,
            )
          ]),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black)),
            title: Text(
              "Add Team Member",
              style: GoogleFonts.nunitoSans(
                color: const Color(0xff212121),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            titleSpacing: 0,
            centerTitle: false,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: authViewModel.autoValidateModeAddTeamMember,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20, top: 30),
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30),
          child: Stack(
            children: [
              ListView(
                children: [
                  Text(
                    "First Name",
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppTextField(
                    controller: _firsNameController,
                    hintText: "First Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Last Name",
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppTextField(
                    controller: _lastNameController,
                    hintText: "Last Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Email",
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      } else if (!value.isValidEmail()) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Phone Number",
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppTextField(
                    controller: _phoneNumberController,
                    hintText: "Phone Number",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                    textInputType: TextInputType.phone,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password",
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppTextField(
                    controller: _passwordController,
                    obscureText: false,
                    hintText: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                    textInputType: TextInputType.visiblePassword,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Role",
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: const Color(0xFFEAEAEA),
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Theme(
                      // <- Here
                      data: Theme.of(context).copyWith(
                        // <- Here
                        splashColor: Colors.transparent, // <- Here
                        highlightColor: Colors.transparent, // <- Here
                        hoverColor: Colors.transparent, // <- Here
                      ),
                      child: authViewModel.roleList.isEmpty
                          ? const SizedBox()
                          : DropdownButtonHideUnderline(
                              child: DropdownButton<UserRoleModel>(
                                value: authViewModel.selectedUserRole,
                                icon: SvgPicture.asset(
                                    'assets/svg/arrow-down-icon.svg'),
                                elevation: 16,
                                onChanged: (UserRoleModel? value) {
                                  // This is called when the user selects an item.
                                  authViewModel.selectedUserRole = value!;
                                },
                                items: authViewModel.roleList
                                    .map<DropdownMenuItem<UserRoleModel>>(
                                        (UserRoleModel value) {
                                  return DropdownMenuItem<UserRoleModel>(
                                    value: value,
                                    child: Text(
                                      value.title.toString(),
                                      style: GoogleFonts.nunitoSans(
                                        color: value.title == '-Select-'
                                            ? const Color(0xff898989)
                                            : const Color(0xff212121),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Assign to",
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: const Color(0xFFEAEAEA),
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Theme(
                      // <- Here
                      data: Theme.of(context).copyWith(
                        // <- Here
                        splashColor: Colors.transparent, // <- Here
                        highlightColor: Colors.transparent, // <- Here
                        hoverColor: Colors.transparent, // <- Here
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Machines>(
                          value: authViewModel.selectedAssignedToMachine,
                          icon: SvgPicture.asset(
                              'assets/svg/arrow-down-icon.svg'),
                          elevation: 16,
                          onChanged: (Machines? value) {
                            // This is called when the user selects an item.
                            authViewModel.selectedAssignedToMachine = value!;
                          },
                          items: authViewModel.assignToList
                              .map<DropdownMenuItem<Machines>>(
                                  (Machines value) {
                            return DropdownMenuItem<Machines>(
                              value: value,
                              child: Text(
                                value.machineName.toString(),
                                style: GoogleFonts.nunitoSans(
                                  color: value.machineName == '-Select-'
                                      ? const Color(0xff898989)
                                      : const Color(0xff212121),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 40),
                          child: AppButton(
                            onTap: () {
                              _addMember(authViewModel);
                            },
                            title: "Update",
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AppButton(
                        onTap: () {
                          _addMember(authViewModel);
                        },
                        title: "Add New Member",
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  _addMember(AuthViewModel authViewModel) async {
    if (_formKey.currentState!.validate()) {
      if (authViewModel.selectedUserRole.id == null ||
          authViewModel.selectedUserRole.id == '0') {
        Fluttertoast.showToast(msg: 'Please select role');
      } else if (authViewModel.selectedAssignedToMachine.id == null ||
          authViewModel.selectedAssignedToMachine.id == '0') {
        Fluttertoast.showToast(msg: 'Please select machine');
      } else {
        await authViewModel.addTeamMember(
            firstName: _firsNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            phoneNo: _phoneNumberController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      }
    } else {
      authViewModel.autoValidateModeAddTeamMember = AutovalidateMode.always;
    }
  }
}
