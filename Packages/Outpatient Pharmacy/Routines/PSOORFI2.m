PSOORFI2 ;BIR/BHW-finish cprs orders cont. ;07/29/96
 ;;7.0;OUTPATIENT PHARMACY;**7,15,23,27,46,130,146,177,222,225,338**;DEC 1997;Build 3
 ;External reference ^YSCL(603.01 supported by DBIA 2697
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
HLP W !,"Enter 'S' to process orders with a priority of STAT",!,"      'E' to process orders with an Emergency priority,",!,"      'R' to process Routine orders.",! Q
HELP ;
 W !,"Please enter a minimum of two (2) characters.",!,"Enter Patient's name whose med orders are to be completed.",!
 S (PATN,DPT)=0 F  S DPT=$O(^PS(52.41,"AOR",DPT)) Q:'DPT  I $D(^PS(52.41,"AOR",DPT,PSOPINST)) W !,$P(^DPT(DPT,0),"^") S PATN=PATN+1 I PATN=20 D  I $D(DUOUT)!($D(DTOUT)) G HELPX
 .K DIR,DUOUT,DTOUT,DIRUT S DIR(0)="E" D ^DIR S PATN=0 K DIR
HELPX K DTOUT,DUOUT,DIRUT,PAINST S DIR(0)="FO^2:30",DIR("A")="Select Patient",DIR("?")="^D HELP^PSOORFIN"
 K PATN,DPT Q
RTE ;
 S PSZFIN=1
 F PSZFZZ=0:0 S PSZFZZ=$O(^PS(52.41,"AC",PAT,$E(PSRT),PSZFZZ)) Q:'PSZFZZ!('PSZFIN)  D
 .I $P($G(^PS(52.41,PSZFZZ,0)),"^",3)="NW"!($P($G(^(0)),"^",3)="RNW")!($P($G(^(0)),"^",3)="RF") I $P($G(^PS(52.41,PSZFZZ,"INI")),"^")=$G(PSOPINST) S PSZFIN=0
 Q
PRI ;
 S PSZFIN=1
 F PSZFZZ=0:0 S PSZFZZ=$O(^PS(52.41,"AP",PAT,$E(PSRT),PSZFZZ)) Q:'PSZFZZ!('PSZFIN)  D
 .I $P($G(^PS(52.41,PSZFZZ,0)),"^",3)="NW"!($P($G(^(0)),"^",3)="RNW")!($P($G(^(0)),"^",3)="RF") I $P($G(^PS(52.41,PSZFZZ,"INI")),"^")=$G(PSOPINST) S PSZFIN=0
 Q
PROFILE ;display med profile
 S MEDA=3 ;3=question asked already
 W !!! K MEDP,DIR,DUOUT,DIRUT,DTOUT S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Do you want to see Medication Profile" D ^DIR K DIR Q:$D(DIRUT)!('Y)
 I Y S MEDP=1
 K DIR,DUOUT,DIRUT,DTOUT
 Q
DC I '$G(PSOORRNW),$G(PSOOPT)=3 S PSORENW("DFLG")=1 S:'$D(PSOBBC1("FROM")) VALMBCK="Q",VALMSG="Renew Rx Request Canceled.",Y=-1 Q
 G DC^PSOORFI6
 Q
DE Q:'$D(^PS(52.41,ORD,0))
 K ^PS(52.41,"AOR",$P(^PS(52.41,ORD,0),"^",2),+$P($G(^PS(52.41,ORD,"INI")),"^"),ORD),^PS(52.41,"AD",$P(^PS(52.41,ORD,0),"^",12),+$P($G(^PS(52.41,ORD,"INI")),"^"),ORD)
 S $P(^PS(52.41,ORD,0),"^",3)="DC",POERR("PLACER")=$P(^(0),"^"),POERR("STAT")="OC"
 S POERR("COMM")=$S($G(POERR("DEAD")):"Patient died on "_$G(PSOPTPST(2,PSODFN,.351))_".",1:ACOM),$P(^PS(52.41,ORD,4),"^")=POERR("COMM")
 D EN^PSOHLSN(POERR("PLACER"),POERR("STAT"),POERR("COMM"),PSONOOR)
 I '$G(POERR("DEAD")) S DIR("A")="Press Return to Continue" D PAUSE^VALM1
 K PSONOOR,PDORUG,ACOM,CMOP,DEA,DEF,DREN,FDR,HDR,PHI,PRC,SIGOK,DIR,DTOUT,DUOUT,DIRUT
 S Y=-1 Q
 ;
