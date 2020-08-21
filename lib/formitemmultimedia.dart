part of masamune.form;

class FormItemMultiMedia extends FormField<String> {
  final double height;
  final Color color;
  final IconData icon;
  final List<FormItemMultiMediaItem> items;
  final void Function(FormItemMultiMediaItem data) onRemove;
  final TextEditingController controller;
  final String Function(List<FormItemMultiMediaItem> data) onPreSave;
  final Widget Function(
      BuildContext context,
      FormItemMultiMediaItem data,
      Size size,
      void Function(dynamic fileOrURL, AssetType type) onUpdate,
      Function onRemove) _builder;
  final Size size;
  final void Function(void Function(dynamic fileOrURL, AssetType type) onUpdate)
      onPressed;
  FormItemMultiMedia(
      {this.height = 100,
      this.color,
      this.onRemove,
      this.icon,
      this.controller,
      this.onPreSave,
      @required this.items,
      Widget Function(
              BuildContext context,
              FormItemMultiMediaItem data,
              Size size,
              void Function(dynamic fileOrURL, AssetType type) onUpdate,
              Function onRemove)
          builder = _defaultBuilder,
      this.onPressed,
      Key key,
      void onSaved(String value),
      String validator(String value),
      String initialJson,
      bool autovalidate = false,
      bool enabled = true})
      : this.size = Size(height - 20, height - 20),
        this._builder = builder,
        super(
            key: key,
            builder: (state) {
              return null;
            },
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            initialValue: initialJson,
            enabled: enabled);

  static Widget _defaultBuilder(
      BuildContext context,
      FormItemMultiMediaItem data,
      Size size,
      void Function(dynamic fileOrURL, AssetType type) onUpdate,
      Function onRemove) {
    if (data.type == AssetType.video) {
      if (data.file != null) {
        return InkWell(
            onLongPress: () {
              onRemove();
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Video.file(
                  data.file,
                  fit: BoxFit.cover,
                  height: size.height,
                  width: size.width,
                  controllable: true,
                )));
      } else if (isNotEmpty(data.url)) {
        return InkWell(
            onLongPress: () {
              onRemove();
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Video.network(
                  data.url,
                  fit: BoxFit.cover,
                  height: size.height,
                  width: size.width,
                  controllable: true,
                )));
      }
    } else {
      if (data.file != null) {
        return InkWell(
            onLongPress: () {
              onRemove();
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.file(data.file,
                    fit: BoxFit.cover,
                    height: size.height,
                    width: size.width)));
      } else if (isNotEmpty(data.url)) {
        return InkWell(
            onLongPress: () {
              onRemove();
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(data.url,
                    fit: BoxFit.cover,
                    height: size.height,
                    width: size.width)));
      }
    }
    return null;
  }

  @override
  _FormItemMultiMediaState createState() => _FormItemMultiMediaState();
}

class _FormItemMultiMediaState extends FormFieldState<String> {
  List<FormItemMultiMediaItem> _items;
  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  FormItemMultiMedia get widget => super.widget as FormItemMultiMedia;

  @override
  void didUpdateWidget(FormItemMultiMedia oldWidget) {
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
  void initState() {
    super.initState();
    this._items = this.widget.items;
    if (isNotEmpty(this.widget.initialValue))
      this._items = this._decodeJson(this.widget.initialValue);
    if (this.widget.controller != null &&
        isNotEmpty(this.widget.controller.text))
      this._items = this._decodeJson(this.widget.controller.text);
    if (widget.controller == null) {
      _controller = TextEditingController();
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  void _onUpdate(dynamic fileOrURL, AssetType type) {
    if (fileOrURL is File) {
      this._items.add(FormItemMultiMediaItem(type: type, file: fileOrURL));
    } else if (fileOrURL is String) {
      this._items.add(FormItemMultiMediaItem(type: type, url: fileOrURL));
    }
    this.setValue(this._encodeJson(this._items));
    this.setState(() {});
  }

  void _onRemove(dynamic dataOrIndex) {
    if (dataOrIndex is FormItemMultiMediaItem) {
      if (this.widget.onRemove != null) this.widget.onRemove(dataOrIndex);
      this._items.remove(dataOrIndex);
    } else if (dataOrIndex is int) {
      if (this.widget.onRemove != null) {
        this.widget.onRemove(this._items.removeAt(dataOrIndex));
      } else {
        this._items.removeAt(dataOrIndex);
      }
    }
    this.setValue(this._encodeJson(this._items));
    this.setState(() {});
  }

  @override
  void save() {
    this.setValue(this._encodeJson(this._items));
    super.save();
  }

  @override
  bool validate() {
    this.setValue(this._encodeJson(this._items));
    return super.validate();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        height: this.widget.height,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: this.widget.size.width,
                    height: this.widget.size.height,
                    margin: const EdgeInsets.only(right: 10),
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: this.widget.color ??
                            Theme.of(context).disabledColor,
                        width: 2,
                      ),
                      child: Icon(this.widget.icon ?? Icons.photo,
                          color: this.widget.color ??
                              Theme.of(context).disabledColor,
                          size: this.widget.height / 3.0),
                      onPressed: () {
                        if (this.widget.onPressed != null)
                          this.widget.onPressed(this._onUpdate);
                      },
                    )),
                ...this._items.mapAndRemoveEmpty((item) {
                  final widget = this.widget._builder(
                      context,
                      item,
                      this.widget.size,
                      this._onUpdate,
                      () => this._onRemove(item));
                  if (widget == null) return null;
                  return Padding(
                      padding: const EdgeInsets.only(right: 10), child: widget);
                })
              ],
            )));
  }

  @override
  void didChange(String value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value;
    }
    final res = _decodeJson(_effectiveController.text);
    if (res.length != this._items.length) {
      this._items = res;
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  String _encodeJson(List<FormItemMultiMediaItem> items) {
    if (items == null) return "[]";
    final res = <Map<String, dynamic>>[];
    for (final tmp in items) {
      if (isNotEmpty(tmp.url)) {
        res.add({"type": this._getTypeString(tmp.type), "url": tmp.url});
      } else {
        res.add({"type": this._getTypeString(tmp.type), "file": tmp.file.path});
      }
    }
    return Json.encode(res);
  }

  List<FormItemMultiMediaItem> _decodeJson(String value) {
    if (isEmpty(value)) return [];
    final res = <FormItemMultiMediaItem>[];
    final list = Json.decodeAsList(value);
    for (final tmp in list) {
      if (tmp is Map<String, dynamic>) {
        if (tmp.containsKey("file")) {
          res.add(FormItemMultiMediaItem(
              file: File(tmp["file"]),
              type: tmp.containsKey("type")
                  ? this._getType(tmp["type"])
                  : AssetType.image));
        } else if (tmp.containsKey("url")) {
          res.add(FormItemMultiMediaItem(
              url: tmp["url"],
              type: tmp.containsKey("type")
                  ? this._getType(tmp["type"])
                  : AssetType.image));
        }
      }
    }
    return res;
  }

  AssetType _getType(String type) {
    switch (type) {
      case "video":
        return AssetType.video;
      default:
        return AssetType.image;
    }
  }

  String _getTypeString(AssetType type) {
    switch (type) {
      case AssetType.video:
        return "video";
      default:
        return "image";
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue;
      this._items = _decodeJson(_effectiveController.text);
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value)
      didChange(_effectiveController.text);
  }
}

class FormItemMultiMediaItem {
  final AssetType type;
  final File file;
  final String url;
  const FormItemMultiMediaItem(
      {this.type = AssetType.image, this.file, this.url});
}
