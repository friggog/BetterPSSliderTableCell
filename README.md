BetterPSSliderTableCell
=======================

An improved version of apple's PSSliderTableCell

If you modify this class I recommend renaming the class as, even if in a different bundle, classes of the same name seem to conflict.

To use, add BetterPSSliderTableCell.mm to xxx_FILES in your makefile and add the following to any slider specifiers in your plist (the value must be shown for there to be space for the button).
```
  <key>cellClass</key>
  <string>BetterPSSliderTableCell</string>
  <key>showValue</key>
  <true/>
```

This code uses ARC, to enabled ARC just add the following to your makefile.
```
ADDITIONAL_CFLAGS = -fobjc-arc
```

Feel free to use and modify in any capacity, including commercially.

=======================

Charlie Hewitt 2014
