FBAAVD2 ;AISC/DMK - EDIT VENDOR DEMOGRAPHICS ;7/10/14  17:07
 ;;3.5;FEE BASIS;**9,10,47,65,98,111,122,154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
EDITV ;entry to edit vendor demographic data
 ;DA defined to IEN of vendor file (161.2)
 Q:'$G(DA)  N FBADT,FBDA,Z6 S FBDA=DA  L +^FBAAV(DA):$G(DILOCKTM,3) I '$T W !,"Another user is editing this vendor record. Try again later.",! Q
 S FBT=$S($D(FBT):FBT,1:""),FBT=$S(FBT="N":FBT,1:"C")
 S FEEO="",DIE="^FBAAV(",DR="[FBAA EDIT VENDOR]",DIE("NO^")="BACKOUTOK"
 S Z1=$G(^FBAAV(DA,0)),Z3=$G(^(1)),Z4=$G(^("AMS")),Z5=$G(^("ADEL")),Z6=$P($G(^(3)),U,2)
 D GETGRP^FBAAUTL6(DA)
 D ^DIE
 I $P($G(^FBAAV(DA,0)),"^",13)']"" S DR="3;4;5;5.5",DIE("NO^")="" D ^DIE
 K DIE
 L -^FBAAV(DA)
 ;check if data was changed
 I $D(^FBAAV(DA,0)),(($P(Z1,U,2,6)'=$P(^FBAAV(DA,0),U,2,6))!($P(Z1,U,8,16)'=$P(^FBAAV(DA,0),U,8,16))!($P(Z3,U,10)'=$P($G(^FBAAV(DA,1)),U,10))!$$GRPDIF^FBAAUTL6(DA)!($P($G(^FBAAV(DA,3)),U,2)'=Z6)) D
 .S FBVNAME=$P(^FBAAV(DA,0),U),FBIEN1=DA,FBADT=$P(Z5,U,4),FBNPI=$P($G(^FBAAV(FBIEN1,3)),U,2),FBTXC=$P($G(^(3)),U,3)
 .;check if date last received from austin, version 3.  If so, then did not receive in upload - send update instead of change
 .;fbadt = date received from austin.
 .I '$$CKVEN^FBAADV(DA),FBADT']"" D UPDT^FBAAAV(FBDA) Q  ;,FBADT<FBINSTAL D UPDT^FBAAAV(DA) Q
 .;if austin deleted is yes, send update instead of change
 .I $P($G(^FBAAV(FBDA,"ADEL")),"^")="Y" D UPDT^FBAAAV(FBDA) Q
 .;if editing a newly added vendor, send update instead of change
 .I FBT="N" D UPDT^FBAAAV(FBDA) Q
 .;if only FPDS data was changed
 .I $P(Z1,U,2,6)=$P(^FBAAV(DA,0),U,2,6),$P(Z1,U,8,16)=$P(^FBAAV(DA,0),U,8,16) D  Q:FBT=""
 ..I '$D(^FBAA(161.25,"AF",DA)),'$D(^FBAA(161.25,DA,0)) S FBT="F" Q  ; no pending actions - add "F"
 ..I '$D(^FBAA(161.25,"AF",DA)),$D(^FBAA(161.25,DA,0)),$P(^(0),U,5)="" S FBT="" Q  ; action pending, but not yet transmitted - will incl. FPDS data
 .I FBT="F" S FBIEN1=DA,FEEO="" D SETGL^FBAAVD Q  ; send FEE-ONLY
 .;If date from austin not null then add vendor entry for a change
 .K DD,DO S DIC="^FBAAV(",DIC(0)="L",DLAYGO=161.2,X=FBVNAME D FILE^DICN Q:Y<0  S FBIEN=+Y
 .F  L +^FBAAV(FBIEN):$G(DILOCKTM,3) Q:$T  W !,"Another user is editing this vendor record.  Trying again.  ",!
 .S ^FBAAV(FBIEN,0)=$G(^FBAAV(FBIEN1,0))
 .S ^FBAAV(FBIEN,1)=$G(^FBAAV(FBIEN1,1))
 .S ^FBAAV(FBIEN,"AMS")=$G(^FBAAV(FBIEN1,"AMS")),$P(^FBAAV(FBIEN,"AMS"),"^")=""
 .K FBFDA
 .S I=0 F  S I=$O(^FBAAV(FBIEN1,2,I)) Q:'I  D
 ..S X=$P($G(^(I,0)),U) I X]"" S FBFDA(161.225,"+"_I_","_FBIEN_",",.01)=X
 .I $D(FBFDA) D UPDATE^DIE("","FBFDA")
 .S DIK="^FBAAV(",DA=FBIEN D IX1^DIK
 .L -^FBAAV(FBIEN)
 .;restore original vendor data
 .F  L +^FBAAV(FBIEN1):$G(DILOCKTM,3) Q:$T  W !,"Another user is editing this vendor record.  Trying again.  ",!
 .S DIE="^FBAAV(",DA=FBIEN1,DR="[FB VENDOR UPDATE]" D ^DIE K DIE
 .D UPDGRP^FBAAUTL6(FBIEN1)
 .L -^FBAAV(FBIEN1)
 .S DA=FBIEN D SETGL^FBAAVD
 K FBSG,FBVNAME,FBIEN,FBIEN1,Z3,Z4,Z5
 ;
