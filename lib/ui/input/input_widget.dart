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
        contentPadding: EdgeInsets.only(
          top: widget.maxLines > 1 ? 20.h : 0,
          left: 10.w,
          right: 10.w,
          bottom: 0,
        ),
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: AppDS.color.error,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: AppDS.color.error,
          ),
        ),
        suffixIcon: widget.isPassword ? _togglePasswordSuffix : null,
      );

  InputDecoration get _defaultInputDecoration => InputDecoration(
        contentPadding: EdgeInsets.only(
          top: widget.maxLines > 1 ? 20.h : 0,
          left: 10.w,
          right: 10.w,
          bottom: 0,
        ),
        alignLabelWithHint: true,
        hintText: widget.focusNode?.hasFocus ?? false ? '' : widget.placeholder,
        labelStyle: TextStyle(
          color: AppDS.color.contrast,
          fontSize: 18.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDS.borderRadius.small.h),
          borderSide: BorderSide(
            color: AppDS.color.accent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: AppDS.color.accent,
          ),
        ),
        suffixIcon: widget.suffixIcon ??
            (widget.isPassword ? _togglePasswordSuffix : null),
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
    return Theme(
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
