ECXAPRO2 ;ALB/JAP - PRO Extract Audit Report (cont) ;3/14/13  14:44
 ;;3.0;DSS EXTRACTS;**9,21,39,144,154**;Dec 22, 1997;Build 13
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
 W !,?5,"2.   ARTIFICIAL LEGS"
 W !,?5,"3.   ARTIFICIAL ARMS AND TERMINAL DEVICES"
 W !,?5,"4.   BRACES AND ORTHOTICS"
 W !,?5,"5.   SHOES/ORTHOTICS"
 W !,?5,"6.   NEUROSENSORY AIDS"
 W !,?5,"7.   RESTORATIONS"
 W !,?5,"8.   OXYGEN AND RESPIRATORY"
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
 N BR,BRC,CODE,CNT,ECXPORT ;144
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
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I ECXPORT D  Q  ;144
 .K ^TMP($J) ;144
 .S ^TMP($J,"ECXPORT",0)="EXTRACT LOG #^NPPD GROUP^NPPD LINE^NAME^SSN^HCPCS^QTY^TYPE^COST^DATE^HCPCS DESC^STATION #^NPPD ENTRY DATE" ;144
 .S CNT=1 ;144
 .D PROCESS^ECXAPRO ;144
 .D DISP ;144
 .D EXPDISP^ECXUTL1
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
 N JJ,SS,LN,PG,COST,DATE,DESC,HCPCS,LOC,PTNAM,QFLG,QTY,RDX,RDXX,SSN,TYPE,DIR,DIRUT,DTOUT,DUOUT,NPPDED ;NPPD ENT DATE CVW 144
 U IO
 S (QFLG,PG)=0,$P(LN,"-",81)=""
 I '$G(ECXPORT) D HEADER ;144
 I '$D(^TMP($J,ECXCODE)) D  Q
 .I $G(ECXPORT) Q  ;144 Stop processing if exporting
 .W !,?14,"No data available.",!
 .I $E(IOST)="C",'QFLG D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" D ^DIR K DIR
 S RDX=0
 F  S RDX=$O(^TMP($J,ECXCODE,RDX)) Q:RDX'>0  Q:QFLG  D
 .S RDXX=^TMP($J,ECXCODE,RDX)
 .S PTNAM=$P(RDXX,U,9),SSN=$P(RDXX,U,10)
 .I '$G(ECXPORT) D:($Y+3>IOSL) HEADER Q:QFLG  ;144 Don't display if exporting
 .S TYPE=$P(RDXX,U,1),TYPE=$S(TYPE="X":"R",1:"I")_" "_$P(RDXX,U,2)
 .S QTY=+$P(RDXX,U,3),COST=$P(RDXX,U,4),HCPCS=$P(RDXX,U,7),DESC=$P(RDXX,U,8),DATE=$P(RDXX,U,11),LOC=$P(RDXX,U,12),NPPDED=$P(RDXX,U,13) ;144 CVW
 .I $G(ECXPORT) S ^TMP($J,"ECXPORT",CNT)=ECXEXT_U_ECXCODE_U_^TMP($J,"RMPRCODE",ECXCODE)_U_PTNAM_U_SSN_U_HCPCS_U_QTY_U_TYPE_U_COST_U_DATE_U_DESC_U_LOC_U_NPPDED,CNT=CNT+1 Q  ;144
 .W !,PTNAM,?5,SSN,?10,HCPCS,?17,QTY,?26,TYPE,?30,COST,?37,DATE,?43,DESC,?64,LOC,?72,NPPDED ;144 CVW
 I $G(ECXPORT) Q  ;144 Stop processing if exporting
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
 W !,LN,!,ECXCODE," -- ",^TMP($J,"RMPRCODE",ECXCODE),?74,"NPPD"
 W !,"NAME",?5,"SSN",?10,"HCPCS",?17,"QTY",?26,"TYP",?30,"COST",?37,"DATE",?43,"HCPCS DESC",?64,"STN#",?72,"ENTRY DT"
 W !,LN,!
 Q
