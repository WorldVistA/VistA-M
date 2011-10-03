IBJDF63 ;ALB/RB - MISC. BILLS FOLLOW-UP REPORT (COMPILE/PRINT SUMMARY);15-APR-00
 ;;2.0;INTEGRATED BILLING;**123**;21-MAR-94
 ;
INIT ; - Initialize counters, if necessary.
 I IBSDV,IBDIV," 6 7 10 21 "'[(" "_IBCAT_" ") Q
 I IBSDV,'IBDIV," 6 7 10 21 "[(" "_IBCAT_" ") Q
 F I=1:1:8 S IB(IBDIV,IBCAT,I)=0
 Q
 ;
EN ; - Compile entry point from IBJDF61.
 ;   Pre-set variables IBA, IBCAT, IBDIV required.
 N I,IB0,IBAGE,IBARD,IBOUT,J
 ;
 ; - Add totals for summary.
 S IBARD=$$ACT^IBJDF2(IBA) G:'IBARD ENQ ; No activation date.
 S IBOUT=0 F I=1:1:5 S IBOUT=IBOUT+$P($G(^PRCA(430,IBA,7)),U,I)
 S IBAGE=$$FMDIFF^XLFDT(DT,IBARD),IB0=$$CAT(IBAGE)
 S $P(IB(IBDIV,IBCAT,IB0),U)=+IB(IBDIV,IBCAT,IB0)+1
 S $P(IB(IBDIV,IBCAT,IB0),U,2)=$P(IB(IBDIV,IBCAT,IB0),U,2)+IBOUT
ENQ Q
 ;
PRT ; - Print entry point from IBJDF62.
 ;
 ; - Extract summary data.
 I $G(IBXTRACT) D EXTMO(.IB) G ENQ1
 ;
 S IBDIV=""
 F  S IBDIV=$O(IB(IBDIV)) Q:IBDIV=""  D SUM(IBDIV)  Q:IBQ
 ;
ENQ1 Q
 ;
