PRCACDRP ;ALB/YG - Catastrophically Disabled Exempt Copay Charge Report; July 25, 2019@21:06
 ;;4.5;Accounts Receivable;**350**;Mar 20, 1995;Build 66
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Routine was cloned from IBOCDRPT and moved to AR (PRCA) namespace
 ;
EN ; - this will produce a report of patient's with charges that are CD.
 ;
 N POP,%ZIS,ZTRTN,ZTDESC,ZTSK,IBEDT,IBBDT,%DT,ZTSAVE,IBEXCEL
 W !!,"*** Print the Catastrophically Disabled Exempt Copay Charge Report ***"
 W !!,"The Catastrophically Disabled legislation effective date is May 5, 2010."
 W !,"You should not enter a date prior to that date, any date entered before"
 W !,"that will be automatically changed to May 5, 2010."
 W !!,"This report includes bills for charges without an IB Status of Cancelled"
 W !,"and with an AR Status of Active, Open, Suspended, Write-Off, Cancellation,"
 W !,"Collected/Closed or with an IB Status of On-Hold, and an episode of care"
 W !,"date on or after the Catastrophically Disabled exemption effective date.",!
 D DATE Q:'IBEDT
 S IBEXCEL=$$EXCEL^PRCACDRP()
 I IBEXCEL D EXMSG
 I 'IBEXCEL D
 . W !!,"This report may take a while to process. It is recommended that you Queue"
 . W !,"this report to a device that is 132 characters wide."
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .S ZTRTN="DQ^PRCACDRP",ZTDESC="Catastrophically Disabled Copay Report"
 .S ZTSAVE("IBEDT")="",ZTSAVE("IBBDT")="",ZTSAVE("IBEXCEL")=""
 .D ^%ZTLOAD D HOME^%ZIS K IO("Q")
 .D MES^XPDUTL("Catastrophically Disabled Copay Report queued #"_ZTSK)
