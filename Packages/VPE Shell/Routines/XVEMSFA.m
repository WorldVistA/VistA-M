XVEMSFA ;DJB/VSHL**DIU2,DIWE,DIWP,DIWW [04/17/94];2017-08-15  4:48 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
DIU2 ;;;
 ;;; D I U 2     Data Dictionary Deletion
 ;;;
 ;;; 1. ENTRY POINT: EN^DIU2
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;     DIU.....File number or global root. This must be a subfile number when
 ;;;             deleting a subfile's data dictionary.
 ;;;     DIU(0)..D=Delete data as well as data dictionary
 ;;;             E=Echo back info during deletion
 ;;;             S=Subfile data dictionary is to be deleted
 ;;;             T=Templates are to be deleted
 ;;;
 ;;;     Example: S DIU="^DIZ(16000.1,",DIU(0)="" D EN^DIU2
 ;;;              This will delete data dictionary. Data and templates remain.
 ;;;              When deleting the dictionary for a subfile you must include
 ;;;              the S in DIU(0).
 ;;;
 ;;;     NOTE: If your file is in ^DIC(file#, the data will ALWAYS be deleted.
 ;;;***
DIWE ;;;
 ;;; D I W E     Edit Word Processing Text
 ;;;
 ;;; 1. ENTRY POINT: ^DIWE
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC.....Global root.
 ;;;    DWLW....Optional. Maximum number of characters stored on a word
 ;;;            processing node.
 ;;;    DWPK....Optional.
 ;;;            1 = If user enters lines shorter than DWLW, they will not
 ;;;                be joined. If lines are longer than DWLW, they will
 ;;;                be broken at word boundaries.
 ;;;            2 = Lines shorter will be joined til they get to DWLW.
 ;;;                If lines are longer they will broken at word boundaries.
 ;;;***
DIWP ;;;
 ;;; D I W P     Word Processing
 ;;;
 ;;; 1. ENTRY POINT: ^DIWP
 ;;;    Before calling DIWP, kill global ^UTILITY($J,"W"). Then DIWP is invoked
 ;;;    for each text line.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    X.......The string of text to be added as input to the formatter. X may
 ;;;            contain |-windows. The expressions within the windows will be
 ;;;            processed as long as they DO NOT refer to database field names.
 ;;;            Thus, |TODAY| will cause today's date to be inserted into the
 ;;;            formatted text.
 ;;;    DIWL....Left margin.
 ;;;    DIWR....Right margin
 ;;;    DIWF....A string of format control parameters:
 ;;;            W = The formatted text will be written out to the current device,
 ;;;                and will not be stored in ^UTILITY($J,"W").
 ;;;            B = Followed by integer, n. The text will stop printing n lines
 ;;;                from the bottom of the page.
 ;;;            C = Followed by integer, n. Column width. Overrides DIWR.
 ;;;            D = Double spaced.
 ;;;            I = Followed by integer, n. Indent n col from left margin (DIWL).
 ;;;            N = No-wrap. If DIWF contains N, DIWR will be ignored.
 ;;;            R = Right justified.
 ;;;***
DIWW ;;;
 ;;; D I W W     Output Last Line of Text
 ;;;
 ;;; 1. ENTRY POINT: ^DIWW
 ;;;    DIWW must be invoked after the last X string is input to DIWP. It allows
 ;;;    the final line of formatted text to be output.
 ;;;***
