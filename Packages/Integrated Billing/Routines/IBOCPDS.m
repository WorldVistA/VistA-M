IBOCPDS ;ALB/ARH - CLERK PRODUCTIVITY REPORT (SUMMARY) ;10/8/91
 ;;2.0;INTEGRATED BILLING;**44,118,155,342**;21-MAR-94;Build 18
 ;
EN ; - Get parameters then run the report.
 D ORDER^IBOCPD I IBQUIT G EXIT
 D HOME^%ZIS
 S IBHDR="CLERK PRODUCTIVITY SUMMARY REPORT" W @IOF,?22,IBHDR,!!
 S IBFLD="Date "_$S(IBORDER="E":"Entered",IBORDER="A":"Authorized",1:"First Printed")
 D RANGE^IBOCPD I IBQUIT G EXIT
 ;
 ; - Print without clerks' names?
 S DIR(0)="Y",DIR("B")="NO",DIR("?")="^D HLP^IBOCPDS" W !
 S DIR("A")="Do you want to print the summary without the clerks' names"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G EXIT
 S IBNCLK=+Y K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
DEV ; - Get the device.
 W !!,"Report requires 132 columns."
 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="ENT^IBOCPDS",ZTDESC="Clerk Productivity Summary Report",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q") G EXIT
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOCPDS" D T1^%ZOSV ;stop rt clock
 ;
ENT ; - Find, save, and print the data that satisfies the search parameters
 ;   entry for tasked jobs.
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOCPDS-2" D T0^%ZOSV ;start rt clock
 K ^TMP("IB",$J),IBMRAUSR
 S IBCDT=IBBEG-.001,IBE=IBEND+.3,U="^",IBQUIT=0
 S IBINDX=$S(IBORDER="E":"APD",IBORDER="A":"APD3",1:"AP")
 F  S IBCDT=$O(^DGCR(399,IBINDX,IBCDT)) Q:IBCDT=""!(IBCDT>IBE)!IBQUIT  S IFN=0 D  S IBQUIT=$$STOP
 .F  S IFN=$O(^DGCR(399,IBINDX,IBCDT,IFN)) Q:'IFN  D FILE
 ;
 ; 5/28/04 - esg - MRA project - patch 155 - get MRA request data
 ;
 S IBCDT=IBBEG-.001,IBE=IBEND+.3
 F  S IBCDT=$O(^DGCR(399,"APM",IBCDT)) Q:'IBCDT!(IBCDT>IBE)!IBQUIT  D
 . S IBQUIT=$$STOP Q:IBQUIT
 . S IFN=0
 . F  S IFN=$O(^DGCR(399,"APM",IBCDT,IFN)) Q:'IFN  D FILEMRA
 . Q
 ;
 I $D(^TMP("IB",$J)),'IBQUIT D PRINT
 ;
EXIT ; - Clean up and quit.
 K ^TMP("IB",$J)
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOCPDS" D T1^%ZOSV ;stop rt clock
 I $D(ZTQUEUED) Q
 K IBE,IBBEG,IBBEGE,IBCANC,IBEND,IBENDE,IBCDT,IFN,IBRT,IBCLK,IBNCLK,IBCT
 K IBTD,IBNODE,IBPGN,IBLN,IBHDR,IBINDX,IBFLD,IBQUIT,IBORDER,IBI,X,Y
 K DTOUT,DUOUT,DIRUT,DIROUT,IBMRAUSR
 D ^%ZISC
 Q
 ;
