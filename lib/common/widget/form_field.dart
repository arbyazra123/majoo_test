import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const InputDecoration defaultInputDecoration = InputDecoration();
const Icon defaultPickerIcon = Icon(Icons.arrow_drop_down);

abstract class CustomFormField<T> extends FormField<T> {
  late CustomFormFieldController<T> controller;

  CustomFormField({
    required this.controller,
    T? initialValue,
    FormFieldBuilder<T>? builder,
    FormFieldValidator<T>? validator,
    FormFieldSetter<T>? onSaved,
    bool enabled = true,
    bool autoValidate = false,
    Key? key,
  }) : super(
            initialValue: controller.value ?? initialValue,
            builder: builder!,
            validator: validator,
            onSaved: onSaved,
            autovalidateMode: autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            enabled: enabled,
            key: key);

  @override
  FormFieldState<T> createState() => CustomFormFieldState<T>();
}

abstract class CustomFormFieldController<T> extends ChangeNotifier
    implements ValueListenable<T> {
  final TextEditingController textController = TextEditingController();

  T _value;

  CustomFormFieldController(this._value) {
    final value = fromValue(_value);
    // if (value != null) {
      textController.text = value;
    // }
  }

  void _initState(void Function(T value) didChange) {
    textController.addListener(() {
      final newValue = toValue(textController.text);
      if (newValue != null && _value != newValue) {
        didChange(newValue);
      }
    });
  }

  String fromValue(T value);

  T toValue(String text);

  @override
  T get value => _value;

  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    if (_value != null) {
      final text = fromValue(_value);
      if (text != textController.text) {
        textController.text = text;
      }
    } else {
      textController.clear();
    }
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}

class CustomFormFieldState<T> extends FormFieldState<T> {
  late VoidCallback _listener;

  CustomFormFieldController<T> get _controller => widget.controller;

  @override
  CustomFormField<T> get widget => super.widget as CustomFormField<T>;

  @override
  void initState() {
    super.initState();
    _listener = () {
      final newValue = _controller.value;
      if (value != newValue) {
        didChange(newValue!);
      }
    };
    _controller._initState(didChange);
    _controller.addListener(_listener);
  }

  @override
  void didUpdateWidget(CustomFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_listener);
      final _controller = this._controller;
      // if (_controller != null) {
        _controller.addListener(_listener);
        setValue(oldWidget.controller.value);
      // }
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _controller.value = widget.initialValue!;
    });
  }

  @override
  void didChange(T? value) {
    if (_controller.value != value) {
      _controller.value = value!;
    }

    /// check mounted to prevent memory leak when setState after dispose
    if (mounted && this.value != value) {
      super.didChange(value);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }
}
