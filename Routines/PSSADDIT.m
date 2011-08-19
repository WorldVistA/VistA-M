PSSADDIT ;BIR/RTR/WRT-Manual match Additives to Orderable Items; 09/01/98 7:06
 ;;1.0;PHARMACY DATA MANAGEMENT;**15,32,41,125**;9/30/97;Build 2
 ;
 ;Reference to $$PSJDF^PSNAPIS(P1,P3) supported by DBIA #2531
 ;
 S PSSITE=+$O(^PS(59.7,0)) I +$P($G(^PS(59.7,PSSITE,80)),"^",2)<2 W !!?3,"Orderable Item Auto-Create has not been completed yet!",! K PSSITE,DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR Q
 K PSSITE W !!,"This option enables you to match IV Additives or IV Solutions to the Pharmacy",!,"Orderable Item File." D END
SEL K DIR S PSSSSS=0 S DIR(0)="S^A:ADDITIVES;S:SOLUTIONS",DIR("A")="Match Additives or Solutions" D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) G END
 I Y="S" G ^PSSSOLIT
EN I $D(PSAIEN) L -^PS(52.6,PSAIEN)
 D:$G(PSDELFLG) REMAT^PSSSOLIT D:$G(PSMASTER) END Q:$G(PSSSSS)!($G(PSMASTER))  D END W ! K DIC,PSJOUT S DIC="^PS(52.6,",DIC(0)="QEAMZ",DIC("A")="Select IV ADDITIVE: " D ^DIC K DIC G:Y<0!($D(DTOUT))!($D(DUOUT)) END
MAS ;Entry point for Master Enter/Edit
 S PSAIEN=+Y,PSANAME=$P(Y,"^",2),PSDISP=+$P($G(^PS(52.6,PSAIEN,0)),"^",2),PSPOI=$P($G(^(0)),"^",11) L +^PS(52.6,PSAIEN):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I '$T W !,$C(7),"Another person is editing this additive." Q
 I 'PSDISP W $C(7),!!?5,"This IV Additive does not point to the Dispense Drug File (#50)",!?5,"it cannot be matched to an Orderable Item!",! G EN
ENTER I 'PSPOI G ADD
 S PSOINAME=$P($G(^PS(50.7,PSPOI,0)),"^"),PSOIDOSE=+$P($G(^(0)),"^",2) W !!,"IV ADDITIVE ->  ",PSANAME,!,"  is already matched to:",!,PSOINAME,"    ",$P($G(^PS(50.606,PSOIDOSE,0)),"^")
 W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to re-match this IV Additive",DIR("B")="NO" D ^DIR K DIR I Y'=1 D SELIV^PSSSOLIT G @$S($G(PSSJI)&('$G(PSSIVOUT)):"ENA^PSSVIDRG",1:"EN")
 S PSDELADD=PSAIEN,PSDELOIT=PSPOI,PSDELFLG=1
 K DIE S DA=PSAIEN,DIE="^PS(52.6,",DR="15////"_"@" D ^DIE D EN^PSSPOIDT(PSPOI),EN2^PSSHL1(PSPOI,"MUP") K PSPOI,PSOINAME,PSOIDOSE G ADD
