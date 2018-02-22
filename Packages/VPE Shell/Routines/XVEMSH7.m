XVEMSH7 ;DJB/VSHL**PARAMETER PASSING [04/17/94];2017-08-15  5:00 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
PARAM ;;;
 ;;; P A R A M E T E R   P A S S I N G
 ;;;
 ;;; User QWIKs can be made more powerful and flexible by using parameter passing.
 ;;; You pass parameters to your QWIKs by typing one dot and your QWIK name, and
 ;;; then from 1 to 9 parameters, each separated by a space. If the parameter
 ;;; itself contains a space, it must be enclosed in quotes. The VShell will look
 ;;; for any parameters and assign them to variables %1 thru %9. Your QWIK would
 ;;; use these variables.
 ;;;
 ;;; As an example of how to use parameter passing, lets look at System QWIK ZP.
 ;;; You use ZP to ZPRINT a routine. You would enter '..ZP ROUTINE'. You can see
 ;;; that ROUTINE is the parameter and the VShell will assign this to %1.
 ;;;
 ;;; Here is ZP's code:  Q:%1']""  ZL @%1 ZP
 ;;;
 ;;; First, this QWIK will QUIT if no routine name has been passed. Next it will
 ;;; ZLOAD the routine into your partition and then ZPRINT it. Note that you don't
 ;;; have to check to see if %1 is defined. %1-%9 are always defined either to a
 ;;; parameter or to null.
 ;;;
 ;;; If you hit '..2' at the >> prompt, to view the System QWIKs in box 2, you
 ;;; will see:  ZP   ZPrint a Routine
 ;;;                 -> %1=Routine Name
 ;;; The '%1=Routine Name' is what you would enter at the 'Edit PARAM NOTES:'
 ;;; prompt when you Enter/Edit a QWIK. Then when you view your QWIKs, these notes
 ;;; are displayed as a reminder that you need to pass a parameter when calling
 ;;; this QWIK.
 ;;;***
PROT ;;;
 ;;; P R O T E C T I O N
 ;;;
 ;;; When you enter code at the ">>" prompt, it is first checked for any global
 ;;; kills. If your code is killing a global, you will receive a warning message
 ;;; which will ask if you really want the code executed. This allows you to
 ;;; review your code and abort the execution if you note any errors.
 ;;;
 ;;; Your line of code is divided into "pieces" based on spaces. If any piece
 ;;; contains an "^" and the previous piece contains a "K", you will receive the
 ;;; warning. Some code may fit this pattern and trigger a warning even tho no
 ;;; kill is being executed. Example:  LOCK ^XXX(1,2) 
 ;;;
 ;;; NOTE: This protection is also available when using the VPE routine and
 ;;;       global editors.
 ;;;***
