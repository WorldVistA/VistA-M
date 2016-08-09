IBOTR3 ;ALB/CPM - INSURANCE PAYMENT TREND REPORT - OUTPUT ;5-JUN-91
 ;;2.0;INTEGRATED BILLING;**42,80,100,118,128,133,447,516,528,529**;21-MAR-94;Build 49
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCROTR3
 ;
EN(IBDIV) ; - Entry point from IBOTR2.
 ;
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 ; - Extract zero totals if no data available.
 I $G(IBXTRACT),'$D(^TMP($J,"IBOTR",IBDIV)) D  G END
 .S IBUNPD=0 F X=1:1:8 S IBTT(X)=0
 .D E^IBJDE(8,0)
 ;
 I $G(IBXTRACT) G IBX ; Calculate grand totals for extract.
 ;
 S IBPAG=0,IBLINE="",$P(IBLINE,"-",IOM)="-",Y=DT D D^DIQ S IBTDT=Y
 I $D(IBAF) D ADDFLD^IBOTR4
 I '$D(^TMP($J,"IBOTR",IBDIV)) D  S IBCALC=3 D PAUSE G END
 .S IBX=$S("Bb"'[IBBRT:IBBRT,IBBRN="C":"A",1:"I")
 .D HDR W !!,"  NO INFORMATION MATCHES SELECTION CRITERIA."
 ;
IBX      S IBX="" F  S IBX=$O(^TMP($J,"IBOTR",IBDIV,IBX)) Q:IBX=""  D  Q:IBQUIT
 .I IBPRNT'="G"!('$G(IBG)) S IBTT="0^0^0^0^0^0^0^0^0^0"
 .I IBOUT="E" D EXCHDR
 .I IBOUT="R" D:'$G(IBXTRACT) HDR Q:IBQUIT
 .D INS
 ;
END      K IBINS,IBPAG,IBLINE,IBTDT,IBX,IBTT,IBTI,IBCALC,IBBN,IBD,IBDS,IBAFT
 K IBAMT,IBG,IBI,IBPERC,IBUNPD,X,X1,X2,IBGRP,IBOUT,STOP
 K IBBLNO,IBRJFLAG,IBGRPD,INSC
 Q
 ;