EXTMO(IBS) ; Extract/transmit data to DM Extract Module
 ; IBS - Array containing the summary information
 ;
 N IB,IBCT,IBI,IBJ,IBR,IBSQ,IBTP,IBZ
 ;
 F IBI=1,2,3 F IBJ=1:1:16 S IB(IBI,IBJ)=$S(IBJ#2:0,1:"0.00")
 ;
 F IBCT=6,7,10 D
 . S IBTP=0
 . I IBCT=7 S IBTP=1       ;  Workman's Comp.
 . I IBCT=10 S IBTP=2      ;  NO-Fault Auto Accident
 . I IBCT=6 S IBTP=3       ;  Tort-Feasor
 . S IBSQ=1
 . F IBI=1:1:7 D
 . . S IBZ=$G(IBS(0,IBCT,IBI))
 . . S IB(IBTP,IBSQ)=+IBZ
 . . S IB(IBTP,IBSQ+1)=$FN(+$P(IBZ,"^",2),"",2)
 . . S IB(IBTP,15)=IB(IBTP,15)+IBZ
 . . S IB(IBTP,16)=IB(IBTP,16)+$P(IBZ,"^",2)
 . . S IBSQ=IBSQ+2
 . S IB(IBTP,16)=$FN(IB(IBTP,16),"",2)
 ;
 F IBR=22:1:24 D E^IBJDE(IBR,0)
 Q
 ;
SUM(IBDIV) ; - Print summary for division.
 ;  Input: IBDIV=Pointer to the division in file #40.8 and pre-set
 ;         variable IBRPT
 N IBDH,IBTYP,I,J,Z,%
 ;
 S IBCAT=0
 F  S IBCAT=$O(IB(IBDIV,IBCAT)) Q:'IBCAT  D  Q:IBQ
 . D HDR Q:IBQ
 . S IBTYP=$G(IBCTG(IBCAT(IBCAT)))_" RECEIVABLES"
 . W !!?(80-$L(IBTYP))\2,IBTYP
 . W !?(80-$L(IBTYP)\2),$$DASH($L(IBTYP))
 . I IBDIV D
 . . S IBDH="Division: "_$P($G(^DG(40.8,IBDIV,0)),U)
 . . W !?(80-$L(IBDH)\2),IBDH
 . ;
 . W !!
 . ;
 . ; - Calculate totals first.
 . F I=1:1:7 F J=1,2 S $P(IB(IBDIV,IBCAT,8),U,J)=$P(IB(IBDIV,IBCAT,8),U,J)+$P(IB(IBDIV,IBCAT,I),U,J)
 . ;
 . W "AR Category",?31,"# Receivables",?52,"Total Outstanding Balance",!
 . W "-----------",?31,"-------------",?52,"-------------------------"
 . I 'IB(IBDIV,IBCAT,8) W !!,"There are no active receivables",$S(IBDIV:" for this division",1:""),".",!! D PAUSE Q
 . ;
 . ; - Primary loop to write results.
 . S Y=$P(IB(IBDIV,IBCAT,8),U,2) F I=1:1:8 S X=$P($T(CATN+I),";;",2,99) D
 . . W:I=8 ! W !,X,?30,$J(+IB(IBDIV,IBCAT,I),6)
 . . W "  (",$J(+IB(IBDIV,IBCAT,I)/+IB(IBDIV,IBCAT,8)*100,0,$S(I=8:0,1:2)),"%)"
 . . S Z=$FN($P(IB(IBDIV,IBCAT,I),U,2),",",2)
 . . W ?52,$J($S(I=1!(I=9):"$",1:"")_Z,15)
 . . W "  (",$J($S('Y:0,1:$P(IB(IBDIV,IBCAT,I),U,2)/Y*100),0,$S(I=8:0,1:2)),"%)"
 . . W:I=8 !!
 . ;
 . D PAUSE
 ;
SUMQ Q
 ;
HDR ; - Write the summary report header.
 N X,PD,PDA,PDF,PDL
 ;
 I $E(IOST,1,2)="C-"!$G(IBPAG) W @IOF,*13
 S IBPAG=$G(IBPAG)+1
 W "MISCELLANEOUS BILLS FOLLOW-UP SUMMARY REPORT"
 W ?71,"Page: ",$J(IBPAG,3),!,"Run Date: ",IBRUN
 S X=""
 I IBRPT="D" D
 . I IBSMN'="A" D
 . . S X="  RECEIVABLES OVER "_IBSMN_" AND LESS THAN "_IBSMX_" DAYS OLD "
 . I IBCAT(IBCAT)>4 S PD="DEBTORS",PDA=IBSDA,PDF=IBSDF,PDL=IBSDL
 . I IBCAT(IBCAT)<5 S PD="PATIENTS",PDA=IBSNA,PDF=IBSNF,PDL=IBSNL
 . I $G(PDA)'="ALL" D
 . . S X=X_"/ "_PD_" FROM '"_$S(PDF="":"FIRST",1:PDF)_"' TO '"
 . . S X=X_$S(PDL="zzzzz":"LAST",1:PDL)_"' "
 . I $G(IBSAM) S X=X_"/ MINIMUM BALANCE: $"_$FN(IBSAM,",",2)_" "
 S $E(X,1,2)=""
 I X'="" F I=1:1 W !,$E(X,1,80) S X=$E(X,81,999) I X="" Q
 ;
 Q
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
CAT(X) ; - Determine category to place receivable.
 Q $S($G(X)<31:1,X<61:2,X<91:3,X<121:4,X<181:5,X<366:6,1:7)
 ;
CATN ; - List of category names.
 ;;Less than 30 days old
 ;;31-60 days
 ;;61-90 days
 ;;91-120 days
 ;;121-180 days
 ;;181-365 days
 ;;Over 365 days
 ;;Total Misc. Receivables
