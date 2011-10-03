PSSLAB ;BIR/JMB,WRT ; 09/02/97 7:57; 5/6/94
 ;;1.0;PHARMACY DATA MANAGEMENT;;9/30/97
EDIT ;Mark/unmark drugs to print on profile
 S (IEN50,DA)=DISPDRG
 D:LMFLAG=1 UNMRK
 Q:NFLAG  Q:$D(DTOUT)  Q:$D(DIRUT)  Q:$D(DUOUT)
 I +$P($G(^PSDRUG(IEN50,"I")),"^") S Y=$P($G(^PSDRUG(IEN50,"I")),"^") X ^DD("DD") W !,"** Drug inactivated "_Y_"."
 I $P($G(^PSDRUG(IEN50,"CLOZ1")),"^")="PSOCLO1" W $C(7),$C(7),!!,"This drug is marked for Clozapine monitoring. To print the most",!,"recent lab result on the profile, the drug must be unmarked",!,"for Clozapine monitoring."  D REASK
ED Q:CLFLAG  Q:NFLAG  Q:$D(DIRUT)  Q:$D(DTOUT)  Q:$D(DUOUT)  S LIEN=+$P($G(^PSDRUG(IEN50,"CLOZ")),"^")
 W !,"** You are NOW editing LAB MONITOR fields. **"
 W ! K DIC S DIC(0)="QEAM",DIC("A")="Select LAB TEST MONITOR: ",DIC="^LAB(60,",DIC("B")=$P($G(^LAB(60,LIEN,0)),"^") D ^DIC K DIC
 G:(Y<0)!($G(DIRUT)) EXIT S LIEN=+Y
 I $S($P($P($G(^LAB(60,LIEN,0)),"^",5),";",2)="":1,1:0) W !!,$C(7),"Missing DATA NAME Probably a panel test.  Please select another." G ED
SPEC S DIE="^PSDRUG(",DA=IEN50,DR="17.2////^S X=LIEN" D ^DIE K DIE
 W !!,?5,"Now editing:",!
 S DIE="^PSDRUG(",DA=IEN50,DR="17.2;17.4;17.3" D ^DIE S $P(^PSDRUG(IEN50,"CLOZ1"),"^",2)=1 S LMFLAG=1,NFLAG=1 K DIE
 G:$D(DTOUT)!($D(DUOUT)) EXIT
 I $P($G(^PSDRUG(DA,"CLOZ")),"^")=""&($P($G(^("CLOZ")),"^",2)="")&($P($G(^("CLOZ")),"^",3)="") S ^PSDRUG(IEN50,"CLOZ1")="" G EDIT
 I $P(^PSDRUG(DA,"CLOZ"),"^")=""!($P(^("CLOZ"),"^",2)="")!($P(^("CLOZ"),"^",3)="") S ^PSDRUG(IEN50,"CLOZ1")="" W !!,$C(7),"Insufficient data.",!,"All fields must have an entry or all fields must be blank.",! S LMFLAG=0 G ED
EXIT K IEN50,LIEN Q
PRINT ;Prints most recent lab test value on profile.
 I '$D(^DPT(DFN,"LR")) W !,"*** NO LAB DATA ON FILE ***" Q
 S LRDFN=+$P(^DPT(DFN,"LR"),"^") Q:'LRDFN
 S MDRUG=+$P(RX0,"^",6),TST=+$P(^PSDRUG(MDRUG,"CLOZ"),"^"),MDAYS=+$P(^("CLOZ"),"^",2),TSTSP=+$P(^("CLOZ"),"^",3)
 G:'TST!('MDAYS)!('TSTSP) CLEAN
 S TSTN=$P($G(^LAB(60,TST,0)),"^"),LDN=$S($D(^(.2)):+^(.2),1:+$P($P($G(^(0)),"^",5),";",2))
 I $G(^LAB(60,TST,.2))=""&($P($P($G(^LAB(60,TST,0)),"^",5),";",2)="") W !,"*** RESULTS FOR A PANEL CANNOT BE PRINTED! ONLY A LAB TEST RESULT CAN BE PRINTED FOR MARKED DRUGS." G CLEAN
EDATE S X="T-"_MDAYS K %DT D ^%DT S EDT=Y,EDL=(9999999-EDT)_".999999",INDIC=0
BEG F BDL=0:0 S BDL=$O(^LR(LRDFN,"CH",BDL)) Q:BDL=""!(BDL>EDL)  D  Q:INDIC=1
 .Q:'$D(^LR(LRDFN,"CH",BDL,LDN))!('$D(^(0)))
 .Q:$P(^LR(LRDFN,"CH",BDL,0),"^",3)=""!($P(^(0),"^",5)'=TSTSP)
 .S Y=$S(+$P($P(^LR(LRDFN,"CH",BDL,0),"^"),"."):+$P($P(^(0),"^"),"."),1:$P(^(0),"^",3))
 .W !,"*** MOST RECENT "_$G(TSTN)_" PERFORMED "_$E(Y,4,5)_"-"_$E(Y,6,7)_"-"_$E(Y,2,3)_" = "_+$P($G(^LR(LRDFN,"CH",BDL,LDN)),"^")_" "_$P($G(^LAB(60,TST,1,TSTSP,0)),"^",7) S INDIC=1
 W:INDIC=0 !,"*** NO RESULTS FOR "_TSTN_" SINCE "_$E(EDT,4,5)_"-"_$E(EDT,6,7)_"-"_$E(EDT,2,3)
CLEAN K BDL,EDL,EDT,INDIC,LDN,LRDFN,MDAYS,MDRUG,TST,TSTN,TSTSP,X,Y
 Q
UNMRK I $P($G(^PSDRUG(IEN50,"CLOZ1")),"^",2)=1 S DIR(0)="Y",DIR("A",1)="",DIR("A",2)="Are you sure you want to unmark "_$P(^PSDRUG(IEN50,0),"^"),DIR("A")="as a Lab Monitor drug",DIR("B")="N" D UNMRK0
 Q
UNMRK0 D ^DIR Q:$D(DIRUT)  Q:$D(DTOUT)  Q:$D(DUOUT)  D UNMRK1
 Q
UNMRK1 I "Yy"[X S LMFLAG=0,DR="17.6///@",DIE="^PSDRUG(" D ^DIE W:LMFLAG=0 !!,$P(^PSDRUG(IEN50,0),"^")_" is now unmarked as a Lab Monitor drug" D ASKEM
 Q
REASK G MONCLOZ^PSSDEE
ASKEM K DIR,X,Y,DIRUT,DTOUT,DUOUT W !!,"Do you wish to mark this drug as a Clozapine drug?" S DIR(0)="Y" D ^DIR
 Q:$D(DTOUT)  Q:$D(DUOUT)  Q:$D(DIRUT)
 I "Nn"[X S NFLAG=1 K DIR,X,Y Q
 I "Yy"[X D CLOZ^PSSDEE
