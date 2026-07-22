RCRPDR ;EDE/YMG - REPAYMENT PLAN DELINQUENT / DEFAULT LETTER REPORTS; 12/28/2020
 ;;4.5;Accounts Receivable;**378,389,429,442**;Mar 20, 1995;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN(TYPE) ; entry point
 ;
 ; TYPE = 0 for delinquent letter report, 1 for default letter report
 ;
 N CLEARQ,EXCEL,POP,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 K ^TMP("RCRPDR",$J)
 W !!,"Print ",$S(TYPE=1:"Default",1:"Delinquent")," Letter Report",!
 ; export to Excel?
 W !,"Answer Yes to print this report in a Mail-merge compatible format."
 W !!,"If you Answer No, the Statement Account Number for the Debtor will not"  ; PRCA*4.5*389
 W !,"appear on the screen.",!!  ; PRCA*4.5*389
 S EXCEL=$$ASKEXCEL^RCRPRPU() I EXCEL<0 Q
 I 'EXCEL W !!,"This report requires 132 characters",!
 I EXCEL D EXCMSG^RCTCSJR    ; Display Excel display message I EXCEL
 ; ask for device
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) S CLEARQ=$$ASKCLR() Q:CLEARQ<0  D  Q  ; queued report: ask if print queue should be cleared, then queue task
 .S ZTDESC="Repayment Plan "_$S(TYPE=1:"Default",1:"Delinquent")_" Letter Report"
 .S ZTRTN="COMPILE^RCRPDR"
 .S ZTSAVE("TYPE")="",ZTSAVE("EXCEL")="",ZTSAVE("CLEARQ")="",ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! D PAUSE^RCRPRPU
 .Q
 D COMPILE
 Q
 ;
COMPILE ; compile report
 N ACCTNUM,ADDRSTR,CRNTDT,DEBT,DEBTOR,MED,N0,NAME,RPIEN,RPPID,TMP,TMPSTR,XREF
 S XREF=$S(TYPE:"PRTDEF",1:"PRTDEL")
 S RPIEN=0 F  S RPIEN=$O(^RCRP(340.5,XREF,1,RPIEN)) Q:'RPIEN  D
 .S N0=^RCRP(340.5,RPIEN,0)
 .S RPPID=$P(N0,U),DEBTOR=+$P(N0,U,2) Q:DEBTOR'>0
 .S ADDRSTR=$P($$DADD^RCAMADD(DEBTOR,1),U,1,6)     ; ADDRSTR = Str1^Str2^Str3^City^State^ZIP
 .S NAME=$$NAM^RCFN01(DEBTOR) Q:NAME=""  ; debtor name
 .S DEBT=U_$P(NAME,",")  ; needed for ACCT^PRCAAPR1, 2nd piece contains last name of the debtor  PRCA*4.5*389
 .; PRCA*4.5*429
 .S TMP=$P($G(^RCD(340,DEBTOR,0)),U)
 .S MED=1 I $P(TMP,";",2)'="DPT(" S MED=0  ; non-medical debt
 .S ACCTNUM="N/A" I MED S ACCTNUM=$$ACCT^PRCAAPR1($P(TMP,";"))
 .I 'MED S NAME="*"_NAME
 .;
 .S TMPSTR="" S TMPSTR=$$CALC(RPIEN,+$P(N0,U,6)) Q:'+$P(TMPSTR,U)  ; PRCA*4.5*389
 .S ^TMP("RCRPDR",$J,NAME)=ADDRSTR_U_ACCTNUM  ; PRCA*4.5*389
 .S ^TMP("RCRPDR",$J,NAME,RPPID)=TMPSTR
 .S ^TMP("RCRPDR",$J,NAME,RPPID,"IEN")=RPIEN
 .Q
 ;
 D PRINT
 K ^TMP("RCRPDR",$J)
 Q
 ;
