import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../packages/ds/app_ds.dart';
import 'input_widget.dart';

class FilledTextFieldWidget extends StatefulWidget {
  const FilledTextFieldWidget({
    Key? key,
    this.initialValue,
    this.placeholder,
    this.isPassword = false,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onValidator,
    this.focusNode,
    this.messageError,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    this.maxLines = 1,
    this.autocorrect = true,
    this.maxLength,
    this.prefixIcon,
  }) : super(key: key);

  final String? initialValue;
  final String? placeholder;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onValidator;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? messageError;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final int maxLines;
  final bool autocorrect;
  final int? maxLength;
  final Widget? prefixIcon;

  @override
  State<FilledTextFieldWidget> createState() => _FilledTextFieldWidgetState();
}

class _FilledTextFieldWidgetState extends State<FilledTextFieldWidget> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  bool get hasError {
    return widget.messageError != null && widget.messageError!.isNotEmpty;
  }

  bool get hasFocus => _focusNode.hasFocus;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Column(
        children: [
          InputWidget(
            focusNode: _focusNode,
            initialValue: widget.initialValue,
            isPassword: widget.isPassword,
            isError: hasError,
            placeholder: widget.placeholder,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            suffixIcon: widget.suffixIcon,
            onEditingComplete: () {
              if (widget.textInputAction == TextInputAction.next) {
                FocusScope.of(context).nextFocus();
              } else {
                FocusScope.of(context).unfocus();
              }
              widget.onValidator?.call();
              widget.onEditingComplete?.call();
            },
            onSubmitted: widget.onFieldSubmitted,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            autocorrect: widget.autocorrect,
            maxLength: widget.maxLength,
            prefixIcon: widget.prefixIcon,
            hasBorder: false,
            backgroundColor: AppDS.color.white,
          ),
        ],
      ),
    );
  }
}
