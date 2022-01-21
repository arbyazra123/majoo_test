import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'form_field.dart';

class CustomTextFormField extends CustomFormField<String> {
  CustomTextFormField({
    String? label,
    String? title,
    String? hint,
    TextController? controller,
    BuildContext? context,
    bool enabled = true,
    bool mandatory = true,
    bool isObscureText = false,
    bool isEmail = false,
    bool isDigit = false,
    FormFieldValidator<String>? validator,
    double padding = 4,
    TextInputAction? textInputAction,
    Widget? suffixIcon,
    Key? key,
  }) : super(
          key: key,
          controller: controller!,
          enabled: enabled,
          builder: (FormFieldState<String> state) {
            return _CustomTextForm(
              label: label,
              controller: controller,
              hint: hint!,
              state: state,
              mandatory: mandatory,
              isObscureText: isObscureText,
              suffixIcon: suffixIcon,
              isEmail: isEmail,
              isDigit: isDigit,
              padding: padding,
              textInputAction: textInputAction,
            );
          },
          validator: (picker) {
            if (mandatory && (picker == null || picker.isEmpty)) {
              return 'this field is required';
            }
            if (validator != null) {
              return validator(picker);
            }
            return null;
          },
        );
}

class TextController extends CustomFormFieldController<String> {
  TextController({String? initialValue}) : super(initialValue ?? "");

  @override
  String fromValue(String value) => value;

  @override
  String toValue(String text) => text;
}

class _CustomTextForm extends StatefulWidget {
  final FormFieldState<String>? state;
  final TextController? controller;
  final double padding;
  final String? label;
  final String? hint;
  final bool mandatory;
  final bool isObscureText;
  final bool isEmail;
  final bool isDigit;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;

  const _CustomTextForm({
    this.state,
    this.controller,
    this.label,
    this.hint,
    this.padding = 0,
    this.isObscureText = false,
    this.isEmail = false,
    this.mandatory = false,
    this.isDigit = false,
    this.textInputAction,
    this.suffixIcon,
  });

  @override
  State<StatefulWidget> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<_CustomTextForm> {
  final _focusNode = FocusNode();

  String get _hint => widget.hint!;

  bool get _mandatory => widget.mandatory;

  String? get _label {
    var fullLabel = StringBuffer();
    final label = widget.label;
    if (label != null) {
      fullLabel.write(label);
      if (_mandatory) fullLabel.write(' *');
      return fullLabel.toString();
    }
    return label!;
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final inputFormatters = <TextInputFormatter>[];
    TextInputType? keyboardType;

    if (widget.isDigit) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
      keyboardType = TextInputType.number;
    }
    if (widget.isEmail) {
      keyboardType = TextInputType.emailAddress;
    }
    final _hint = this._hint;
    return Padding(
      padding: EdgeInsets.only(bottom: widget.padding, top: widget.padding),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 300,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label != null
                      ? Text(_label!, style: TextStyle(fontSize: 12))
                      : SizedBox.shrink(),
                  SizedBox(height: 3),
                  Stack(
                    children: <Widget>[
                      if (widget.controller?.textController == null ||
                          widget.controller?.textController.text.isEmpty ==
                              true)
                        Positioned(
                            top: _label != null
                                ? 17
                                : _focusNode.hasFocus
                                    ? 17
                                    : 9,
                            left: 10,
                            child: SizedBox(
                              width: constraints.maxWidth * 0.9,
                              child: Text(
                                _hint ?? 'Fill the field here',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          textInputAction: widget.textInputAction,
                          keyboardType: keyboardType,
                          inputFormatters: inputFormatters,
                          focusNode: _focusNode,
                          textAlignVertical:
                              _label == null ? TextAlignVertical.center : null,
                          controller: widget.controller?.textController,
                          decoration: defaultInputDecoration.copyWith(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              isDense: _label == null,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              errorText: widget.state!.errorText,
                              alignLabelWithHint: true,
                              suffixIcon: _focusNode.hasFocus
                                  ? widget.suffixIcon ??
                                      IconButton(
                                        icon: const Icon(Icons.cancel),
                                        onPressed: () {
                                          widget.controller?.textController
                                              .clear();
                                        },
                                      )
                                  : null),
                          obscureText: widget.isObscureText,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
