PRSRL1 ;HISC/JH,WCIOFO/JAH,SAB-ONE OR ALL EMPLOYEE LEAVE USE REPORT. ;7-AUG-2000
 ;;4.0;PAID;**2,5,17,19,35,39,61**;Sep 21, 1995
EMP ; employee entry point
 D DUZ^PRSRUTL G Q:'PRSRDUZ
 S DIC="^PRSPC(",DIC(0)="NZ",X=PRSRDUZ D ^DIC G Q1:Y=-1
 S SW=0,SW(4)=1,PRSR=3,PRSRY=Y,PRSRY1=$S($D(Y(0)):Y(0),1:"")
 S D0=$P(PRSRY,U),NAM=$P(Y(0),U),TLE=$P(Y(0),U,8),PRSRSSN=$P(Y(0),U,9)
 G EN2
 ;
SUP ;T&A supervisor entry point: select T&L unit & set up TLE array
 S PRSTLV=3,PRSAI=1,PRSR=1 D TLESEL^PRSRUT0 G Q1:$G(TLE)=""
 ;
LKUPEMP ;user selects 1 employee or all.  PRSRY and Y1 ="" if all selected.
 W !
 S DIC="^PRSPC(",DIC(0)="AEQZ",D="ATL"_$P(TLE(1),"^",1)
 S DIC("A")="Enter employee name (Return for All): "
 ;screen employees by T&L unit
 S DIC("S")="I $$INXR^PRSRL1($P(TLE(1),U),Y)"
 D IX^DIC G Q1:$D(DUOUT)!$D(DTOUT)
 ;
 S PRSR=0 S:X="" (PRSR,SW)=1,(PRSRY,PRSRY1)=""
 G EN1
 ;
FIS D DUZ^PRSRUTL G Q:SSN="" S PRSR=2
FIS1 W ! S DIC="^PRSPC(",DIC(0)="AEZM",DIC("A")="Enter employee name: "
 D ^DIC G Q1:$D(DUOUT)!$D(DTOUT)!(Y=-1)
 ;
 ;If a single T&L unit member was selected
EN1 I PRSR'=1 S PRSRY=Y,SW=0,D0=+Y,PRSRY1=$S($D(Y(0)):Y(0),1:""),NAM=$P(Y(0),"^"),TLE=$P(Y(0),"^",8),PRSRSSN=$P(Y(0),"^",9)
 I (PRSR=1)&'SW D CHKTLE^PRSRUTL G FIS1:'STFSW
 S SW(4)=1
 ;
