ACKQR3 ;AUG/JLTP BIR/PTD HCIOFO/AG-Visits by Diagnosis ; [ 03/27/99   10:02 AM ]
 ;;3.0;QUASAR;**8**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
OPTN ;Introduce option.
 W @IOF,!,"This option produces a report listing clinic visits for a date range"
 W !,"sorted by ICD-9CM diagnostic codes.",!
 ;
 ; get division
 S ACKDIV=$$DIV^ACKQUTL2(3,.ACKDIV,"AI") G:+ACKDIV=0 EXIT
 ; get date range
 D DTRANGE^ACKQRU G:$D(DIRUT) EXIT
 S ACKRDR="Visits from "_ACKXBD_" to "_ACKXED
 ;
 ; determine the type of report
 ;  returns ACKASB="A","S" or "B"
 ;          ACKSS=1-6 (1=one clinician etc.)
 ;          ACKSTF(x) selected staff members
 D PARAMS^ACKQRU G:$D(DIRUT) EXIT
 ;
DEV ; get device
 W !!,"The right margin for this report is 80."
 W !,"You can queue it to run at a later time.",!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS
 I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." G EXIT
 ; queue selected
 I $D(IO("Q")) D  G EXIT
 . K IO("Q")
 . S ZTRTN="DQ^ACKQR3",ZTDESC="QUASAR - A&SP VISITS BY DIAGNOSIS"
 . S ZTSAVE("ACK*")="" D ^%ZTLOAD D HOME^%ZIS K ZTSK
 ;
DQ ;Entry point when queued.
 ;  variables required at this point are:-
 ;   ACKDIV() - selected divisions
 ;   ACKBD,ACKXBD - beginning of date range (internal,external)
 ;   ACKED,ACKXED - end of date range (internal,external)
 ;   ACKASB - A=audio,S=speech,B=both
 ;   ACKSS - type of report (1=one clinicians etc)
 ;   ACKSTF() - selected clinicians
 U IO
 D NOW^%DTC S ACKCDT=$$NUMDT^ACKQUTL(%)_" at "_$$FTIME^ACKQUTL(%),ACKPG=0
 K ^TMP("ACKQR3",$J),ACKT,ACKT2 S ACKT=0,ACKT2=0
 ; walk down the visits using the date index
 S ACKD=ACKBD F  S ACKD=$O(^ACK(509850.6,"B",ACKD)) Q:'ACKD!(ACKD>ACKED)  D
 . S ACKV=0 F  S ACKV=$O(^ACK(509850.6,"B",ACKD,ACKV)) Q:'ACKV  D STORE
 D PRINT
 ;
EXIT ;ALWAYS EXIT HERE
 K ACK2,ACKASB,ACKBD,ACKC,ACKCDT,ACKCL,ACKCLI,ACKCLN,ACKCLNC,ACKCPT
 K ACKSORT,ACKD,ACKED,ACKHDR2,ACKI,ACKLINE,ACKLR,ACKOOP,ACKP,ACKPC
 K ACKPCP,ACKPG,ACKRDR,ACKSS,ACKSTAFF,ACKSTF,ACKT,ACKV,ACKVSC,ACKXBD
 K ACKXED,ACKT2,ACKCT,ACKDIVX,ACKOK,ACKHDR,ACKDIV,ACKHDR5,ACKVDIV
 K ACKSORT,ACKICDN,ACKTMP,ACKICD9,ACKTXT
 K %DT,%I,%ZIS,%T,DIRUT,DTOUT,DUOUT,I,JJ,SS,X,Y,ZTDESC,ZTIO,ZTRTN
 K ZTSAVE,ZTSK,^TMP("ACKQR3",$J)
 W:$E(IOST)="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
