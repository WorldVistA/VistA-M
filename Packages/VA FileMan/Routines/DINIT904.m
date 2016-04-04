DINIT904 ;GFT/GFT-DIALOG FILE INITS 
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,8116,3,1,0)
 ;;=1^NUMBER OF LINES IN W-P TEXT THAT THE USER IS ABOUT TO DELETE
 ;;^UTILITY(U,$J,.84,8116,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8116,5,1,0)
 ;;=DIWE3^D+4
 ;;^UTILITY(U,$J,.84,8117,0)
 ;;=8117^2^^2
 ;;^UTILITY(U,$J,.84,8117,2,0)
 ;;=1^^1^1^2991008^^
 ;;^UTILITY(U,$J,.84,8117,2,1,0)
 ;;=thru: 
 ;;^UTILITY(U,$J,.84,8117,5,0)
 ;;=^.841^3^3
 ;;^UTILITY(U,$J,.84,8117,5,1,0)
 ;;=DIWE3^D+1
 ;;^UTILITY(U,$J,.84,8117,5,2,0)
 ;;=DIWE1^LIST
 ;;^UTILITY(U,$J,.84,8117,5,3,0)
 ;;=DIWE4^PRINT
 ;;^UTILITY(U,$J,.84,8118,0)
 ;;=8118^2^^2
 ;;^UTILITY(U,$J,.84,8118,2,0)
 ;;=1^^1^1^2991022^
 ;;^UTILITY(U,$J,.84,8118,2,1,0)
 ;;=From line: 
 ;;^UTILITY(U,$J,.84,8118,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8118,5,1,0)
 ;;=DIWE3^F
 ;;^UTILITY(U,$J,.84,8119,0)
 ;;=8119^2^^2
 ;;^UTILITY(U,$J,.84,8119,1,0)
 ;;=^^1^1^2991024^^^
 ;;^UTILITY(U,$J,.84,8119,1,1,0)
 ;;=After line
 ;;^UTILITY(U,$J,.84,8119,2,0)
 ;;=^^1^1^2991024^^
 ;;^UTILITY(U,$J,.84,8119,2,1,0)
 ;;=after line: 
 ;;^UTILITY(U,$J,.84,8119,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8119,5,1,0)
 ;;=DIWE3^MOVE+3
 ;;^UTILITY(U,$J,.84,8120,0)
 ;;=8120^2^^2
 ;;^UTILITY(U,$J,.84,8120,2,0)
 ;;=^^1^1^2990711^
 ;;^UTILITY(U,$J,.84,8120,2,1,0)
 ;;=after character(s):
 ;;^UTILITY(U,$J,.84,8120,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8120,5,1,0)
 ;;=DIWE4^BA
 ;;^UTILITY(U,$J,.84,8121,0)
 ;;=8121^2^^2
 ;;^UTILITY(U,$J,.84,8121,2,0)
 ;;=^^1^1^2991011^^
 ;;^UTILITY(U,$J,.84,8121,2,1,0)
 ;;=<NO CHANGE>
 ;;^UTILITY(U,$J,.84,8121,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8121,5,1,0)
 ;;=DIWE3
 ;;^UTILITY(U,$J,.84,8122,0)
 ;;=8122^2^^2
 ;;^UTILITY(U,$J,.84,8122,2,0)
 ;;=1
 ;;^UTILITY(U,$J,.84,8122,2,1,0)
 ;;=  to: 
 ;;^UTILITY(U,$J,.84,8122,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8122,5,1,0)
 ;;=DIWE2^C+1
 ;;^UTILITY(U,$J,.84,8123,0)
 ;;=8123^2^y^2
 ;;^UTILITY(U,$J,.84,8123,2,0)
 ;;=^^1^1^2991024^^^
 ;;^UTILITY(U,$J,.84,8123,2,1,0)
 ;;=|1| line(s) inserted..
 ;;^UTILITY(U,$J,.84,8123,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8123,3,1,0)
 ;;=1^NUMBER OF LINES INSERTED
 ;;^UTILITY(U,$J,.84,8123,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8123,5,1,0)
 ;;=DIWE2^I+2
 ;;^UTILITY(U,$J,.84,8124,0)
 ;;=8124^2^^2
 ;;^UTILITY(U,$J,.84,8124,1,0)
 ;;=^^4^4^2991022^
 ;;^UTILITY(U,$J,.84,8124,1,1,0)
 ;;=ABDBD
 ;;^UTILITY(U,$J,.84,8124,1,2,0)
 ;;=ASJASJ
 ;;^UTILITY(U,$J,.84,8124,1,3,0)
 ;;=SAS
 ;;^UTILITY(U,$J,.84,8124,1,4,0)
 ;;=AS
 ;;^UTILITY(U,$J,.84,8124,2,0)
 ;;=^^1^1^2991022^^
 ;;^UTILITY(U,$J,.84,8124,2,1,0)
 ;;=OK to change? 
 ;;^UTILITY(U,$J,.84,8124,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8124,5,1,0)
 ;;=DIWE2^C1
 ;;^UTILITY(U,$J,.84,8125,0)
 ;;=8125^2^^2
 ;;^UTILITY(U,$J,.84,8125,2,0)
 ;;=^^1^1^2991022^
 ;;^UTILITY(U,$J,.84,8125,2,1,0)
 ;;=Ask 'OK' for each line found
 ;;^UTILITY(U,$J,.84,8125,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8125,5,1,0)
 ;;=DIWE2^C+2
 ;;^UTILITY(U,$J,.84,8129,0)
 ;;=8129^2^^2
 ;;^UTILITY(U,$J,.84,8129,2,0)
 ;;=^^1^1^2991022^
 ;;^UTILITY(U,$J,.84,8129,2,1,0)
 ;;=CONTROL CHARACTERS REMOVED!!
 ;;^UTILITY(U,$J,.84,8129,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8129,5,1,0)
 ;;=DIWE2^TAB+1
 ;;^UTILITY(U,$J,.84,8130,0)
 ;;=8130^2^^2
 ;;^UTILITY(U,$J,.84,8130,2,0)
 ;;=^^5^5^2991011^
 ;;^UTILITY(U,$J,.84,8130,2,1,0)
 ;;=WARNING!
 ;;^UTILITY(U,$J,.84,8130,2,2,0)
 ;;=The Field you are transferring text from displays text without wrapping.
 ;;^UTILITY(U,$J,.84,8130,2,3,0)
 ;;=The field you are transferring text into may display text differently.
 ;;^UTILITY(U,$J,.84,8130,2,4,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,8130,2,5,0)
 ;;=Do you want to continue?
 ;;^UTILITY(U,$J,.84,8131,0)
 ;;=8131^2^^2
 ;;^UTILITY(U,$J,.84,8131,2,0)
 ;;=^^1^1^2991026^
 ;;^UTILITY(U,$J,.84,8131,2,1,0)
 ;;=From what text: 
 ;;^UTILITY(U,$J,.84,8131,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8131,5,1,0)
 ;;=DIWE3
 ;;^UTILITY(U,$J,.84,8132,0)
 ;;=8132^3^^2^
 ;;^UTILITY(U,$J,.84,8132,1,0)
 ;;=^^1^1^2991026^^
 ;;^UTILITY(U,$J,.84,8132,1,1,0)
 ;;=^S
 ;;^UTILITY(U,$J,.84,8132,2,0)
 ;;=^^1^1^2991026^^^
 ;;^UTILITY(U,$J,.84,8132,2,1,0)
 ;;=Enter the message NUMBER or SUBJECT of another MailMan message, OR
 ;;^UTILITY(U,$J,.84,8132,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8132,5,1,0)
 ;;=DIWE3^Z0+4
 ;;^UTILITY(U,$J,.84,8133,0)
 ;;=8133^3^^2
 ;;^UTILITY(U,$J,.84,8133,2,0)
 ;;=^^1^1^2991026^^
 ;;^UTILITY(U,$J,.84,8133,2,1,0)
 ;;=     Select another entry in this file, or
 ;;^UTILITY(U,$J,.84,8133,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8133,5,1,0)
 ;;=DIWE3
 ;;^UTILITY(U,$J,.84,8134,0)
 ;;=8134^3^^2
 ;;^UTILITY(U,$J,.84,8134,2,0)
 ;;=^^3^3^2991026^^^^
 ;;^UTILITY(U,$J,.84,8134,2,1,0)
 ;;=     Use relational syntax to pick up information from a Word-Processing
 ;;^UTILITY(U,$J,.84,8134,2,2,0)
 ;;=     field in another file.
 ;;^UTILITY(U,$J,.84,8134,2,3,0)
 ;;=     Example: "VALUE":FILE:WORD-PROCESSING FIELD NUMBER
 ;;^UTILITY(U,$J,.84,8134,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8134,5,1,0)
 ;;=DIWE3
 ;;^UTILITY(U,$J,.84,8135,0)
 ;;=8135^2^^2
 ;;^UTILITY(U,$J,.84,8135,2,0)
 ;;=^^1^1^2991026^
 ;;^UTILITY(U,$J,.84,8135,2,1,0)
 ;;=The TEXT TRANSFER has been CANCELLED.
 ;;^UTILITY(U,$J,.84,8135,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8135,5,1,0)
 ;;=DIWE3
 ;;^UTILITY(U,$J,.84,8145,0)
 ;;=8145^1^^2
 ;;^UTILITY(U,$J,.84,8145,2,0)
 ;;=^^2^2^2990710^
 ;;^UTILITY(U,$J,.84,8145,2,1,0)
 ;;=You have asked to sort on the same field twice!
 ;;^UTILITY(U,$J,.84,8145,2,2,0)
 ;;=Please re-enter your SORT criteria.
 ;;^UTILITY(U,$J,.84,8145,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8145,5,1,0)
 ;;=DIQQQ^DIP1
 ;;^UTILITY(U,$J,.84,8146,0)
 ;;=8146^2^y^2
 ;;^UTILITY(U,$J,.84,8146,2,0)
 ;;=^^1^1^2991013^
 ;;^UTILITY(U,$J,.84,8146,2,1,0)
 ;;=uses internal code '|1|'
 ;;^UTILITY(U,$J,.84,8146,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8146,3,1,0)
 ;;=1^INTERNAL VALUE OF A SET-TYPE FIELD
 ;;^UTILITY(U,$J,.84,8146,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8146,5,1,0)
 ;;=DIP12^CK+8
 ;;^UTILITY(U,$J,.84,8147,0)
 ;;=8147^1^^2
 ;;^UTILITY(U,$J,.84,8147,2,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,8147,2,1,0)
 ;;=Captions cannot contain ':' or ';', or begin with a digit or a period.
 ;;^UTILITY(U,$J,.84,8147,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8147,5,1,0)
 ;;=DIQQQ^DIA3
 ;;^UTILITY(U,$J,.84,8148,0)
 ;;=8148^2^^2
 ;;^UTILITY(U,$J,.84,8148,1,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,8148,1,1,0)
 ;;=THERE ARE NO LINES
 ;;^UTILITY(U,$J,.84,8148,2,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,8148,2,1,0)
 ;;=THERE ARE NO LINES!
 ;;^UTILITY(U,$J,.84,8148,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8148,5,1,0)
 ;;=DIWE1^LN+1
 ;;^UTILITY(U,$J,.84,8149,0)
 ;;=8149^2^^2
 ;;^UTILITY(U,$J,.84,8149,1,0)
 ;;=^^1^1^2991027^^^
 ;;^UTILITY(U,$J,.84,8149,1,1,0)
 ;;=EDIT option
 ;;^UTILITY(U,$J,.84,8149,2,0)
 ;;=^^1^1^2991004^^^^
 ;;^UTILITY(U,$J,.84,8149,2,1,0)
 ;;=EDIT Option
 ;;^UTILITY(U,$J,.84,8149,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8149,5,1,0)
 ;;=DIWE1^1
 ;;^UTILITY(U,$J,.84,8150,0)
 ;;=8150^2^^2
 ;;^UTILITY(U,$J,.84,8150,2,0)
 ;;=^^1^1^2990711^^
 ;;^UTILITY(U,$J,.84,8150,2,1,0)
 ;;=Answer with a line number
 ;;^UTILITY(U,$J,.84,8150,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8150,5,1,0)
 ;;=DIWE5^LNQ+1
 ;;^UTILITY(U,$J,.84,8151,0)
 ;;=8151^2^y^2
 ;;^UTILITY(U,$J,.84,8151,2,0)
 ;;=^^1^1^2990711^^
 ;;^UTILITY(U,$J,.84,8151,2,1,0)
 ;;=   or a space to mean the current line (|1|)
 ;;^UTILITY(U,$J,.84,8151,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8151,3,1,0)
 ;;=1^CURRENT LINE NUMBER
 ;;^UTILITY(U,$J,.84,8151,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8151,5,1,0)
 ;;=DIWE5^LNQ+2
 ;;^UTILITY(U,$J,.84,8152,0)
 ;;=8152^2^y^2
 ;;^UTILITY(U,$J,.84,8152,2,0)
 ;;=^^1^1^2990711^^
 ;;^UTILITY(U,$J,.84,8152,2,1,0)
 ;;=   or '-' to mean line |1|
 ;;^UTILITY(U,$J,.84,8152,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8152,3,1,0)
 ;;=1^PREVIOUS LINE NUMBER
 ;;^UTILITY(U,$J,.84,8152,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8152,5,1,0)
 ;;=DIWE5^LNQ+2
 ;;^UTILITY(U,$J,.84,8153,0)
 ;;=8153^2^y^2
