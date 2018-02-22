XVEMSH1 ;DJB/VSHL**INTRO,PROTECTION ;2017-08-15  5:00 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
INTRO ;;;
 ;;; I N T R O D U C T I O N
 ;;;
 ;;; I am making the VICTORY PROGRAMMER ENVIRONMENT (VPE) software package
 ;;; available to M (Mumps) users under the following conditions:
 ;;; o  VPE may be distributed freely without charge.
 ;;; o  VPE may not be sold, licensed, or a fee charged for its use.
 ;;; o  Any other use, distribution, or representation of VPE is expressly
 ;;;    forbidden without the written consent of David J. Bolduc.
 ;;; DAVID J. BOLDUC
 ;;;
 ;;; Welcome to the VPE VShell. This M Shell is designed for people who work in
 ;;; programmer mode. It will provide an environment that is safer than normal
 ;;; programmer mode, and will help you organize your work and reduce the
 ;;; keystrokes required to accomplish your tasks.
 ;;;
 ;;; You enter the VShell with the command 'D ^XV'. You exit by entering any
 ;;; of the following: '^,H,h,HALT,halt'.
 ;;;
 ;;; To allow you to distinguish between the VShell and normal programmer mode,
 ;;; the ">" prompt is replaced with ">>".
 ;;; >D ^XV
 ;;; >>
 ;;;
 ;;; When you first enter the VShell you'll be asked for an ID number. This number
 ;;; will be your permanent identification number. Any QWIK commands you develop
 ;;; will be stored using this number. If you enter the VShell with an incorrect
 ;;; ID number, you will not have access to your QWIKs.
 ;;;
 ;;; If you enter the VShell from a UCI that contains the VA KERNEL routine ^XUP,
 ;;; your ID will be saved with your DUZ and you won't have to enter it again.
 ;;; If you enter from a UCI that doesn't contain ^XUP, your ID won't be stored
 ;;; and you will need to enter it each time.
 ;;;
 ;;; ** THINGS TO GET USED TO **
 ;;;
 ;;; Different M systems handle the user partition differently. Some systems note
 ;;; the routine that is in the partition, execute your code, and then restore the
 ;;; routine to your partition. Because of this, you cannot ZLoad a routine and
 ;;; call your editor on one line, and then ZSave it on another line. It may no
 ;;; longer be in the partition. When doing things of this nature, all steps must
 ;;; be placed on ONE line of code.
 ;;;
 ;;; Ex: ZL ROUTINE X ^% ZS   <-- All steps on one line of code.
 ;;;
 ;;; You can have similar problems if you try to enter lines of code at the '>>'
 ;;; prompt to make a new routine. A System QWIK called RTN is provided for
 ;;; starting a new routine. See SYSTEM QWIK help text.
 ;;;
 ;;; Any questions you may have concerning VPE may be directed to:
 ;;;       BOLDUC,DAVID@FORUM.VA.GOV
 ;;;***
