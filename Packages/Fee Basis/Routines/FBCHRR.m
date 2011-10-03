FBCHRR ;AISC/DMK-RE-INITIATE REJECTS FROM PRICER ;7/17/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DIC S FBTYPE="B9"
 W ! S DIC="^FBAA(161.7,",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,15)=""Y""&($P(^(0),U,17)]"""")"_$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):"",1:"&($P(^(0),U,5)=DUZ)"),DIC("A")="Select Batch with Pricer Rejects: " D ^DIC
 G END:X="^"!(X=""),DIC:Y<0 S FBN=+Y,FBN(0)=Y(0)
 I '$D(^FBAAI("AH",FBN)) W !!,*7,"No items rejected for this batch!",! G DIC
DIC1 W !! S DIC="^FBAA(161.7,",DIC(0)="AEQMZ",DIC("A")="Select New Batch Number: ",DIC("S")="I $P(^(0),U,3)=FBTYPE&($P(^(0),U,5)=DUZ)&($P(^(0),U,15)=""Y"")&($G(^(""ST""))=""O"")&($P(^(0),U,18)'[""Y"")"
 D ^DIC K DIC G DIC:$E(X)="^"!(X=""),DIC1:Y<0 S FBNB=+Y,FBNB(0)=Y(0)
DIC2 W ! S DIC="^FBAAI(",DIC(0)="AEQMZ",DIC("A")="Select Patient: ",D="D",DIC("S")="I $D(^(""FBREJ"")),$P(^(""FBREJ""),U,3)=FBN" D IX^DIC G DIC:$E(X)="^"!(X=""),DIC2:Y<0 S FBI=+Y,FBI(0)=Y(0) G END:'$D(^FBAAI(FBI,0))
 S FBLISTC="" D HOME^%ZIS,START^FBCHDI2
ASK S DIR(0)="Y",DIR("A")="Want to re-initiate this payment",DIR("B")="NO" D ^DIR K DIR G END:$D(DIRUT),DIC:'Y
 S (DIC,DIE)="^FBAAI(",DIC(0)="AEQM",DA=FBI,DR="20////^S X=FBNB" D ^DIE
 K ^FBAAI(FBI,"FBREJ"),^FBAAI("AH",FBN,FBI) S $P(FBNB(0),"^",10)=$P(FBNB(0),"^",10)+1,$P(FBNB(0),"^",11)=$P(FBNB(0),"^",11)+1,$P(FBNB(0),"^",18)="N",^FBAA(161.7,FBNB,0)=FBNB(0)
 I '$D(^FBAAI("AH",FBN)) S $P(FBN(0),"^",17)="",^FBAA(161.7,FBN,0)=FBN(0)
 I $D(^FBAAI("AH",FBN)) G DIC2
EDIT S DIR(0)="Y",DIR("A")="Want to edit payment now",DIR("B")="YES" D ^DIR K DIR G END:$D(DIRUT)!'Y
 S FBPRICE=""
 ; get values of FPPS Claim ID and Line Item
 S FBFPPSC=$P($G(^FBAAI(FBI,3)),U)
 S FBFPPSL=$P($G(^FBAAI(FBI,3)),U,2)
 ; load current adjustment data
 D LOADADJ^FBCHFA(FBI_",",.FBADJ)
 ; save adjustment data prior to edit session in sorted list
 S FBADJL(0)=$$ADJL^FBUTL2(.FBADJ) ; sorted list of original adjustments
 ; load current remittance remark data
 D LOADRR^FBCHFR(FBI_",",.FBRRMK)
 ; save remittance remarks prior to edit session in sorted list
 S FBRRMKL(0)=$$RRL^FBUTL4(.FBRRMK)
 S (DIC,DIE)="^FBAAI(",DA=FBI,DR="[FBCH EDIT PAYMENT]"
 D ^DIE G H^XUS:$D(DTOUT)
 ; if adjustment data changed then file
 I $$ADJL^FBUTL2(.FBADJ)'=FBADJL(0) D FILEADJ^FBCHFA(FBI_",",.FBADJ)
 ; if remit remark data changed then file
 I $$RRL^FBUTL4(.FBRRMK)'=FBRRMKL(0) D FILERR^FBCHFR(FBI_",",.FBRRMK)
END K DIC,D,DA,DIRUT,DR,DTOUT,DUOUT,FBPRICE,VAL,DIE,FBI,FBN,FBNB,FBTYPE,I,POP,X,Y,FBLISTC
 K FBFPPSC,FBFPPSL,FBADJ,FBADJL,FBRRMK,FBRRMKL
 D END^FBCHDI
 Q
