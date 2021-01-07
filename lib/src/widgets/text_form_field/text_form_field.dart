import 'package:cubes/src/observable/observable_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CTextFormFieldControl {
  final bool enable;
  final String text;
  final String error;

  CTextFormFieldControl({this.enable, this.text, this.error});

  CTextFormFieldControl copyWith({
    String value,
    bool enable,
    String error,
  }) {
    return CTextFormFieldControl(
      text: value ?? this.text,
      enable: enable ?? this.enable,
      error: error,
    );
  }
}

enum CObscureTextAlign {
  none,
  left,
  right,
}

class CObscureTextButtonConfiguration {
  final Widget iconShow;
  final Widget iconHide;
  final CObscureTextAlign align;

  CObscureTextButtonConfiguration({
    this.iconShow,
    this.iconHide,
    this.align = CObscureTextAlign.right,
  });

  const CObscureTextButtonConfiguration.none({
    this.iconShow,
    this.iconHide,
  }) : this.align = CObscureTextAlign.none;
}

class CTextFormField extends StatefulWidget {
  final ObservableValue<CTextFormFieldControl> observable;
  final InputDecoration decoration;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChanged;
  final CObscureTextButtonConfiguration obscureTextButtonConfiguration;
  final bool obscureText;
  final AutovalidateMode autovalidateMode;
  final FocusNode focusNode;
  final GestureTapCallback onTap;
  final ValueChanged<String> onFieldSubmitted;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final TextStyle style;
  final TextAlign textAlign;
  final int maxLines;
  final int minLines;
  final bool expands;
  final int maxLength;
  final bool showCursor;
  final bool autofocus;
  final bool readOnly;
  final bool autocorrect;
  final bool enableSuggestions;
  final double cursorWidth;
  final double cursorHeight;
  final Radius cursorRadius;
  final Color cursorColor;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final TextAlignVertical textAlignVertical;
  final TextCapitalization textCapitalization;

  const CTextFormField({
    Key key,
    @required this.observable,
    this.decoration = const InputDecoration(),
    this.validator,
    this.obscureTextButtonConfiguration = const CObscureTextButtonConfiguration.none(),
    this.onChanged,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.autovalidateMode,
    this.focusNode,
    this.onTap,
    this.onFieldSubmitted,
    this.textInputAction,
    this.inputFormatters,
    this.keyboardType,
    this.style,
    this.minLines,
    this.maxLength,
    this.maxLines = 1,
    this.expands = false,
    this.autofocus = false,
    this.readOnly = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.showCursor,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.strutStyle,
    this.textDirection,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
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
      if (control.text != null && control.text != _controller.text) {
        _controller.text = control.text;
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
      focusNode: widget.focusNode,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus,
      showCursor: widget.showCursor,
      readOnly: widget.readOnly,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      cursorColor: widget.cursorColor,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      textAlignVertical: widget.textAlignVertical,
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textCapitalization: widget.textCapitalization,
      onChanged: (text) {
        widget.observable.modify((value) => value.copyWith(value: text));
        widget.onChanged?.call(text);
      },
      decoration: widget.decoration?.copyWith(
        errorText: (_error?.isNotEmpty ?? false) ? _error : null,
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
    if (widget.obscureText && widget?.obscureTextButtonConfiguration?.align == CObscureTextAlign.right) {
      Widget icon = _obscureText
          ? widget?.obscureTextButtonConfiguration?.iconShow ?? Icon(Icons.visibility_outlined)
          : widget?.obscureTextButtonConfiguration?.iconHide ?? Icon(Icons.visibility_off_outlined);
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
    if (widget.obscureText && widget?.obscureTextButtonConfiguration?.align == CObscureTextAlign.left) {
      Widget icon = _obscureText
          ? widget?.obscureTextButtonConfiguration?.iconShow ?? Icon(Icons.visibility_outlined)
          : widget?.obscureTextButtonConfiguration?.iconHide ?? Icon(Icons.visibility_off_outlined);
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