CONTR ;enter contract information for a CNH vendor
 Q:$S('$D(FBPARCD):1,FBPARCD'=5:1,1:0)
 I '$D(^XUSEC("FBAA LEVEL 2",DUZ)) W !!?3,$C(7)_"You must be a holder of the FBAA LEVEL 2 security key to edit",!?3,"contracts and rates." Q
 Q:'$G(DA)  S FBVIEN=DA
 S FBLIEN=$P($G(^FBAA(161.25,FBVIEN,0)),"^",6) I FBLIEN]"",FBLIEN'=FBVIEN W !!,*7,"Cannot add contract information to this vendor until change has been",!,"approved by Austin." Q
 W ! S DIC="^FBAA(161.21,",DIC(0)="AEQLM",DLAYGO=161.21,DIC("S")="I $P(^(0),U,4)="_FBVIEN
 D ^DIC K DIC,DLAYGO Q:X=""!(X="^")  G CONTR:Y<0
 S DA=+Y,FBCNUM=$P(Y,"^",2),DIE="^FBAA(161.21,"
 F  L +^FBAA(161.21,DA):$G(DILOCKTM,3) Q:$T  W !,"This contract is being edited by another user, trying again.",!
 S ZO1=^FBAA(161.21,DA,0),DR="[FBNH ENTER CONTRACT]",DIE("NO^")="" D ^DIE K DIE,DR
 I '$G(DA) K ZO1 Q
 I $D(^FBAA(161.22,"AC",DA)) D
 .Q:$P(ZO1,"^",1,2)=$P(^FBAA(161.21,DA,0),"^",1,2)  W !!,*7,"You cannot change contract numbers or effective dates on",!,"a contract that has rates associated with it."
 .S DIE="^FBAA(161.21,",DR=".01////^S X=$P(ZO1,U);.02////^S X=$P(ZO1,U,2);.03////^S X=$P(ZO1,U,3);.04////^S X=$P(ZO1,U,4)" D ^DIE K DIE,DR W !!,"Contract information reset"
 L -^FBAA(161.21,DA) K ZO1
 Q:$D(DTOUT)
 I $G(FBEXNDT)<$G(FBEXDT) D URATE K FBCIEN,FBEXDT,FBEXNDT,FBURT
 ;create rates for a contract. Rates cannot be changed, but the
 ;user can enter multiple rates for a contract.
 ;FBCIEN=internal entry number for contract in 161.21
 S FBCIEN=DA K FBX
RATE K DA W ! S DIR(0)="161.22,.02",DIR("A")="Enter Nursing Home Rate",DIR("?")="^K FBX,FBRATE D DISPLAY^FBAAVD1 W !,""Enter an amount between .01 and 9999999.99""" D ^DIR
 K DIR Q:$D(DIRUT)  Q:'Y  S FBR=+Y
 ;I $L($$RATE^FBAAVD1($P(^FBAA(161.21,FBCIEN,0),"^",1)))+$L("^"_FBR)>510 W !,*7,"There are too many rates loaded for that contract! Please remove obsolete rates.",! Q
 I $D(^FBAA(161.22,"AD",FBCIEN,FBR)) K FBR W !,*7,"Rate already exists for that contract!",! G RATE
 S X=$P(^FBAA(161.22,0),U,3)
RETRY S X=X+1 G:$D(^FBAA(161.22,X)) RETRY
 F  L +^FBAA(161.22,X):$G(DILOCKTM,3) Q:$T  W !,"Another user is editing this rate record.  Trying again.  ",!
 K DD,DO S DIC="^FBAA(161.22,",DIC(0)="L",DLAYGO=161.22,DIC("DR")=".02////^S X="_FBR_";.03////^S X="_FBCIEN D FILE^DICN K DIC,DLAYGO
 L -^FBAA(161.22,+Y)
 G RATE
 ;
GETVEN K FBRATE D GETVEN^FBAAUTL1 G END:'IFN
 S DA=IFN K DIC,IFN
 S FBPARCD=$P($G(^FBAAV(DA,0)),U,9)
 I FBPARCD'=5 W !?5,*7,"Vendor selected is not a Community Nursing Home.",! G GETVEN
 D CONTR G GETVEN
END K DIC,DA,FBVIEN,IFN,FBPARCD,X,Y,FBLIEN
 Q
URATE ;Update rate when user backs up contract dates.
 N DA S (FBCIEN,FBURT)=0
 F  S FBURT=$O(^FBAA(161.23,"AE",FBCNUM,FBURT)) Q:'FBURT  F  S FBCIEN=$O(^FBAA(161.23,"AE",FBCNUM,FBURT,FBCIEN)) Q:'FBCIEN  I $P($G(^FBAA(161.23,FBCIEN,0)),"^",2)>FBEXNDT D
 .I +$G(^FBAA(161.23,FBCIEN,0))>FBEXNDT S DIK="^FBAA(161.23,",DA=FBCIEN D ^DIK K DIK Q
 .S DIE="^FBAA(161.23,",DA=FBCIEN,DR=".02////^S X=FBEXNDT" D ^DIE K DIE
 Q