STORE ;
 S ACKHDR=^ACK(509850.6,ACKV,0)
 S ACKHDR5=^ACK(509850.6,ACKV,5)
 ; get Division and make sure it was selected
 S ACKVDIV=+$P(ACKHDR5,U,1)
 I '$D(ACKDIV(ACKVDIV)) Q
 ;
 S ACKCLNC=+$P(ACKHDR,U,6) ;clinic IEN
 S ACK2=$G(^ACK(509850.6,ACKV,2))
 S ACKVSC=$P(ACK2,U) ; visit stop code
 ; determine sort value for visit stop code (will return zero
 ;  if the visit is not to be included in the report)
 S ACKSORT=$$STOPSORT^ACKQRU(ACKASB,ACKVSC) Q:'ACKSORT
 ; check that the staff member for the visit was selected for this report
 I (ACKSS=3)!(ACKSS=6) S ACKLR=$P(ACK2,U,4)   ; student
 I ACKSS'=3,ACKSS'=6 S ACKLR=$$LEADROLE^ACKQUTL2(ACKV) ; determine lead role
 Q:$S(ACKCLNC=0:1,ACKLR="":1,1:0)
 Q:'$D(ACKSTF(ACKLR))
 ; count the Diagnosis codes for the visit
 S ACKP=0 F  S ACKP=$O(^ACK(509850.6,ACKV,1,ACKP)) Q:'ACKP  D
 . S ACKICDN=$$GET1^DIQ(509850.63,ACKP_","_ACKV_",",.01,"I","","")
 . I '$D(^TMP("ACKQR3",$J,"ICD9",1,80,ACKICDN_",")) D GETDIAG(ACKICDN)
 . S X=^TMP("ACKQR3",$J,"ICD9",1,80,ACKICDN_",",.01)
 . I X="" Q
 . ; add to count of Diagnosis codes for staff member
 . S ACKCT=+$G(^TMP("ACKQR3",$J,1,ACKVDIV,ACKSORT,ACKCLNC,ACKLR,X))
 . S ^TMP("ACKQR3",$J,1,ACKVDIV,ACKSORT,ACKCLNC,ACKLR,X)=ACKCT+1
 . ; add to count of Diagnosis codes for the stop code within the division
 . S ^TMP("ACKQR3",$J,0,ACKVDIV,ACKSORT,X)=$G(^TMP("ACKQR3",$J,0,ACKVDIV,ACKSORT,X))+1
 . ; add to count of Diagnosis codes totals for all divisions
 . S ^TMP("ACKQR3",$J,2,ACKSORT,X)=$G(^TMP("ACKQR3",$J,2,ACKSORT,X))+1
 . ; add to the total count for the stop code, division, and the grand total
 . S ACKT(ACKVDIV,ACKSORT)=$G(ACKT(ACKVDIV,ACKSORT))+1
 . S ACKT(ACKVDIV)=$G(ACKT(ACKVDIV))+1
 . S ACKT2(ACKSORT)=$G(ACKT2(ACKSORT))+1,ACKT2=$G(ACKT2)+1
 Q
GETDIAG(ACKICDN) ; get Diagnosis data and place in ^TMP
 N ACKTMP,ACKMSG,ACKICD9,ACKQDTXT
 S ACKTMP=$NA(^TMP("ACKQR3",$J,"ICD9",1))
 D GETS^DIQ(80,ACKICDN_",",".01","",ACKTMP,"ACKMSG")
 S ACKICD9=^TMP("ACKQR3",$J,"ICD9",1,80,ACKICDN_",",.01)
 S ACKQDTXT=$$DIAGTXT^ACKQUTL8(ACKICDN,"")
 S ^TMP("ACKQR3",$J,"ICD9",1,80,ACKICDN_",",3)=ACKQDTXT
 S ^TMP("ACKQR3",$J,"ICD9",2,ACKICD9)=ACKICDN
 Q
ICDDESC(ACKICD9) ; get the description of an ICD9 from the ^TMP file
 N ACKICDN S ACKICDN=^TMP("ACKQR3",$J,"ICD9",2,ACKICD9)
 Q ^TMP("ACKQR3",$J,"ICD9",1,80,ACKICDN_",",3)
 ;
