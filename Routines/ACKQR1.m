ACKQR1 ;AUG/JLTP,AEM BIR/PTD HCIOFO/AG -Patients by City  [ 12/07/95   9:52 AM ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
OPTN ;Introduce option.
 W @IOF,!,"This option generates a patient count report for a selected date range."
 W !,"The report shows the number of patients seen, sorted by city of residence.",!
 ;
 ; get division
 S ACKDIV=$$DIV^ACKQUTL2(3,.ACKDIV,"AI") G:+ACKDIV=0 EXIT
 ; get date range
 D DTRANGE^ACKQRU G:$D(DIRUT) EXIT
 S ACKRDR="Visits from "_ACKXBD_" to "_ACKXED
 ;
 ; 
DEV W !!,"The right margin for this report is 80."
 W !,"You can queue it to run at a later time.",!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS
 I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." G EXIT
 ; queue selected
 I $D(IO("Q")) D  G EXIT
 . K IO("Q")
 . S ZTRTN="DQ^ACKQR1",ZTDESC="QUASAR - A&SP PATIENTS BY CITY"
 . S ZTSAVE("ACK*")="" D ^%ZTLOAD D HOME^%ZIS K ZTSK
 ;
DQ ;Entry point when queued.
 ;  variables required at this point are:-
 ;    ACKDIV() - selected divisions
 ;    ACKBD,ACKXBD - beginning of date range (internal,external)
 ;    ACKED,ACKXED - end of date range (internal,external)
 ;
 U IO
 S ACKLINE="",$P(ACKLINE,"-",IOM)="-"
 D NOW^%DTC S ACKXDT=$$NUMDT^ACKQUTL(%)_" at "_$$FTIME^ACKQUTL(%)
 K ^TMP("ACKQR1",$J)
 ; walk down the visits using the date index
 S ACKD=ACKBD F  S ACKD=$O(^ACK(509850.6,"B",ACKD)) Q:'ACKD!(ACKD>ACKED)  D
 . S ACKV=0 F  S ACKV=$O(^ACK(509850.6,"B",ACKD,ACKV)) Q:'ACKV  D STORE
 D PRINT
 ;
EXIT ;ALWAYS EXIT HERE
 K %DT,%T,%ZIS,ACKBD,ACKCL,ACKCSC,ACKCTY,ACKD,ACKED,ACKI
 K ACKLINE,ACKPG,ACKRDR,ACKST,ACKTOT,ACKUNIQ,ACKV,ACKX,ACKXBD
 K ACKXDT,ACKXED,DFN,ACKDIV,ACKHDR,ACK2,ACKHDR5,ACKVDIV,ACKVSC
 K ACKSORT,ACKCT,ACKNEW,ACKTXT
 K DIRUT,DTOUT,DUOUT,VA,VAERR,VAPA,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE
 K ZTSK,^TMP("ACKQR1",$J)
 W:$E(IOST)="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
STORE ;
 S ACKHDR=^ACK(509850.6,ACKV,0),ACK2=$G(^ACK(509850.6,ACKV,2))
 S ACKHDR5=^ACK(509850.6,ACKV,5)
 ; get division and check against selected divisions
 S ACKVDIV=$P(ACKHDR5,U,1)
 I '$D(ACKDIV(ACKVDIV)) Q
 ; get visit stop code
 S ACKVSC=$P(ACK2,U,1)
 ; get sort value for visit stop
 S ACKSORT=$$STOPSORT^ACKQRU("B",ACKVSC)
 ; get patient data
 S DFN=+$P(ACKHDR,U,2)
 D ADD^VADPT
 S ACKCTY=VAPA(4)
 S ACKST=$$STATEABR(+VAPA(5))
 Q:ACKCTY=""!(ACKST="")
 ; get visit clinic
 S ACKCL=$P(ACKHDR,U,6)
 ;
 ; add to temp file counts
 ;
 ; add to totals for city,state for the division
 I '$D(^TMP("ACKQR1",$J,1,ACKVDIV,ACKCL,ACKSORT,ACKST,ACKCTY,DFN)) D
 . S ACKCT=+$G(^TMP("ACKQR1",$J,1,ACKVDIV,ACKCL,ACKSORT,ACKST,ACKCTY))
 . S ^TMP("ACKQR1",$J,1,ACKVDIV,ACKCL,ACKSORT,ACKST,ACKCTY)=ACKCT+1
 . S ^TMP("ACKQR1",$J,1,ACKVDIV,ACKCL,ACKSORT,ACKST,ACKCTY,DFN)=""
 ;
 ; add to totals for for the stop code in the division
 I '$D(^TMP("ACKQR1",$J,2,ACKVDIV,ACKSORT,DFN)) D
 . S ACKCT=+$G(^TMP("ACKQR1",$J,2,ACKVDIV,ACKSORT))
 . S ^TMP("ACKQR1",$J,2,ACKVDIV,ACKSORT)=ACKCT+1
 . S ^TMP("ACKQR1",$J,2,ACKVDIV,ACKSORT,DFN)=""
 ;
 ; add to totals for the city,state across all divisions
 I '$D(^TMP("ACKQR1",$J,3,ACKSORT,ACKST,ACKCTY,DFN)) D
 . S ACKCT=+$G(^TMP("ACKQR1",$J,3,ACKSORT,ACKST,ACKCTY))
 . S ^TMP("ACKQR1",$J,3,ACKSORT,ACKST,ACKCTY)=ACKCT+1
 . S ^TMP("ACKQR1",$J,3,ACKSORT,ACKST,ACKCTY,DFN)=""
 ;
 ; add to totals for the stop code across all divisions
 I '$D(^TMP("ACKQR1",$J,4,ACKSORT,DFN)) D
 . S ACKCT=+$G(^TMP("ACKQR1",$J,4,ACKSORT))
 . S ^TMP("ACKQR1",$J,4,ACKSORT)=ACKCT+1
 . S ^TMP("ACKQR1",$J,4,ACKSORT,DFN)=""
 ;
 Q
PRINT ;
 S ACKPG=0,ACKVDIV=""
 F  S ACKVDIV=$O(ACKDIV(ACKVDIV)) Q:ACKVDIV=""  D PRINT2 Q:$D(DIRUT)
 I '$D(DIRUT) D TOTALS
 Q
PRINT2 ; print data for a single division
 I '$D(^TMP("ACKQR1",$J,1,ACKVDIV)) D  Q
 . D HDR W !!,"No data found for report specifications.",!!
 . I $E(IOST)="C" D PAUSE^ACKQUTL Q:$D(DIRUT)
 D HDR
 S ACKCL=""
 F  S ACKCL=$O(^TMP("ACKQR1",$J,1,ACKVDIV,ACKCL)) Q:ACKCL=""!($D(DIRUT))  D
 .I $Y>(IOSL-7) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 .W !!,"CLINIC: ",$$CLINICNM(ACKCL)
 .S ACKSORT=""
 .F  S ACKSORT=$O(^TMP("ACKQR1",$J,1,ACKVDIV,ACKCL,ACKSORT)) Q:ACKSORT=""!($D(DIRUT))  D
 ..I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ..W !!,"STOP CODE: ",$$STOPNM^ACKQRU(ACKSORT)
 ..S ACKST=""
 ..F  S ACKST=$O(^TMP("ACKQR1",$J,1,ACKVDIV,ACKCL,ACKSORT,ACKST)) Q:ACKST=""!($D(DIRUT))  D
 ...S ACKCTY=""
 ...F  S ACKCTY=$O(^TMP("ACKQR1",$J,1,ACKVDIV,ACKCL,ACKSORT,ACKST,ACKCTY)) Q:ACKCTY=""!($D(DIRUT))  D
 ....S ACKUNIQ=^TMP("ACKQR1",$J,1,ACKVDIV,ACKCL,ACKSORT,ACKST,ACKCTY)
 ....I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ....W !,?5,ACKCTY_", "_ACKST,":",?35,$J(ACKUNIQ,5)," patient"_$S(ACKUNIQ=1:"",1:"s")
SCTOTS ;
 Q:'$D(^TMP("ACKQR1",$J,2))
 S ACKNEW=0
 I $Y>(IOSL-8) S ACKNEW=1 D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 W !
 I 'ACKNEW W !,ACKLINE  ; don't print this line if we've just thrown a page
 W !,"STOP CODE TOTALS:",!
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR1",$J,2,ACKVDIV,ACKSORT)) Q:ACKSORT=""  D
 . W !,$$STOPNM^ACKQRU(ACKSORT)
 . S ACKTOT=+$G(^TMP("ACKQR1",$J,2,ACKVDIV,ACKSORT))
 . W ?35,$J(ACKTOT,5)," patient"_$S(ACKTOT=1:"",1:"s")
 ;
 Q:$D(DIRUT)
 I $E(IOST)="C" D PAUSE^ACKQUTL Q:$D(DIRUT)
 Q
 ;
TOTALS ; print the final page of totals across all divisions
 Q:'$D(^TMP("ACKQR1",$J,3))
 I $O(ACKDIV(""))=$O(ACKDIV(""),-1) Q  ; there must be only one division
 D TOTLHD S ACKTXT="DIVISIONS:"
 S ACKVDIV="" F  S ACKVDIV=$O(ACKDIV(ACKVDIV)) Q:ACKVDIV=""  D  Q:$D(DIRUT)
 . I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 . W !,ACKTXT,?12,$$DIVNAME(ACKVDIV) S ACKTXT=""
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR1",$J,3,ACKSORT)) Q:ACKSORT=""  D   Q:$D(DIRUT)
 . I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 . W !!,"STOP CODE:",$$STOPNM^ACKQRU(ACKSORT)
 . S ACKST=""
 . F  S ACKST=$O(^TMP("ACKQR1",$J,3,ACKSORT,ACKST)) Q:ACKST=""  D  Q:$D(DIRUT)
 . . S ACKCTY=""
 . . F  S ACKCTY=$O(^TMP("ACKQR1",$J,3,ACKSORT,ACKST,ACKCTY)) Q:ACKCTY=""  D  Q:$D(DIRUT)
 . . . I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 . . . S ACKCT=^TMP("ACKQR1",$J,3,ACKSORT,ACKST,ACKCTY)
 . . . W !?5,ACKCTY,", ",ACKST,":",?35,$J(ACKCT,5)," patient",$S(ACKCT=1:"",1:"s")
 Q:'$D(^TMP("ACKQR1",$J,4)) 
 S ACKNEW=0
 I $Y>(IOSL-8) S ACKNEW=1 D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 W !
 I 'ACKNEW W !,ACKLINE  ; don't print this line if we've just thrown a page
 W !,"STOP CODE TOTALS:",!
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR1",$J,4,ACKSORT)) Q:ACKSORT=""  D
 . W !,$$STOPNM^ACKQRU(ACKSORT),":"
 . S ACKTOT=+$G(^TMP("ACKQR1",$J,4,ACKSORT))
 . W ?35,$J(ACKTOT,5)," patient"_$S(ACKTOT=1:"",1:"s")
 ;
 Q:$D(DIRUT)
 I $E(IOST)="C" D PAUSE^ACKQUTL Q:$D(DIRUT)
 Q
HDR ;
 W:($E(IOST)="C")!(ACKPG>0) @IOF
 S ACKPG=ACKPG+1
 W "Printed: ",ACKXDT,?(IOM-8),"Page: ",ACKPG,!
 W ! D CNTR^ACKQUTL("Audiology & Speech Pathology")
 W ! D CNTR^ACKQUTL("Unique Patients by City")
 W ! D CNTR^ACKQUTL(ACKRDR)
 I ACKVDIV]"" W ! D CNTR^ACKQUTL("For Division: "_$$DIVNAME(ACKVDIV))
 W !,ACKLINE
 Q
 ;
TOTLHD ; print header for totals page
 S ACKPG=ACKPG+1
 W @IOF,"Printed: ",ACKXDT,?(IOM-8),"Page: ",ACKPG,!
 W ! D CNTR^ACKQUTL("Audiology & Speech Pathology")
 W ! D CNTR^ACKQUTL("Unique Patients by City")
 W ! D CNTR^ACKQUTL(ACKRDR)
 W ! D CNTR^ACKQUTL("Summary")
 W !,ACKLINE
 Q
 ;
DIVNAME(ACKVDIV) ; determine division name
 Q $$GET1^DIQ(40.8,ACKVDIV_",",.01)
 ;
CLINICNM(ACKCL) ; determine clinic name
 Q $$GET1^DIQ(44,ACKCL_",",.01)
 ;
STATEABR(ACKST) ; get State abbreviation
 Q $$GET1^DIQ(5,ACKST_",",1)
 ;
