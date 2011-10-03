ENFABETR ;WASHINGTON IRMFO/KLD/DH/SAB; EQUIPMENT BETTERMENTS; 6/9/97
 ;;7.0;ENGINEERING;**29,33,39**;Aug 17, 1993
 ; This routine should not be modified.
ST D GETEQ^ENUTL G K:Y<0 S ENEQ("DA")=+Y
 L +^ENG(6914,ENEQ("DA")):5 I '$T W !!,$C(7),"Another user is editing this Equipment Record. Please try again later." G K
 I '$D(^ENG(6915.2,"B",ENEQ("DA"))) D  L -^ENG(6914,ENEQ("DA")) G K
 . W $C(7),!!,"There is no FA document on file for this asset. Nothing to better."
 I $D(^ENG(6915.5,"B",ENEQ("DA"))) S X=$$CHKFA^ENFAUTL(ENEQ("DA")) I +X=0 D  L -^ENG(6914,ENEQ("DA")) G K
 . S Y=$P(X,U,3) D DD^%DT
 . W $C(7),!,"An FD document for ENTRY #",ENEQ("DA")," was processed on ",Y,"."
 . W !,"No action taken."
 S ENEQ(2)=$G(^ENG(6914,ENEQ("DA"),2)),ENEQ(8)=$G(^(8)),ENEQ(9)=$G(^(9))
 D BETNUM
 S DIC="^ENG(6915.3,",DIC(0)="L",DLAYGO=6915.3,X=ENEQ("DA")
 S DIC("DR")="1///NOW;1.5////^S X=DUZ;23///^S X=ENFB(""BETNUM"");35///^S X=$P(ENEQ(9),U,9)"
 K DD,DO D FILE^DICN K DLAYGO
 I Y'>0 W !!,$C(7),"Can't update betterment log. Better notify IRM." L -^ENG(6914,ENEQ("DA")) G K
 L +^ENG(6915.3,+Y):0 I '$T W !!,$C(7),"The FB document that you just created is being edited by someone else.",!,"Please notify your ADPAC." L -^ENG(6914,ENEQ("DA")) G K
 S ENFB("DA")=+Y
 W !!,"Current Asset Value is $",$P(ENEQ(2),U,3)
DIE ;Edit the FB DOC LOG entry
 S DIE="^ENG(6915.3,",DIE("NO^")="BACKOUTOK"
 S DA=ENFB("DA")
 S DR="24;100;28;32BETTERMENT VALUE"
 W ! D ^DIE K DIE("NO^")
 I '$D(^ENG(6915.3,DA,4))!($D(DTOUT)) D  G EXIT
 . W !!,$C(7),"This BETTERMENT is incomplete and is being deleted..."
 . S DIK=DIE D ^DIK K DIK
 S ENFAP("DOC")="FB"
 F I=0:1:6,100 S ENFAP(I)=$G(^ENG(6915.3,ENFB("DA"),I))
 K ^TMP($J) D ^ENFAVAL
 I $D(^TMP($J)) D LISTP^ENFAXMTM D  G:$D(DIRUT)!'Y EXIT G DIE
 .S DIR(0)="Y",DIR("A")="Re-edit this betterment",DIR("B")="Y"
 .D ^DIR K DIR Q:Y
 .W !,"Sorry, I must then delete this betterment!"
 .S DIK=DIE,DA=ENFB("DA") D ^DIK W " ...deleted" S Y=0
 S ENAV=$$AVP^ENFAAV("6915.3",ENFB("DA"))
 I 'ENAV W !,"Adjustment voucher was NOT created." I $G(ENUT) S DIK=DIE,DA=ENFB("DA") D ^DIK W "...data base unchanged." G EXIT
 S DIR(0)="Y",DIR("A")="Sure you want to process this betterment",DIR("B")="YES"
 D ^DIR I 'Y!($D(DIRUT)) S DIK=DIE,DA=ENFB("DA") D ^DIK W "...data base unchanged." G EXIT
EQ ;apply changes
 ;save data in adjusted node of FB document for later use as FC defaults
 S ENFAP(200)=$P(ENFAP(4),U,4)_U_$P(ENFAP(3),U,8)_U_$P(ENFAP(100),U)
 S ENFAP(200)=ENFAP(200)_U_$P(ENFAP(3),U,12)
 S $P(^ENG(6915.3,ENFB("DA"),200),U,1)=ENFAP(200)
 ;update FAP Balance
 D ADJBAL^ENFABAL($P(ENEQ(9),U,5),$P(ENEQ(9),U,7),$P(ENEQ(8),U,6),$P($P(ENFAP(0),U,2),"."),$P(ENFAP(4),U,4))
 W !!,"Updating the Equipment File..."
 S DA=ENEQ("DA"),DIE="^ENG(6914,"
 S ENEQ("NEW VAL")=$P(ENEQ(2),U,3)+$P(ENFAP(4),U,4)
 S DR="12////"_$$DEC^ENFAUTL(ENEQ("NEW VAL")) D ^DIE
 W !!,"Sending FB document to FAP." D ^ENFAXMT
 I ENAV D
 . S DIE="^ENG(6915.3,",DR="301///NOW",DA=ENFB("DA") D ^DIE
 . W !,"Adjustment Voucher was created.",!
EXIT L -^ENG(6915.3,ENFB("DA")),-^ENG(6914,ENEQ("DA"))
K K DA,DIC,DIE,DIK,DIR,DR,ENAV,ENFAP,ENFB,ENEQ,I,Y Q
 ;
BETNUM N COUNT S COUNT=0 F I=0:0 S I=$O(^ENG(6915.3,"B",ENEQ("DA"),I)) Q:'I  D
 .S COUNT=COUNT+1
 S COUNT=COUNT+1 S:COUNT<10 COUNT=0_COUNT S ENFB("BETNUM")=COUNT
 Q
 ;ENFABETR
