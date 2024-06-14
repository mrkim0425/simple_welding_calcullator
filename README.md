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

## Video

https://github.com/mrkim0425/simple_welding_calcullator/assets/67783062/0c5692d8-3b6f-44a1-aedd-ef3ef51e188f

