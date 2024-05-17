import '../app_export.dart';

class FillProcessButton extends StatelessWidget {
  Function onClick;
  String msg;
   FillProcessButton({
    super.key,
    required this.onClick,
     required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
          backgroundColor: ColorConstant.primaryColor),
      onPressed: () => onClick,
      child:  SizedBox(
        width: double.infinity,
        child: Center(child: Text(msg)),
      ),
    );
  }
}