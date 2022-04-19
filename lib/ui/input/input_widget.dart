import 'package:flutter/services.dart';

import '../../packages/ds/app_system.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    Key? key,
    this.placeholder,
    this.initialValue,
    this.isPassword = false,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.textInputAction,
    this.isError = false,
    this.focusNode,
    this.showCursor = true,
    this.floatingLabelBehavior,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    this.maxLines = 1,
    this.autocorrect = true,
    this.maxLength,
    this.prefixIcon,
    this.hasBorder = true,
    this.backgroundColor,
  }) : super(
          key: key,
        );

  final String? initialValue;
  final String? placeholder;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onSubmitted;
  final bool isPassword;
  final bool isError;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool showCursor;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final int maxLines;
  final bool autocorrect;
  final int? maxLength;
  final Widget? prefixIcon;
  final bool hasBorder;
  final Color? backgroundColor;

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final TextEditingController _controller = TextEditingController();

  Widget get _iconPasswordHidden => Icon(
        Icons.remove_red_eye_outlined,
        color: widget.isError ? AppDS.color.error : AppDS.color.primary,
      );

  Widget get _iconPasswordShowed => Icon(
        Icons.remove_red_eye,
        color: widget.isError ? AppDS.color.error : AppDS.color.primary,
      );

  bool _isObscured = false;

  Widget get _togglePasswordSuffix => ExcludeSemantics(
        child: GestureDetector(
          child: _isObscured ? _iconPasswordHidden : _iconPasswordShowed,
          onTap: () => setState(
            () => _isObscured = !_isObscured,
          ),
        ),
      );

  InputDecoration get _errorInputDecoration => InputDecoration(
        fillColor: widget.backgroundColor,
        alignLabelWithHint: true,
        enabledBorder: widget.hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppDS.color.error,
                ),
              )
            : InputBorder.none,
        focusedBorder: widget.hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppDS.color.error,
                ),
              )
            : InputBorder.none,
        suffixIcon: widget.isPassword ? _togglePasswordSuffix : null,
        prefixIcon: widget.prefixIcon,
      );

  InputDecoration get _defaultInputDecoration => InputDecoration(
        fillColor: widget.backgroundColor,
        alignLabelWithHint: true,
        hintText: widget.focusNode?.hasFocus ?? false ? '' : widget.placeholder,
        labelStyle: TextStyle(
          color: AppDS.color.contrast,
          fontSize: 18.sp,
        ),
        border: widget.hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDS.borderRadius.small.h),
                borderSide: BorderSide(
                  color: AppDS.color.accent,
                ),
              )
            : InputBorder.none,
        focusedBorder: widget.hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppDS.color.accent,
                ),
              )
            : InputBorder.none,
        suffixIcon: widget.suffixIcon ??
            (widget.isPassword ? _togglePasswordSuffix : null),
        prefixIcon: widget.prefixIcon,
      );

  @override
  void initState() {
    if (widget.isPassword) {
      _isObscured = true;
    }
    _controller.text = widget.initialValue ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4.h),
            blurRadius: 24.h,
            spreadRadius: 0,
            color: AppDS.color.black.withOpacity(.09),
          ),
        ],
        color: AppDS.color.white,
        borderRadius: BorderRadius.circular(AppDS.borderRadius.small.h),
      ),
      child: Theme(
        data: ThemeData(
          primaryColor: AppDS.color.primary,
        ),
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: _controller,
          obscureText: _isObscured,
          textInputAction: widget.textInputAction,
          showCursor: widget.showCursor,
          inputFormatters: widget.inputFormatters,
          decoration:
              widget.isError ? _errorInputDecoration : _defaultInputDecoration,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onSubmitted,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          autocorrect: widget.autocorrect,
          maxLength: widget.maxLength,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.focusNode != null) {
      widget.focusNode!.dispose();
    }
    super.dispose();
  }
}
