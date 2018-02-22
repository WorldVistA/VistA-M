XVEMSH6 ;DJB/VSHL**COMMAND LINE HISTORY,PROGRAMMER TOOLS [5/8/97 7:46pm];2017-08-15  5:00 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
CLH ;;;
 ;;; C O M M A N D   L I N E   H I S T O R Y
 ;;;
 ;;; The VShell maintains a Command Line History (CLH) that allows you to
 ;;; capture, edit, and reissue up to 20 commands. Actually there are 4 separate
 ;;; CLH's, one for each module of VPE (VGL,VRR,VEDD) and one for the VShell itself.
 ;;; Hitting the left arrow key will display your last 20 commands, and allow you
 ;;; to edit and reissue any one. You can use the up and down arrow keys to move
 ;;; up and down the CLH, and edit and reissue any individual command.
 ;;;
 ;;; If you have a previous command that you wish to convert to a User QWIK, move
 ;;; to that command using the arrow keys, and then hit <ESC>Q for the QWIK
 ;;; dialogue. The QWIK you create will use the code from the CLH.
 ;;;
 ;;; You may purge the CLH at any time using the following System QWIKs:
 ;;;      ..PURVSHL   Purge VShell CLH
 ;;;      ..PURVRR    Purge Routine Lister/Editor CLH
 ;;;      ..PURVGL    Purge Global Lister/Editor CLH
 ;;;      ..PURVEDD   Purge VEDD CLH
 ;;;
 ;;; As commands are added and dropped from the CLH, the number of any individual
 ;;; command can become large. Each time you enter the VShell the CLH is renumbered
 ;;; back to 1-20. You can manually renumber the CLH with System QWIK ..CLH.
 ;;;
 ;;; If you have the ^%ZOSF("UCI") global node on your system, VShell will delete
 ;;; the SHL Command Line History whenever you switch UCIs. This is to protect you
 ;;; from accidientily rerunning a command in the wrong UCI.
 ;;;
 ;;; The CLH is an extremely useful tool and you should become proficient in its
 ;;; use. Remember, it is also available in VRR, VGL, and VEDD.
 ;;;***
PGM ;;;
 ;;; P R O G R A M M E R   T O O L S
 ;;;
 ;;; The VShell includes a number of programmer tools that range from a single
 ;;; routine to very sophisticated packages. They all have one thing in common:
 ;;; They're useful. These tools are System QWIKs and are located in Box 3. Type
 ;;; '..3' to see them. To use them, type two dots and the name.
 ;;;
 ;;; E       A routine editor that uses the VRR module.
 ;;; ASCII   Displays the ASCII character set.
 ;;; CAL     Six month calendar display.
 ;;; KEY     Display escape sequence for any key struck.
 ;;; VEDD    VElectronic Data Dictionary - An easy to use utility for viewing the
 ;;;         structure of Fileman files.
 ;;; VGL     VGlobal Lister/Editor - A tool to examine and edit globals.
 ;;; VRR     VRoutine Reader - Used to read routines. Allows branching to up
 ;;;         to 4 routines so you can follow any branching logic contained in the
 ;;;         code.
 ;;;***
