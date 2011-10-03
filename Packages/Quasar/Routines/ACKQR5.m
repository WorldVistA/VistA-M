ACKQR5 ;HCIOFO/BH -Statistics by EC Code  ; [ 10/10/00   9:52 AM ]
 ;;3.0;QUASAR;**1**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
OPTN W @IOF,!,"This option produces a report listing clinic visits for a date range"
 W !,"sorted by Event Capture procedure codes.",!
 ;
 S ACKDIV=$$DIV^ACKQUTL2(3,.ACKDIV,"AI") G:+ACKDIV=0 EXIT
 ; Date's
 D DTRANGE^ACKQRU G:$D(DIRUT) EXIT
 S ACKRDR="Visits from "_ACKXBD_" to "_ACKXED
 ; 
 ; Type of report: Returns-
 ; ACKASB="A","S","O" or a combination, ACKSS=1-6 (1=one clinician etc)
 ; ACKSTF(x) selected staff members
 D PARAMS^ACKQRU G:$D(DIRUT) EXIT
 ;
DEV W !!,"The right margin for this report is 80."
 W !,"You can queue it to run at a later time.",!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS
 I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." G EXIT
 ; Queue selected
 I $D(IO("Q")) D  G EXIT
 . K IO("Q")
 . S ZTRTN="DQ^ACKQR5",ZTDESC="QUASAR - A&SP EC PROCEDURE STATISTICS"
 . S ZTSAVE("ACK*")="" D ^%ZTLOAD D HOME^%ZIS K ZTSK
 ;
DQ ; Queued entry point
 ; Vars required are:-
 ; ACKDIV() - selected divs, ACKBD,ACKXBD - beginning of date range (internal,external)
 ; ACKED,ACKXED - end of date range (internal, external)
 ; ACKASB - A=audio,S=speech,O=other,ASO=all three
 ; ACKSS - type of report (1=one clinician etc),  ACKSTF(x) - selected providers
 U IO
 D NOW^%DTC S ACKCDT=$$NUMDT^ACKQUTL(%)_" at "_$$FTIME^ACKQUTL(%),ACKPG=0
 K ^TMP("ACKQR5",$J),ACKT,ACKT2 S ACKT2=0
 ; $O thru visit file using the date index
 F ACKD=ACKBD:0 S ACKD=$O(^ACK(509850.6,"B",ACKD)) Q:'ACKD!(ACKD>ACKED)  D
 . S ACKV=0 F  S ACKV=$O(^ACK(509850.6,"B",ACKD,ACKV)) Q:'ACKV  D STORE
 D PRINT
 ;
EXIT ; Only way out
 K ACK2,ACKASB,ACKBD,ACKC,ACKCDT,ACKCL,ACKCLI,ACKCLN,ACKCLNC,ACKEC
 K ACKSORT,ACKD,ACKED,ACKHDR2,ACKI,ACKLINE,ACKLR,ACKOOP,ACKP,ACKPC
 K ACKPCP,ACKPG,ACKRDR,ACKSS,ACKSTAFF,ACKSTF,ACKT,ACKV,ACKVSC,ACKXBD
 K ACKXED,ACKT2,ACKCT,ACKVDIV,ACKOK,ACKHDR,ACKDIV,ACKHDR5,ACKSORT
 K ACKECN,ACKVOL,ACKTXT,ACKQUIT,ZTSAVE,ZTSK,^TMP("ACKQR5",$J)
 K %DT,%I,%ZIS,%T,DIRUT,DTOUT,DUOUT,I,JJ,SS,X,Y,ZTDESC,ZTIO,ZTRTN
 W:$E(IOST)="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
