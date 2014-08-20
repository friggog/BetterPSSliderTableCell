BetterPSSliderTableCell
=======================

Improved PSSliderTabelCell

=======================

If you modify this class I recommend renaming the class as, even if in a different bundle, classes of the same name seem to conflict with preferenceloader.

To use, add BetterPSSliderTableCell.mm to xxx_FILES in your makefile and add the following to any slider specifiers in your plist.
```
  <key>cellClass</key>
  <string>BetterPSSliderTableCell</string>
```

This code uses ARC, to enabled ARC just add the following to your makefile.
```
ADDITIONAL_CFLAGS = -fobjc-arc
```

=======================

Charlie Hewitt 2014
