PRCSUT41 ;WISC/KMB/BGJ-UTILITY TO CREATE NEW DISTRIBUTION SCHEDULE ;7/6/89  13:17
V ;;5.1;IFCAP;**5**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;PRCHSY=NEW 410 IRN,PRCHJ=NEW 410 ITEM MULTIPLE IRN
 ;PRCHS=OLD 410 IRN,PRCHX=OLD 410 ITEM MULTIPLE IRN
 Q:'$D(PRCHSY)!('$D(PRCHS))  Q:'$D(PRCHJ)!('$D(PRCHX))  Q:'$D(^PRCS(410,PRCHSY,0))!('$D(^PRCS(410,PRCHS,0)))  Q:'$D(^PRCS(410,PRCHSY,"IT",PRCHJ,0))!('$D(^PRCS(410,PRCHS,"IT",PRCHX,0)))
 S PRCSI=0 F PRCSJ=1:1 S PRCSI=$O(^PRCS(410,PRCHS,"IT",PRCHX,2,PRCSI)) Q:PRCSI'>0  S PRCSDS=^(PRCSI,0) Q:$P(PRCSDS,U,2)'>0  Q:'$D(^PRCS(410.6,+$P(PRCSDS,U,2),0))  S PRCSDSD=^(0) D STF
 K PRCSDS,PRCSDSD,PRCSI,PRCSJ,DLAYGO
 Q
STF S X=PRCSDSD,$P(X,U)=$P(^PRCS(410,PRCHSY,0),U)_"-"_PRCHJ_"-"_PRCSI
 S DLAYGO=410.6,DIC="^PRCS(410.6,",DIC(0)="LOXZ" D FILE^DICN K DIC Q:Y<0  S $P(^PRCS(410.6,+Y,0),U,2,7)=$P(PRCSDSD,U,2,7)
 S:'$D(^PRCS(410,PRCHSY,"IT",PRCHJ,2,0)) ^(0)="^410.212I^^"
 S ^PRCS(410,PRCHSY,"IT",PRCHJ,2,PRCSI,0)=PRCSI_U_(+Y),^PRCS(410,PRCHSY,"IT",PRCHJ,2,"B",PRCSI,PRCSI)="" S $P(^PRCS(410,PRCHSY,"IT",PRCHJ,2,0),U,3,4)=PRCSI_U_($P(^PRCS(410,PRCHSY,"IT",PRCHJ,2,0),U,4)+1)
 Q
USEROUT ; remove user terminated by Kernel from IFCAP
 N CPT,ST,XDA,XDA1
 Q:'DA  S (CPT,ST)=0,XDA=DA
 ;remove user from supply
 K ^VA(200,XDA,400)
 ; remove user from all cps
 I $D(^PRC(420,"C",XDA)) D
 .F  S ST=$O(^PRC(420,"C",XDA,ST)) Q:'ST  D
 ..S CPT=0 F  S CPT=$O(^PRC(420,"C",XDA,ST,CPT)) Q:'CPT  D
 ...S DA(2)=ST,DA(1)=CPT,DA=XDA,DIK="^PRC(420,"_DA(2)_",1,"_DA(1)_",1," D ^DIK K DIK
 ; put users on a 'don't use' array
 S ST=0 F  S ST=$O(^PRC(420,"B",ST)) Q:ST=""  D
 .S DA(1)=ST,DA=XDA,DIK="^PRC(411,"_DA(1)_",6," D ^DIK K DIK
 .Q:$D(^PRC(411,ST,8,XDA))
 .S:'$D(^PRC(411,ST,8,0)) ^(0)="^411.045PA^^"
 .L +^PRC(411,ST):15 Q:'$T
 .S DA(1)=ST,DIC="^PRC(411,"_DA(1)_",8,",(DA,X)=XDA,DIC(0)="X",DINUM=X D FILE^DICN
 .L -^PRC(411,ST)
 K DIC
 ;remove user from inventory system
 S X="PRCPXTRM" X ^%ZOSF("TEST") D:$T=1 TERMUSER^PRCPXTRM(DA)
 K DA Q
USERIN ;restore terminated user to IFCAP
 N X,Y,YY,DIR,DIRUT,DUOUT,ENTRY,STA,OK
 S (ENTRY,STA,OK)=0 W !!
 S DIR(0)="P^200:EMZ",DIR("A")="Enter username",DIR("?")="Enter name in the format lastname,firstname"
 D ^DIR K DIR Q:$D(DIRUT)  W !!,"You have selected ",$P(Y,"^",2) S YY=+Y
 ;
 S DIR("A")="Do you wish to reinstate this user",DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  I Y=0 W !,"No action taken." G USERIN
 ;
 F  S STA=$O(^PRC(420,"B",STA)) Q:STA=""  I $D(^PRC(411,STA,8,"B",YY,YY)) S ENTRY=YY D
 .S DA(1)=STA,DA=ENTRY L +^PRC(411,STA,8):3 E  W $C(7),!,"User is being edited by someone else and was not reinstated as an IFCAP user for station ",STA,"." Q
 .S DIK="^PRC(411,"_DA(1)_",8," D ^DIK K DIK,DIR
 .W !,"This user was reinstated as an IFCAP user for station ",STA,"."
 .S OK=1
 .L -^PRC(411,STA,8)
 I ENTRY=0 W !,"This user was never terminated from IFCAP." G USERIN
 I 'OK G USERIN
 ;
 S DIR("A")="Is this user an A&MM employee",DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  I Y=1 D
 .S DIE="^VA(200,",DR="400;.135",DA=YY L +^VA(200,DA):3 E  W $C(7),!,"User is being edited by someone else and was not added as an A&MM employee." Q
 .D ^DIE K DIE
 .L -^VA(200,YY) W !?5,"To edit the Signature Block printed name or title, use TBOX"
 W !! G USERIN
 QUIT
