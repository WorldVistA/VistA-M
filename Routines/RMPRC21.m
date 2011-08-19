RMPRC21 ;PHX/HNB-CANCEL A 1358 PROSTHETIC REQUEST ;8/29/1994
 ;;3.0;PROSTHETICS;**62**;Feb 09, 1996
 ;
 ; RVD patch # 62 - call pce delete if PCE was recorded and cancelled.
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;entry point for Cancel a Transaction Option
 D DIV4^RMPRSIT G:$D(X) EXIT
 S PRCS("A")="Select OBLIGATION NUMBER: " D EN1^PRCS58 G:Y=-1 EXIT
 S RMPROB=$P(Y,U,2),RMPR("OB")=$P(Y(0),U,1)
 S DIC("A")="Select TRANSACTION: "
 S DIC("S")="S R90=^(0) I $P(R90,U,3)=RMPR(""OB""),('$P(R90,U,5)&'$P(R90,U,8)),($P(R90,U,14)=RMPR(""STA""))" I RMPRSITE=1 S DIC("S")=DIC("S")_"!($P(R90,U,14)="""")"
 S DIC="^RMPR(664,",DIC(0)="AEQM",DIC("W")="D EN2^RMPRD1"
 D ^DIC G:Y<0 EXIT S RMPRA=+Y K R90
CL S B2=^RMPR(664,RMPRA,0) G:$P(B2,U,8) M4 G:$P(B2,U,5) M6
 L +^RMPR(664,RMPRA,0):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" G EXIT
 K DIC,Y,DA S X=$P(B2,U,7),DIC=424,DIC(0)="MZ"
 D ^DIC S $P(B2,U,7)=+Y
 S RMPRDFN=$P(^RMPR(664,RMPRA,0),U,2),RMPRWO=$P(^(0),U,15),RMPRDA=$P(^(0),U,17),RMPRNAM=$P(^DPT(RMPRDFN,0),U,1),RMPRSSN=$P(^(0),U,9)
 D ^RMPRLI
A W !!,"Do you really want to CANCEL this Transaction" S %=0 D YN^DICN G:%<0!(%=2) EXIT G:%=0 H
 S RMPRAR=$S($P(^RMPR(664,RMPRA,0),U,12)'="":$P(^(0),U,12),1:""),$P(^(0),U,12)=""
 D:RMPRAR'="" K660
 Q:$G(RMPRA)'>0
 S R1=0 F  S R1=$O(^RMPR(664,RMPRA,1,R1)) Q:R1'>0  S RMPRAR=$S($P(^RMPR(664,RMPRA,1,R1,0),U,13)'="":$P(^(0),U,13),1:""),$P(^(0),U,13)="" G:RMPRAR="" M3 D K660
C58 ;CLOSE OUT IFCAP DAILY RECORD
 I $D(RMPRWO),RMPRWO D  D CA0^RMPR29M(RMPRDA,RMPRA)
 .S $P(^RMPR(664.2,RMPRWO,0),U,16,17)="" F DA=0:0 S DA=$O(^RMPR(664.2,RMPRWO,1,"AC",RMPRA,DA)) Q:DA'>0  S DIK="^RMPR(664.2,"_RMPRWO_",1,",DA(1)=RMPRWO D ^DIK
 I $P(B2,U,7)'>0 W !,$C(7),"DID NOT HAVE AN IFCAP DAILY RECORD" G K664
 D NOW^%DTC S PRCSX=$P(B2,U,7)_U_%_U_0_U_"Canceled"_U_1 D ^PRCS58CC
 I +Y=0 W !,$C(7),$C(7),"FAILED TO CLOSE IFCAP DAILY RECORD FOR THE FOLLOWING REASON ",$P(Y,U,2),!,"PLEASE CONTACT YOUR APPLICATION COORDINATOR!"
 G K664
K660 ;DELETE APPLIANCE/REPAIR RECORDS
 D SS660 Q:$G(RMPRAR)'>0
 ;modified by #62
 ;call pce delete if patient encounter was recorded
 I $D(^RMPR(660,RMPRAR,10)),$P(^RMPR(660,RMPRAR,10),U,12) D
 .S RMCHK=0
 .S RMCHK=$$PCED^RMPRPCEP(RMPRAR)
 ;
 S DA=RMPRAR,DIK="^RMPR(660," D ^DIK W "."
 K RMPRAR
 Q
SS660 ;set new status in 660.5
 W !!,"CANCELLING THE OBLIGATION!"
 I $G(RMPRF)'>0 S RMPRF=$P($G(^RMPR(664,RMPRA,2)),U,4)
 Q
K664 ;CANCEL FLAG
 S $P(^RMPR(664,RMPRA,0),"^",5)=DT,$P(^RMPR(664,RMPRA,2),"^",2)=DUZ
 S DA=RMPRA,DR="3.1",DIE="^RMPR(664," D ^DIE W !,$C(7),$C(7),"Transaction Canceled and Deleted..." D LINK^RMPRS
 ;
EXIT L:$D(RMPRA) -^RMPR(664,RMPRA,0)
 K LINE,PRCSCPAN,PRCSIP,RMPR("OB"),RMPRAMIS,RMPRA,RMPRAR,RMPRCNT
 K RMPRI,RMPRIT,RMPRIT1,RMPRU,RMPRX,X,PRCS,DIE,PRCSX,RMPRDFN,RMPRNAM
 K RMPROB,RMPRSSN,DR,PRC,RMPRC,DIC,DIK,%,R1,DA,B2,RMPRCK,DIC
 K DIK,I,Y,RAC,R90,RMPRN,^TMP($J)
 Q
H W !,"By entering Yes, this will Delete the transaction in Prosthetics, and Cancel the Transaction in IFCAP." G A
H2 W !,"By entering Yes, this will Cancel the Transaction in IFCAP,and NOT UPDATE the 10-2319." G M3A
M3 W !,$C(7),$C(7),"TRANSACTION MISSING APPLIANCE/REPAIR RECORD!"
M3A W !,"Do you still want to CANCEL this Transaction" S %=0 D YN^DICN G:%<0!(%=2) EXIT G:%=0 H2 G C58
M4 W !,$C(7),$C(7),"This Transaction has already been Closed!" G EXIT
M6 W !,$C(7),$C(7),"This transaction has already been Canceled!" G EXIT
