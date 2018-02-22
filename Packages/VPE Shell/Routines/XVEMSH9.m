XVEMSH9 ;DJB/VSHL**VA KERNEL ;2017-08-15  5:00 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
KERN ;;;
 ;;; V A   K E R N E L
 ;;;
 ;;; The following information applies to those users who wish to run the VSHELL
 ;;; as a VA KERNEL menu option.
 ;;;
 ;;; You create the VSHELL option as an Action type: D ^XV. The name of the
 ;;; option MUST include the word 'VSHELL'. This is important. If the name doesn't
 ;;; include 'VSHELL' it will not run. The purpose for this naming convention is
 ;;; to enable the VSHELL to know when it's being called as a VA KERNEL menu
 ;;; option.
 ;;;
 ;;; The VSHELL sets a flag when it starts running. This flag prevents you from
 ;;; starting a 2nd VSHELL. If you try to run the VSHELL menu option and get a
 ;;; message saying "The VSHELL is already running", and you are not running
 ;;; the VSHELL already, it's because this flag has not been cleared. You can
 ;;; clear the flag 2 ways.
 ;;;     1. Log off the system and log back on with a new $J.
 ;;;     2. Enter Programmer Mode, kill XQY0, start the VSHELL and then HALT.
 ;;;        This will delete the VSHELL's scratch global, clearing the flag. You
 ;;;        can now DO ^ZU to reenter the VA KERNEL menu system and run the VSHELL
 ;;;        option.
 ;;;
 ;;; If you enter the VSHELL from a VA KERNEL menu option, switch UCIs, and then
 ;;; try to HALT, you will receive a message telling you to move back to the UCI
 ;;; you first came in from, and then you can HALT.
 ;;;
 ;;; NOTE: If you run a VA KERNEL menu option using ^XUP while in the VSHELL, you
 ;;; may be halted from the system upon return. This is NOT caused by the VSHELL,
 ;;; but is a factor of the VA KERNEL software.
 ;;;***
