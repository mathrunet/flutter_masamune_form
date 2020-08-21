part of masamune.form;

class FormItemSubmit extends StatelessWidget implements FormItem {
  final String label;
  final VoidAction onPressed;
  final Color backgroundColor;
  final Color color;
  final IconData icon;
  final bool enabled;
  final bool dense;
  FormItemSubmit(
      {this.label,
      this.onPressed,
      this.backgroundColor,
      this.color,
      this.dense = false,
      this.enabled = true,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: 80),
        padding: this.dense
            ? const EdgeInsets.all(0)
            : const EdgeInsets.symmetric(vertical: 10),
        child: this.icon != null
            ? FlatButton.icon(
                padding: const EdgeInsets.all(10),
                color: this.enabled
                    ? (this.backgroundColor ?? context.theme.primaryColor)
                    : context.theme.disabledColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(this.dense ? 0 : 8.0)),
                ),
                icon: Icon(this.icon,
                    size: 32,
                    color: this.color ?? context.theme.backgroundColor),
                label: Text(this.label,
                    style: TextStyle(
                        color: this.color ?? context.theme.backgroundColor,
                        fontSize: 24)),
                onPressed: this.enabled ? this.onPressed : null)
            : FlatButton(
                padding: const EdgeInsets.all(10),
                color: this.enabled
                    ? (this.backgroundColor ?? context.theme.primaryColor)
                    : context.theme.disabledColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(this.dense ? 0 : 8.0)),
                ),
                child: Text(this.label,
                    style: TextStyle(
                        color: this.color ?? context.theme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24)),
                onPressed: this.enabled ? this.onPressed : null));
  }
}
