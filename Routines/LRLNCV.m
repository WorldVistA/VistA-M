LRLNCV ;DALOI/CA-VALIDATE LOINC MAPPING ;18-JUL-2001
 ;;5.2;LAB SERVICE;**232,278**;Sep 27,1994
 ;
 ;=================================================================
 ; Ask VistA test in Lab Test file #60
START ;entry point from option LR LOINC VALIDATE
 S LREND=0 D TEST
 I $G(LREND) G EXIT
 ;
 W !!,"NAME OF NLT CODE: ",$P(^LAM(LRNLT,0),U)
 W !,"NLT CODE: ",$P(^LAM(LRNLT,0),U,2) S LRNLTN=$P($G(^LAM(LRNLT,0)),U,2)
 S LRDEF=+$G(^LAM(LRNLT,9))
 I LRDEF W !,"DEFAULT LOINC CODE: ",$S(LRDEF:LRDEF_"  "_$P(^LAB(95.3,LRDEF,80),U),1:"NONE")
ASKSPEC ; Ask Specimen- Lookup in Specimen multiple in Lab Test file #60
 W !!
LOOK61 K DIR,DA
 S DIR(0)="PO^61:EZMN",DIR("S")="I $P(^(0),U,9)"
 S DIR("A")="Select a Specimen source that has a LEDI HL7 code"
 S DIC("A")="Specimen source: "
 D ^DIR
 I $D(DUOUT)!($D(DTOUT))!(Y<1) G START
 S LRSPEC=+Y
SUFFIX ;Set LRCDEF Value
 S LREND=0,DIC="^LRO(68.2,",DIC(0)="AQEM",DIC("A")="Work Load Area: ",DIC("S")="I $D(^(""SUF"")),+^(""SUF"")" D ^DIC S:Y<1 LREND=1 K DIC
 I $G(LREND) G START
 S LRCDEF=$P(^LRO(68.2,+Y,"SUF"),U,3)
LOINC S LRMSG=1
 S LRLOINC=$$LNC^LRVER1(LRNLTN,LRCDEF,LRSPEC)
 I LRLOINC S LRLOINC=LRLOINC_"-"_$P($G(^LAB(95.3,LRLOINC,0)),U,15)
 I 'LRLOINC W !!,"TEST NOT MAPPED",!! D EXIT G START
 S LRDA=$P(LRMSGM,"-",2),LRDA=+$O(^LAM("C",LRDA,0))
 S LRDAN="Unknown code number"
 I $G(LRDA),$D(^LAM(LRDA,0)) S LRDAN=$P($G(^LAM(LRDA,0)),U)
 W !!,"LOINC Code: ",LRLOINC,!,$G(^LAB(95.3,+LRLOINC,80)),!
 W !,$$CJ^XLFSTR("LOINC code was located @ NLT CODE: "_LRDAN,IOM)
 W !,$$CJ^XLFSTR($P(LRMSGM,"-",2,99),IOM)
 D EXIT G START
 Q
EXIT K DA,DIC,DIE,DINUM,DIR,DIRUT,DR,DTOUT,DUOUT,LREND,LRLOINC,LRIEN,LRMSG,LRNLT,LRSPEC,LRSPECN,LRSUF,LRTEST,S,Y
 K DD,DO,DLAYGO,LRDEF,X
 QUIT
TEST W !!
 K DIR
 S DIR(0)="PO^60:QENMZ,",DIR("A")="VistA Lab Test"
 S DIR("?")="Select Lab test"
 D ^DIR K DIR
 I $D(DIRUT)!'Y K DIRUT S LREND=1 Q
 S LRIEN=+Y,LRTEST=$P(Y,U,2)
 ;Check for RESULT NLT CODE and if not one let enter
 I '$P($G(^LAB(60,+$G(LRIEN),64)),U,2) D
 .W $$CJ^XLFSTR("There is not a RESULT NLT CODE for "_LRTEST,IOM)
 .W $$CJ^XLFSTR("You MAY select one now to continue with the LOINC lookup",IOM),!
 K DIE,DR,DA S DA=LRIEN,DIE="^LAB(60,",DR=64.1
 D ^DIE
 I $D(DUOUT)!($D(DTOUT)) G START
 I '$P($G(^LAB(60,+$G(LRIEN),64)),U,2) D
 .S DIC=DIE,DR=0 W !! W ?5,"IEN: [",DA,"] ",$P(^LAB(60,LRIEN,0),U) S S=$Y D EN^LRDIQ W !
 W !
 S LRNLT=$P($G(^LAB(60,+$G(LRIEN),64)),U,2)
 I 'LRNLT G TEST
 Q
