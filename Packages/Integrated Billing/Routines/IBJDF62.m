IBJDF62 ;ALB/RB - MISC. BILLS FOLLOW-UP REPORT (PRINT) ;15-APR-00
 ;;2.0;INTEGRATED BILLING;**123,159**;21-MAR-94
 ;
EN ; - Print the Follow-up report.
 S IBQ=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%) G:IBRPT="S" SUM
 I 'IBSDV D DET(0) G SUM
 S IBDIV=""
 F  S IBDIV=$O(VAUTD(IBDIV)) Q:IBDIV=""  D  Q:IBQ
 . D DET(IBDIV)
 ;
SUM I 'IBQ D PRT^IBJDF63 ; Print summary.
ENQ K IBN,IBIN,IBC,IBCD,IBC1,IBC2,IBCAT1,IBD,IBDIV,IBGBL,IBPAG,IBP,IBPD,IBPTD,IBQ,IBRUN,%
 Q
 ;
DET(IBDIV) ; - Print report for a specific division.
 ; Input: IBDIV=Pointer to the division in file #40.8
 S IBCAT=0
 F  S IBCAT=$O(IBCAT(IBCAT)) Q:'IBCAT  D  Q:IBQ
 . S IBCAT1=IBCAT(IBCAT),IBGBL=$S(IBCAT1<5:"IBJDF6P",1:"IBJDF6D")
 . I IBDIV,IBCAT1'<5 Q
 . I IBSDV,'IBDIV,IBCAT1<5 Q
 . I '$D(^TMP(IBGBL,$J,IBDIV,IBCAT)) D HDR1 Q:IBQ  D NAR,PAUSE Q
 . D HDR1 Q:IBQ
 . S IBIN="" F  S IBIN=$O(^TMP(IBGBL,$J,IBDIV,IBCAT,IBIN)) Q:IBIN=""  D  Q:IBQ
 . . I $Y>(IOSL-5) D PAUSE Q:IBQ  D HDR1 Q:IBQ
 . . D HDR2
 . . S (IBPTD,IB0,IBD)=""
 . . F  S IBPTD=$O(^TMP(IBGBL,$J,IBDIV,IBCAT,IBIN,IBPTD)) Q:IBPTD=""  D  Q:IBQ
 . . . I $Y>(IOSL-5) D PAUSE Q:IBQ  D HDR1,HDR2 Q:IBQ
 . . . S IBPD=$G(^TMP(IBGBL,$J,IBDIV,IBCAT,IBIN,IBPTD))
 . . . D WPAT
 . . . F  S IB0=$O(^TMP(IBGBL,$J,IBDIV,IBCAT,IBIN,IBPTD,IB0)) Q:IB0=""  D  Q:IBQ
 . . . . S IBN=$G(^TMP(IBGBL,$J,IBDIV,IBCAT,IBIN,IBPTD,IB0))
 . . . . I $Y>(IOSL-3) D PAUSE Q:IBQ  D HDR1,HDR2 Q:IBQ  D WPAT
 . . . . I IBCAT1<5 D
 . . . . . W ?71,IB0,?84,$$DAT1^IBOUTL(+IBN),?94,$$DAT1^IBOUTL($P(IBN,U,2))
 . . . . . W ?104,$$DAT1^IBOUTL($P(IBN,U,3)),?114,$J($P(IBN,U,4),8,2)
 . . . . . W ?124,$J($P(IBN,U,5),8,2),!
 . . . . E   D
 . . . . . W ?33,IB0,?47,$$DAT1^IBOUTL(+IBN),?59,$P($P(IBN,U,2),"@@")
 . . . . . W ?92,$J($P(IBN,U,3),8,2),?103,$J($P(IBN,U,4),8,2)
 . . . . . W ?114,$J($P(IBN,U,5),8,2),!
 . . . . ; 
 . . . . ; - Display bill comment history, if necessary.
 . . . . I IBSH D COM
 . ;
 . I 'IBQ D PAUSE
 ;
