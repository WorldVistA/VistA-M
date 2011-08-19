NURARPC1 ;HIRMFO/RM/MD-PRINT AMIS 1106 ACUITY REPORTS (cont.) ;2/27/98  14:38
 ;;4.0;NURSING SERVICE;**9,13**;Apr 25, 1997
SETDAY ; SET DAY IF DAILY REPORT
 D EN7^NURSAGP1 Q:NUROUT
 Q
SETMON ; SET MONTH IF MONTHLY REPORT
 W !!,"Enter MONTH and CALENDER YEAR: "
 R X:DTIME
 I '$T!("^"[X) S NUROUT=1 Q
 S %DT="E" D ^%DT K %DT
 G:((X["?")) SETMON
 S X=Y D H^%DTC I ((%Y'=-1)!($E(Y,6,7)'="00")!($E(Y,4,5)="00")) W $C(7),!!,"Only enter a MONTH and YEAR eg. '3/1998 or MAR, 1998' " G SETMON
 S NDATED=$E(Y,1,5)_"MT"
 S:'$D(NURTYPE) NURTYPE=0 S NURSHDR=$S(NURTYPE=0:"AMIS ",1:"Midnight Acuity ")_"Monthly Report for "_$E(NDATED,4,5)_"/"_$E(NDATED,2,3)
 Q
SETQUART ; SET QUARTER IF QUARTERLY REPORT
 W ! S %DT="AE",%DT("A")="Enter FISCAL YEAR: "
 D ^%DT K %DT
 I X="^" S NUROUT=1 Q
 G:((Y<0)!(X["?")) SETQUART
 S X=Y D H^%DTC I ((%Y'=-1)!($E(Y,4,5)'="00")) W *7,!!,"Only enter a YEAR" G SETQUART
 K %Y S NDATED=$E(Y,1,3) S:'$D(NURTYPE) NURTYPE=0
 I NURSWHEN["A" S NURSHDR=$S(NURTYPE=0:"AMIS ",1:"Midnight Acuity ")_"Annual Report for "_(1700+$E(NDATED,1,3)) Q
SETQUAR1 ;
 W !!,"Enter QUARTER (Choose a number 1-4): "
 R X:DTIME
 I X="^"!'$T S NUROUT=1 Q
 I ((X'?1N)!(X<1)!(X>4)) W $C(7) G SETQUAR1
 S NDATED=$S(X=1:NDATED_"12Q1",X=2:NDATED_"03Q2",X=3:NDATED_"06Q3",X=4:NDATED_"09Q4",1:0)
 I NDATED=0 W *7,!!!,"INVALID ENTRY, TRY AGAIN" G SETQUART
 S:'$D(NURTYPE) NURTYPE=0 S NURSHDR=$S(NURTYPE=0:"AMIS ",1:"Midnight Acuity ")_"Quarterly Report for "_(1700+$E(NDATED,1,3))_" Qtr. #"_$E(NDATED,7)
 Q
NOVALU(NDA) ;
 ; This function checks inactive units to see if they have acuity
 ; data for the requested reporting period. If a unit has acuity
 ; data a one (1) is returned otherwise a zero (0) is returned,
 N NURX S NURX=1,NUNIT=$E($P($G(^NURSA(213.4,NDA,0)),U),9,99)
 I $G(^NURSF(211.4,+NUNIT,"I"))="I" D
 .  S D1=0 F  S D1=$O(^NURSA(213.4,NDA,1,D1)) Q:D1'>0  D:$G(^NURSA(213.4,NDA,1,D1,0))'=""
 .  .  I $P(^NURSA(213.4,NDA,1,D1,0),U,2,6)="0^0^0^0^0" S NURX=0
 .  .  Q
 .  Q
 K NUNIT
 Q NURX
