part of masamune.form;

class FormItemTextField extends StatelessWidget implements FormItem {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final String hintText;
  final bool dense;
  final String labelText;
  final String counterText;
  final Widget prefix;
  final bool enabled;
  final Widget suffix;
  final bool readOnly;
  final bool obscureText;
  final bool allowEmpty;
  final List<String> suggestion;
  final void Function(String) onDeleteSuggestion;
  final void Function(String value) onSaved;

  FormItemTextField(
      {this.controller,
      this.keyboardType = TextInputType.text,
      this.maxLength = 100,
      this.maxLines = 1,
      this.minLines = 1,
      this.hintText = "",
      this.labelText = "",
      this.prefix,
      this.suffix,
      this.dense = false,
      this.suggestion,
      this.allowEmpty = false,
      this.enabled = true,
      this.readOnly = false,
      this.obscureText = false,
      this.counterText = "",
      this.onDeleteSuggestion,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return SuggestionOverlayBuilder(
        items: this.suggestion,
        onDeleteSuggestion: this.onDeleteSuggestion,
        controller: this.controller,
        builder: (context, controller, onTap) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
                enabled: this.enabled,
                controller: controller,
                keyboardType: this.keyboardType,
                maxLength: this.maxLength,
                maxLines: this.maxLines,
                minLines: this.minLines,
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
                  hintText: this.hintText,
                  labelText: this.labelText,
                  counterText: this.counterText,
                  prefix: this.prefix,
                  suffix: this.suffix,
                ),
                obscureText: this.obscureText,
                readOnly: this.readOnly,
                autovalidate: false,
                onTap: this.enabled ? onTap : null,
                validator: (value) {
                  if (!this.allowEmpty && isEmpty(value)) return this.hintText;
                  return null;
                },
                onSaved: (value) {
                  if (isEmpty(value)) return;
                  if (this.onSaved != null) this.onSaved(value);
                })));
  }
}
