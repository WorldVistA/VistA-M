RCDMCR8A ;ALB/YG - Pension Report Exempt Charge Reconciliation Report - Input/output; Jun 16, 2021@14:23
 ;;4.5;Accounts Receivable;**384**;Jun 16, 2021;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;This routine is being implemented for the AR Cross-Servicing Project
 ; This report assists users in reviewing all bills containing charges 
 ; with a distinct date of service on or after the co-payment exemption 
 ; effective date for Veterans with Primary or Secondary Eligibility equal 
 ; Pension
 ; 
 ;  The report captures any charges without an IB status of cancelled, and
 ; with an AR Status of Active, Open, Suspended, Write-Off, or Collected/
 ; Closed or an IB Status of On-Hold, with a date of service on or after 
 ; the exemption effective date.
 ;
MAIN ; Initial Interactive Processing
 N ZTQUEUED,ZTREQ
 S:$G(U)="" U="^"
 N STOPIT,EXCEL,RCSCR,ARTYPE,NDTFLAG
 W !!,"*** Print the Pension Exempt Charge Recon Report ***",!
 S STOPIT=0 ; quit flag
 ; Get Status
 ;S ARTYPE=$$ARSTAT^RCDMCUT2(.STOPIT)
 S ARTYPE=$$ARSTAT(.STOPIT)
 Q:STOPIT>0!(ARTYPE']"")
 ;
 S NDTFLAG=0
 D  Q:NDTFLAG="^"
 . N Y
 . K DIR,DIRUT,DTOUT,DIROUT,DUOUT
 . S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 . S DIR("A")="Show veterans with missing Exempt Date"
 . D ^DIR S NDTFLAG=$G(Y)
 . S:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) NDTFLAG="^"
 . K DIR,DIRUT,DTOUT,DIROUT,DUOUT,Y
 ; Prompt user if report will be Excel Delimited format:
 S EXCEL=$$EXCEL^RCDMCUT2
 ;Quit is user up arrowed or timed out
 Q:EXCEL="^"
 D:EXCEL>0 EXMSG^RCDMCUT2
 D:EXCEL'>0
 . W !!,"This report may take a while to process. It is recommended that"
 . W !,"you Queue this report to a device that is 132 characters wide."
 ;
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,POP,ZTSAVE
 S %ZIS="QM"
 W ! D ^%ZIS
 I POP S STOPIT=1 Q
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 I $D(IO("Q")) D  S STOPIT=1
 . S ZTRTN="RUN^RCDMCR8A"
 . S ZTIO=ION
 . S ZTSAVE("RCSCR")=""
 . S ZTSAVE("ARTYPE")=""
 . S ZTSAVE("EXCEL")=""
 . S ZTSAVE("NDTFLAG")=""
 . S ZTDESC="Pension Exempt Charge Recon Report Process"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request Queued.  TASK = "_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 ;
 Q:STOPIT>0!($D(ZTQUEUED))
 D RUN^RCDMCR8A
 I STOPIT'=2 D PAUSE2^RCDMCUT2
 Q
 ;
RUN ;Get data and Print it out
 ;If queued ensure you delete it from the TASKS file
 I $D(ZTQUEUED) S ZTREQ="@"
 N RCPAGE
 K ^TMP($J,"RCDMCR8")
 S RCPAGE=0,STOPIT=$G(STOPIT)
 ; Collect the data in ^TMP
 D COLLECT^RCDMCR8B(.STOPIT,ARTYPE)
 Q:$G(STOPIT)>0
 U IO
 ; Print Report using data in ^TMP
 D REPORT
 I 'RCSCR W !,@IOF
 D ^%ZISC
 K ^TMP($J,"RCDMCR8")
 K EXCEL,RCSCR,TESTDATE
 Q
 ;
