#!/bin/sh
export WINEPREFIX="${HOME}/.sketchup64"
# wine SketchUpMake-en-x64.exe
# winetricks corefonts
# cp $WINEPREFIX/drive_c/windows/syswow64/mfc100u.dll $WINEPREFIX/drive_c/windows/system32
wine "C:\Program Files (x86)\SketchUp\SketchUp 2016\SketchUp.exe"
