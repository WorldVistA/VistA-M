LRRP8C ;DALISC/TNN/J0 - WKLD STATS REPORT BY SHIFT ; 4/9/93
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 W !!,"ENTRY POINT IS AT EN^LRRP8." H 3 QUIT
 ;
PRINT ;
 W:$E(IOST,1,2)="C-" @IOF
 S LRGCNT=+$G(^TMP("LR",$J,0))
 I 'LRGCNT W !,"  *** NO DATA FOR THIS REPORT ***",! Q
 D:LRRPT=1 DET Q:LREND
 D SUM Q:LREND
 D PRNTMAN^LRCAPMR1 Q:LREND
 D COMM^LRCAPMR2 Q:LREND
 Q
DET ;
 S LRA=0
 F  S LRA=$O(^TMP("LR",$J,"AA",LRA)) Q:('LRA)!(LREND)  D
 . S LRANAM=$P($G(^LRO(68,LRA,0)),U)
 . D HDR^LRCAPU
 . W !,"Accession Area: ",LRANAM,!
 . S LRACNT=+$G(^TMP("LR",$J,"AA",LRA,0))
 . I 'LRACNT W !,"  *** NO DATA FOR THIS ACCESSION AREA ***",! Q
 . S LRSHFT=0
 . F  S LRSHFT=$O(LRST(LRSHFT)) Q:('LRSHFT)!(LREND)  D
 . . S LRCONT=0 D SHFTHDR S LRCONT=1
 . . S LRSCNT=+$G(^TMP("LR",$J,"AA",LRA,"SHFT",LRSHFT,0))
 . . I 'LRSCNT W !,"  *** NO DATA FOR THIS SHIFT ***",! Q
 . . S LRCAPNAM=""
 . . F  S LRCAPNAM=$O(^TMP("LR",$J,"AA",LRA,"SHFT",LRSHFT,"CCN",LRCAPNAM)) Q:(LRCAPNAM="")!(LREND)  D
 . . . S LRREC=$G(^TMP("LR",$J,"AA",LRA,"SHFT",LRSHFT,"CCN",LRCAPNAM,0))
 . . . S LRCCNT=+LRREC,LRCAPNUM=$P(LRREC,U,2)
 . . . S LRPCT=(LRCCNT/LRSCNT)*100
 . . . I $Y+7>IOSL D
 . . . . D NPG^LRCAPU Q:LREND
 . . . . W !,"Accession Area: ",LRANAM,"   (cont.)",!
 . . . . D SHFTHDR
 . . . Q:LREND
 . . . W $J(LRCCNT,7),?10,$E(LRCAPNAM,1,30),?42,LRCAPNUM
 . . . W ?53,$J(LRPCT,6,2),"%",!
 . . Q:LREND
 . . W "Shift subtotal: ",$J(LRSCNT,8),!
 . Q:LREND
 . D AASUM
 . Q:LREND
 . D:$E(IOST,1,2)="C-" PAUSE^LRCAPU Q:LREND  W @IOF
 Q
AASUM ;*** Accession Area summary ***
 D NPG^LRCAPU Q:LREND  W !,"Accession Area: ",LRANAM,"   (cont.)",!
 I LRSTFLG=1 D
 . W !
 . S LRSHFT=0
 . F  S LRSHFT=$O(LRST(LRSHFT)) Q:('LRSHFT)!(LREND)  D
 . . S LRSCNT=+$G(^TMP("LR",$J,"AA",LRA,"SHFT",LRSHFT,0))
 . . S LRPCT=(LRSCNT/LRACNT)*100
 . . W "Shift#",LRSHFT,": ",$J(LRPCT,6,2)
 . . W "% of ",LRANAM," total.",!
 . W !
 S LRCONT=0 D ACCHDR S LRCONT=1
 S LRCAPNAM=""
 F  S LRCAPNAM=$O(^TMP("LR",$J,"AA",LRA,"CCN",LRCAPNAM)) Q:(LRCAPNAM="")!(LREND)  D
 . S LRREC=$G(^TMP("LR",$J,"AA",LRA,"CCN",LRCAPNAM,0))
 . S LRCCNT=+LRREC,LRCAPNUM=$P(LRREC,U,2)
 . S LRPCT=(LRCCNT/LRACNT)*100
 . I $Y+5>IOSL D
 . . D NPG^LRCAPU Q:LREND
 . . W !,"Accession Area: ",LRANAM,"   (cont.)",!
 . . D ACCHDR
 . Q:LREND
 . W $J(LRCCNT,7),?10,$E(LRCAPNAM,1,30),?42,LRCAPNUM
 . W ?53,$J(LRPCT,6,2),"%",!
 Q:LREND
 W !,LRANAM," subtotal:  ",$J(LRACNT,8),!
 Q
SUM ;
 D HDR^LRCAPU
 S LRCONT=0 D SUMHDR S LRCONT=1
 S LRA=0
 F  S LRA=$O(^TMP("LR",$J,"AA",LRA))  Q:('LRA)!(LREND)  D
 . S LRANAM=$P($G(^LRO(68,LRA,0)),U)
 . S LRACNT=+$G(^TMP("LR",$J,"AA",LRA,0))
 . S LRPCT=(LRACNT/LRGCNT)*100
 . I $Y+7>IOSL D
 . . D NPG^LRCAPU Q:LREND
 . . D SUMHDR
 . Q:LREND
 . W $J(LRACNT,8),?10,LRANAM,?42,$J(LRPCT,6,2),"% of grand total.",!
 Q:LREND
 W !,"Grand Total: ",$J(LRGCNT,8),!
 D:$E(IOST,1,2)="C-" PAUSE^LRCAPU Q:LREND  W @IOF
 Q
SHFTHDR ;
 I LRSTFLG=1 D
 . W !!,"SHIFT#",LRSHFT," FROM: ",$P(LRST(LRSHFT),"^")," Hours  TO: "
 . W $P(LRST(LRSHFT),"^",2)," Hours." W:LRCONT "   (cont.)" W !
 E  D
 . W !!,"TIME RANGE FROM: ",$P(LRST(LRSHFT),"^")," Hours  TO: "
 . W $P(LRST(LRSHFT),"^",2)," Hours." W:LRCONT "   (cont.)" W !
 W !,"  Count   Procedure Name                  Code       "
 W "Percent of shift subtotal",!
 W $E(LRDSHS,1,80),!
 Q
ACCHDR ;
 W !,"Total count for each type of WKLD code:" W:LRCONT "  (cont.)" W !
 W !,"  Count   Procedure Name                  Code       "
 W "Pct of Acc. area subtotal",!
 W $E(LRDSHS,1,80),!
 Q
SUMHDR ;
 W !,"Summary by Accession Area:" W:LRCONT "  (cont.)" W !
 W !,"   Count  Accession Area                  "
 W "Percent of grand total",!
 W $E(LRDSHS,1,80),!
 Q
