PRCHUSER ;WISC/AKS-Add/Edit purchase card user ;9/12/00  22:52
 ;;5.1;IFCAP;**8,125**;Oct 20, 2000;Build 15
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N DIC,DA,Y,DIE,DR,PRCF,%,PRCHORIG,PRCRI
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
MORE S DIC="^PRC(440.5,",DIC(0)="AELQM",DLAYGO=440.5
 S DIC("S")="I $D(PRC(""SITE"")),$P($G(^PRC(440.5,+Y,2)),""^"",3)=PRC(""SITE"")"
 D ^DIC Q:Y'>0  S DA=+Y,PRCRI(440.5)=DA,PRCIEN=DA
 N SITECHK S SITECHK=$P($G(^PRC(440.5,DA,2)),U,3) I +SITECHK'=0,SITECHK'=PRC("SITE") W !!,"This card is not entered for this station." H 3 G MORE
 S DIE="^PRC(440.5,",DR="[PRCH PURCHASE CARD]" D ^DIE ;Q:$D(Y)
 D EDIT^PRC0B(.X,"440.5;^PRC(440.5,;"_PRCRI(440.5),"70////P;71////"_DT)
 K PRCHHLDR,PRCHAPP,PRCHALT,PRCHSING,PRCHMNTH
 I '$G(DA) G Q
 S DA(1)=DA S PRCHUSER=$P(^PRC(440.5,DA,0),U,8)
 I $G(PRCHUSER),$G(PRCHORIG),PRCHUSER'=PRCHORIG D
 . S DIK="^PRC(440.5,"_DA(1)_",1,",DA=PRCHORIG D ^DIK K Y,DIK
 I $G(PRCHUSER),'$D(^PRC(440.5,DA,1,PRCHUSER)) D
 . I '$G(^PRC(440.5,DA(1),1,0)) D
 . . S $P(^PRC(440.5,DA(1),1,0),U,2)=$P(^DD(440.5,12,0),U,2)
 . S DIE="^PRC(440.5,"_DA(1)_",1,",DA=PRCHUSER,DR=".01////^S X=PRCHUSER"
 . D ^DIE
 . S $P(^PRC(440.5,DA(1),1,0),U,3)=DA,$P(^(0),U,4)=$P(^(0),U,4)+1
 . K DIE,DR,PRCHUSER
MORES S:'$D(DA(1)) DA(1)=DA S DIC="^PRC(440.5,"_DA(1)_",1,",DIC(0)="AELQ"
 S DIC("S")="I +Y'=$P(^PRC(440.5,DA(1),0),U,8)" D ^DIC
 G:$D(DUOUT)!$D(DTOUT) Q G REPL:Y'>0  S DA=+Y
 I $P(Y,U,3)'=1 D
 . W !!?5,"Would you like to delete this surrogate user" S %=2 D YN^DICN
 . Q:%<1!(%=2)
 . S DA=+Y,DIK="^PRC(440.5,"_DA(1)_",1,"
 . D ^DIK K Y,DIK
 G MORES
REPL ;REPLACEMENT CARD ENTRY
 D NOW^%DTC S XNOW=X
 K DIR
 S PRCRPLO=$P($G(^PRC(440.5,PRCIEN,50)),U)
REPL1 S DIR("A")="REPLACED CARD: " S:PRCRPLO'="" DIR("B")=PRCRPLO S DIR("?")="Enter a valid card number for replaced card, 16 digits",DIR(0)="FAO^16:16"
 D ^DIR G Q:$D(DIRUT)!$D(DTOUT) S PRCRPLN=X K DIR
 I PRCRPLN'?1.N W "   Must be 16 digits!!" G REPL1
 I PRCRPLO=PRCRPLN!'PRCRPLN G Q
 S PRCRIENN=$O(^PRC(440.5,"B",PRCRPLN,0)) I 'PRCRIENN W "    Not a valid Purchase Card number" G REPL
 I $P(^PRC(440.5,PRCRIENN,2),U,2)'="Y" W "    Replaced Card Must be INACTIVE" G REPL
 S PRCIENP=$O(^PRC(440.5,"ARPC",PRCRPLN,0)) I PRCIENP W "    Replaced Card already listed under card: ",$P(^PRC(440.5,PRCIENP,0),U) G REPL
 S ERR="" D  I ERR'="" W !," >> Replaced card does not match this card for: ",ERR G REPL
 . S PRCUR0=^PRC(440.5,PRCIEN,0),PRCUR2=^PRC(440.5,PRCIEN,2),PRCRPL0=$G(^PRC(440.5,PRCRIENN,0)),PRCRPL2=$G(^PRC(440.5,PRCRIENN,2))
 . I $P(PRCUR0,U,8)'=$P(PRCRPL0,U,8) S ERR="CARD HOLDER"
 . I $P(PRCUR0,U,2)'=$P(PRCRPL0,U,2) S:ERR'="" ERR=ERR_"," S ERR=ERR_"FUND CONTROL POINT"
 . I $P(PRCUR0,U,3)'=$P(PRCRPL0,U,3) S:ERR'="" ERR=ERR_"," S ERR=ERR_"COST CENTER"
 . I $P(PRCUR0,U,4)'=$P(PRCRPL0,U,4) S:ERR'="" ERR=ERR_"," S ERR=ERR_"BUDGET OBJECT CODE"
 . I $P(PRCUR2,U,3)'=$P(PRCRPL2,U,3) S:ERR'="" ERR=ERR_"," S ERR=ERR_"STATION NUMBER"
 K DIE S DIE="^PRC(440.5,",DA=PRCIEN,DR="51///^S X=PRCRPLN" D ^DIE K DIE,DA,DR
Q W !!?5,"Would you like to register another purchase card" S %=2 D YN^DICN
 W ! G:%=1 MORE I %=0 W !!,"Please answer 'Yes' or 'No'"
 K DLAYGO,DA,PRCRPLO,DIR,PRCRPLN,PRCIEN,PRCRIENN,PRCIENP,ERR,PRCUR0,PRCUR2,PRCRPL0,PRCRPL2,XNOW,DIRUT,DTOUT,DIK,DUOUT,DIROUT
 QUIT
INPUT1 ;Input transform for File #440.5, Field #1
 S DIC="^PRC(420,PRC(""SITE""),1,",DIC(0)="QEMNZ" S DIC("S")="I $D(^PRC(420,""C"",PRCHHLDR,PRC(""SITE""),+Y))",D="B^C" D MIX^DIC1 K:Y<0 X K DIC,D
 Q:'$D(X)  S X=$P(Y(0),U)
 Q
