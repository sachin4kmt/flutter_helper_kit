/// Advanced debug console helpers with ANSI styling, log levels, and HTTP logs.
library;

import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'printf_style.dart';
part 'printf.dart';

/// Resolves a clickable caller link from a [StackTrace] string (for tests).
@visibleForTesting
String? printfCallerLinkFromStackTrace(String stackTraceText) =>
    _callerLinkFromStackTrace(stackTraceText);
