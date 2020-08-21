part of masamune.form;

class FormItemLabeledDropdownField extends StatelessWidget implements FormItem {
  final TextEditingController controller;
  final String labelText;
  final Map<String, String> items;
  final Widget prefix;
  final bool enabled;
  final Widget suffix;
  final bool dense;
  final void Function(String value) onSave;
  final void Function(String value) onChanged;

  FormItemLabeledDropdownField(
      {this.controller,
      @required this.items,
      this.labelText = "",
      this.prefix,
      this.dense = false,
      this.enabled = true,
      this.suffix,
      this.onSave,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).disabledColor,
                style: this.dense ? BorderStyle.none : BorderStyle.solid),
            borderRadius: BorderRadius.circular(4.0)),
        margin: this.dense
            ? const EdgeInsets.all(0)
            : const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4.5),
        child: Row(children: [
          Expanded(
              flex: 4,
              child: Text(this.labelText,
                  style: TextStyle(
                      color: this.enabled
                          ? null
                          : Theme.of(context).disabledColor))),
          Flexible(
              flex: 1,
              child: DropdownTextFormField(
                  controller: this.controller,
                  items: this.items,
                  enabled: this.enabled,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyText1.color,
                      height: 1.25),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      prefix: this.prefix,
                      suffix: this.suffix),
                  autovalidate: false,
                  onChanged: (value) {
                    if (this.onChanged != null) this.onChanged(value);
                  },
                  onSaved: (value) {
                    if (isEmpty(value)) return;
                    if (this.onSave != null) this.onSave(value);
                  }))
        ]));
  }
}
