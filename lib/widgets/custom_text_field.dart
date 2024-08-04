// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController? controller;
//   final String labelText;
//   final String? hintText;
//   final bool obscureText;
//   final TextInputType keyboardType;
//   final TextStyle? labelStyle;
//   final TextStyle? hintStyle;
//   final EdgeInsetsGeometry? contentPadding;
//   final InputBorder? border;
//   final InputBorder? focusedBorder;
//   final InputBorder? enabledBorder;
//   final InputBorder? errorBorder;
//   final InputBorder? focusedErrorBorder;
//   final TextStyle? errorStyle;

//   CustomTextField({
//     this.controller,
//     required this.labelText,
//     this.hintText,
//     this.obscureText = false,
//     this.keyboardType = TextInputType.text,
//     this.labelStyle,
//     this.hintStyle,
//     this.contentPadding,
//     this.border,
//     this.focusedBorder,
//     this.enabledBorder,
//     this.errorBorder,
//     this.focusedErrorBorder,
//     this.errorStyle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: labelText,
//         hintText: hintText,
//         labelStyle: labelStyle ?? TextStyle(color: Colors.black),
//         hintStyle: hintStyle ?? TextStyle(color: Colors.grey[600]),
//         contentPadding: contentPadding ??
//             EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//         border: border ??
//             OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.blue),
//             ),
//         focusedBorder: focusedBorder ??
//             OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.blue, width: 2),
//             ),
//         enabledBorder: enabledBorder ??
//             OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey, width: 1),
//             ),
//         errorBorder: errorBorder ??
//             OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.red, width: 1),
//             ),
//         focusedErrorBorder: focusedErrorBorder ??
//             OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.red, width: 2),
//             ),
//         errorStyle: errorStyle ?? TextStyle(color: Colors.red),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  CustomTextField({required this.labelText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
