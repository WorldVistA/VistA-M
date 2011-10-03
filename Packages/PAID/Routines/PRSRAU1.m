PRSRAU1 ;HISC/JH-PRIOR PAY PERIOD ADJUSTMENT AUDIT REPORT ;07-SEP-2000
 ;;4.0;PAID;**2,16,19,35,60**;Sep 21, 1995
SUP S PRSTLV=3,PRSR=1
 D TLESEL^PRSRUT0
 G Q1:$G(TLE)=""!(SSN="") G EN1
 ;
FIS S PRSR=2,PRSTLV=3
 D TLESEL^PRSRUT0
 G Q1:TLE=""!(SSN="")
 ;
EN1 W ! S X="T",%DT="" D ^%DT Q:Y<0  S DT=Y K %DT
 ;
ASK ;
 D PPRANGE^PRSAPPU(.FR,.TO,.FR4Y,.TO4Y)
 G Q1:'(FR4Y&TO4Y)
 W !,"This report could take some time, remember to QUEUE the report."
 S ZTRTN="START^PRSRAU1"
 S ZTDESC="PAY PERIOD ADJ. AUDIT REPORT"
 D ST^PRSRUTL,LOOP,QUE1^PRSRUT0 G Q1:POP!($D(ZTSK))
 ;
START ;
 N PPDAY,PP4Y
 S (CNT,POUT)=0
 K ^TMP($J,"AUD")
 S ^TMP($J,"AUD")="PRIOR PAY PERIOD ADJUSTMENT REPORT"
 ;
 ;Function returns 4 dig yr pay per. 2/4 digit yr may be passed.
 ;
 S DA(4)=$$PREP^PRSAPPU(FR) ; get previous pay period
 F  S DA(4)=$O(^PRST(458,"AB",DA(4))) Q:DA(4)=""!(DA(4)]TO4Y)  D
 .  S DA(3)=$O(^PRST(458,"AB",DA(4),0))
 .  S D0=0
 .  F  S D0=$O(^PRST(458,DA(3),"E",D0)) Q:D0'>0  S X=$E($P($G(^PRST(458,DA(3),"E",D0,5)),"^"),22,24) D:$P(TLE(1),"^")=X
 ..    S NAM=$P(^PRSPC(D0,0),"^")
 ..    S DA=0
 ..    F I=0:0 S DA=$O(^PRST(458,DA(3),"E",D0,"X",DA)) Q:DA'>0  D
 ...      S AUDIT=$G(^PRST(458,DA(3),"E",D0,"X",DA,0))
 ...      Q:AUDIT=""
 ...      S TYPE=$P(AUDIT,U,4)
 ...      S RAUDIT=$S(TYPE="T":$P($G(^PRST(458,DA(3),"E",D0,"X",DA,1)),"^"),1:1)
 ...      S RAUDIT=$P($G(^PRST(458,DA(3),1)),"^",RAUDIT)
 ...      S DAUDIT=$P(AUDIT,U,2)
 ...      I DAUDIT'="" S DAUDIT=$E(DAUDIT,4,5)_"/"_$E(DAUDIT,6,7)_"/"_$E(DAUDIT,2,3)
 ...      S AUDITOR=$S($P(AUDIT,U,3)'="":$P(^VA(200,$P(AUDIT,U,3),0),U),1:"")
 ...      S STATUS=$P(AUDIT,U,5)
 ...      S PCLERK=$S($P(AUDIT,U,6)'="":$P($G(^VA(200,$P(AUDIT,U,6),0)),U),1:"")
 ...      S CDATE=$P(AUDIT,U,7)
 ...      I CDATE'="" S CDATE=$E(CDATE,4,5)_"/"_$E(CDATE,6,7)_"/"_$E(CDATE,2,3)
 ...      S APRV=$S($P(AUDIT,U,8)'="":$P(^VA(200,$P(AUDIT,U,8),0),U),1:"")
 ...      S APRVD=$P(AUDIT,U,9)
 ...      I APRVD'="" S APRVD=$E(APRVD,4,5)_"/"_$E(APRVD,6,7)_"/"_$E(APRVD,2,3)
 ...      S APSUP=$S($P(AUDIT,U,10)'="":$P(^VA(200,$P(AUDIT,U,10),0),U),1:"")
 ...      S APSUPD=$P(AUDIT,U,11)
 ...      I APSUPD'="" S APSUPD=$E(APSUPD,4,5)_"/"_$E(APSUPD,6,7)_"/"_$E(APSUPD,2,3)
 ...      S CNT=CNT+1
 ...      S ^TMP($J,"AUD",TLE(1),RAUDIT,NAM,CNT)=DAUDIT_"^"_AUDITOR_"^"_TYPE_"^"_STATUS_"^"_PCLERK_"^"_CDATE_"^"_APRV_"^"_APRVD_"^"_APSUP_"^"_APSUPD
 ...      W:'$D(ZTSK)&($E(IOST)'="P")&($R(30)) "."
 ...  Q
 ..  Q
 .  Q
IND S DAT2=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 U IO I 'CNT S TL(0)=TLE(1) W:$E(IOST,1,2)="C-" @IOF D  G Q1
 .D HDR1^PRSRAU11
 .W !,"|",?10,"No Audit Data on File within this Date Range.",?79,"|"
 .S POUT=1
 .D NONE
 D ^PRSRAU11
Q1 K %,%DT,C,CODE,FOOT,TLE,CNT,D0,DA,DAT2,DTOUT,POP,DIC,EDT,FR,TO,FR4Y,TO4Y,FRP,FRPP,P1,PP,PPE,PRSAI,PRSR,PRSTLV,SEL
 K %Z,APRV,APRVD,APSUP,APSUPD,AUDIT,AUDITOR,CDATE,DATA,DATE,DAUDIT,II,J,JJ,PCLERK,RAUDIT,REC,STATUS
 K I,NAM,POUT,SSN,STAT,SW,TL,TO,TYP,TYPE,USR,X,XX,Y,YY,Z1,ZTDESC,ZTRTN,ZTSAVE,^TMP($J) D ^%ZISC S:$D(ZTSK) ZTREQ="@" K ZTSK D HOME^%ZIS
 Q
NONE F I=$Y:1:IOSL-9 D VLIN1^PRSRAU11
 D HDR^PRSRAU11
 Q
MSG2 W !,*7,"You entered a beginning Pay Period that is greater than the ending Pay Period.",! G ASK
LOOP F X="FR*","TO*","TL*","TLE*","SSN","XX","YY","SW" S ZTSAVE(X)=""
 Q
