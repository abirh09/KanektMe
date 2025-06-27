import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/textstyle.dart';
import '../utils/validators.dart';

class CustomTextbox extends StatefulWidget {
  final TextEditingController controller;
  final String fieldTitle;
  final String hintText;
  final bool needValidation;
  final bool? obscure;
  final String errorMessage;
  final BorderRadius? borderRadius;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final String? suffixText;
  final IconData? prefixIcon;
  final Color? backgroundColor;
  final bool? viewOnly;
  final bool? needTitle;
  final TextAlign? textAlign;
  final TextStyle? hintTextStyle;
  final TextStyle? inputTextStyle;
  final Key? itemkey;
  final Function? onValueChange;
  final GestureTapCallback? onTap;
  final TextStyle? titleStyle;
  final Widget? prefixWidget;

  final FormFieldValidator<String>? validatorClass;

  const CustomTextbox(
      {super.key,
        this.onValueChange,
        required this.controller,
        required this.hintText,
        required this.needValidation,
        required this.errorMessage,
        this.textInputAction,
        this.inputType,
        this.suffixText,
        this.backgroundColor,
        this.viewOnly,
        required this.fieldTitle,
        this.validatorClass,
        this.needTitle,
        this.textAlign,
        this.prefixIcon,
        this.itemkey,
        this.borderRadius,
        this.hintTextStyle,
        this.inputTextStyle,
        this.titleStyle,
        this.prefixWidget, this.obscure, this.onTap});

  @override
  State<CustomTextbox> createState() => _CustomTextboxState();
}

class _CustomTextboxState extends State<CustomTextbox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.needTitle ?? true)
            Wrap(
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: widget.fieldTitle, style: CustomTextStyle.tittleText),
                    if (widget.needValidation) TextSpan(text: "*", style: CustomTextStyle.tittleText.copyWith(color: CustomColors.red))
                  ]),
                ),
              ],
            ),
          if (widget.needTitle ?? true) const SizedBox(height: 5),
          TextFormField(
            key: widget.itemkey,
            controller: widget.controller,
            keyboardType: widget.inputType ?? TextInputType.text,
            style: widget.inputTextStyle ?? CustomTextStyle.generalText,
            textAlign: widget.textAlign ?? TextAlign.start,
            readOnly: widget.viewOnly ?? false,
            obscureText: widget.obscure??false,
            decoration: InputDecoration(
              errorText: "",
              errorStyle: CustomTextStyle.generalText.copyWith(fontSize: 11, color: CustomColors.red),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle ?? CustomTextStyle.generalText.copyWith(color: CustomColors.textBlack),
              filled: true,
              fillColor: widget.backgroundColor ?? CustomColors.white,
              suffixText: widget.suffixText != null ? widget.suffixText.toString() : "",
              suffixIcon: null,
              prefixIcon: widget.prefixWidget ?? (widget.prefixIcon != null ? Icon(widget.prefixIcon) : null),
              border: OutlineInputBorder(borderRadius: widget.borderRadius ?? BorderRadius.circular(10), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: widget.borderRadius ?? BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            onFieldSubmitted: (value) {
              widget.controller.text = value;
            },
            onSaved: (value) {
              widget.controller.text = value!;
            },
            validator: widget.validatorClass ?? ValidatorClass().noValidationRequired,
            onChanged: (value) {
              if (value.isNotEmpty && widget.onValueChange != null) {
                widget.onValueChange!(value);
              }
            },
            onTap: widget.onTap,
          ),
        ],
      ),
    );
  }
}