INACT W ! K DIE S PSBEFORE=$P(^PS(50.7,PSPOI,0),"^",4),PSAFTER=0,PSINORDE="" S DIE="^PS(50.7,",DR=".04;.05;.06;.07;.08",DA=PSPOI D ^DIE S PSAFTER=$P(^PS(50.7,PSPOI,0),"^",4) K DIE
 S:PSBEFORE&('PSAFTER) PSINORDE="D" S:PSAFTER PSINORDE="I"
 I PSINORDE'="" D REST^PSSPOIDT(PSPOI)
 K PSBEFORE,PSAFTER,PSINORDE
SYN W ! K DIC S:'$D(^PS(50.7,PSPOI,2,0)) ^PS(50.7,PSPOI,2,0)="^50.72^0^0" S DIC="^PS(50.7,"_PSPOI_",2,",DA(1)=PSPOI,DIC(0)="QEAMZL",DIC("A")="Select SYNONYM: ",DLAYGO=50.7 D ^DIC K DIC
 I Y<0!($D(DTOUT))!($D(DUOUT)) K:'$O(^PS(50.7,PSPOI,2,0)) ^PS(50.7,PSPOI,2,0) Q:$G(NEWFLAG)  D:'$G(PSSSSS) EN2^PSSHL1(PSPOI,"MUP") D END G EN
 W ! S DA=+Y,DIE="^PS(50.7,"_PSPOI_",2,",DA(1)=PSPOI,DR=.01 D ^DIE K DIE G SYN
 Q:$G(NEWFLAG)  D:'$G(PSSSSS) EN2^PSSHL1(PSPOI,"MUP")
 D END G EN
CHECK S (ZZFLAG,ZZXFLAG)=0 F VV=0:0 S VV=$O(^PS(50.7,"ADF",XXX,PSOIDOSE,VV)) Q:'VV  S:VV&($P($G(^PS(50.7,VV,0)),"^",3)) ZZFLAG=VV S:VV&($P($G(^(0)),"^",3))&($D(^PS(52.6,"AOI",VV))) ZZXFLAG=VV
 Q
END I $D(PSAIEN) L -^PS(52.6,PSAIEN)
 K PSDELADD,PSDELFLG,PSDELOIT,PSSSSS
 K DA,DIC,DR,DTOUT,LL,QQ,HOLDOI,INFLAG,NEWFLAG,PSAIEN,PSANAME,PSDISP,PSDOSNM,PSDOSPTR,PSND,PSND1,PSND3,PSONEW,PSNDOSE,PSNEWOI,PSOIDOSE,PSOINAME,PSPOI,SCOUNT,SS,SYN,SYN1,VV,PFLAG,PFLAGOI,WW,X,XXX,Y,ZZFLAG,PANS,ZZXFLAG,SYNNAM,VV,VVV,TT,SCLAST Q
ADD ;
 K PSDOSPTR S PSND=$G(^PSDRUG(PSDISP,"ND")),PSND1=$P(PSND,"^"),PSND3=$P(PSND,"^",3),DA=PSND1,K=PSND3
 I PSND1,PSND3 S X=$$PSJDF^PSNAPIS(DA,K) S PSDOSPTR=$P(X,"^")
 I $G(PSDOSPTR),$D(^PS(50.606,PSDOSPTR,0)) W !?3,"*** Dose Form from NDF:  ",$P($G(^PS(50.606,PSDOSPTR,0)),"^") G PASS
 W ! K DIC S DIC="^PS(50.606,",DIC(0)="QEAMZ",DIC("A")="Select Dose Form: " D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) G EN
 S PSDOSPTR=+Y
PASS S PSDOSNM=$P($G(^PS(50.606,PSDOSPTR,0)),"^"),PSOIDOSE=PSDOSPTR S XXX=PSANAME D CHECK
 I $G(ZZFLAG),'$G(ZZXFLAG) W $C(7),!!,"There is already an Orderable Item named:",!?5,$P($G(^PS(50.7,ZZFLAG,0)),"^"),"   ",$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^"),!
 I  K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Match to this Orderable Item" D ^DIR K DIR I Y["^"!($D(DTOUT)) G EN
 I $G(ZZFLAG),'$G(ZZXFLAG),$G(Y) W !!,"Matching: ",PSANAME,!,"   to",!,$P($G(^PS(50.7,+ZZFLAG,0)),"^")_"   "_PSDOSNM W ! K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this OK" D ^DIR S PANS=Y G:PANS=1 MAT^PSSSUTIL G:(PANS["^")!($D(DTOUT)) EN
 I $G(ZZXFLAG) W $C(7),!!?5,"You must create a new Orderable Item Name for this IV Additive, since a",!?5,"duplicate already exists with another IV Additive matched to it!",!
