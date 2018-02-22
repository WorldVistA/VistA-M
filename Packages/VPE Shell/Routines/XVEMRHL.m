XVEMRHL ;DJB/VRR**Help Text - Rtn Lbry ;2017-08-15  1:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
LIBRARY ;;;Routine Library & Versioning
 ;;; INTRODUCTION
 ;;; ------------
 ;;;
 ;;; VPE's Library & Versioning modules work in concert with the routine
 ;;; editor (..E). They are activated with the ..LBRY System QWIK as follows:
 ;;;
 ;;;     ..LBRY        Displays the Library/Versioning menu.
 ;;;     ..LBRY ON     Activates both modules.
 ;;;     ..LBRY OFF    Inactivates both modules.
 ;;;     ..LBRY ON L   Activates Library only.
 ;;;     ..LBRY ON V   Activates Versioning only.
 ;;;
 ;;; This sets the following nodes:
 ;;;     ^XVV(19200.11,"A-ACTIVE") = "ON/OFF" (Library)
 ;;;     ^XVV(19200.112,"A-ACTIVE")= "ON/OFF" (Version)
 ;;;
 ;;; Note: If Library is active and Versioning inactive and you want to
 ;;;       reverse this, first do ..LBRY OFF to inactivate Library and then
 ;;;       do ..LBRY ON V to activate Versioning.
 ;;;
 ;;; SETUP
 ;;; -----
 ;;;
 ;;; Files used:
 ;;;
 ;;;      VPE PERSON.......^XVV(19200.111)
 ;;;             Name
 ;;;             Identifier
 ;;;             VPE ID
 ;;;             Routine Versioning Prompt
 ;;;
 ;;;      VPE RTN LBRY..............^XVV(19200.11)
 ;;;             Name
 ;;;             Identifier
 ;;;             Date Signed Out
 ;;;             Signed Out By (Pointer to 19200.111)
 ;;;
 ;;;      VPE RTN VERSIONING...^XVV(19200.112)
 ;;;             Routine
 ;;;             Version
 ;;;             Description
 ;;;             Date
 ;;;             Text
 ;;;
 ;;; Move to your production account and restore file VPE_x.PRD. This will load
 ;;; FM Init routines ^XVVMI*. Next, DO ^XVVMINIT to install the files listed
 ;;; above. Edit file VPE PERSON. This file should contain the names of all
 ;;; your programmers. It IS NOT a pointer to the NEW PERSON file. It also
 ;;; contains each person's VPE ID number, which you can find by looking at
 ;;; variable XVV("ID") at the ">>" prompt when you're logged into the VPE
 ;;; programmer shell. For this to work correctly, these files should be
 ;;; translated so they are available in multiple UCI's.
 ;;;
 ;;; R O U T I N E   L I B R A R Y
 ;;; -----------------------------
 ;;;
 ;;; The Library's purpose is to help prevent routines from being accidentily
 ;;; overwritten when there are multiple programmers working on the same routines.
 ;;;
 ;;; The premise is that programmers can 'sign out' routines they will be working
 ;;; on. If another programmer attempts to edit a signed out routine using VPE's
 ;;; routine editor, a message is displayed warning that the routine has been 
 ;;; signed out. The programmer should then check with the person who signed out
 ;;; the routine, before continuing.
 ;;;
 ;;; This IS NOT a database that tracks revisions to routines. It is a database
 ;;; of the names of all routines currently signed out. Once the routines are
 ;;; signed back in, they are dropped from the database.
 ;;;
 ;;; System QWIC ..LBRY is the main menu for signing routines in & out of the
 ;;; Library. The VPE routine editor (..E) also interacts with the Library.
 ;;;
 ;;; Routine Editor (..E):
 ;;;
 ;;;    a. When you enter the editor, you will receive a warning message IF
 ;;;       the routine you are editing has been signed out by someone else.
 ;;;       The same will happen if you BRANCH to another routine.
 ;;;
 ;;;    b. When you leave the editor, IF the routine you were editing hasn't
 ;;;       been signed out and you hit SAVE to save any changes, you will be
 ;;;       asked if you want to sign out the routine.
 ;;;
 ;;; NOTE: The menu option "Sign In Routines" uses VPE's 'Selector' software.
 ;;; You select the routines you want to sign in, by positioning the cursor
 ;;; and hitting <SPACE BAR>. "=>" Will appear next to selected items. Hit
 ;;; <SPACE BAR> again to de-select an item.
 ;;;
 ;;; R O U T I N E   V E R S I O N I N G
 ;;; -----------------------------------
 ;;;
 ;;; As a routine is edited and the changes saved, the versioning module stores
 ;;; the routine's code, by version number. A programmer can, at any time,
 ;;; restore any version of the routine, making it the active version.
 ;;;
 ;;; System QWIK ..LBRY is the main menu for viewing and restoring different
 ;;; versions of a routine. The VPE routine editor (..E) contains the prompts
 ;;; that allow a programmer to create the different versions.
 ;;;
 ;;; Routine Editor (..E):
 ;;;
 ;;;    a. When you leave the editor, if you choose SAVE to save any changes,
 ;;;       you will be asked if you want to store a version of the routine.
 ;;;       You may create a new version or update an existing version.
 ;;;
 ;;;    b. Filling in the DESCRIPTION field will aid you in selecting the
 ;;;       correct routine to restore.
 ;;;***