PRINT ; print the report for each Division
 S ACKVDIV=""
 I '$D(^TMP("ACKQR3",$J,1)) D  Q
 . D HDR
 . W !!,"No data found for report specifications.",!!
 . D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 F  S ACKVDIV=$O(ACKDIV(ACKVDIV)) Q:ACKVDIV=""  D PRINT2 Q:$D(DIRUT)
 I '$D(DIRUT) D TOTALS
 Q
PRINT2 ; print for a single division
 I '$D(^TMP("ACKQR3",$J,1,ACKVDIV)) D  Q
 . D HDR W !!,"No data found for report specifications.",!!
 . D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 D HDR
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR3",$J,1,ACKVDIV,ACKSORT)) Q:ACKSORT=""!($D(DIRUT))  D
 .I $Y>(IOSL-9) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 .W !!,"STOP CODE: ",$$STOPNM^ACKQRU(ACKSORT)
 .S ACKCLN=""
 .F  S ACKCLN=$O(^TMP("ACKQR3",$J,1,ACKVDIV,ACKSORT,ACKCLN)) Q:ACKCLN=""!($D(DIRUT))  D
 ..I $Y>(IOSL-7) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ..W !!?2,"CLINIC: ",$$GET1^DIQ(44,ACKCLN_",",.01)
 ..S ACKSTF=""
 ..F  S ACKSTF=$O(^TMP("ACKQR3",$J,1,ACKVDIV,ACKSORT,ACKCLN,ACKSTF)) Q:ACKSTF=""!($D(DIRUT))  D
 ...I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ...W !!?2,$S("1^4"[ACKSS:"CLINICIAN: ","2^5"[ACKSS:"OTHER PROVIDER: ",1:"STUDENT: ")
 ...W $$CONVERT^ACKQUTL4(ACKSTF)
 ...S ACKPC=""
 ...F  S ACKPC=$O(^TMP("ACKQR3",$J,1,ACKVDIV,ACKSORT,ACKCLN,ACKSTF,ACKPC)) Q:ACKPC=""!($D(DIRUT))  D
 ....I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ....W !?5,ACKPC,?15,$$ICDDESC(ACKPC),?55,"COUNT: "
 ....W $J(^TMP("ACKQR3",$J,1,ACKVDIV,ACKSORT,ACKCLN,ACKSTF,ACKPC),4)
 Q:$D(DIRUT)  D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
SUMM ;
 Q:'$D(^TMP("ACKQR3",$J,0))  D SUMHD
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR3",$J,0,ACKVDIV,ACKSORT)) Q:ACKSORT=""!($D(DIRUT))  D
 .I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 .W !!,"STOP CODE: ",$$STOPNM^ACKQRU(ACKSORT)
 .S ACKPC=""
 .F  S ACKPC=$O(^TMP("ACKQR3",$J,0,ACKVDIV,ACKSORT,ACKPC)) Q:ACKPC=""!($D(DIRUT))  D
 ..I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 ..W !?5,ACKPC,?15,$$ICDDESC(ACKPC),?55,"COUNT: "
 ..W $J(^TMP("ACKQR3",$J,0,ACKVDIV,ACKSORT,ACKPC),4)
 .I $Y>(IOSL-4) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 .Q:$D(DIRUT)
 .W !!,"Total For ",$$STOPNM^ACKQRU(ACKSORT)
 .W ?62,$J(ACKT(ACKVDIV,ACKSORT),4)
 I $Y>(IOSL-4) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 Q:$D(DIRUT)  W !!,"Total For Division: "_$$DIVNAME(ACKVDIV),?62,$J(ACKT(ACKVDIV),4)
 Q:$D(DIRUT)  D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 Q
TOTALS ; print the final page of totals for all divisions
 Q:'$D(^TMP("ACKQR3",$J,2))
 I $O(ACKT(""))=$O(ACKT(""),-1) Q  ; there must be only one division!
 D TOTLHD S ACKTXT="DIVISIONS: "
 S ACKVDIV="" F  S ACKVDIV=$O(ACKT(ACKVDIV)) Q:ACKVDIV=""  D  Q:$D(DIRUT)
 . I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 . W !,ACKTXT,?12,$$DIVNAME(ACKVDIV) S ACKTXT=""
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR3",$J,2,ACKSORT)) Q:ACKSORT=""!($D(DIRUT))  D
 .I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 .W !!,"STOP CODE: ",$$STOPNM^ACKQRU(ACKSORT)
 .S ACKPC=""
 .F  S ACKPC=$O(^TMP("ACKQR3",$J,2,ACKSORT,ACKPC)) Q:ACKPC=""!($D(DIRUT))  D
 ..I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 ..W !?5,ACKPC,?15,$$ICDDESC(ACKPC),?55,"COUNT: "
 ..W $J(^TMP("ACKQR3",$J,2,ACKSORT,ACKPC),4)
 .I $Y>(IOSL-4) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 .Q:$D(DIRUT)
 .W !!,"Total For ",$$STOPNM^ACKQRU(ACKSORT)
 .W ?62,$J(ACKT2(ACKSORT),4)
 I $Y>(IOSL-4) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 Q:$D(DIRUT)  W !!,"Grand Total:",?62,$J(ACKT2,4)
 Q:$D(DIRUT)  D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 Q
HDR ;
 W:($E(IOST)="C")!(ACKPG>0) @IOF
 S ACKPG=ACKPG+1
 W "Printed: ",ACKCDT,?(IOM-8),"Page: ",ACKPG,!
 W ! D CNTR^ACKQUTL("Audiology & Speech Pathology")
 W ! D CNTR^ACKQUTL("Diagnostic Code Statistics")
 W ! D CNTR^ACKQUTL("for")
 I ACKSS<4 S X=$$STAFFNM($O(ACKSTF(0))) W ! D CNTR^ACKQUTL(X)
 I ACKSS=4 W ! D CNTR^ACKQUTL("All Clinicians")
 I ACKSS=5 W ! D CNTR^ACKQUTL("All Other Providers")
 I ACKSS=6 W ! D CNTR^ACKQUTL("All Students")
 W ! D CNTR^ACKQUTL("Covering "_ACKRDR)
 I ACKVDIV]"" W ! D CNTR^ACKQUTL("For Division: "_$$DIVNAME(ACKVDIV))
 S X="",$P(X,"-",IOM)="-" W !,X
 Q
SUMHD ;
 W:($E(IOST)="C")!(ACKPG>0) @IOF
 S ACKPG=ACKPG+1
 W "Printed: ",ACKCDT,?(IOM-8),"Page: ",ACKPG,!
 W ! D CNTR^ACKQUTL("Audiology & Speech Pathology")
 W ! D CNTR^ACKQUTL("Diagnostic Code Statistics")
 W ! D CNTR^ACKQUTL("For Division: "_$$DIVNAME(ACKVDIV))
 W ! D CNTR^ACKQUTL("Summary")
 S X="",$P(X,"-",IOM)="-" W !,X
 Q
TOTLHD ;
 W:($E(IOST)="C")!(ACKPG>0) @IOF
 S ACKPG=ACKPG+1
 W "Printed: ",ACKCDT,?(IOM-8),"Page: ",ACKPG,!
 W ! D CNTR^ACKQUTL("Audiology & Speech Pathology")
 W ! D CNTR^ACKQUTL("Diagnostic Code Statistics")
 W ! D CNTR^ACKQUTL("Summary")
 S X="",$P(X,"-",IOM)="-" W !,X
 Q
 ;
DIVNAME(ACKVDIV) ; get division name
 Q $$GET1^DIQ(40.8,ACKVDIV_",",.01)
 ;
STAFFNM(ACKSTF) ; get staff name
 Q $$MIXC^ACKQUTL($$CONVERT^ACKQUTL4(ACKSTF))
 ;