REPORT ;Print report
 N RUNDATE,STATUS,NAME,SSN,BILLNO,IBIEN,SKIP,DISCHDT
 ;
 S RUNDATE=$$FMTE^XLFDT($$NOW^XLFDT,"9MP")
 D HDR
 I +$D(^TMP($J,"RCDMCR8"))'>0 W !,"No data meets the criteria." Q
 K SKIP
 S NAME=""
 F  S NAME=$O(^TMP($J,"RCDMCR8","DETAIL",NAME)) Q:NAME']""  D  Q:STOPIT
 . S SSN=""
 . F  S SSN=$O(^TMP($J,"RCDMCR8","DETAIL",NAME,SSN)) Q:SSN']""  D  Q:STOPIT
 . . S BILLNO=""
 . . F  S BILLNO=$O(^TMP($J,"RCDMCR8","DETAIL",NAME,SSN,BILLNO)) Q:BILLNO']""  D  Q:STOPIT
 . . . S IBIEN=""
 . . . F  S IBIEN=$O(^TMP($J,"RCDMCR8","DETAIL",NAME,SSN,BILLNO,IBIEN)) Q:IBIEN']""  D  Q:STOPIT
 . . . . N NODE,SERVDT,RXDT,ELIG,EXEMPTDT,RXNUM,RXNAM,STATUS,ELIGTYP,PNTERMDT
 . . . . ; S ^TMP($J,"RCDMCR8","DETAIL",NAME,SSN,BILLNO,IBIEN)=SERVDT_U_RXDT_U_ELIG_U_EXEMPTDT_U_RXNUM_U_RXNAM_U_STATUS_U_ELIGTYP
 . . . . S NODE=$G(^TMP($J,"RCDMCR8","DETAIL",NAME,SSN,BILLNO,IBIEN))
 . . . . S SERVDT=$S($P(NODE,U,10)'="":$P(NODE,U,10),1:$P(NODE,U,1))
 . . . . S RXDT=$P(NODE,U,2)
 . . . . S ELIG=$P(NODE,U,3)
 . . . . S EXEMPTDT=$P(NODE,U,4)
 . . . . S RXNUM=$P(NODE,U,5)
 . . . . S RXNAM=$P(NODE,U,6)
 . . . . S STATUS=$P(NODE,U,7)
 . . . . S ELIGTYP=$P(NODE,U,8)
 . . . . S PNTERMDT=$P(NODE,U,9) ;Pension Termination Date
 . . . . S DISCHDT=$P(NODE,U,11) ;Discharge Date
 . . . . I EXCEL'>0 D WRLINE Q
 . . . . I EXCEL>0 D WRLINE2 Q
 Q
 ;
WRLINE ; Write the data formated report line
 ; Columns are - position, width, spacing (offset header by)
 ;Veteran Name - 1,23,1 
 ;Pat/ID (1st char Last Name + Last 4 of SSN) - 25,5,2
 ;Bill # - 32,11,1
 ;EXMPTDT - 44,7,2
 ;PNTERMDT - 53,7,3
 ;Med Care Date - 63,7,1
 ;D/C Date - 72,8,2
 ;RXFillDT - 82,7,2
 ;RX # - 91,9,1
 ;RX Name - 101,22,1 
 ;Status - 124,9,1
 D CHKP() Q:STOPIT
 I NDTFLAG=0,EXEMPTDT="NODATE" Q
 W !
 W $E(NAME,1,23) ; Veteran Name
 W ?24,$E(NAME,1)_$E(SSN,$L(SSN)-3,$L(SSN)) ; 1st char last name + Last 4 of SSN
 W ?31,$P(BILLNO,"/",1) ; Bill Number
 I EXEMPTDT="NODATE" W ?43,EXEMPTDT Q
 W ?43,$$STRIP^XLFSTR($$FMTE^XLFDT(EXEMPTDT,"8D")," ")
 W:PNTERMDT>0 ?52,$$STRIP^XLFSTR($$FMTE^XLFDT(PNTERMDT,"8D")," ")
 W:SERVDT>0 ?62,$$STRIP^XLFSTR($$FMTE^XLFDT(SERVDT,"8D")," ")
 W:DISCHDT>0 ?70,$$STRIP^XLFSTR($$FMTE^XLFDT(DISCHDT,"8D")," ") ;Discharge Date
 W:RXDT>0 ?80,$$STRIP^XLFSTR($$FMTE^XLFDT(RXDT,"8D")," ") ; Med Fill Date
 W ?89,RXNUM ; RX # 
 W ?99,$E(RXNAM,1,22) ; RX Name
 W ?122,$E(STATUS,1,9)
 ;W:RXDT>0 ?71,$$STRIP^XLFSTR($$FMTE^XLFDT(RXDT,"8D")," ") ; Med Fill Date
 ;W ?79,RXNUM ; RX # 
 ;W ?89,$E(RXNAM,1,22) ; RX Name
 ;W ?112,$E(STATUS,1,9)
 ;W ?122,$E(ELIGTYP,1,4)
 Q
 ;
WRLINE2 ; Write the Excel report line
 I NDTFLAG=0,EXEMPTDT="NODATE" Q
 W !
 W NAME,U
 W $E(NAME,1)_$E(SSN,$L(SSN)-3,$L(SSN)),U
 W $P(BILLNO,"/",1),U
 I EXEMPTDT="NODATE" W EXEMPTDT,U,U,U,U,U,U,U Q
 W:EXEMPTDT $$FMTE^XLFDT(EXEMPTDT,"9D") W U
 W:PNTERMDT $$FMTE^XLFDT(PNTERMDT,"9D") W U
 W:SERVDT $$FMTE^XLFDT(SERVDT,"9D") W U
 W:DISCHDT $$FMTE^XLFDT(DISCHDT,"9D") W U
 W:RXDT $$FMTE^XLFDT(RXDT,"9D") W U
 W RXNUM,U
 W RXNAM,U
 W STATUS,U
 ;W ELIGTYP,U
 Q
 ;
CHKP(FOOTER) ;Check for End of Page
 ;INPUT:
 ;  FOOTER - Footer value. Optional. Default to 4 if nothing passed
 I $G(FOOTER)'>0 S FOOTER=4
 I $Y>(IOSL-FOOTER) D:RCSCR PAUSE^RCDMCUT2 Q:STOPIT  D HDR K SKIP
 Q
 ;
HDR ;Print Report Header
 I EXCEL>0 D  Q
 . W !,"Veteran Name",U,"Pat/ID",U
 . W "Bill #",U,"EXMPTDT",U,"PenTermDt",U,"Med Care Date",U,"D/C Date",U,"RXFillDT",U,"RX #",U,"RX Name",U,"Status"
 S RCPAGE=RCPAGE+1
 W @IOF,"Pension Exempt Charge Reconciliation Report  -- Run Date: ",RUNDATE," --"
 W ?122,"Page "_RCPAGE
 ;Print to screen or printer
 W !,"Veteran Name",?24,"Pat/ID",?31,"Bill #",?43,"EXMPTDT",?52,"PenTermDt",?62,"MedC DT",?70,"D/C Date",?80,"RXFillDT",?89,"RX #",?99,"RX Name",?122,"Status"
 D ULINE^RCDMCUT2("=",$G(IOM))
 Q
 ;
ARSTAT(STOPIT) ;Chose AR status
 N C,SL,J,TEMP
 S SL=0
 F J=1:1:10 D  Q:SL=0
 . S SL=0
 . D MENU
 . I Y=7 Q
 . I Y="^"!(Y="") S STOPIT=1 Q
 . I $E(Y,$L(Y))="," S Y=$E(Y,1,$L(Y)-1)
 . F C=1:1:$L(Y,",") Q:SL!(Y=7)  D
 . . S TEMP=$P(Y,",",C)
 . . I TEMP>7!(TEMP<1) S SL=1 Q
 . . I TEMP=7 S Y=7 Q
 Q Y
 ;
MENU ;
 W !,?5,"1 - Active"
 W !,?5,"2 - Open"
 W !,?5,"3 - Suspended"
 W !,?5,"4 - Collected/Closed"
 W !,?5,"5 - IB On-Hold"
 W !,?5,"6 - Write-Off"
 W !,?5,"7 - ALL (Includes 1-6 and AR CANCELLATIONS)",!
 N DIR
 K X,Y
 S DIR(0)="LO^1:7"
 S DIR("B")=7
 D ^DIR
 Q