RF ;process refill request from CPRS
 S PSOREF("IRXN")=$P(OR0,"^",19) D PSOL^PSSLOCK($P(OR0,"^",19)) I '$G(PSOMSG) D  D PAUSE^VALM1 K PSOREF,PSOMSG Q
 .I $P($G(PSOMSG),"^",2)'="" W $C(7),!!,$P(PSOMSG,"^",2),! Q
 .W $C(7),!!,"Another person is editing Rx "_$P(^PSRX($P(OR0,"^",19),0),"^"),!
 ;
 D FULL^VALM1
 I '$P($G(^PS(52.41,ORD,0)),"^",23),+$G(^PS(52.41,ORD,"FLG")) D  I $D(DIRUT)!'Y S VALMBCK="B" Q
 . K DIRUT,DUOUT,DTOUT,DIR
 . S DIR("A",1)="Flagged by "_$$GET1^DIQ(52.41,ORD,34)_" on "_$$GET1^DIQ(52.41,ORD,33)_": "_$$GET1^DIQ(52.41,ORD,35)
 . S DIR("A",2)=""
 . S DIR("A",3)="Unflagged by "_$$GET1^DIQ(52.41,ORD,37)_" on "_$$GET1^DIQ(52.41,ORD,36)_": "_$$GET1^DIQ(52.41,ORD,38)
 . S DIR("A",4)=""
 . S DIR(0)="Y",DIR("B")="YES",DIR("A")="Continue"
 . W ! D ^DIR
 ;
 I $G(ORD),+$P($G(^PS(52.41,+ORD,0)),"^",23)=1 D  Q:$D(DIRUT)!'Y  D EN1^ORCFLAG(+$P($G(^PS(52.41,ORD,0)),"^")) H 1
 . K DIRUT,DUOUT,DTOUT,DIR
 . S DIR("A",1)="This Refill Request is flagged. In order to process it"
 . S DIR("A",2)="you must unflag it first."
 . S DIR("A",3)=""
 . S DIR(0)="Y",DIR("A")="Unflag Refill Request",DIR("B")="NO"
 . W ! D ^DIR I $D(DIRUT)!'Y S VALMBCK="B"
 I $G(ORD),+$P($G(^PS(52.41,+ORD,0)),"^",23)=1 Q
 ;
 K PSOMSG S (PSOREF("DFLG"),PSOREF("FIELD"),PSOREF1)=0,X="T-6M",%DT="X" D ^%DT
 S (PSOID,PSOREF("ISSUE DATE"))=$S($P(^PSRX(PSOREF("IRXN"),0),"^",13)<Y:Y,1:$P(^PSRX(PSOREF("IRXN"),0),"^",13))
 S:$G(PSORX("BAR CODE"))&($G(PSOBBC1("FROM"))="NEW") PSOREF("ISSUE DATE")=DT K X,X1,X2
 ;
 S PSONEW("DAYS SUPPLY")=$P(^PSRX(PSOREF("IRXN"),0),"^",8),PSONEW("# OF REFILLS")=$P(^(0),"^",9)
 W !!,"Processing Refill Request for Rx "_$P(^PSRX(PSOREF("IRXN"),0),"^")
 D FILLDT^PSODIR2(.PSOREF) I PSOREF("DFLG") S VALMBCK="R" G END
 ;
 S PSORX("MAIL/WINDOW")=$S($P(OR0,"^",17)="M":"MAIL",1:"WINDOW") D MW^PSODIR2(.PSOREF) I PSOREF("DFLG") S VALMBCK="R" G END
 S:'$G(PSOFROM)'="NEW" PSOFROM="REFILL" S PSOREF("DFLG")=0
 D ^PSOREF0
