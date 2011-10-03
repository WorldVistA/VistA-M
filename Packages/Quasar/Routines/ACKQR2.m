ACKQR2 ;AUG/JLTP BIR/PTD HCIOFO/AG -Statistics by Procedure ; [ 12/07/95   9:52 AM ]
 ;;3.0;QUASAR;**1,8**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
OPTN W @IOF,!,"This option produces a report listing clinic visits for a date range"
 W !,"sorted by CPT-4 procedure codes.",!
 ;
 S ACKDIV=$$DIV^ACKQUTL2(3,.ACKDIV,"AI") G:+ACKDIV=0 EXIT
 ; Date's
 D DTRANGE^ACKQRU G:$D(DIRUT) EXIT
 S ACKRDR="Visits from "_ACKXBD_" to "_ACKXED
 ; 
 ; Type of report: Returns-
 ; ACKASB="A","S","O" or a combo, ACKSS=1-6 (1=one clinician etc)
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
 . S ZTRTN="DQ^ACKQR2",ZTDESC="QUASAR - A&SP PROCEDURE STATISTICS"
 . S ZTSAVE("ACK*")="" D ^%ZTLOAD D HOME^%ZIS K ZTSK
 ;
DQ ; Queued entry
 ; Vars required :-
 ; ACKDIV() - selected divs, ACKBD,ACKXBD - beginning date range (int,ext)
 ; ACKED,ACKXED - end date range (int, ext)
 ; ACKASB - A=audio,S=speech,O=other,ASO=all three
 ; ACKSS - type of report (1=one clinician etc),  ACKSTF(x) - selected prvds
 U IO
 D NOW^%DTC S ACKCDT=$$NUMDT^ACKQUTL(%)_" at "_$$FTIME^ACKQUTL(%),ACKPG=0
 K ^TMP("ACKQR2",$J),ACKT,ACKT2 S ACKT2=0
 ; $O thru visit file using date index
 F ACKD=ACKBD:0 S ACKD=$O(^ACK(509850.6,"B",ACKD)) Q:'ACKD!(ACKD>ACKED)  D
 . S ACKV=0 F  S ACKV=$O(^ACK(509850.6,"B",ACKD,ACKV)) Q:'ACKV  D STORE
 D PRINT
 ;
EXIT ; 1 way out
 K ACK2,ACKASB,ACKBD,ACKC,ACKCDT,ACKCL,ACKCLI,ACKCLN,ACKCLNC,ACKCPT
 K ACKSORT,ACKD,ACKED,ACKHDR2,ACKI,ACKLINE,ACKLR,ACKOOP,ACKP,ACKPC
 K ACKPCP,ACKPG,ACKRDR,ACKSS,ACKSTAFF,ACKSTF,ACKT,ACKV,ACKVSC,ACKXBD
 K ACKXED,ACKT2,ACKCT,ACKVDIV,ACKOK,ACKHDR,ACKDIV,ACKHDR5,ACKSORT
 K ACKCPTN,ACKVOL,ACKTXT,ACKQUIT,ZTSAVE,ZTSK,^TMP("ACKQR2",$J)
 K %DT,%I,%ZIS,%T,DIRUT,DTOUT,DUOUT,I,JJ,SS,X,Y,ZTDESC,ZTIO,ZTRTN
 W:$E(IOST)="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
