IBJDF43 ;ALB/RB - FIRST PARTY FOLLOW-UP REPORT (COMPILE/PRINT SUMMARY);15-APR-00
 ;;2.0;INTEGRATED BILLING;**123**;21-MAR-94
 ;
INIT ; - Initialize counters (Called by IBJDF41)
 ;   Pre-set variables IB, IB(, IBCAT, IBSRC required.
 N I,IB0 S IB0=$S(IB=40:19,1:IB)
 ;
 I '$D(IB(IBCAT,IB0)) D
 .I IBSTA="A",IB0'=16 Q  ; Active AR's only.
 .I IBSTA="S",IB0=16 Q  ; Suspended AR's only.
 .F I=1:1:$S(IBSRC:8,1:7),9 S IB(IBCAT,IB0,I)=0
 Q
 ;
EN ; - Compile entry point from IBJDF41.
 ;   Pre-set variables IB, IB(, IBA, IBCAT, IBSRC required.
 N I,IB0,IBAGE,IBARD,IBCAT1,IBOUT S IB0=$S(IB=40:19,1:IB)
 ;
 ; - Add totals for summary.
 S IBARD=$$ACT^IBJDF2(IBA) G:'IBARD ENQ ; No activation date.
 S IBOUT=0 F I=1:1:5 S IBOUT=IBOUT+$P($G(^PRCA(430,IBA,7)),U,I)
 ;
 ; - Handle claims referred to Regional Counsel.
 I IBSRC,$P($G(^PRCA(430,IBA,6)),U,4) D  G ENQ
 .S $P(IB(IBCAT,IB0,8),U)=$P(IB(IBCAT,IB0,8),U)+1
 .S $P(IB(IBCAT,IB0,8),U,2)=$P(IB(IBCAT,IB0,8),U,2)+IBOUT
 ;
 S IBAGE=$$FMDIFF^XLFDT(DT,IBARD),IBCAT1=$$CAT^IBJDF2(IBAGE)
 S $P(IB(IBCAT,IB0,IBCAT1),U)=$P(IB(IBCAT,IB0,IBCAT1),U)+1
 S $P(IB(IBCAT,IB0,IBCAT1),U,2)=$P(IB(IBCAT,IB0,IBCAT1),U,2)+IBOUT
 ;
ENQ K IBPRTFLG,IBPAG,IBRUN,J,Z Q
 ;
PRT ; - Print entry point from IBJDF42.
 ;
 ; - Extract summary data.
 I $G(IBXTRACT) D EXTMO(.IB) G ENQ1
 ;
 ; - Print the summary report.
 D SUM
 ;
ENQ1 Q
 ;
EXTMO(IBS) ; Extract/transmit data to DM Extract Module
 ; IBS - Array containing the summary information
 ;
 N IB,IBCT,IBI,IBJ,IBR,IBSQ,IBTP,IBZ
 ;
 F IBI=1:1:5 F IBJ=1:1:18 S IB(IBI,IBJ)=$S(IBJ#2:0,1:"0.00")
 ;
 S IBCT=""
 F  S IBCT=$O(IBS(IBCT)) Q:IBCT=""  D
 . S IBTP=0
 . I IBCT=2 S IBTP=1       ;  Emergency/Humatiatiran
 . I IBCT=1 S IBTP=2       ;  Ineligible
 . I IBCT=18 S IBTP=3      ;  C - Means Test
 . I IBCT=22 S IBTP=4      ;  RX CO-Payment/SC VET
 . I IBCT=23 S IBTP=5      ;  RX CO-Payment/NSC VET
 . S IBSQ=1
 . F IBI=1:1:8 D
 . . S IBZ=$G(IBS(IBCT,16,IBI))
 . . S IB(IBTP,IBSQ)=+IBZ
 . . S IB(IBTP,IBSQ+1)=$FN(+$P(IBZ,"^",2),"",2)
 . . S IB(IBTP,17)=IB(IBTP,17)+IBZ
 . . S IB(IBTP,18)=IB(IBTP,18)+$P(IBZ,"^",2)
 . . S IBSQ=IBSQ+2
 . S IB(IBTP,18)=$FN(IB(IBTP,18),"",2)
 ;
 F IBR=12:1:16 D E^IBJDE(IBR,0)
 Q
 ;
SUM ; - Print summary for AR category.
 ; Input: IBCAT=AR category pointer to file #430.2
 S IBS=$S(IBSRC:8,1:7)
 S (IBCAT,IB,IBPRTFLG)=0
 F  S IBCAT=$O(IB(IBCAT)) Q:'IBCAT  D  Q:IBQ
 . D HDR
 . F  S IB=$O(IB(IBCAT,IB)) Q:'IB  D  Q:IBQ
 . . ; - Calculate totals first.
 . . F I=1:1:IBS D  Q:IBQ
 . . . F J=1,2 S $P(IB(IBCAT,IB,9),U,J)=$P(IB(IBCAT,IB,9),U,J)+$P(IB(IBCAT,IB,I),U,J)
 . . ;
 . . I $Y>(IOSL-16) D HDR Q:IBQ
 . . ;
 . . S X=$S(IB=16:"ACTIVE ",1:"SUSPENDED ")
 . . S X=X_$P($G(^PRCA(430.2,IBCAT,0)),U)
 . . W !!!!?(80-$L(X)\2),X,!?(80-$L(X)\2),$$DASH($L(X)),!!
 . . ;
 . . W "AR Category",?31,"# Receivables",?52,"Total Outstanding Balance",!
 . . W "-----------",?31,"-------------",?52,"-------------------------",!
 . . I 'IB(IBCAT,IB,9) W !,"There are no statistics for this category." D PAUSE Q
 . . ;
 . . ; - Primary loop to write results.
 . . S Y=$P(IB(IBCAT,IB,9),U,2)
 . . F I=1:1:IBS,9 S X=$P($T(CATN+I),";;",2,99) D
 . . . W:I=9 ! W !,X,?30,$J(+IB(IBCAT,IB,I),6)
 . . . W "  (",$J(+IB(IBCAT,IB,I)/+IB(IBCAT,IB,9)*100,0,$S(I=9:0,1:2)),"%)"
 . . . S Z=$FN($P(IB(IBCAT,IB,I),U,2),",",2)
 . . . W ?52,$J($S(I=1!(I=9):"$",1:"")_Z,15)
 . . . W "  (",$J($S('Y:0,1:$P(IB(IBCAT,IB,I),U,2)/Y*100),0,$S(I=9:0,1:2)),"%)"
 . . ;
 . . S IBPRTFLG=1 D PAUSE
 ;
 I 'IBPRTFLG D
 . W !!!!!!,"There are no receivables for the parameters entered."
 ;
SUMQ Q
 ;
HDR ; - Write the summary report header.
 W:'$G(IBPAG) ! I $E(IOST,1,2)="C-"!$G(IBPAG) W @IOF,*13
 S IBPAG=$G(IBPAG)+1
 W "FIRST PARTY FOLLOW-UP SUMMARY REPORT   Run Date: ",IBRUN
 W ?71,"Page: ",$J(IBPAG,3)
 S X=""
 I IBRPT="D" D
 . I IBSMN'="A" D
 . . S X="  RECEIVABLES OVER "_IBSMN_" AND LESS THAN "_IBSMX_" DAYS OLD "
 . I $G(IBSNA)'="ALL" D
 . . S X=X_"/ PATIENTS FROM '"_$S(IBSNF="":"FIRST",1:IBSNF)_"' TO '"
 . . S X=X_$S(IBSNL="zzzzz":"LAST",1:IBSNL)_"' "
 . I $G(IBSAM) S X=X_"/ MINIMUM BALANCE: $"_$FN(IBSAM,",",2)_" "
 S X=X_"/ RECEIVABLES REFERRED TO RC "_$S('IBSRC:"NOT ",1:"")_"INCLUDED"
 S $E(X,1,2)=""
 F I=1:1 W !,$E(X,1,80) S X=$E(X,81,999) I X="" Q
 ;
 Q
 ;
DASH(X) ; - Return a dashed line.
 Q $TR($J("",X)," ","=")
 ;
PAUSE ; - Page break.
 I $E(IOST,1,2)'="C-" Q
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR S:$D(DIRUT)!($D(DUOUT)) IBQ=1
 Q
 ;
CATN ; - List of category names.
 ;;Less than 30 days old
 ;;31-60 days
 ;;61-90 days
 ;;91-120 days
 ;;121-180 days
 ;;181-365 days
 ;;Over 365 days
 ;;Referred to Regional Counsel
 ;;Total First Party Receivables
