XVEMGH2 ;DJB/VGL**Help Text - Main Screen [06/08/94];2017-08-15  12:29 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
VGL2 ;;;
 ;;;
 ;;;    C         Enter Mumps code in the form of an IF statement. If True,
 ;;;              the node will be displayed. When you select 'C' you will see
 ;;;              a display of available variables. These variables may be used
 ;;;              in your code.
 ;;;
 ;;;              NOTE: To run this option, DUZ(0) must contain '@'.
 ;;;
 ;;;              Examples:
 ;;;
 ;;;                   I $P(GLVAL,U,2)=5
 ;;;
 ;;;              This will display only those nodes whose 2nd "Piece" equals 5.
 ;;;
 ;;;                   I 1 W !?40,"PIECE 5: ",$P(GLVAL,U,5)
 ;;;
 ;;;              This will display "Piece" 5 on one line and the entire node on
 ;;;              the next, so you can track the changes in value of "Piece" 5.
 ;;;
 ;;;              Some code searches may take a long time depending on the size
 ;;;              of the global being viewed. For this reason, I allow you to
 ;;;              abort a search by hitting any key. The display of all nodes
 ;;;              will resume in the normal fashion.
 ;;;
 ;;;  VEDD        Allows branching to 'Electronic Data Dictionary' to view a file.
 ;;;
 ;;;    ES        Edit a node's subscript. You are not allowed to edit the
 ;;;              subscript of a node that has decendents.
 ;;;
 ;;;    EV        Edit a node's value.
 ;;;
 ;;;    SA        SAves selected nodes which can then be UNsaved later. This
 ;;;              option is used to move code. In conjunction with my routine
 ;;;              editor, you can move code FROM a global TO a routine, FROM a
 ;;;              routine TO a global, or FROM a global TO another global.
 ;;;
 ;;;    UN        UNsave previously SAved code.
 ;;;***
