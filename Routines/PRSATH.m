PRSATH ; HISC/FPT-Transmission History ;12/16/92  14:06
 ;;4.0;PAID;;Sep 21, 1995
 ;
 ;  ACKNOW  = Number of messages acknowledged by Austin
 ;  PPIEN   = Pay period internal entry number
 ;  MSGIEN  = MailMan message internal entry number
 ;  TRANS   = Number of messages transmitted to Austin
 ;
 K DIC S DIC="^PRST(458,",DIC(0)="AEMQZ" S PPIEN=$P($G(^PRST(458,0)),U,3) I PPIEN<1 D KILL Q
 S DIC("B")=$P(^PRST(458,PPIEN,0),U,1) D ^DIC K DIC I +Y<1 D KILL Q
 S PPIEN=+Y
 W:$Y>0 @IOF,!!?21,"Transmission History for Pay Period ",$P($P(^PRST(458,PPIEN,0),U),"-",2),!
 S X=$G(^PRST(458,PPIEN,0))
 W !,"Transmitting Clerk: ",?50 S Y=$P(X,"^",2) W $P($G(^VA(200,+Y,0)),U)
 W !,"Transmitting Date/Time: ",?50 S Y=$P(X,"^",3) D DT
 W !!,"Total Number of Employees Transmitted: ",?50,$P(X,"^",4)
 W !,"Total Number of Records Transmitted: ",?50,$P(X,"^",5),!
MSGIEN ; count messages transmitted to and acknowledged by Austin
 S (ACKNOW,MSGIEN,TRANS)=0
 F  S MSGIEN=$O(^PRST(458,PPIEN,"X",MSGIEN)) Q:MSGIEN<1  S TRANS=TRANS+1 D
 .S X=+$O(^XMB(3.9,MSGIEN,1,"C","XXX@Q-TAB.VA.GOV",0)) I X<1!('$D(^XMB(3.9,MSGIEN,1,X,0))) W !,"MESSAGE# ",MSGIEN," NO LONGER EXISTS",*7 Q
 .S:$P(^XMB(3.9,MSGIEN,1,X,0),"^",4)'="" ACKNOW=ACKNOW+1
 W !!,"Total Number of Messages for Transmission: ",?50,TRANS
 W !,"Number of Messages Acknowledged by Austin: ",?50,ACKNOW
 W ! K DIR S DIR(0)="E",DIR("A")="Press RETURN to Continue" D ^DIR
KILL K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,ACKNOW,MSGIEN,PPIEN,TRANS,X,Y Q
 ;
DT ; Date/time converter
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12)
 Q