PRINT ; print report
 N ACCTNUM,ADDR,AMNT,CNT,DATA,DATA1,EXTDT,LN,NAME,PAGE,RPPID,UPDT
 U IO
 S PAGE=0
 S EXTDT=$$FMTE^XLFDT(DT)
 I EXCEL D
 .W !,"Print ",$S(TYPE=1:"Default",1:"Delinquent")," Letter Report;",EXTDT
 .W !,"Name^Statement Account Number^Street Address^Address 2^Address 3^City^State^Zip Code^RPP ID^Amount Due" W:'TYPE "^Current Through"
 .Q
 I 'EXCEL D
 .I $E(IOST,1,2)["C-",'$D(ZTQUEUED) W @IOF
 .D HDR
 .Q
 I '$D(^TMP("RCRPDR",$J)) D  Q
 .I EXCEL W !!,"No records found." Q
 .W !!,$$CJ^XLFSTR("No records found.",132)
 .Q
 S NAME="" F  S NAME=$O(^TMP("RCRPDR",$J,NAME)) Q:NAME=""  D
 .S RPPID="" F  S RPPID=$O(^TMP("RCRPDR",$J,NAME,RPPID)) Q:RPPID=""  D
 ..S DATA1=^TMP("RCRPDR",$J,NAME),ADDR=$P(DATA1,U,1,6),ACCTNUM=$P(DATA1,U,7)  ; PRCA*4.5*389
 ..S DATA=^TMP("RCRPDR",$J,NAME,RPPID)
 ..S AMNT=$FN($P(DATA,U),"",2)
 ..I 'TYPE S UPDT=$$FMTE^XLFDT($P(DATA,U,2),"5DZ")
 ..I EXCEL D  Q
 ...W !,NAME,U,ACCTNUM,U,$P(ADDR,U),U,$P(ADDR,U,2),U,$P(ADDR,U,3),U,$P(ADDR,U,4),U,$P(ADDR,U,5),U,$P(ADDR,U,6),U,RPPID,U,AMNT  ; PRCA*4.5*389
 ...I 'TYPE W U,UPDT  ; PRCA*4.5*389
 ...Q
 ..S LN=LN+1
 ..W !,$E(NAME,1,26)
 ..W ?28,$E($P(ADDR,U)_" "_$P(ADDR,U,2)_" "_$P(ADDR,U,3)_", "_$P(ADDR,U,4)_", "_$P(ADDR,U,5)_" "_$P(ADDR,U,6),1,56)
 ..W ?86,RPPID,?107,AMNT W:'TYPE ?119,UPDT  ; PRCA*4.5*389
 ..I LN>(IOSL-4) D HDR
 ..Q
 .Q
 ; if not queued, clear print queue if necessary
 I '$D(ZTQUEUED),EXCEL W ! S CLEARQ=$$ASKCLR() I CLEARQ=1 D
 .; clear print flag in file 340.5
 .S NAME="" F  S NAME=$O(^TMP("RCRPDR",$J,NAME)) Q:NAME=""  D
 ..S RPPID="" F  S RPPID=$O(^TMP("RCRPDR",$J,NAME,RPPID)) Q:RPPID=""  D CLRPRNT(^TMP("RCRPDR",$J,NAME,RPPID,"IEN"),TYPE)
 ..Q
 .Q
 Q
 ;
HDR ; print header
 I PAGE>0,'$D(ZTQUEUED) D PAUSE^RCRPRPU
 W @IOF
 S PAGE=PAGE+1,LN=4
 W !,"Print ",$S(TYPE=1:"Default",1:"Delinquent")," Letter Report",?66,EXTDT,?120,"Page: ",PAGE
 W !!,"* Indicates a non-medical debt repayment plan"
 W !!,?11,"Name",?53,"Address",?91,"RPP ID",?105,"Amount Due" W:'TYPE ?117,"Current Through"  ; PRCA*4.5*389
 W ! D DASH^RCRPRPU(132)
 Q
 ;
CALC(RPIEN,MAMNT) ; calculate amount due and "current through" date
 ;
 ; RPIEN - file 340.5 ien
 ; MAMNT - monthly amount (340.5/.06)
 ;
 ; returns amount due ^ "current through" date, or "" if no missing payments were found
 ;
 N CBAL,CNT,LSTDT,N0,RPDT,TOTAL,UPDT,Z
 I $G(MAMNT)'>0 Q ""
 S LSTDT=$O(^RCRP(340.5,RPIEN,2,"B",""),-1) ; last due date in the schedule  PRCA*4.5*429
 ; loop backwards from today's date, count entries with no payment and no forbearance
 S CNT=0,RPDT=DT F  S RPDT=$O(^RCRP(340.5,RPIEN,2,"B",RPDT),-1) Q:'RPDT  D
 .S Z=$O(^RCRP(340.5,RPIEN,2,"B",RPDT,"")) Q:'Z
 .S N0=^RCRP(340.5,RPIEN,2,Z,0) I +$P(N0,U,2)=0,+$P(N0,U,3)=0 S CNT=CNT+1
 .Q
 I CNT=0 Q ""  ; no missing payments found
 S UPDT=LSTDT I DT'>LSTDT D  ; PRCA*4.5*429
 .S CNT=CNT+1  ; add upcoming payment
 .S UPDT=$O(^RCRP(340.5,RPIEN,2,"B",DT))  ; upcoming payment date
 .; if today's date is between 21st and 28th, add 2nd upcoming payment and go to the next upcoming payment date
 .I DT'>$O(^RCRP(340.5,RPIEN,2,"B",LSTDT),-1) S Z=$E(DT,6,7) I Z>21,Z<28 S CNT=CNT+1,UPDT=$O(^RCRP(340.5,RPIEN,2,"B",UPDT))
 .Q
 S TOTAL=MAMNT*CNT ; total amount owed for missed payments
 S CBAL=$$CBAL^RCRPU3(RPIEN)  ; PRCA*4.5*442
 Q $S(TOTAL>CBAL:CBAL,1:TOTAL)_U_UPDT  ; PRCA*4.5*442
 ;
ASKCLR() ; display "clear print queue?" prompt
 ;
 ; returns 1 for Yes, 0 for No, -1 for no selection
 ;
 ;Ask if the user wishes to clear the queue
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Clear the print queue after printing? (Y/N)"
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q:+Y'=1 0
 ;
 ;Confirm that the user wishes to clear the queue
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you sure you wish to clear the queue?  If you do, the data in this report will be lost. (Y/N)"
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q Y
 ;
CLRPRNT(RPIEN,TYPE) ; clear print delinquent / print default flag for a given RPP
 ;
 ; RPIEN - repayment plan ien (file 340.5)
 ; TYPE - 0 for print delinquent? field (340.5/1.03), 1 for print default? field (340.5/1.02)
 ;
 N FDA,FLD
 I RPIEN'>0 Q
 S FLD=$S(TYPE:1.02,1:1.03)
 L +^RCRP(340.5,RPIEN):5 I '$T Q
 S FDA(340.5,RPIEN_",",FLD)=0
 D FILE^DIE("","FDA")
 ; update audit log
 D UPDAUDIT^RCRPU2(RPIEN,DT,"E",$S(TYPE:"DF",1:"DL"))
 L -^RCRP(340.5,RPIEN)
 Q
