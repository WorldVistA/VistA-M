PRSADP2 ; HISC/REL-Display Employee Pay Period ;7/22/97
 ;;4.0;PAID;**21,28,46,114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
PAY ; Payroll Entry
 N PPERIOD
 S PRSTLV=7
 D TOP ; print header
P1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC(0)="AEQM",DIC="^PRSPC("
 W ! D ^DIC S DFN=+Y K DIC G:DFN<1 EX
 S TLE=$P($G(^PRSPC(DFN,0)),"^",8)
 S DIC="^PRST(458,",DIC(0)="AEQM",DIC("A")="Select PAY PERIOD: "
 W ! D ^DIC K DIC G:Y<1 EX
 S PPI=+Y
 ;  1st put pay period in YY-PP format 4 call 2 lookup old T&L.
 S PPERIOD=$S(Y["-":$P(Y,"^",2),1:$P(^PRST(458,$P(Y,"^"),0),"^"))
 D CHECKTLE(PPERIOD,DFN,.TLE) ;verify that T&L unit hasn't changed
 D L1 ;ask device
 G P1 ;ask for employee again
 ;====================================================================
TK ; TimeKeeper Entry
 S PRSTLV=2 G T0
 ;====================================================================
SUP ; Supervisor Entry
 S PRSTLV=3
T0 D TOP ; print header
 D ^PRSAUTL G:TLI<1 EX
 N PPERIOD
T1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC(0)="AEQM",DIC="^PRSPC("
 S DIC("S")="I $P(^(0),""^"",8)=TLE" S D="ATL"_TLE W ! D IX^DIC
 S DFN=+Y K DIC G:DFN<1 EX
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT(0)=-DT W ! D ^%DT
 G:Y<1 EX S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1) G EX:PPI<1
 ;  1st put pay period in YY-PP format 4 call 2 lookup old T&L.
 S PPERIOD=$S(Y["-":$P(Y,"^",2),1:$P(^PRST(458,$P(Y,"^"),0),"^"))
 ;
 ; Save T&L unit 4 use in DIC("S"), cause we might change TLE
 ; for display if this employee was in a different T&L during 
 ; the selected pay period.
 S TLSCREEN=TLE
 ;
 D CHECKTLE(PPERIOD,DFN,.TLE) ;verify that T&L unit hasn't changed
 D L1 ;ask device
 ;restore TLE variable to the one originally selected.
 S TLE=TLSCREEN
 ; 
 G T1 ;ask for employee again
 ;====================================================================
EMP ; Employee Entry
 N PPERIOD,OLDTLE
 S PRSTLV=1 D TOP S DFN="",SSN=$P($G(^VA(200,DUZ,1)),"^",9)
 I SSN'="" S DFN=$O(^PRSPC("SSN",SSN,0))
 I 'DFN W !!,*7,"Your SSN was not found in both the New Person & Employee File!" G EX
 S TLE=$P($G(^PRSPC(DFN,0)),"^",8)
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT(0)=-DT W ! D ^%DT
 G:Y<1 EX S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1) G EX:PPI<1
 ;  1st put pay period in YY-PP format 4 call 2 lookup old T&L.
 S PPERIOD=$S(Y["-":$P(Y,"^",2),1:$P(^PRST(458,$P(Y,"^"),0),"^"))
 D CHECKTLE(PPERIOD,DFN,.TLE) ;verify that T&L unit hasn't changed
 D L1 G EX
 ;====================================================================
TOP W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?27,"EMPLOYEE PAY PERIOD DATA" Q
L1 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP Q:POP
 I $D(IO("Q")) S PRSAPGM="DIS^PRSADP2",PRSALST="DFN^TLE^PPI" D QUE^PRSAUTL Q
 U IO D DIS
 ; pause screen when employee to prevent scroll (other users prompted)
 I $E(IOST,1,2)="C-",'QT,PRSTLV=1 S PG=PG+1 D H1
 D ^%ZISC K %ZIS,IOP Q
 ;====================================================================
DIS ; Display 14 days
 S PDT=$G(^PRST(458,PPI,2)),STAT=$P($G(^PRST(458,PPI,"E",DFN,0)),"^",2)
 S (PG,QT)=0 D HDR
 W !!,?7,"Date",?21,"Scheduled Tour",?46,"Tour Exceptions"
 W !?3,"------------------------------------------------------------------------"
 F DAY=1:1:14 S DTE=$P(PDT,"^",DAY) D:$Y>(IOSL-5) HDR G:QT D1 D F0^PRSADP1
 S Z=$G(^PRST(458,PPI,"E",DFN,2)) I Z'="" D:$Y>(IOSL-10) HDR Q:QT  D VCS^PRSASR1
 S Z=$G(^PRST(458,PPI,"E",DFN,4)) I Z'="" D:$Y>(IOSL-8) HDR Q:QT  D ED^PRSASR1
 S (X9,XF)=0 F DAY=1:1:14 D ^PRSATPE I $D(ER) S:FATAL XF=1 F K=0:0 S K=$O(ER(K)) Q:K<1  D:$Y>(IOSL-4) HDR G:QT D1 W:X9 ! W !?5,$P(PDT,"^",DAY),"  " W:$P(ER(K),"^",2)'="" $P(ER(K),"^",2) W ?28,$P(ER(K),"^",1) S X9=0
D1 I PRSTLV>5 S Z=$G(^PRST(458,PPI,"E",DFN,5)) W:Z'="" !!,"8B Codes: ",Z
 Q:QT  W ! I $D(^PRST(458,PPI,"E",DFN,"X",0)) D ^PRSAUDP
 Q
 ;====================================================================
HDR ; Display Header
 D H1 Q:QT  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1
 S X=$G(^PRSPC(DFN,0)) ;employees (partial) master record.
 W ! W:$E(IOST,1,2)="C-" @IOF
 W ?3,$P(X,"^",1),?36,"T&L ",$S($G(TLE):TLE,1:$P(X,"^",8))
 S X=$P(X,"^",9)
 I '$G(PRSTLV)!($G(PRSTLV)=1) W ?68,"XXX-XX-",$E(X,6,9) W:PG>1 ! Q
 I PRSTLV=2!(PRSTLV=3) W ?68,$E(X),"XX-XX-",$E(X,6,9) W:PG>1 ! Q 
 I PRSTLV=7 W ?68,$E(X,1,3),"-",$E(X,4,5),"-",$E(X,6,9) W:PG>1 ! Q
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX G KILL^XUSCLEAN
 Q
 ;=============J.Heiges===============================================
CHECKTLE(PAYPRD,EMPLOYEE,TLE) ;
 ;  In cases where Time keepers, Payroll or employees are viewing 
 ;an old pay period, make sure employee being viewed was not in 
 ;a different T&L unit.
 ;  This routine calls function that checks an old pay plan and
 ;populates OLDPP() array with T&L Unit.
 ;  To handle cases when we're dealing with the current pay period,
 ;ignore cases when the lookup fails, since the current pay period
 ;will not be in the Pay Run download file.  If old T&L unit not found, 
 ;display current.
 ;
 ;VARS:
 ;  PAYPRD= Pay period in file 458, .01 field, in the
 ;          form YY-PP (year-pay period).  i.e 96-02
 ;  EMPLOYEE= employees internal entry number in file 450.
 ;
 N PPLOLD,PPL,OLDPP
 ; call old pay plan lookup to also return old T&L unit.
 S PPLOLD=$$OLDPP^PRS8UT(PAYPRD,+EMPLOYEE) ;pay plan from PAYPDTMP.
 ;
 ; Did lookup find legitimate T&L unit ?  If so, is it different
 ; than the employees current T&L?  If so, return old value.
 I $L($G(OLDPP("TLUNIT")))>2 D
 .  I OLDPP("TLUNIT")'=TLE S TLE=OLDPP("TLUNIT")
 ;
 Q
 ;===================================================================
