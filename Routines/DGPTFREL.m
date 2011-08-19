DGPTFREL ;ALB/JDS - DATA RELEASE ;1/25/05 12:22pm
 ;;5.3;Registration;**635**;Aug 13, 1993
 ;
 D LO^DGUTL
ASK L ^DGP(45.83):3 I '$T W !,"Cannot release while transmitting" Q
 L  W !! K DIC I '$D(DGRTY) S Y=1 D RTY^DGPTUTL
 S DIC("A")="Release "_$P(DGRTY0,U)_" Record: ",DIC="^DGP(45.84,",DIC(0)="EQMZA"
 S DIC("S")="I '$D(^DGP(45.83,""C"",+Y)),$D(^DGPT(+Y,0)),$P(^(0),U,11)="_DGRTY
 D ^DIC K DIC G Q:Y'>0 S (DA,DGPTIFN,PTF)=+Y
 ;
EN ; -- entry point
 S DGREL=^DGP(45.84,DGPTIFN,0),DGPTF=^DGPT(DGPTIFN,0),DFN=+DGPTF,DGPT=^DPT(DFN,0),Y=$P(DGREL,U,2) D D^DGPTUTL
REL ;
 W !!,"Release ",$P(DGRTY0,U)," record #",DGPTIFN," for:",!?5,$P(DGPT,U,1)," - ",$P(DGPT,U,9),"  Closed ",Y S %=2 D YN^DICN
 I '% W !!,"Enter 'Y' if this is the ",$P(DGRTY0,U)," record you wish to release for transmission",!,"to Austin, 'N' or <RET> if not.",! G REL
 G Q:%'=1
 I '$D(^DGP(45.83,DT,0)) S (DINUM,X)=DT,DIC="^DGP(45.83,",DIC(0)="L" K DD,DO D FILE^DICN K DINUM,DIC I Y=-1 W !,*7,"Cannot continue without proper FileMan access.  Please see your supervisor." G Q
 L +^DGPT(45,DGPTIFN):2
 I '$T W !,"Patient is being edited by another user" H 2 G Q
 I '($D(^DGP(45.83,DT,"P",0))#2) S ^DGP(45.83,DT,"P",0)="^45.831PA^0^0"
 I $P(^DGP(45.83,DT,0),U,2) S DA=DT,DIE="^DGP(45.83,",DR="1///@" D ^DIE K DIE
 ;S DA=DGPTIFN,DA(1)=DT,DR=".01///"_DGPTIFN,DP=45.831,DIE="^DGP(45.83,"_DT_",""P""," D ^DIE ; old code left for reference
 S (DINUM,X)=DGPTIFN,DIC(0)="L",DA(1)=DT,DIC="^DGP(45.83,"_DT_",""P""," D FILE^DICN K DINUM,DIC,DA
 S DA=DGPTIFN,DIE="^DGP(45.84,",DR="4////"_DT_";5////"_DUZ D ^DIE
 D MOB^DGPTFM2,ICDINFO^DGAPI(DFN,PTF),XREF^DGPTFM21
 S DR=".07////1"
 F DGZP=1:1 Q:'$D(DGZPRF(DGZP))  D
 .I '$P(DGZPRF(DGZP),U,7),$$DATA2PCE^DGAPI1(DFN,DGPTIFN,DGZP) D ERR:RES<-1,^DIE:RES>-2
 W !!,"****** ",$P(DGRTY0,U)," RECORD RELEASED ******",!
 L -^DGPT(45,DGPTIFN) D HANG^DGPTUTL
 I DGRTY=1 D ^A1B2MAIN
 I $D(DRGCAL)!$D(DGPTFLE) G CEN
 G ASK
 ;
CEN ; -- does census also need to be released if releasing PTF in Load/Edit
 I $D(DGPTFLE),DGRTY=1,$D(DGCST),DGCST=1,$D(DGCI) W !!,*7,"Census Record #",DGCI," also needs to be 'released'." S DGPTIFN=DGCI,Y=2 D RTY^DGPTUTL G EN
 ;
Q K DGRTY,DGRTY0,DGPTIFN,DGPTFLE,DGREL,DGPTF,DFN,DGPT,A,DIE,DIC,DA,Y,%,X,DR,DP
 D Q1^DGPTF Q
ERR W @IOF
 F I=1:1 Q:'$D(^TMP("DGPAPI",$J,"DIERR",$J,1,"TEXT",I))  W !,^(I)
 W !,"Press return to continue." R X:DTIME Q
 ;
