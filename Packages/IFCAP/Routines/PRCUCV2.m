PRCUCV2 ;WISC@ALTOONA/CTB-ESIG CONVERSION ;2/15/93  3:55 PM
V ;;5.0;IFCAP;;4/21/95
SETOFCDS ;display set of codes
 N X,LN,Y
 Q:$P($G(DIR(0)),"^",1)'["S"
 W !,"Select From:",!
 S X=$P(DIR(0),"^",2)
 F LN=1:1 Q:$P(X,";",LN)=""  S Y=$P(X,";",LN) W !?5,$P(Y,":"),?15,$P(Y,":",2)
 QUIT
