
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The ProviderContainer is a global object that stores all the providers of Riverpod
/// and allows us to read and modify them.
///
/// Although it is a bad practice to read provider values without using ref, it provides
/// tons of convenience in places where we need to access the providers without using ref.
final ProviderContainer _riverpodContainer = ProviderContainer();


ProviderContainer get riverpodContainer => _riverpodContainer;