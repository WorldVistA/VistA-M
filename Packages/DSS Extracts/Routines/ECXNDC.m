ECXNDC ;ALB/JAP BIR/CML - Lookup Routine for NDC's ; 6/7/05 1:52pm
 ;;3.0;DSS EXTRACTS;**10,11,24,84**;Dec 22, 1997
EN ;entry point from option
 N F5068,QFLG
 S F5068=0 I $T(PSNAPIS+1^PSNAPIS)[";;4.0;" S F5068=1
 W @IOF
 W !!,"Pharmacy Feeder Keys for DSS are built in the following manner."
 I 'F5068 D NDF3 Q:QFLG
 I F5068 D NDF4 Q:QFLG
 W @IOF
 W !,"This option will allow lookups on the local DRUG file (#50) using "
 W !,"NDCs from DSS Pharmacy Feeder Keys that have been rejected because"
 I 'F5068 D
 .W !,"the first seven characters are zeros. (Ex. ""0000000051079014120"")"
 I F5068 D
 .W !,"the first five characters are zeros in a 17 character Feeder Key."
 .W !,"(Ex. ""00000051079014120"")"
 .W !,"OR"
 .W !,"the first seven characters are zeros in a 19 character Feeder Key."
 .W !,"(Ex. ""0000000051079014120"")"
 W !!,"This would occur when a pharmacy item has not been matched to the"
 W !,"the National Drug File (NDF)."
 W !!,"Enter the NDC (last twelve characters) from a rejected feeder key"
 W !,"to display information from the local DRUG file for any drug which"
 W !,"has that NDC."
 D ASK
 K %,%H,%Y,DRG,DRGNM,ECD,LN,POP,X,Y,DUOUT,DTOUT
 Q
ASK ;select ndc for lookup
 K DUOUT,DTOUT
 W !!!,"Enter 12 numeric characters at the prompt or <cr> to exit.",!
 S DIC=50,DIC(0)="QEA",D="NDC",DIC("A")="Select NDC: "
 ;Use pharmacy encapsulation API for MIX^DIC1 dbia 4551
 D MIX^PSSDI(50,"ECX",.DIC,D,,)
 Q:Y<0  Q:($D(DUOUT)!$D(DTOUT))
 S DRG=+Y
 ;Use pharmacy encapsulation API for EN^DIQ1 dbia 4451
 S DIQ="ECXDIQ",DIQ(0)="E" D EN^PSSDI(50,"DSS",DIC,".01;2;31;14.5;16",DRG,.DIQ)
 K LN S DRGNM=ECXDIQ(50,DRG,.01,"E"),$P(LN,"-",$L(DRGNM)+1)=""
 W !!,DRGNM,!,LN
 W !,"NDC:           ",ECXDIQ(50,DRG,31,"E"),?40,"VA Classification:       ",ECXDIQ(50,DRG,2,"E")
 W !,"Dispense Unit: ",ECXDIQ(50,DRG,14.5,"E"),?40,"Price per Dispense Unit: ",ECXDIQ(50,DRG,16,"E")
 K ECXDIQ,X,Y,DIC,DIQ,DRG,ECXDIQ,D
 G ASK
 ;
NDF3 ;before ndf v4
 S QFLG=0
 W !!,"Your site is running NATIONAL DRUG FILE (NDF) v3.18, so"
 W !,"PHA Feeder Keys are composed of 19 numeric characters."
 W !!?5,"Ex. ""0016006000003073531""   where characters:"
 W !!?5,"1-4 (0016)          = pointer to the NATIONAL DRUG file (#50.6)"
 W !?5,"5-7 (006)           = pointer to VA PRODUCT NAME subfile (#50.68)"
 W !?5,"                      of the NATIONAL DRUG file (#50.6)"
 W !?5,"8-19 (000003073531) = NDC from the local DRUG file (#50)"
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q
 ;
NDF4 ;after ndf v4
 S QFLG=0
 W !!,"Your site is running NATIONAL DRUG FILE (NDF) v4.0."
 W !,"If Pharmacy data is dated after September 30, 1998,"
 W !,"then PHA Feeder Keys are composed of 17 numeric characters."
 W !!?5,"Ex. ""12006000003073531""   where characters:"
 W !?5,"1-5 (12006)         = pointer to VA PRODUCT NAME file (#50.68)"
 W !?5,"6-17 (000003073531) = NDC from the local DRUG file (#50)"
 W !!,"If Pharmacy data is dated prior to October 1, 1998,"
 W !,"then PHA Feeder Keys are composed of 19 numeric characters."
 W !!?5,"Ex. ""0016006000003073531""   where characters:"
 W !!?5,"1-4 (0016)          = pointer to the NATIONAL DRUG file (#50.6)"
 W !?5,"5-7 (006)           = pointer to VA PRODUCT NAME subfile (#50.68)"
 W !?5,"                      of the NATIONAL DRUG file (#50.6)"
 W !?5,"8-19 (000003073531) = NDC from the local DRUG file (#50)"
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q
