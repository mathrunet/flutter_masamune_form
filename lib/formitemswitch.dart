part of masamune.form;

class FormItemSwitch extends FormField<bool> {
  final TextEditingController controller;
  final FormItemSwitchType type;
  final void Function(bool value) onChanged;
  final Color activeColor;
  final bool dense;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;
  final Widget leading;
  final String hintText;
  final String labelText;

  FormItemSwitch(
      {this.controller,
      this.leading,
      this.dense = false,
      this.type = FormItemSwitchType.form,
      this.onChanged,
      this.activeColor,
      this.activeTrackColor,
      this.inactiveThumbColor,
      this.inactiveTrackColor,
      this.hintText,
      this.labelText,
      Key key,
      void onSaved(bool value),
      String validator(bool value),
      bool initialValue,
      bool autovalidate = false,
      bool enabled = true})
      : super(
            key: key,
            builder: (state) {
              return null;
            },
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            initialValue: initialValue,
            enabled: enabled);
  @override
  _FormItemSwitchState createState() => _FormItemSwitchState();
}

class _FormItemSwitchState extends FormFieldState<bool> {
  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  FormItemSwitch get widget => super.widget as FormItemSwitch;

  @override
  void didUpdateWidget(FormItemSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(_parse(widget.controller.text));
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  bool _parse(String text) {
    if (isEmpty(text)) return false;
    if (text.toLowerCase() == "true") return true;
    return false;
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController();
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
    setValue(_parse(this._effectiveController.text));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    switch (widget.type) {
      case FormItemSwitchType.form:
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).disabledColor,
                  style:
                      this.widget.dense ? BorderStyle.none : BorderStyle.solid),
              borderRadius: BorderRadius.circular(4.0)),
          margin: this.widget.dense
              ? const EdgeInsets.all(0)
              : const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4.5),
          child: Row(children: [
            Expanded(
                flex: 4,
                child: Text(this.widget.labelText,
                    style: TextStyle(
                        color: this.widget.enabled
                            ? null
                            : Theme.of(context).disabledColor))),
            Flexible(
                flex: 1,
                child: Switch(
                  value: this.value,
                  activeColor: this.widget.activeColor,
                  activeTrackColor: this.widget.activeTrackColor,
                  inactiveThumbColor: this.widget.inactiveThumbColor,
                  inactiveTrackColor: this.widget.inactiveTrackColor,
                  onChanged: (bool value) {
                    if (this.widget.onChanged != null)
                      this.widget.onChanged(value);
                    this.setState(() {});
                  },
                ))
          ]),
        );
        break;
      default:
        return SwitchListTile(
            dense: this.widget.dense,
            activeColor: this.widget.activeColor,
            activeTrackColor: this.widget.activeTrackColor,
            inactiveThumbColor: this.widget.inactiveThumbColor,
            inactiveTrackColor: this.widget.inactiveTrackColor,
            onChanged: (bool value) {
              setValue(value);
              if (this.widget.onChanged != null) this.widget.onChanged(value);
              this.setState(() {});
            },
            title: Text(this.widget.labelText ?? Const.empty),
            subtitle: isNotEmpty(this.widget.hintText)
                ? Text(this.widget.hintText)
                : null,
            secondary: this.widget.leading,
            value: this.value);
        break;
    }
  }

  @override
  void didChange(bool value) {
    super.didChange(value);
    if (_parse(_effectiveController.text) != value) {
      _effectiveController.text = value?.toString()?.toLowerCase();
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text =
          widget.initialValue?.toString()?.toLowerCase();
    });
  }

  void _handleControllerChanged() {
    bool parsed = _parse(_effectiveController.text);
    if (parsed != value) {
      didChange(parsed);
    }
  }
}

enum FormItemSwitchType { list, form }
