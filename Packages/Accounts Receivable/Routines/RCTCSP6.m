RCTCSP6 ;ALB/YG - Cross-Servicing Re-Referred Bills Report;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**350**;Mar 20, 1995;Build 66
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
MAIN ;PRCA*4.5*350
 ;
BILLREP ;Cross-servicing bill report, prints individual bills that make up a cross-servicing account
 N DIC,DEBTOR,ZTSAVE,ZTDESC,ZTRTN,POP,DTFRMTO,PROMPT,EXCEL,RUNDATE,PAGE,DFN
 S RUNDATE=$$FMTE^XLFDT($$NOW^XLFDT,"9MP")
 K ^TMP("RCTCSP1",$J)
 S PAGE=0
 W !,"*** Cross-Servicing Re-Referred Bills Report ***",!
 W !,"The Cross-Servicing Re-Referred Bills Report provides a list of all bills"
 W !,"that have been re-referred to Cross-Servicing.",!
 ;S DIC=340,DIC(0)="AEQM",DIC("S")="I $D(^RCD(340,""TCSP"",+Y))" D ^DIC
 ;Q:Y<1  S DEBTOR=+Y
 ;S DTFRMTO=$$DTFRMTO^RCTCSP2 Q:'DTFRMTO  ;Get date range as per PRCA*4.5*315
 S DTFRMTO=$$DATE2^RCDMCUT2("  Enter the Date Range for Bills that have been Re-Referred for Cross-Servicing:  ",,"T-7")
 S EXCEL=0,PROMPT="CAPTURE Report data to an Excel Document",DIR(0)="Y",DIR("?")="^D HEXC^RCTCSJR"
 ;S EXCEL=$$SELECT^RCTCSJR(PROMPT,"NO") 
 S EXCEL=$$EXCEL^RCDMCUT2
 I "01"'[EXCEL Q
 I EXCEL D EXCMSG^RCTCSJR ; Display Excel display message
 I 'EXCEL W !,"It is recommended that you Queue this report to a device that is 132 characters wide. "
 S %ZIS="MQ" D ^%ZIS G:POP BILLREPQ     ;PRC*4.5*336
 I $D(IO("Q")) D  G BILLREPQ
 .S ZTSAVE("DEBTOR")="",ZTSAVE("DTFRMTO")="",ZTSAVE("EXCEL")=""
 .S ZTRTN="BILLREPP^RCTCSP6",ZTDESC="CROSS-SERVICING BILL REPORT"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 .Q
 ;
