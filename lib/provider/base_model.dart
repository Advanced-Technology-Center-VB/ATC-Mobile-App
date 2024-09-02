import 'package:flutter/material.dart';

/// This class serves as the base for view models.
/// 
/// No code is required in this class as it is just a contract to make
/// the dependency injection code a bit more maintainable.
abstract class BaseModel with ChangeNotifier {}