import 'package:flutter/material.dart';

Widget loadingWidget(String message) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Center(
          child: Text(
            message,
          ),
        ),
      ],
    );
