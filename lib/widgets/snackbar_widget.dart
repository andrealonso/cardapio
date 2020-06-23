import 'package:flutter/material.dart';

class SnackbarWidget {
  SnackBar dasdsa({String texto, String label, Function clicar}) {
    return SnackBar(
      content: Text(texto),
      action: SnackBarAction(
        label: label,
        onPressed: clicar,
      ),
    );
  }
}