END D PSOUL^PSSLOCK(PSOREF("IRXN")) K PSOREF,NODE,PSOREF1,PSL,PSOERR,PSORX("QFLG")
 Q
S D KPRI,KPRIZ F  S ORD=$O(^PS(52.41,"AP",PAT,"S",ORD)) Q:'ORD!($G(POERR("QFLG")))  I $P(^PS(52.41,ORD,0),"^",3)'="DC",$P(^(0),"^",3)'="DE" D LOCK1^PSOORFI1,ORD^PSOORFIN S PSOSTATZ=1
 D:$G(POERR("QFLG")) KPRI Q:$G(POERR("QFLG"))  I $G(PSOSTATZ) S ORD=0 D
 .D KPRIZ F  S ORD=$O(^PS(52.41,"AP",PAT,"E",ORD)) Q:'ORD!($G(POERR("QFLG")))  I $P(^PS(52.41,ORD,0),"^",3)'="DC",$P(^(0),"^",3)'="DE" D LOCK1^PSOORFI1,ORD^PSOORFIN
 .Q:$G(POERR("QFLG"))
 .D KPRIZ S ORD=0 F  S ORD=$O(^PS(52.41,"AP",PAT,"R",ORD)) Q:'ORD!($G(POERR("QFLG")))  I $P(^PS(52.41,ORD,0),"^",3)'="DC",$P(^(0),"^",3)'="DE" D LOCK1^PSOORFI1,ORD^PSOORFIN
 D KPRI
 Q
E D KPRI,KPRIZ F  S ORD=$O(^PS(52.41,"AP",PAT,"E",ORD)) Q:'ORD!($G(POERR("QFLG")))  I $P(^PS(52.41,ORD,0),"^",3)'="DC",$P(^(0),"^",3)'="DE" D LOCK1^PSOORFI1,ORD^PSOORFIN S PSOEMERZ=1
 D:$G(POERR("QFLG")) KPRI Q:$G(POERR("QFLG"))  I $G(PSOEMERZ) S ORD=0 D
 .D KPRIZ F  S ORD=$O(^PS(52.41,"AP",PAT,"S",ORD)) Q:'ORD!($G(POERR("QFLG")))  I $P(^PS(52.41,ORD,0),"^",3)'="DC",$P(^(0),"^",3)'="DE" D LOCK1^PSOORFI1,ORD^PSOORFIN
 .Q:$G(POERR("QFLG"))
 .D KPRIZ S ORD=0 F  S ORD=$O(^PS(52.41,"AP",PAT,"R",ORD)) Q:'ORD!($G(POERR("QFLG")))  I $P(^PS(52.41,ORD,0),"^",3)'="DC",$P(^(0),"^",3)'="DE" D LOCK1^PSOORFI1,ORD^PSOORFIN
 D KPRI
 Q
R D KPRI,KPRIZ F  S ORD=$O(^PS(52.41,"AP",PAT,"R",ORD)) Q:'ORD!($G(POERR("QFLG")))  I $P(^PS(52.41,ORD,0),"^",3)'="DC",$P(^(0),"^",3)'="DE" D LOCK1^PSOORFI1,ORD^PSOORFIN S PSOROUTZ=1
 D:$G(POERR("QFLG")) KPRI Q:$G(POERR("QFLG"))  I $G(PSOROUTZ) S ORD=0 D
 .D KPRIZ F  S ORD=$O(^PS(52.41,"AP",PAT,"E",ORD)) Q:'ORD!($G(POERR("QFLG")))  I $P(^PS(52.41,ORD,0),"^",3)'="DC",$P(^(0),"^",3)'="DE" D LOCK1^PSOORFI1,ORD^PSOORFIN
 .Q:$G(POERR("QFLG"))
 .D KPRIZ S ORD=0 F  S ORD=$O(^PS(52.41,"AP",PAT,"S",ORD)) Q:'ORD!($G(POERR("QFLG")))  I $P(^PS(52.41,ORD,0),"^",3)'="DC",$P(^(0),"^",3)'="DE" D LOCK1^PSOORFI1,ORD^PSOORFIN
 D KPRI
 Q
