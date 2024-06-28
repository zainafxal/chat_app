import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final bool showVisibilityIcon; // Control visibility icon visibility
  final TextEditingController controller;
  bool obsc;
  final FocusNode? focusNode;

  MyTextField({
    super.key,
    required this.hintText,
    required this.showVisibilityIcon,
    required this.controller,
    required this.obsc,
    this.focusNode,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  // bool _obscureText = obsc; // Manage password visibility state

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obsc,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary)),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          suffixIcon: widget.showVisibilityIcon // Conditionally show icon
              ? IconButton(
                  icon: Icon(
                    widget.obsc ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.obsc = !widget.obsc;
                    });
                  },
                )
              : null, // Hide icon if not required
        ),
      ),
    );
  }
}
