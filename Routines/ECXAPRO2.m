ECXAPRO2 ;ALB/JAP - PRO Extract Audit Report (cont) ; Nov 16, 1998
 ;;3.0;DSS EXTRACTS;**9,21,39**;Dec 22, 1997
 ;
ASK ;further detail needed?
 K X,Y
 W !
 S DIR(0)="Y",DIR("A")="Do you want to see details on this audit report",DIR("B")="NO"
 D ^DIR K DIR
 Q:($G(Y)=0)!$D(DUOUT)!($D(DTOUT))
 ;allow user to expand as many lines as needed
 F  D ASK2 Q:$D(DUOUT)!($D(DTOUT))
 Q
 ;
ASK2 ;select nppd group to be expanded
 D CODE
 W @IOF,!
 W !,?5,"1.   WHEELCHAIRS AND ACCESSORIES"
 W !,?5,"2.   ARTIFICAL LEGS"
 W !,?5,"3.   ARTIFICAL ARMS AND TERMINAL DEVICES"
 W !,?5,"4.   BRACES AND ORTHOTICS"
 W !,?5,"5.   SHOES/ORTHOTICS"
 W !,?5,"6.   NEUROSENSORY AIDS"
 W !,?5,"7.   RESTORATIONS"
 W !,?5,"8.   OXYGEN AND RESPIRATIORY"
 W !,?5,"9.   MEDICAL EQUIPMENT, MISC., ALL OTHER NEW"
 W !,?5,"10.  REPAIR",!!
 S DIR(0)="N^1:10:0"
 S DIR("A")="Select NPPD Group "
 D ^DIR K DIR
 Q:$D(DUOUT)!($D(DTOUT))
 D ASK3(Y)
 Q:$D(DTOUT)
 K DIRUT,DTOUT,DUOUT
 G ASK2
 Q
 ;
ASK3(ECXY) ;select nppd line item
 N BR,BRC,CODE
 S BR=0,BRC=0 K CODE W @IOF
 F  S BR=$O(^TMP($J,"RMPRCODE",BR)) Q:BR=""  I $L(BR)>3 D
 .I $E(BR,1,1)=ECXY S BRC=BRC+1 W !?5,BRC_".",?10,BR,?18,^TMP($J,"RMPRCODE",BR) S CODE(BRC,BR)=""
 .I ($E(BR,1,1)="R")&(ECXY=10) S BRC=BRC+1 W !?5,BRC_".",?10,BR,?18,^TMP($J,"RMPRCODE",BR) S CODE(BRC,BR)=""
 W !
 S DIR(0)="N^1:"_BRC_":0"
 S DIR("A")="Select NPPD Line "
 D ^DIR K DIR
 Q:$D(DUOUT)!($D(DTOUT))
 S ECXCODE="",ECXCODE=$O(CODE(Y,ECXCODE))
 S ECXPGM="TASK^ECXAPRO",ECXDESC="PRO Extract Audit Detail"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")="",ECXSAVE("ECXREPT")="",ECXSAVE("ECXPRIME")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXCODE")=""
 W !
 ;determine output device and queue if requested
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE) I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .I '$D(^TMP($J,"RMPRGN")) D PROCESS^ECXAPRO
 .D DISP
 I $D(IO(0)) I IO(0)'=IO D ^%ZISC
 D HOME^%ZIS
 Q
 ;
CODE ;setup nppd codes
 ;intended to duplicate code^rmprn63
 N NULINE
 Q:$D(^TMP($J,"RMPRCODE"))
 F I=1:1 S NULINE=$P($T(TEXT+I^ECXAPRO3),";;",2) Q:NULINE["QUIT"  D
 .S ^TMP($J,"RMPRCODE",$P(NULINE,";",1))=$P(NULINE,";",2)
 Q
 ;
DISP ;display all records within nppd code group
 ;based on desp^rmprn6pl
 N JJ,SS,LN,PG,COST,DATE,DESC,HCPCS,LOC,PTNAM,QFLG,QTY,RDX,RDXX,SSN,TYPE,DIR,DIRUT,DTOUT,DUOUT
 U IO
 S (QFLG,PG)=0,$P(LN,"-",80)=""
 D HEADER
 I '$D(^TMP($J,ECXCODE)) D  Q
 .W !,?14,"No data available.",!
 .I $E(IOST)="C",'QFLG D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" D ^DIR K DIR
 S RDX=0
 F  S RDX=$O(^TMP($J,ECXCODE,RDX)) Q:RDX'>0  Q:QFLG  D
 .S RDXX=^TMP($J,ECXCODE,RDX)
 .S PTNAM=$P(RDXX,U,9),SSN=$P(RDXX,U,10)
 .D:($Y+3>IOSL) HEADER Q:QFLG
 .S TYPE=$P(RDXX,U,1),TYPE=$S(TYPE="X":"R",1:"I")_" "_$P(RDXX,U,2)
 .S QTY=+$P(RDXX,U,3),COST=$P(RDXX,U,4),HCPCS=$P(RDXX,U,7),DESC=$P(RDXX,U,8),DATE=$P(RDXX,U,11),LOC=$P(RDXX,U,12)
 .W !,PTNAM,?6,SSN,?13,HCPCS,?20,QTY,?30,TYPE,?36,COST,?45,DATE,?52,DESC,?74,LOC
 I $E(IOST)="C",'QFLG D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" D ^DIR K DIR
 Q
 ;
HEADER ;header and page control
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report Detail",?72,"Page ",PG
 W !,"DSS Extract Log #:       "_ECXEXT
 W !,"Date Range of Audit:     "_ECXARRAY("START")_" to "_ECXARRAY("END")
 I ECXALL=1 W !,"Station:                 "_$P(ECXDIV,U,2)_" ("_$P(ECXDIV,U,3)_")"
 I ECXALL=0 W !,"Division:                "_$P(ECXDIV,U,2)_" ("_$P(ECXDIV,U,3)_")"
 W !,"Report Run Date/Time:    "_ECXRUN
 W !,LN,!,ECXCODE," -- ",^TMP($J,"RMPRCODE",ECXCODE)
 W !,"NAME",?6,"SSN",?13,"HCPCS",?20,"QTY",?30,"TYPE",?36,"COST",?45,"DATE",?52,"HCPCS DESC",?74,"STN #"
 W !,LN,!
 Q