KPRI K PSOSTATZ,PSOROUTZ,PSOEMERZ
 Q
KPRIZ K PSOQUIT,POERR("QFLG")
 Q
INST ;Select Institution
 N PSOCNT
 I '$G(PSOSITE) D ^PSOLSET I '$G(PSOSITE) S PSOIQUIT=1 Q
 N PSIR,PSCT,PSINST K PSOPINST
 S PSCT=0 F PSIR=0:0 S PSIR=$O(^PS(59,PSOSITE,"INI1",PSIR)) Q:'PSIR  I $P($G(^PS(59,PSOSITE,"INI1",PSIR,0)),"^") S PSCT=PSCT+1 I PSCT=1 S PSOPINST=$P($G(^(0)),"^")
 I PSCT=0 W !!,"There are no CPRS Ordering Institutions associated with this Outpatient site!",!,"Use the Site Parameter enter/edit option to enter CPRS Ordering Institutions!",! S PSOIQUIT=1 Q
 I PSCT=1 D INSTNM G INSTA
 W !!!,"There are multiple Institutions associated with this Outpatient Site for",!,"finishing orders entered through CPRS. Select the Institution for which to",!,"finish orders from.  Enter '?' to see all choices.",!
 K PSOPNAME D:$G(PSOPINST)  K DIC S DIC(0)="AEQMZ",DIC="^PS(59,"_PSOSITE_",""INI1""," S:$G(PSOPNAME)'="" DIC("B")=$G(PSOPNAME) D ^DIC K DIC,PSOPNAME I Y<1 W !!,"No Institution selected",! S PSOIQUIT=1 Q
 .K ^UTILITY("DIQ1",$J),DIQ S DA=$G(PSOPINST),DIC=4,DIQ(0)="E",DR=".01" D EN^DIQ1 S PSOPNAME=$G(^UTILITY("DIQ1",$J,4,DA,.01,"E")) K ^UTILITY("DIQ1",$J),DA,DR,DIC,DIQ
 W ! S PSOPINST=$P(Y,"^",2) K Y
 D INSTNM W !,"You have selected "_$G(PSODINST)_"."
 W !,"After completing these orders, you may re-enter this option and select again."
INSTA S PSOCNT=$$CNT(PSOPINST)
 I '$D(IOINORM)!('$D(IOINHI)) S X="IORVOFF;IORVON;IOINHI;IOINORM" D ENDR^%ZISS
 W !!?7,IORVON_IOINHI,"<There ",$S(PSOCNT=1:"is ",1:"are "),$S(PSOCNT>0:PSOCNT,1:"no")," flagged order",$S(PSOCNT=1:"",1:"s")," for ",PSODINST,">",IOINORM_IORVOFF,!
 K PSODINST
 Q
 ;
CNT(SITE)  ; - Counter for flagged pending orders by Site
 N CNT,ORD
 K ^TMP($J,"PSOFLPO")
 S (CNT,LOGIN,ORD)=0
 F  S LOGIN=$O(^PS(52.41,"AD",LOGIN)) Q:'LOGIN  D
 . F  S ORD=$O(^PS(52.41,"AD",LOGIN,SITE,ORD)) Q:'ORD  D
 . . I $P(^PS(52.41,ORD,0),"^",3)="DC"!($P(^PS(52.41,ORD,0),"^",3)="DE") Q
 . . I $P($G(^PS(52.41,ORD,0)),"^",23) S CNT=CNT+1 S:$P(^(0),"^",2) ^TMP($J,"PSOFLPO",$P(^(0),"^",2))=""
 Q CNT
 ;
