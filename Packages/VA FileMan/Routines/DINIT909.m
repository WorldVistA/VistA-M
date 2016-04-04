DINIT909 ;GFT/GFT-DIALOG FILE INITS 
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9162,1,1,0)
 ;;=List a Range of Lines
 ;;^UTILITY(U,$J,.84,9162,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9162,2,1,0)
 ;;=List a Range of Lines
 ;;^UTILITY(U,$J,.84,9162,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9162,5,1,0)
 ;;=DIWE1^L
 ;;^UTILITY(U,$J,.84,9162.1,0)
 ;;=9162.1^^^2
 ;;^UTILITY(U,$J,.84,9162.1,2,1,0)
 ;;=List line: 
 ;;^UTILITY(U,$J,.84,9163,0)
 ;;=9163^3^^2
 ;;^UTILITY(U,$J,.84,9163,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9163,1,1,0)
 ;;=Move Lines to New Location within Text
 ;;^UTILITY(U,$J,.84,9163,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9163,2,1,0)
 ;;=Move Lines to New Location within Text
 ;;^UTILITY(U,$J,.84,9163,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9163,5,1,0)
 ;;=DIWE1^M
 ;;^UTILITY(U,$J,.84,9163.1,0)
 ;;=9163.1^^^2
 ;;^UTILITY(U,$J,.84,9163.1,2,1,0)
 ;;=Move line: 
 ;;^UTILITY(U,$J,.84,9166,0)
 ;;=9166^3^^2
 ;;^UTILITY(U,$J,.84,9166,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9166,1,1,0)
 ;;=Print Lines as Formatted Output
 ;;^UTILITY(U,$J,.84,9166,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9166,2,1,0)
 ;;=Print Lines as Formatted Output
 ;;^UTILITY(U,$J,.84,9166,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9166,5,1,0)
 ;;=DIWE1^P
 ;;^UTILITY(U,$J,.84,9166.1,0)
 ;;=9166.1^^^2
 ;;^UTILITY(U,$J,.84,9166.1,2,1,0)
 ;;=Print from Line: 1//
 ;;^UTILITY(U,$J,.84,9168,0)
 ;;=9168^3^^2
 ;;^UTILITY(U,$J,.84,9168,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9168,1,1,0)
 ;;=Repeat Lines at a New Location
 ;;^UTILITY(U,$J,.84,9168,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9168,2,1,0)
 ;;=Repeat Lines at a New Location
 ;;^UTILITY(U,$J,.84,9168,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9168,5,1,0)
 ;;=DIWE1^R
 ;;^UTILITY(U,$J,.84,9168.1,0)
 ;;=9168.1^^^2
 ;;^UTILITY(U,$J,.84,9168.1,2,1,0)
 ;;=Repeat line: 
 ;;^UTILITY(U,$J,.84,9169,0)
 ;;=9169^3^^2
 ;;^UTILITY(U,$J,.84,9169,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9169,1,1,0)
 ;;=Search for a String
 ;;^UTILITY(U,$J,.84,9169,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9169,2,1,0)
 ;;=Search for a String
 ;;^UTILITY(U,$J,.84,9169,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9169,5,1,0)
 ;;=DIWE1^S
 ;;^UTILITY(U,$J,.84,9169.1,0)
 ;;=9169.1^^^2
 ;;^UTILITY(U,$J,.84,9169.1,2,1,0)
 ;;=Search for: 
 ;;^UTILITY(U,$J,.84,9170,0)
 ;;=9170^3^^2
 ;;^UTILITY(U,$J,.84,9170,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9170,1,1,0)
 ;;=Transfer Lines From Another Document
 ;;^UTILITY(U,$J,.84,9170,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9170,2,1,0)
 ;;=Transfer Lines From Another Document
 ;;^UTILITY(U,$J,.84,9170,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9170,5,1,0)
 ;;=DIWE1^T
 ;;^UTILITY(U,$J,.84,9170.1,0)
 ;;=9170.1^^^2
 ;;^UTILITY(U,$J,.84,9170.1,2,1,0)
 ;;=Transfer incoming text after line: 
 ;;^UTILITY(U,$J,.84,9171,0)
 ;;=9171^3^^2
 ;;^UTILITY(U,$J,.84,9171,1,0)
 ;;=^^1^1^2991026^^
 ;;^UTILITY(U,$J,.84,9171,1,1,0)
 ;;=Utility Sub-Menu
 ;;^UTILITY(U,$J,.84,9171,2,0)
 ;;=^^1^1^2991026^^^^
 ;;^UTILITY(U,$J,.84,9171,2,1,0)
 ;;=Utilities for Word-Processing
 ;;^UTILITY(U,$J,.84,9171,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9171,5,1,0)
 ;;=DIWE1^U
 ;;^UTILITY(U,$J,.84,9171.1,0)
 ;;=9171.1^2^^2
 ;;^UTILITY(U,$J,.84,9171.1,2,0)
 ;;=^^1^1^2991026^
 ;;^UTILITY(U,$J,.84,9171.1,2,1,0)
 ;;=Miscellaneous UTILITIES
 ;;^UTILITY(U,$J,.84,9175,0)
 ;;=9175^3^^2
 ;;^UTILITY(U,$J,.84,9175,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9175,1,1,0)
 ;;=Y-Programmer Edit
 ;;^UTILITY(U,$J,.84,9175,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9175,2,1,0)
 ;;=Y-Programmer Edit
 ;;^UTILITY(U,$J,.84,9175,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9175,5,1,0)
 ;;=DIWE1^Y
 ;;^UTILITY(U,$J,.84,9175.1,0)
 ;;=9175.1^^^2
 ;;^UTILITY(U,$J,.84,9175.1,2,1,0)
 ;;=Y
 ;;^UTILITY(U,$J,.84,9180,0)
 ;;=9180^3^^2
 ;;^UTILITY(U,$J,.84,9180,2,0)
 ;;=^^10^10^2990720^^^^
 ;;^UTILITY(U,$J,.84,9180,2,1,0)
 ;;=You are ready to enter a line of text.
 ;;^UTILITY(U,$J,.84,9180,2,2,0)
 ;;=Type 'CONTROL-I' (or the TAB key) to insert tabs.
 ;;^UTILITY(U,$J,.84,9180,2,3,0)
 ;;=When the text is output, these formatting rules will apply:
 ;;^UTILITY(U,$J,.84,9180,2,4,0)
 ;;= A)  Lines containing only punctuation characters, or lines containing TABs
 ;;^UTILITY(U,$J,.84,9180,2,5,0)
 ;;=     will stand by themselves, i.e., no wrap-around.
 ;;^UTILITY(U,$J,.84,9180,2,6,0)
 ;;= B)  Lines beginning with spaces will start on a new line.
 ;;^UTILITY(U,$J,.84,9180,2,7,0)
 ;;= C)  Expressions between '|' characters will be evaluated as
 ;;^UTILITY(U,$J,.84,9180,2,8,0)
 ;;=     'computed-field' expressions, and then printed as evaluated.
 ;;^UTILITY(U,$J,.84,9180,2,9,0)
 ;;=     Thus, '|NAME|' would cause the current NAME to be inserted in the text.
 ;;^UTILITY(U,$J,.84,9180,2,10,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9180,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9180,5,1,0)
 ;;=DIWE5^IQ
 ;;^UTILITY(U,$J,.84,9181,0)
 ;;=9181^3^^2
 ;;^UTILITY(U,$J,.84,9181,2,0)
 ;;=^^1^1^2990720^^^
 ;;^UTILITY(U,$J,.84,9181,2,1,0)
 ;;=Do you want to see a list of allowable formatting 'WINDOWS'
 ;;^UTILITY(U,$J,.84,9181,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9181,5,1,0)
 ;;=DIWE5^IQ
 ;;^UTILITY(U,$J,.84,9182,0)
 ;;=9182^3^^2
 ;;^UTILITY(U,$J,.84,9182,2,0)
 ;;=^^1^1^2990711^
 ;;^UTILITY(U,$J,.84,9182,2,1,0)
 ;;=SPECIAL FORMATTING INCLUDES:
 ;;^UTILITY(U,$J,.84,9182,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9182,5,1,0)
 ;;=DIWE5^IQ
 ;;^UTILITY(U,$J,.84,9183,0)
 ;;=9183^3^y^2
 ;;^UTILITY(U,$J,.84,9183,2,0)
 ;;=^^4^4^2990906^^
 ;;^UTILITY(U,$J,.84,9183,2,1,0)
 ;;=If you want to use the text from the '|1|' field of another
 ;;^UTILITY(U,$J,.84,9183,2,2,0)
 ;;='|2|' entry< type the name of that entry.
 ;;^UTILITY(U,$J,.84,9183,2,3,0)
 ;;=Otherwise, use a computed expression to designate some 
 ;;^UTILITY(U,$J,.84,9183,2,4,0)
 ;;=Word-Processing text.
 ;;^UTILITY(U,$J,.84,9183,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,9183,3,1,0)
 ;;=1^NAME OF W-P FIELD WE ARE EDITING
 ;;^UTILITY(U,$J,.84,9183,3,2,0)
 ;;=2^NAME OF FILE WE ARE EDITING
 ;;^UTILITY(U,$J,.84,9183,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9183,5,1,0)
 ;;=DIWE5^TQ
 ;;^UTILITY(U,$J,.84,9184,0)
 ;;=9184^2^^2
 ;;^UTILITY(U,$J,.84,9184,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,9184,2,1,0)
 ;;=Text-Terminator
 ;;^UTILITY(U,$J,.84,9184,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9184,5,1,0)
 ;;=DIWE11^TT+2
 ;;^UTILITY(U,$J,.84,9185,0)
 ;;=9185^3^^2
 ;;^UTILITY(U,$J,.84,9185,2,0)
 ;;=^^2^2^2991008^
 ;;^UTILITY(U,$J,.84,9185,2,1,0)
 ;;=Answer must be 1 to 5 characters, containing no question-marks or up-arrows.
 ;;^UTILITY(U,$J,.84,9185,2,2,0)
 ;;=To go back to the Null-String, just type "@".
 ;;^UTILITY(U,$J,.84,9185,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9185,5,1,0)
 ;;=DIWE11
 ;;^UTILITY(U,$J,.84,9186,0)
 ;;=9186^2^^2
 ;;^UTILITY(U,$J,.84,9186,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,9186,2,1,0)
 ;;=The NULL-STRING is now the TEXT-TERMINATOR!
 ;;^UTILITY(U,$J,.84,9186,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9186,5,1,0)
 ;;=DIWE11
 ;;^UTILITY(U,$J,.84,9189,0)
 ;;=9189^2^^2
 ;;^UTILITY(U,$J,.84,9189,2,0)
 ;;=^^1^1^2991027^^
 ;;^UTILITY(U,$J,.84,9189,2,1,0)
 ;;=UTILITY Option
 ;;^UTILITY(U,$J,.84,9189,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9189,5,1,0)
 ;;=DIWE11
 ;;^UTILITY(U,$J,.84,9190,0)
 ;;=9190^2^^2
 ;;^UTILITY(U,$J,.84,9190,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,9190,2,1,0)
 ;;=Editor Change
 ;;^UTILITY(U,$J,.84,9190,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9190,5,1,0)
 ;;=DIWE11
 ;;^UTILITY(U,$J,.84,9191,0)
 ;;=9191^2^^2
 ;;^UTILITY(U,$J,.84,9191,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,9191,2,1,0)
 ;;=File Transfer from Foreign CPU
 ;;^UTILITY(U,$J,.84,9191,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9191,5,1,0)
 ;;=DIWE11
 ;;^UTILITY(U,$J,.84,9192,0)
 ;;=9192^2^^2
 ;;^UTILITY(U,$J,.84,9192,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,9192,2,1,0)
 ;;=Text-Terminator-String change
 ;;^UTILITY(U,$J,.84,9192,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9192,5,1,0)
 ;;=DIWE11
