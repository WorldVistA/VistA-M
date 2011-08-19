PRSROT1 ;HISC/JH-IND. OR ALL EMPLOYEE OT/CT REPORT ;1/12/98
 ;;4.0;PAID;**2,19,21,28,27,34,114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
SUP S PRSTLV=3,PRSAI=1
 S PRSR=1
 D TLESEL^PRSRUT0
 G Q:$G(TLE)=""!(SSN="")
 G EN1
 ;
 ;get Time & Leave unit and set up TLE array.
FIS S PRSR=2,PRSTLV=7
 D TLESEL^PRSRUT0
 G Q:TLE=""!(SSN="")
EN1 W ! S X="T",%DT="" D ^%DT Q:Y<0  S DT=Y K %DT
 ;
 ;get one or all employees
EN2 W !
 S DIC="^PRSPC(",DIC(0)="AEQZ"
 S D="ATL"_$P(TLE(1),"^",1)
 S DIC("A")="Enter employee name (Return for All): "
 S DIC("S")="I $$INXR^PRSRL1($P(TLE(1),U),Y)"
 D IX^DIC G Q1:$D(DUOUT)!$D(DTOUT)
 S PRSRY=Y,SW=$S(PRSRY'=-1:0,1:1)
 I 'SW S D0=$P(PRSRY,"^") D CHKTLE^PRSRUTL G EN2:'STFSW
 ;
 ;get year and validate
ASK S %DT("A")="Enter YEAR: "
 S %DT="AEP"
 S %DT(0)=-DT
 D ^%DT K %DT
 G Q1:$D(DTOUT)!(X="^"),MSG2:X="?"!(Y=-1)
 G MSG3:$P($O(^PRST(459,"B",$E(Y,2,3)_"-")),"-")'=$E(Y,2,3)
 S YEAR=$E(Y,2,3)
 ;
 ;get pay periods
ASK1 ;
 ;determine first and last pay periods on file for year
 S X(1)=+$P($O(^PRST(459,"B",YEAR_"-00")),"-",2) ; first
 S X(2)=+$P($O(^PRST(459,"B",YEAR_"-99"),-1),"-",2) ;last
 S DIR(0)="NOA^"_X(1)_":"_X(2)_":0"
 S DIR("A")="Start with Pay Period ("_X(1)_"-"_X(2)_", or Return for all in this year): "
 S DIR("?",1)="Enter the number of the first pay period to be included"
 S DIR("?",2)="on the report. Only pay periods on file can be selected."
 S DIR("?",3)="Just press Return to select all pay periods for the year."
 S DIR("?",4)=" "
 S DIR("?")="Enter a number ("_X(1)_"-"_X(2)_") or press Return for all"
 D ^DIR K DIR G:$D(DTOUT)!$D(DUOUT) Q1
 I Y="" S PPE(1)=X(1),PPE(2)=X(2) ; all pay periods
 E  S PPE(1)=Y D  G:$D(DIRUT) Q1 S PPE(2)=Y
 . S DIR(0)="NA^"_PPE(1)_":"_X(2)_":0"
 . S DIR("A")="End with Pay Period ("_PPE(1)_"-"_X(2)_"): "
 . S DIR("B")=PPE(1)
 . D ^DIR K DIR
 S:$L(PPE(1))=1 PPE(1)="0"_PPE(1)
 S:$L(PPE(2))=1 PPE(2)="0"_PPE(2)
 I SW,PPE(1)'=PPE(2) W !,"This report could take some time. Consider Queuing the report."
 ;
 S TLUNIT=$S(PRSRDUZ:$P($G(^PRSPC(PRSRDUZ,0)),"^",7),1:$O(^VA(200,DUZ,2,0))),TLI=$S(PRSRDUZ:$P($G(^(0)),"^",8),1:"000")
 S ZTRTN="START^PRSROT1"
 S ZTDESC="EMPLOYEE OT/CT REPORT" W !!,$C(7),"THIS IS A 132 COLUMN REPORT !",! D ST^PRSRUTL,LOOP,QUE1^PRSRUT0 G Q1:POP!($D(ZTSK))
 ;
 ;======================================================================
 ;
START S (CNT,COMP(1),COMPU(1),OTP(1),OTH(1),POUT)=0
 K ^TMP($J)
 S ^TMP($J,"OT/CP")="EMPLOYEE OT/CT REPORT"
 ;
 ; loop thru specified pay periods and gather/sort data
 S PPE=+PPE(1)-1 S:$L(PPE)=1 PPE="0"_PPE
 S DA(2)=YEAR_"-"_PPE
 F  S DA(2)=$O(^PRST(459,"B",DA(2))) Q:($P(DA(2),"-")'=YEAR)!($P(DA(2),"-",2)>PPE(2))  D
 . S DA(1)=$O(^PRST(459,"B",DA(2),0)) Q:DA(1)'>0  ; pay period ien in 459
 . D DAT ; payrun date
 . S DA(3)=$O(^PRST(458,"B",DA(2),0)) Q:DA(3)'>0  ; pay period ien in 458
 . ; if one employee
 . I 'SW D OTCT^PRSROSOR
 . ; if all employees
 . I SW S D0=0 F  S D0=$O(^PRST(458,DA(3),"E",D0)) Q:D0'>0  D
 . . S NAM=$P($G(^PRSPC(D0,0)),"^")
 . . D OTCT^PRSROSOR
 ;
 ; report results
IND S DAT=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3) U IO I 'CNT D HDR1^PRSROT11 W !,"|",?10,"No Overtime, Comptime, or Credit Hours Data on File.",?131,"|" S POUT=1 D NONE G Q1
 D ^PRSROT11 G Q1:POUT I CNT D VLIDSH0^PRSROT11 S CODE="O001",FOOT="VA TIME & ATTENDANCE SYSTEM" D FOOT1^PRSRUT0
Q I $E(IOST,1,2)="C-" S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
Q1 K %,%DT,DATT,DIC,FOOT,INX,CODE,COMP,COMPU,DTOUT,DUOUT,POP,OTH,OTP,PPE,PRSAI,PRSR,PRSRY,PRSTLV,TL,TLE,TLI,USR,TLUNIT,CNT,COS,COSORG,D0,DA,DAT,DATE,DATES,DAY,DDATE,PP
 K I,II,NAM,ORG,POUT,SAL,SSN,STFSW,SW,TIME,TITLE,X,Y,YEAR,Z1,ZTDESC,ZTRTN,ZTSAVE,ZTSK,^TMP($J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
DAT S DATE=$P($G(^PRST(459,DA(1),0)),"^",2) S:DATE'="" DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 Q
NONE I IOSL<66 D VLIN0^PRSROT11
 D HDR^PRSROT11
 Q
MSG2 W $C(7),!!,"*** Enter Year: 92 , 1994 ... " G ASK
MSG3 W $C(7),!!,"*** Year Entered is not on File." G ASK
LOOP F X="D0","DA*","PPE*","NAM","TLE*","TL*","TLI","TLUNIT","SW","COS","ORG","YEAR","PRSRY","PRSTLV" S ZTSAVE(X)=""
 Q
