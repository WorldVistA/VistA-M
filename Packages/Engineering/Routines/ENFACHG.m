ENFACHG ;WASHINGTON IRMFO/KLD/DH/SAB; EQUIPMENT CHANGES; 1/3/97
 ;;7.0;ENGINEERING;**29,39**;Aug 17, 1993
 ;This routine should not be modified.
 D SETUP
 D:ENDO ASKEQ
 D:ENDO ADDFC
 D:ENDO ASKCS
 D:ENDO ASKDATA
 K ENAV I ENDO D  I $G(ENUT) S ENDO=0 K ENUT
 . S ENAV=$$AVP^ENFAAV("6915.4",ENFC("DA"))
 . I 'ENAV W !,"Adjustment voucher was NOT created."
 D:ENDO ASKOK
 D:'ENDO DEL
 D:ENDO UPDATE
 D WRAPUP
 Q
SETUP ;
 S ENDO=1
 S (ENEQ("DA"),ENFA("DA"),ENFB("DA"),ENFC("DA"),ENFC("BETRMNT"))=""
 S:'$D(ENFAP("SITE")) ENFAP("SITE")=+^ENG(6915.1,1,0)
 Q
ASKEQ ; ask for equipment item
 D GETEQ^ENUTL I Y'>0 S ENDO=0 Q
 L +^ENG(6914,+Y):5 I '$T D  S ENDO=0 Q
 . W !!,"Someone else is editing this Equipment Record."
 . W !,"Please try again later."
 S ENEQ("DA")=+Y
 I '$D(^ENG(6915.2,"B",ENEQ("DA"))) D   S ENDO=0 Q
 . W !!,"There is no FA document on file for this asset."
 . W !,"Nothing to change."
 S X=$$CHKFA^ENFAUTL(ENEQ("DA")) I +X=0 D  S ENDO=0 Q
 . S Y=$P(X,U,3) D DD^%DT
 . W !!,"An FD document for ENTRY #",ENEQ("DA")," was processed on ",Y,"."
 S ENFA("DA")=$P(X,U,4)
 F I=1,2,3,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 Q
ADDFC ; create entry for FC code sheet
 S DIC="^ENG(6915.4,",DIC(0)="L",DLAYGO=6915.4
 S X=ENEQ("DA"),DIC("DR")="1///NOW;1.5////^S X=DUZ"
 K DD,DO D FILE^DICN K DLAYGO
 I Y'>0 D  S ENDO=0 Q
 . W !!,"Can't update the FC DOCUMENT LOG file. Better contact IRM."
 S ENFC("DA")=+Y
 L +^ENG(6915.4,+Y):0 I '$T D  S ENDO=0 Q
 . W !!,"The FC document that you just created is being edited by someone else."
 . W !,"Please notify your ADPAC."
 Q
ASKCS ; ask for code sheet to change
 W !
 S DIE="^ENG(6915.4,",DA=ENFC("DA"),DR="[ENFA CHANGE EN]"
 D ^DIE I $D(DTOUT) W !!,"Timeout" S ENDO=0 Q
 S ENFC("BETRMNT")=$P($G(^ENG(6915.4,ENFC("DA"),3)),U,8)
 I ENFC("BETRMNT")="" D  S ENDO=0 Q
 . W !!,"Document being changed (BETTERMENT NUMBER) must be specified."
 Q
