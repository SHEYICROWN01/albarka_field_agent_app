// ignore: file_names
import 'dart:io';

import 'package:albarka_agent_app/app_export.dart';
import 'package:albarka_agent_app/db_helper/getSavingsModel.dart';
import 'package:http/http.dart' as http;

class LocalActivities extends StatefulWidget {
  const LocalActivities({Key? key}) : super(key: key);

  @override
  State<LocalActivities> createState() => _LocalActivitiesState();
}

class _LocalActivitiesState extends State<LocalActivities> {
  bool _processing = false;
  List<getSavingsModel> _savingsList = [];
  int _currentIndex = 0;

  Future<List<getSavingsModel>> _getData() async {
    final getAgentDetails = Provider.of<AuthViewModel>(context, listen: false);
    final savings = await DatabaseHelper.instance
        .getAllSavings(getAgentDetails.username.toString());
    setState(() {
      _savingsList = savings;
    });
    return _savingsList;
  }

  Future<void> _processItem(int index) async {
    final getAgentDetails = Provider.of<AuthViewModel>(context, listen: false);
    setState(() {
      _processing = true;
    });
    try {
      final url = Uri.parse(
          "https://dashboard.albarkaltd.com/albarkaAPI/insertContribution.php");
      final request = http.MultipartRequest('POST', url);
      request.fields['member_id'] = _savingsList[index].memberID.toString();
      request.fields['member_Name'] = _savingsList[index].memberName.toString();
      request.fields['Amount'] = _savingsList[index].amount.toString();
      request.fields['date'] = _savingsList[index].dateNow.toString();
      request.fields['contributionType'] =
          _savingsList[index].contributionType.toString();
      request.fields['Branch'] = _savingsList[index].branch.toString();
      request.fields['agentId'] = getAgentDetails.userid.toString();
      request.fields['date2'] = _savingsList[index].dateTime.toString();
      request.fields['transactionType'] =
          _savingsList[index].transactionType.toString();

      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        await DatabaseHelper.instance.deleteRecordByID(
          'savings',
          _savingsList[index].id,
        );

        Utils.toastMessage(responseString);

        //   if (_currentIndex < _savingsList.length - 1) {
        //     _currentIndex++;
        //     await _processItem(_currentIndex);
        //   }
        // } else if (response.statusCode == 400) {
        //   Utils.toastMessage(responseString);
        //   _currentIndex = 0;
        // }
      }
    } on SocketException {
      Utils.toastMessage('No Internet');
    } finally {
      setState(() {
        _processing = false;
      });
    }
  }

  // Future<void> _uploadAll() async {
  //   _currentIndex = 0;
  //   await _processItem(_currentIndex);
  // }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: const Text('Local Savings'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, RouteName.dashboardView);
              },
              icon: const Icon(null),
              label: Text(
                'Move to dashboard',
                style: TextStyle(color: ColorConstant.primaryColor),
              ))
        ],
      ),
      body: FutureBuilder<List<getSavingsModel>>(
        future: _getData(),
        builder: (context, AsyncSnapshot<List<getSavingsModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: ColorConstant.primaryColor,
              color: Colors.green,
            ));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  width: double.maxFinite,
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(10),
                    elevation: 5,
                    child: ListTile(
                      trailing: GestureDetector(
                          onTap: () {
                            _showLogoutDialog(context, index);
                            AlertDialog(
                              title: Text("Delete Savings".toUpperCase()),
                              content: const Text(
                                  "Are you sure you want to delete savings."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("No"),
                                ),
                              ],
                            );
                          },
                          child: const Icon(Icons.delete, color: Colors.red)),
                      leading: _processing == true
                          ? const CircularProgressIndicator()
                          : ElevatedButton.icon(
                              onPressed: () {
                                _processItem(index);
                              },
                              icon: const Icon(Icons.upload,
                                  size: 12, color: Colors.white),
                              label: const Text(''),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.primaryColor)),
                      title: Text(
                        'Account N0: ${snapshot.data?[index].memberID}',
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fullname: ${snapshot.data?[index].memberName}',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Amount ₦:${snapshot.data?[index].amount}',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Transaction Type: ${snapshot.data?[index].transactionType}',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${snapshot.data?[index].dateNow}',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      // floatingActionButton: _processing == true
      //     ? FloatingActionButton(
      //         onPressed: () {},
      //         child: const CircularProgressIndicator(strokeWidth: 3),
      //       )
      //     : FloatingActionButton(
      //         onPressed: _uploadAll,
      //         child: const Icon(Icons.cloud_upload),
      //       ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context, int index) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Delete Savings".toUpperCase(),
            text: "Are you sure you want to delete savings?",
            confirmButtonText: "Yes, Delete",
            type: ArtSweetAlertType.warning));

    // ignore: unrelated_type_equality_checks
    if (response == false) {
      return;
    }

    if (response.isTapConfirmButton) {
      await DatabaseHelper.instance.deleteRecordByID(
        'savings',
        _savingsList[index].id,
      );
      Utils.toastMessage('Savings deleted');
      //Navigator.pop(context);
      //Navigator.pop(context);

      return;
    }
  }
}
