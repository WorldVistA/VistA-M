RMPR4C21 ;PHX/HNB-CANCEL A PURCHASE CARD TRANSACTION;3/1/1996
 ;;3.0;PROSTHETICS;**3,20,62,140**;Feb 09, 1996;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;RVD patch #62 - pce interface
 ;
EN ;entry point for Cancel a Transaction Option
 D DIV4^RMPRSIT G:$D(X) EXIT
 W !!,"You may also make a selection by Purchase Card Transaction"
 W !,"(Example, PC number), or Bank Authorization Number (6 digit number).",!
 S DIC("A")="Select PATIENT: "
 S DIC("S")="I $D(^(4)) I ('$P(^(0),U,8)&'$P(^(0),U,5)),($P(^(0),U,14)=RMPR(""STA""))"
 S DIC="^RMPR(664,",DIC(0)="AEQMN",DIC("W")="D EN2^RMPR4D1"
 D ^DIC G:Y<0 EXIT S RMPRA=+Y K R90
CL S B2=^RMPR(664,RMPRA,0) G:$P(B2,U,8) M4 G:$P(B2,U,5) M6
 L +^RMPR(664,RMPRA,0):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" G EXIT
 K DIC,Y,DA S X=$P(B2,U,7),DIC=424,DIC(0)="MZ"
 D ^DIC S $P(B2,U,7)=+Y
 S RMPRDFN=$P(^RMPR(664,RMPRA,0),U,2),RMPRWO=$P(^(0),U,15),RMPRDA=$P(^(0),U,17)
 S DFN=RMPRDFN D DEM^VADPT
 S RMPRSSNE=VA("PID")
 D ^RMPR4LI
A W !!,"Do you really want to CANCEL this Transaction" S %=0 D YN^DICN G:%<0!(%=2) EXIT G:%=0 H
 ;call IFCAP to cancel
 S X=1
 S RMPR442=$P($G(^RMPR(664,RMPRA,4)),U,6)
 I RMPR442="" G BYPASS
 I $P($G(^PRC(442,RMPR442,7)),U)=45 W !!,"Purchase Card CANCELLED in IFCAP, will cancel open Pros PC order, hit return" R X:10 G BYPASS
 D CAN^PRCH7B(.X,RMPRA,RMPR442,0)
 I X="^" W !!,"NOT CANCELED You must say YES to 'Approve and print Amendment number'" G EXIT
 K RMPR442,X
BYPASS S RMPRAR=$S($P(^RMPR(664,RMPRA,0),U,12)'="":$P(^(0),U,12),1:""),$P(^(0),U,12)=""
 D:RMPRAR'="" K660
 Q:$G(RMPRA)'>0
 S R1=0 F  S R1=$O(^RMPR(664,RMPRA,1,R1)) Q:R1'>0  S RMPRAR=$S($P(^RMPR(664,RMPRA,1,R1,0),U,13)'="":$P(^(0),U,13),1:""),$P(^(0),U,13)="" G:RMPRAR="" M3 D K660
C58 ;CLOSE OUT
 I $D(RMPRWO),RMPRWO D  D CA0^RMPR29M(RMPRDA,RMPRA)
 .S $P(^RMPR(664.2,RMPRWO,0),U,16,17)="" F DA=0:0 S DA=$O(^RMPR(664.2,RMPRWO,1,"AC",RMPRA,DA)) Q:DA'>0  S DIK="^RMPR(664.2,"_RMPRWO_",1,",DA(1)=RMPRWO D ^DIK
 ;
 G K664
K660 ;DELETE APPLIANCE/REPAIR RECORDS
 D SS660 Q:$G(RMPRAR)'>0
 ;modified by #62
 ;call pce delete if patient encounter was recorded
 I $D(^RMPR(660,RMPRAR,10)),$P(^RMPR(660,RMPRAR,10),U,12) D
 .S RMCHK=0
 .S RMCHK=$$PCED^RMPRPCEP(RMPRAR)
 S DA=RMPRAR,DIK="^RMPR(660," D ^DIK W "."
 K RMPRAR
 Q
SS660 ;
 ;
 Q
K664 ;CANCEL FLAG
 S $P(^RMPR(664,RMPRA,0),"^",5)=DT,$P(^RMPR(664,RMPRA,2),"^",2)=DUZ
 S DA=RMPRA,DR="3.1",DIE="^RMPR(664," D ^DIE
 W !,$C(7),$C(7),"Transaction Canceled and Deleted..." H 2 D LINK^RMPRS
 ;
EXIT L:$D(RMPRA) -^RMPR(664,RMPRA,0)
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 K LINE,RMPRAMIS,RMPRA,RMPRAR,RMPRCNT
 K RMPRI,RMPRIT,RMPRIT1,RMPRU,RMPRX,X,PRCS,DIE,PRCSX,RMPRDFN,RMPRNAM
 K RMPRSSN,DR,PRC,RMPRC,DIC,DIK,%,R1,DA,B2,RMPRCK,DIC
 K DIK,I,Y,RAC,R90,RMPRN,^TMP($J)
 Q
H W !,"By entering Yes, will Delete the transaction in Prosthetics." G A
H2 W !,"By entering Yes, will Cancel the Transaction , and NOT UPDATE the 10-2319." G M3A
M3 W !,$C(7),$C(7),"TRANSACTION MISSING APPLIANCE/REPAIR RECORD!"
M3A W !,"Do you still want to CANCEL this Transaction" S %=0 D YN^DICN G:%<0!(%=2) EXIT G:%=0 H2 G C58
M4 W !,$C(7),$C(7),"This Transacion has already been Closed!" G EXIT
M6 W !,$C(7),$C(7),"This transaction has already been Canceled!" G EXIT
