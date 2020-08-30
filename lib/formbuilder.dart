part of masamune.form;

class FormBuilder extends StatelessWidget {
  final GlobalKey<FormState> _key;
  final List<Widget> children;
  final FormBuilderType type;

  FormBuilder(
      {@required GlobalKey<FormState> key,
      @required this.children,
      this.type = FormBuilderType.listView})
      : this._key = key;
  @override
  Widget build(BuildContext context) {
    return Form(key: this._key, child: this._buildInternal(context));
  }

  Widget _buildInternal(BuildContext context) {
    switch (this.type) {
      case FormBuilderType.fixed:
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: this.children));
      case FormBuilderType.center:
        return Container(
            constraints: BoxConstraints.expand(),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: this.children));
      default:
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: this.children)));
    }
  }
}

enum FormBuilderType { listView, center, fixed }
