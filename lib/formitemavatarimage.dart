part of masamune.form;

class FormItemAvatarImage extends StatelessWidget implements FormItem {
  final ImageProvider image;
  final String label;
  final VoidAction onPressed;
  final Color textColor;
  final Color backgroundColor;
  final bool enabled;
  FormItemAvatarImage(
      {@required this.image,
      this.label,
      this.onPressed,
      this.textColor,
      this.backgroundColor,
      this.enabled = true});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 120,
                width: 120,
                child: CircleAvatar(
                  backgroundColor: context.theme.canvasColor,
                  backgroundImage: this.image,
                )),
            if (isNotEmpty(this.label))
              FlatButton(
                  shape: StadiumBorder(),
                  child: Text(this.label,
                      style: TextStyle(
                          color:
                              this.textColor ?? context.theme.backgroundColor)),
                  onPressed: this.enabled ? this.onPressed : null,
                  disabledColor: context.theme.disabledColor,
                  disabledTextColor: context.theme.backgroundColor,
                  color: this.enabled
                      ? (this.backgroundColor ?? context.theme.primaryColor)
                      : context.theme.disabledColor)
          ],
        ));
  }
}
