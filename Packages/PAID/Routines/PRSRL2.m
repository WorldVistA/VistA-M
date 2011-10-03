PRSRL2 ;HISC/JH,WIRMFO/JAH-IND. OR ALL EMPLOYEE LEAVE REQUEST REPORT ;3/5/1998
 ;;4.0;PAID;**2,17,19,39**;Sep 21, 1995
 ;
 ;entry point from T&A supervisor menu
 ;TLESEL allows selection of a T&L unit if user is a supervisor
 ;of the T&L unit.  It returns TLE array populated with T&L unit
SUP S PRSTLV=3,(PRSAI,PRSR)=1 D TLESEL^PRSRUT0 G Q:$G(TLE)=""!(SSN="")
 W ! S X="T",%DT="" D ^%DT Q:Y<0  S DT=Y K %DT
 ;
EN1 S DIC="^PRSPC("
 S DIC(0)="AEQZ"
 S D="ATL"_$P(TLE(1),"^",1)
 S DIC("S")="I $$INXR^PRSRL1($P(TLE(1),U),Y)"
 S DIC("A")="Enter employee name (Return for all): "
 D IX^DIC
 G Q1:$D(DUOUT)!$D(DTOUT)
 S PRSRY=Y,PRSRY1=$S($D(Y(0)):Y(0),1:"")
 I PRSRY'=-1 S D0=$P(PRSRY,"^") D CHKTLE^PRSRUTL G EN1:'STFSW
 ;
ASK ;get beginning date for report
 S %DT("A")="Report Beginning Date "
 S %DT("B")="T",%DT="AEX"
 D ^%DT G Q1:$D(DTOUT)!(X="")!(X="^"),MSG2:Y=-1 S FR=Y D DD^%DT S XX=Y
 ;
 ;for ending date set default to users response to the begin date ?
 S %DT("A")="Report Ending Date: "
 S %DT("B")=XX,%DT(0)=FR
 S %DT="AEX" D ^%DT G Q1:$D(DTOUT)!(X="^"),MSG2:Y=-1
 S TO=Y
 G ASK:FR>TO
 S X1=FR,X2=-1
 D C^%DTC S DAT=X,Y=TO D DD^%DT S YY=Y K %DT
 ;
 S ZTRTN="START^PRSRL2"
 S ZTDESC="EMP. LEAVE REQUEST REPORT"
 W !!,$C(7),"THIS IS A 132-COLUMN REPORT !",!
 D ST^PRSRUTL,LOOP,QUE1^PRSRUT0 G Q1:POP!($D(ZTSK))
START S ^TMP($J,"REQ",0)="EMPLOYEE   LEAVE   REQUEST  LIST"
 S LVT=";"_$P(^DD(458.1,6,0),"^",3)
 S LVS=";"_$P(^DD(458.1,8,0),"^",3)
 S (POUT,CNT)=0
 ;
 ; user has selected one person for the report
 I PRSRY'=-1 D SINGLE Q
 ;
 ; user has selected all employees for the report
 S TLUNIT=$S(PRSRDUZ:$P($G(^PRSPC(PRSRDUZ,0)),"^",7),1:"000")
 S TLI=$S(PRSRDUZ:$P($G(^(0)),"^",8),1:"000")
 S TLI(0)=0,SW=1
 F  S TLI(0)=$O(TLE(TLI(0))) Q:TLI(0)'>0  S TLI(1)=0 F  S TLI(1)=$O(TLE(TLI(0),TLI(1))) Q:TLI(1)'>0  S D0=$P(TLE(TLI(0),TLI(1)),U),NAM=$P(TLE(TLI(0),TLI(1)),U,2) D REQ^PRSRLSOR
 D IND
 Q
SINGLE ;
 S SW=0
 S SSN=$S(PRSRY1'="":$P(PRSRY1,"^",9),1:"")
 S:SSN'="" SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 S COS=$E($P(PRSRY,"^",49),1,4)
 S ORG=$E($P(PRSRY,"^",49),5,8)
 S TLUNIT=$P(^PRSPC(D0,0),"^",7)
 S TLE=$P(TLE(TL),U)
 S:ORG ORG=$O(^PRST(454,1,"ORG","B",COS_":"_ORG,""))
 D REQ^PRSRLSOR,IND
 Q
 ;
 ;
IND ;
 S DAT=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 U IO
 I $E(IOST,1,2)="C-" W @IOF
 I 'CNT D HDR1^PRSRL21:SW=1,HDR2^PRSRL21:SW=0 W !,"|",?10,"No Requests on File within this Date Range.",?131,"|" S POUT=1 D NONE G Q
 D HDR2^PRSRL21:'SW,PRT2^PRSRL21:'SW,HDR1^PRSRL21:SW,PRT1^PRSRL21:SW G Q1:POUT F I=$Y:1:IOSL-5 D VLIN1^PRSRL21:SW,VLIN^PRSRL21:'SW
 I CNT D VLIDSH^PRSRL21:'SW,VLIDSH1^PRSRL21:SW S CODE=$S('SW:"L001",1:"L002"),FOOT="VA TIME & ATTENDANCE SYSTEM" D FOOT1^PRSRUT0
Q I $E(IOST,1,2)="C-" R !!,"Press Return/Enter to continue. ",X:DTIME
Q1 K %DT,BEG,CNT,CODE,COS,COSORG,D0,D1,DA,DAPR,DAT,DAY,DENT,DTOUT,DUOUT,FOOT,II,POP,X1,X2,DIC,DTI,END,FR,I,K,LVS,LVT,NAM,ORG,POUT,PPI,PRSAI,PRSR,PRSRI,PRSRY,PRSRY1
 K PRSRDUZ,PRSTLV,SCOM,SSN,STFSW,SUPR,SW,TL,TLE,TLI,TLUNIT,TO,TOUR,USR,X,XX,Y,YY,Z,Z1,ZTDESC,ZTRTN,ZTSAVE,^TMP($J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
NONE I IOSL<66 F I=$Y:1:IOSL-5 D VLIN1^PRSRL21:SW,VLIN^PRSRL21:'SW
 D HDR^PRSRL21
 Q
MSG2 W !!,*7,"The Date was invalid." G ASK
LOOP F X="D0","FR","NAM","ORG","TO","TL*","TLE*","TLI","PRSRDUZ","PRSRY","PRSRY1","XX","YY" S ZTSAVE(X)=""
 Q
