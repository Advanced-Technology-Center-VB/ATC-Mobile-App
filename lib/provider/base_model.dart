import 'package:flutter/material.dart';

// ignore_for_file: must_call_super

/// This class serves as the base for view models.
/// 
/// No code is required in this class as it is just a contract to make
/// the dependency injection code a bit more maintainable.
abstract class BaseModel with ChangeNotifier {
  @override
  void dispose() {
    /// So... you found me. Yes, it might be a bit of a poor choice, but hear me out.
    /// The lifecycle of a view model should last throughout the entire life span of the application.
    /// Therefore, disposing a view model is not something that should happen, and since the
    /// ChangeNotifierProvider likes to dispose ChangeNotifiers when it gets disposed,
    /// it might cause problems to have this method do something.
  }
}