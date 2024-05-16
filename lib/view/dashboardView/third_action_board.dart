import 'package:albarka_agent_app/app_export.dart';

class ThirdActionBoard extends StatelessWidget {
  const ThirdActionBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.1), // Transparent black for the shadow
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3), // Changes the position of the shadow
          ),
        ],
      ),
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 25),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildExpanded('Update Member ', Icons.update,
                    () => Navigator.pushNamed(context, RouteName.updateMember)),
                buildExpanded('Member Data', Icons.data_saver_off,
                    () => Navigator.pushNamed(context, RouteName.memberData)),
                buildExpanded(
                    'Transactions by Date',
                    Icons.money,
                    () => Navigator.pushNamed(
                        context, RouteName.transactionByDate)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildExpanded('Note', Icons.note_alt_outlined,
                    () => Navigator.pushNamed(context, RouteName.noteView)),
                buildExpanded('Expenses ', Icons.account_balance_wallet_sharp,
                    () => Navigator.pushNamed(context, RouteName.dailyExpense)),
                buildExpanded(
                    'Account Report',
                    Icons.book,
                    () =>
                        Navigator.pushNamed(context, RouteName.accountSummary)),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       buildExpanded('Loan by Date', Icons.monetization_on_sharp,
          //               () => Navigator.pushNamed(context, RouteName.loanByDate)),
          //
          //       buildExpanded('Contact us', Icons.account_circle,
          //           () => Navigator.pushNamed(context, RouteName.contactUS)),
          //       getUsername.username == "optimum"
          //           ? buildExpanded(
          //               'Management',
          //               Icons.person,
          //               () => Navigator.pushNamed(
          //                   context, RouteName.managementScreen))
          //           : Expanded(
          //               child: Column(
          //                 children: [
          //                   Material(
          //                     borderRadius: BorderRadius.circular(20),
          //                     clipBehavior: Clip.hardEdge,
          //                     color: Colors.white,
          //                     child: Container(
          //                       height: 60,
          //                       width: 60,
          //                       padding:
          //                           const EdgeInsets.symmetric(vertical: 10),
          //                       child: const Icon(
          //                         Icons.add,
          //                         color: Colors.white,
          //                         size: 30,
          //                       ),
          //                     ),
          //                   ),
          //                   const SizedBox(height: 5),
          //                   const Text(
          //                     '',
          //                     style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: 13,
          //                       fontWeight: FontWeight.w600,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Expanded buildExpanded(
      String text, IconData iconData, void Function() onTap) {
    return Expanded(
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
            color: ColorConstant.primaryColor.withOpacity(0.1),
            child: InkWell(
              onTap: onTap,
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Icon(
                  iconData,
                  color: ColorConstant.primaryColor,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