STORE ;
 S ACKHDR=^ACK(509850.6,ACKV,0),ACKHDR5=^ACK(509850.6,ACKV,5)
 ; Get div & make sure it was selected
 S ACKVDIV=$P(ACKHDR5,U,1)
 I '$D(ACKDIV(ACKVDIV)) Q
 ;
 S ACKCLNC=+$P(ACKHDR,U,6) ; clinic IEN
 Q:'ACKCLNC
 S ACK2=$G(^ACK(509850.6,ACKV,2))
 S ACKVSC=$P(ACK2,U) ; clinic stp code
 ; Determine sort order for visit stp code (will return zero if
 ; the visit is not to be included in the report)
 S ACKSORT=$$STOPSORT^ACKQRU(ACKASB,ACKVSC) Q:'ACKSORT
 ;
 ; Check staff member selected for report
 I (ACKSS=3)!(ACKSS=6) S ACKLR=$P(ACK2,U,4)  Q:ACKLR=""  Q:'$D(ACKSTF(ACKLR))
 ;
 ; Count the EC proc codes for visit
 S ACKP=0 F  S ACKP=$O(^ACK(509850.6,ACKV,7,ACKP)) Q:'ACKP  D
 . S ACKECN=$$GET1^DIQ(509850.615,ACKP_","_ACKV_",",.01,"I","","")
 . S ACKVOL=$$GET1^DIQ(509850.615,ACKP_","_ACKV_",",.03,"I","","")
 . S:ACKVOL<1 ACKVOL=1
 . S ACKQUIT=0
 . I ACKSS'=3,ACKSS'=6 D  Q:ACKQUIT
 . . S ACKLR=$$GET1^DIQ(509850.615,ACKP_","_ACKV_",",.05,"I","","")
 . . I ACKLR="" S ACKLR=$$LEADROLE^ACKQUTL2(ACKV)
 . . I ACKLR="" S ACKQUIT=1
 . . I '$D(ACKSTF(ACKLR)) S ACKQUIT=1
 . ;
 . I '$D(^TMP("ACKQR5",$J,"EC",1,725,ACKECN_",")) D GETEC(ACKECN)
 . S ACKEC=^TMP("ACKQR5",$J,"EC",1,725,ACKECN_",",1)
 . I ACKEC="" Q
 . ; Add to cnt of procs for stff member
 . S ACKCT=+$G(^TMP("ACKQR5",$J,1,ACKVDIV,ACKSORT,ACKCLNC,ACKLR,ACKEC))
 . S ^TMP("ACKQR5",$J,1,ACKVDIV,ACKSORT,ACKCLNC,ACKLR,ACKEC)=ACKCT+ACKVOL
 . ; Add to cnt of EC procs for the stp code within div
 . S ^TMP("ACKQR5",$J,0,ACKVDIV,ACKSORT,ACKEC)=$G(^TMP("ACKQR5",$J,0,ACKVDIV,ACKSORT,ACKEC))+ACKVOL
 . ; Add to cnt of ec procs for all divs
 . S ^TMP("ACKQR5",$J,2,ACKSORT,ACKEC)=$G(^TMP("ACKQR5",$J,2,ACKSORT,ACKEC))+ACKVOL
 . ; Add to total cnt for the stp code, the div & grand total
 . S ACKT(ACKVDIV,ACKSORT)=$G(ACKT(ACKVDIV,ACKSORT))+ACKVOL
 . S ACKT(ACKVDIV)=$G(ACKT(ACKVDIV))+ACKVOL
 . S ACKT2(ACKSORT)=$G(ACKT2(ACKSORT))+ACKVOL,ACKT2=ACKT2+ACKVOL
 Q
GETEC(ACKECN) ; Get EC Proc code data and put in ^TMP
 N ACKTMP,ACKEC S ACKTMP=$NA(^TMP("ACKQR5",$J,"EC",1))
 D GETS^DIQ(725,ACKECN_",",".01;1","",ACKTMP,"ACKMSG")
 S ACKEC=^TMP("ACKQR5",$J,"EC",1,725,ACKECN_",",1)
 S ^TMP("ACKQR5",$J,"EC",2,ACKEC)=ACKECN
 Q
ECDESC(ACKEC) ; Get ec Proc desc (short name)
 N ACKECN S ACKECN=^TMP("ACKQR5",$J,"EC",2,ACKEC)
 Q ^TMP("ACKQR5",$J,"EC",1,725,ACKECN_",",.01)
 ;
PRINT ; print report for each div
 S ACKVDIV=""
 I '$D(^TMP("ACKQR5",$J,1)) D  Q
 . D HDR
 . W !!,"No data found for report specifications.",!!
 . D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 F  S ACKVDIV=$O(ACKDIV(ACKVDIV)) Q:ACKVDIV=""!($D(DIRUT))  D PRINT2 Q:$D(DIRUT)
 I '$D(DIRUT) D TOTALS
 Q
 ;
