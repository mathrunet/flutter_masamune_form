part of masamune.form;

/// Form-headline widget.
class FormItemHeadline extends StatelessWidget implements FormItem {
  /// Border designation.
  final BorderSide bottomBorder;

  /// Icon data.
  final IconData icon;

  /// Headline title.
  final String title;

  /// Form-headline widget.
  ///
  /// [bottomBorder]: Border designation.
  /// [icon]: Icon data.
  /// [title]: Headline title.
  FormItemHeadline(
    this.title, {
    this.bottomBorder,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 15, bottom: 5, top: 25),
        decoration: BoxDecoration(
            border: Border(
                bottom: this.bottomBorder ??
                    BorderSide(color: context.theme.dividerColor))),
        child: Row(children: [
          if (this.icon != null) ...[
            Icon(this.icon,
                color: context.theme.textTheme.caption.color,
                size: context.theme.textTheme.caption.fontSize),
            SizedBox(width: 20),
          ],
          Text(this.title, style: context.theme.textTheme.caption),
        ]));
  }
}
