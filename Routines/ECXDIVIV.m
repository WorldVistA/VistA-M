ECXDIVIV ;BIR/CML-Enter/Edit and Print IV Room Division ; 3/13/07 10:48am
 ;;3.0;DSS EXTRACTS;**8,105**;Dec 22, 1997;Build 70
 ;
ED ;enter/edit division field for iv rooms
 N CHKFLG,DIC,DIE,DA,DR
 W !!,"This option allows editing of the DIVISION field for IV Rooms.",!
 S CHKFLG=0,OUT=0
 D CHK Q:CHKFLG
 F  D  Q:OUT
 .W ! S DIC=59.5,DIC(0)="QEAMZ" D ^DIC
 .I Y<0 S OUT=1 Q
 .I $G(^PS(59.5,+Y,"I"))]"" W "   *INACTIVE*",$C(7)
 .S DIE=DIC,DA=+Y
 .S DR=.02 D ^DIE K DA
 Q
 ;
PRT ;print worksheet
 W !!,"This option will produce a worksheet listing all entries in the IV Room file"
 W !,"(#59.5).  It should be used to help DSS and Pharmacy services define and"
 W !,"review the DIVISION assignments for each IV Room.",!! S QFLG=0
 S QFLG=0,CHKFLG=0
 D CHK Q:CHKFLG
 D EN^XUTMDEVQ("START^ECXDIVIV","DSS - IV Room List")
 I POP D
 .W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
 .D PAUSE
 K ^TMP($J,"ECXDSS")
 Q
 ;
START ;queued entry point
 N CHKFLG,DIV,DIVNM,INACT,IV,IVRM,JJ,LN1,LN2,PDT,PG,QFLG,SS,X,Y
 I '$D(DT) S DT=$$HTFM^XLFDT(+$H)
 K ^TMP("ECXDIVIV",$J),^TMP($J,"ECXDSS") S QFLG=0,IV=0
 ;call pharmacy encapsulation api and return all iv rooms information
 D ALL^PSJ59P5(,"??","ECXDSS")
 F  S IV=$O(^TMP($J,"ECXDSS",IV)) Q:'IV  D
 .S IVRM=$G(^TMP($J,"ECXDSS",IV,.01)),DIV=$P($G(^(.02)),U)
 .S DIVNM=$S(DIV="":"ZZZ",1:$E($P(^DG(40.8,DIV,0),U),1,30))
 .K INACT I $P($G(^TMP($J,"ECXDSS",IV,19)),U)]"" S INACT=$P(^(19),U,2)
 .S ^TMP("ECXDIVIV",$J,DIVNM,IVRM)=$S($D(INACT):INACT,1:"")
 ;print report
 S PG=0,PDT=$$FMTE^XLFDT(DT),$P(LN1,"-",81)="",$P(LN2,"_",30)=""
 D HDR
 I '$D(^TMP("ECXDIVIV",$J)) W !!,"No Data found for this worksheet."
 I $D(^TMP("ECXDIVIV",$J)) S DIVNM="" D
 .F  S DIVNM=$O(^TMP("ECXDIVIV",$J,DIVNM)) Q:DIVNM=""  Q:QFLG  D
 ..S IVRM=""
 ..F  S IVRM=$O(^TMP("ECXDIVIV",$J,DIVNM,IVRM)) Q:IVRM=""  Q:QFLG  D
 ...S INACT=^TMP("ECXDIVIV",$J,DIVNM,IVRM)
 ...D:$Y+4>IOSL HDR Q:QFLG
 ...W !!,IVRM,?34,$S(DIVNM="ZZZ":LN2,1:DIVNM),?60,INACT
 I $E(IOST)="C"&('QFLG) D PAUSE
 K ^TMP("ECXDIVIV",$J) S:$D(ZTQUEUED) ZTREQ="@"
 W:$E(IOST)'="C" @IOF
 D ^%ZISC
 Q
 ;
HDR ;header
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1
 Q:QFLG
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF
 W !,"IV Room Worksheet",?72,"Page: ",PG,!,"Printed ",PDT
 W !!,"IV ROOM",?34,"DIVISION",?60,"INACTIVE DATE",!,LN1
 Q
 ;
CHK ;check for existence of necessary files for division functionality
 S CHKFLG=0
 D ALL^PSJ59P5(,"??","ECXIV")
 I '$O(^TMP($J,"ECXIV",0)) D  I CHKFLG D EXIT Q
 .W !,"The IV Room file (#59.5) does not exist!"
 .S CHKFLG=1 D PAUSE
 I '$D(^ECX(728.113,0)) D  I CHKFLG D EXIT Q
 .W $C(7),!!,"Your facility appears to be running a version of Inpatient Medications prior to"
 .W !,"version 4.5 which is necessary to use this option."
 .S CHKFLG=1 D PAUSE
 I '$D(^TMP($J,"ECXIV",$O(^TMP($J,"ECXIV",0)),.02)) D
 .W $C(7),!!,"The Inpatient Medications Patch PSJ*4.5*27 has not yet been installed!"
 .W !,"It must be loaded before you can proceed with this option."
 .S CHKFLG=1 D PAUSE
EXIT K ^TMP($J,"ECXIV")
 Q
 ;
PAUSE ;pause screen
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 Q