INS      ; - Loop through each insurance company or amount.
 I IBSORT="I" D
 .S IBINS="" F  S IBINS=$O(^TMP($J,"IBOTR",IBDIV,IBX,IBINS)) Q:IBINS=""  D BILLNO Q:IBQUIT
 I IBSORT'="I" D
 .S IBAMT="" F  S IBAMT=$O(^TMP($J,"IBOTRS",IBDIV,IBX,IBAMT)) Q:IBAMT=""  S IBINS="" F  S IBINS=$O(^TMP($J,"IBOTRS",IBDIV,IBX,IBAMT,IBINS)) Q:IBINS=""!(IBQUIT)  D BILLNO Q:IBQUIT
 ;
 ; - Extract grand totals data.
 I $G(IBXTRACT),'IBQUIT D  Q
 .S IBUNPD=$J($P(IBTT,U,2)-$P(IBTT,U,5),0,2)
 .F X=1:1:8 S IBTT(X)=$S(19'[X:$J($P(IBTT,U,X),0,2),1:$P(IBTT,U,X))
 .D E^IBJDE(8,0)
 ;
 I 'IBQUIT,'$G(IBG),IBOUT="R" D GTOT^IBOTR4 ; Write grand totals for report.
 Q
 ;
BILLNO   ; - Loop through all bills for an insurance company.
 I $G(IBXTRACT) G LOOP
 I IBOUT="E" S IBDS=0,INSC=$P(IBINS,"@@") G LOOP
 I $Y>(IOSL-15) S IBCALC=15 D PAUSE Q:IBQUIT  D HDR Q:IBQUIT
 I IBPRNT'="G" S IBDS=0,IBTI="0^0^0^0" D INSADD
 E  I $G(IBG) S IBTT="0^0^0^0^0^0^0^0^0^0" D INSADD
LOOP     ; add group# for p447 
 S IBGRP="" F  S IBGRP=$O(^TMP($J,"IBOTR",IBDIV,IBX,IBINS,IBGRP)) Q:IBGRP=""!(IBQUIT)  D
 . I IBOUT="E",IBGRP'="" S IBGRPD=$S(IBGRP'=0:$$GET1^DIQ(355.3,IBGRP_",",2.02),1:"None Defined")
 . ; IB*2.0*516/TAZ Print the actual group number instead of internal group number.
 . I IBOUT="R" I IBPRNT="M" W !!,"Group #: "_$S(IBGRP'=0:$$GET1^DIQ(355.3,IBGRP_",",2.02),1:"None Defined")
 . ;
 . S IBBN="" F  S IBBN=$O(^TMP($J,"IBOTR",IBDIV,IBX,IBINS,IBGRP,IBBN)) Q:IBBN=""  S IBD=^(IBBN) D DETAIL Q:IBQUIT
 I IBOUT="E" Q
 I 'IBQUIT,IBOUT="R" D
 .I IBPRNT'="G" D SUBTOT^IBOTR4 ; Write insurance co. sub-totals.
 .E  D:$G(IBG) GTOT^IBOTR4 ;      Write insurance co. grand totals.
 Q
 ;
DETAIL   ; - Write out detail lines.
 N IBPEN S IBPEN=$S($P(IBBN,"@@",2)["*":0,1:$P(IBD,U,6)-$P(IBD,U,7))
 I IBOUT="E" D EXOUT Q
 G:IBPRNT="S" SUBTOT G:IBPRNT="G" GNDTOT
 I $Y>(IOSL-7) S IBCALC=7 D PAUSE Q:IBQUIT  D HDR Q:IBQUIT  D INSADD
 ;
 ;IB*2.0*529 Reject flag re-added back to the software.
 S IBBLNO=$P($P(IBBN,"@@",2),"*") I IBBLNO["%" S IBBLNO=$P(IBBLNO,"%",2)
 S IBRJFLAG=+$$BILLREJ^IBJTU6(IBBLNO),IBRJFLAG=$S(IBRJFLAG=1:"c",1:"")
 W !,IBRJFLAG,$P(IBBN,"@@",2),?13,$P(IBBN,"@@"),?35,$$DATE($P(IBD,U,2))
 ;end IB*2.0*529
 W ?44,$$DATE($P(IBD,U,3)),?54,$$DATE($P(IBD,U,4))
 W ?64,$S($P(IBD,U,5):$$DATE($P(IBD,U,5)),1:$P(IBD,U,5))
 S X1=$S($P(IBD,U,5):$P(IBD,U,5),1:DT),X2=$P(IBD,U,4) D ^%DTC S IBDS=IBDS+X
 W ?74,$J(X,4),?79,$J($P(IBD,U,6),11,2),?91,$J($P(IBD,U,7),10,2)
 W ?102,$J($P(IBD,U,6)-$P(IBD,U,7),11,2),?114,$J(IBPEN,11,2)
 W ?126,$J($S(+$P(IBD,U,6)=0:0,1:$P(IBD,U,7)/$P(IBD,U,6)*100),6,2)
 ;
SUBTOT   ; - Update sub-totals.
 S $P(IBTI,U)=$P(IBTI,U)+1,$P(IBTI,U,2)=$P(IBTI,U,2)+$P(IBD,U,6)
 S $P(IBTI,U,3)=$P(IBTI,U,3)+$P(IBD,U,7),$P(IBTI,U,4)=$P(IBTI,U,4)+IBPEN
 ;
GNDTOT   ; - Update grand totals.
 S $P(IBTT,U)=$P(IBTT,U)+1,$P(IBTT,U,2)=$P(IBTT,U,2)+$P(IBD,U,6)
 I +$P($P(IBBN,"@@"),"(",2)<65 S $P(IBTT,U,3)=$P(IBTT,U,3)+$P(IBD,U,6),$P(IBTT,U,6)=$P(IBTT,U,6)+$P(IBD,U,7)
 E  S $P(IBTT,U,4)=$P(IBTT,U,4)+$P(IBD,U,6),$P(IBTT,U,7)=$P(IBTT,U,7)+$P(IBD,U,7)
 S $P(IBTT,U,5)=$P(IBTT,U,5)+$P(IBD,U,7),$P(IBTT,U,8)=$P(IBTT,U,8)+IBPEN
 I $G(IBCANC),$P(IBD,U,8) S $P(IBTT,U,9)=$P(IBTT,U,9)+1,$P(IBTT,U,10)=$P(IBTT,U,10)+$P(IBD,U,6)
 Q
 ;
HDR      ; - Print the report header.
 S IBPAG=IBPAG+1 W @IOF,IBRTN," PAYMENT TREND REPORT - "
 W $S(IBX="I":"INPATIENT",IBX="O":"OUTPATIENT",1:"COMBINED INPATIENT AND OUTPATIENT")," BILLING"
 W ?109,IBTDT,"   PAGE ",$J(IBPAG,3),!
 I IBDIV W "For: ",$P($G(^DG(40.8,IBDIV,0)),U)," - "
 W IBDFN,": ",$$DATE(IBBDT)," - ",$$DATE(IBEDT)
 I IBPRNT="M" W ?82,"Note: '*' after the Bill No. denotes a CLOSED bill"
 W:$D(IBAF) !,IBAFT G:IBPRNT="G" HDL
 W !!,"BILL",?13,"PATIENT",?55,"DATE",?64,"DATE BILL",?75,"#"
 W ?83,"AMOUNT",?93,"AMOUNT",?106,"AMOUNT",?117,"AMOUNT",?127,"PERC"
 W !,"NUMBER",?13,"NAME (AGE)",?35,"BILL FROM  -  TO",?54,"PRINTED"
 W ?65,"CLOSED",?74,"DAYS",?83,"BILLED",?92,"COLLECTED",?106,"UNPAID"
 W ?117,"PENDING",?127,"COLL"
HDL      W !,IBLINE
 I IBPRNT="M" W !?56,"M A I N  R E P O R T"
 I IBPRNT="G" W !?55,"G R A N D  T O T A L S",!
 I IBPRNT="S" W !?49,"S U M M A R Y  S T A T I S T I C S"
 I "OP"[IBSORT W !?30,"S O R T E D  B Y  A M O U N T  ",$S(IBSORT="O":"O W E",1:"P A I")," D - H I G H E S T  T O  L O W E S T"
 S IBQUIT=$$STOP^IBOUTL("Trend Report")
 Q
 ;
EXCHDR   ;
 W !,"PAYMENT TREND REPORT"
 W !,$S(IBX="I":"INPATIENT",IBX="O":"OUTPATIENT",1:"COMBINED INPATIENT AND OUTPATIENT")," BILLING"
 I IBDIV W !,"For: ",$P($G(^DG(40.8,IBDIV,0)),U)
 W !,IBDFN,": ",$$DATE(IBBDT)," - ",$$DATE(IBEDT)
 I IBPRNT="M" W !,"Note: '*' after the Bill No. denotes a CLOSED bill"
 I IBPRNT="M" W !,"M A I N  R E P O R T"
 I IBPRNT="G" W !,"G R A N D  T O T A L S",!
 I IBPRNT="S" W !,"S U M M A R Y  S T A T I S T I C S"
 I "OP"[IBSORT W !,"S O R T E D  B Y  A M O U N T  ",$S(IBSORT="O":"O W E",1:"P A I")," D - H I G H E S T  T O  L O W E S T"
 W:$D(IBAF) !,IBAFT G:IBPRNT="G" EXHDL
 W !,"INSURANCE NAME^GROUP #^BILL NUMBER^PATIENT NAME (AGE)^BILL FROM^DATE BILL TO^DATE PRINTED^DATE BILL CLOSED^# DAYS^AMOUNT BILLED^AMOUNT COLLECTED^AMOUNT UNPAID^AMOUNT PENDING^PERC COLL"
EXHDL    ;
 Q
 ;
EXOUT    ; Print excel format
 ;IB*2.0*529 Reject flag re-added back to the software.
 S IBBLNO=$P($P(IBBN,"@@",2),"*") I IBBLNO["%" S IBBLNO=$P(IBBLNO,"%",2)
 S IBRJFLAG=+$$BILLREJ^IBJTU6(IBBLNO),IBRJFLAG=$S(IBRJFLAG=1:"c",1:"")
 ;end IB*2.0*529
 W !,$P(INSC,"~~",1)_"/"_$P(INSC,"~~",2)_U_$G(IBGRPD)_U_IBRJFLAG_$P(IBBN,"@@",2)_U_$P(IBBN,"@@")_U_$$DATE($P(IBD,U,2))_U_$$DATE($P(IBD,U,3))_U_$$DATE($P(IBD,U,4))
 W U_$S($P(IBD,U,5):$$DATE($P(IBD,U,5)),1:$P(IBD,U,5))
 S X1=$S($P(IBD,U,5):$P(IBD,U,5),1:DT),X2=$P(IBD,U,4) D ^%DTC S IBDS=IBDS+X
 W U_$J(X,4)_U_$J($P(IBD,U,6),11,2)_U_$J($P(IBD,U,7),10,2)
 W U_$J($P(IBD,U,6)-$P(IBD,U,7),11,2)_U_$J(IBPEN,11,2)
 W U_$J($S(+$P(IBD,U,6)=0:0,1:$P(IBD,U,7)/$P(IBD,U,6)*100),6,2)
 Q
 ;
DATE(IBX) S:IBX]"" IBX=$E(IBX,4,5)_"/"_$E(IBX,6,7)_"/"_$E(IBX,2,3) Q IBX
 ;
PAUSE    I $E(IOST,1,2)'="C-" Q
 I IOSL<60 F IBI=$Y:1:(IOSL-IBCALC) W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
 ;
INSADD   ; - Display Insurance Company name and address.
 ; Input: IBINS
 N D,PH,IEN,IBINS1,IBPTIN
 ;
 ;IB*2.0*529 - display TIN with insurance company
 S IBINS1=$P(IBINS,"@@")
 S IBPTIN=$P(IBINS1,"~~",2),IBINS1=$P(IBINS1,"~~")
 W !!?16,"INSURANCE CARRIER: ",IBINS1,"/",IBPTIN
 ;end IB*2.0*529
 S IEN=$P(IBINS,"@@",2) G:'IEN INSADQ
 S D=$G(^DIC(36,IEN,.11)),PH=$P($G(^(.13)),U) G:D="" INSADQ
 W:$P(D,U)]"" !?35,$P(D,U)
 W:$P(D,U,2)]"" !?35,$P(D,U,2)
 W:$P(D,U,3)]"" !?35,$P(D,U,3)
 W:$P(D,U)]""!($P(D,U,2)]"")!($P(D,U,3)]"") !?35
 W $P(D,U,4) W:$P(D,U,4)]""&($P(D,U,5)]"") ", "
 W $P($G(^DIC(5,+$P(D,U,5),0)),U)
 W:$P(D,U,6)]""&($P(D,U,4)]""!($P(D,U,5)]"")) "   "
 W $P(D,U,6) W:PH]"" $J("",8),"Phone: ",PH
INSADQ   W ! Q
