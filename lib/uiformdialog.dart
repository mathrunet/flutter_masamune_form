part of masamune.form;

/// Show dialog for form.
///
/// ```
/// UIFormDialog.show( context );
/// ```
class UIFormDialog {
  /// Show dialog.
  ///
  /// [context]: Build context.
  /// [dialogTitlePath]: Dialog title path.
  /// [dialogSubmitTextPath]: Dialog submit button text path.
  /// [dialogSubmitActionPath]: The path of action when the submit button of the dialog is pressed.
  /// [submitText]: Default submit button text.
  /// [submitHeight]: Height of submit button.
  /// [onSubmit]: Default submit button action.
  /// [submitBorderRadius]: Border radius of the Submit button.
  /// [submitBackgroundColor]: Background color of the Submit button.
  /// [title]: Default title.
  /// [popOnPress]: True if the dialog should be closed together when the button is pressed.
  static Future show(BuildContext context,
      {String dialogTitlePath = DefaultPath.dialogTitle,
      String dialogSubmitTextPath = DefaultPath.dialogSubmitText,
      String dialogSubmitActionPath = DefaultPath.dialogSubmitAction,
      String submitText = "OK",
      List<Widget> children,
      BorderRadiusGeometry submitBorderRadius,
      Color submitBackgroundColor,
      double submitHeight = 80,
      String title,
      bool popOnPress = true,
      VoidAction onSubmit}) async {
    if (context == null) return;
    String _title = context.read(dialogTitlePath, defaultValue: title);
    if (_title == null || children == null) return;
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    OverlayState overlay = context.navigator.overlay;
    await showDialog(
        context: overlay.context,
        builder: (context) {
          return WillPopScope(
              onWillPop: null,
              child: Form(
                  key: key,
                  child: SimpleDialog(
                    title: Text(_title),
                    titlePadding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                    children: [
                      ...children,
                      FormItemSubmit(
                        label: submitText,
                        height: submitHeight,
                        backgroundColor: submitBackgroundColor,
                        borderRadius: submitBorderRadius,
                        onPressed: () {
                          if (!key.currentState.validate()) return;
                          key.currentState.save();
                          PathMap.removeAllPath([
                            dialogTitlePath,
                            dialogSubmitTextPath,
                            dialogSubmitActionPath,
                            dialogSubmitTextPath
                          ]);
                          context.readAction(dialogSubmitActionPath,
                              defaultAction: onSubmit)();
                          if (popOnPress)
                            Navigator.of(context, rootNavigator: true).pop();
                        },
                      )
                    ],
                  )));
        });
    PathMap.removeAllPath([
      dialogTitlePath,
      dialogSubmitTextPath,
      dialogSubmitActionPath,
      dialogSubmitTextPath
    ]);
  }
}
