part of masamune.form;

/// Template for creating form pages.
abstract class UIPageForm extends UIPageScaffold
    with UIFormMixin, UITextFieldControllerMixin {
  /// Executed when the widget is loaded.
  ///
  /// Override and use.
  ///
  /// [context]: Build context.
  @override
  @mustCallSuper
  void onLoad(BuildContext context) {
    super.onLoad(context);
    this.init(this.define(context), document: this.loader(context));
  }

  /// Creating a floating action button.
  ///
  /// [context]: Build context.
  @override
  Widget floatingActionButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: () => this.onSubmit(context),
        child: Icon(this.floatingActionButtonIcon));
  }

  /// What happens when a form is submitted.
  void onSubmit(BuildContext context);

  /// FAB icon definition.
  IconData get floatingActionButtonIcon => Icons.check;

  /// Initial definition of the controller.
  ///
  /// [context]: Build context.
  Map<String, String> define(BuildContext context);

  /// Data load.
  ///
  /// [context]: Build context.
  FutureOr<IDataDocument> loader(BuildContext context);

  /// Form body definition.
  ///
  /// [context]: Build context.
  List<Widget> formBody(BuildContext context,
      Map<String, TextEditingController> controller, IDataDocument form);

  /// Set the form type.
  ///
  /// Available for login and password reset page.
  FormBuilderType get formType => FormBuilderType.listView;

  /// Creating a body.
  ///
  /// [context]: Build context.
  @override
  Widget body(BuildContext context) {
    return FormBuilder(
        type: this.formType,
        key: this.formKey,
        children: this.formBody(context, this.controllers, this.form));
  }
}
