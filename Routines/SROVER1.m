SROVER1 ;BIR/MAM - EDIT, VERIFICATION SCREEN ;[ 10/01/99  12:55 PM ]
 ;;3.0;Surgery;**18,67,88,127,119**;24 Jun 93
 S SROVER=1,SRAO(1)=55,SRAO(2)=27,SRAO(3)=26,SRAO(4)="",SRAO(5)=34,SRAO(6)="",SRAO(7)=32,SRAO(8)=32.5,SRMSG="NO Assoc. DX ENTERED"
ASK W !!,"Select Information to Edit: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 Q
 S:$E(X)="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),($E(X)'="A") D HELP Q:SRSOUT  G ASK
 I $E(X)="A" S X="1:8"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>8)!(Y>Z) D HELP Q:SRSOUT  G ASK
 I X?.N1":".N D RANGE Q
 S EMILY=X D ONE Q
 Q
HELP W !!,"Enter the number corresponding to the information you want to update.  You may",!,"enter 'ALL' to update all the information displayed on this screen, or a"
 W !,"range of numbers separated by a ':' to update more than one item."
 Q
RANGE ; range of numbers
 S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 W @IOF I EMILY=2 S X=$P(S("OP"),"^",2) I X D  W !
 .S SRY=$$CPT^ICPTCOD(X,$P($G(^SRF(SRTN,0)),"^",9)),Y=$P(SRY,"^",2),Z=$P(SRY,"^",3)
 .W !,"  CPT Code: "_Y_"  ",Z,!,?5,"Description:" D ^SROCPT W ! F I=1:1:80 W "-"
 I EMILY=4 D POTH Q
 I EMILY=6 D INTRA^SROCMPS S SRSOUT=0 Q
 W ! K DR,DIE,DA S DIE=130,DA=SRTN,DR=SRAO(EMILY)_"T" D ^DIE K DR,DIE
 I EMILY=5 D
 .D:$$SCEC^SROVER3() ASK^SROPCE1 K SRCL
 .D DOTH^SROVER3 I $D(Y) S SRSOUT=0
 I EMILY=2,$P(S("OP"),"^",2)'="" D VASDX^SROADX
 Q
POTH W !,"Other Procedures:",!
 N SRSHT K SRSEL S CNT=1,OTH=0 F  S OTH=$O(^SRF(SRTN,13,OTH)) Q:'OTH!(SRSOUT)  D
 .S OTHER=$P(^SRF(SRTN,13,OTH,0),"^"),X=$P($G(^SRF(SRTN,13,OTH,2)),"^"),CPT="NOT ENTERED",CPT1=""
 .I X S CPT1=X,Y=$$CPT^ICPTCOD(X,$P($G(^SRF(SRTN,0)),"^",9)),SRCPT=$P(Y,"^",2),SRSHT=$P(Y,"^",3),CPT=SRCPT_"  "_SRSHT
 .W !,CNT_". "_OTHER,!,?5,"CPT Code: "_CPT S SRSEL(CNT)=OTH_"^"_OTHER_"^CPT Code: "_CPT_"^"_CPT1
 .I CPT1,$O(^SRF(SRTN,13,OTH,"MOD",0)) D  W "  ("_SRX_")"
 ..S (SRCOMMA,SRI)=0,SRCMOD="",SRX="Modifiers: " F  S SRI=$O(^SRF(SRTN,13,OTH,"MOD",SRI)) Q:'SRI  D
 ...S SRM=$P(^SRF(SRTN,13,OTH,"MOD",SRI,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRM,"I"),"^",2)
 ...S SRX=SRX_$S(SRCOMMA:",",1:"")_SRCMOD,SRCOMMA=1
 . D OTHADXD^SROADX1
 .S CNT=CNT+1
 W !,CNT_". Enter NEW Other Procedure",! K DIR S DIR("A")="Enter selection",DIR(0)="NO^1:"_CNT D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 Q:'Y  S SRDA=Y W !! I SRDA<CNT D  W @IOF G POTH
 .N OTHCNT S OTHCNT=Y
 .W @IOF,!,"Other Procedures:",!!,OTHCNT,"."
 .W ?3,$P(SRSEL(SRDA),"^",2),!,?5,$P(SRSEL(SRDA),"^",3)
 .S OTH=$P(SRSEL(SRDA),"^") K SRDES S CPT1=$P(SRSEL(SRDA),"^",4),X=$$CPTD^ICPTCOD(CPT1,"SRDES",,$P($G(^SRF(SRTN,0)),"^",9)) I $O(SRDES(0)) F I=1:1:X W !,?5,SRDES(I)
 .K DA,DIE,DIR,DR W ! S DA=$P(SRSEL(SRDA),"^"),DA(1)=SRTN,DIE="^SRF(SRTN,13,",DR=".01;3" D ^DIE K DA,DIE,DR Q:$D(Y)
 .D VOTHADX^SROADX
 K DIR S DIR("A")="Enter new OTHER PROCEDURE",DIR(0)="130.16,.01" D ^DIR K DIR S SRNEW=Y I $D(DTOUT)!$D(DUOUT)!(Y="") D PH Q
 K DD,DO S DIC="^SRF(SRTN,13,",X=SRNEW,DIC(0)="L",DIC("P")=$P(^DD(130,.42,0),"^",2) D FILE^DICN K DIC,DD,DO I +Y<0 D PH Q
 K DA,DIE,DIR,DR S DA=+Y,DA(1)=SRTN,DIE="^SRF(SRTN,13,",DR="3" D ^DIE
 D NOTHADX^SROADX K DA,DIE,DR Q:$D(Y)
PH W @IOF G POTH
 Q
PRESS W ! K DIR S DIR("A")="Press RETURN to continue ",DIR(0)="FOA" D ^DIR K DIR
 Q
