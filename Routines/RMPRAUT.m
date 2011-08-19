RMPRAUT ;PHX/JLT-AUTO ADAPTIVE EQUIPMENT ;8/29/1994
 ;;3.0;PROSTHETICS;;Feb 09, 1996
LOOK D DIV4^RMPRSIT,HOME^%ZIS G:$D(X) END D GETPAT^RMPRUTIL G:'$D(RMPRDFN) END S RMPR45=$S($D(^RMPR(667,"AD",RMPRDFN)):$O(^RMPR(667,"AD",RMPRDFN,0)),1:"") S Y=RMPR45 D DD^%DT
 I Y'="" W !!,?20,"VAF21-4502 DATE: ",Y G EDT
 K Y,DA
 S DIR(0)="667,2" D ^DIR G:$D(DTOUT) END S:Y RMPR45=Y_U_"N"
ANK I $D(DIRUT),X'["^" S DIR(0)="667,2.1",DIR("A")="ANKLYOSIS OR VOC REHAB" D ^DIR G:$D(DUOUT) END S RMPRX=X K DIR I X="" W !!,?5,$C(7),"This is a required response.  Enter '^' to exit.",! G ANK
 K Y,DA,X
EDT S DIR(0)="667,3" D ^DIR G:$D(DTOUT)!($D(DIRUT)) END S RMPRC(1)=Y
 S DIR(0)="667,4" D ^DIR G:$D(DTOUT)!($D(DIRUT)) END S RMPRC(2)=Y
