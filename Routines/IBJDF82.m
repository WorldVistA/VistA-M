IBJDF82 ;ALB/RRG - AR PRODUCTIVITY REPORT (PRINT) ;29-AUG-00
 ;;2.0;INTEGRATED BILLING;**123,159**;21-MAR-94
 ;
EN ; - Print the AR Productivity Report
 ; 
 S IBQ=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 ;
 I '$D(^TMP("IBJDF8SUM",$J)) D  G ENQ
 . D @($S(IBRPT="D":"HDRD",1:"HDRS"))
 . W !!,"There is no AR Productivity information for the parameters selected."
 . D PAUSE
 ;
 ; - Summary report was selected
 I IBRPT="S" G SUM
 ;
 S IBPAG=0 D HDRD G:IBQ ENQ
 ;
 S (IBCLNAM,IBBLNUM,IBTRXNUM)="",CLIDENT=0
 F  S IBCLNAM=$O(^TMP("IBJDF8",$J,IBCLNAM)) Q:IBCLNAM=""  D  Q:IBQ
 . I IBPNI="I" S CLIDENT=CLIDENT+1
 . I $Y>(IOSL-6) D PAUSE Q:IBQ  D HDRD Q:IBQ
 . D WCLK
 . F  S IBBLNUM=$O(^TMP("IBJDF8",$J,IBCLNAM,IBBLNUM)) Q:IBBLNUM=""  D  Q:IBQ
 . . F  S IBTRXNUM=$O(^TMP("IBJDF8",$J,IBCLNAM,IBBLNUM,IBTRXNUM)) Q:IBTRXNUM=""  D  Q:IBQ
 . . . S IBTRXDAT=$G(^TMP("IBJDF8",$J,IBCLNAM,IBBLNUM,IBTRXNUM)),IBFLG=1
 . . . ; 
 . . . ; - Page Break
 . . . I $Y>(IOSL-6) D PAUSE Q:IBQ  D HDRD,WCLK Q:IBQ
 . . . ;
 . . . ; - Bill, Trx Date, Debtor, Trx Type, Trx Amount
 . . . W !,$P(IBTRXDAT,"^",1),?13,$$DAT1^IBOUTL($P(IBTRXDAT,"^",2))
 . . . W ?23,$E($P(IBTRXDAT,"^",3),1,28)
 . . . W ?53,$E($P(IBTRXDAT,"^",4),1,20)
 . . . W ?75,$J($FN($P(IBTRXDAT,"^",5),",",2),11)
 . . . ;
 . . . ; - Current Balance, Follow-up date, Trx Number
 . . . W ?90,$J($FN($P(IBTRXDAT,"^",6),",",2),11)
 . . . W ?104,$$DAT1^IBOUTL($P(IBTRXDAT,"^",7))
 . . . W ?115,$S(IBTRXNUM:IBTRXNUM,1:"N/A")
 . . . ;
 . . . ; - Most recent brief comment
 . . . I $P(IBTRXDAT,"^",8)'="" D
 . .  . . W !,?13,"COMMENT: ",?22,$E($P(IBTRXDAT,"^",8),1,90)
 . W !
 ;
 G ENQ:IBQ D PAUSE G ENQ:IBQ
 ;
SUM ; - Print Summary Report
 ;
 D HDRS G ENQ:IBQ
 ;
 S (IBCNT1,IBTOT1,CLIDENT)=0
 I IBSPT=1 D
 . S CLNAM="" F  S CLNAM=$O(^TMP("IBJDF8SUM",$J,CLNAM)) Q:CLNAM=""  D  Q:IBQ
 . . I IBPNI="I" S CLIDENT=CLIDENT+1
 . . I $Y>(IOSL-7) D PAUSE Q:IBQ  D HDRS Q:IBQ
 . . W !,$S(IBPNI="I":"CLERK # "_CLIDENT,1:CLNAM)
 . . S (IBCNT,IBTOT)=0,TRXCAT=""
 . . F  S TRXCAT=$O(^TMP("IBJDF8SUM",$J,CLNAM,TRXCAT)) Q:TRXCAT=""  D  Q:IBQ
 . . . I $Y>(IOSL-6) D PAUSE Q:IBQ  D HDRS Q:IBQ  W !,$S(IBPNI="I":"CLERK # "_CLIDENT,1:CLNAM)
 . . . S SUMDAT=^TMP("IBJDF8SUM",$J,CLNAM,TRXCAT)
 . . . W ?25,$P(SUMDAT,"^",3),?50,$J($P(SUMDAT,"^",1),12)
 . . . W ?65,$J($FN($P(SUMDAT,"^",2),",",2),15),!
 . . . S IBQ=$$STOP^IBOUTL("AR Productivity Report")
 . . . S IBCNT=IBCNT+SUMDAT,IBTOT=IBTOT+$P(SUMDAT,"^",2)
 . . ;
 . . D WTOT
 . I IBCNT1>1 D WTOT1
 ;
 G ENQ:IBQ
 ;
 I IBSPT=0 D
 . S (IBCNT,IBTOT)=0,TRXCAT=""
 . F  S TRXCAT=$O(IB(TRXCAT)) Q:TRXCAT=""  D
 . . S SUMDAT=IB(TRXCAT) I $P(SUMDAT,"^",1)=0 Q
 . . W !,?25,$P(SUMDAT,"^",3),?50,$J($P(SUMDAT,"^",1),12)
 . . W ?65,$J($FN($P(SUMDAT,"^",2),",",2),15)
 . . S IBCNT=IBCNT+SUMDAT,IBTOT=IBTOT+$P(SUMDAT,"^",2)
 . W ! D WTOT
 ;
 D PAUSE
 ;
