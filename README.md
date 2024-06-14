# Dependent on Theme in ListView.builder Sample

In `ListView.builder`, 

the widget dependent on `ThemeData` with `Theme.of(context)` 

cannot be rebuilt using the `BuildContext` provided by `itemBuilder`.


see [lib/home.dart](./lib/home.dart).

## The Way to Reproduce This Issue(?)

1. Run this app
2. change your system theme mode.

## Tested on ...

flutter 3.19.6 & 3.22.0