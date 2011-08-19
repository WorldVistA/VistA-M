LRLNCDEL ; DALOI/CA/FHS - UNMAP LAB TESTS TO LOINC CODES OR DELETE LOINC MAPPINGS ;1-OCT-1998
 ;;5.2;LAB SERVICE;**232,278**;Sep 27,1994
 ;Reference to ^DD supported by IA 10154
 ;=================================================================
 ; Ask VistA test to unmap-Lookup in Lab Test file #60
START ;entry point from option LR LOINC MAPPING
 S LREND=0 D TEST
 I $G(LREND) G EXIT
 W @IOF,!! D SPEC
 I $G(LREND) D EXIT G START
 D UNMAP
 D EXIT
 G START
EXIT ;
 K DA,DIC,DIE,DINUM,DIR,DIRUT,DR,DTOUT,I,LRCODE,LRDATA,LREND,LRLNC,LRLNC0,LRLOINC,LRELEC,LRIEN,LRNLT,LRSPEC,LRSPECL,LRSPECN,LRTIME,LRTEST,LRUNITS,S,Y
 K LRNLTN,LRNLTNM,LRASPECT
 K D,D0,DD,DO,DLAYGO,LRLNCNAM,LRNO,LROUT,X
 QUIT
TEST W !!
 N DIR,Y,X,LROUT,LRERR,DA,DIC,DIE,DR
 S DIR(0)="PO^60:QENMZ,",DIR("A")="VistA Lab Test to delete/unmap to LOINC "
 S DIR("?")="Select Lab test you wish to delete/unmap to a LOINC Code"
 D ^DIR K DIR
 I $D(DIRUT) K DIRUT S LREND=1 Q
 S LRIEN=+Y,LRTEST=$P(Y,U,2)
 ;Check for RESULT NLT CODE and if not one let enter
 L +^LAB(60,LRIEN):2 I '$T W !?4,"Locked by another user" H 5 G TEST
 I '$P($G(^LAB(60,LRIEN,64)),U,2) D  I $D(DUOUT)!($D(DTOUT)) S LREND=1 Q
 . W !!,"There is not a RESULT NLT CODE for "_LRTEST,".",!
 . W !,"You must select one now to continue with the mapping of this test!",!
 . K DIE,DR,DA S DA=LRIEN,DIE="^LAB(60,",DR=64.1
 . D ^DIE
 . L -^LAB(60,LRIEN)
 . I $D(DUOUT)!($D(DTOUT)) Q
 . S DIC=DIE,DR=0 W !! W ?5,"IEN: [",DA,"] ",$P(^LAB(60,LRIEN,0),U) S S=$Y D EN^LRDIQ W !
 L -^LAB(60,LRIEN)
 S LRNLT=$P($G(^LAB(60,LRIEN,64)),U,2)
 I 'LRNLT G TEST
 D GETS^DIQ(64,LRNLT_",",".01;1","E","LROUT","LRERR")
 S LRNLTNM=$G(LROUT(64,LRNLT_",",.01,"E"))
 S LRNLTN=$G(LROUT(64,LRNLT_",",1,"E"))
 Q
SPEC ; Ask Specimen- Lookup in Specimen multiple in Lab Test file #60
 N DIR,DIRUT
 S DIR(0)="PO^61:ENQNZ",LREND=0
 S DIR("S")="I $P(^(0),U,9),$P(^(0),U,10)"
 S DIR("?")="Enter a TOPOGRAPHY having a LEDI HL7 code defined."
 S DIR("A")="Specimen Source: "
 D ^DIR I $D(DIRUT) S LREND=1 Q
 S LRSPEC=+Y,LRSPECN=$P(Y,U,2)
 S LRELEC=$P(Y(0),U,9),LRASPECT=$P(Y(0),U,10)
 D GETS^DIQ(64.061,LRELEC_",",1,"E","LROUT","LRERR")
 S LRSPECL=$G(LROUT(64.061,LRELEC_",",1,"E"))
 I '$L(LRSPECL) W !?5,LRSPECN_" has a broken pointer" S LREND=1
 Q
UNMAP ;Check to see if already mapped to a LOINC code
 N DA,DIC,DIK,DIR,DIRUT,DR
 S DIR(0)="PO^64:EQNZM",DIR("S")="I $P($P(^(0),U,2),""."")="_$P(LRNLTN,".")
 S DIR("B")=$P(LRNLTN,".")
 D ^DIR I $D(DIRUT) S LREND=1 Q
 S LRNLT=+Y
 L +^LAM(LRNLT,5):1 I '$T W !,"Another user is editing this record",! H 5 Q
 I '$D(^LAM(LRNLT,5,LRSPEC,1,LRASPECT)) D  G INDEX60
 . N LROUT
 . D GETS^DIQ(64.061,LRASPECT_",",.01,"E","LROUT")
 . W $C(7)
 . W !!!?5,"Lab Test: "_LRTEST_" / "_LRSPECL_" is NOT mapped to "
 . W !,"WKLD CODE: "_$P(Y,U,2)_"  Time Aspect of: "_$G(LROUT(64.061,LRASPECT_",",.01,"E"))
DIS ;Show the data
 K DA,DIC,DIK,DIR,DR
 S DA(2)=LRNLT,DA(1)=LRSPEC,DA=LRASPECT,DIC="^LAM("_DA(2)_",5,"_DA(1)_",1,"
 S S=0,DR="0:99"
 W !!,LRSPECN,!
 D EN^DIQ
 S DIR(0)="Y",DIR("A")="Are You  - SURE-   you want to delete this mapping"
 D ^DIR I $G(Y)'=1 L -^LAM(LRNLT,5) Q
 S DIK=DIC D ^DIK
INDEX60 ;Stores LOINC code in Laboratory Test file (#60) so know what tests are mapped.
 K DIE,DA,DR S DA=LRSPEC,DA(1)=LRIEN,DIE="^LAB(60,"_DA(1)_",1,",DR="95.3///@" D ^DIE
 ;S ^LAB(60,LRIEN,1,LRSPEC,95.3)=LRCODE
 L -^LAM(LRNLT,5)
 Q
SHOWPRE ;DISPLAY LOINC CODE ALREADY MAPPED TO NLT
 S LRLNC=$P($G(^LAM(LRNLT,5,LRSPEC,1,LRTIME,1)),U)
 W !!,"This test and specimen is mapped to:"
 W !,"LOINC code: ",LRLNC,"  ",$G(^LAB(95.3,+LRLNC,80))
 W !!
 S DIR(0)="Y",DIR("A")="Are you sure you want to delete this mapping"
 S DIR("?")="If you enter yes, the current LOINC code mapping will be deleted."
 D ^DIR K DIR
 Q 
