PRSRAU11 ;HISC/JH=EMPLOYEE AUDIT RECORD REPORT CONT. ;07-SEP-2000
 ;;4.0;PAID;**2,60**;Sep 21, 1995
PRT W:$E(IOST,1,2)="C-" @IOF
 S (DATE(1),NAM)="",TL=0,SW=0,PRSE=" "
 S TL(0)="" F  S TL(0)=$O(^TMP($J,"AUD",TL(0))) Q:TL(0)=""  D:TL'=TL(0) HDR1 D  Q:POUT
 .  S DA(1)=0 F I=0:0 S DA(1)=$O(^TMP($J,"AUD",TL(0),DA(1))) Q:DA(1)'>0  D  Q:POUT
 ..  S DA="" F I=0:0 S DA=$O(^TMP($J,"AUD",TL(0),DA(1),DA)) Q:DA=""  D  Q:POUT
 ...  S CNT=0 F I=0:0 S CNT=$O(^TMP($J,"AUD",TL(0),DA(1),DA,CNT)) Q:CNT'>0  D  Q:POUT
 ....  S DATA=$G(^TMP($J,"AUD",TL(0),DA(1),DA,CNT)),ADATE=$P(DATA,"^"),AUDITOR=$P(DATA,"^",2),TYP=$P(DATA,"^",3),STAT=$P(DATA,"^",4)
 ....  S PCLERK=$P(DATA,"^",5),CDATE=$P(DATA,"^",6),APRV=$P(DATA,"^",7),APRVD=$P(DATA,"^",8),APSUP=$P(DATA,"^",9),APSUPD=$P(DATA,"^",10)
 ....  D:($Y>(IOSL-9)) HDR Q:POUT  F JJ="AUDITOR","PCLERK","APRV","APSUP" D INITALS(.JJ):@JJ'=""
 ....  I DA'=NAM W !,"|",DA D VLIN
 ....  I TYP="T" S RAUDIT=$TR($$FMTE^XLFDT(DA(1),"2FD")," ","0")
 ....  I TYP'="T" D
 .....  N D1,PPI,PPE,PP4Y,DAY
 .....  S D1=DA(1)
 .....  D PP^PRSAPPU
 .....  S RAUDIT="PP "_PPE
 ....  W !,"|",?8,RAUDIT,?22,"|",AUDITOR,?26,"|",ADATE,?35,"|"
 ....  W TYP,?37,"|",STAT,?40,"|",APSUP,?44,"|",APSUPD,?53,"|",APRV,?57,"|",APRVD,?66,"|",PCLERK,?70,"|",CDATE,?79,"|"
 ....  S DATE(1)=DA(1),NAM=DA
 ....  Q
 ...  Q
 ..  Q
 .  I IOSL<66 F I=$Y:1:IOSL-9 D VLIN1
 .  S SW=1 D HDR:'POUT Q
 Q
INITALS(INIT) ;EXTRACT INITALS FROM NAME (Last,First Middle<(optional)) 
 ;PASS BACK (XXX)
 N J S J=$F(@INIT,","),J(1)=$F(@INIT," "),@INIT=$E(@INIT,J)_$S(J(1):$E(@INIT,J(1)),1:"")_$E(@INIT)
 Q
HDR D CODES,VLIDSH1 S CODE="AU01",FOOT="VA TIME & ATTENDANCE SYSTEM" D FOOT2^PRSRUT0
 I $E(IOST)="C" R !,"Press Return/Enter to continue. ",II:DTIME S:'$T!(II="^") POUT=1 Q:POUT
 W @IOF
 D:'SW HDR1 S SW=0 Q
HDR1 W !?23,^TMP($J,"AUD"),?66,"DATE: ",DAT2,!?20,"from PP ",FR," thru PP ",TO,?43," for T&L ",$P(TL(0),"^") D VLIDSH1
 W !,"|",?22,"|"," TIMEKEEPER",?35,"|"," ","|","  ","|"," SUPERVISOR",?53,"|","  APPROVER",?66,"|"," PROCESSOR",?79,"|"
 ;W !,"|",?22,"|","------------","| |  |","------------","|","------------","|","------------","|"
 W !,"|","EMPLOYEE",?22,"|","NAM",?26,"|","  DATE",?35,"|","*",?37,"|","**",?40,"|","NAM",?44,"|","  DATE",?53,"|","NAM",?57,"|","  DATE",?66,"|","NAM",?70,"|","  DATE",?79,"|" D VLIDSH2 Q
VLIDSH1 W !,"|---------------------|------------|-|--|------------|------------|------------|" Q
VLIDSH2 W !,"|---------------------|---|--------|-|--|---|--------|---|--------|---|--------|" Q
VLIN1 W !,"|",?22,"|",?26,"|",?35,"|",?37,"|",?40,"|",?44,"|",?53,"|",?57,"|",?66,"|",?70,"|",?79,"|" Q
VLIN W ?22,"|",?26,"|",?35,"|",?37,"|",?40,"|",?44,"|",?53,"|",?57,"|",?66,"|",?70,"|",?79,"|" Q
CODES ;LIST CODES & DESCRIPTIONS
 S TYPE=";"_$P($G(^DD(458.1101,3,0)),U,3),STATUS=";"_$P($G(^DD(458.1101,4,0)),U,3)
 W !,"| *TYPE:  " F I=1:1 S J=$P(TYPE,";",I+1) Q:J=""  W $P(J,":")_"="_$P(J,":",2),?($X+3)
 W ?79,"|",!,"| **STATUS:  " F I=1:1 S J=$P(STATUS,";",I+1) Q:J=""  W:$P(J,":")="X" ?79,"|",!,"|",?13 W $P(J,":")_"="_$P(J,":",2),?($X+3)
 W ?79,"|" Q