INST1 ;
 K PSOPINST N PSIR
 F PSIR=0:0 S PSIR=$O(^PS(59,PSOSITE,"INI1",PSIR)) Q:'PSIR!($G(PSOPINST))  I $P($G(^PS(59,PSOSITE,"INI1",PSIR,0)),"^") S PSOPINST=$P($G(^(0)),"^")
 Q
CLOZ ;checks clozapine status of patient 
 S CLOZPAT=$O(^YSCL(603.01,"C",PSODFN,0))
 S CLOZPAT=$P($G(^YSCL(603.01,+CLOZPAT,0)),"^",3)
 S CLOZPAT=$S(CLOZPAT="M":2,CLOZPAT="B":1,1:0)
 S:'$D(PSONEW("# OF REFILLS")) (PSONEW("# OF REFILLS"),PSONEW("N# REF"))=0
 Q
ELIG I $G(CLOZPAT)=1 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="   Patient Eligible for 14 Day Supply or 7 Day Supply with 1 refill"
 I $G(CLOZPAT)=2 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="   Patient Eligible for 28 Day Supply or 14 Day Supply with 1 refill or 7 Day Supply with 3 refill"
 Q
USER(USER) ;returns .01 of 200
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="M",X="`"_USER D ^DIC S USER1=$S(+Y:$P(Y,"^",2),1:"Unknown") K DIC,X,Y
 Q
INSTNM ;
 K PSOFINDA,PSODINST I $G(DA) S PSOFINDA=$G(DA)
 K PSODNM S DA=$G(PSOPINST) I DA S DIC=4,DIQ(0)="E",DR=".01",DIQ="PSODNM" D EN^DIQ1 S PSODINST=$G(PSODNM(4,DA,.01,"E")) K PSODNM,DIC,DR,DA
 I $G(PSOFINDA) S DA=$G(PSOFINDA) K PSOFINDA
 Q
POST S PSOFINY=$G(Y) D ^PSOBUILD S Y=$G(PSOFINY) K PSOFINY D OERR^PSORX1 I $G(PSOQUIT) Q
 K PSOQFLG F PT="GET","DEAD","INP","CNH","TPB","ADDRESS","COPAY" S RTN=PT_"^PSOPTPST" D @RTN K PSOXFLG Q:$G(POERR("DEAD"))!($G(PSOQFLG))
 I $G(POERR("DEAD")) S POERR("QFLG")=1 Q
 K PSOERR("DEAD") I $G(PSOQFLG) Q
 D ^PSOORUT2,BLD^PSOORUT1,EN^PSOLMUTL
 Q
SIG ;
 S SIG=0,PSOFINFL=1 F  S SIG=$O(^PS(52.41,ORD,"SIG",SIG)) Q:'SIG  D
 .S (MIG,SIG(SIG))=^PS(52.41,ORD,"SIG",SIG,0)
 .F SG=1:1:$L(MIG," ") S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(MIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",20)=" " S ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(MIG," ",SG) D
 ..I $E(^TMP("PSOPO",$J,IEN,0),$L(^TMP("PSOPO",$J,IEN,0)))=" " S ^TMP("PSOPO",$J,IEN,0)=$E(^TMP("PSOPO",$J,IEN,0),1,($L(^TMP("PSOPO",$J,IEN,0))-1))
 S:$O(SIG(0)) SIGOK=1 K MIG
 F D=0:0 S D=$O(^PS(52.41,ORD,"INS1",D)) Q:'D  S PSONEW("INS",D)=^PS(52.41,ORD,"INS1",D,0)
 Q
