import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../packages/ds/app_ds.dart';
import 'input_widget.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
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

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
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

  Widget errorLabel(BuildContext context) {
    if (!hasError) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              widget.messageError!,
              textAlign: TextAlign.right,
              softWrap: true,
              style: TextStyle(
                color: AppDS.color.error,
              ),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
        ],
      ),
    );
  }

  Widget label(BuildContext context) {
    if (widget.placeholder == null || !hasFocus) {
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            width: 6,
          ),
          Expanded(
            child: Text(
              widget.placeholder ?? '',
              textAlign: TextAlign.left,
              softWrap: true,
              style: AppDS.fonts.body,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Column(
        children: [
          label(context),
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
          ),
          errorLabel(context)
        ],
      ),
    );
  }
}
