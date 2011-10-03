ENFADEL ;WASHINGTON IRMFO/KLD/DH/SAB; Equipment Disposition ;10/23/97
 ;;7.0;ENGINEERING;**29,33,38,39,46**;Aug 17, 1993
 ;This routine should not be modified.
ST D GETEQ^ENUTL G K:Y'>0
 S (DA,ENEQ("DA"))=+Y
 L +^ENG(6914,DA):5 I '$T W !!,$C(7),"Another user is editing this Equipment Record. Please try again later." G K
 I '$D(^ENG(6915.2,"B",DA)) D  G K
 . W $C(7),!,"There is no FA document on file for this asset. No action taken."
 I $D(^ENG(6915.5,"B",DA)) S X=$$CHKFA^ENFAUTL(DA) I +X=0 D  G K
 . S Y=$P(X,U,3) D DD^%DT
 . W $C(7),!,"An FD document for ENTRY #",DA," was processed on ",Y,"."
 . W !,"No action taken."
 F I=2,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 S DIC="^ENG(6915.5,",DIC(0)="L",DLAYGO=6915.5
 S X=ENEQ("DA"),DIC("DR")="1///NOW;1.5////^S X=DUZ"
 K DD,DO D FILE^DICN K DLAYGO
 S ENFD("DA")=+Y
 L +^ENG(6915.5,ENFD("DA")):0 I '$T W !!,$C(7),"Another user is editing the FD document that you just created.",!,"Please notify your ADPAC." L -^ENG(6914,ENEQ("DA")) G K
 ; ask type of FD
 S DIE="^ENG(6915.5,",DA=ENFD("DA"),DR="100"
 D ^DIE I $D(Y)!$D(DTOUT) D  G EXIT
 . W !!,$C(7),"The type of FD Document is required. No action taken."
 . S DIK=DIE D ^DIK K DIK
 S ENFD("TYPE")=$P($G(^ENG(6915.5,ENFD("DA"),100)),U)
 I ENFD("TYPE")="T",$$GET1^DIQ(6914,ENEQ("DA"),38)="1524" D  I 'Y W !!,"No action taken." S DIK=DIE D ^DIK K DIK G EXIT
 . W !,"This equipment item is already on SGL 1524 (Excess)."
 . S DIR(0)="Y",DIR("A")="Are you sure you want to process a Turn-In"
 . S DIR("B")="NO" D ^DIR K DIR