MAK S DIC=667.2,DIC(0)="AEQMZ",DIC("A")="MAKE: " D ^DIC G:+Y'>0!(X["^")!($D(DTOUT)) END G:X[""&(Y'>0) MAK S RMPRC(3)=$S(Y'=-1:+Y,1:"")
 K DIC,Y,DA S DIR(0)="667,6" D ^DIR G:$D(DTOUT)!($D(DIRUT)) END S RMPRC(4)=X
DPR S DIR("A")="VEHICLE ID#",DIR(0)="667,.01" D ^DIR G:$D(DTOUT)!($D(DIRUT)) END S RX=Y K DIR I $D(^RMPR(667,"B",RX)) F RA=0:0 S RA=$O(^RMPR(667,"B",RX,RA)) Q:RA'>0  I $D(^RMPR(667,RA,2)),$P(^(2),U) S RI=^RMPR(667,RA,0) D
 .S DFN=$P(RI,U,2) D ^VADPT W !!,"Patient: ",$E(VADM(1),1,30),?40,VA("PID"),!!,"Has Vehicle ID#: ",$P(RI,U,1)," As an active Vehicle of Record"
 .W !,?5,$C(7),"You must mark this Vehicle of Record Inactive before ",!,?5,"you can assign it to this Veteran.  Use the Edit/Delete",!,?5,"Vehicle of Record option to do so" S FLG=1
 I $D(FLG) G END
 K DIC,Y S X=RX S DIC="^RMPR(667,",DIC(0)="EQZL",DLAYGO=667 D ^DIC K DLAYGO G:+Y'>0 END
CHK S RMPRDA=+Y,(RC,RB,RF,RLP)=0,RA="" K Y,DA I '$D(^RMPR(667,"C",RMPRDFN)) G ROV
 D LP
 G:RC'>1 ROV K DIR S DIR(0)="Y",DIR("B")="YES"
 W !!,$C(7),?5,"There are currently two V.O.R in the last 4 yrs.",!,?5,"Are you going to apply the exception rule?"
EXP W ! D ^DIR I $D(DTOUT)!($D(DIRUT))!(Y=0) G DEL
ASK S RK=0 W ! D DSP
 W ! K DIR S DIR(0)="N",DIR("A")="Please Enter Vehicle of Record entry # to be dropped",DIR("?")="Selecting an entry will mark the Vehicle inactive"
 D ^DIR G:$D(DTOUT)!($D(DIRUT)) DEL I '$D(RAC(Y)) W $C(7) G ASK
 I $D(^RMPR(667,+RAC(Y),2)),$P(^(2),U)=0 W $C(7),!!,?5,"INACTIVE RECORD" G ASK
 L +^RMPR(667,+RAC(Y),0):1  I '$T W !,"Someone else is Editing this entry" G END
 S $P(^RMPR(667,+RAC(Y),2),U)=0 K RFL S RY=Y,FL=+RAC(Y) S DA=+RAC(Y),DIE="^RMPR(667,",DR="10" D ^DIE L -^RMPR(667,+RAC(RY),0) K DIE,DIC,Y,DA G FILE
ROV I $D(RAC),RF>1 W !!,$C(7),?5,"This Patient Currently has two Vehicles of Record.",!,?5,"Would you like to drop a Vehicle?" S DIR(0)="Y",DIR("B")="YES" G EXP
FILE K DIR,Y S DIR(0)="667,7^^K:Y<RMPRC(1) X" D ^DIR G:$D(DTOUT)!($D(DIRUT)) DEL S RMPRC(5)=Y
 K DIR,Y S DIR(0)="667,2.2" D ^DIR G:$D(DTOUT)!($D(DIRUT)) DEL S RMPRC(6)=Y
 K DIR,Y S DIR(0)="667,2.3" D ^DIR G:$D(DTOUT)!($D(DIRUT)) DEL S RMPRC(7)=Y
 S RMPRC(8)="" I RMPRC(7)=4 K DIR,Y S DIR(0)="667,2.4" D ^DIR I +Y S RMPRC(8)=Y
 S $P(^RMPR(667,RMPRDA,0),U,2)=RMPRDFN S:$D(RMPRX) $P(^(0),U,9)=RMPRX S:$P(RMPR45,U,2)="N" $P(^(0),U,3)=$P(RMPR45,U)
 S $P(^RMPR(667,RMPRDA,0),U,4)=RMPRC(1),$P(^(0),U,5)=RMPRC(2),$P(^(0),U,6)=RMPRC(3),$P(^(0),U,7)=RMPRC(4),$P(^(0),U,8)=RMPRC(5),$P(^(0),U,10)=RMPR("STA")
 S ^RMPR(667,RMPRDA,2)=1_"^"_RMPRC(6)_"^"_RMPRC(7)_"^"_RMPRC(8)
 S DA=RMPRDA,DIK="^RMPR(667," D IX1^DIK K Y,DA,FL
 K DIR S DIR(0)="Y",DIR("A")="Would you like to enter the Auto adaptive equipment now"
 D ^DIR G:$D(DTOUT)!($D(DIRUT))!(Y=0) END
 W ! K DIR,Y S DIR(0)="S^A:21B;V:21A",DIR("A")="Enter 'A' for Adaptive items, 'V' for Van Mods" D ^DIR G:$D(DTOUT)!($D(DIRUT)) END S RMPRAM=Y(0) K DIR G ENT^RMPRAVR
END D:'$D(DTOUT) LINK^RMPRS
 K DA,DIK,J,RMPRDA,REX,DIC,DIR,RMPR45,RMPRDFN,RMPRC,RAC,RZ,RB,RC,RA,X,RFL,FL,RF,RK,RD,RMPR45,RMPRAM,RMPRDFN,RMPRR,RE,DIR,DIRUT,DUOUT,RLP,RMPRDOB,RMPRNAM,RMPRSSN,RMPRDOD,FLG Q
DEL S DA=RMPRDA,DIK="^RMPR(667," D ^DIK W !!,$C(7),"Deleted..." S:$D(FL) ^RMPR(667,+FL,2)=1 D END
 Q
DSP S RK=$O(RAC(RK)) Q:RK'>0  S RA=RAC(RK) W !,RK W:$P(RA,U,3) ?3,$E($P(^DPT($P(RA,U,3),0),U),1,20),"   ",$P(RA,U,2) W:$P(RA,U,7) ?45,$E(^RMPR(667.2,$P(RA,U,7),0),1,10) W ?50,$E($P(RA,U,8),1,5) S Y=$P(RA,U,9) D DD^%DT W ?57,Y
 I $D(^RMPR(667,+RAC(RK),2)) W ?69 W $S(+^(2)=1:"ACTIVE",1:"INACTIVE")
 G DSP
LP S RB=$O(^RMPR(667,"C",RMPRDFN,RB)) Q:RB'>0  S REX=$S($D(^RMPR(667,RB,2)):$P(^(2),U),1:0)
 I $P(^RMPR(667,RB,2),U)=1 S:$P(^RMPR(667,RB,0),U,8)'="" RZ=+$P(^(0),U,8) S RD=DT-RZ S:RD'>40000&(REX=1) RC=RC+1 S:REX=1 RF=RF+1 S RLP=RLP+1,RAC(RLP)=RB_"^"_^(0)
 G LP
