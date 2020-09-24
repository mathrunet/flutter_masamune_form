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
  final InputBorder border;
  final InputBorder disabledBorder;
  final List<String> suggestion;
  final Color backgroundColor;
  final void Function(String) onDeleteSuggestion;
  final void Function(String value) onSaved;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color subColor;

  FormItemTextField(
      {this.controller,
      this.keyboardType = TextInputType.text,
      this.maxLength = 100,
      this.maxLines,
      this.minLines = 1,
      this.border,
      this.disabledBorder,
      this.backgroundColor,
      this.hintText = "",
      this.labelText = "",
      this.prefix,
      this.suffix,
      this.dense = false,
      this.padding,
      this.suggestion,
      this.allowEmpty = false,
      this.enabled = true,
      this.readOnly = false,
      this.obscureText = false,
      this.counterText = "",
      this.onDeleteSuggestion,
      this.onSaved,
      this.color,
      this.subColor});

  @override
  Widget build(BuildContext context) {
    return SuggestionOverlayBuilder(
        items: this.suggestion,
        onDeleteSuggestion: this.onDeleteSuggestion,
        controller: this.controller,
        builder: (context, controller, onTap) => Padding(
            padding: this.dense
                ? const EdgeInsets.all(0)
                : (this.padding ?? const EdgeInsets.symmetric(vertical: 10)),
            child: TextFormField(
                enabled: this.enabled,
                controller: controller,
                keyboardType: this.keyboardType,
                maxLength: this.maxLength,
                maxLines: this.maxLines,
                minLines: this.minLines,
                decoration: InputDecoration(
                  fillColor: this.backgroundColor,
                  filled: this.backgroundColor != null,
                  isDense: this.dense,
                  border: this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  enabledBorder: this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  disabledBorder: this.disabledBorder ??
                      this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  errorBorder: this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  focusedBorder: this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  focusedErrorBorder: this.border ??
                      OutlineInputBorder(
                          borderSide: this.dense
                              ? BorderSide.none
                              : const BorderSide()),
                  hintText: this.hintText,
                  labelText: this.labelText,
                  counterText: this.counterText,
                  prefix: this.prefix,
                  suffix: this.suffix,
                  labelStyle: TextStyle(color: this.color),
                  hintStyle: TextStyle(color: this.subColor),
                  suffixStyle: TextStyle(color: this.subColor),
                  prefixStyle: TextStyle(color: this.subColor),
                  counterStyle: TextStyle(color: this.subColor),
                  helperStyle: TextStyle(color: this.subColor),
                ),
                style: TextStyle(color: this.color),
                obscureText: this.obscureText,
                readOnly: this.readOnly,
                autovalidate: false,
                onTap: this.enabled ? onTap : null,
                validator: (value) {
                  if (!this.allowEmpty && isEmpty(value)) return this.hintText;
                  return null;
                },
                onSaved: (value) {
                  if (!this.allowEmpty && isEmpty(value)) return;
                  if (this.onSaved != null) this.onSaved(value);
                })));
  }
}