ENQ K IBCNT,IBCNT1,IBFLG,IBDFN,IBILL,IBKEY,IBPAT,IBPAG,IBQ,IBRUN,IBRP
 K IBTOT,IBTOT1,%,SUMDAT,CLIDENT,TRXCAT,IBCLNAM,IBTRXNUM,IBTRXDAT
 K CLNAM,IBBLNUM
 Q
 ;
WCLK ; - Print Clerk Name or Identifier
 W !,$S(IBPNI="I":"CLERK # "_CLIDENT,1:IBCLNAM)
 Q
 ;
WTOT ; Write the Totals by Clerk
 ;
 S IBCNT1=IBCNT1+IBCNT,IBTOT1=IBTOT1+IBTOT
 I IBCNT'>1 S (IBCNT,IBTOT)=0 Q
 W ?53,"---------",?67,"-------------"
 W !?50,$J(IBCNT,12),?65,$J($FN(IBTOT,",",2),15),!
 S (IBCNT,IBTOT)=0
 Q
 ;
WTOT1 ; Write the Grand Totals
 ;
 W !?53,"---------",?67,"-------------"
 W !?25,"GRAND TOTALS",?50,$J(IBCNT1,12),?65,$J($FN(IBTOT1,",",2),15),!
 Q
 ;
HDRD ; - Prints the Detailed Report Header
 ; 
 W @IOF,*13 S IBPAG=$G(IBPAG)+1
 W !,"AR Productivity Report",?60,"Run  Date: ",IBRUN
 W ?123,"Page: ",$J(IBPAG,3)
 W !,"From: ",?7,IBF,?20,"to",?23,IBT
 W ?60,"Detail By ",?70,$S(IBPNI="N":"Clerk Name",1:"Clerk Identifier")
 ;
 W !!,?13,"Trx.",?53,"Transaction",?75,"Transaction",?90,"Current"
 W ?104,"Follow-Up",?115,"Transaction"
 W !,"Bill Number",?13,"Date",?23,"Debtor",?53,"Type",?75,"Amount"
 W ?90,"Balance",?104,"Date",?115,"Number"
 W !,$$DASH(132,0) S IBQ=$$STOP^IBOUTL("AR Productivity Report")
 Q
 ;
HDRS ; - Prints the Summary Report Header
 ; 
 N X
 W @IOF,$C(13) W !?26,"SUMMARY AR PRODUCTIVITY REPORT"
 S X=" From "_IBF_" to "_IBT
 W !?(80-$L(X)/2+1),X,!!?(80-$L(IBRUN)/2+1),IBRUN
 S X="",$P(X,"=",$L(IBRUN))="" W !?(80-$L(IBRUN)/2+1),X
 W !!,$S(IBSPT=1:"Clerk",1:""),?25,"Transaction Category"
 W ?50,"Total Number",?64,"Total Dollar Amt"
 W !,$$DASH(80,0) S IBQ=$$STOP^IBOUTL("AR Productivity Report")
 Q
 ;
DASH(X,Y) ; - Return a dashed line.
 ; Input: X=Number of Columns (80 or 132), Y=Char to be printed
 ; 
 Q $TR($J("",X)," ",$S(Y:"-",1:"="))
 ;
PAUSE ; - Page break.
 ; 
 I $E(IOST,1,2)'="C-" Q
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR S:$D(DIRUT)!($D(DUOUT)) IBQ=1
 Q
 ;
DT(X) ; - Return date.
 ;    Input: X=Date in Fileman format
 ;   Output: Z=Date in MMDDYY format
 ;
 Q $E(X,4,7)_$E(X,2,3)