EN2 W ! S X="T",%DT="" D ^%DT Q:Y<0  S DT=Y K %DT
ASK S %DT("A")="Report Beginning Date ",%DT(0)=-DT,%DT("B")="T",%DT="AEX"
 D ^%DT G Q1:$D(DTOUT)!(X="")!(X="^"),MSG2:Y=-1
 S FR=Y,FRO=Y-1,BDT=9999999-Y D DD^%DT S XX=Y
 S %DT("A")="Report Ending Date ",%DT("B")="T",%DT="AEX"
 D ^%DT G Q1:$D(DTOUT)!(X="")!(X="^"),MSG2:Y=-1,Q1:Y["^"
 S (TOP,TO)=Y,EDT=9999999-Y
 G ASK:FR>TO
 S D1=TO,DAT=X S Y=TO D DD^%DT S YY=Y
 ;
 I 'SW S COSORG=$P(PRSRY1,"^",49),COS=$S(COSORG'="":$E(COSORG,1,4),1:""),ORG=$S(COSORG'="":$E(COSORG,5,8),1:"") D
 .  I ORG'="" S ORG=$O(^PRSP(454,1,"ORG","B",COS_":"_ORG,"")) I ORG'="" S ORG=$P($G(^PRSP(454,1,"ORG",ORG,0)),"^",2),ORG=$S(ORG'="":$P($G(^PRSP(454.1,ORG,0)),"^"),1:COSORG)
 ;
 W ! I SW(4) S ZTRTN="START^PRSRL1",ZTDESC="EMPLOYEE LEAVE USAGE REPORT" D ST^PRSRUTL,LOOP,QUE1^PRSRUT0 G Q1:POP!($D(ZTSK))
 ;
START ; queued entry point
 S LVT=";"_$P(^DD(458.1,6,0),"^",3) ; Type of Leave set of codes
 S CNT=0
 K ^TMP($J,"USE")
 S ^TMP($J,"USE")="LEAVE USED SUMMARY"
 ;
 ;SW    = true when all employees in t&l selected
 ;        false when individual employee selected
 ;FRO   = fileman date
 ;D0    = employe ien in #450 (and #458)
 ;DA(1) = ien in file 458 (pay period)
 ;DA    = day # within payperiod
 ;DA(2) = pay period yyyy-nn
 ;DATES = string of FM dates for current pay period
 ;
 ; set up employee variables when printing individual
 I 'SW D
 . N X
 . S X=$G(^PRSPC(D0,0))
 . S NAM=$P(X,U)
 . S TLE=$P(X,U,8)
 . S SSN=$P(X,U,9),SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 ;
 ;Loop thru Time & Attendance (458) file "day" x-ref
 F  S FRO=$O(^PRST(458,"AD",FRO)) Q:FRO'>0!(FRO>TOP)  D
 . S X=$G(^PRST(458,"AD",FRO)),DA(1)=$P(X,U),DA=$P(X,U,2)
 . S DATES=$G(^PRST(458,DA(1),1))
 . ; determine the 4 digit year pay period
 . S D1=$P(DATES,U) D PP^PRSAPPU S DA(2)=PP4Y
 . ; get/sort leave for the day
 . D USE^PRSRLSOR
 ;
IND ; report results
 U IO
 I SW D ^PRSRL11 ; all empl report
 I 'SW D ^PRSRL12 ; one empl report
 D ^%ZISC
 ;
Q ;
Q1 K %,%DT,%Y,INX,CODE,FOOT,K,LVT,PPI,USR,PRSR,PRSRI,PRSRY,PRSRY1
 K PRSTLV,PRSV,TLE,TLI,TLUNIT,BDT,C,CNT,COS,COSORG,D0,DA,DAT,DAT2
 K DATE,DATES,DFN,DTOUT,DUOUT,POP,D1,STFSW,X1,X2,DATT,DAY,DAYS,DIC,EDT
 K FR,FRP,FRPP,P1,PP,PPE,PRSAI,SEL
 K I,II,J,LEV,LEVHR,LOC,LOC1,MIS1,MIS2,MISC,MISC1,MISS,NAM,NQ,NUM
 K ORG,POUT,POS,RG,SCEHR,SSN,SW,SW1,SW2,TC,TIM,TITLE,TL,TLEV,TO
 K TODA,TOP,TOPP,TOUR,TYL,TYP,TYPE,X,XX,XFR,Y,YY,Z,Z1,ZTDESC,ZTRTN
 K ZTSAVE,ZTSK,^TMP($J)
 K D,FRO,PAGE,PP4Y,PRSRDUZ,PRSRSSN
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
MSG1 W $C(7),!!,"*** Employee name not found." G EN1
MSG2 W $C(7),!!,"The Date was invalid." G ASK
MSG3 W $C(7),!!,"Date not found in file." G ASK
LOOP F X="D0","FR","FRO","FRP","TLE*","TO","TOP","SW","LOC","POS","PRSRY","PRSRY1","COS","ORG","XX","YY","NAM","PRSDUZ","PRSRSSN" S ZTSAVE(X)=""
 Q
INXR(TLCODE,IEN450) ;check if IEN is in T&L cross reference of 450
 Q $D(^PRSPC("ATL"_TLCODE,$P(^(0),U),+IEN450))
