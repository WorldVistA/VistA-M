GMRCYP31 ;SLC/JFR - POST-INIT FOR PATCH 31; 2/04/03 08:02
 ;;3.0;CONSULT/REQUEST TRACKING;**31,32**;DEC 27, 1997
 ; 
 ; Re-distributed with GMRC*3*32 to address error with no records 
 ; to print when sent to a printer.
 Q
POST ;
 N %ZIS,GMRCQT,POP
 W !!,"This report should be sent to a printer",!
 S %ZIS="" D ^%ZIS
 I POP Q
 I $D(IO("Q")) D  Q
 . N ZTRTN,ZTDTH,ZTIO,ZTSAVE,ZTDESC
 . S ZTRTN="POST1^GMRCYP31",ZTIO=ION,ZTDTH=$H
 . S ZTDESC="GMRC*3*31 Post-Install Report"
 . D ^%ZTLOAD D HOME^%ZIS K IO("Q") Q
 . W !,"REPORT TASKED TO PRINT!"
 . Q
 D POST1
 Q
POST1 ; START POST-INIT
 N GMRCO,GMRCISIT,GMRCRO
 S GMRCISIT=0
 F  S GMRCISIT=$O(^GMR(123,"AIFC",GMRCISIT)) Q:'GMRCISIT  D
 . S GMRCRO=0
 . F  S GMRCRO=$O(^GMR(123,"AIFC",GMRCISIT,GMRCRO)) Q:'GMRCRO  D
 .. S GMRCO=$O(^GMR(123,"AIFC",GMRCISIT,GMRCRO,0))
 .. I $P($G(^GMR(123,GMRCO,12)),U,5)="P" D
 ... D ACTS(GMRCO)
 ... I $D(^TMP("GMRCYP31",$J,GMRCISIT,GMRCO)) D
 .... S ^TMP("GMRCYP31",$J,GMRCISIT,GMRCO)=""
 .. Q
 . Q
 D PRINT
 Q
 ;
ACTS(CSLT) ;loop activities and see if there is a remote FWD or SF update
 ;CSTL = ien from file 123
 N ACTV
 S ACTV=0
 F  S ACTV=$O(^GMR(123,CSLT,40,ACTV)) Q:'ACTV  D
 . N ACTYPE
 . S ACTYPE=$P(^GMR(123,CSLT,40,ACTV,0),U,2)
 . Q:ACTYPE'=17&(ACTYPE'=4)  ;only FWD and SF are affected
 . Q:'$D(^GMR(123,CSLT,40,ACTV,2))  ;only remote activities
 . Q:'$O(^GMR(123,CSLT,40,ACTV,1,1))  ;only comments >1 line long
 . N SITE
 . S SITE=$P(^GMR(123,CSLT,0),U,23)
 . S ^TMP("GMRCYP31",$J,SITE,CSLT,ACTV,0)=""
 Q
 ;
PRINT ; loop the ^TMP global and write records
 ; ask device and queue if needed
 ; 
 ;I $D(ZTQUEUED) S ZTREQ="@"
 N GMRCCT,TAB,GMRCDA,GMRCSIT,ACT,REMNUM,GMRCPG
 U IO
 S GMRCPG=1
 D HDR(.GMRCPG)
 I '$O(^TMP("GMRCYP31",$J,0)) D  D ^%ZISC,HOME^%ZIS Q
 . W !,"No records to report"
 . I $E(IOST,1,2)="C-" N DIR S DIR(0)="E" D ^DIR
 . Q
 S TAB=$$REPEAT^XLFSTR(" ",29)
 W !,"No cleanup or modification should be made to Inter-facility consults that are "
 W !,"identified with extraneous comments at this time.  Patch GMRC*3*32 will outline"
 W !,"the processes that should be utilized to properly accomplish these corrections."
 W !,$$REPEAT^XLFSTR("*",79)
 W !!
 S GMRCSIT=0
 F  S GMRCSIT=$O(^TMP("GMRCYP31",$J,GMRCSIT)) Q:'GMRCSIT  D
 . S GMRCDA=0
 . F  S GMRCDA=$O(^TMP("GMRCYP31",$J,GMRCSIT,GMRCDA)) Q:'GMRCDA  D
 .. I (IOSL-$Y)<7 D HDR(.GMRCPG) I 'GMRCPG S GMRCDA=999999999 Q
 .. N PTNM,PTSSN,REMSIT
 .. S PTNM="Patient name: "_$$GET1^DIQ(123,GMRCDA,.02,"E")
 .. S PTSSN="SSN: "_$$GET1^DIQ(2,$P(^GMR(123,GMRCDA,0),U,2),.09)
 .. S REMSIT=$$GET1^DIQ(4,$P(^GMR(123,GMRCDA,0),U,23),.01)
 .. S REMNUM=$P(^GMR(123,GMRCDA,0),U,22)
 .. I GMRCPG>2 W !,$$REPEAT^XLFSTR("*",78)
 .. W !,"Consult #: ",GMRCDA
 .. W !,PTNM,?50,PTSSN
 .. W !,"Receiving Site: ",REMSIT,?50,"Remote Consult #: ",REMNUM
 .. W !!,$$CJ^XLFSTR("Activities for Review",78)
 .. W !,$$CJ^XLFSTR("*********************",78)
 .. I (IOSL-$Y)<4 D HDR(.GMRCPG) I 'GMRCPG S GMRCDA=999999999 Q
 .. W !,"Facility"
 .. W !," Activity",?25,"Date/Time/Zone",$E(TAB,1,6)
 .. W "Responsible Person",$E(TAB,1,2),"Entered By"
 .. W !,$$REPEAT^XLFSTR("-",79)
 .. S ACT=0
 .. F  S ACT=$O(^TMP("GMRCYP31",$J,GMRCSIT,GMRCDA,ACT)) Q:'ACT  D
 ... N GMRCCT S GMRCCT=1
 ... I (IOSL-$Y)<6 D HDR(.GMRCPG,GMRCDA) I 'GMRCPG D  Q
 .... S (ACT,GMRCDA)=9999999999
 ... W !,?11,"Act. #:",ACT
 ... D BLDALN^GMRCSLM4(GMRCDA,ACT)
 ... N I S I=0
 ... F  S I=$O(^TMP("GMRCR",$J,"DT",I)) Q:'I  D
 .... I (IOSL-$Y)<5 D HDR(.GMRCPG,GMRCDA) I 'GMRCPG D  Q
 ..... S (I,ACT,GMRCDA)=9999999999
 .... W !,$G(^TMP("GMRCR",$J,"DT",I,0))
 ... K ^TMP("GMRCR",$J,"DT")
 .. W !
 .. Q
 . Q
 D ^%ZISC,HOME^%ZIS
 D EXIT
 Q
 ;
HDR(PAGE,CSLT) ;print a new header
 ; PAGE = next page number
 ; CSLT = consult ien working on
 ;
 I $E(IOST,1,2)="C-",PAGE>1 D  I 'PAGE Q
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 . S DIR(0)="E" D ^DIR
 . I $D(DIRUT) S PAGE=0
 W @IOF
 W !,"GMRC*3*31 Post-Install",?69,"Page: ",PAGE
 W !,$$REPEAT^XLFSTR("-",79)
 I $D(CSLT) D
 . N TEXT
 . S TEXT="Consult # "_CSLT_" cont'd."
 . W !,$$CJ^XLFSTR(TEXT,80)
 . W !
 S PAGE=PAGE+1
 Q
EXIT ; clean up
 K ^TMP("GMRCYP31",$J)
 Q
