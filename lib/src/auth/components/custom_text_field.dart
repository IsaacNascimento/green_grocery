import "package:flutter/material.dart";


class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isPasswordField;

  const CustomTextField({
    Key? key, 
    required this.icon,
    required this.label,
    this.isPasswordField = false,
    }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool isObscureText = false;

  @override
  void initState() {
    super.initState();

    isObscureText = widget.isPasswordField ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        obscureText: isObscureText,
        decoration: InputDecoration(
            suffixIcon: widget.isPasswordField ? IconButton(
              onPressed: () => {
                setState(() {
                  isObscureText = !isObscureText;
                })
              },
              icon: Icon(isObscureText ? Icons.visibility : Icons.visibility_off),
            ) : null, 
            prefixIcon: Icon(widget.icon),
            labelText: widget.label,
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            )),
      ),
    );
  }
}
