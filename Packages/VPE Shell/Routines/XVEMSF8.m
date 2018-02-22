XVEMSF8 ;DJB/VSHL**DIQ,DIQ1 [04/17/94];2017-08-15  4:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
DIQ ;;;
 ;;; D I Q     Data Display, Date Conversion
 ;;;
 ;;; 1. ENTRY POINT: EN^DIQ
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC......The global root or file number.
 ;;;    DA.......Internal entry number of file entry to be printed.
 ;;;    DR.......Literal name of subscript or subscripts to be displayed.
 ;;;             Use ":" for a range. All data fields within and decendent
 ;;;             from the subscript(s) will be displayed. If DR is not defined,
 ;;;             all fields are displayed.
 ;;;     DIQ(0)..C=display computed flds, A=display audit records
 ;;;
 ;;; 1. ENTRY POINT: Y^DIQ
 ;;;    Converts a data element from its internal form to its external form.
 ;;;    When call is made, naked reference must be at ^DD(File#,Fld#,0).
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    Y.......Internal form of value being converted.
 ;;;    C........2nd Piece of ^DD zero node. Following sets C and naked ref:
 ;;;             S C=$P(^DD(file#,fld#,0),U,2) D Y^DIQ
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Y........External form of value.
 ;;;
 ;;; 1. ENTRY POINT: D^DIQ
 ;;;    Converts internal date to external form. Same as DD^%DT.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    Y.......Internal date.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Y.......External form of date/time.
 ;;;
 ;;; 1. ENTRY POINT: DT^DIQ
 ;;;    Converts date in Y exactly like D^DIQ. It also writes the date after
 ;;;    it's been converted. Input and output variables same as D^DIQ.
 ;;;***
DIQ1 ;;;
 ;;; D I Q 1     Data Retrieval
 ;;;
 ;;; 1. ENTRY POINT: EN^DIQ1
 ;;;    KILL ^UTILITY("DIQ1",$J) before and after this call.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC.....Global root or file number.
 ;;;    DR......Field numbers separated by semicolons. Use ":" for range.
 ;;;            S DR=".01;1;10-15"
 ;;;    DA......Internal number of entry.
 ;;;    DIQ.....Local array name where field values will be placed. If undefined
 ;;;            values will be put in ^UTILITY("DIQ1",$J,. Array name should
 ;;;            not begin with DI.
 ;;;    DIQ(0)..Optional. I=Internal value,E=External value,N=Don't return null.
 ;;;
 ;;;    RETRIEVING FROM A SUBFILE
 ;;;    DR(Subfile number) = List of fields in subfile.
 ;;;    DA(Subfile number) = Entry in subfile.
 ;;;    S DIC=16000,DR=".01;2",DA=77,DR(16000.02)=".01;1",DA(16000.02)=1 D EN^DIQ1
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    DIQ AND DIQ(0) UNDEFINED
 ;;;       ^UTILITY("DIQ1",$J,file#,DA,fld#)=external value
 ;;;    DIQ(0) DEFINED, DIQ UNDEFINED
 ;;;       ^UTILITY("DIQ1",$J,file#,DA,fld#,"E")=external value
 ;;;       ^UTILITY("DIQ1",$J,file#,DA,fld#,"I")=internal value
 ;;;    DIQ DEFINED
 ;;;       Output is similar but stored in specified local array.
 ;;;    WORD PROCESSING FIELD
 ;;;       DIQ not defined - ^UTILITY("DIQ1",$J,file#,DA,fld#,1)
 ;;;                         ^UTILITY("DIQ1",$J,file#,DA,fld#,2)
 ;;;       DIQ defined  - Similar but stored in local array.
 ;;;***
