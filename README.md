BetterPSSliderTableCell
=======================

Improved PSSliderTabelCell

=======================

If you modify this class I recommend renaming the class as, even if in a different bundle, classes of the same name seem to conflict with preferenceloader.

To use, add BetterPSSliderTableCell.mm to your makefile and add 
  <key>cellClass</key>
  <string>BetterPSSliderTableCell</string>
to any slider specifiers in your plist.

This code uses ARC, you can modify it not to but I would recommend you don't. To enabled ARC just add 'ADDITIONAL_CFLAGS = -fobjc-arc' to your makefile

=======================

Charlie Hewitt 2014