BILLREPP ;Call to build array of bills referred
 U IO
 N BILL,B7,B14,B15,B16,D4,FND,BAMT,DIRUT,TNM,TID,TDT,DASH,CSTAT,PAGE,DASH,TMP,I,DATE,DTFRM,DTTO,DATDATE,REASON,COMMENT,USER,OAMT,LIEN,NAME,NODE,SSN
 K ^TMP("RCTCSP6",$J)
 S DASH="",$P(DASH,"-",78)=""  ;(as per PRCA*4.5*315)
 S (DATE,DTFRM)=$$FMADD^XLFDT(+$P(DTFRMTO,U,2)),DTTO=$P(DTFRMTO,U,3)
 S (BAMT,BILL,PAGE)=0
 ; rewritten to sort by "TCSP" (#151 date referred to TCSP) not the "AB" xref... PRCA*4.5*315 (TV8)
 F  S BILL=$O(^PRCA(430,"TCSP",BILL)) Q:BILL=""!($D(DIRUT))  D:$$RR^RCTCSPU(BILL)
 .S DEBTOR=$P($G(^PRCA(430,BILL,0)),U,9)
 .S DFN=$P($G(^RCD(340,DEBTOR,0)),U) Q:DFN'[";DPT" 
 .S DFN=+DFN
 .D DEM^VADPT
 .I $G(VAERR)>0 D KVAR^VADPT Q
 .S NAME=$G(VADM(1))
 .I NAME']"" D KVAR^VADPT Q
 .S SSN=$P(VADM(2),U,1)
 .Q:'+$G(^PRCA(430,BILL,15))
 .S DATDATE=$P($G(^PRCA(430,BILL,15)),U) Q:DATDATE<DTFRM!(DATDATE>DTTO)
 .S B7=$G(^PRCA(430,BILL,7))
 .S BAMT=0 F I=1:1:5 S BAMT=BAMT+$P(B7,U,I)
 .S ^TMP("RCTCSP6",$J,DEBTOR,BILL)=BAMT_U_NAME_U_SSN
 D BILLREPH
 S DEBTOR="" F  S DEBTOR=$O(^TMP("RCTCSP6",$J,DEBTOR)) Q:'DEBTOR!($D(DIRUT))  D  Q:$D(DIRUT)
 . S BILL=0 F  S BILL=$O(^TMP("RCTCSP6",$J,DEBTOR,BILL)) Q:'BILL  D  Q:$D(DIRUT)
 ..Q:'+$G(^PRCA(430,BILL,15))
 ..S NODE=^TMP("RCTCSP6",$J,DEBTOR,BILL),BAMT=$P(NODE,U),NAME=$P(NODE,U,2),SSN=$P(NODE,U,3)
 ..S FND=1 W !,$P(^PRCA(430,BILL,0),U) ; Bill
 ..S CSTAT=$P(^(0),U,8),B7=$G(^(7)),B15=$G(^(15)),B16=$G(^(16))
 ..I 'EXCEL W ?14,$E(NAME,1,17) ; Name
 ..I EXCEL W U,NAME
 ..I 'EXCEL W ?34,SSN ; SSN
 ..I EXCEL W U,SSN
 ..I 'EXCEL W ?45,$$FMTE^XLFDT($P(B15,U,1),"2Z") ; Rerefer date
 ..I EXCEL W U,$$FMTE^XLFDT($P(B15,U,1),"2Z")
 ..S OAMT=$P(B16,U,9) I OAMT'>0 S OAMT=$P($G(^PRCA(430,BILL,30)),U,10)
 ..I 'EXCEL W ?55,$J("$"_$FN(OAMT,",",2),11) ; Original Amt
 ..I EXCEL W U,"$"_$FN(OAMT,",",2)
 ..I 'EXCEL W ?70,$J("$"_$FN(BAMT,",",2),11) ; Curr Amt
 ..I EXCEL W U,"$"_$FN(BAMT,",",2)
 ..I 'EXCEL,OAMT-BAMT'=0 W ?85,$J("$"_$FN(OAMT-BAMT,",",2),11) ; diff amt
 ..I EXCEL W U W:OAMT-BAMT'=0 "$",$FN(OAMT-BAMT,",",2)
 ..S LIEN=$O(^PRCA(430,BILL,15.5,"B",0,""),-1)
 ..S REASON=$P(^PRCA(430,BILL,15.5,LIEN,0),U,4)
 ..S REASON=$S(REASON="T":"Treas RVSL",REASON="R":"Recall Error",REASON="D":"DFLT RPP",REASON="O":"Other")
 ..S USER=$P(^PRCA(430,BILL,15.5,LIEN,0),U,3),USER=$P(^VA(200,USER,0),U)
 ..I 'EXCEL W ?100,$E(REASON,1,15)
 ..I EXCEL W U,REASON
 ..I 'EXCEL W ?116,$E(USER,1,16)
 ..I EXCEL W U,USER
 ..;check for end of page here, if necessary form feed and print header
 ..I ($Y+3)>IOSL D
 ...I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR Q:$D(DIRUT)
 ...D BILLREPH
 I $E(IOST,1,2)="C-",'$D(DIRUT) R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP("RCTCSP6",$J)
 K IOP,%ZIS,ZTQUEUED
BILLREPQ Q
 ;
BILLREPH ;header for cross-servicing bill report
 W @IOF
 S PAGE=PAGE+1
 I 'EXCEL D
 . W @IOF,"Cross-Servicing Re-Referred Bills Report   -- Run Date: ",RUNDATE," --"
 . W ?122,"Page "_PAGE
 . W !,"    Re-Referred Dates from ",$$FMTE^XLFDT(DTFRM,"9D")," to ",$$FMTE^XLFDT(DTTO,"9D")
 . W !
 ;I 'EXCEL W "PAGE "_PAGE,?24,"CROSS-SERVICING BILL REPORT",?60,$$FMTE^XLFDT(DT,"2Z"),!,DASH
 ;I EXCEL W "PAGE "_PAGE_U_"CROSS-SERVICING BILL REPORT"_U_U_$$FMTE^XLFDT(DT,"2Z")
 ;N RCHDR,RCSSN
 ;S RCHDR=$$ACCNTHDR^RCDPAPLM(DEBTOR),RCSSN=$S($P(RCHDR,U,2)["P":$E($P(RCHDR,U,2),7,11),1:$E($P(RCHDR,U,2),6,9))  ;Pseudo SSN shouldn't be allowed but we allowed for it to print
 I EXCEL W !,"Bill #",U,"Debtor Name",U,"SSN",U,"Re-Refer Date",U,"Orig Amt",U,"Curr Amt",U,"Diff Amt",U,"Reason",U,"User ID" Q
 W !,"Bill #",?19,"Debtor Name",?37,"SSN",?43,"Re-Refer Date",?57,"Orig Amt",?72,"Curr Amt",?87,"Diff Amt",?102,"Reason",?120,"User ID"
 D ULINE^RCDMCUT2("=",$G(IOM))
 Q
 ;
