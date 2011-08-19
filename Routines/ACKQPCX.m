ACKQPCX ;HCIOFO/AG - PCE Exception Report ; [ 03/27/99   10:02 AM ]
 ;;3.0;QUASAR;**1**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
OPTN ;Introduce option.
 W @IOF
 W !
 W !?25,"QUASAR - PCE Exception Report",!
 W !,"This option produces a report listing all the A&SP Clinic Visits that have been"
 W !,"reported as an exception by PCE.",!
 ;
 ; get division
 S ACKDIV=$$DIV^ACKQUTL2(3,.ACKDIV,"AI") G:+ACKDIV=0 EXIT
DATES W !
 D DTRANGE^ACKQRU G:$D(DIRUT) EXIT
 I '$$V3DATE(ACKBD) K ACKBD,ACKXBD,ACKED,ACKXED G DATES
 S ACKRDR="Visits from "_ACKXBD_" to "_ACKXED
 ; 
DEV ; get device
 W !!,"The right margin for this report is 80."
 W !,"You can queue it to run at a later time.",!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS
 I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." G EXIT
 ; queue selected
 I $D(IO("Q")) D  G EXIT
 . K IO("Q")
 . S ZTRTN="DQ^ACKQPCX",ZTDESC="QUASAR - PCE EXCEPTION REPORT"
 . S ZTSAVE("ACK*")="" D ^%ZTLOAD D HOME^%ZIS K ZTSK
 ;
DQ ; Entry point when queued.
 ;  variables required at this point are:-
 ;   ACKDIV() - selected divisions
 ;   ACKBD    - Begining Date Range
 ;   ACKED    - End Date Range
 ;   ACKRDR   - Date Heading
 U IO
 D NOW^%DTC S ACKCDT=$$NUMDT^ACKQUTL(%)_" at "_$$FTIME^ACKQUTL(%),ACKPG=0
 K ^TMP("ACKQPCX",$J)
 ;
 ; walk down the visits using the exception date index
 S ACKEXDT=ACKBD F  S ACKEXDT=$O(^ACK(509850.6,"AEX",ACKEXDT)) Q:'ACKEXDT!(ACKEXDT>ACKED)  D
 . S ACKVIEN=0 F  S ACKVIEN=$O(^ACK(509850.6,"AEX",ACKEXDT,ACKVIEN)) Q:'ACKVIEN  D SORT
 ;
 ; now print the report
 D PRINT
 ;
EXIT ;ALWAYS EXIT HERE
 K ACK2,ACKASB,ACKBD,ACKC,ACKCDT,ACKCL,ACKCLI,ACKCLN,ACKCLNC,ACKCPT
 K ACKSORT,ACKD,ACKED,ACKHDR2,ACKI,ACKLINE,ACKLR,ACKOOP,ACKP,ACKPC
 K ACKPCP,ACKPG,ACKRDR,ACKSS,ACKSTAFF,ACKSTF,ACKT,ACKV,ACKVSC,ACKXBD
 K ACKXED,ACKT2,ACKCT,ACKDIVX,ACKOK,ACKHDR,ACKDIV,ACKHDR5,ACKVDIV
 K ACKSORT,ACKICDN,ACKTMP,ACKICD9,ACKTXT,ACKED,ACKBD,ACKRDR
 K %DT,%I,%ZIS,%T,DIRUT,DTOUT,DUOUT,I,JJ,SS,X,Y,ZTDESC,ZTIO,ZTRTN
 K ZTSAVE,ZTSK,^TMP("ACKQCX",$J),ACKXBD,ACKXED,NEWCLN,VADM
 K ACKVIEN,ACKDT,ACKVERR,ACKDTEX,ACKEXDT,ACKTM,ACKPAT,ACKPATSS,ACKPATNM
 W:$E(IOST)="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SORT ; add the exception visit to ^TMP in sort order.
 ;
 ; check visit is for a selected Division
 S ACKVDIV=$$GET1^DIQ(509850.6,ACKVIEN_",",60,"I")  ; division
 I '$D(ACKDIV(+ACKVDIV)) Q
 ;
 ; unpack data items needed for sorting
 S ACKDT=$$GET1^DIQ(509850.6,ACKVIEN_",",.01,"I")   ; visit date
 S ACKTM=$$GET1^DIQ(509850.6,ACKVIEN_",",55,"I")    ; Appointment time
 S ACKCLN=$$GET1^DIQ(509850.6,ACKVIEN_",",2.6,"I")  ; clinic
 ;
 ; file in temp file
 S ^TMP("ACKQPCX",$J,"SORT",+ACKVDIV,+ACKCLN,+ACKDT,+ACKTM,+ACKVIEN)=""
 ;
 ; end of sort
 Q
PRINT ; print the report for each Division
 S ACKVDIV=""
 I '$D(^TMP("ACKQPCX",$J,"SORT")) D HDR W !!,"No data found for report specifications.",!! D:$E(IOST)="C" PAUSE^ACKQUTL Q
 F  S ACKVDIV=$O(ACKDIV(ACKVDIV)) Q:ACKVDIV=""  D PRINT2 Q:$D(DIRUT)
 Q
