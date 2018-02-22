XVEMSH2 ;DJB/VSHL**KEYBOARD [9/30/95 6:57pm];2017-08-15  5:00 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
KEYS ;;;
 ;;; K E Y B O A R D
 ;;;
 ;;; There are certain Key combinations used throughout the VShell. To enter them
 ;;; correctly, hit the first key, release it, then hit the second key.
 ;;; Example: <ESC>H. Hit the <ESC> key and release it. Then hit the H key.
 ;;;
 ;;; <ESC><ESC>  This combination normally allows you to Quit back to the ">>"
 ;;;             prompt.
 ;;; <ESC>H      This will bring up any Help text.
 ;;; <ESC>Q      When you've selected a command from the Command Line History,
 ;;;             you may hit <ESC>Q if you wish to convert the command to a User
 ;;;             QWIK.
 ;;; <ESC>U      When you're editing a QWIK and are at the CODE: prompt, you can
 ;;;             hit <ESC>U to UNsave code that was SAved in either the VPE
 ;;;             routine or global editors.
 ;;;
 ;;; Certain keys act differently depending on where you are in the VShell.
 ;;;
 ;;; -->  A R R O W   K E Y S
 ;;;
 ;;; Module:  VShell    VGL                     VRR                VEDD
 ;;; Prompt:  >>       Session 1...Global ^    Select ROUTINE:    Select FILE:
 ;;; When you are at the above prompts, if you haven't typed any characters:
 ;;;    Left Arrow...Display last 20 commands of Command Line History (CLH)
 ;;;    Up Arrow.....Move up 1 command in the CLH
 ;;;    Down Arrow...Move down 1 command in the CLH
 ;;; If you have typed any characters, the arrow keys are used to position the
 ;;; cursor for editing.
 ;;;
 ;;; When moving up and down the CLH, if the cursor is not moved from its position
 ;;; at the end of the command line, Up & Down Arrow will move you to the next
 ;;; command. If the cursor is moved and is no longer at the end of the command
 ;;; line, Up & Down Arrow will move you up and down the lines of the command
 ;;; itself, if the command has more than one line. Once you've moved the cursor,
 ;;; if you want the next command in CLH, you reposition the cursor to the end of
 ;;; the command line (Use <F1><AR> key combination).
 ;;;
 ;;; -->  F   K E Y S
 ;;;
 ;;; When you are at the VShell prompt ">>", and you have not typed any characters:
 ;;;   <F1>1  List User QWIK Commands with Description
 ;;;   <F1>2  List User QWIK Commands with Code
 ;;;   <F1>3  List System QWIK Commands with Description
 ;;;   <F1>4  List System QWIK Commands with Code
 ;;;
 ;;; When you are using the CLH editor:
 ;;;   <F1><AL>  Moves cursor to beginning of line
 ;;;   <F1><AR>  Moves cursor to end of line
 ;;;   <F2><AL>  Moves cursor left 15 characters
 ;;;   <F2><AR>  Moves cursor right 15 characters
 ;;;
 ;;; NOTE: On VT-100 keyboards substitute the PF1,PF2 keys.
 ;;;
 ;;; -->  T A B   K E Y
 ;;;
 ;;; When you are at the VShell prompt ">>", and you have not typed any characters:
 ;;;   <TAB>  Allows you to enter/edit User QWIKs
 ;;;
 ;;; When using the CLH editor:
 ;;;   <TAB>  Can be used to exit
 ;;;***
