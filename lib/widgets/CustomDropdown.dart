import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final ValueChanged<String>? textChange;
  final String hint;
  final String? hintText;
  final TextEditingController textController;
  final bool readOnly;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.textChange,
    required this.textController,
    this.readOnly = false,
    this.hint = 'Select an option',
    this.hintText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 50,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 0, bottom: 0),
              child: TextField(
                controller: textController,
                readOnly: readOnly,
                onChanged: textChange,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: const Color.fromARGB(255, 201, 201, 201),
            margin: const EdgeInsets.symmetric(vertical: 4),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: DropdownButton<T>(
                icon: Transform.rotate(
                  angle: -90 * (3.14 / 180),
                  child: const Icon(Icons.chevron_left_sharp),
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
                isExpanded: true,
                value: value,
                hint: Text(hint),
                menuMaxHeight: 400,
                items: items,
                elevation: 0,
                onChanged: onChanged,
                underline: Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