ASKDATA ; ask data for FC Document
 S DIE="^ENG(6915.4,",DIE("NO^")="BACKOUTOK",DA=ENFC("DA")
 S DR="[ENFA CHANGE "_$S(ENFC("BETRMNT")="00":"FA]",1:"FB]")
 W ! D ^DIE K DIE("NO^") I $D(DTOUT) W !!,"Timeout" S ENDO=0 Q
 ;
 S ENFAP(100)=$G(^ENG(6915.4,ENFC("DA"),100))
 S X=$P(ENFAP(100),U,6) I X]"" S X1=$G(^ENG(6915.4,ENFC("DA"),3)),$P(X1,U,12)=$E(X,1,3)+1700,$P(X1,U,13)=$E(X,4,5),$P(X1,U,14)=$E(X,6,7),^(3)=X1
 S X=$P(ENFAP(100),U,7) I X]"" S X1=$G(^ENG(6915.4,ENFC("DA"),4)),$P(X1,U,14)=$E(X,1,3)+1700,$P(X1,U,15)=$E(X,4,5),$P(X1,U,16)=$E(X,6,7),^(4)=X1
 I $P(ENFAP(100),U)]"" S ENFAP("CSN")=$$GET1^DIQ(6915.4,ENFC("DA"),100),$P(^ENG(6915.4,ENFC("DA"),3),U,9)=$$GROUP^ENFAVAL(ENFAP("CSN")),$P(^ENG(6915.4,ENFC("DA"),3),U,11)=ENFAP("CSN")
 I $P(ENFAP(100),U,2)]"" S ENFAP("CMR")=$$GET1^DIQ(6915.4,ENFC("DA"),101),$P(^ENG(6915.4,ENFC("DA"),3),U,10)=$$LOC^ENFAVAL(ENFAP("CMR"))
 F I=0,3,4,6 S ENFAP(I)=$G(^ENG(6915.4,ENFC("DA"),I))
 ;
 S ENFAP("DOC")="FC" K ^TMP($J) D ^ENFAVAL
 I $D(^TMP($J)) D LISTP^ENFAXMTM D  G:Y ASKDATA S ENDO=0 Q
 . S DIR(0)="Y",DIR("A")="Re-edit this change",DIR("B")="YES"
 . D ^DIR K DIR
 . I 'Y W !!,"Sorry, I must then delete this change!" Q
 . ;Initialize derived values
 . S X1=$G(^ENG(6915.4,ENFC("DA"),3)),$P(X1,U,9,14)="^^^^^",^(3)=X1
 . S X1=$G(^ENG(6915.4,ENFC("DA"),4)),$P(X1,U,14,16)="^^",^(4)=X1
 . S ENFAP("CSN")="",ENFAP("CMR")=""
 . S Y=1
 Q
ASKOK ;
 S DIR(0)="Y",DIR("A")="Sure you want to process these changes"
 S DIR("B")="YES" D ^DIR K DIR I 'Y!($D(DIRUT)) S ENDO=0
 Q
DEL ;
 I $G(ENFC("DA"))]"" D
 . S DA=ENFC("DA"),DIK="^ENG(6915.4," D ^DIK K DIK
 . W !,"FC Document deleted..."
 W $C(7),!,"No action taken. Database unchanged."
 Q
UPDATE ;
 ; update modified code sheet
 D MCS^ENFACHG1
 ;update FAP Balance when value entered
 I $P(ENFAP(4),U,6)]"" D ADJBAL^ENFABAL($P(ENEQ(9),U,5),$P(ENEQ(9),U,7),$P(ENEQ(8),U,6),$P($P(ENFAP(0),U,2),"."),$P(ENFAP(4),U,6)-$P(ENFAP(100),U,4))
 W !!,"Updating the Equipment File..." D EQ^ENFACHG1
 W !!,"Sending FC document to FAP..." D ^ENFAXMT
 I $G(ENAV) D
 . S DIE="^ENG(6915.4,",DR="301///NOW",DA=ENFC("DA") D ^DIE
 . W !,"Adjustment Voucher was created.",!
 Q
WRAPUP ;
 I $G(ENEQ("DA"))]"" L -^ENG(6914,ENEQ("DA"))
 I $G(ENFC("DA"))]"" L -^ENG(6915.4,ENFC("DA"))
 K DA,DIC,DIE,DR,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,X1,Y
 K ENAV,ENDO,ENEQ,ENFAP,ENFA,ENFB,ENFC
 Q
 ;ENFACHG
