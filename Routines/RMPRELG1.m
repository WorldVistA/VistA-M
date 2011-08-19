RMPRELG1 ;PHX/RFM/JLT-DISPLAY ELIGIBILITY FIRST PAGE ;8/29/1994
 ;;3.0;PROSTHETICS;**45**;Feb 09, 1996
 D HOME^%ZIS,DIV4^RMPRSIT  G:$D(X) EXIT S DIC(0)="AEMQ",DIC="^DPT(" D ^DIC G:Y<0 EXIT S DFN=+Y D DEM^VADPT S RMPRNAM=VADM(1),RMPRSSN=$P(VADM(2),U,2) K VADM D DEM^VADPT,ELIG^VADPT,ADD^VADPT,OAD^VADPT S RMPRCNUM=VAEL(7) W @IOF
 W $E(RMPRNAM,1,20),?23,"SSN: ",$P(VADM(2),U,2),?42,"DOB: ",$P(VADM(3),U,2),?61,"CLAIM# ",RMPRCNUM
 W !!,"Phone: ",VAPA(8),?40,"Phone: ",VAOA(8),!,"Current Address:",?40,"Primary Next of Kin Address:",!,VAPA(1),?40,VAOA(1)
 W:VAPA(2)'="" !,VAPA(2) W:VAPA(2)=""&(VAPA(3)'="") !,VAPA(3) W:VAPA(2)=""&(VAPA(3)="") !,VAPA(4),",",$P(VAPA(5),U,2)," ",VAPA(6)
 W:VAOA(4)'="" ?40,VAOA(4),",",$P(VAOA(5),U,2)," ",VAOA(6) W:VAPA(2)'=""&(VAPA(3)'="") !,VAPA(3),?40,"Name: ",VAOA(9) W:VAOA(2)'=""&(VAOA(3)="") !,VAPA(4),",",$P(VAPA(5),U,2)," ",VAPA(6)
 W:VAPA(2)=""&(VAPA(3)="")&(VAOA(9)'="") !?40,"Name: ",VAOA(9)
 W:VAPA(2)'=""&(VAPA(3)'="") !,VAPA(4),",",$P(VAPA(5),U,2)," ",VAPA(6),?40,"Relationship: ",VAPA(10)
 I VAOA(10)'="" W:VAPA(2)=""&(VAPA(3)'="")!(VAPA(2)="")&(VAPA(3)="") !?40,"Relationship: ",VAOA(10) K VAPA,VAOA
 W !!,"Patient Type: ",$P(VAEL(6),U,2),?40,"Period of Service: ",$P(VAEL(2),U,2),!,"Primary Eligibility Code:",?40,"Status: ",$P(VAEL(9),U,2),!,$P(VAEL(1),U,2)
 W ?40,"Eligibility Status: ",$E($P(VAEL(8),U,2),1,19) K VAEL D MB^VADPT W !!,"Receiving A&A Benefits? " W:VAMB(1)=0 "NO" W:$P(VAMB(1),U,1)=1 $P(VAMB(1),U,2)
 W ?40,"Receiving Housebound Benefits? " W:VAMB(2)=0 "NO" W:$P(VAMB(2),U,1)=1 $P(VAMB(2),U,2)
 W !,"Receiving Social Security? " W:VAMB(3)=0 "NO" W:$P(VAMB(3),U,1)=1 $P(VAMB(3),U,2) W ?40,"Receiving VA Pension? " W:VAMB(4)=0 "NO" W:$P(VAMB(4),U,1)=1 $P(VAMB(4),U,2)
 W !,"Receiving Military Retirement? " W:VAMB(5)=0 "NO" W:$P(VAMB(5),U,1)=1 $P(VAMB(5),U,2) W ?40,"Receiving VA Disability? " W:VAMB(7)=0 "NO" W:$P(VAMB(7),U,1)=1 $P(VAMB(7),U,2) K VAMB
 I $Y>18 D QUEST2 W @IOF
 S RO=0 F I=0:0 S RO=$O(^DPT(DFN,.372,RO)) W:'$D(RMPRL) !!,"Patient Name: ",VADM(1),?40,"SSN: ",$P(VADM(2),U,2),!!,"MAS Disability Code(s):" Q:RO'>0  D WRI
 D SVC^VADPT W !!,"*POW? ",$S(VASV(4)=1:"YES",VASV(4)=0:"NO") K VASV
 S FL=1 K RMNOQUIT G QUES
WRI ;WRITES MAS DISABILITY CODES
 I $Y>19 D QUEST1
 W !,$E($P(^DIC(31,$P(^DPT(DFN,.372,RO,0),U,1),0),U,1),1,30),?40,"Disability% ",$P(^DPT(DFN,.372,RO,0),U,2),?56," Service Connected? " W:$P(^DPT(DFN,.372,RO,0),U,3)=1 "YES" W:$P(^DPT(DFN,.372,RO,0),U,3)=0 "NO" S RMPRL=1 Q
 ;D:$P($G(^DPT(DFN,.372,RO,0)),U,1)>0&(RO'="")  Q
 ;.N RMPRTEM S RMPRTEM=$P(^DPT(DFN,.372,RO,0),U,1) I $P($G(^DIC(31,RMPRTEM,0)),U,1)="" W !!,"'",RMPRTEM,"'"," Is a non-existent code ; Check the MAS disability codes on this patient." S RMPRL=1 Q
 ;.W !,$E($P(^DIC(31,$P(^DPT(DFN,.372,RO,0),U,1),0),U,1),1,30),?40,"Disability% ",$P(^DPT(DFN,.372,RO,0),U,2),?56," Service Connected? " W:$P(^DPT(DFN,.372,RO,0),U,3)=1 "YES" W:$P(^DPT(DFN,.372,RO,0),U,3)=0 "NO" S RMPRL=1 Q
QUES K RMPRFLG,RMPRL F  Q:$Y>18  W !
 W ! R "Enter `^`to exit, or `return` to continue: ",ANS:DTIME G:'$T EXIT G:ANS="" ^RMPRELG2 G:ANS["^" EXIT
 W " ??",!!,$C(7) G QUES
EXIT ;KILL VARIABLES AND EXIT ROUTINE
 K FL,DIC,VA,RNSK D KVAR^VADPT
 K RMPRCNUM,RMPRCOMB,KILL,VAERR,VADM,VASV,VAOA,VAPA,FLG,ANS,DFN,RMPRDFN,RMPRDOB,RMPRNAM,RMPRSSN,Y
 Q
QUEST1 ;DO PAGE BREAK IF CURSOR AT LINE 18
 N DIR
 W !
 S DIR(0)="FAO^0:0",DIR("A")="Enter `return` to continue" D ^DIR:DTIME
 I Y'="" W !,"YOU MUST ENTER `RETURN` TO FINISH VIEWING MAS DISABILITY CODES" G QUEST1
 W @IOF W !!,"Patient Name: ",$E(VADM(1),1,20),?40,"SSN:",$P(VADM(2),U,2),!!,"MAS Disability Codes continued: "
 Q
QUEST2 ;PRINT MAS DISABILITY CODES ON NEXT PAGE IF TOO MANY TO ALL FIT.
 N DIR K DIR S DIR(0)="FAO^0:0" D ^DIR:DTIME
 Q:'$T
 S RMNOQUIT=1
 I X="^" S RMNOQUIT=0 Q
 I X'="" W !,"Press `RETURN` to continue." G QUEST2
 I X="" W @IOF S RMNOQUIT=1 Q
