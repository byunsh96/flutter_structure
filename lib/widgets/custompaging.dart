import 'package:flutter/material.dart';

class CustomPaging extends StatelessWidget{
  final int currentPage;
  final int totalPages;
  final Function(int) onPageSelected;

  CustomPaging({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('widget.totalPages : ${totalPages}');
    print('widget.currentPage : ${currentPage}');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        totalPages,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: InkWell(
            onTap: () => onPageSelected(index + 1),
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: currentPage == index + 1 ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )..insert(
        0,
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: currentPage == 1
              ? null
              : () => onPageSelected(currentPage - 1),
        ),
      )..add(
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: currentPage == totalPages
              ? null
              : () => onPageSelected(currentPage + 1),
        ),
      ),
    );
  }
}