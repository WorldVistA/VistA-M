XVEMGH1 ;DJB/VGL**Help Text - Main Screen [02/05/95];2017-08-15  12:29 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
VGL2 ;;;
 ;;; V G L   E N T R Y   P O I N T S
 ;;;
 ;;;     ^XVEMG    Normal entry point
 ;;;    R^XVEMG    A Fileman subscript has the following pattern:
 ;;;                   Root..Variable..Constant..Variable..Constant..etc
 ;;;                Entry point R^XVEMG will display the variable portion of
 ;;;                the subscript in reverse video.
 ;;;PARAM(var)^XVEMG  Parameter passing.
 ;;;
 ;;; E N T E R                            R  E  S  U  L  T
 ;;; ---------    ----------------------------------------------------------------
 ;;;   'n'        Enter a REF number from the left hand column and the pieces of
 ;;;              the selected node will be displayed vertically. You can then
 ;;;              select a piece and view the data dictionary for the field
 ;;;              this piece represents.
 ;;;
 ;;;              If the node you select is a Xref, the data dictionary for
 ;;;              the field setting the Xref, will be displayed. If the node is
 ;;;              a word processing field, the field will be displayed directly.
 ;;;              If the node is a zero node, information on the contents of a
 ;;;              zero node will be displayed.
 ;;;
 ;;;   <TAB>      As noted above, you select a node by entering it's REF number.
 ;;;              You may also select a node by positioning the highlight located
 ;;;              on the extreme left hand side of the screen, and then hitting
 ;;;              <TAB>.
 ;;;
 ;;;    A         This option allows you to start up an alternate session to
 ;;;              view a 2nd global.
 ;;;
 ;;;    G         Goto a node number. G 1 will return you to the opening screen.
 ;;;              G 1000 (or any high number) will cause the listing to begin with
 ;;;              the highest node that's been displayed.
 ;;;
 ;;; <HOME>,<F4><AL>  Returns you to the opening screen.
 ;;;
 ;;; <END>,<F4><AR>   Causes listing to begin with highest node displayed.
 ;;;
 ;;;   S'n'       Skip over subscipt level 'n'.
 ;;;              Example:  Assume you started the listing with the NEW PERSON
 ;;;              file ^VA(200, and you were now at ^VA(200,4,"FOF",3.05,0). If
 ;;;              you wanted to skip to the next user, you would enter S2. This
 ;;;              means subscript level 2 would skip to the next value. This
 ;;;              would result in ^VA(200,5,0) being displayed.
 ;;;***
