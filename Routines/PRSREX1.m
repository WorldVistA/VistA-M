PRSREX1 ;HISC/JH,JAH-INDIVIDUAL SERVICE EXPENDITURE REPORT ;22-JAN-1998
 ;;4.0;PAID;**2,16,17,19,35**;Sep 21, 1995
 ;
 ;TLESEL sets up TLE array in PRSUT0:
 ;   TLE      = # units selected
 ;   TLE(n)   = T&L unit ^ name
 ;   TLE(n,m) = IEN ^ member name
 ;T&A Supervisor entry point
SUP S PRSTLV=3
 S (PRSR,PRSAI)=1
 D TLESEL^PRSRUT0 G MSG4:$G(TLE)=""!(SSN="") G EN1
 ;
 ;Payroll entry point
FIS S PRSR=2,PRSTLV=3
 D TLESEL^PRSRUT0 G MSG4:TLE=""!(SSN="")
 ;
EN1 W ! S X="T",%DT="" D ^%DT Q:Y<0  S DT=Y K %DT
 ;
 ;set DA to earliest payrun on record
 ;ask, construct and validate payperiod input
ASK S DA=""
 S DA=$O(^PRST(459,"AB",DA))
 S DA=$E((DA-1700),1,3)_"0000"
 S %DT("A")="Enter YEAR: "
 S %DT="AEP",%DT(0)=-DT
 D ^%DT G Q1:$D(DTOUT)!(X="^"),MSG2:X="?"!(Y=-1),MSG3:Y<DA K %DT S YEAR=$E(Y,2,3)
ASK1 R !!,"Enter Pay Period (Return for all): ",PPE:DTIME G Q1:'$T!(PPE="^") G MSG:(PPE'>0&(PPE'<27))!(PPE["?")
 I PPE'="" S II=$L(PPE),PPE=$S(II>1:PPE,1:"0"_PPE),DA(1)=YEAR_"-"_PPE,DA=$O(^PRST(459,"B",DA(1),"")) G MSG1:DA=""
 E  S DA(1)=$E(Y,2,3)_"-"_"00" W !,"This report could take some time, remember to QUEUE the report."
 D DUZ^PRSRUTL
 S TLUNIT=$S(PRSRDUZ:$P($G(^PRSPC(PRSRDUZ,0)),"^",7),1:$O(^VA(200,DUZ,2,0))),TLI=$S(PRSRDUZ:$P($G(^(0)),"^",8),1:"000")
 S ZTRTN="START^PRSREX1",ZTDESC="SERVICE EXPENDITURE REPORT" W !!,$C(7),"THIS IS A 132 COLUMN REPORT !",! D ST^PRSRUTL,LOOP,QUE1^PRSRUT0 G Q1:POP!($D(ZTSK))
START S (CNT,POUT,TGOV,TOTAL)=0 K ^TMP($J) S ^TMP($J,"EXP")="EMPLOYEE COST FOR PAY PERIOD" F II=1:1:9 S TOTAL(II)=0
 ;
 S DAT=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 ;
 ;if a single pay period was selected
 I PPE D EXP^PRSROSOR,IND,Q1 Q
 ;
 ;otherwise all pay periods for a year were selected
 ;Q if we've gone into next year or end
 F II=0:0 S DA(1)=$O(^PRST(459,"B",DA(1))) Q:DA(1)=""!($P(DA(1),"-")'=YEAR)  D
 .  S DA=0 F II=0:0 S DA=$O(^PRST(459,"B",DA(1),DA)) Q:DA'>0  D EXP^PRSROSOR
 .  Q
IND U IO I 'CNT S PP=PPE,SW(7)=1,TLEU=TLE D HDR1^PRSREX11,VLIN0^PRSREX11 W "|",?10,"No Expenditures on File this Pay Period.",?131,"|" S POUT=1 D NONE G Q1
 D ^PRSREX11
Q1 K %,%DT,FOOT,CODE,TLE,TLUNIT,CNT,COS,COSORG,D0,DA,DAT,DTOUT,POP,DIC,GOV,TGOV,NAM,PP,PPE,PRSAI,PRSR,PRSTLV,STOT
 K TL,TLI,USR,Z1,I,II,ORG,PRSRDUZ,POUT,SSN,SW,TIME,TOT,TOTAL,X,Y,YEAR,ZTDESC,ZTRTN,ZTSAVE,^TMP($J) D ^%ZISC S:$D(ZTSK) ZTREQ="@" K ZTSK
 Q
NONE I IOSL<66 F I=$Y:1:IOSL-5 D VLIN0^PRSREX11
 D HDR^PRSREX11
 Q
MSG W !,"Enter Numeric Digit, 1 thru 26 or Return/Enter for All Pay Periods." G ASK1
MSG1 W !!,*7,"*** Pay Period ",PPE," Year ",YEAR," not found in File." G ASK1
MSG2 W !!,*7,"*** Enter Year: 92 , 1994 ... " G ASK
MSG3 W !!,*7,"*** Year Entered is not on File." G ASK
MSG4 R !!,"Press Return/Enter to continue. ",X:DTIME G Q1
LOOP F X="DA*","TLE*","TLI","TLUNIT","DT","ORG","PPE","YEAR","SW" S ZTSAVE(X)=""
 Q