DQ U IO
 ;
 N IBX,IBZ,IBDT,IBDG,DFN,IBP,IBARX,IBARBILL,IBARDATA,IBDPT,IBDDT,IBQUIT,REAS,ARSTAT,EOCDT,FUND,IBDATA,IBSTAT,MCDT,RXDT,PRGRP,CD,CDDATE,PAR,PARZ
 ;
 S (IBP,IBQUIT)=0
 D HEAD
 I IBBDT<3100505 S IBBDT=3100505 ; not before CD effective date
 S IBDDT=IBBDT-1 F  S IBDDT=$O(^IB("D",IBDDT)) Q:'IBDDT!(IBQUIT)  D  Q:IBQUIT
 . S IBX=0 F  S IBX=$O(^IB("D",IBDDT,IBX)) Q:'IBX!(IBQUIT)  D  Q:IBQUIT  ;S ^TMP($J,"PRCACDRP",REAS,IBX)=IBZ,X=$I(^TMP($J,"PRCACDRP",REAS))
 . . S IBZ=$G(^IB(IBX,0)),DFN=+$P(IBZ,"^",2)
 . . S PRGRP=$$PRIORITY^DGENA(DFN)
 . . S IBDT=$S($E($P(IBZ,"^",4),1,2)=52:IBDDT,$P(IBZ,"^",8)="RX COPAYMENT":IBDDT,$P(IBZ,"^",15):$P(IBZ,"^",15),1:$P(IBZ,"^",14))\1
 . . K IBDG
 . . S IBDG=$$GET^DGENCDA(DFN,.IBDG)  ; IA# 4969
 . . ; quit if no date, or pt not CD
 . . S REAS=1
 . . I 'IBDT Q  ; no date
 . . S CDDATE=IBDG("REVDTE")
 . . S CD=$G(IBDG("VCD"))="Y"
 . . ; Business decision is to ignore Billing Exemption file 354.1
 . . ;I 'CD S CDDATE="" F  S CD=$O(^IBA(354.1,"AP",DFN,CD)) Q:'CD  I $P($G(^IBA(354.1,CD,0)),U,5)=12 S CD=1,CDDATE=$P(^(0),U) Q
 . . I 'CD Q
 . . S IBARX=+$O(^PRCA(430,"B",$S($P(IBZ,"^",11):$P(IBZ,"^",11),1:0),0))  ; IA# 389
 . . S IBARBILL=$S(IBARX:$$BILL^RCJIBFN2(IBARX),1:"")  ; IA# 1452
 . . K IBARDATA
 . . I IBARX D DIQ^RCJIBFN2(IBARX,"8,77:79;141;203;255.1","IBARDATA") ; IA# 1452
 . . S IBDATA=$$GETIB^RCDMCR4B(IBX,0)
 . . S MCDT=$P(IBDATA,U,2) I MCDT="" S MCDT=$P(IBDATA,U,3)
 . . S RXDT=$P(IBDATA,U,4)
 . . S EOCDT=$S(RXDT>MCDT:RXDT,1:MCDT)
 . . S IBSTAT=$P(IBDATA,U,5) S:IBSTAT="" IBSTAT=$P(IBZ,U,5)
 . . S ARSTAT=$G(IBARDATA(430,IBARX,8,"E")) I ARSTAT="COLLECTED/CLOSED" S ARSTAT="C/C"
 . . ; quit if status cancelled (ib) or no charge
 . . I IBSTAT=10 Q  ; cancelled
 . . I '$P(IBZ,"^",7) Q  ; no charge
 . . ; quit if AR STATUS is not on the list and IB status is not ON HOLD.  Question - what about CANCELLED BILL (#26)
 . . S REAS=2 I IBARX,$P(IBARBILL,"^",2)=26 Q
 . . ; non inpatient, only talk to parent
 . . S REAS=3 I $P(IBZ,U,4)'?1"405:".E,$P(IBZ,U,4)'?1"45:".E,$$PARENTE^RCDMCR5B(IBX)'=IBX Q
 . . ; inpatient, check if parent event or parent charge is cancelled.
 . . I $P(IBZ,U,4)?1"405:".E!($P(IBZ,U,4)'?1"45:".E) S PAR=$$PARENTE^RCDMCR5B(IBX) I PAR S PARZ=^IB(PAR,0) I $P(PARZ,U,5)=10 Q
 . . I $P(IBZ,U,4)?1"405:".E!($P(IBZ,U,4)'?1"45:".E) S PAR=$$PARENTC^RCDMCR5B(IBX) I PAR S PARZ=^IB(PAR,0) I $P(PARZ,U,5)=10 Q
 . . ; quit if CD effective date not before event date
 . . S REAS=4 Q:IBDT<3100505  Q:IBDT<CDDATE
 . . ; quit if not within specified date range
 . . S REAS=5 Q:IBDT<IBBDT!(IBDT>IBEDT)  Q:EOCDT<IBBDT!(EOCDT>IBEDT)
 . . ; quit if LTC action type
 . . S REAS=6 I $P($G(^IBE(350.1,+$P(IBZ,"^",3),0)),"^")["LTC " Q
 . . S REAS=7 Q:'IBDATA
 . . ; quit if not the right fund
 . . S REAS=8 I IBARX S FUND=$G(IBARDATA(430,IBARX,203,"E")) I FUND'=528703,FUND'=528701 Q
 . . ; quit if AR STATUS is not on the list and IB status is not ON HOLD.  Question - what about CANCELLED BILL (#26)
 . . S REAS=9 I '$F(",16,39,42,40,22,23,",","_$P(IBARBILL,U,2)_","),$P(IBZ,U,5)'=8 Q
 . . S REAS=10 Q:EOCDT<3100505  Q:EOCDT<CDDATE
 . . S IBDPT=$G(^DPT(DFN,0))
 . . I 'IBEXCEL D
 . . . S REAS=0 W !,$E($P(IBDPT,"^"),1,20) ; patient name
 . . . W ?21,$P(IBDPT,"^",9) ; snn
 . . . W ?31,PRGRP ; Priority group
 . . . W ?33,$$FMTE^XLFDT($G(IBDG("REVDTE")),"2DZ") ; Catastrophically Disabled Date, IA# 10103
 . . . W ?42,$E($P($P(IBZ,"^",11),"-",2),1,8) ; ar bill no
 . . . ;IBDATA = 1 ^ Outpatient Date ^ Discharge Date ^ RX/Refill Date ^ IB Status ^ RX NUM ^ RX Name ^ CHGAMT
 . . . W:MCDT'="" ?50,$$FMTE^XLFDT(MCDT,"2DZ") ; Med Care Date
 . . . W:RXDT'="" ?59,$$FMTE^XLFDT(RXDT,"2DZ") ; RX Date
 . . . W ?68,$E($P(IBDATA,U,6),1,8) ; rx #
 . . . W ?77,$E($P(IBDATA,U,7),1,20) ; rx name
 . . . W ?98,$J("$"_$FN($P(IBDATA,U,8),"",2),9) ; charge
 . . . W ?108,$E($P($G(^IBE(350.21,IBSTAT,0)),U),1,10) ; IBSTATUS
 . . . W ?119,$E(ARSTAT,1,13) ; AR Status
 . . . I $Y+3>IOSL D HEAD
 . . I IBEXCEL D
 . . . S REAS=0 W !,"""",$P(IBDPT,"^"),"""" ; patient name
 . . . W U,$P(IBDPT,"^",9) ; snn
 . . . W U,PRGRP ; Priority group
 . . . W U,$$FMTE^XLFDT($G(IBDG("REVDTE")),"2DZ") ; Catastrophically Disabled Date, IA# 10103
 . . . W U,$P($P(IBZ,"^",11),"-",2) ; ar bill no
 . . . ;IBDATA = 1 ^ Outpatient Date ^ Discharge Date ^ RX/Refill Date ^ IB Status ^ RX NUM ^ RX Name ^ CHGAMT
 . . . W U W:MCDT'="" $$FMTE^XLFDT(MCDT,"2DZ") ; Med Care Date
 . . . W U W:RXDT'="" $$FMTE^XLFDT(RXDT,"2DZ") ; RX Date
 . . . W U,$P(IBDATA,U,6) ; rx # (or get it from IBDATA?)
 . . . W U,$P(IBDATA,U,7) ; rx name
 . . . W U,"$",$FN($P(IBDATA,U,8),"",2) ; charge
 . . . W U,$P($G(^IBE(350.21,IBSTAT,0)),U) ; IBSTATUS
 . . . W U,ARSTAT ; AR Status
 I 'IBQUIT,'IBEXCEL,IBP,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR I $D(DIRUT) S IBQUIT=1 Q
 D ^%ZISC
EXIT S:$D(ZTQUEUED) ZTREQ="@"
 Q
HEAD ;
 N IBL,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I 'IBEXCEL,IBP,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR I $D(DIRUT) S IBQUIT=1 Q
 S IBP=IBP+1
 I 'IBEXCEL D
 . W @IOF,!,"Cross-Servicing Catastrophically Disabled Exempt Copayment Charge Report   --- Run Date: ",$$FMTE^XLFDT($$NOW^XLFDT,"9MP")," ---",?122,"Page: ",IBP
 . W !,"Episode of Care Dates from ",$$FMTE^XLFDT(IBBDT,"9MP")," to ",$$FMTE^XLFDT(IBEDT,"9MP")
 . W !,"                              Pri  CD             Medical   RX Fill                                  Charge"
 . W !,"Patient Name           SSN    Grp  Date   Bill NO Care Date Date    RX #     RX Name                 Amount IB Status  AR Status",!
 I IBEXCEL D
 . W !,"Patient Name",U,"SSN",U,"Pri Grp",U,"CD Date",U,"Bill NO",U,"Medical Care Date",U,"RX Fill Date",U,"RX #",U
 . W "RX Name",U,"Charge Amount",U,"IB Status",U,"AR Status",U
 I 'IBEXCEL F IBL=1:1:$S(IOM:IOM,1:132) W "-"
 Q
EXCEL() ; Export the report to MS Excel?
 ; Function return values:
 ;   0 - User selected "No" at prompt.
 ;   1 - User selected "Yes" at prompt.
 ;   ^ - User aborted.
 ; This function allows the user to indicate whether the report should be
 ; printed in a format that could easily be imported into an Excel
 ; spreadsheet.  If the user wants to print in EXCEL format, the variable 
 ; IBEXCEL will be set to '1', otherwise IBEXCEL will be set to '0' for "No" 
 ; or "^" to abort.
 ;
 N DIR,DIRUT,Y
 S DIR(0)="Y"
 S DIR("A")="Do you want to capture report data for an Excel document"
 I $G(IBEXCEL)=1 S DIR("B")="YES"
 E  S DIR("B")="NO"
 S DIR("?",1)="If you want to capture the output from this report in a format that"
 S DIR("?",2)="could easily be imported into an Excel spreadsheet, then answer YES here."
 S DIR("?")="If you want a normal report output, then answer NO here."
 W !
 D ^DIR
 K DIR
 I $D(DIRUT) Q "^" ; Abort
 Q +Y
DATE ;
 ;  -get beginning and ending dates
 ;  -output in ibbdt - beginning date
 ;             ibedt - ending date
 ;
BDT ;  -get beginning date
 S (IBBDT,IBEDT)=""
 ;S %DT(0)=3100505
 S %DT("B")="May 5, 2010"
 S %DT="AEX",%DT("A")="Start with DATE: " D ^%DT K %DT G DATEQ:Y<0
 S IBBDT=Y
 I IBBDT<3100505 S IBBDT=3100505 ;W !,"Start date changed to 5/5/2010"
 ;
EDT ;  -get ending date
 S %DT="AEX",%DT("A")="Go to DATE: ",%DT("B")="T" D ^%DT S:X=" " X=IBBDT
 G DATEQ:(X="")!(X["^") G EDT:Y<0
 S IBEDT=Y I Y<IBBDT W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G BDT
 ;
DATEQ K %DT
 Q
EXMSG ;
 W !,"This report may take a while to process.  To capture as an Excel"
 W !,"format, it is recommended that you queue this report to a spool device"
 W !,"with margins of 256 and page length of 99999 (e.g. spoolname;256;99999)."
 W !,"This should help avoid wrapping problems."
 W !!,"Another method would be to set up your terminal to capture the detail"
 W !,"report data.  On some terminals, this can be done by clicking on the "
 W !,"'Tools' menu above, then click on 'Capture Incoming Data' to save to"
 W !,"Desktop.  To avoid undesired wrapping of the data saved to the file,"
 W !,"please enter '0;256;99999' at the 'DEVICE:' prompt."
 Q
