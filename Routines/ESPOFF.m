ESPOFF ;DALISC/CKA - OFFENSE REPORT INPUT;3/99
 ;;1.0;POLICE & SECURITY;**9,12,27,39**;Mar 31, 1994
EN ;
 D DT^DICRW S ESPVAR=3
 I '$D(DUZ(2)) W !!,"SITE # IS NOT DEFINED." G EXIT
DTR S NOUPD=0 W !! S DIR(0)="DO^::ETXR",DIR("A")="DATE/TIME RECEIVED",DIR("?")="^W !!,?10,""Enter the  date and time the complaint is received.  You must enter a time."" S %DT=""ETXR"" D HELP^%DTC"
 D ^DIR K DIR G:$D(DIRUT) EXIT S ESPDTR=Y
LKUP S DIC="^ESP(912,",DIC(0)="XMZ" D ^DIC K DIC S ESPY=+Y
 I Y>0 D MSG G NOUPD
FAC S ESPX=".07" D RD G:$D(DUOUT)!($D(DTOUT)) NOUPD S ESPD(.07)=+Y
 S ESPN=1
CL S DIR(0)="912.01,.01",DIR("A")="CLASSIFICATION CODE" D ^DIR K DIR G:$D(DUOUT)!($D(DTOUT)) NOUPD G:$D(DIRUT) DTO
 S (ESPCL(ESPN),ESPS)=+Y S:'+Y ESPCL(ESPN)=""
 I '$O(^ESP(912.8,"AC",ESPS,0)) G SCL
TYPE S DIR(0)="912.01,.02",DIR("A")="TYPE" D ^DIR K DIR G:$D(DUOUT)!($D(DTOUT)) NOUPD
 S $P(ESPCL(ESPN),U,2)=+Y,ESPS=+Y_"^"_ESPS S:'+Y $P(ESPCL(ESPN),U,2)=""
 I '$O(^ESP(912.9,"AC",+Y,0)) G SCL
SUB S DIR(0)="912.01,.03",DIR("A")="SUBTYPE" D ^DIR K DIR G:$D(DUOUT)!($D(DTOUT)) NOUPD
 S $P(ESPCL(ESPN),U,3)=+Y S:'+Y $P(ESPCL(ESPN),U,3)=""
SCL S ^TMP($J,"UOR","CL",ESPN,0)=ESPCL(ESPN)
ASK S DIR(0)="Y",DIR("A")="Do you want to enter another classification code",DIR("B")="NO" D ^DIR K DIR
 G:$D(DTOUT) NOUPD
 I Y'=1&(Y'=0) W !!,$C(7),?5,"You must enter Yes or No." G ASK
 I Y S ESPN=ESPN+1 G CL
DTO S ESPX=".03" D RD G:$D(DUOUT)!($D(DTOUT)) NOUPD S ESPD(.03)=Y
 I ESPD(.03)>ESPDTR W !!,$C(7),"Date/time of Offense must be before Date/time Received!",! G DTO
EDTO S ESPX=".09" D RD G:$D(DUOUT)!($D(DTOUT)) NOUPD S ESPD(.09)=Y
 I ESPD(.09)'="",ESPD(.03)>ESPD(.09) W !!,$C(7),"Ending Date/time of Offense must be after Date/time of Offense!",! G EDTO
LOC S ESPX=".04" D RD G:$D(DUOUT)!($D(DTOUT)) NOUPD S ESPD(.04)=Y
WEAP S ESPX=".05" D RD G:$D(DUOUT)!($D(DTOUT)) NOUPD S ESPD(.05)=Y
MO W !,"METHOD OF OPERATION: " S DWLW=80,DWPK=1,DIC="^TMP($J,""MO"",",DIWESUB="METHOD OF OPERATION" D EN^DIWE
 G:$D(DTOUT) NOUPD
POL N TYPE S ESPX=".06" D RD G:$D(DUOUT)!($D(DTOUT)) NOUPD S:'+Y ESPD(.06)="" I +Y S ESPD(.06)=+Y D SET(+Y,0)
CIP S ESPX="1.01" D RD G:$D(DUOUT)!($D(DTOUT)) NOUPD S ESPD(1.01)=Y
BAT S ESPX="1.02" D RD G:$D(DUOUT)!($D(DTOUT)) NOUPD S ESPD(1.02)=Y
 S ^TMP($J,"UOR",0)="^"_ESPDTR_"^"_ESPD(.03)_"^"_ESPD(.04)_"^"_ESPD(.05)_"^"_ESPD(.06)_"^"_ESPD(.07)_"^O^"_ESPD(.09)_"^^"_ESPD(.11)_"^"_ESPD(.12)
 S ^TMP($J,"UOR",1)=ESPD(1.01)_"^"_ESPD(1.02)_"^"
 G 1^ESPOFF0
EXIT W:$D(DTOUT) $C(7)
 K DA,DIC,DIR,DIRUT,DUOUT,ESPCL,ESPD,ESPDTR,ESPFN,ESPN,ESPNOT,ESPS,ESPTEST,ESPVAR,ESPX,ESPY,I,NOUPD,X,Y,^TMP($J)
 QUIT
RD S DIR(0)="912,"_ESPX D ^DIR I $S(($L(X)>1&($E(X)=U)):1,($L(X)>1&(X[U)):1,1:0) D NO K X,Y G RD
 K DIR Q
NO W $C(7),!!?5,"NO '^'S ALLOWED!",!! Q
 ;
NOUPD W !!,$C(7),?20,"NO UPDATING HAS OCCURRED!!!",!! K ESPCL,ESPD,ESPDTR,ESPX,ESPY,^TMP($J) G:$D(DTOUT) EXIT G DTR
MSG W !,$C(7),"FOUND" W ?10,"There is already a report for this date/time.",!?10,"Same date/time received NOT allowed.",!?10,"To edit the existing report,",!?10,"you must go to the Edit an Offense Report option."
 W !?10,"To complete this report, go to Resume an Offense Report Entry."
 Q
SET(NEWKEY,TYPE) ;PULL BADGE/RANK FOR INVESTIGATOR
 S:TYPE>0 HDA=DA
 S DIC="^VA(200,",DA=NEWKEY,DR="910.1;910.2",DIQ(0)="E",DIQ="POLINF" D EN^DIQ1
 S:TYPE>0 SX=$S(TYPE=1:POLINF(200,DA,910.1,"E"),TYPE=2:POLINF(200,DA,910.2,"E"),1:""),DI=.06
 S:TYPE=0 ESPD(.11)=POLINF(200,DA,910.1,"E"),ESPD(.12)=POLINF(200,DA,910.2,"E")
 K DIC,DIQ,POLINF
 Q:TYPE=0
 S DA=HDA K HDA
 Q SX
