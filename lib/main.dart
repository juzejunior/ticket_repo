import 'package:flutter/material.dart';
import 'package:top_up_ticket/app/view/app.dart';
import 'package:top_up_ticket/core/providers/app_repository_provider.dart';

void main() {
  runApp(
    const AppRepositoryProvider(
      child: MyApp(),
    ),
  );
}
