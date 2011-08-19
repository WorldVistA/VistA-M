ESPMNI1 ;DALISC/CKA - MASTER NAME INPUT-PART 2;5/92
 ;;1.0;POLICE & SECURITY;**14**;Mar 31, 1994
CONT ;CONTINUE MASTER NAME INPUT
 S ESPJ=1
AKA S DIR(0)="910.01,.01" D ^DIR K DIR G:$D(DUOUT)!($D(DTOUT)) NOU G:$D(DIRUT)&($E(Y)'="^") REM S ESPAKA(ESPJ)=Y I Y["^" D NO G AKA
YN S DIR(0)="Y",DIR("A")="Do you want to enter another AKA",DIR("B")="NO" D ^DIR K DIR
 G:$D(DTOUT) NOU
 I Y'=1&(Y'=0) W !!,$C(7),?5,"You must enter Yes or No." G YN
 I Y S ESPJ=ESPJ+1 G AKA
REM W !,"REMARKS: " S DIC="^TMP("_$J_",""MNI""," D EN^DIWE
 ;DISPLAY INFO BEFORE UPDATE
DISP W !!,"Name: ",ESPD(.01),?40,"SSN: ",$S(ESPD(.02,"P")]"":ESPD(.02,"P"),1:ESPD(.02)),!,"DOB: ",ESPD(.03,"P"),?25,"SEX: ",ESPD(.08),?35,"RACE: ",ESPD(.09,"P")
 W !,"Height: ",ESPD(3.01),?15,"Weight: ",ESPD(3.02)
 W !,"Hair Color: ",ESPD(3.03,"P"),?35,"Eye Color: ",ESPD(3.04,"P"),?60,"Skin Tone: ",ESPD(3.05,"P")
 W !,"Scars/Marks: ",ESPD(3.06)
 W !,"DL#: ",ESPD(.1),?25,"STATE: ",ESPD(.11,"P"),!,"CATEGORY: ",ESPD(.04,"P")
 I ESPD(.04)'="E" W !,"Place of Employment: ",ESPD(.06),!,"Work Address: ",ESPD(2.01),!,"Work Address [line 2]: ",ESPD(2.02),!,"City: ",ESPD(2.03),?25,"State: ",ESPD(2.04,"P"),?65,"Zip: ",ESPD(2.05)
 I ESPD(.04)="E" W !,"Service: ",ESPD(.05,"P"),?60,"ID: ",ESPD(.07)
 W !,"Office Phone: ",ESPD(2.06),!,"Home Address: ",ESPD(1.01),!,"Home Address [line 2]: ",ESPD(1.02),!,"City: ",ESPD(1.03),?25,"State: ",ESPD(1.04,"P"),?65,"Zip: ",ESPD(1.05),!,"Home Phone: ",ESPD(1.06)
 F ESPJ=1:1 Q:'$D(ESPAKA(ESPJ))  W !,"ALIAS ",ESPJ,": ",ESPAKA(ESPJ)
 K ^UTILITY($J,"W") S DIWL=10,DIWR=70,DIWF="W" W !,"REMARKS: "
 S IEN=0 F ESPJ=0:0 S IEN=$O(^TMP($J,"MNI",IEN)) Q:IEN'>0  S X=^(IEN,0) D ^DIWP
 D ^DIWW
OK ;UPDATE WILL BEGIN NOW
 D:$D(XRTL) T0^%ZOSV ; START
STUFF W !!!,"Updating",!! K DD,DO S DIC="^ESP(910,",DIC(0)="L",DLAYGO=910,X=ESPD(.01) D FILE^DICN S ESPFN=+Y I '$P(Y,U,3) W !,$C(7),"This entry already exists!" G NOU
 L +^ESP(910,ESPFN):1 I '$T W !,"Another user is editing this record!!" G NOU
 S ^ESP(910,ESPFN,0)=ESPD(.01)_"^"_ESPD(.02)_"^"_ESPD(.03)_"^"_ESPD(.04)_"^"_ESPD(.05)_"^"_ESPD(.06)_"^"_ESPD(.07)_"^"_ESPD(.08)_"^"_ESPD(.09)_"^"_ESPD(.1)_"^"_ESPD(.11)
 S ^ESP(910,ESPFN,1)=ESPD(1.01)_"^"_ESPD(1.02)_"^"_ESPD(1.03)_"^"_ESPD(1.04)_"^"_ESPD(1.05)_"^"_ESPD(1.06),^(2)=ESPD(2.01)_"^"_ESPD(2.02)_"^"_ESPD(2.03)_"^"_ESPD(2.04)_"^"_ESPD(2.05)_"^"_ESPD(2.06)
 S ^ESP(910,ESPFN,3)=ESPD(3.01)_"^"_ESPD(3.02)_"^"_ESPD(3.03)_"^"_ESPD(3.04)_"^"_ESPD(3.05)_"^"_ESPD(3.06)
SAKA S:$O(ESPAKA(0)) ^ESP(910,ESPFN,10,0)="^910.01^" K DD,DO S DIC="^ESP(910,"_ESPFN_",10,",DIC(0)="L",DLAYGO=910,DA(1)=ESPFN F ESPJ=1:1 Q:'$D(ESPAKA(ESPJ))  S X=ESPAKA(ESPJ) D FILE^DICN
SREM S %X="^TMP("_$J_",""MNI"",",%Y="^ESP(910,"_ESPFN_",20," D %XY^%RCR K ^TMP($J,"MNI")
XR S DIK="^ESP(910,",DA=ESPFN D IX1^DIK K DIK,DA
 W !,"Done",!!
 L -^ESP(910,ESPFN)
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; STOP
 D FDISP^ESPMNI2
EXIT W:$D(DTOUT) $C(7)
 K %X,%Y,DA,DD,DIC,DIK,DIR,DIRUT,DIWF,DIWL,DIWR,DO,DUOUT,ESPAKA,ESPD,ESPDOB,ESPJ,ESPNO,IEN,X,Y,^TMP($J,"MNI")
 Q:$D(DTOUT)
 G:ESPVAR=1 EN^ESPMNI
 G:ESPVAR=2 NUM^ESPVREG
 D:ESPVAR=3 RET
 D:ESPVAR=4 RETV
QUIT QUIT
NOU W !!,$C(7),?20,"NO UPDATING HAS OCCURRED!!!",!! K ESPAKA,ESPD,^TMP($J,"MNI") G:$D(DTOUT) EXIT G EN^ESPMNI
NO W $C(7),!!?5,"NO ^'S ALLOWED!",!! Q
RETV W !,"Now returning to the Violation Notice!"
 Q
RET W !,"Now returning to the Offense Report!"
 Q
