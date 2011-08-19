IBJDF52 ;ALB/RB - CHAMPVA/TRICARE FOLLOW-UP REPORT (PRINT) ;15-APR-00
 ;;2.0;INTEGRATED BILLING;**123,159,240**;21-MAR-94
 ;
EN ; - Print the Follow-up report.
 S (IBQ,IBFLG)=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%) G:IBRPT="S" SUM
 I 'IBSD D DET(0) G SUM
 I IBSEL["1" D DET(0)
 S IBDIV=""
 F  S IBDIV=$O(VAUTD(IBDIV)) Q:IBDIV=""  D DET(IBDIV) Q:IBQ
 ;
SUM I 'IBQ D PRT^IBJDF53 ; Print summary.
ENQ K I,IB0,IBC,IBCAT,IBCD,IBC1,IBC2,IBDIV,IBFLG,IBIN,IBKEY,IBN,IBPT,IBPAG
 K IBQ,IBRUN,IBTYP,%
 Q
 ;
DET(IBDIV) ; - Print report for a specific division.
 ; Input: IBDIV=Pointer to the division in file #40.8 & variable IBSEL1
 S IBCAT=0
 F  S IBCAT=$O(IBCAT(IBCAT)) Q:'IBCAT  D  Q:IBQ
 . S (IB0,IBIN,IBKEY,IBTYP)=""
 . F IBTYP=1:1:4 D:IBSEL1[IBTYP  Q:IBQ
 . . I IBDIV,IBCAT=31 Q
 . . I IBSD,'IBDIV,IBCAT'=31 Q
 . . I '$D(^TMP("IBJDF5",$J,IBDIV,IBCAT,IBTYP)) D HDR1,NAR,PAUSE Q
 . . S IBFLG=0
 . . F  S IBIN=$O(^TMP("IBJDF5",$J,IBDIV,IBCAT,IBTYP,IBIN)) Q:IBIN=""  D  Q:IBQ
 . . . D HDR1,HDR2 Q:IBQ
 . . . F  S IBKEY=$O(^TMP("IBJDF5",$J,IBDIV,IBCAT,IBTYP,IBIN,IBKEY)) Q:IBKEY=""  D  Q:IBQ
 . . . . S IBPT=$G(^TMP("IBJDF5",$J,IBDIV,IBCAT,IBTYP,IBIN,IBKEY))
 . . . . D WPAT
 . . . . F  S IB0=$O(^TMP("IBJDF5",$J,IBDIV,IBCAT,IBTYP,IBIN,IBKEY,IB0)) Q:IB0=""  D  Q:IBQ
 . . . . . S IBN=$G(^TMP("IBJDF5",$J,IBDIV,IBCAT,IBTYP,IBIN,IBKEY,IB0))
 . . . . . I $Y>(IOSL-3) D PAUSE Q:IBQ  D HDR1,HDR2 Q:IBQ  D WPAT
 . . . . . W ?59,IB0,?71,$$DAT1^IBOUTL(+IBN)
 . . . . . W ?80,$$DAT1^IBOUTL($P(IBN,U,2))
 . . . . . W ?89,$$DAT1^IBOUTL($P(IBN,U,3)),?98,$J($P(IBN,U,4),8,2)
 . . . . . W ?107,$J($P(IBN,U,5),8,2),?116,$P(IBN,U,6),!
 . . . . . ;
 . . . . . ; - Display bill comment history, if necessary.
 . . . . . I IBSH D WCOM
 . . . D:'IBQ PAUSE
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
 N FLG,X
 ;
 S FLG=1 I $G(IBFLG) S FLG=0
 I '$G(IBFLG),$E(IOST,1,2)="C-"!$G(IBPAG) D
 . W @IOF,*13 S IBFLG=0
 . S IBPAG=$G(IBPAG)+1
 I $G(IBFLG) D
 . I $Y'>(IOSL-11) W !!! Q
 . W @IOF,*13 S IBPAG=$G(IBPAG)+1,FLG=1
 I '$G(IBPAG) S IBPAG=1
 I IBDIV!FLG D
 . W "CHAMPVA/TRICARE Follow-Up Report"
 . I IBDIV W " for ",$P($G(^DG(40.8,IBDIV,0)),U),"  "
 . W ?75,"Run Date: ",IBRUN W:FLG ?123,"Page: ",$J(IBPAG,3)
 S X="ALL ACTIVE "_$G(IBCTG(IBCAT(IBCAT)))_" RECEIVABLES "
 I IBTYP'=4 S X=X_"("_$G(IBTPR(IBTYP))_") "
 I IBSMN S X=X_"OVER "_IBSMN_" AND UNDER "_IBSMX_" DAYS OLD "
 S X=X_" / BY PATIENT "_$S(IBSN="N":"NAME",1:"LAST 4 DIGITS OF SSN")
 S X=X_" ("_$S($G(IBSNA)="ALL":"ALL",1:"From "_$S(IBSNF="":"FIRST",1:IBSNF)_" to "_$S(IBSNL="zzzzz":"LAST",1:IBSNL))_")"
 S X=X_" / "_$S('IBSAM:"NO ",1:"")_"MINIMUM BALANCE"
 I IBSAM S X=X_$S(IBSAM:": $"_$FN(IBSAM,",",2),1:"")
 S X=X_" / "_$S('IBSH:"NO ",IBSH1="A":"ALL ",1:"ONLY ")_"COMMENTS"
 S X=X_$S($G(IBSH2):" NOT OLDER THAN "_IBSH2_" DAYS",1:"")
 S X=X_" / '*' AFTER THE PATIENT NAME = VA EMPLOYEE"
 F I=1:1 W !,$E(X,1,132) S X=$E(X,133,999) I X="" Q
 ;
 W !!?71,"Dte Bill",?98,"Original  Current"
 W !,"Patient",?26,"Age SSN" W:IBCAT'=31 ?43,"Other Insurance"
 W ?59,"Bill Number Prepared",?80,"Bill Frm Bill To    Amount  Balance"
 W:IBCAT'=31 ?116,"Subscriber ID"
 W !,$$DASH(IOM),!
 S IBQ=$$STOP^IBOUTL("CHAMPVA/TRICARE Follow-Up Report")
 Q
 ;
HDR2 ; - Write the insurance company sub-header.
 N X,X13
 I $P(IBIN,"@@")'=0 W ?2,"Carrier: ",$P(IBIN,"@@")
 S X=$G(^DIC(36,+$P(IBIN,"@@",2),.11)),X13=$G(^(.13))
 I X]"" D
 .W ", ",$P(X,U),", ",$P(X,U,4),", ",$P($G(^DIC(5,+$P(X,U,5),0)),U,2),"  ",$P(X,U,6)
 .I $P(X13,U,2)]"" W "   Billing Phone: ",$P(X13,U,2) Q
 .I $P(X13,U)]"" W "   Main Phone: ",$P(X13,U)
 ;
 Q
 ;
NAR ; - Write detail line (if '$D).
 S IBFLG=1
 W !!,"There are no active receivables for the parameters above."
 Q
 ;
WPAT ; - Write patient data.
 W !,$P(IBPT,U),?26,$J($P(IBPT,U,2),3),?30,$P(IBPT,U,3)
 W ?43,$P(IBPT,U,4)
 Q
 ;
WCOM ; - Write bill comments
 N CONT,DIWL,DIWR,IBC,IBCD,IBC1,IBC2,X
 ;
 S (IBC,CONT,IBCD)=0,IBC1="",DIWL=1,DIWR=104 K ^UTILITY($J)
 F  S IBC=$O(^TMP("IBJDF5",$J,IBDIV,IBCAT,IBTYP,IBIN,IBKEY,IB0,IBC)) Q:'IBC  D  Q:IBQ
 . F  S IBC1=$O(^TMP("IBJDF5",$J,IBDIV,IBCAT,IBTYP,IBIN,IBKEY,IB0,IBC,IBC1)) Q:IBC1=""  D  Q:IBQ
 . . S IBC2=^TMP("IBJDF5",$J,IBDIV,IBCAT,IBTYP,IBIN,IBKEY,IB0,IBC,IBC1)
 . . I 'IBC1 S IBCD=IBC2 D WCD Q
 . . I $Y>(IOSL-4) D WCPB Q:IBQ
 . . S X=IBC2 I $E(X)=" ",$L(X)>1 S $E(X)=""
 . . D ^DIWP
 . . I 'CONT,$L(IBC2)<66 D WCTXT Q
 . . S CONT=$L(IBC2)>65
 . . I '$O(^TMP("IBJDF5",$J,IBDIV,IBCAT,IBTYP,IBIN,IBKEY,IB0,IBC,IBC1)) D
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
 ;
 D PAUSE Q:IBQ  D HDR1,HDR2 Q:IBQ
 W ! D WPAT D WCD W:IBC1>1 ?26,"(continued)",!
 Q 
 ;
WCD ; - Write comment date.
 W !?2,"Comment Date: ",$$DAT1^IBOUTL(IBCD)
 Q
 ;
SSN(X) ; - Format the SSN.
 Q $S(X:$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10),1:"")