DETQ Q
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
HDR1 ; - Write the primary report header.
 I $E(IOST,1,2)="C-"!$G(IBPAG) W @IOF,*13
 S IBPAG=$G(IBPAG)+1 W "Miscellaneous Bills Follow-Up Report"
 I IBDIV W " for ",$P($G(^DG(40.8,IBDIV,0)),U)
 W ?60,"   Run Date: ",IBRUN,?123,"Page: ",$J(IBPAG,3)
 ;
 S X="ALL ACTIVE "_$G(IBCTG(IBCAT(IBCAT)))_" RECEIVABLES "
 I IBSMN S X=X_"OVER "_IBSMN_" AND LESS THAN "_IBSMX_" DAYS OLD "
 I IBCAT(IBCAT)<5 D
 . S X=X_" / BY PATIENT "_$S(IBSN="N":"NAME",1:"LAST 4 DIGITS OF SSN")
 . S X=X_" ("_$S($G(IBSNA)="ALL":"ALL",1:"From "_$S(IBSNF="":"FIRST",1:IBSNF)_" to "_$S(IBSNL="zzzzz":"LAST",1:IBSNL))_") / "
 I IBCAT(IBCAT)>4 D
 . S X=X_" / BY DEBTOR NAME"
 . S X=X_" ("_$S($G(IBSDA)="ALL":"ALL",1:"From "_$S(IBSDF="":"FIRST",1:IBSDF)_" to "_$S(IBSDL="zzzzz":"LAST",1:IBSDL))_") / "
 S X=X_$S('IBSAM:"NO ",1:"")_" MINIMUM BALANCE"
 I IBSAM S X=X_$S(IBSAM:": $"_$FN(IBSAM,",",2),1:"")
 S X=X_" / "_$S('IBSH:"NO ",IBSH1="A":"ALL ",1:"ONLY ")_"COMMENTS"
 S X=X_$S($G(IBSH2):" NOT OLDER THAN "_IBSH2_" DAYS",1:"")
 S X=X_" / '*' AFTER THE PATIENT/DEBTOR NAME = VA EMPLOYEE"
 F I=1:1 W !,$E(X,1,132) S X=$E(X,133,999) I X="" Q
 ;
 I IBCAT1<5 D  G HDQ
 .W !!?84,"Date",?94,"Bill",?104,"Bill",?114,"Original   Current"
 .W !,"Patient (Age)",?33,"SSN",?47,"Other Insurance",?71,"Bill Number"
 .W ?84,"Prepared  From Dte  To Date",?116,"Amount   Balance"
 ;
 W !!?47,"Date Bill",?92,"Original   Last Amt    Current"
 W !,"Debtor",?33,"Bill Number   Prepared    Processed By",?94,"Amount"
 W ?107,"Paid    Balance" S:$G(IBD) IBD=""
HDQ W !,$$DASH(IOM),!
 S IBQ=$$STOP^IBOUTL("Miscellaneous Bills Follow-Up Report")
 Q
 ;
HDR2 ; - Write the insurance company sub-header.
 N X,X13 Q:IBCAT1>4
 W ?2,"Carrier: ",$P(IBIN,"@@")
 S X=$G(^DIC(36,+$P(IBIN,"@@",2),.11)),X13=$G(^(.13))
 I X]"" D
 .W ", ",$P(X,U),", ",$P(X,U,4),", ",$P($G(^DIC(5,+$P(X,U,5),0)),U,2),"  ",$P(X,U,6)
 .I $P(X13,U,2)]"" W "   Billing Phone: ",$P(X13,U,2) Q
 .I $P(X13,U)]"" W "   Main Phone: ",$P(X13,U)
 ;
 W !
 Q
 ;
NAR ; - Write detail line (if '$D).
 N I
 W !!,"There are no active receivables "
 I IBSMN W IBSMN,$S(IBSMX>IBSMN:" to "_IBSMX,1:"")," days old "
 I IBDIV W "for this division."
 I IBSDV,IBDIV,IBCAT1<5 Q
 I IBSDV,'IBDIV,IBCAT1'<5 Q
 F I=1:1:8 S IB(+IBDIV,IBCAT,I)=""
 Q
 ;
WPAT ; - Write patient data.
 I IBCAT1<5 D  Q
 . W $P(IBPD,U)," (",$P(IBPD,U,2),")",?33,$P(IBPD,U,3),?47,$P(IBPD,U,4)
 W $P(IBPD,U)
 Q
 ;
COM ; - Write comments
 N CONT,DIWL,DIWR,IBC,IBC1,IBC2,X
 ;
 S (IBC,CONT)=0,IBC1="",DIWL=1,DIWR=104 K ^UTILITY($J,"W")
 F  S IBC=$O(^TMP(IBGBL,$J,IBDIV,IBCAT,IBIN,IBPTD,IB0,IBC)) Q:'IBC  D  Q:IBQ
 . I $Y>(IOSL-4) D PAUSE Q:IBQ  D HDR1,HDR2 Q:IBQ  D WPAT W !
 . F  S IBC1=$O(^TMP(IBGBL,$J,IBDIV,IBCAT,IBIN,IBPTD,IB0,IBC,IBC1)) Q:IBC1=""  D  Q:IBQ
 . . S IBC2=^TMP(IBGBL,$J,IBDIV,IBCAT,IBIN,IBPTD,IB0,IBC,IBC1)
 . . I $Y>(IOSL-4) D WCPB Q:IBQ
 . . I 'IBC1 S IBCD=IBC2 D WCD Q
 . . S X=IBC2 I $E(X)=" ",$L(X)>1 S $E(X)=""
 . . D ^DIWP
 . . I 'CONT,$L(IBC2)<66 D WCTXT Q
 . . S CONT=$L(IBC2)>65
 . . I '$O(^TMP(IBGBL,$J,IBDIV,IBCAT,IBIN,IBPTD,IB0,IBC,IBC1)) D
 . . . D:$D(^UTILITY($J,"W")) WCTXT
 K ^UTILITY($J,"W")
 Q
 ;
WCTXT ; - Write comment text
 N LIN,WLIN
 S LIN=""
 F  S LIN=$O(^UTILITY($J,"W",1,LIN)) Q:LIN=""  D  Q:IBQ
 . S WLIN=$G(^UTILITY($J,"W",1,LIN,0))
 . I $Y>(IOSL-4) D WCPB Q:IBQ
 . W:WLIN'="" ?26,WLIN,!
 K ^UTILITY($J,"W")
 Q
 ;
WCPB ; - Page Break in the middle of Comments
 D PAUSE Q:IBQ  D HDR1,HDR2 Q:IBQ
 W ! D WPAT W ! D WCD W:IBC1>1 ?26,"(continued)",!
 Q 
 ;
WCD ; - Write comment date.
 W ?2,"Comment Date: ",$$DAT1^IBOUTL(IBCD)
 Q
