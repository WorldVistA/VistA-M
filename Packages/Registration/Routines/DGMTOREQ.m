DGMTOREQ ;ALB/TET,CAW,CKN - List Means Test Status  ; 5/6/92 ; 07/22/02 11:00am
 ;;5.3;Registration;**33,100,166,182,456**;Aug 13, 1993
EN ;Entry point to list required/pending means tests
ST ;select means test status
 I DGMTYPT=1 S DIC("S")="I ""^R^P^""[$P(^(0),U,2)&($P(^(0),U,19)=DGMTYPT)"
 I DGMTYPT=2 S DIC("S")="I ""^I^P^""[$P(^(0),U,2)&($P(^(0),U,19)=DGMTYPT),$$ACT^DGMTDD(Y,DT)",DIC("B")=9 ;Screen Status for Active
ST1 S DIC(0)="AEQMZ",DIC="^DG(408.32,"
 S DIC("A")="Select "_$S(DGMTYPT=1:"MEANS",1:"COPAY")_" TEST STATUS NAME: "
 D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT)) EXIT G:Y'>0 ST
 S DGCAT(+Y)=$P(Y,U,2)
 ;
DTB ;select beginning date
 S DIR(0)="DO^::EX",DIR("A")="Enter Beginning Date",DIR("?")="^D HELP^%DTC" D ^DIR K DIR G:$D(DIRUT) EXIT S DGBEG=Y
 I DGBEG>DT W !,"   Future dates are not allowed.",*7 K DGBEG G DTB
 ;select ending date
 S DIR(0)="D^"_DGBEG_":NOW:EX",DIR("A")="Enter Ending Date",DIR("?")="^D HELP^%DTC" D ^DIR K DIR G:$D(DIRUT) EXIT
 S DGEND=Y
 ;S DGBEG=DGBEG-.1,DGEND=Y_.9
Q ;select device and print
 S DGVAR="DGCAT#^DGBEG^DGEND^DGMTYPT",DGPGM="DQ^DGMTOREQ"
 D ZIS^DGUTQ G EXIT:POP U IO
DQ ;gather data and print
 S DGC=$O(DGCAT(0)),DGCRT=$S($E(IOST,1,2)="C-":1,1:0)
 S DGBEGE=$$DATE(DGBEG),DGENDE=$$DATE(DGEND),$P(DGDASH,"=",IOM-1)="",DGPG=0
 S DGC(1)=$S(DGMTYPT=1:"MEANS",1:"COPAY")_" TEST STATUS Report",DGC(2)="STATUS:  "_DGCAT(DGC)
 S DGC(3)="From "_DGBEGE_" Through "_DGENDE
 ;flag for new column if Means test type is 1 and report selection is for pending means test data
 S CFLG=0 I (DGMTYPT=1)&(DGC=2) S CFLG=1
SORT ;sort data into tmp global
 I '$D(^DGMT(408.31,"AS",DGMTYPT,DGC)) S DGM="No patients found with "_$S(DGMTYPT=1:"means",1:"copay")_" test status of "_DGCAT(DGC)_"." D HDR W !!?10,DGM G EXIT
 S DGD=-(DGEND+.9) F  S DGD=$O(^DGMT(408.31,"AS",DGMTYPT,DGC,DGD)) Q:'DGD!(DGD>-DGBEG)  D
 .S DFN=0 F  S DFN=$O(^DGMT(408.31,"AS",DGMTYPT,DGC,DGD,DFN)) Q:'DFN  S DGSSN=$$PID(DFN),DGDPT0=$G(^DPT(DFN,0)) I DGDPT0]"" S DGNM=$S($P(DGDPT0,U)]"":$P(DGDPT0,U),1:DFN) D
 ..S DGDA=0 F  S DGDA=$O(^DGMT(408.31,"AS",DGMTYPT,DGC,DGD,DFN,DGDA)) Q:'DGDA  D
 ...Q:'$G(^DGMT(408.31,DGDA,"PRIM"))
 ...S DGMT0=$G(^DGMT(408.31,DGDA,0)) Q:'DGMT0
 ...S ^TMP($J,"DGMTO",DGNM,DFN,DGDA)=DGSSN_U_$P(DGMT0,U)_U_$$SR^DGMTAUD1(DGMT0)
 ...I CFLG D
 ....S PENDA=$$PA^DGMTUTL(DGDA)
 ....S ^TMP($J,"DGMTO",DGNM,DFN,DGDA)=$G(^TMP($J,"DGMTO",DGNM,DFN,DGDA))_U_PENDA
 I $O(^TMP($J,"DGMTO",0))']"" S DGM="No patients found for requested date range." D HDR W !!?10,DGM G EXIT
PRINT ;print data from tmp global
 D HDR
 S DGNM=0 F  S DGNM=$O(^TMP($J,"DGMTO",DGNM)) Q:DGNM=""  D  G:$D(DIRUT) EXIT
 .S DFN=0 F  S DFN=$O(^TMP($J,"DGMTO",DGNM,DFN)) Q:'DFN  D  Q:$D(DIRUT)
 ..S DGDA=0 F  S DGDA=$O(^TMP($J,"DGMTO",DGNM,DFN,DGDA)) Q:'DGDA  D:$Y+10>IOSL PAGE Q:$D(DIRUT)  D
 ...S DG0=^TMP($J,"DGMTO",DGNM,DFN,DGDA)
 ...W !,DGNM,?24,$$PID($P(DG0,U)),?38,$P(DG0,U,3),?54,$$DATE($P(DG0,U,2))
 ...I CFLG W ?71,$P(DG0,U,4)
EXIT ;clean up and quit
 I +$G(DGCRT),$Y'>(IOSL-10) D CR
 K DFN,DG0,DGBEG,DGBEGE,DGC,DGCAT,DGCRT,DGD,DGDA,DGDPT0,DGDASH,DGEND,DGENDE,DGJ,DGM,DGMT0,DGMTYPT,DGNM,DGPG,DGSSN,DIC,DIR,DTOUT,DUOUT,DIRUT,VAERR,X,Y,PENDA,CFLG
 D CLOSE^DGMTUTL,^%ZISC
 K ^TMP($J)
 Q
HDR ;header
 I DGPG=0,DGCRT W @IOF
 F I=1:1:3 W !?(IOM-$L(DGC(I))/2),DGC(I)
 S DGPG=DGPG+1 W !?66,"Page ",DGPG,!,DGDASH,!
 W !?38,$S(DGMTYPT=1:"Means",1:"Copay")_" Test",?56,"Date of"
 I CFLG W ?67,"Pend. Adj."
 W !,"Patient Name",?24,"Patient ID",?40,"Source",?58,"Test"
 I CFLG W ?69,"Status"
 W !,"------------",?24,"----------",?38,"----------",?56,"-------"
 I CFLG W ?67,"----------"
 Q
DATE(X) ;function to return date in external format
 ;INPUT -  FM internal date format
 ;OUTPUT - external date format
 Q $$FMTE^XLFDT($E(X,1,12),1)
 ;
PID(X) ;function to return pid
 ;INPUT -  DFN
 ;OUTPUT - PID or UNKNOWN
 D PID^VADPT6
 Q $S(VA("PID")]"":VA("PID"),1:"UNKNOWN")
 ;
CR ;read for display
 S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) DIRUT=1
 Q
PAGE ;new page
 I DGCRT D CR Q:$D(DIRUT)
 W @IOF
 D HDR
 Q
