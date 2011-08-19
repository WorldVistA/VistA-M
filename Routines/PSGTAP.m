PSGTAP ;BIR/CML3-SEND PICK LIST TO TRAVENOL'S ATC 212 (DRIVER) ; 05 May 98 / 10:25 AM
 ;;5.0; INPATIENT MEDICATIONS ;**10**;16 DEC 97
 ;
EN ;
 D ENCV^PSGSETU I $D(XQUIT) Q
 ;
ASK ;
 R !!,"Select WARD GROUP or PICK LIST: ",X:DTIME W:'$T $C(7) S:'$T X="^" G:"^"[X OUT I X=+X D NL G:'$D(X) ASK I Y D EN1 G ASK
 I X?1."?" W !!?2,"Select a Ward Group for which a pick list has been run that you wish to send",!,"to the ATC.",!?2,"You may also directly select a Pick List by number, which prints in the upper",!,"left corner of each pick list." G ASK
 K DIC S DIC="^PS(57.5,",DIC(0)="EIMQZ",DIC("S")="I $P(^(0),""^"",2)=""P""" D ^DIC K DIC I Y S PSGPLWG=+Y,PSGPLGF="A" D AD I $D(X) F  D ^PSGPLG Q:'PSGPLG  D EN1 Q:OK
 G ASK
 ;
OUT ;
 D ENKV^PSGSETU K A,BLKS,C,D,DAT,DIC,G,I1,I2,ND,O,P,PID,PL,PN,PND,PSGIOP,PSGPLG,PSGPLGF,PSGPLWG,PSGPLWGN,PSGSPD,Q,QUIT,R,S,ST,T,TM,W
 Q
 ;
EN1 ;
 S OK=0 I '$$LOCK^PSGPLUTL(PSGPLG,"PSGTAP") W $C(7),!!,"This PICK LIST is currently being accessed by another task." Q
 I $P($G(^PS(53.5,PSGPLG,0)),"^",12) S PSGID=$P(^(0),"^",12),PSGOD=$$ENDTC^PSGMI(PSGID) D  I Y<1 D EN2 Q
 .W !! S DIR(0)="Y^A",DIR("A")="Pick List #"_PSGPLG_" was queued to the ATC for "_PSGOD_".  Send again",DIR("B")="N" D ^DIR K DIR
 S X=$G(^PS(53.5,PSGPLG,0)),Y=$O(^(0))="",X=$P(X,"^",11)&'$P(X,"^",9),%=1
 I X!Y W $C(7) F  W !!,"THIS PICK LIST HAS NO",$S(Y:" DATA.",1:"T RUN TO COMPLETION."),!,"Do you wish to continue" S %=2 D YN^DICN G:% EN2 W !!?2,"Enter 'YES' to send this pick list to the ATC.  Enter 'NO' (or '^') to not",!,"send it."
 G:%'=1 EN2 K %ZIS S %ZIS="NQ",PSGION=ION,IOP="`"_PSGIOP_";255" D ^%ZIS I POP S IOP=PSGION D ^%ZIS K IOP W $C(7),!!?10,"THE ATC MACHINE IS NOT FOUND!" G EN2
 S PSGTAPR=0 I $D(^PS(53.55,PSGPLG,0)),$P(^(0),"^",2),$O(^(1,0)) F  W !!,"This pick list had been previously started, but did not run to completion.",!,"Do you want to restart it where it left off" S %=0 D YN^DICN I 1 Q:%  D
 .W !!?2,"Enter 'YES' to restart the pick list from where it previously stopped.  Enter",!,"'NO' to start this pick list from the beginning." W:%Y'?1."?" "  (A response is required.)"
 I  G:%<0 EN2 S PSGTAPR=%=1
 S X=0,X=$O(^PS(59.7,X)),PSGTIR=$S($P($G(^(X,26)),"^",2)=1:"ENQ^PSGTAP1",1:"ENQ^PSGTAP0")
 K PSGTID,ZTSAVE S ZTDESC="PICK LIST TO ATC",(ZTSAVE("PSGPLG"),ZTSAVE("PSGSPD"),ZTSAVE("PSGTAPR"),ZTSAVE("PSGPLWG"))="" D ENTSK^PSGTI
 I $D(ZTSK) W "...SENT!" S OK=1 I $D(ZTSK("D"))#2 S %H=ZTSK("D") D YMD^%DTC S $P(^PS(53.5,PSGPLG,0),"^",12)=X+%
 ;
EN2 ;
 I $D(PSGPLG) D UNLOCK^PSGPLUTL(PSGPLG,"PSGTAP")
 Q
 ;
NL ; numeric look-up
 S Y=$G(^PS(53.5,X,0)) I $S('Y:1,'$P(Y,"^",2):1,1:'$D(^PS(53.5,"AB",$P(Y,"^",2),+$P(Y,"^",3),X))) S Y=0 Q
 S PSGPLG=X,X=^PS(53.5,PSGPLG,0),Y=$$ENDTC^PSGMI($P(X,"^",3)),PSGPLWG=$P(X,"^",2),PSGPLWGN=$S('$D(^PS(57.5,PSGPLWG,0)):PSGPLWG_";PS(57.5,",$P(^(0),"^")]"":$P(^(0),"^"),1:PSGPLWG_";PS(57.5,"),PSGOD=$$ENDTC^PSGMI($P(X,"^",4))
 W !?5,"Ward Group: ",PSGPLWGN,!?5,Y,"  thru  ",PSGOD
 ;
AD ; ATC device
 S X=$G(^PS(57.5,PSGPLWG,3)) I $P(X,"^",3)="" W $C(7),!!?3,"THIS WARD GROUP DOES NOT HAVE AN ATC DEVICE DESIGNATED FOR IT." K X
 S:$D(X) PSGIOP=$P(X,"^",3),PSGSPD=$P(X,"^",2),Y=1 Q
