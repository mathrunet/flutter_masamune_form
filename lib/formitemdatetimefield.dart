part of masamune.form;

class FormItemDateTimeField extends StatelessWidget implements FormItem {
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
  final bool obscureText;
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
      this.maxLength = 100,
      this.maxLines = 1,
      this.minLines = 1,
      this.hintText = "",
      this.labelText = "",
      this.counterText = "",
      this.dense = false,
      this.enabled = true,
      this.prefix,
      this.suffix,
      this.readOnly = false,
      this.obscureText = false,
      this.type = FormItemDateTimeFieldPickerType.dateTime,
      @required this.initialDateTime,
      DateFormat format,
      Future<DateTime> onShowPicker(BuildContext context, DateTime dateTime),
      this.onSaved})
      : this._format = format,
        this._onShowPicker = onShowPicker {
    if (this.controller == null) return;
    this.controller.text = this.format == null
        ? this.initialDateTime.toIso8601String()
        : this.format.format(this.initialDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: this.dense
            ? const EdgeInsets.all(0)
            : const EdgeInsets.symmetric(vertical: 10),
        child: DateTimeTextFormField(
          controller: this.controller,
          keyboardType: TextInputType.text,
          initialValue: this.initialDateTime,
          maxLength: this.maxLength,
          maxLines: this.maxLines,
          enabled: this.enabled,
          minLines: this.minLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: this.dense ? BorderSide.none : const BorderSide()),
            enabledBorder: OutlineInputBorder(
                borderSide: this.dense ? BorderSide.none : const BorderSide()),
            disabledBorder: OutlineInputBorder(
                borderSide: this.dense ? BorderSide.none : const BorderSide()),
            errorBorder: OutlineInputBorder(
                borderSide: this.dense ? BorderSide.none : const BorderSide()),
            focusedBorder: OutlineInputBorder(
                borderSide: this.dense ? BorderSide.none : const BorderSide()),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: this.dense ? BorderSide.none : const BorderSide()),
            hintText: this.hintText,
            counterText: this.counterText,
            labelText: this.labelText,
            prefix: this.prefix,
            suffix: this.suffix,
          ),
          obscureText: this.obscureText,
          readOnly: this.readOnly,
          format: this.format,
          autovalidate: false,
          validator: (value) {
            if (isEmpty(value)) return this.hintText;
            return null;
          },
          onSaved: (value) {
            if (isEmpty(value)) return;
            if (this.onSaved != null) this.onSaved(value);
          },
          onShowPicker:
              this.onShowPicker ?? DateTimeTextFormField.dateTimePicker(),
        ));
  }
}

enum FormItemDateTimeFieldPickerType { date, time, dateTime }
