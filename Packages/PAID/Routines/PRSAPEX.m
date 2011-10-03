PRSAPEX ; HISC/REL-Pay Period Exceptions ; 3-27-1998
 ;;4.0;PAID;**37,43**;Sep 21, 1995
 K DIC S DIC="^PRST(458,",DIC(0)="AEQM",DIC("A")="Select PAY PERIOD: " W ! D ^DIC K DIC G:Y<1 EX S PPI=+Y
T0 R !!,"Select T&L Unit (or ALL): ",X:DTIME G:'$T!("^"[X) EX S X=$TR(X,"al","AL") I X="ALL" S TLE="" G L1
 K DIC S DIC="^PRST(455.5,",DIC(0)="EMQ" D ^DIC G EX:$D(DTOUT),T0:Y<1
 S TLE=$P(Y,"^",2)
L1 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSAPEX",PRSALST="PPI^TLE" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 ; Process Exception List
 S PPE=$P($G(^PRST(458,PPI,0)),"^",1),PDT=$G(^PRST(458,PPI,2)),QT=0
 S DTE=$P(PDT,"^",1)_" to "_$P(PDT,"^",14),PG=0,HDR=0 D HDR
 I TLE'="" S ATL="ATL"_TLE,TL=TLE D Q10 D:'QT H1 Q
 S ATL="ATL00"
 F  S ATL=$O(^PRSPC(ATL)) Q:ATL'?1"ATL".E  S TLE=$E(ATL,4,6) D Q10 Q:QT
 D:'QT H1 Q
Q10 S NN=""
 F  S NN=$O(^PRSPC(ATL,NN)) Q:NN=""  D  Q:QT
 .  S HDR=0
 .  F DFN=0:0 S DFN=$O(^PRSPC(ATL,NN,DFN)) Q:DFN<1  D  Q:QT
 ..    Q:'$D(^PRST(458,PPI,"E",DFN,"D",0))
 ..    F DAY=1:1:14 D FND Q:QT
 ..;
 ..;  If timecard status is other than Timekeeper & a TT8b is on file
 ..;  then compare calculated OT in TT8B to approved OT in request file.
 ..;  Display & file OT warning if existing warning is not cleared.
 ..;  
 ..    N TT8B,STATUS,WEEK,OT8B,OTAPP
 ..    S TT8B=$G(^PRST(458,PPI,"E",DFN,5)),STATUS=$P($G(^(0)),"^",2)
 ..    Q:(STATUS="T")!(TT8B="")
 ..    F WEEK=1:1:2 D
 ...      I $$CHECKOT(PPI,WEEK,DFN) D
 ....        D GETOTS^PRSAOTT(PPE,DFN,TT8B,WEEK,.OT8B,.OTAPP)
 ....        I OTAPP<OT8B D 
 .....          D OTDISP(DFN,OT8B,OTAPP,WEEK)
 .....          D FILEOTW^PRSAOTTF(PPI,DFN,WEEK,OT8B,OTAPP)
 Q
 ;
CHECKOT(P,W,E) ;DETERMINE WHETHER TO DO THE OT CHECK
 ;
 ;input:  P--pay period ien, W--week 1 or 2 of pp, E--emp 450 ien
 ;return: true or false as described below.
 S CHECK=1
 ;
 ;If no warning on file do OT warnings check (return true).
 ;
 ;If warning on file for this pay per, week, employee (P,W,E)
 ;and status of warning is cleared then don't recheck or display
 ;any warning (return false).  A status of cleared indicates 
 ;payroll has cleared the warning to remove it from display.
 ;
 S WRNIEN=$$WRNEXIST^PRSAOTTF(P,E,W)
 Q:'WRNIEN CHECK
 ;
 Q:$P($G(^PRST(458.6,WRNIEN,0)),"^",5)'="C" CHECK
 Q 0
 ;
FND D ^PRSATPE Q:'$D(ER)
 I 'HDR D:$Y>(IOSL-5) HDR Q:QT  W !!,$P(^PRSPC(DFN,0),"^",1)," (",TLE,")" S HDR=1
 F K=0:0 S K=$O(ER(K)) Q:K<1  D:$Y>(IOSL-3) HDR Q:QT  W !?5,$P(PDT,"^",DAY),"  " W:$P(ER(K),"^",2)'="" $P(ER(K),"^",2) W ?28,$P(ER(K),"^",1)
 Q
OTDISP(DFN,OT8B,OTAPP,WEEK) ;
 I 'HDR D:$Y>(IOSL-5) HDR Q:QT  W !!,$P(^PRSPC(DFN,0),"^",1)," (",TLE,")" S HDR=1
 D:$Y>(IOSL-3) HDR Q:QT  D DISPLAY^PRSAOTT(DFN,OT8B,OTAPP,WEEK)
 Q
HDR ; Display Header
 D H1 Q:QT  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !?26,"VA TIME & ATTENDANCE SYSTEM",?72,"Page ",PG
 W !!?(81-$L(DTE)\2),DTE W:HDR !!,$P(^PRSPC(DFN,0),"^",1)," (",TLE,")" Q
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX G KILL^XUSCLEAN
 Q
