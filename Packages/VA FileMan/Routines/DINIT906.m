DINIT906 ;GFT/GFT-DIALOG FILE INITS ;6JUNE2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,8197.2,2,1,0)
 ;;=Changed from "|1|"
 ;;^UTILITY(U,$J,.84,8197.2,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8197.2,3,1,0)
 ;;=1^The former audit-trail value of the field being displayed in CAPTIONED OUTPUT
 ;;^UTILITY(U,$J,.84,8197.2,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8197.2,5,1,0)
 ;;=DIQ^PRINTAUD+6
 ;;^UTILITY(U,$J,.84,8197.3,0)
 ;;=8197.3^2^^2
 ;;^UTILITY(U,$J,.84,8197.3,2,0)
 ;;=^^1^1^2991218^
 ;;^UTILITY(U,$J,.84,8197.3,2,1,0)
 ;;=Created
 ;;^UTILITY(U,$J,.84,8197.3,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8197.3,5,1,0)
 ;;=DIQ^PRINTAUD+6
 ;;^UTILITY(U,$J,.84,8197.4,0)
 ;;=8197.4^2^y^2
 ;;^UTILITY(U,$J,.84,8197.4,2,0)
 ;;=^^1^1^2991218^
 ;;^UTILITY(U,$J,.84,8197.4,2,1,0)
 ;;=|1| on |2| by User #|3|
 ;;^UTILITY(U,$J,.84,8197.4,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,8197.4,3,1,0)
 ;;=1^What happened
 ;;^UTILITY(U,$J,.84,8197.4,3,2,0)
 ;;=2^DATE/TIME
 ;;^UTILITY(U,$J,.84,8197.4,3,3,0)
 ;;=3^USER NUMBER
 ;;^UTILITY(U,$J,.84,8197.4,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8197.4,5,1,0)
 ;;=DIQ^PRINTAUD+6
 ;;^UTILITY(U,$J,.84,8197.5,0)
 ;;=8197.5^2^^2
 ;;^UTILITY(U,$J,.84,8197.5,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,8197.5,2,1,0)
 ;;=Accessed
 ;;^UTILITY(U,$J,.84,8197.5,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8197.5,5,1,0)
 ;;=DIQ^PRINTAUD+7
 ;;^UTILITY(U,$J,.84,8198,0)
 ;;=8198^2^^2
 ;;^UTILITY(U,$J,.84,8198,2,0)
 ;;=^^1^1^2990828^^
 ;;^UTILITY(U,$J,.84,8198,2,1,0)
 ;;=Standard Captioned Output
 ;;^UTILITY(U,$J,.84,8198,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8198,5,1,0)
 ;;=DII^R
 ;;^UTILITY(U,$J,.84,8199,0)
 ;;=8199^2^^2
 ;;^UTILITY(U,$J,.84,8199,1,0)
 ;;=^^1^1^2990824^
 ;;^UTILITY(U,$J,.84,8199,1,1,0)
 ;;=ANOTHER ONE: in inquiry
 ;;^UTILITY(U,$J,.84,8199,2,0)
 ;;=^^1^1^2990824^
 ;;^UTILITY(U,$J,.84,8199,2,1,0)
 ;;=Another one:
 ;;^UTILITY(U,$J,.84,8201,0)
 ;;=8201^2^y^2
 ;;^UTILITY(U,$J,.84,8201,2,0)
 ;;=^^1^1^2990831^^^
 ;;^UTILITY(U,$J,.84,8201,2,1,0)
 ;;=By '|1|', do you mean |2| '|3|'
 ;;^UTILITY(U,$J,.84,8201,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,8201,3,1,0)
 ;;=1^What user input as a COMPUTED EXPRESSION element
 ;;^UTILITY(U,$J,.84,8201,3,2,0)
 ;;=2^File
 ;;^UTILITY(U,$J,.84,8201,3,3,0)
 ;;=3^Field
 ;;^UTILITY(U,$J,.84,8201,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8201,5,1,0)
 ;;=DICOMP0^A+1
 ;;^UTILITY(U,$J,.84,8202,0)
 ;;=8202^2^y^2
 ;;^UTILITY(U,$J,.84,8202,2,0)
 ;;=^^1^1^2990831^^^^
 ;;^UTILITY(U,$J,.84,8202,2,1,0)
 ;;=By '|1|', do you mean the |2| File, pointing via its '|3|' field
 ;;^UTILITY(U,$J,.84,8202,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,8202,3,1,0)
 ;;=1^What user entered as BACKWARDS POINTER
 ;;^UTILITY(U,$J,.84,8202,3,2,0)
 ;;=2^File name
 ;;^UTILITY(U,$J,.84,8202,3,3,0)
 ;;=3^Name of POINTER field
 ;;^UTILITY(U,$J,.84,8202,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8202,5,1,0)
 ;;=DICOMPV
 ;;^UTILITY(U,$J,.84,8203,0)
 ;;=8203^2^y^2
 ;;^UTILITY(U,$J,.84,8203,2,0)
 ;;=^^1^1^2990831^^
 ;;^UTILITY(U,$J,.84,8203,2,1,0)
 ;;=Will terminal user be allowed to select proper entry in |1| File
 ;;^UTILITY(U,$J,.84,8203,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8203,3,1,0)
 ;;=1^Name of File that computed expression is navigating to.
 ;;^UTILITY(U,$J,.84,8203,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8203,5,1,0)
 ;;=DICOMPW^ASKE+1
 ;;^UTILITY(U,$J,.84,8204,0)
 ;;=8204^2^y^2
 ;;^UTILITY(U,$J,.84,8204,2,0)
 ;;=^^1^1^2990831^
 ;;^UTILITY(U,$J,.84,8204,2,1,0)
 ;;=Do you want to permit adding a new '|1|' entry
 ;;^UTILITY(U,$J,.84,8204,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8204,3,1,0)
 ;;=1^Name of File
 ;;^UTILITY(U,$J,.84,8204,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8204,5,1,0)
 ;;=DICOMPW^ASK1
 ;;^UTILITY(U,$J,.84,8205,0)
 ;;=8205^2^^2
 ;;^UTILITY(U,$J,.84,8205,2,0)
 ;;=^^1^1^2990831^
 ;;^UTILITY(U,$J,.84,8205,2,1,0)
 ;;=Well then, do you want to FORCE adding a new entry every time
 ;;^UTILITY(U,$J,.84,8205,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8205,5,1,0)
 ;;=DICOMPW^ASK2
 ;;^UTILITY(U,$J,.84,8206,0)
 ;;=8206^2^y^2
 ;;^UTILITY(U,$J,.84,8206,2,0)
 ;;=^^1^1^2990831^
 ;;^UTILITY(U,$J,.84,8206,2,1,0)
 ;;=Do you want an 'ADDING A NEW |1|' message
 ;;^UTILITY(U,$J,.84,8206,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8206,3,1,0)
 ;;=1^Name of File
 ;;^UTILITY(U,$J,.84,8206,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8206,5,1,0)
 ;;=DICOMPW^ASK3
 ;;^UTILITY(U,$J,.84,8300,0)
 ;;=8300^2^y^2
 ;;^UTILITY(U,$J,.84,8300,2,0)
 ;;=^^1^1^2991011^^
 ;;^UTILITY(U,$J,.84,8300,2,1,0)
 ;;=  (|1| entries)
 ;;^UTILITY(U,$J,.84,8300,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8300,3,1,0)
 ;;=1^NUMBER OF ENTRIES
 ;;^UTILITY(U,$J,.84,8300,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8300,5,1,0)
 ;;=DICRW
 ;;^UTILITY(U,$J,.84,8301,0)
 ;;=8301^2^^2
 ;;^UTILITY(U,$J,.84,8301,2,0)
 ;;=^^1^1^2991011^^
 ;;^UTILITY(U,$J,.84,8301,2,1,0)
 ;;=  (1 entry)
 ;;^UTILITY(U,$J,.84,8301,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8301,5,1,0)
 ;;=DICRW
 ;;^UTILITY(U,$J,.84,9070,0)
 ;;=9070^3^^2
 ;;^UTILITY(U,$J,.84,9070,1,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,9070,1,1,0)
 ;;=Type '-' in front of numeric-valued field name to sort from high to low.
 ;;^UTILITY(U,$J,.84,9070,2,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,9070,2,1,0)
 ;;=Type '-' in front of numeric-valued field name to sort from high to low.
 ;;^UTILITY(U,$J,.84,9070,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9070,5,1,0)
 ;;=DIQQ^DIP+1
 ;;^UTILITY(U,$J,.84,9071,0)
 ;;=9071^3^^2
 ;;^UTILITY(U,$J,.84,9071,2,0)
 ;;=^^4^4^2991026^^^^
 ;;^UTILITY(U,$J,.84,9071,2,1,0)
 ;;=Type '+' in front of field name to get SUBTOTALS by that field's values.
 ;;^UTILITY(U,$J,.84,9071,2,2,0)
 ;;=     '#' to PAGE-FEED on each field value,  '!' to get RANKING NUMBER
 ;;^UTILITY(U,$J,.84,9071,2,3,0)
 ;;=     '@' to SUPPRESS SUB-HEADER,            ']' to force SAVING TEMPLATE
 ;;^UTILITY(U,$J,.84,9071,2,4,0)
 ;;=Type ';TXT' after free-text fields to SORT NUMBERS AS TEXT
 ;;^UTILITY(U,$J,.84,9071,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9071,5,1,0)
 ;;=DIQQ^DIP
 ;;^UTILITY(U,$J,.84,9072,0)
 ;;=9072^3^^2
 ;;^UTILITY(U,$J,.84,9072,2,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,9072,2,1,0)
 ;;=Type [TEMPLATE NAME] in brackets to SORT BY PREVIOUS SEARCH RESULTS
 ;;^UTILITY(U,$J,.84,9072,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9072,5,1,0)
 ;;=DIQQ^DIP+7
 ;;^UTILITY(U,$J,.84,9073,0)
 ;;=9073^3^^2
 ;;^UTILITY(U,$J,.84,9073,2,0)
 ;;=^^1^1^2990720^
 ;;^UTILITY(U,$J,.84,9073,2,1,0)
 ;;=Type 'BY(0)' to define record selection and sort order
 ;;^UTILITY(U,$J,.84,9075,0)
 ;;=9075^3^^2
 ;;^UTILITY(U,$J,.84,9075,2,0)
 ;;=^^2^2^2990710^^
 ;;^UTILITY(U,$J,.84,9075,2,1,0)
 ;;=You can NEGATE any of these conditions by preceding them with "'" or "-".
 ;;^UTILITY(U,$J,.84,9075,2,2,0)
 ;;=Thus,  "'NULL"  means  "NOT NULL".
 ;;^UTILITY(U,$J,.84,9075,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9075,5,1,0)
 ;;=DIQQQ^DISC
 ;;^UTILITY(U,$J,.84,9076,0)
 ;;=9076^3^^2
 ;;^UTILITY(U,$J,.84,9076,2,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,9076,2,1,0)
 ;;=Enter "ALL" to print every field.
 ;;^UTILITY(U,$J,.84,9076,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9076,5,1,0)
 ;;=DIQQ^DIP2+6
 ;;^UTILITY(U,$J,.84,9077,0)
 ;;=9077^3^^2
 ;;^UTILITY(U,$J,.84,9077,2,0)
 ;;=^^4^4^2990711^^
 ;;^UTILITY(U,$J,.84,9077,2,1,0)
 ;;=Type '&' in front of field name to get TOTAL for that field.
 ;;^UTILITY(U,$J,.84,9077,2,2,0)
 ;;=     '!' to get COUNT.   '+' to get TOTAL & COUNT.    '#' to get MAX & MIN.
 ;;^UTILITY(U,$J,.84,9077,2,3,0)
 ;;=     ']' to force SAVING PRINT TEMPLATE
 ;;^UTILITY(U,$J,.84,9077,2,4,0)
 ;;=You can follow field name with ';' and FORMAT SPECIFICATION.
 ;;^UTILITY(U,$J,.84,9077,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9077,5,1,0)
 ;;=DIQQ^DIP2
 ;;^UTILITY(U,$J,.84,9078,0)
 ;;=9078^3^^2
 ;;^UTILITY(U,$J,.84,9078,2,0)
 ;;=^^1^1^2990710^^
 ;;^UTILITY(U,$J,.84,9078,2,1,0)
 ;;=Type '[TEMPLATE NAME]' in brackets to use an existing PRINT TEMPLATE.
 ;;^UTILITY(U,$J,.84,9078,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9078,5,1,0)
 ;;=DIQQ^DIP2
 ;;^UTILITY(U,$J,.84,9079,0)
 ;;=9079^3^y^2
 ;;^UTILITY(U,$J,.84,9079,2,0)
 ;;=^^3^3^2990710^
 ;;^UTILITY(U,$J,.84,9079,2,1,0)
 ;;=Enter a value which '|1|'
 ;;^UTILITY(U,$J,.84,9079,2,2,0)
 ;;=must |2|, in order for truth condition