DIE ;Enter data for FD DOC
 S DIE="^ENG(6915.5,",DIE("NO^")="BACKOUTOK"
 S DA=ENFD("DA"),DR="[ENFA DELETE-"_ENFD("TYPE")_"]"
 W ! D ^DIE I $D(Y)!($D(DTOUT)) D  G EXIT
 . W !!,$C(7),"This FD document is incomplete and is being deleted..."
 . S DIK=DIE D ^DIK K DIK
 I ENFD("TYPE")="T" D  I $D(Y)!($D(DTOUT)) G EXIT
 . ; ask fair market value at turn-in
 . W !!,"When equipment is turned-in, its TOTAL ASSET VALUE must be"
 . W !,"changed to the fair market value per VA Accounting Standards."
 . W !,"NOTE: The current TOTAL ASSET VALUE will automatically be saved"
 . W !,"in the ORIGINAL ASSET VALUE field."
 . ; compute repair costs (exclude PM)
 . S (ENT,ENT("L"),ENT("M"),ENT("V"))=0
 . S ENI=0 F  S ENI=$O(^ENG(6914,ENEQ("DA"),6,ENI)) Q:'ENI  D
 . . S ENY=$G(^ENG(6914,ENEQ("DA"),6,ENI,0))
 . . Q:$E($P(ENY,U,2),1,3)="PM-"  ; exclude PM
 . . S ENT("L")=ENT("L")+$P(ENY,U,5)
 . . S ENT("M")=ENT("M")+$P(ENY,U,6)
 . . S ENT("V")=ENT("V")+$P(ENY,U,7)
 . S ENT=ENT("L")+ENT("M")+ENT("V")
 . ; display info to assist determination of fair market value
 . W !!,"Current TOTAL ASSET VALUE: ",$FN($P(ENEQ(2),U,3),",",2)
 . W !,"Acquisition Date: ",$$FMTE^XLFDT($P(ENEQ(2),U,4)),"   Life Expectancy: ",$P(ENEQ(2),U,6)
 . W !,"Replacement Date: ",$$FMTE^XLFDT($P(ENEQ(2),U,10))
 . W "   Condition: ",$$GET1^DIQ(6914,ENEQ("DA"),53)
 . W !,"Repair Costs (excluding preventive maintenance)"
 . W !,"   Labor$ :",$FN(ENT("L"),",",0),"   Material$: ",$FN(ENT("M"),",",0),"   Vendor$: ",$FN(ENT("V"),",",0),"   Total$: ",$FN(ENT,",",0),!
 . K ENT
 . S DIE="^ENG(6915.5,",DA=ENFD("DA"),DR="104R"
 . D ^DIE I $D(Y)!($D(DTOUT)) D
 . . W !!,$C(7),"Fair Market Value unspecified. This FD document is being deleted..."
 . . S DIK=DIE D ^DIK K DIK
 S ENFAP("DOC")="FD"
 S ENFAP(0)=$G(^ENG(6915.5,DA,0)),ENFAP(5)=$G(^(5)),ENFAP(100)=$G(^(100))
 I $P(ENFAP(5),U,8)="" S $P(ENFAP(5),U,8)="0.00"
 I $P(ENFAP(100),U,4)="" S $P(ENFAP(100),U,4)=7
 S $P(^ENG(6915.5,ENFD("DA"),100),U,2)=$$GET1^DIQ(6914,ENEQ("DA"),12)
 S X=$P(ENFAP(100),U,3) I X]"" S $P(ENFAP(5),U,5)=$E(X,1,3)+1700,$P(ENFAP(5),U,6)=$E(X,4,5),$P(ENFAP(5),U,7)=$E(X,6,7)
 S X=$P(ENFAP(100),U,4) S:X $P(ENFAP(5),U,4)=$$GET1^DIQ(6914.8,X,.01)
 S ^ENG(6915.5,ENFD("DA"),5)=ENFAP(5)
 K ^TMP($J) D ^ENFAVAL
 I $D(^TMP($J)) D LISTP^ENFAXMTM D  G DIE:"Yy"[X,EXIT
 .R !!,"Re-edit this disposition?  Y// ",X:DTIME S:'$T X=U Q:"Yy"[X
 .W !,"Sorry, I must then delete this FD document!"
 .S DIK=DIE,DA=ENFD("DA") D ^DIK W " ...deleted" S X=U
 S ENAV=$$AVP^ENFAAV("6915.5",ENFD("DA"))
 I 'ENAV W !,"Adjustment voucher was NOT created." I $G(ENUT) S DIK=DIE D ^DIK W !,"No action taken. Database unchanged." K DIR G EXIT
 S DIR(0)="Y",DIR("A")="Sure you want to process this disposition",DIR("B")="YES"
 D ^DIR I 'Y!($D(DIRUT)) S DIK=DIE D ^DIK W "...data base unchanged." K DIR G EXIT
EQ ; update
 ;update FAP Balance
 D ADJBAL^ENFABAL($P(ENEQ(9),U,5),$P(ENEQ(9),U,7),$P(ENEQ(8),U,6),$P($P(ENFAP(0),U,2),"."),-$P(ENEQ(2),U,3))
 W !!,"Updating the Equipment File..."
 S DA=ENEQ("DA"),DIE="^ENG(6914," K DIC
 S DR="31////"_$P(ENFAP(100),U,4)_";32////"_$P(ENFAP(5),U,8) D ^DIE
 S DR="20////4;19////@;38////@" D ^DIE
 I ENFD("TYPE")="T" D
 . I $P(^ENG(6914,DA,3),U,15)'>0 S $P(^(3),U,15)=$P(ENEQ(2),U,3) ; orig.$
 . S DR="20.5////"_$P(ENFAP(100),U,3)
 . S DR=DR_";12////"_$$DEC^ENFAUTL($P(ENFAP(100),U,5))
 . D ^DIE
 I ENFD("TYPE")="D" S DR="22////"_$P(ENFAP(100),U,3) D ^DIE
 W !!,"Sending FD document to FAP." D ^ENFAXMT
 I $G(ENAV) D
 . S DIE="^ENG(6915.5,",DR="301///NOW",DA=ENFD("DA") D ^DIE
 . W !,"Adjustment Voucher was created.",!
 I ENFD("TYPE")="T" D
 . W !!,"Editing Equipment Data"
 . S DA=ENEQ("DA"),DIE="^ENG(6914,"
 . S DR="20;19//996;38//1524"
 . D ^DIE Q:$D(DTOUT)
 . Q:$$GET1^DIQ(6914,ENEQ("DA"),38)'=1524
 . S DIR(0)="Y",DIR("A")="Should a FA Document also be sent"
 . S DIR("?",1)="The FD Document removed the asset from Fixed Assets."
 . S DIR("?",2)="Since the asset was placed in the Excess (1524) account"
 . S DIR("?",3)="a FA Document should be sent adding it to Fixed Assets"
 . S DIR("?",4)="as excess equipment."
 . S DIR("?")="Enter YES to send a FA Document"
 . W ! D ^DIR K DIR Q:$D(DIRUT)!'Y
 . D ^ENFAACQ
EXIT L -^ENG(6915.5,ENFD("DA")),-^ENG(6914,ENEQ("DA"))
 ;
K K DA,DIC,DIE,DR,ENAV,ENEQ,ENFA,ENFAP,ENFD,I,X,Y Q
 ;
 ;ENFADEL
