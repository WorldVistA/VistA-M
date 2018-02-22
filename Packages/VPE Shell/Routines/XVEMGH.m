XVEMGH ;DJB/VGL**Help Text - Global Prompt [06/19/94];2017-08-15  12:29 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
VGL1 ;;;
 ;;; V G L . . . . . . . . Victory Global Lister . . . . . . . . . . David Bolduc
 ;;;
 ;;; NOTE: DUZ(0) must contain either '@' or '#' to run VGL.
 ;;;
 ;;; A)  E N T E R:
 ;;;                A global reference
 ;;;                      -or-
 ;;;          <SPACE>.... to select global using a file name or number
 ;;;          Global*.... to select global from a list
 ;;;               *D.... for a directory list (DSM,DT,MSM)
 ;;;              *%D.... for a library directory list (DSM,DT,MSM)
 ;;;
 ;;;   The global reference may contain variables which must be defined.
 ;;;   Ranges can be specified with a ":" (colon), and multiple arguments
 ;;;   with a " " (space). Ending in a closed paren will prevent the display
 ;;;   from going below the last node specified.
 ;;;
 ;;;   EXAMPLES:
 ;;;
 ;;;       ^DD .................Will list all of ^DD.
 ;;;
 ;;;       ^VA(200 .............Will list all of global ^VA using first level
 ;;;                            subscript 200.
 ;;;
 ;;;       ^DPT(DFN ............Will list all of ^DPT using first level subscript
 ;;;                            equal to variable DFN.
 ;;;
 ;;;       ^%ZIS* ..............List each ^%ZIS node by the first subscript level,
 ;;;                            and allow user to select one for viewing.
 ;;;
 ;;;       ^DIC(4 9.4,1:10,0) ..In ^DIC the first level subscript may be either
 ;;;                            4 or 9.4, the second level subscript must be
 ;;;                            from 1 to 10, and the third level subscript
 ;;;                            must be 0.
 ;;;
 ;;;       ^DPT(,,, ............Will display only those nodes of ^DPT whose
 ;;;                            subscript is 4 levels or lower.
 ;;;
 ;;;       ^DIZ(,500:) .........In ^DIZ, any first level subscript, and second 
 ;;;                            level subscript equal to or greater than 500.
 ;;;
 ;;;       <SPACE>
 ;;;       Select FILE: 4 ......Select global for file 4 [INSTITUTION..^DIC(4,].
 ;;;
 ;;;       ^|"MGR","ROU"|EDI ...List ^EDI global which resides in MGR.
 ;;;***