PRINT2 ; print for a single div
 I '$D(^TMP("ACKQR5",$J,1,ACKVDIV)) D  Q
 . D HDR
 . W !!,"No data found for report specifications.",!!
 . D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 D HDR
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR5",$J,1,ACKVDIV,ACKSORT)) Q:(ACKSORT="")!($D(DIRUT))  D
 .I $Y>(IOSL-9) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 .W !!,"STOP CODE: ",$$STOPNM^ACKQRU(ACKSORT)
 .S ACKCLN="" F  S ACKCLN=$O(^TMP("ACKQR5",$J,1,ACKVDIV,ACKSORT,ACKCLN)) Q:ACKCLN=""!($D(DIRUT))  D
 ..I $Y>(IOSL-7) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ..W !!?2,"CLINIC: ",$$GET1^DIQ(44,ACKCLN_",",.01)
 ..S ACKSTF=""
 ..F  S ACKSTF=$O(^TMP("ACKQR5",$J,1,ACKVDIV,ACKSORT,ACKCLN,ACKSTF)) Q:ACKSTF=""!($D(DIRUT))  D
 ...I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ...W !!?2,$S("1^4"[ACKSS:"CLINICIAN: ","2^5"[ACKSS:"OTHER PROVIDER: ",1:"STUDENT: ")
 ...W $$CONVERT^ACKQUTL4(ACKSTF)
 ...S ACKEC=""
 ...F  S ACKEC=$O(^TMP("ACKQR5",$J,1,ACKVDIV,ACKSORT,ACKCLN,ACKSTF,ACKEC)) Q:(ACKEC="")!($D(DIRUT))  D
 ....I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ....W !?5,ACKEC,?15,$$ECDESC(ACKEC),?55,"COUNT: "
 ....W $J(^TMP("ACKQR5",$J,1,ACKVDIV,ACKSORT,ACKCLN,ACKSTF,ACKEC),4)
 Q:$D(DIRUT)  D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
SUMM ;
 Q:'$D(^TMP("ACKQR5",$J,0))  D SUMHD
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR5",$J,0,ACKVDIV,ACKSORT)) Q:ACKSORT=""!($D(DIRUT))  D
 .I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 .W !!,"STOP CODE: ",$$STOPNM^ACKQRU(ACKSORT)
 .S ACKEC=""
 .F  S ACKEC=$O(^TMP("ACKQR5",$J,0,ACKVDIV,ACKSORT,ACKEC)) Q:(ACKEC="")!($D(DIRUT))  D
 ..I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 ..W !?5,ACKEC,?15,$$ECDESC(ACKEC),?55,"COUNT: "
 ..W $J(^TMP("ACKQR5",$J,0,ACKVDIV,ACKSORT,ACKEC),4)
 .Q:$D(DIRUT)  I $Y>(IOSL-4) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 .Q:$D(DIRUT)
 .W !!,"Total For ",$$STOPNM^ACKQRU(ACKSORT)
 .W ?62,$J(ACKT(ACKVDIV,ACKSORT),4)
 Q:$D(DIRUT)  I $Y>(IOSL-4) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 Q:$D(DIRUT)  W !!,"Total For Division: "_$$DIVNAME(ACKVDIV),?62,$J(ACKT(ACKVDIV),4)
 Q:$D(DIRUT)  D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 Q
 ;
TOTALS ; Print final page of totals for all divs
 Q:'$D(^TMP("ACKQR5",$J,2))
 Q:$D(DIRUT)
 I $O(ACKT(""))=$O(ACKT(""),-1) Q  ; Must be only one div
 D TOTLHD S ACKTXT="DIVISIONS: "
 S ACKVDIV="" F  S ACKVDIV=$O(ACKT(ACKVDIV)) Q:ACKVDIV=""  D  Q:$D(DIRUT)
 . I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 . W !,ACKTXT,?12,$$DIVNAME(ACKVDIV) S ACKTXT=""
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR5",$J,2,ACKSORT)) Q:ACKSORT=""!($D(DIRUT))  D
 . I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 . W !!,"STOP CODE: ",$$STOPNM^ACKQRU(ACKSORT)
 . S ACKEC=""
 . F  S ACKEC=$O(^TMP("ACKQR5",$J,2,ACKSORT,ACKEC)) Q:(ACKEC="")!($D(DIRUT))  D
 . . I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 . . W !?5,ACKEC,?15,$$ECDESC(ACKEC),?55,"COUNT: "
 . . W $J(^TMP("ACKQR5",$J,2,ACKSORT,ACKEC),4)
 . I $Y>(IOSL-4) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 . Q:$D(DIRUT)
 . W !!,"Total For ",$$STOPNM^ACKQRU(ACKSORT)
 . W ?62,$J(ACKT2(ACKSORT),4)
 Q:$D(DIRUT)  I $Y>(IOSL-4) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 Q:$D(DIRUT)  W !!,"Grand Total:",?62,$J(ACKT2,4)
 Q:$D(DIRUT)  D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 Q
HDR ;
 W:($E(IOST)="C")!(ACKPG>0) @IOF
 S ACKPG=ACKPG+1
 W "Printed: ",ACKCDT,?(IOM-8),"Page: ",ACKPG,!
 W ! D CNTR^ACKQUTL("Audiology & Speech Pathology")
 W ! D CNTR^ACKQUTL("EC Procedure Statistics")
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
 W ! D CNTR^ACKQUTL("EC Procedure Statistics")
 W ! D CNTR^ACKQUTL("For Division: "_$$DIVNAME(ACKVDIV))
 W ! D CNTR^ACKQUTL("Summary")
 S X="",$P(X,"-",IOM)="-" W !,X
 Q
TOTLHD ;
 W:($E(IOST)="C")!(ACKPG>0) @IOF
 S ACKPG=ACKPG+1
 W "Printed: ",ACKCDT,?(IOM-8),"Page: ",ACKPG,!
 W ! D CNTR^ACKQUTL("Audiology and Speech Pathology")
 W ! D CNTR^ACKQUTL("EC Procedure Statistics")
 W ! D CNTR^ACKQUTL("Summary")
 S X="",$P(X,"-",IOM)="-" W !,X
 Q
 ;
DIVNAME(ACKVDIV) ; Get div name
 Q $$GET1^DIQ(40.8,ACKVDIV_",",.01)
 ;
STAFFNM(ACKSTF) ; Get staff name
 Q $$MIXC^ACKQUTL($$CONVERT^ACKQUTL4(ACKSTF))
