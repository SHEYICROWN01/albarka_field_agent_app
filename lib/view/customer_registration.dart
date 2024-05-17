import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:albarka_agent_app/app_export.dart';

class CustomerRegistration extends StatefulWidget {
  const CustomerRegistration({
    super.key,
  });

  @override
  State<CustomerRegistration> createState() => _CustomerRegistrationState();
}

class _CustomerRegistrationState extends State<CustomerRegistration> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  late DateTime selectedDate;
  String email = "";
  String firstname = "";
  String lastname = "";
  String phone = "";
  String address = "";
  String rate = "";
  String occupation = "";
  String representative = "";
  String? _mySelection;
  File? _profileImage;
  bool isLoading = false;

  String dropdownValue = 'Gender';
  String dropMaritalStatus = 'Marital Status';
  String dropAgeRange = 'Age Range';
  String dropIdType = 'ID Type';
  String locationName = 'Location';
  String? dataIdType;
  String? dataGender;
  String? ageRange;
  String? maritalStatus;

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
      return 'Please pick an image';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getSWData();
    // Initialize selectedDate with the current date
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    occupationController.dispose();
    rateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getAgentDetails = Provider.of<AuthViewModel>(context, listen: false);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height - 50,
        padding: const EdgeInsets.all(20),
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
                      icon: Icon(
                        Icons.close,
                        color: ColorConstant.primaryColor,
                      ),
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
                  hintText: 'Full Name',
                  errorMsg: 'Enter your full name',
                  val: firstname,
                  isEmail: false,
                  isPass: false,
                  len: 2,
                ),
                ReuseableInputFields(
                  hintText: 'Last Name',
                  errorMsg: 'Enter your last name',
                  val: lastname,
                  isEmail: false,
                  isPass: false,
                  len: 2,
                ),
                ReuseableInputFields(
                  hintText: 'Phone Number',
                  errorMsg: 'Enter your full name',
                  val: phone,
                  isEmail: false,
                  isPass: false,
                  len: 11,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ReuseableLocalDropDown(
                      val: maritalStatus,
                      dropDownValue: dropMaritalStatus,
                      items: const [
                        'Marital Status',
                        'Single',
                        'Married',
                        'Divorce',
                      ],
                    ),
                    ReuseableLocalDropDown(
                      val: dataGender,
                      dropDownValue: dropdownValue,
                      items: const [
                        'Gender',
                        'Male',
                        'Female',
                      ],
                    ),
                    Container(
                      height: 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[200]),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Text('DOB',),
                          IconButton(
                            icon: Icon(Icons.date_range_outlined,
                                color: ColorConstant.black900),
                            onPressed: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );

                              if (pickedDate != null &&
                                  pickedDate != selectedDate) {
                                setState(() {
                                  selectedDate = pickedDate;
                                  ageRange =
                                      '${selectedDate.day.toString()}-${selectedDate.month.toString()}';
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ReuseableInputFields(
                  hintText: 'Address',
                  errorMsg: "Required Customer's Address",
                  val: address,
                  isEmail: false,
                  isPass: false,
                  len: 2,
                ),
                ReuseableInputFields(
                  hintText: 'Occupation',
                  errorMsg: "Required Customer's Occupation",
                  val: occupation,
                  isEmail: false,
                  isPass: false,
                  len: 2,
                ),
                ReuseableDropDown(
                  hintText: 'Location',
                  mySelection: _mySelection,
                  data: data,
                  itemName: 'branch',
                ),
                ReuseableInputFields(
                  hintText: 'Rate',
                  errorMsg: "Rate can't be 0",
                  val: rate,
                  isEmail: false,
                  isPass: false,
                  len: 2,
                ),
                const SizedBox(height: 20),
                isLoading == true
                    ? const FillLoadingButton()
                    : FillProcessButton(
                        onClick: () => _registerCustomer(
                            getAgentDetails.username.toString()),
                        msg: 'Register',
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registerCustomer(String getRepresentative) async {
    String? imageValidation = _validateImage(_profileImage);
    if (dropdownValue == 'Gender') {
      Utils.snackBar('Gender is Required', context);
    } else if (dropMaritalStatus == 'Marital Status') {
      Utils.snackBar('Martial Status is Required', context);
    } else if (formKey.currentState!.validate() && imageValidation == null) {
      setState(() {
        isLoading = true;
      });
      try {
        final url = Uri.parse(
            "https://dashboard.albarkaltd.com/albarkaAPI/customerRegistration.php");
        var request = http.MultipartRequest('POST', url);

        request.fields['firstname'] = firstname;
        request.fields['lastname'] = lastname;
        request.fields['dob'] = ageRange!;
        request.fields['gender'] = dataGender!;
        request.fields['maritalStatus'] = maritalStatus!;
        request.fields['rate'] = rate;
        request.fields['occupation'] = occupation;
        request.fields['phoneNumber'] = phone;
        request.fields['email'] = 'albarkaltd@gmail.com';
        request.fields['address'] = address;
        request.fields['branch'] = _mySelection.toString();
        request.fields['representative'] = getRepresentative;
        request.fields['userLat'] = '7.145244';
        request.fields['userLong'] = '3.327695';

        var pic =
            await http.MultipartFile.fromPath("image", _profileImage!.path);
        request.files.add(pic);
        var response = await request.send();
        var bodyResponse = await response.stream.bytesToString();

        if (bodyResponse !=
            "Unable to Insert Member Records.....Please try again later") {
          setState(() {
            isLoading = false;
          });
          CoolAlert.show(
            barrierDismissible: false,
            context: context,
            type: CoolAlertType.success,
            title: "Successful",
            text: bodyResponse,
          );
          firstnameController.clear();
          lastnameController.clear();
          phoneController.clear();
          emailController.clear();
          addressController.clear();
          occupationController.clear();
          rateController.clear();
        } else if (bodyResponse ==
            "Unable to Insert Member Records.....Please try again later") {
          setState(() {
            isLoading = false;
          });
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Oops...",
            text:
                "Account Number Already Exist.\n Use a different account number",
          );
        }
      } on SocketException {
        setState(() {
          isLoading = false;
        });
        Utils.snackBar('No Internet Connectivity', context);
      }
    }
  }
}
