import 'package:flutter/material.dart';

class EmailInput extends StatefulWidget {
  const EmailInput({
    super.key,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.controller,
    this.decoration,
    this.autofocus = false,
    this.style,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
  });
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final bool autofocus;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }

    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(EmailInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? _controller;
    }
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);
      _focusNode = widget.focusNode ?? _focusNode;
      _focusNode.addListener(_handleFocusChange);
    }
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      _validateEmail(_controller.text);
    }
  }

  void _validateEmail(String value) {
    setState(() {
      if (widget.validator != null) {
        _errorText = widget.validator!(value);
      } else {
        _errorText = _defaultValidator(value);
      }
    });
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.emailAddress,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      style: widget.style,
      decoration: (widget.decoration ??
              const InputDecoration(labelText: 'Email'))
          .copyWith(errorText: _errorText),
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
        if (_errorText != null) {
          _validateEmail(value);
        }
      },
      onEditingComplete: () {
        if (widget.nextFocusNode != null) {
          widget.nextFocusNode?.requestFocus();
        } else {
          _focusNode.unfocus();
        }
      },
      onFieldSubmitted: (_) {
        if (widget.nextFocusNode != null) {
          widget.nextFocusNode?.requestFocus();
        } else {
          _focusNode.unfocus();
        }
      },
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return _defaultValidator(value);
      },
    );
  }
}
