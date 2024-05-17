import '../app_export.dart';

class FillLoadingButton extends StatelessWidget {
  const FillLoadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
          backgroundColor: ColorConstant.primaryColor),
      onPressed: () {},
      child: const SizedBox(
        width: double.infinity,
        child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            )),
      ),
    );
  }
}