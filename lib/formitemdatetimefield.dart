part of masamune.form;

class FormItemDateTimeField extends StatefulWidget implements FormItem {
  /// Calculate formatted datetime string from [millisecondsSinceEpoch].
  static String formatDateTime(int millisecondsSinceEpoch,
          {String format = "yyyy/MM/dd(E) HH:mm:ss",
          String defaultValue = ""}) =>
      DateTimeTextFormField.formatDateTime(millisecondsSinceEpoch,
          format: format, defaultValue: defaultValue);

  /// Calculate formatted date string from [millisecondsSinceEpoch].
  static String formatDate(int millisecondsSinceEpoch,
          {String format = "yyyy/MM/dd(E)", String defaultValue = ""}) =>
      DateTimeTextFormField.formatDate(millisecondsSinceEpoch,
          format: format, defaultValue: defaultValue);

  /// Calculate formatted time string from [millisecondsSinceEpoch].
  static String formatTime(int millisecondsSinceEpoch,
          {String format = "HH:mm:ss", String defaultValue = ""}) =>
      DateTimeTextFormField.formatTime(millisecondsSinceEpoch,
          format: format, defaultValue: defaultValue);

  /// Calculate DateTime from [millisecondsSinceEpoch].
  static DateTime value(int millisecondsSinceEpoch) =>
      DateTimeTextFormField.value(millisecondsSinceEpoch);

  /// Picker definition that selects only dates.
  static Future<DateTime> Function(BuildContext, DateTime) datePicker(
          {DateTime startDate, DateTime currentDate, DateTime endDate}) =>
      DateTimeTextFormField.datePicker(
          startDate: startDate, currentDate: currentDate, endDate: endDate);

  /// Definition of a picker to select time.
  static Future<DateTime> Function(BuildContext, DateTime) timePicker(
          {DateTime currentTime}) =>
      DateTimeTextFormField.timePicker(currentTime: currentTime);

  /// Picker definition that selects the date and time.
  static Future<DateTime> Function(BuildContext, DateTime) dateTimePicker(
          {DateTime startDate, DateTime current, DateTime endDate}) =>
      DateTimeTextFormField.dateTimePicker(
          startDate: startDate, current: current, endDate: endDate);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final bool dense;
  final int minLines;
  final String hintText;
  final String labelText;
  final String counterText;
  final Widget prefix;
  final Widget suffix;
  final bool readOnly;
  final bool allowEmpty;
  final bool obscureText;
  final Color backgroundColor;
  final DateTime initialDateTime;
  final DateFormat _format;
  final bool enabled;
  final FormItemDateTimeFieldPickerType type;
  final Future<DateTime> Function(BuildContext, DateTime) _onShowPicker;
  final void Function(DateTime value) onSaved;

  Future<DateTime> Function(BuildContext, DateTime) get onShowPicker {
    if (this._onShowPicker != null) return this._onShowPicker;
    switch (this.type) {
      case FormItemDateTimeFieldPickerType.date:
        return DateTimeTextFormField.datePicker();
      case FormItemDateTimeFieldPickerType.time:
        return DateTimeTextFormField.timePicker();
      default:
        return DateTimeTextFormField.dateTimePicker();
    }
  }

  DateFormat get format {
    if (this._format != null) return this._format;
    switch (this.type) {
      case FormItemDateTimeFieldPickerType.date:
        return DateFormat("yyyy/MM/dd(E)");
      case FormItemDateTimeFieldPickerType.time:
        return DateFormat("HH:mm:ss");
      default:
        return DateFormat("yyyy/MM/dd(E) HH:mm:ss");
    }
  }

  FormItemDateTimeField(
      {this.controller,
      this.keyboardType = TextInputType.text,
      this.maxLength,
      this.maxLines,
      this.minLines = 1,
      this.backgroundColor,
      this.hintText = "",
      this.labelText = "",
      this.counterText = "",
      this.dense = false,
      this.enabled = true,
      this.prefix,
      this.suffix,
      this.allowEmpty = false,
      this.readOnly = false,
      this.obscureText = false,
      this.type = FormItemDateTimeFieldPickerType.dateTime,
      this.initialDateTime,
      DateFormat format,
      Future<DateTime> onShowPicker(BuildContext context, DateTime dateTime),
      this.onSaved})
      : this._format = format,
        this._onShowPicker = onShowPicker;
  @override
  State<StatefulWidget> createState() => _FormItemDateTimeFieldState();
}

class _FormItemDateTimeFieldState extends State<FormItemDateTimeField> {
  @override
  void initState() {
    super.initState();
    if (this.widget.controller == null) return;
    if (this.widget.initialDateTime != null) {
      this.widget.controller.text = this.widget.format == null
          ? this.widget.initialDateTime.toIso8601String()
          : this.widget.format.format(this.widget.initialDateTime);
    } else {
      this.widget.controller.text = Const.empty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: this.widget.dense
            ? const EdgeInsets.all(0)
            : const EdgeInsets.symmetric(vertical: 10),
        child: DateTimeTextFormField(
          controller: this.widget.controller,
          keyboardType: TextInputType.text,
          initialValue: this.widget.initialDateTime,
          maxLength: this.widget.maxLength,
          maxLines: this.widget.maxLines,
          enabled: this.widget.enabled,
          minLines: this.widget.minLines,
          decoration: InputDecoration(
            fillColor: this.widget.backgroundColor,
            filled: this.widget.backgroundColor != null,
            border: OutlineInputBorder(
                borderSide:
                    this.widget.dense ? BorderSide.none : const BorderSide()),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    this.widget.dense ? BorderSide.none : const BorderSide()),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    this.widget.dense ? BorderSide.none : const BorderSide()),
            errorBorder: OutlineInputBorder(
                borderSide:
                    this.widget.dense ? BorderSide.none : const BorderSide()),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    this.widget.dense ? BorderSide.none : const BorderSide()),
            focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    this.widget.dense ? BorderSide.none : const BorderSide()),
            hintText: this.widget.hintText,
            counterText: this.widget.counterText,
            labelText: this.widget.labelText,
            prefix: this.widget.prefix,
            suffix: this.widget.suffix,
          ),
          style: Config.isIOS ? TextStyle(fontSize: 13) : null,
          obscureText: this.widget.obscureText,
          readOnly: this.widget.readOnly,
          format: this.widget.format,
          autovalidate: false,
          validator: (value) {
            if (!this.widget.allowEmpty && isEmpty(value))
              return this.widget.hintText;
            return null;
          },
          onSaved: (value) {
            if (!this.widget.allowEmpty && isEmpty(value)) return;
            if (this.widget.onSaved != null) this.widget.onSaved(value);
          },
          onShowPicker: this.widget.onShowPicker ??
              DateTimeTextFormField.dateTimePicker(),
        ));
  }
}

enum FormItemDateTimeFieldPickerType { date, time, dateTime }