FILE ; - Save the data in sorted order in a temporary file.
 S IBRT=$P($G(^DGCR(399,IFN,0)),U,7) I 'IBRT Q
 S IBCLK=$P($G(^VA(200,+$P($G(^DGCR(399,IFN,"S")),U,$S(IBORDER="E":2,IBORDER="A":11,IBORDER="P":13,1:0)),0)),U) I IBCLK="" Q
 S IBTD=$P($G(^DGCR(399,IFN,"U1")),U,1)-$P($G(^DGCR(399,IFN,"U1")),U,2)
 S IBCANC=($P(^DGCR(399,IFN,0),U,13)=7)
 S IBNODE=$G(^TMP("IB",$J)),$P(^($J),U,1,4)=($P(IBNODE,U,1)+1)_U_($P(IBNODE,U,2)+IBTD)_U_($P(IBNODE,U,3)+$S('IBCANC:0,1:1))_U_($P(IBNODE,U,4)+$S('IBCANC:0,1:IBTD))
 S IBNODE=$G(^TMP("IB",$J,IBCLK)),$P(^(IBCLK),U,1,4)=($P(IBNODE,U,1)+1)_U_($P(IBNODE,U,2)+IBTD)_U_($P(IBNODE,U,3)+$S('IBCANC:0,1:1))_U_($P(IBNODE,U,4)+$S('IBCANC:0,1:IBTD))
 S IBNODE=$G(^TMP("IB",$J,IBCLK,IBRT)),$P(^(IBRT),U,1,4)=($P(IBNODE,U,1)+1)_U_($P(IBNODE,U,2)+IBTD)_U_($P(IBNODE,U,3)+$S('IBCANC:0,1:1))_U_($P(IBNODE,U,4)+$S('IBCANC:0,1:IBTD))
 S IBNODE=$G(^TMP("IB",$J,"~~")),$P(^("~~"),U,1,4)=($P(IBNODE,U,1)+1)_U_($P(IBNODE,U,2)+IBTD)_U_($P(IBNODE,U,3)+$S('IBCANC:0,1:1))_U_($P(IBNODE,U,4)+$S('IBCANC:0,1:IBTD))
 S IBNODE=$G(^TMP("IB",$J,"~~",IBRT)),$P(^(IBRT),U,1,4)=($P(IBNODE,U,1)+1)_U_($P(IBNODE,U,2)+IBTD)_U_($P(IBNODE,U,3)+$S('IBCANC:0,1:1))_U_($P(IBNODE,U,4)+$S('IBCANC:0,1:IBTD))
 ;
 ; 7/26/04 - ESG - MRA Project - Capture division data for MRA authorizer user
 I IBCLK["AUTHORIZER,IB MRA"!(IBCLK["POSTMASTER")  D
 . N DIV
 . S DIV=+$P($G(^DGCR(399,IFN,0)),U,22)    ; division pointer
 . S DIV=$P($G(^DG(40.8,DIV,0)),U,1)       ; division name
 . I DIV="" S DIV="~UNKNOWN"
 . S IBNODE=$G(IBMRAUSR(IBCLK,IBRT,DIV))
 . S $P(IBMRAUSR(IBCLK,IBRT,DIV),U,1,4)=($P(IBNODE,U,1)+1)_U_($P(IBNODE,U,2)+IBTD)_U_($P(IBNODE,U,3)+$S('IBCANC:0,1:1))_U_($P(IBNODE,U,4)+$S('IBCANC:0,1:IBTD))
 . Q
 Q
 ;
FILEMRA ; Capture and file MRA data into the scratch global
 ; 9/9/03 - ESG - MRA Project
 NEW IBRT,IBTD,MRAUSR,IBNODE
 S IBRT=$P($G(^DGCR(399,IFN,0)),U,7) I 'IBRT G FMX
 S IBTD=$P($G(^DGCR(399,IFN,"U1")),U,1)-$P($G(^DGCR(399,IFN,"U1")),U,2)
 S MRAUSR=+$P($G(^DGCR(399,IFN,"S")),U,8)
 I 'MRAUSR G FMX
 S MRAUSR=$P($G(^VA(200,MRAUSR,0)),U,1)
 I MRAUSR="" G FMX
 S IBNODE=$G(^TMP("IB",$J)),$P(^($J),U,5,6)=($P(IBNODE,U,5)+1)_U_($P(IBNODE,U,6)+IBTD)
 S IBNODE=$G(^TMP("IB",$J,MRAUSR)),$P(^(MRAUSR),U,5,6)=($P(IBNODE,U,5)+1)_U_($P(IBNODE,U,6)+IBTD)
 S IBNODE=$G(^TMP("IB",$J,MRAUSR,IBRT)),$P(^(IBRT),U,5,6)=($P(IBNODE,U,5)+1)_U_($P(IBNODE,U,6)+IBTD)
 S IBNODE=$G(^TMP("IB",$J,"~~")),$P(^("~~"),U,5,6)=($P(IBNODE,U,5)+1)_U_($P(IBNODE,U,6)+IBTD)
 S IBNODE=$G(^TMP("IB",$J,"~~",IBRT)),$P(^(IBRT),U,5,6)=($P(IBNODE,U,5)+1)_U_($P(IBNODE,U,6)+IBTD)
 ;
FMX ;
 Q
 ;
 ;
PRINT ; - Print the report from the temp sort file to the appropriate device.
 N IBT,IBH1,L1,L2,T1,T2,T3,T4,T5,T6
 S IBCLK="",IBPGN=0
 S L1=7        ; length of count fields
 S L2=13       ; length of dollar amount fields
 S T1=50       ; tab stop 1 - total count
 S T2=59       ; tab stop 2 - total dollar amount
 S T3=78       ; tab stop 3 - cancelled count
 S T4=87       ; tab stop 4 - cancelled dollar amount
 S T5=106      ; tab stop 5 - MRA request count
 S T6=115      ; tab stop 6 - MRA request dollar amount
 D HDR F  S IBCLK=$O(^TMP("IB",$J,IBCLK)) Q:IBCLK=""!(IBQUIT)  D LINE
 S IBT=$G(^TMP("IB",$J)) I IBQUIT Q
 W !!,"TOTAL:",?T1,$J(+$P(IBT,U,1),L1),?T2,$J($P(IBT,U,2),L2,2),?T3,$J(+$P(IBT,U,3),L1),?T4,$J($P(IBT,U,4),L2,2),?T5,$J(+$P(IBT,U,5),L1),?T6,$J($P(IBT,U,6),L2,2),!
 D NOTE^IBOCPD,PAUSE
 Q
 ;
LINE ; - Print all data for a particular clerk.
 N IBT,DIV
 S IBLN=IBLN+1 I IBNCLK S IBCT=$G(IBCT)+1
 I IBCLK'="~~" W !,$S(IBNCLK:"CLERK #"_IBCT,1:$E(IBCLK,1,25))
 E  W !,"RATE TYPE TOTALS"
 S IBRT="" F  S IBRT=$O(^TMP("IB",$J,IBCLK,IBRT)) Q:IBRT=""!(IBQUIT)  D  Q:IBQUIT  S IBLN=IBLN+1 I IBLN>(IOSL-7) D PAUSE,HDR:'IBQUIT
 . S IBT=$G(^TMP("IB",$J,IBCLK,IBRT))
 . W ?30,$E($P(^DGCR(399.3,IBRT,0),U,1),1,20),?T1,$J(+$P(IBT,U,1),L1),?T2,$J($P(IBT,U,2),L2,2),?T3,$J(+$P(IBT,U,3),L1),?T4,$J($P(IBT,U,4),L2,2)
 . W ?T5,$J(+$P(IBT,U,5),L1),?T6,$J($P(IBT,U,6),L2,2),!
 . ; divisional display
 . I '$D(IBMRAUSR(IBCLK,IBRT)) Q
 . W ?T1,"  -----",?T2,"  -----------",?T3,"  -----",?T4,"  -----------",?T5,"  -----",?T6,"  -----------"
 . S DIV=""
 . F  S DIV=$O(IBMRAUSR(IBCLK,IBRT,DIV)) Q:DIV=""!IBQUIT  D
 .. S IBLN=IBLN+1 I IBLN>(IOSL-7) D PAUSE,HDR:'IBQUIT
 .. I IBQUIT Q
 .. S IBT=$G(IBMRAUSR(IBCLK,IBRT,DIV))
 .. W !?7,DIV,?T1,$J(+$P(IBT,U,1),L1),?T2,$J($P(IBT,U,2),L2,2),?T3,$J(+$P(IBT,U,3),L1),?T4,$J($P(IBT,U,4),L2,2),?T5,$J(+$P(IBT,U,5),L1),?T6,$J($P(IBT,U,6),L2,2)
 .. Q
 . I IBQUIT Q
 . W !
 . Q
 ;
 I IBQUIT Q
 W ?T1,"  -----",?T2,"  -----------",?T3,"  -----",?T4,"  -----------"
 W ?T5,"  -----",?T6,"  -----------"
 S IBT=$G(^TMP("IB",$J,IBCLK))
 W !,?30,"SUBTOTAL:",?T1,$J(+$P(IBT,U,1),L1),?T2,$J($P(IBT,U,2),L2,2),?T3,$J(+$P(IBT,U,3),L1),?T4,$J($P(IBT,U,4),L2,2)
 W ?T5,$J(+$P(IBT,U,5),L1),?T6,$J($P(IBT,U,6),L2,2),!
 S IBLN=IBLN+2
 Q
 ;
HDR ; - Print the report header.
 N IBH1,IBH2
 S IBQUIT=$$STOP Q:IBQUIT  S IBPGN=IBPGN+1,IBLN=7
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S IBCDT=$P(Y,"@",1)_"  "_$P(Y,"@",2)
 I IBPGN>1!($E(IOST,1,2)["C-") W @IOF
 S IBH1=$S(IBORDER="E":"ENTERED",IBORDER="A":"AUTHORIZED",1:"FIRST PRINTED")
 W "CLERK PRODUCTIVITY SUMMARY FOR BILLS ",IBH1," ",IBBEGE," - ",IBENDE I IOM<85 W !
 S IBH2=$S(IBORDER'="P":IBH1,1:"PRINTED") S:IBORDER="E" IBH1="ENTERED/EDITED"
 W ?(IOM-30),IBCDT,?(IOM-8),"PAGE ",IBPGN,!
 W !,?T1,"---",$S(IBORDER'="A":"-",1:""),"TOTAL ",IBH2,"---",$S(IBORDER'="A":"--",1:""),?T3,"-",$S(IBORDER'="A":"-",1:""),IBH2," CANCELLED-",$S(IBORDER'="A":"--",1:"")
 W ?T5,"-----MRA REQUESTS-----"
 W !,IBH1," BY",?30,"RATE TYPE",?T1,$J("COUNT",L1),?T2,$J("AMOUNT",L2),?T3,$J("COUNT",L1),?T4,$J("AMOUNT",L2)
 W ?T5,$J("COUNT",L1),?T6,$J("AMOUNT",L2),!
 S IBI="",$P(IBI,"-",IOM+1)="" W IBI,!
 Q
 ;
PAUSE ; - Pause at end of screen if beeing displayed on a terminal.
 Q:$E(IOST,1,2)'["C-"
 S DIR(0)="E" D ^DIR K DIR
 I $D(DUOUT)!($D(DIRUT)) S IBQUIT=1
 Q
 ;
STOP() ; - Determine if user has requested the queued report to stop.
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
 ;
HLP ; - "Do you want to print..." prompt.
 W !!,"Select: '<CR>' to print the summary with the clerks' actual names"
 W !?11,"'Y' to print the summary with an identifier ('CLERK #xxx')"
 W !?15,"in place of the clerks' names",!?11,"'^' to quit"
 Q
