RCRFRPT ;EDE/YMG - MULTIPLE REFERRAL PROGRAMS REPORT; 11/02/2022
 ;;4.5;Accounts Receivable;**412**;Mar 20, 1995;Build 13
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 N DAY,POP,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 K ^TMP("RCRFRPT",$J)
 W !!,"Multiple Referral Programs Report",!
 S DAY=$E(DT,6,7)
 I (DAY>19)!(DAY<8) D  Q
 .W !,"WARNING:"
 .W !,"  This report is disabled from the 20th of current month through the 7th of"
 .W !,"  the next month to ensure that the DMC Master File updates have occurred.",!
 .D PAUSE^RCRPRPU
 .Q
 D EXCMSG^RCTCSJR    ; Excel display message
 ; ask for device
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ; queued report
 .S ZTDESC="Multiple Referral Programs Report",ZTRTN="COMPILE^RCRFRPT"
 .S ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! D PAUSE^RCRPRPU
 .Q
 D COMPILE
 Q
 ;
COMPILE ; compile report
 N AAFLG,BILLNO,DBTR,DEATHDT,DEBTOR,DFN,DMCDT,DMCFLG,HBFLG,HRFSFLG,IENS,INCLUDE,LTRDT1,LTRDT2,LTRDT3,N0,N6,PENFLG,PNAME,PREPDT,PTDONE,RCBAL,RCBILL,RCCAT,RCSTAT
 N SC,SCFLG,SSN,TCSPDT,TCSPFLG,TOPDT,TOPFLG,VADM,VAEL,VAMB,Z
 S DBTR=0 F  S DBTR=$O(^RCD(340,"B",DBTR)) Q:'DBTR  D
 .I $P(DBTR,";",2)'["DPT(" Q  ; debtor is not a patient
 .S DEBTOR=$O(^RCD(340,"B",DBTR,"")) Q:'DEBTOR
 .I $P($G(^RCD(340,DEBTOR,3)),U,10) Q  ; DMC site deletion flag is set
 .I $P($G(^RCD(340,DEBTOR,6)),U,2) Q  ; TOP referral is stopped
 .S DFN=$P(DBTR,";") D DEM^VADPT
 .S PNAME=VADM(1)  ; patient name
 .S SSN=$P(VADM(2),U)  ; patient SSN
 .S DEATHDT=+$P(VADM(6),U) I DEATHDT Q  ; date of death
 .D MB^VADPT S AAFLG=$P(VAMB(1),U),HBFLG=$P(VAMB(2),U),PENFLG=$P(VAMB(4),U)  ; A&A, Housebound, and pension flags
 .S SC=0 D ELIG^VADPT S SCFLG=$P(VAEL(3),U) I SCFLG S SC=$P(VAEL(3),U,2) ; service connected %
 .S HRFSFLG=$$CHKHRFS^RCHRFSUT(DFN,DT,DT) I HRFSFLG Q  ; was there an active HRFS flag for this patient (1/0)
 .S PTDONE=0
 .S RCBILL=0 F  S RCBILL=$O(^PRCA(430,"C",DEBTOR,RCBILL)) Q:'RCBILL  D
 ..S (DMCFLG,TCSPFLG,TOPFLG)=0
 ..S DMCDT=+$G(^PRCA(430,RCBILL,12)) S:DMCDT DMCFLG=1  ; DMC referral date; if 0, then bill is not at DMC
 ..S IENS=RCBILL_","
 ..S RCSTAT=$$GET1^DIQ(430,IENS,8) I "^ACTIVE^SUSPENDED^CANCELLATION^COLLECTED/CLOSED^"'[(U_RCSTAT_U) Q  ; incorect bill status
 ..S TOPDT=+$G(^PRCA(430,RCBILL,14)) S:TOPDT TOPFLG=1  ; TOP referral date
 ..S TCSPDT=0,Z=$G(^PRCA(430,RCBILL,15)) I '$P(Z,U,2),'$P(Z,U,7) S TCSPDT=+$P(Z,U)  ; TCSP referral date, get if neither recall of stop referral flag is set
 ..S:TCSPDT TCSPFLG=1
 ..S INCLUDE=$S(TOPFLG=TCSPFLG:TOPFLG,1:DMCFLG)  ; debt at 2 or more referral programs
 ..I AAFLG!HBFLG!PENFLG S INCLUDE=TOPFLG!TCSPFLG  ; debt at treasury when debtor has A&A, housebound, or pension
 ..I 'INCLUDE Q
 ..S N0=^PRCA(430,RCBILL,0),BILLNO=$P(N0,U),PREPDT=+$P(N0,U,10)  ; Bill # and Bill Prepared Date
 ..S RCBAL=$$BALANCE^RCRPRPU(RCBILL)  ; current bill balance
 ..S RCCAT=$$GET1^DIQ(430,IENS,2)  ; AR category
 ..S N6=$G(^PRCA(430,RCBILL,6)),LTRDT1=$P(N6,U),LTRDT2=$P(N6,U,2),LTRDT3=$P(N6,U,3)
 ..I 'PTDONE S ^TMP("RCRFRPT",$J,PNAME,DFN)=SSN_U_$S(SCFLG:SC,1:"No")_U_AAFLG_U_PENFLG_U_HBFLG,PTDONE=1
 ..S ^TMP("RCRFRPT",$J,PNAME,DFN,BILLNO)=RCCAT_U_RCSTAT_U_RCBAL_U_PREPDT_U_LTRDT1_U_LTRDT2_U_LTRDT3_U_TCSPDT_U_DMCDT_U_TOPDT
 ..Q
 .Q
 D PRINT
 K ^TMP("RCRFRPT",$J)
 I '$D(ZTQUEUED) D ^%ZISC
 Q
 ;