STORE ;
 S ACKHDR=^ACK(509850.6,ACKV,0),ACKHDR5=^ACK(509850.6,ACKV,5)
 ; Get div,make sure it was selected
 S ACKVDIV=$P(ACKHDR5,U,1)
 I '$D(ACKDIV(ACKVDIV)) Q
 ;
 S ACKCLNC=+$P(ACKHDR,U,6) ; clinic IEN
 Q:'ACKCLNC
 S ACK2=$G(^ACK(509850.6,ACKV,2))
 S ACKVSC=$P(ACK2,U) ; clinic stp code
 ; Determine sort order for visit stp code (will return zero if
 ; the visit isnt to be included in report
 S ACKSORT=$$STOPSORT^ACKQRU(ACKASB,ACKVSC) Q:'ACKSORT
 ;
 ; Check stff member for report
 I (ACKSS=3)!(ACKSS=6) S ACKLR=$P(ACK2,U,4)  Q:ACKLR=""  Q:'$D(ACKSTF(ACKLR))
 ;
 ; Count the proc codes for visit
 S ACKP=0 F  S ACKP=$O(^ACK(509850.6,ACKV,3,ACKP)) Q:'ACKP  D
 . S ACKQQPN=$$GET1^DIQ(509850.61,ACKP_","_ACKV_",",.07,"I","","")
 . I ACKQQPN'="" Q  ;  Has a Pointer to EC code therefore created by EC
 . S ACKCPTN=$$GET1^DIQ(509850.61,ACKP_","_ACKV_",",.01,"I","","")
 . S ACKVOL=$$GET1^DIQ(509850.61,ACKP_","_ACKV_",",.03,"I","","")
 . S:ACKVOL<1 ACKVOL=1
 . S ACKQUIT=0
 . I ACKSS'=3,ACKSS'=6 D  Q:ACKQUIT
 . . S ACKLR=$$GET1^DIQ(509850.61,ACKP_","_ACKV_",",.05,"I","","")
 . . I ACKLR="" S ACKLR=$$LEADROLE^ACKQUTL2(ACKV)
 . . I ACKLR="" S ACKQUIT=1
 . . I '$D(ACKSTF(ACKLR)) S ACKQUIT=1
 . ;
 . I '$D(^TMP("ACKQR2",$J,"CPT",1,81,ACKCPTN_",")) D GETCPT(ACKCPTN)
 . S ACKCPT=^TMP("ACKQR2",$J,"CPT",1,81,ACKCPTN_",",.01)
 . I ACKCPT="" Q
 . ; Add to cnt of procs for stff member
 . S ACKCT=+$G(^TMP("ACKQR2",$J,1,ACKVDIV,ACKSORT,ACKCLNC,ACKLR,ACKCPT))
 . S ^TMP("ACKQR2",$J,1,ACKVDIV,ACKSORT,ACKCLNC,ACKLR,ACKCPT)=ACKCT+ACKVOL
 . ; Add to cnt of procs for the stp code within div
 . S ^TMP("ACKQR2",$J,0,ACKVDIV,ACKSORT,ACKCPT)=$G(^TMP("ACKQR2",$J,0,ACKVDIV,ACKSORT,ACKCPT))+ACKVOL
 . ; Add to cnt of procs for all divs
 . S ^TMP("ACKQR2",$J,2,ACKSORT,ACKCPT)=$G(^TMP("ACKQR2",$J,2,ACKSORT,ACKCPT))+ACKVOL
 . ; Add to tot cnt for the stp code, the div & grand tot
 . S ACKT(ACKVDIV,ACKSORT)=$G(ACKT(ACKVDIV,ACKSORT))+ACKVOL
 . S ACKT(ACKVDIV)=$G(ACKT(ACKVDIV))+ACKVOL
 . S ACKT2(ACKSORT)=$G(ACKT2(ACKSORT))+ACKVOL,ACKT2=ACKT2+ACKVOL
 Q
GETCPT(ACKCPTN) ; Get Proc code data & put in ^TMP
 N ACKTMP,ACKCPT S ACKTMP=$NA(^TMP("ACKQR2",$J,"CPT",1))
 D GETS^DIQ(81,ACKCPTN_",",".01","",ACKTMP,"ACKMSG")
 S ACKCPT=^TMP("ACKQR2",$J,"CPT",1,81,ACKCPTN_",",.01)
 S ^TMP("ACKQR2",$J,"CPT",1,81,ACKCPTN_",",2)=$$PROCTXT^ACKQUTL8(ACKCPTN,"")
 S ^TMP("ACKQR2",$J,"CPT",2,ACKCPT)=ACKCPTN
 Q
CPTDESC(ACKCPT) ; Get Proc desc
 N ACKCPTN S ACKCPTN=^TMP("ACKQR2",$J,"CPT",2,ACKCPT)
 Q ^TMP("ACKQR2",$J,"CPT",1,81,ACKCPTN_",",2)
 ;
PRINT ; print report 4 each div
 S ACKVDIV=""
 I '$D(^TMP("ACKQR2",$J,1)) D  Q
 . D HDR
 . W !!,"No data found for report specifications.",!!
 . D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 F  S ACKVDIV=$O(ACKDIV(ACKVDIV)) Q:ACKVDIV=""!($D(DIRUT))  D PRINT2 Q:$D(DIRUT)
 I '$D(DIRUT) D TOTALS
 Q
 ;
PRINT2 ; print for single div
 I '$D(^TMP("ACKQR2",$J,1,ACKVDIV)) D  Q
 . D HDR
 . W !!,"No data found for report specifications.",!!
 . D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 D HDR
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR2",$J,1,ACKVDIV,ACKSORT)) Q:(ACKSORT="")!($D(DIRUT))  D
 .I $Y>(IOSL-9) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 .W !!,"STOP CODE: ",$$STOPNM^ACKQRU(ACKSORT)
 .S ACKCLN="" F  S ACKCLN=$O(^TMP("ACKQR2",$J,1,ACKVDIV,ACKSORT,ACKCLN)) Q:ACKCLN=""!($D(DIRUT))  D
 ..I $Y>(IOSL-7) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ..W !!?2,"CLINIC: ",$$GET1^DIQ(44,ACKCLN_",",.01)
 ..S ACKSTF=""
 ..F  S ACKSTF=$O(^TMP("ACKQR2",$J,1,ACKVDIV,ACKSORT,ACKCLN,ACKSTF)) Q:ACKSTF=""!($D(DIRUT))  D
 ...I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ...W !!?2,$S("1^4"[ACKSS:"CLINICIAN: ","2^5"[ACKSS:"OTHER PROVIDER: ",1:"STUDENT: ")
 ...W $$CONVERT^ACKQUTL4(ACKSTF)
 ...S ACKCPT=""
 ...F  S ACKCPT=$O(^TMP("ACKQR2",$J,1,ACKVDIV,ACKSORT,ACKCLN,ACKSTF,ACKCPT)) Q:(ACKCPT="")!($D(DIRUT))  D
 ....I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR
 ....W !?5,ACKCPT,?15,$$CPTDESC(ACKCPT),?55,"COUNT: "
 ....W $J(^TMP("ACKQR2",$J,1,ACKVDIV,ACKSORT,ACKCLN,ACKSTF,ACKCPT),4)
 Q:$D(DIRUT)  D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
SUMM ;
 Q:'$D(^TMP("ACKQR2",$J,0))  D SUMHD
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR2",$J,0,ACKVDIV,ACKSORT)) Q:ACKSORT=""!($D(DIRUT))  D
 .I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 .W !!,"STOP CODE: ",$$STOPNM^ACKQRU(ACKSORT)
 .S ACKCPT=""
 .F  S ACKCPT=$O(^TMP("ACKQR2",$J,0,ACKVDIV,ACKSORT,ACKCPT)) Q:(ACKCPT="")!($D(DIRUT))  D
 ..I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 ..W !?5,ACKCPT,?15,$$CPTDESC(ACKCPT),?55,"COUNT: "
 ..W $J(^TMP("ACKQR2",$J,0,ACKVDIV,ACKSORT,ACKCPT),4)
 .Q:$D(DIRUT)  I $Y>(IOSL-4) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 .Q:$D(DIRUT)
 .W !!,"Total For ",$$STOPNM^ACKQRU(ACKSORT)
 .W ?62,$J(ACKT(ACKVDIV,ACKSORT),4)
 Q:$D(DIRUT)  I $Y>(IOSL-4) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D SUMHD
 Q:$D(DIRUT)  W !!,"Total For Division: "_$$DIVNAME(ACKVDIV),?62,$J(ACKT(ACKVDIV),4)
 Q:$D(DIRUT)  D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 Q
 ;
TOTALS ; Print final page of tots 4 all divs
 Q:'$D(^TMP("ACKQR2",$J,2))
 Q:$D(DIRUT)
 I $O(ACKT(""))=$O(ACKT(""),-1) Q  ; Must be only one div
 D TOTLHD S ACKTXT="DIVISIONS: "
 S ACKVDIV="" F  S ACKVDIV=$O(ACKT(ACKVDIV)) Q:ACKVDIV=""  D  Q:$D(DIRUT)
 . I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 . W !,ACKTXT,?12,$$DIVNAME(ACKVDIV) S ACKTXT=""
 S ACKSORT=""
 F  S ACKSORT=$O(^TMP("ACKQR2",$J,2,ACKSORT)) Q:ACKSORT=""!($D(DIRUT))  D
 . I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 . W !!,"STOP CODE: ",$$STOPNM^ACKQRU(ACKSORT)
 . S ACKCPT=""
 . F  S ACKCPT=$O(^TMP("ACKQR2",$J,2,ACKSORT,ACKCPT)) Q:(ACKCPT="")!($D(DIRUT))  D
 . . I $Y>(IOSL-3) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D TOTLHD
 . . W !?5,ACKCPT,?15,$$CPTDESC(ACKCPT),?55,"COUNT: "
 . . W $J(^TMP("ACKQR2",$J,2,ACKSORT,ACKCPT),4)
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
 W ! D CNTR^ACKQUTL("Procedure Statistics")
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
 W ! D CNTR^ACKQUTL("Procedure Statistics")
 W ! D CNTR^ACKQUTL("For Division: "_$$DIVNAME(ACKVDIV))
 W ! D CNTR^ACKQUTL("Summary")
 S X="",$P(X,"-",IOM)="-" W !,X
 Q
 ;
TOTLHD W:($E(IOST)="C")!(ACKPG>0) @IOF
 S ACKPG=ACKPG+1
 W "Printed: ",ACKCDT,?(IOM-8),"Page: ",ACKPG,!
 W ! D CNTR^ACKQUTL("Audiology and Speech Pathology")
 W ! D CNTR^ACKQUTL("Procedure Statistics")
 W ! D CNTR^ACKQUTL("Summary")
 S X="",$P(X,"-",IOM)="-" W !,X
 Q
DIVNAME(ACKVDIV) ; Get div name
 Q $$GET1^DIQ(40.8,ACKVDIV_",",.01)
STAFFNM(ACKSTF) ; Get staff name
 Q $$MIXC^ACKQUTL($$CONVERT^ACKQUTL4(ACKSTF))
