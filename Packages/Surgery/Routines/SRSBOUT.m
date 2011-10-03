SRSBOUT ;B'HAM ISC/MAM - BLOCK OUT TIME ON OR SCHEDULE ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50,165**;24 Jun 93;Build 6
CNG S SRS1=$P(^SRS("R",SRSDAY,SRSOR,I,J),"^",3),EN1=$P(^(J),"^",4),SRS2=SRSST,EN2=SRSET
 I (SRS1'<SRS2)&(SRS1<EN2)!((EN1>SRS2)&(EN1'>EN2))!((SRS2'<SRS1)&(SRS2<EN1)) I J=0!(SRSNUM=0)!((J<8)&(SRSNUM>5))!((J>5)&(SRSNUM<8))!(SRSNUM=J)!(((J=4)!(J=5)&(SRSNUM=4)!(SRSNUM=5))) D INT
 Q
INT ; collision with service at the same time
 S SRSSER1=^SRS("R",SRSDAY,SRSOR,I,J),STIME=$P(SRSSER1,"^",3),ETIME=$P(SRSSER1,"^",4),STIME=$E(STIME,1,2)_":"_$E(STIME,4,5),ETIME=$E(ETIME,1,2)_":"_$E(ETIME,4,5)
 S SRSBANG=1 W !!,"Time collision with '"_$P(SRSSER1,"^",5)_"' which has reservations from "_STIME_" to "_ETIME_".",!
 ;;>>BEGIN 3*165-RJS
 W:$G(SRBCHK(SRSDATE)) "The start date entered is not available for your ",SRSSER," Service Block.",!
 W !,"I will search for available openings.  Please wait."
 N SRSDT S SRSDT=0 F  S SRSDT=$O(SRBCHK(SRSDT)) Q:'SRSDT  D
 .I $G(SRBCHK(SRSDT)) W !,?5,$E(SRSDT,4,5),"-",$E(SRSDT,6,7),"-",$E(SRSDT,2,3)," is not available"
 .I '$G(SRBCHK(SRSDT)) W !,?5,$E(SRSDT,4,5),"-",$E(SRSDT,6,7),"-",$E(SRSDT,2,3)," is available"
 N DIR,Y S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to use the available dates" D ^DIR Q:Y
 S SRBFLG=1 W !!,"Your Service Block has not been set."  ;;<<END 3*165-RJS
 Q
S ; set up ^SRS
 S ^SRS(SRSOR,"S",SRSDATE,1)=$E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3)_"  |____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|"
 S ^SRS(SRSOR,"S",SRSDATE,0)=SRSDATE
 I '$D(^SRS(SRSOR,"SS",SRSDATE,1)) S ^SRS(SRSOR,"SS",SRSDATE,1)=^SRS(SRSOR,"S",SRSDATE,1),^SRS(SRSOR,"SS",SRSDATE,0)=SRSDATE
 Q
END W !!,"Press RETURN to continue  " R X:DTIME
 K SRBCHK,SRBFLG,SRBPRG,^TMP($J) ;; 3*165-RJS  CLEANUP
 D ^SRSKILL W @IOF
 Q
MNTH ; one day each month
 R !!,"Every month, last week of the month ? NO//  ",Z1:DTIME I '$T!(Z1["^") S SRSOUT=1 Q
 S Z1=$E(Z1) S:Z1="" Z1="N" S:$E(Z1)="y" Z1="Y" S:Z1["Y" Z=7
 I "YyNn"'[Z1 W !!,"If this blockout should appear on the same day every month, on the last",!,"week of that month, enter 'YES'.  Otherwise, enter RETURN." G MNTH
 Q
SER ; select service
 S SRBPRG=1 D CURRENT^SRSBUTL
 R !!,"For what service ? (3-4 characters, do not use 'X' or '=')  ",SRSSER:DTIME I '$T!(SRSSER["^") G END
 I SRSSER="" G END
 I SRSSER["=" W !!,"You service abbreviation cannot include the equal sign." G SER
 I SRSSER'?3.4A W !!!,"Enter a 3 to 4 letter abbreviation for the service, i.e. card, gen, gi.",!! G SER
 I SRSSER["X"!(SRSSER["x") W !!,"Your service abbreviation cannot include the letter 'X'." G SER
 I $L(SRSSER)<3!($L(SRSSER)>4) W !!,"Abbreviation must be 3 to 4 characters. " G SER
 F SRMM=1:1:$L(SRSSER) I $E(SRSSER,SRMM)?1U S SRSSER=$E(SRSSER,0,SRMM-1)_$C($A(SRSSER,SRMM)+32)_$E(SRSSER,SRMM+1,999)
ROOM ; select operating room
 W !! K DIC S DIC="^SRS(",DIC(0)="QEAM",DIC("S")="I $$ORDIV^SROUTL0(+Y,$G(SRSITE(""DIV""))),('$P(^SRS(+Y,0),U,6))",DIC("A")="Select Operating Room: " D ^DIC K DIC G:Y'>0 END S SRSOR=+Y,SRBPRG=1
 I $D(^SRS("SER",SRSSER,SRSOR)) W !!,?5,"A Service Block for """,SRSSER,""" already exists. Please try agian." G SER
DATE ; select date to begin
 S %DT("A")="Select Starting Date: ",%DT="AEFX" W !! D ^%DT G:Y'>0 END S SRSDATE=Y I SRSDATE<DT W !!,"Past dates cannot be entered." G DATE
TIME ; select starting and ending times
 S (SRSBANG,SRSOUT)=0 D ^SRSTIME I SRSOUT G END
 ;
PAT W !!,"1. Every week, same time ",!,"2. Every other week ",!,"3. Every month, same day of week & week of month " R !!,"Select Number:  ",Z:DTIME I '$T!(Z["^") S SRSOUT=1 G END
 I Z["?" D HELP G PAT
 I Z<1!(Z>3) W !!,"Enter 1, 2, or 3." G PAT
 I Z>2 S X1=SRSDATE,X2=$E(SRSDATE,1,5)_"01" D ^%DTC S Z=X\7+3
 I Z>5 D MNTH Q:SRSOUT
 S SRSNUM=$P("0^8^1^2^3^4^5","^",Z),X1=SRSDATE,X2=2830103 D ^%DTC S SRSDAY=$P("MO^TU^WE^TH^FR^SA^SU","^",X#7+1),Y=0 I SRSNUM=8 S:X#2 SRSNUM=9
 S SRSST=$P(SRSTIME,"^"),SRSET=$P(SRSTIME,"^",2),SRSST=$E(SRSST,1,2)_"."_$E(SRSST,4,5),SRSET=$E(SRSET,1,2)_"."_$E(SRSET,4,5)
 S SRBFLG=1  ;;>>BEGIN 3*165-RJS
 D BLOCKED^SRSBUTL,CHK^SRSBUTL  ;;<<END 3*165-RJS
 S I="" F  S I=$O(^SRS("R",SRSDAY,SRSOR,I)) Q:I=""!SRSBANG  F J=0:1:9 I $D(^SRS("R",SRSDAY,SRSOR,I,J)) D CNG Q:SRSBANG
 G:SRSBANG&SRBFLG END  ;;<<3*165-RJS
 W !!,"Updating Schedules...",!
MUL2 ;
 K DIE,DR S DIE=131.7,DA=SRSOR,DR="8///"_SRSDAY,DR(2,131.703)="1///"_SRSSER,DR(3,131.704)="2////"_DUZ_";1///"_SRSST,DR(4,131.705)="2////"_SRSNUM_";1///"_SRSET D ^DIE K DR
 S SRSBOUT=DUZ_"^"_SRSDAY_"0^"_$P(SRSTIME,"^")_"^"_$P(SRSTIME,"^",2)_"^"_SRSSER,X=0
 I '$D(^SRS(SRSOR,"S",SRSDATE,1)) D S
 D UPDATE
CK1 I SRSNUM=0 S X=7 D UPDATE G:X CK1
CK2 I SRSNUM>7 S X=14 D UPDATE G:X CK2
CK0 I SRSNUM>0,(SRSNUM<5) S X5=$E(SRSDATE,4,5),X1=SRSDATE,X2=7 D C^%DTC S SRSDATE=X G:$E(X,4,5)=X5 CK0
CK3 I SRSNUM>0,(SRSNUM<5) S X=SRSNUM-1*7 D UPDATE G:X CK0
CK5 I SRSNUM=5 S X1=SRSDATE,X2=21 D C^%DTC S SRSDATE=X
CK4 I SRSNUM=5 S X1=SRSDATE,X2=7,X5=$E(SRSDATE,4,5) D C^%DTC S SRSDATE=X G:$E(SRSDATE,4,5)=X5 CK4 S X=-7 D UPDATE G:X CK5
 G END
UPDATE S X1=SRSDATE,X2=X D C^%DTC S SRSDATE=X D  Q
 .Q:$G(SRBCHK(SRSDATE))
 .D:$D(^SRS(SRSOR,"S",SRSDATE)) PATRN^SRSUTL S X=1 S:$O(^SRS(SRSOR,"S",SRSDATE))="" X=0
 Q
HELP W !!,"Enter '1' to create the blockout on the same day and time every week, '2' to",!,"create the blockout on the same day and time every other week, or '3' to "
 W !,"create the blockout for the same day of the week and week of the month only."
 Q