XDIR W !!,"Additive Name ->  ",$G(PSANAME),!,"Dose Form ->      ",$G(PSDOSNM),!
 S X=PSANAME D INPUT
 K DIR S DIR(0)="F^3:40",DIR("A")="Enter Orderable Item Name" I '$G(ZZXFLAG),'$G(INFLAG),$L(PSANAME)>2,$L(PSANAME)<41 S DIR("B")=PSANAME
 D ^DIR K DIR I Y["^"!(Y="")!($D(DTOUT))!($D(DUOUT)) G EN
 S HOLDOI=X
 D INPUT I INFLAG S X=PSANAME G XDIR
 S (PFLAG,PFLAGOI)=0 F QQ=0:0 S QQ=$O(^PS(50.7,"ADF",X,PSOIDOSE,QQ)) Q:'QQ!(PFLAG)  I QQ,$P($G(^PS(50.7,QQ,0)),"^",3)'="" S PFLAG=1,PFLAGOI=QQ
 I PFLAG,$D(^PS(52.6,"AOI",PFLAGOI)) W $C(7),!!,?2,"A duplicate Name and Dose Form entry already exists in the Orderable Item",!,?2,"File, with a corresponding matched IV Additive. You must select another name!" G XDIR
 I PFLAG,'$D(^PS(52.6,"AOI",PFLAGOI)) W !!,"Matching: ",PSANAME,!,"   to",!,$P($G(^PS(50.7,PFLAGOI,0)),"^")_"   "_$G(PSDOSNM) W ! K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this OK" D ^DIR K DIR G:Y["^"!($D(DTOUT)) EN G:Y=0 XDIR
 I PFLAG,'$D(^PS(52.6,"AOI",PFLAGOI)) S ZZFLAG=PFLAGOI G MAT^PSSSUTIL
NEW  ;create new entry in 50.7 and match to it
 W !!,"Matching: ",PSANAME,!,"  to",!,HOLDOI_"  "_$G(PSDOSNM)
 W ! K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this OK" D ^DIR K DIR W ! I Y'=1 S X=PSANAME G XDIR
 K DIC,DD,DO S DIC="^PS(50.7,",DIC(0)="L",X=HOLDOI,DIC("DR")=".02////"_PSOIDOSE_";.03////"_1 D FILE^DICN K DIC
 I Y<1 W !!?5,"UNABLE TO CREATE ENTRY, TRY AGAIN!",! G XDIR
 S PSNEWOI=+Y S SCOUNT=0 F SS=0:0 S SS=$O(^PS(52.6,PSAIEN,3,SS)) Q:'SS  S SCOUNT=SCOUNT+1,SYN(SCOUNT)=^(SS,0)
 K DIE S DIE="^PS(52.6,",DA=PSAIEN,DR="15////"_PSNEWOI D ^DIE K DIE
 I SCOUNT S ^PS(50.7,PSNEWOI,2,0)="^50.72^"_SCOUNT_"^"_SCOUNT F WW=0:0 S WW=$O(SYN(WW)) Q:'WW  S ^PS(50.7,PSNEWOI,2,WW,0)=SYN(WW)
 I SCOUNT F LL=0:0 S LL=$O(^PS(50.7,PSNEWOI,2,LL)) Q:'LL  S SYNNAM=$P(^(LL,0),"^"),^PS(50.7,PSNEWOI,2,"B",SYNNAM,LL)=""
 S NEWFLAG=1 S PSPOI=PSNEWOI D DIR^PSSPOIM3 I $G(PSSDIR) W !!?3,"Now editing Orderable Item:",!?3,$P(^PS(50.7,PSNEWOI,0),"^"),"   ",$P($G(^PS(50.606,+$P(^(0),"^",2),0)),"^") D INACT K NEWFLAG
 K NEWFLAG,PSSDIR
 D EN^PSSPOIDT(PSPOI) D:'$G(PSSSSS) EN2^PSSHL1(PSNEWOI,"MAD")
 G EN
INPUT S INFLAG=0 I X[""""!($A(X)=45)!('(X'?1P.E))!(X?2"z".E) W $C(7),!?5,"??",! S INFLAG=1
 Q
