part of masamune.form;

class UIPageReAuth extends UIPageForm {
  /// Page title.
  @protected
  String get title => "Reauthentication".localize();

  /// Set the form type.
  ///
  /// Available for login and password reset page.
  FormBuilderType get formType => FormBuilderType.center;

  /// Creating a app bar.
  ///
  /// [context]: Build context.
  @protected
  @override
  Widget appBar(BuildContext context) {
    return AppBar(title: Text(this.title));
  }

  /// Initial definition of the controller.
  ///
  /// [context]: Build context.
  @override
  Map<String, String> define(BuildContext context) {
    return {"password": Const.empty};
  }

  /// Form body definition.
  ///
  /// [context]: Build context.
  @override
  List<Widget> formBody(BuildContext context,
      Map<String, TextEditingController> controller, IDataDocument form) {
    return [
      Text(
        "Please enter your login information again".localize(),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20),
      FormItemTextField(
        controller: controller["password"],
        hintText: "Please enter a password".localize(),
        labelText: "Password".localize(),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        onSaved: (value) {
          if (isEmpty(value)) return;
          form["password"] = value;
        },
      )
    ];
  }

  /// Data load.
  ///
  /// [context]: Build context.
  @override
  FutureOr<IDataDocument<IDataField>> loader(BuildContext context) {
    return null;
  }

  /// What happens when a form is submitted.
  @override
  void onSubmit(BuildContext context) async {
    if (!this.validate(context)) return;
    context.navigator.pushReplacementNamed(this.data.getString("redirect_to"));
  }
}
