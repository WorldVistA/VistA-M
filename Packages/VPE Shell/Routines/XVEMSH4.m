XVEMSH4 ;DJB/VSHL**SYSTEM QWIKS [9/8/97 8:24pm];2017-08-15  5:00 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
SYSTEM ;;;
 ;;; S Y S T E M   Q W I K S
 ;;;
 ;;; System QWIKs come with the VShell. To invoke a System QWIK, type two dots
 ;;; followed by the name. For example, to run VGL you would type ..VGL.
 ;;; The following is a list of the available System QWIKs, grouped by category:
 ;;;
 ;;; 1.) QWIK RELATED
 ;;;
 ;;; QB     Assign User QWIKs to a Box. See BOXES help text.
 ;;; QC     Copy a QWIK.
 ;;; QD     Delete a QWIK.
 ;;; QE     Add/Edit a QWIK. Same as <TAB>.
 ;;; QL1    List User QWIKs/Description - Same as <F1>1.
 ;;; QL2    List User QWIKs/Code - Same as <F1>2.
 ;;; QL3    List System QWIKs/Description - Same as <F1>3.
 ;;; QL4    List System QWIKs/Code - Same as <F1>4.
 ;;; QSAVE  Saves your User QWIKs to a routine. Use for back-up or to send your
 ;;;        QWIKs to another programmer. This option also restores previously
 ;;;        saved QWIKs.
 ;;; QV     Create QWIKs that will run on different vendors' Mumps systems. See
 ;;;        VENDOR SPECIFIC CONFIGURATIONS help text.
 ;;; QVL    List Vendor Specific Code for QWIKs set up with QV.
 ;;;
 ;;; 2.) SHELL RELATED
 ;;;
 ;;; CLH     Resequences your Command Line History. The VShell saves your last 20
 ;;;         commands. As new commands are added and old commands dropped, the
 ;;;         sequence number of each entry can get large. You may type ..CLH
 ;;;         at anytime, to resequence the numbers back to 1-20.
 ;;; DTMVT   For DataTree users. If you Control C out of some DataTree utilities,
 ;;;         VT100 terminal emulation is no longer in effect and you will see
 ;;;         junk on the screen. Use this QWIK to reset your terminal to VT100.
 ;;; PARAM   Enter System Parameters. See MISCELLANEOUS help text.
 ;;; PUR     The VShell has it's own scratch area: ^XVEMS("%"). PUR will purge
 ;;;         older nodes left behind by a previous session.
 ;;; PURVGL  Purge VGL's Command Line History.
 ;;; PURVRR  Purge VRR's Command Line History.
 ;;; PURVEDD Purge VEDD's Command Line History.
 ;;; PURVSHL Purge Command Line History for the VShell.
 ;;; UL      List VShell Users, including DUZ and ID numbers.
 ;;; VER     Displays VShell version number.
 ;;;
 ;;; 3.) PROGRAMMER TOOLS
 ;;;
 ;;; ASCII   ASCII table display.
 ;;; CAL     6 month calendar display.
 ;;; E       VRoutine Editor.
 ;;; KEY     Display escape sequence for any key pressed.
 ;;; LBRY    Routine Library. Used with ..E to help prevent routines from being
 ;;;         accidentily overwritten when there are multiple programmers working
 ;;;         on the same routines.
 ;;; NOTES   VPE programmer notes.
 ;;; RL      Routine Lister
 ;;; RTN     Start a new M routine. You may enter your lines of
 ;;;         code and it will prompt you for a routine name and save it to disk.
 ;;; VEDD    VElectronic Data Dictionary.
 ;;; VGL     VGlobal Lister.
 ;;; VRR     VRoutine Reader.
 ;;; ZD      Kill all local variables that start with %1(parameter).
 ;;; ZP      Use to ZPRINT a routine.
 ;;; ZR      Use to ZREMOVE from 1 to 9 routines.
 ;;; ZW      ZWRITE the symbol table. Writes the variables one page at a time.
 ;;;
 ;;; 4.) FILEMAN/VA KERNEL RELATED
 ;;;
 ;;; FMC     Fileman programmer calls.
 ;;; FMTI    Fileman Input Template display.
 ;;; FMTP    Fileman Print Template display.
 ;;; FMTS    Fileman Sort Template display.
 ;;; LF      VA KERNEL Libray Functions.
 ;;; XQRT    Help text for VA Kernel menu options.
 ;;;
 ;;; 5.) VENDOR GENERIC QWIKS
 ;;;
 ;;;     See VENDOR SPECIFIC CONFIGURATIONS help text.
 ;;;***
