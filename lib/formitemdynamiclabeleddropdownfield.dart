part of masamune.form;

class FormItemDynamicLabeledDropdownField extends StatefulWidget
    implements FormItem {
  final TextEditingController controller;
  final String labelText;
  final Map<String, String> items;
  final Widget prefix;
  final Widget suffix;
  final String Function(String key, String value) validator;
  final void Function(String key, String value) onSaved;
  final void Function(String key, String value) onChanged;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final String hintText;
  final String counterText;
  final bool readOnly;
  final bool obscureText;
  final String separator;
  final bool dense;
  final List<String> suggestion;
  final bool enabled;
  final bool allowEmpty;
  final void Function(String) onDeleteSuggestion;

  FormItemDynamicLabeledDropdownField(
      {this.controller,
      @required this.items,
      this.labelText = "",
      this.prefix,
      this.suffix,
      this.onSaved,
      this.dense = false,
      this.onChanged,
      this.enabled = true,
      this.suggestion,
      this.validator,
      this.separator = Const.colon,
      this.keyboardType = TextInputType.text,
      this.maxLength = 100,
      this.maxLines = 1,
      this.minLines = 1,
      this.onDeleteSuggestion,
      this.allowEmpty = false,
      this.hintText = "",
      this.readOnly = false,
      this.obscureText = false,
      this.counterText = ""});

  @override
  State<StatefulWidget> createState() =>
      _FormItemDynamicLabeledDropdownFieldState();
}

class _FormItemDynamicLabeledDropdownFieldState
    extends State<FormItemDynamicLabeledDropdownField> {
  TextEditingController _textController;
  TextEditingController _dropdownController;

  @override
  void initState() {
    super.initState();
    if (this.widget.controller != null &&
        isNotEmpty(this.widget.controller.text)) {
      final tmp = this.widget.controller.text.split(Const.colon);
      this._textController = TextEditingController(text: tmp.first);
      this._dropdownController = TextEditingController(text: tmp.last);
    } else {
      this._textController = TextEditingController();
      this._dropdownController = TextEditingController();
    }
    this._textController.addListener(this._listener);
    this._dropdownController.addListener(this._listener);
  }

  void _listener() {
    if (this.widget.controller == null) return;
    String dropDown = isEmpty(this._dropdownController.text)
        ? (this.widget.items?.entries?.first?.key ?? Const.empty)
        : this._dropdownController.text;
    this.widget.controller.text =
        "${this._textController.text}${this.widget.separator}$dropDown";
  }

  @override
  void dispose() {
    super.dispose();
    this._textController.removeListener(this._listener);
    this._dropdownController.removeListener(this._listener);
  }

  @override
  Widget build(BuildContext context) {
    return SuggestionOverlayBuilder(
        items: this.widget.suggestion,
        controller: this._textController,
        onDeleteSuggestion: this.widget.onDeleteSuggestion,
        builder: (context, controller, onTap) => Padding(
            padding: this.widget.dense
                ? const EdgeInsets.all(0)
                : const EdgeInsets.symmetric(vertical: 10),
            child: Stack(children: [
              TextFormField(
                  enabled: this.widget.enabled,
                  controller: controller,
                  keyboardType: TextInputType.text,
                  maxLength: this.widget.maxLength,
                  maxLines: this.widget.maxLines,
                  minLines: this.widget.minLines,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: this.widget.dense
                            ? BorderSide.none
                            : const BorderSide()),
                    enabledBorder: OutlineInputBorder(
                        borderSide: this.widget.dense
                            ? BorderSide.none
                            : const BorderSide()),
                    disabledBorder: OutlineInputBorder(
                        borderSide: this.widget.dense
                            ? BorderSide.none
                            : const BorderSide()),
                    errorBorder: OutlineInputBorder(
                        borderSide: this.widget.dense
                            ? BorderSide.none
                            : const BorderSide()),
                    focusedBorder: OutlineInputBorder(
                        borderSide: this.widget.dense
                            ? BorderSide.none
                            : const BorderSide()),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: this.widget.dense
                            ? BorderSide.none
                            : const BorderSide()),
                    hintText: this.widget.hintText,
                    labelText: this.widget.labelText,
                    counterText: this.widget.counterText,
                    contentPadding: const EdgeInsets.only(
                        top: 20, left: 12, bottom: 20, right: 108),
                    prefix: this.widget.prefix,
                  ),
                  obscureText: this.widget.obscureText,
                  readOnly: this.widget.readOnly,
                  autovalidate: false,
                  onTap: this.widget.enabled ? onTap : null,
                  validator: (value) {
                    if (!this.widget.allowEmpty && isEmpty(value))
                      return this.widget.hintText;

                    if (this.widget.validator != null)
                      return this.widget.validator(
                          value,
                          isEmpty(this._dropdownController.text)
                              ? (this.widget.items?.entries?.first?.key ??
                                  Const.empty)
                              : this._dropdownController.text);
                    return null;
                  },
                  onSaved: (value) {
                    if (!this.widget.allowEmpty && isEmpty(value)) return;
                    if (this.widget.onSaved != null)
                      this.widget.onSaved(
                          value,
                          isEmpty(this._dropdownController.text)
                              ? (this.widget.items?.entries?.first?.key ??
                                  Const.empty)
                              : this._dropdownController.text);
                  }),
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      width: 100,
                      height: 60,
                      padding: const EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: DropdownTextFormField(
                          controller: this._dropdownController,
                          items: this.widget.items,
                          enabled: this.widget.enabled,
                          style: TextStyle(
                              fontSize: 20,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                              height: 1.25),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                          autovalidate: false,
                          onChanged: (value) {
                            if (this.widget.onChanged != null)
                              this.widget.onChanged(
                                  this._textController.text,
                                  isEmpty(value)
                                      ? (this
                                              .widget
                                              .items
                                              ?.entries
                                              ?.first
                                              ?.key ??
                                          Const.empty)
                                      : value);
                          }))),
            ])));
  }
}
