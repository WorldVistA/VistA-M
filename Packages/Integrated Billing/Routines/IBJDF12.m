IBJDF12 ;ALB/CPM - THIRD PARTY FOLLOW-UP REPORT (PRINT) ;10-JAN-97
 ;;2.0;INTEGRATED BILLING;**69,118,128,123,204,205,554,618,663**;21-MAR-94;Build 27
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; - Print the Follow-up report.
 S IBQ=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 I 'IBSD D DET(0),PAUSE:'IBQ G ENQ
 S IBDIV=0 F  S IBDIV=$O(VAUTD(IBDIV)) Q:'IBDIV  D DET(IBDIV),PAUSE:'IBQ Q:IBQ
 ;
ENQ K IBPAG,IBRUN,IBDIV,IBWIN,IBWPT,IBWDP,IBQ,IBH,IBZ,IBC,IBC1,IBC2,IBCD,%
 Q
 ;
DET(IBDIV) ; - Print report for a specific division.
 ;  Input: IBDIV=Pointer to the division in file #40.8
 S IBPAG=0
 I '$D(^TMP("IBJDF1",$J,IBDIV)) D  G DETQ
 .S IBSEL=5 D HDR1 I IBQ Q
 .W !!,"There are no active receivables "
 .I IBSMN W IBSMN,$S(IBSMX>IBSMN:" to "_IBSMX,1:"")," days old "
 .I IBDIV W "for this division."
 ;
 S IBTYP=0 F  S IBTYP=$O(^TMP("IBJDF1",$J,IBDIV,IBTYP)) Q:'IBTYP  D  Q:IBQ
 .D HDR1 I IBQ Q
 .S IBWIN="" F  S IBWIN=$O(^TMP("IBJDF1",$J,IBDIV,IBTYP,IBWIN)) Q:IBWIN=""  D  Q:IBQ
 ..I $Y>(IOSL-5) D PAUSE Q:IBQ  D HDR1 Q:IBQ
 ..D HDR2
 ..S IBWPT="" F  S IBWPT=$O(^TMP("IBJDF1",$J,IBDIV,IBTYP,IBWIN,IBWPT)) Q:IBWPT=""  D  Q:IBQ
 ...S (IBH,IBWDP)="" F  S IBWDP=$O(^TMP("IBJDF1",$J,IBDIV,IBTYP,IBWIN,IBWPT,IBWDP)) W:IBWDP="" ! Q:IBWDP=""  S IBZ=$G(^(IBWDP)) D  Q:IBQ
 ....I $Y>(IOSL-3) D PAUSE Q:IBQ  D HDR1,HDR2 Q:IBQ  S IBH=0
 ....W ! I 'IBH D WPAT S IBH=1
 ....D WBIL Q:IBQ
 ....;
 ....; - Display bill comment history, if necessary.
 ....I IBSH D WCOM Q:IBQ
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
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
HDR1 ; - Write the primary report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W "Third Party Follow-Up Report"_$S(IBSDATE="D":" ( date of care )",1:" ( days in AR )")
 I IBDIV W " for ",$P($G(^DG(40.8,IBDIV,0)),U)
 W ?88,"Run Date: ",IBRUN,?123,"Page: ",$J(IBPAG,3)
 ; IB*2*554/DRF - Add NON-VA to header/IB*2.0*618 Changed to Community Care
 W !,"All active ",$S(IBSEL[1:"INPATIENT ",IBTYP[2:"OUTPATIENT ",IBSEL[3:"RX REFILL ",IBSEL[4:"COMMUNITY CARE ",1:""),"receivables "
 I IBSMN W IBSMN,$S(IBSMX>IBSMN:" to "_IBSMX,1:"")," days old "
 I IBSAM W "with balances of at least $",IBSAM
 W !!?37,"Other",?51,"Date",?92,"Original",?103,"Current"
 W !,"Patient (Age)",?24,"SSN",?37,"Carrier",?51,"Prepared",?61,"Bill No.",?73,"Bill Fr. Bill To",?94,"Amount",?103,"Balance",?114,"Subscriber ID"
 W !,$$DASH(IOM)
 I IBSRC W !,"Note: '(n)' or '(*)' next to balance means AR was referred to Regional Counsel"
 W ! S IBQ=$$STOP^IBOUTL("Third Party Follow-Up Report")
 Q
 ;
HDR2 ; - Write the insurance company sub-header.
 N X,X13 W !?3,"Carrier: ",$P(IBWIN,"@@")
 S X=$G(^DIC(36,+$P(IBWIN,"@@",2),.11)),X13=$G(^(.13))
 I X]"" D
 .W ", ",$P(X,U),", ",$P(X,U,4),", ",$P($G(^DIC(5,+$P(X,U,5),0)),U,2),"  ",$P(X,U,6)
 .I $P(X13,U,2)]"" W "   Billing Phone: ",$P(X13,U,2) Q
 .I $P(X13,U)]"" W "   Main Phone: ",$P(X13,U)
 Q
 ;
WPAT ; - Write patient data.
 W $P(IBZ,U),?24,$$SSN($P(IBZ,U,2)),?37,$P(IBZ,U,3)
 Q
 ;
WBIL ; - Write bill data.
 W ?51,$$DAT1^IBOUTL(+IBWDP),?60,$P(IBWDP,"@@",2)
 W ?73,$$DAT1^IBOUTL($P(IBZ,U,4)),?82,$$DAT1^IBOUTL($P(IBZ,U,5))
 W ?90,$J($P(IBZ,U,6),10,2),?100,$J(+$P(IBZ,U,7),10,2)
 I $P($P(IBZ,U,7),"~",2) D
 . I $P($P(IBZ,U,7),"~",2)<6 W "(",$P($P(IBZ,U,7),"~",2),")" Q
 . W "(*)"
 W ?114,$E($P(IBZ,U,8),1,18)
 Q
 ;
WCOM ; - Write the comments
 N CONT,DIWL,DIWR,IBC,IBC1,IBC2,X
 ;
 S (IBC,CONT)=0,DIWL=1,DIWR=104 K ^UTILITY($J,"W")
 F  S IBC=$O(^TMP("IBJDF1",$J,IBDIV,IBTYP,IBWIN,IBWPT,IBWDP,IBC)) Q:'IBC  D  Q:IBQ
 . I $Y>(IOSL-4) D PAUSE Q:IBQ  D HDR1,HDR2 Q:IBQ  W ! D WPAT,WBIL
 . S IBC1=""
 . F  S IBC1=$O(^TMP("IBJDF1",$J,IBDIV,IBTYP,IBWIN,IBWPT,IBWDP,IBC,IBC1)) Q:IBC1=""  D  Q:IBQ
 . . S IBC2=^TMP("IBJDF1",$J,IBDIV,IBTYP,IBWIN,IBWPT,IBWDP,IBC,IBC1)
 . . I $Y>(IOSL-4) D WCPB Q:IBQ
 . . I 'IBC1 S IBCD=IBC2 D WCD Q
 . . S X=IBC2 I $E(X)=" ",$L(X)>1 S $E(X)=""
 . . D ^DIWP
 . . I 'CONT,$L(IBC2)<66 D WCTXT Q
 . . S CONT=$L(IBC2)>65
 . . I '$O(^TMP("IBJDF1",$J,IBDIV,IBTYP,IBWIN,IBWPT,IBWDP,IBC,IBC1)) D
 . . . D:$D(^UTILITY($J,"W")) WCTXT
 K ^UTILITY($J,"W")
 Q
 ;
WCD ; - Write comment date.
 W !?2,"Comment Date: ",$$DAT1^IBOUTL(IBCD)
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
 W ! D WPAT,WBIL D WCD W:IBC1>1 ?26,"(continued)",!
 Q 
 ;
SSN(X) ; - Format the SSN.
 Q $S(X]"":$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10),1:"")
