XUTMKE2 ;SEA/RDS - Taskman: Option, ZTME SCREEN*, Part 2 ;04/17/98  13:19
 ;;8.0;KERNEL;**63,79**;Jul 10, 1995
 ;
SCRAD ;Add Error Screens
 N DIE,DR,DA,DDSFILE,ZTX,ZTY
AD S ZTY=$$SCSEL(1,"Enter Error Screen to Add/Apply") Q:ZTY'>0
 ;S DA=+ZTY,DIE="^%ZTER(2,",DR=".02//L;.03;.04;2" D ^DIE
 D FORM(+ZTY) G AD
 ;
SCSEL(%,%ZT) ;Select Error Screen
 N ZT,ZTE,DIC,DA,DIR
 W ! I $G(%ZT)="" S %ZT="Select ERROR SCREEN"
 G SEL1:$G(%)
 ;
SEL0 S DIR(0)="PO^3.076:AEMQ"
 S DIR("A")=%ZT
 S DIR("?")="^D SCSELH^XUTMKE2"
 S DIR("??")="^D SCLIST^XUTMKE1"
 D ^DIR
 Q Y
 ;
SEL1 S DIC=3.076,DIC(0)="AEMQL"
 S DIC("A")=%ZT_": ",DIC("DR")=".02//L"
 D ^DIC
 Q Y
 ;
FORM(DA) ;Call the form.
 N DDSFILE,DR
 S DDSFILE="^%ZTER(2,",DR="[XUTMKE ADD]" D ^DDS
 Q
SCSELH ;SCSEL--Text For ? Help
 W !!?5,"A screen is a string of characters."
 W !?5,"Taskman and %ZTER do not log errors whose error messages contain a screen."
 W !!?5,"For example, if a DSM-11 site routinely logs many disconnect errors each"
 W !?5,"day that cannot be prevented, the site manager could enter the screen"
 W !?5,"""DSCON"" to prevent these errors from being logged."
 W !!?5,"Enter ?? to see the screens that are currently in place."
 Q
 ;
SCRED ;Edit Error Screen
 N DIR,DIRUT,DTOUT,DUOUT,ZTX,ZTY
ED S ZTY=$$SCSEL(0,"Enter Error Screen to edit") Q:ZTY'>0
 ;S DA=+ZTY,DR=".03;.04;2",DIE="^%ZTER(2," D ^DIE
 D FORM(+ZTY)
 ;
 W !
 S DIR(0)="Y",DIR("A")="Do you want to reset the counter to zero"
 S DIR("B")="NO",DIR("?")="     Answer YES to erase the current count and start over."
 D ^DIR S ZTZ=X K DIR
 I $D(DIRUT) W !!?5,"Count NOT changed!" Q
 ;
ED3 I Y=1 S ^%ZTER(2,+ZTY,3)=0 W !?5,"Counter reset!"
 G ED
 ;
NAME ;Called from FORM XUTMKE field 1.
 N XUTM1,XUTM2 S XUTM1=^%ZTER(2,DA,0)
 D UNED^DDSUTL(1,"","",$P(XUTM1,U,5)) ;If national can't edit name
 D UNED^DDSUTL(6,"","",$P(XUTM1,U,5)) ;If national can't have alternative text.
 I $P(XUTM1,U,5) S XUTM2(1)="This is a Nationally released entry.",XUTM2(2)="Can't be deleted, name changed, have alternative text." D HLP^DDSUTL(.XUTM2)
 Q
