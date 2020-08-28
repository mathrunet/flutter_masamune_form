part of masamune.form;

/// Form item for uploading an image.
class FormItemImage extends FormField<String> {
  final void Function(void Function(File) onUpdate) onTap;

  /// The overall color if you have not uploaded an image.
  final Color color;

  /// Icon if you have not uploaded an image.
  final IconData icon;

  /// True for dense.
  final bool dense;

  /// Form item for uploading an image.
  ///
  /// [key]: Key.
  /// [onTap]: Processing when tapped.
  /// Finally save the file using onUpdate.
  /// [controller]: Text ediging controller.
  /// [color]: The overall color if you have not uploaded an image.
  /// [icon]: Icon if you have not uploaded an image.
  /// [onSaved]: Processing when saved.
  /// [validator]: Processing when validated.
  /// [autovalidate]: True to automatically validate.
  /// [enabled]: True to enable.
  /// [dense]: True for dense.
  FormItemImage(
      {Key key,
      this.controller,
      @required this.onTap,
      this.color,
      this.dense = false,
      this.icon = Icons.add_a_photo,
      void onSaved(String value),
      String validator(String value),
      String initialURI,
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
            initialValue: initialURI,
            enabled: enabled);

  /// Text ediging controller.
  final TextEditingController controller;

  @override
  _FormItemImageState createState() => _FormItemImageState();
}

class _FormItemImageState extends FormFieldState<String> {
  TextEditingController _controller;
  File _data;
  File _local;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  FormItemImage get widget => super.widget as FormItemImage;

  void _onUpdate(File file) {
    if (file == null || isEmpty(file.path)) return;
    this.setState(() {
      this.setValue(file.path);
      this._data = file;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(FormItemImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(widget.controller.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InkWell(
      onTap: () {
        if (!this.widget.enabled) return;
        if (this.widget.onTap != null) this.widget.onTap(this._onUpdate);
      },
      child: this._buildImage(context),
    );
  }

  Widget _buildImage(BuildContext context) {
    String value = this._effectiveController?.text;
    if (isNotEmpty(this.widget.initialValue)) value = this.widget.initialValue;
    if (this._data != null) {
      return Container(
          padding: this.widget.dense
              ? const EdgeInsets.all(0)
              : const EdgeInsets.symmetric(vertical: 10),
          constraints: const BoxConstraints.expand(height: 200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(this.widget.dense ? 0 : 8.0),
            child: Image.file(this._data, fit: BoxFit.cover),
          ));
    } else if (isNotEmpty(value)) {
      if (value.startsWith("http")) {
        return Container(
            padding: this.widget.dense
                ? const EdgeInsets.all(0)
                : const EdgeInsets.symmetric(vertical: 10),
            constraints: const BoxConstraints.expand(height: 200),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(this.widget.dense ? 0 : 8.0),
              child: Image.network(value, fit: BoxFit.cover),
            ));
      } else {
        if (this._local == null) this._local = File(value);
        return Container(
            padding: this.widget.dense
                ? const EdgeInsets.all(0)
                : const EdgeInsets.symmetric(vertical: 10),
            constraints: const BoxConstraints.expand(height: 200),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(this.widget.dense ? 0 : 8.0),
              child: Image.file(this._local, fit: BoxFit.cover),
            ));
      }
    } else {
      return Container(
          padding: this.widget.dense
              ? const EdgeInsets.all(0)
              : const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            constraints: const BoxConstraints.expand(height: 160),
            decoration: BoxDecoration(
                border: Border.all(
                    color: this.widget.color ?? Theme.of(context).disabledColor,
                    style: this.widget.dense
                        ? BorderStyle.none
                        : BorderStyle.solid),
                borderRadius: BorderRadius.circular(8.0)),
            child: Icon(this.widget.icon,
                size: 56,
                color: this.widget.color ?? Theme.of(context).disabledColor),
          ));
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String value) {
    super.didChange(value);

    if (_effectiveController.text != value) _effectiveController.text = value;
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value)
      didChange(_effectiveController.text);
  }
}
