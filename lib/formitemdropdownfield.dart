part of masamune.form;

class FormItemDropdownField extends StatelessWidget implements FormItem {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String counterText;
  final Map<String, String> items;
  final Widget prefix;
  final Widget suffix;
  final bool enabled;
  final bool dense;
  final bool allowEmpty;
  final void Function(String value) onSave;
  final void Function(String value) onChanged;

  FormItemDropdownField(
      {this.controller,
      this.hintText = "",
      @required this.items,
      this.enabled = true,
      this.dense = false,
      this.labelText = "",
      this.prefix,
      this.allowEmpty = false,
      this.suffix,
      this.counterText = "",
      this.onSave,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: this.dense
            ? const EdgeInsets.all(0)
            : const EdgeInsets.symmetric(vertical: 10),
        child: DropdownTextFormField(
            controller: this.controller,
            items: this.items,
            enabled: this.enabled,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide:
                      this.dense ? BorderSide.none : const BorderSide()),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      this.dense ? BorderSide.none : const BorderSide()),
              disabledBorder: OutlineInputBorder(
                  borderSide:
                      this.dense ? BorderSide.none : const BorderSide()),
              errorBorder: OutlineInputBorder(
                  borderSide:
                      this.dense ? BorderSide.none : const BorderSide()),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      this.dense ? BorderSide.none : const BorderSide()),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      this.dense ? BorderSide.none : const BorderSide()),
              contentPadding: const EdgeInsets.all(17.5),
              hintText: this.hintText,
              labelText: this.labelText,
              counterText: this.counterText,
              prefix: this.prefix,
              suffix: this.suffix,
            ),
            autovalidate: false,
            validator: (value) {
              if (!this.allowEmpty && isEmpty(value)) return this.hintText;
              return null;
            },
            onChanged: (value) {
              if (this.onChanged != null) this.onChanged(value);
            },
            onSaved: (value) {
              if (isEmpty(value)) return;
              if (this.onSave != null) this.onSave(value);
            }));
  }
}
