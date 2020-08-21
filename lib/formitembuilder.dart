part of masamune.form;

class FormItemBuilder<TController extends Object> extends FormField<String> {
  final TController Function(String text) onInitController;
  final void Function(TController controller) onDisposeController;
  final String Function(TController controller) onPreSave;
  final TController Function(TController controller, String text) onUpdated;
  final TextEditingController controller;
  final Future future;
  final Colors indicatorColor;
  final Widget Function(
          BuildContext context, TController controller, FocusNode focusNode)
      _builder;

  FormItemBuilder(
      {Key key,
      this.future,
      this.indicatorColor,
      @required
          this.onInitController,
      @required
          Widget Function(BuildContext context, TController controller,
                  FocusNode focusNode)
              builder,
      this.onUpdated,
      this.onDisposeController,
      this.onPreSave,
      this.controller,
      void onSaved(String value),
      String validator(String value),
      String initialURI,
      bool autovalidate = false,
      bool enabled = true})
      : this._builder = builder,
        super(
            key: key,
            builder: (state) {
              return null;
            },
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            initialValue: initialURI,
            enabled: enabled);

  @override
  _FormItemBuilderState<TController> createState() =>
      _FormItemBuilderState<TController>();
}

class _FormItemBuilderState<TController extends Object>
    extends FormFieldState<String> {
  TextEditingController _textEditingController;
  TController _controller;
  FocusNode _focusNode;

  TextEditingController get _effectiveController =>
      widget.controller ?? _textEditingController;

  @override
  FormItemBuilder<TController> get widget =>
      super.widget as FormItemBuilder<TController>;

  @override
  void didUpdateWidget(FormItemBuilder<TController> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _textEditingController =
            TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(widget.controller.text);
        if (oldWidget.controller == null) _textEditingController = null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    if (widget.controller == null) {
      _textEditingController = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
    if (this.widget.onInitController != null) {
      this._controller =
          this.widget.onInitController(_effectiveController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (this.widget.future != null) {
      return FutureBuilder(
        future: this.widget.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return this._controller == null ||
                    this.widget.builder == null ||
                    this._focusNode == null
                ? Container()
                : this
                    .widget
                    ._builder(context, this._controller, this._focusNode);
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor:
                  this.widget.indicatorColor ?? Theme.of(context).primaryColor,
            ));
          }
        },
      );
    } else {
      return this._controller == null ||
              this.widget.builder == null ||
              this._focusNode == null
          ? Container()
          : this.widget._builder(context, this._controller, this._focusNode);
    }
  }

  @override
  void save() {
    if (this.widget.onPreSave != null)
      this.setValue(this.widget.onPreSave(this._controller));
    super.save();
  }

  @override
  bool validate() {
    if (this.widget.onPreSave != null)
      this.setValue(this.widget.onPreSave(this._controller));
    return super.validate();
  }

  @override
  void didChange(String value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value;
    }
    if (this.widget.onUpdated != null) {
      this._controller =
          this.widget.onUpdated(this._controller, _effectiveController.text);
    } else if (this.widget.onInitController != null) {
      this._controller =
          this.widget.onInitController(_effectiveController.text);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    if (this.widget.onDisposeController != null)
      this.widget.onDisposeController(this._controller);
    super.dispose();
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
