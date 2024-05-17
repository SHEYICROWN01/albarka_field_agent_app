import 'dart:io';
import 'package:albarka_agent_app/app_export.dart';
import 'package:http/http.dart' as http;
class Register extends StatelessWidget {
  const Register({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return const Content();
          },
        );
      },
      child: Text('Create a new account',
          style: TextStyle(color: ColorConstant.primaryColor)),
    );
  }
}

class Content extends StatefulWidget {
  const Content({
    super.key,
  });

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String name = "";
  String phone = "";
  String address = "";
  String username = "";
  String password = "";
  String registrationCode = "";
  bool hidePassword = true;
  String? _mySelection;
  File? _profileImage;
  bool isLoading = false;

  String url = "https://dashboard.albarkaltd.com/mobileapi/branch.php";

  List? data = [];
  Future<String> getSWData() async {
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });
    return "Success";
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  String? _validateImage(File? image) {
    if (image == null) {
      return 'Select a profile picture';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 50,
      padding: const EdgeInsets.all(30),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New account",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text("Create a new account")
                    ],
                  ),
                  //clone button
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          ColorConstant.primaryColor.withOpacity(0.6),
                      radius: 40,
                      backgroundImage: _profileImage != null
                          ? Image.file(_profileImage!).image
                          : null,
                    ),
                    Positioned(
                      top: 55,
                      right: -4,
                      child: Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ReuseableInputFields(
                hintText: 'Email Address',
                errorMsg: 'Enter your valid email address',
                val: email,
                isEmail: true,
                isPass: false,
                len: 0,
              ),
              ReuseableInputFields(
                hintText: 'Full Name',
                errorMsg: 'Enter your full name',
                val: name,
                isEmail: false,
                isPass: false,
                len: 2,
              ),
              ReuseableInputFields(
                  hintText: 'Phone',
                  errorMsg: 'Enter a valid phone number',
                  val: phone,
                  isEmail: false,
                  isPass: false,
                  len: 11),
              ReuseableInputFields(
                hintText: 'Address',
                errorMsg: 'Enter your address',
                val: address,
                isEmail: false,
                isPass: false,
                len: 2,
              ),
              ReuseableInputFields(
                hintText: 'Username',
                errorMsg: 'Enter your username',
                val: username,
                isEmail: false,
                isPass: false,
                len: 2,
              ),
              ReuseableInputFields(
                hintText: 'Password',
                errorMsg: 'Enter your password',
                val: password,
                isEmail: false,
                isPass: true,
                len: 2,
              ),
              ReuseableDropDown(
                hintText: 'Location',
                mySelection: _mySelection,
                data: data,
                itemName: 'branch',
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200]),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Registration Code',
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.lock_person_sharp),
                    ),
                    validator: (val) {
                      if (val != "AlbarkaBusinessSupport") {
                        return "Provide a valid Registration Code";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        registrationCode = val;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              isLoading == true
                  ? const FillLoadingButton()
                  : FillProcessButton(
                      onClick: () => register(),
                      msg: 'Sign up',
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    String? imageValidation = _validateImage(_profileImage);

    if (formKey.currentState!.validate() &&
        imageValidation != null &&
        _mySelection != null) {
      setState(() {
        isLoading = true;
      });

      try {
        final url = Uri.parse(
            "https://dashboard.albarkaltd.com/albarkaAPI/staff_registration.php");
        var request = http.MultipartRequest('POST', url);
        request.fields['fullname'] = name;
        request.fields['email'] = email;
        request.fields['phone'] = phone;
        request.fields['address'] = address;
        request.fields['branch'] = _mySelection.toString();
        request.fields['username'] = username;
        request.fields['password'] = password;

        var pic =
            await http.MultipartFile.fromPath("image", _profileImage!.path);
        request.files.add(pic);

        var response = await request.send();
        var bodyResponse = await response.stream.bytesToString();

        const successMessage = "Member's Information Created Successfully!";
        const failureMessage = "Registration Failed: ";

        if (bodyResponse == successMessage) {
          setState(() {
            isLoading = false; // Set to false on success
          });
          Utils.toastMessage("Registration Successful!");
          Navigator.pop(context);
        } else {
          // Handle failure
          setState(() {
            isLoading = false;
          });

          Utils.toastMessage("$failureMessage$bodyResponse");
        }
      } on SocketException {
        setState(() {
          isLoading = false;
        });
        Utils.toastMessage('No connectivity');
      }
    } else {
      // Show error message for image validation
      Utils.snackBar(imageValidation!, context);
    }
  }
}
