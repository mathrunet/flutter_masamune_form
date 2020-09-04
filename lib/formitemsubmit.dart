part of masamune.form;

class FormItemSubmit extends StatelessWidget implements FormItem {
  final String label;
  final VoidAction onPressed;
  final Color backgroundColor;
  final Color color;
  final IconData icon;
  final bool enabled;
  final bool dense;
  final double height;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  FormItemSubmit(
      {this.label,
      this.onPressed,
      this.backgroundColor,
      this.color,
      this.padding,
      this.height = 80,
      this.fontSize = 20,
      this.dense = false,
      this.enabled = true,
      this.borderRadius,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: this.height),
        padding: this.dense
            ? const EdgeInsets.all(0)
            : (this.padding ?? const EdgeInsets.symmetric(vertical: 10)),
        child: this.icon != null
            ? FlatButton.icon(
                padding: const EdgeInsets.all(10),
                color: this.enabled
                    ? (this.backgroundColor ?? context.theme.primaryColor)
                    : context.theme.disabledColor,
                shape: RoundedRectangleBorder(
                  borderRadius: this.borderRadius ??
                      BorderRadius.all(Radius.circular(this.dense ? 0 : 8.0)),
                ),
                icon: Icon(this.icon,
                    size: this.fontSize * 1.2,
                    color: this.color ?? context.theme.backgroundColor),
                label: Text(this.label,
                    style: TextStyle(
                        color: this.color ?? context.theme.backgroundColor,
                        fontSize: this.fontSize)),
                onPressed: this.enabled ? this.onPressed : null)
            : FlatButton(
                padding: const EdgeInsets.all(10),
                color: this.enabled
                    ? (this.backgroundColor ?? context.theme.primaryColor)
                    : context.theme.disabledColor,
                shape: RoundedRectangleBorder(
                  borderRadius: this.borderRadius ??
                      BorderRadius.all(Radius.circular(this.dense ? 0 : 8.0)),
                ),
                child: Text(this.label,
                    style: TextStyle(
                        color: this.color ?? context.theme.backgroundColor,
                        fontSize: this.fontSize)),
                onPressed: this.enabled ? this.onPressed : null));
  }
}
