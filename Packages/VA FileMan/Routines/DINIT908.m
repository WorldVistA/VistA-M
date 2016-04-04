DINIT908 ;GFT/GFT-DIALOG FILE INITS 
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9118,0)
 ;;=9118^3^y^2
 ;;^UTILITY(U,$J,.84,9118,2,0)
 ;;=^^1^1^2991122^
 ;;^UTILITY(U,$J,.84,9118,2,1,0)
 ;;=ENTER A NUMBER BETWEEN |1| AND |2|, |3| DECIMAL DIGIT(S)
 ;;^UTILITY(U,$J,.84,9118,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,9118,3,1,0)
 ;;=1^LOWEST NUMBER ALLOWED
 ;;^UTILITY(U,$J,.84,9118,3,2,0)
 ;;=2^HIGHEST NUMBER ALLOWED
 ;;^UTILITY(U,$J,.84,9118,3,3,0)
 ;;=3^NUMBER OF DECIMAL PLACES ALLOWED
 ;;^UTILITY(U,$J,.84,9118,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9118,5,1,0)
 ;;=DIALOGZ
 ;;^UTILITY(U,$J,.84,9118.1,0)
 ;;=9118.1^3^y^2
 ;;^UTILITY(U,$J,.84,9118.1,2,0)
 ;;=^^1^1^2991122^^
 ;;^UTILITY(U,$J,.84,9118.1,2,1,0)
 ;;=ENTER A DOLLAR AMOUNT BETWEEN |1| AND |2|, |3| DECIMAL DIGIT(S)
 ;;^UTILITY(U,$J,.84,9118.1,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,9118.1,3,1,0)
 ;;=1^LOWEST NUMBER ALLOWED
 ;;^UTILITY(U,$J,.84,9118.1,3,2,0)
 ;;=2^HIGHEST NUMBER ALLOWED
 ;;^UTILITY(U,$J,.84,9118.1,3,3,0)
 ;;=3^NUMBER OF DECIMAL PLACES ALLOWED
 ;;^UTILITY(U,$J,.84,9118.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9118.1,5,1,0)
 ;;=DIALOGZ
 ;;^UTILITY(U,$J,.84,9119,0)
 ;;=9119^3^y^2
 ;;^UTILITY(U,$J,.84,9119,2,0)
 ;;=^^1^1^2991122^
 ;;^UTILITY(U,$J,.84,9119,2,1,0)
 ;;=ENTER FROM |1| TO |2| CHARACTERS OF FREE TEXT
 ;;^UTILITY(U,$J,.84,9119,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,9119,3,1,0)
 ;;=1^SHORTEST LENGTH
 ;;^UTILITY(U,$J,.84,9119,3,2,0)
 ;;=2^LONGEST LENGTH
 ;;^UTILITY(U,$J,.84,9119,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9119,5,1,0)
 ;;=DIALOGZ
 ;;^UTILITY(U,$J,.84,9119.1,0)
 ;;=9119.1^3^y^2
 ;;^UTILITY(U,$J,.84,9119.1,2,0)
 ;;=^^1^1^2991122^
 ;;^UTILITY(U,$J,.84,9119.1,2,1,0)
 ;;=ENTER A FREE-TEXT ANSWER CONTAINING EXACTLY |1| CHARACTER(S)
 ;;^UTILITY(U,$J,.84,9119.1,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,9119.1,3,1,0)
 ;;=1^LENGTH OF ANSWER
 ;;^UTILITY(U,$J,.84,9119.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9119.1,5,1,0)
 ;;=DIALOGZ
 ;;^UTILITY(U,$J,.84,9121,0)
 ;;=9121^3^y^2
 ;;^UTILITY(U,$J,.84,9121,2,0)
 ;;=^^2^2^2990710^
 ;;^UTILITY(U,$J,.84,9121,2,1,0)
 ;;=At the time the lookup occurs in File |1|, there may be more than 1 entry found.
 ;;^UTILITY(U,$J,.84,9121,2,2,0)
 ;;=Answering 'Y' here means that the user then will be allowed to choose among several entries.
 ;;^UTILITY(U,$J,.84,9121,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,9121,3,1,0)
 ;;=1^file name
 ;;^UTILITY(U,$J,.84,9121,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9121,5,1,0)
 ;;=DIQQQ^DICOMPW
 ;;^UTILITY(U,$J,.84,9131,0)
 ;;=9131^3^^2
 ;;^UTILITY(U,$J,.84,9131,2,0)
 ;;=^^3^3^2990720^^^
 ;;^UTILITY(U,$J,.84,9131,2,1,0)
 ;;=Follow a field name with ';"CAPTION"'
 ;;^UTILITY(U,$J,.84,9131,2,2,0)
 ;;= to have the field asked as 'CAPTION: '
 ;;^UTILITY(U,$J,.84,9131,2,3,0)
 ;;=   or with ';T' to use the field TITLE as caption.
 ;;^UTILITY(U,$J,.84,9131,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9131,5,1,0)
 ;;=DIQQQ^DIA
 ;;^UTILITY(U,$J,.84,9148,0)
 ;;=9148^3^y^2
 ;;^UTILITY(U,$J,.84,9148,1,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,9148,1,1,0)
 ;;=Enter line number
 ;;^UTILITY(U,$J,.84,9148,2,0)
 ;;=^^1^1^2991005^^
 ;;^UTILITY(U,$J,.84,9148,2,1,0)
 ;;=Enter a line number between |1| and |2|.
 ;;^UTILITY(U,$J,.84,9148,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,9148,3,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,.84,9148,3,2,0)
 ;;=2^Highest line number
 ;;^UTILITY(U,$J,.84,9148,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9148,5,1,0)
 ;;=DIWE1^RD
 ;;^UTILITY(U,$J,.84,9149,0)
 ;;=9149^3^^2
 ;;^UTILITY(U,$J,.84,9149,2,0)
 ;;=1^^1^1^2991004^
 ;;^UTILITY(U,$J,.84,9149,2,1,0)
 ;;=Choose, by first letter, a Word Processing command
 ;;^UTILITY(U,$J,.84,9149,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9149,5,1,0)
 ;;=DIWE1^1+5
 ;;^UTILITY(U,$J,.84,9150,0)
 ;;=9150^3^^2
 ;;^UTILITY(U,$J,.84,9150,1,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,9150,1,1,0)
 ;;=Type line number
 ;;^UTILITY(U,$J,.84,9150,2,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,9150,2,1,0)
 ;;=or type a Line Number to edit that line.
 ;;^UTILITY(U,$J,.84,9150,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9150,5,1,0)
 ;;=DIWE1^LC+6
 ;;^UTILITY(U,$J,.84,9151,0)
 ;;=9151^3^^2
 ;;^UTILITY(U,$J,.84,9151,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9151,1,1,0)
 ;;=Add Lines to End of Text
 ;;^UTILITY(U,$J,.84,9151,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9151,2,1,0)
 ;;=Add Lines to End of Text
 ;;^UTILITY(U,$J,.84,9151,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9151,5,1,0)
 ;;=DIWE1^A
 ;;^UTILITY(U,$J,.84,9151.1,0)
 ;;=9151.1^^^2
 ;;^UTILITY(U,$J,.84,9151.1,2,1,0)
 ;;=Add lines
 ;;^UTILITY(U,$J,.84,9152,0)
 ;;=9152^3^^2
 ;;^UTILITY(U,$J,.84,9152,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9152,1,1,0)
 ;;=Break a Line into Two
 ;;^UTILITY(U,$J,.84,9152,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9152,2,1,0)
 ;;=Break a Line into Two
 ;;^UTILITY(U,$J,.84,9152,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9152,5,1,0)
 ;;=DIWE1^B
 ;;^UTILITY(U,$J,.84,9152.1,0)
 ;;=9152.1^^^2
 ;;^UTILITY(U,$J,.84,9152.1,2,1,0)
 ;;=Break line: 
 ;;^UTILITY(U,$J,.84,9153,0)
 ;;=9153^3^^2
 ;;^UTILITY(U,$J,.84,9153,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9153,1,1,0)
 ;;=Change Every String to Another in a Range of Lines
 ;;^UTILITY(U,$J,.84,9153,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9153,2,1,0)
 ;;=Change Every String to Another in a Range of Lines
 ;;^UTILITY(U,$J,.84,9153,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9153,5,1,0)
 ;;=DIWE1^C
 ;;^UTILITY(U,$J,.84,9153.1,0)
 ;;=9153.1^^^2
 ;;^UTILITY(U,$J,.84,9153.1,2,1,0)
 ;;=Change every: 
 ;;^UTILITY(U,$J,.84,9154,0)
 ;;=9154^3^^2
 ;;^UTILITY(U,$J,.84,9154,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9154,1,1,0)
 ;;=Delete Line(s)
 ;;^UTILITY(U,$J,.84,9154,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9154,2,1,0)
 ;;=Delete Line(s)
 ;;^UTILITY(U,$J,.84,9154,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9154,5,1,0)
 ;;=DIWE1^D
 ;;^UTILITY(U,$J,.84,9154.1,0)
 ;;=9154.1^^^2
 ;;^UTILITY(U,$J,.84,9154.1,2,1,0)
 ;;=Delete from line: 
 ;;^UTILITY(U,$J,.84,9155,0)
 ;;=9155^3^^2
 ;;^UTILITY(U,$J,.84,9155,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9155,1,1,0)
 ;;=Edit a Line (Replace __  With __)
 ;;^UTILITY(U,$J,.84,9155,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9155,2,1,0)
 ;;=Edit a Line (Replace __  With __)
 ;;^UTILITY(U,$J,.84,9155,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9155,5,1,0)
 ;;=DIWE1^E
 ;;^UTILITY(U,$J,.84,9155.1,0)
 ;;=9155.1^^^2
 ;;^UTILITY(U,$J,.84,9155.1,2,1,0)
 ;;=Edit line: 
 ;;^UTILITY(U,$J,.84,9157,0)
 ;;=9157^3^^2
 ;;^UTILITY(U,$J,.84,9157,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9157,1,1,0)
 ;;=Get Data from Another Source
 ;;^UTILITY(U,$J,.84,9157,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9157,2,1,0)
 ;;=Get Data from Another Source
 ;;^UTILITY(U,$J,.84,9157,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9157,5,1,0)
 ;;=DIWE1^G
 ;;^UTILITY(U,$J,.84,9157.1,0)
 ;;=9157.1^^^2
 ;;^UTILITY(U,$J,.84,9157.1,2,1,0)
 ;;=Get Data from Another Source 
 ;;^UTILITY(U,$J,.84,9159,0)
 ;;=9159^3^^2
 ;;^UTILITY(U,$J,.84,9159,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9159,1,1,0)
 ;;=Insert Line(s) after an Existing Line
 ;;^UTILITY(U,$J,.84,9159,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9159,2,1,0)
 ;;=Insert Line(s) after an Existing Line
 ;;^UTILITY(U,$J,.84,9159,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9159,5,1,0)
 ;;=DIWE1^I
 ;;^UTILITY(U,$J,.84,9159.1,0)
 ;;=9159.1^^^2
 ;;^UTILITY(U,$J,.84,9159.1,2,1,0)
 ;;=Insert after line: 
 ;;^UTILITY(U,$J,.84,9160,0)
 ;;=9160^3^^2
 ;;^UTILITY(U,$J,.84,9160,1,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9160,1,1,0)
 ;;=Join Line to the One Following
 ;;^UTILITY(U,$J,.84,9160,2,0)
 ;;=^^1^1^2990706^
 ;;^UTILITY(U,$J,.84,9160,2,1,0)
 ;;=Join Line to the One Following
 ;;^UTILITY(U,$J,.84,9160,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9160,5,1,0)
 ;;=DIWE1^J
 ;;^UTILITY(U,$J,.84,9160.1,0)
 ;;=9160.1^^^2
 ;;^UTILITY(U,$J,.84,9160.1,2,1,0)
 ;;=Join line: 
 ;;^UTILITY(U,$J,.84,9162,0)
 ;;=9162^3^^2
 ;;^UTILITY(U,$J,.84,9162,1,0)
 ;;=^^1^1^2990706^
