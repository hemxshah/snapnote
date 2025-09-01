import 'package:flutter/material.dart';
import 'package:myapp/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext) {
  return showGenericDialog(
    context: context,
    title: "Delete",
    content: "Are you sure you want to delete the note?",
    optionsBuilder: ()=>{
      "Cancel" : false,
      "Delete" : true,
    },
  ).then((value) => value ?? false,);
}