PRINT ; print report
 N BDATA,BILLNO,DFN,EXTDT,PDATA,PNAME,SC,Z,Z1
 U IO
 S EXTDT=$$FMTE^XLFDT(DT)
 W !,"Multiple Referral Programs Report^",EXTDT
 W !!,"This report includes debts at multiple referral programs along with debts at treasury where the veteran has Aid and Attendance, Housebound or Pension benefits."
 W !!,"Name^SSN^Bill #^AR Category^Bill Status^Bill Balance^Bill Prepared Date^Letter 1^Letter 2^Letter 3^TCSP Referral Date^DMC Referral Date^TOP Referral Date^SC %^A&A^VA Pension^Housebound Benefits"
 I '$D(^TMP("RCRFRPT",$J)) W !!,"No records found." Q
 S PNAME="" F  S PNAME=$O(^TMP("RCRFRPT",$J,PNAME)) Q:PNAME=""  D
 .S DFN=0 F  S DFN=$O(^TMP("RCRFRPT",$J,PNAME,DFN)) Q:'DFN  D
 ..S PDATA=^TMP("RCRFRPT",$J,PNAME,DFN)
 ..S BILLNO="" F  S BILLNO=$O(^TMP("RCRFRPT",$J,PNAME,DFN,BILLNO)) Q:BILLNO=""  D
 ...S BDATA=^TMP("RCRFRPT",$J,PNAME,DFN,BILLNO)
 ...W !,PNAME,U,$P(PDATA,U),U,BILLNO,U,$P(BDATA,U),U,$P(BDATA,U,2),U,$P(BDATA,U,3),U
 ...F Z=4:1:10 S Z1=$P(BDATA,U,Z) W $S('Z1:"N/A",1:$$FMTE^XLFDT(Z1,"2DZ")),U
 ...S SC=$P(PDATA,U,2) I SC'="No" S SC=SC_"%"
 ...W SC,U,$S($P(PDATA,U,3):"Yes",1:"No"),U,$S($P(PDATA,U,4):"Yes",1:"No"),U,$S($P(PDATA,U,5):"Yes",1:"No")
 ...Q
 ..Q
 .Q
 Q
