XVEMRH1 ;DJB/VRR**Help Text [10/22/96 8:35am];2017-08-15  1:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
VRR1 ;;;
 ;;;  B L O C K   M O D E:
 ;;;
 ;;;  In EDIT mode, type <F3> to change to BLOCK mode. The word BLOCK will
 ;;;  appear at the upper right of the screen. Use the Up/Down Arrow keys to
 ;;;  highlight routine lines. To act on the highlighted lines do:
 ;;;     <ESC>C .....Copy lines to the clipboard
 ;;;     <ESC>X .....Cut lines to the clipboard
 ;;;     <DEL> ......Delete lines
 ;;;     <F3> .......Return to EDIT mode without taking action
 ;;;
 ;;;  While in BLOCK mode, you may position the cursor and then hit:
 ;;;     <F1><AL> ...Highlight all lines from cursor to top of routine
 ;;;     <F1><AR> ...Highlight all lines from cursor to bottom of routine
 ;;;
 ;;;  When you've returned to EDIT mode, position the cursor and hit <ESC>V
 ;;;  to paste saved lines into the current routine. The new lines will be
 ;;;  inserted below the cursor. In MENU BAR mode you can branch to other routines
 ;;;  save code to the clipboard, return to the current routine, and paste the
 ;;;  code in.
 ;;;
 ;;;  M E N U   B A R   M O D E:
 ;;;
 ;;;  In EDIT mode, type <TAB> to change to MENU BAR mode. This positions the
 ;;;  cursor at the bottom of the screen and the following menu becomes active:
 ;;;
 ;;;    R         Branch to selected routine.
 ;;;              NOTE: You can also branch to a routine while in EDIT mode.
 ;;;              To do so, position the cursor over the "^" part of any routine
 ;;;              referenced on the screen, and hit <ESC>R.
 ;;;
 ;;;    F         Find selected Line Tag. Search begins on next line after cursor.
 ;;;              Use <ESC>N in EDIT mode to find next occurance.
 ;;;
 ;;;    L         Locate selected string. Search begins on next line after cursor.
 ;;;              Use <ESC>N in EDIT mode to find next occurance.
 ;;;
 ;;;    G         Move to selected line number in current routine. Also, you may
 ;;;              goto a line by entering 'Line Tag+Offset' (Ex: EN+15)
 ;;;
 ;;;    J         Join 2 lines you select.
 ;;;
 ;;;    JC        Join next line to current line.
 ;;;
 ;;;    S         Display routine size.
 ;;;
 ;;;    LC        Locate and change all occurances of selected string.
 ;;;
 ;;;    RS        Search routine(s) for selected string.
 ;;;
 ;;;    VEDD      Branch to Electronic Data Dictionary
 ;;;
 ;;;    VGL       Branch to Global Lister
 ;;;              NOTE: You may also branch to a global while in EDIT mode,
 ;;;              by passing the global reference as a parameter. To do so,
 ;;;              find the global reference on the screen, position the curosr
 ;;;              at the start of the name and hit <ESC>G. Then position the
 ;;;              cursor as far to the right as you want to include as your
 ;;;              parameter, and hit <ESC>G again.
 ;;;
 ;;;    CALL      Helps you construct certain programmer calls and inserts
 ;;;              them into your code.
 ;;;
 ;;;    FMC       View VShell's 'Fileman Calls' database.
 ;;;
 ;;;    ASC       View VShell's 'ASCII Table' display.
 ;;;
 ;;;    PUR       Purge the Clipboard (^XVEMS("E","SAVEVRR")).
 ;;;***
