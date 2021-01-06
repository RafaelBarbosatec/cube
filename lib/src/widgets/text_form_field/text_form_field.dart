import 'package:cubes/src/observable/observable_value.dart';
import 'package:flutter/material.dart';

class TextFormFieldControl {
  final bool enable;
  final String value;
  final String error;

  TextFormFieldControl({this.enable, this.value, this.error});

  TextFormFieldControl copyWith({
    String value,
    bool enable,
    String error,
  }) {
    return TextFormFieldControl(
      value: value ?? this.value,
      enable: enable ?? this.enable,
      error: error ?? this.error,
    );
  }
}

enum ObscureTextAlign {
  none,
  left,
  right,
}

class ObscureTextConfiguration {
  final Widget iconShow;
  final Widget iconHide;
  final ObscureTextAlign align;

  ObscureTextConfiguration({
    this.iconShow,
    this.iconHide,
    this.align = ObscureTextAlign.right,
  });

  const ObscureTextConfiguration.none({
    this.iconShow,
    this.iconHide,
  }) : this.align = ObscureTextAlign.none;
}

class CTextFormField extends StatefulWidget {
  final ObservableValue<TextFormFieldControl> observable;
  final InputDecoration decoration;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChanged;
  final ObscureTextConfiguration obscureTextConfiguration;
  final bool obscureText;
  final AutovalidateMode autovalidateMode;

  const CTextFormField({
    Key key,
    this.observable,
    this.decoration,
    this.validator,
    this.obscureTextConfiguration = const ObscureTextConfiguration.none(),
    this.onChanged,
    this.obscureText = false,
    this.autovalidateMode,
  }) : super(key: key);
  @override
  _CTextFormFieldState createState() => _CTextFormFieldState();
}

class _CTextFormFieldState extends State<CTextFormField> {
  TextEditingController _controller = TextEditingController();
  bool _enable;
  bool _obscureText = false;
  String _error;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    widget.observable.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.observable.removeListener(listener);
    super.dispose();
  }

  void listener() {
    final control = widget.observable.value;

    Future.delayed(Duration.zero, () {
      if (control.value != null && control.value != _controller.text) {
        _controller.text = control.value;
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
      }

      if (_enable != control.enable) {
        setState(() {
          _enable = control.enable;
        });
      }

      if (_error != control.error) {
        setState(() {
          _error = control.error;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      enabled: _enable,
      obscureText: _obscureText,
      autovalidateMode: widget.autovalidateMode,
      onChanged: (text) {
        widget.onChanged?.call(text);
        widget.observable.modify((value) => value.copyWith(value: text));
      },
      decoration: (widget.decoration ?? InputDecoration()).copyWith(
        errorText: _error.isNotEmpty ? _error : null,
        suffixIcon: _buildSuffixIcon(),
        prefixIcon: _buildPrefixIcon(),
      ),
      validator: (value) {
        String error = widget?.validator?.call(value);
        widget.observable.modify((value) => value.copyWith(error: error ?? ''));
        return error;
      },
    );
  }

  Widget _buildSuffixIcon() {
    if (widget.obscureText && widget?.obscureTextConfiguration?.align == ObscureTextAlign.right) {
      Widget icon = _obscureText
          ? widget?.obscureTextConfiguration?.iconShow ?? Icon(Icons.visibility_outlined)
          : widget?.obscureTextConfiguration?.iconHide ?? Icon(Icons.visibility_off_outlined);
      return IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else {
      return null;
    }
  }

  Widget _buildPrefixIcon() {
    if (widget.obscureText && widget?.obscureTextConfiguration?.align == ObscureTextAlign.left) {
      Widget icon = _obscureText
          ? widget?.obscureTextConfiguration?.iconShow ?? Icon(Icons.visibility_outlined)
          : widget?.obscureTextConfiguration?.iconHide ?? Icon(Icons.visibility_off_outlined);
      return IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else {
      return null;
    }
  }
}
