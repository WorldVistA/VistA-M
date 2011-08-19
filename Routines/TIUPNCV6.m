TIUPNCV6 ;SLC/DJP ;PNs ==> TIU cnv rtns ;5-7-97
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
TLSRCH ;Utility to search ^TIU(8925.1 FOR ^GMR(121.2 titles
 K DIR W @IOF W !!?14,"***** TITLE REPORT *****"
 W !!?5,"This option will identify TITLES in ^GMR(121.2,"
 W !?5,"Generic Progress Note Title File which are NOT"
 W !?5,"defined in ^TIU(8925.1, TIU Document Definition File."
 W !!?5,"It is important for a successful conversion that"
 W !?5,"all Progress Note Titles be defined as Documents"
 W !?5,"within ^TIU(8925.1.  The exceptions to this rule are"
 W !?5,"titles which have been retired or inactivated.  They"
 W !?5,"do not need to be entered in the file."
 W !! K DIR S DIR(0)="Y",DIR("A")="Do you want to continue"
 S DIR("B")="YES",DIR("?")="^D HELP8^TIUPNCV6"
 D ^DIR K DIR I $D(DIRUT)!(Y=0) Q
 D DEVICE
 Q
 ;
LOOPT ;Loops through ^GMR(121.2
 U IO
 S CTR=0 F LKUP=0:0 S LKUP=$O(^GMR(121.2,LKUP)) Q:LKUP<1  D SRCH
 D HDR,PRINT
 K LKUP,GMRPTL,CTR,TIU,PRT,TIULN
 K ^TMP("TIUTIL")
 Q
 ;
SRCH ;Lookup on ^TIU(8925.1, TIU Document Definition File
 S TIUFPRIV=1
 S GMRPTL=$P(^GMR(121.2,LKUP,0),U,1)
 I $P($G(^GMR(121.2,LKUP,0)),U,4)="1" D RETIRED Q
 S X=$$UPPER^TIULS(GMRPTL),TYP="DOC"
 K DIC S DIC(0)="XZ",DIC="^TIU(8925.1,"
 S DIC("S")="I $P($G(^(0)),U,4)=TYP"
 D ^DIC K DIC,TYP I Y<1 D NOTR Q
 I $P(Y(0),U,4)'="DOC" D NORING
 Q
 ;
NOTR ;Title not found in ^TIU(8925.1
 S CTR=CTR+1
 S ^TMP("TIUTIL",$J,CTR)=CTR_".  "_GMRPTL_" not found in ^TIU(8925.1."
 Q
NORING ;Title found in file but not defined as a DOCUMENT
 S CTR=CTR+1
 S ^TMP("TIUTIL",$J,CTR)=CTR_".  "_GMRPTL_" not defined as a DOCUMENT."
 Q
 ;
RETIRED ;Title assigned to existing note but RETIRED from further use
 S CTR=CTR+1
 S ^TMP("TIUTIL",$J,CTR)=CTR_".  "_GMRPTL_" RETIRED."
 Q
 ;
PRINT ;Prints Undefined Title Report
 I '$D(^TMP("TIUTIL",$J))
 I  W !!,?19,"NO DISCREPANCIES FOUND",!?19,"**************",! Q
 F PRT=0:0 S PRT=$O(^TMP("TIUTIL",$J,PRT)) Q:PRT<1  W !?5,^TMP("TIUTIL",$J,PRT),! D:PRT=CTR LASTLN Q:$D(TIU("QUIT"))  D LNCK Q:$D(TIU("QUIT"))
 Q
 ;
DEVICE ;prompts for device selection
 K IOP S %ZIS="Q" D ^%ZIS I POP K POP Q
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTSAVE("TIU*")="",ZTSAVE("GMRP*")=""
 .S ZTRTN="LOOPT^TIUPNCV6",ZTDESC="TIU/GMRPN TITLE SEARCH" D ^%ZTLOAD
 .W !,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled."),!
 .K ZTRTN,ZTDESC,ZTSAVE
 .D HOME^%ZIS
 D LOOPT,^%ZISC
 Q
 ;
LNCK ;Check current $Y value for paging
 I IOST?1"P".E Q:$Y'>(IOSL-9)  D HDR Q
 I $Y>(IOSL-3) D RETURN I '$D(TIU("QUIT")) D HDR
 Q
 ;
RETURN ;Issues RETURN prompt
 K DIR F TIULN=1:1:(IOSL-$Y-4) W !
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT) S TIU("QUIT")=1 Q
 I Y="" W @IOF
 Q
 ;
HDR ;Header Line for Title Report
 W !!?12,"******  UNDEFINED TITLE REPORT  ******",!!
 Q
 ;
LASTLN ;End of report
 W !!?12,"****** END OF REPORT ******"
 S TIU("QUIT")=1
 Q
 ;
HELP8 ;Help text for SEARCH prompt
 W !!?5,"Press <ret> to continue with compare of the Progress"
 W !?5,"Note Title File and the TIU Document Definition File."
 W !?5,"Enter NO or ""^"" to stop this option."
 Q
 ;