PRINT2 ; print for a single division
 I '$D(^TMP("ACKQPCX",$J,"SORT",ACKVDIV)) D  Q
 . D HDR W !!,"No data found for report specifications.",!!
 . D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 D HDR
 ; walk down the clinics for the Division
 S ACKCLN=""
 F  S ACKCLN=$O(^TMP("ACKQPCX",$J,"SORT",ACKVDIV,ACKCLN)) Q:ACKCLN=""  D  Q:$D(DIRUT)
 . S ACKDT="",NEWCLN=1
 . F  S ACKDT=$O(^TMP("ACKQPCX",$J,"SORT",ACKVDIV,ACKCLN,ACKDT)) Q:ACKDT=""  D  Q:$D(DIRUT)
 . . S ACKTM=""
 . . F  S ACKTM=$O(^TMP("ACKQPCX",$J,"SORT",ACKVDIV,ACKCLN,ACKDT,ACKTM)) Q:ACKTM=""  D  Q:$D(DIRUT)
 . . . S ACKVIEN=""
 . . . F  S ACKVIEN=$O(^TMP("ACKQPCX",$J,"SORT",ACKVDIV,ACKCLN,ACKDT,ACKTM,ACKVIEN)) Q:ACKVIEN=""  D  Q:$D(DIRUT)
 . . . . D PRINTV
 Q:$D(DIRUT)  D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 ; 
 ; end of printing for a division
 Q
 ;
PRINTV ; Print a Visit
 K ^TMP("ACKQPCX",$J,"VISIT")
 S ACKVERR=$NA(^TMP("ACKQPCX",$J,"VISIT"))
 D PCEERR^ACKQUTL3(ACKVIEN,ACKVERR,0,IOM-10)
 ;
 ; determine whether page throw is required
 S LN=$S(NEWCLN:2,1:0)+3+$S(@ACKVERR:@ACKVERR,1:2)
 ; W "($Y=" W $Y,",LN=",LN,")"
 I $Y>(IOSL-LN-2) S Y=$Y D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ;
 W:NEWLN ! S NEWLN=1
 ; if new clinic then print clinic name
 I NEWCLN W !,"Clinic: ",$$GET1^DIQ(509850.6,ACKVIEN_",",2.6,"E"),! S NEWCLN=0
 ;
 ; get patient data
 S (ACKPAT,DFN)=+$$GET1^DIQ(509850.6,ACKVIEN_",",1,"I")
 D DEM^VADPT
 S ACKPATNM=VADM(1),ACKPATSS=$P(VADM(2),U,2)
 ;
 ; print visit header
 S Y=ACKDT D DD^%DT S ACKDTEX=Y
 W !,?5,"Visit Date: ",ACKDTEX
 W ?40,"Patient: ",$E(ACKPATNM,1,40)
 W !,?4,"Appnt. Time: ",$$FMT^ACKQUTL6(ACKTM,0)
 W ?40,"    SSN: ",ACKPATSS
 ;
 ; print errors
 I @ACKVERR F LN=1:1:@ACKVERR W !,?10,@ACKVERR@(LN)
 I '@ACKVERR D
 . W !,?10,"Last Edit in QSR: ",$$GET1^DIQ(509850.6,ACKVIEN_",",140,"E")
 . W !,?10,"Last Sent to PCE: ",$$GET1^DIQ(509850.6,ACKVIEN_",",135,"E")
 ;
 ; end of printing a visit
 Q
 ;
HDR ;
 W:($E(IOST)="C")!(ACKPG>0) @IOF
 S ACKPG=ACKPG+1
 W "Printed: ",ACKCDT,?(IOM-8),"Page: ",ACKPG,!
 W ! D CNTR^ACKQUTL("Audiology & Speech Pathology")
 W ! D CNTR^ACKQUTL("PCE Exception Report")
 I ACKVDIV]"" W ! D CNTR^ACKQUTL("For Division: "_$$DIVNAME(ACKVDIV)_"  "_ACKRDR)
 S X="",$P(X,"-",IOM)="-" W !,X
 S NEWLN=0
 Q
 ;
DIVNAME(ACKVDIV) ; get division name
 Q $$GET1^DIQ(509850.83,ACKVDIV_",1",.01,"E")
 ;
V3DATE(ACKBD) ;
 N ACKA,ACKB,X,Y,X1,X2,%T,%H,%
 S ACKA=""
 S ACKA=$O(^DIC(9.4,"B","QUASAR",ACKA))
 I ACKA="" Q 1
 S ACKB=""
 I '$D(^DIC(9.4,ACKA,22,"B","3.0")) Q 1
 S ACKB=$O(^DIC(9.4,ACKA,22,"B","3.0",ACKB))
 I ACKB="" Q 1
 I '$D(^DIC(9.4,ACKA,22,ACKB,0)) Q 1
 S Y=$P(^DIC(9.4,ACKA,22,ACKB,0),"^",3)
 I Y="" Q 1
 S Y=$P(Y,".",1)
 S X1=ACKBD,X2="1" D C^%DTC S X=$P(X,".",1)
 I X>Y Q 1
 D DD^%DT
T W !!,"Warning - You are running a report using a start date that falls either on or   before the installation of version 3.0 of Quasar."
 W !!,"Quasar version 3.0 was installed on - ",Y
 W !!,"Note that all PCE related functionality was developed within Quasar version 3.0."
 W !,"It is recommended that this report be run using start a date that falls after   the installation date.",!
 ;
 N DIR,DUOUT,DTOUT,DIRUT
OK2 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to Continue "
 S DIR("?")="Answer YES to continue running the report or NO to quit."
 D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G OK2
 S:$D(DIRUT) Y=0
 S:$D(DTOUT) Y=0
 Q Y
