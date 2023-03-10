RCRPINQ ;EDE/YMG - REPAYMENT PLAN INQUIRY; 12/10/2020
 ;;4.5;Accounts Receivable;**377,381,388,378**;Mar 20, 1995;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 N POP,RPIEN,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 N IOBOFF,IOBON,IORVON,IORVOFF,X,RCDONE
 F  D  Q:RPIEN<0
 .S RPIEN=$$SELRPP^RCRPU1() I RPIEN=-1 Q
 .I "^6^7^8^"[(U_$P($G(^RCRP(340.5,RPIEN,0)),U,7)_U) D
 ..S X="IOBON;IORVON;IOBOFF;IORVOFF" D ENDR^%ZISS
 ..W !!,IOBON,IORVON,$$CJ^XLFSTR("*** WARNING: YOU HAVE SELECTED A CLOSED REPAYMENT PLAN ***",80),IORVOFF,IOBOFF,!!
 ..Q
 .; ask for device
 .K IOP,IO("Q")
 .S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 .I $D(IO("Q")) D  Q  ; queued output
 ..S ZTDESC="Repayment Plan Inquiry",ZTRTN="PRINT^RCRPINQ"
 ..S ZTSAVE("RPIEN")="",ZTSAVE("ZTREQ")="@"
 ..D ^%ZTLOAD,HOME^%ZIS
 ..I $G(ZTSK) W !!,"Inquiry output has started with task# ",ZTSK,".",! D PAUSE^RCRPRPU
 ..Q
 .D PRINT
 .Q
 Q
 ;
PRINT ; display repayment plan data
 ;
 ; RPIEN - ien in file 340.5
 ;
 N LN
 S LN=0
 S LN=$$PRTHDR(RPIEN,LN) Q:'LN      ; print header
 S LN=$$PRTBILLS(RPIEN,LN) Q:'LN  ; print the list of bills in the plan
 S LN=$$PRTSCHED(RPIEN,LN) Q:'LN  ; print the payment schedule
 S LN=$$PRTFORB(RPIEN,LN) Q:'LN   ; print forbearances
 S LN=$$PRTPMTS(RPIEN,LN) Q:'LN   ; print payments
 S LN=$$PRTAUDT(RPIEN,LN) Q:'LN   ; print audit log
 ;
 S LN=$$WRTLN("",LN) Q:'LN
 S LN=$$WRTLN($$CJ^XLFSTR("End of Inquiry",80),LN) Q:'LN
 I $E(IOST,1,2)["C-",'$D(ZTQUEUED) W ! D PAUSE^RCRPRPU
 Q
 ;
GETDOB(DEBTOR) ; get date of birth
 ;
 ; DEBTOR - file 340 ien
 ;
 ; returns DOB (external format) from either file 2 or file 200, or "" if DOB can't be found
 ;
 N DFN,RES,VADM,Z,Z1,Z2
 S RES=""
 I $G(DEBTOR)'>0 Q RES
 S Z=$P($G(^RCD(340,DEBTOR,0)),U),Z1=$P(Z,";"),Z2=$P(Z,";",2)
 I Z2["DPT" S DFN=Z1 D DEM^VADPT S RES=$P(VADM(3),U,2)
 I Z2["VA(200" S RES=$$GET1^DIQ(200,Z1_",",5)
 Q RES
 ;
FMTPHONE(PHONE) ; format phone number for display
 ;
 ; PHONE -  phone # to format (numeric)
 ;
 ; returns formatted phone #
 ;
 N RES
 S RES=PHONE
 I $L(PHONE)=7 S RES=$E(PHONE,1,3)_"-"_$E(PHONE,4,7)
 I $L(PHONE)=10 S RES="("_$E(PHONE,1,3)_")"_$E(PHONE,4,6)_"-"_$E(PHONE,7,10)
 I $L(PHONE)=11 S RES=$E(PHONE)_"-"_"("_$E(PHONE,1,3)_")"_$E(PHONE,4,6)_"-"_$E(PHONE,7,10)
 Q RES
 ;
PMNTS(RPIEN) ; calculate the sum of payments made for a given RPP
 ;
 ; RPIEN - file 340.5 ien
 ;
 ; returns sum of payments in sub-file 340.53
 ;
 N PMDT,PMIEN,RES
 S RES=0
 S PMDT=0 F  S PMDT=$O(^RCRP(340.5,RPIEN,3,"B",PMDT)) Q:'PMDT  D
 .S PMIEN="" F  S PMIEN=+$O(^RCRP(340.5,RPIEN,3,"B",PMDT,PMIEN)) Q:'PMIEN  S RES=RES+$P($G(^RCRP(340.5,RPIEN,3,PMIEN,0)),U,2)
 .Q
 Q RES
 ;
WRTLN(STR,LN) ; write line
 ;
 ; STR - line to write
 ; LN  - current line #
 ;
 ; returns next line # or 0 for user exit
 ;
 W !,STR S LN=LN+1
 I $E(IOST,1,2)["C-",'$D(ZTQUEUED),LN>(IOSL-3) S LN=$$NEWPG()
 Q LN
 ;
NEWPG() ; print new page
 ;
 ; returns next line # or 0 for user exit
 ;
 I '$$ASKCONT^RCRPU2() Q 0
 W @IOF
 Q 1
 ;
PRTHDR(RPIEN,LN) ; display header
 ;
 ; RPIEN is defined in tag EN
 ;
 ; returns next line # or 0 for user exit
 ;
 N ADDRSTR,CBAL,DEBDOB,DEBPHN,DEBSSN,DEBTOR,N0,RAMNT
 S N0=$G(^RCRP(340.5,RPIEN,0)) ; 0-node in file 340.5
 S DEBTOR=$P(N0,U,2)
 S ADDRSTR=$$DADD^RCAMADD(DEBTOR,1)  ; ADDRSTR = Str1^Str2^Str3^City^State^ZIP^Telephone^Forein Country Code
 U IO
 I $E(IOST,1,2)["C-" W @IOF
 S DEBSSN=$$SSN^RCFN01(DEBTOR),DEBDOB=$$GETDOB^RCRPINQ(DEBTOR),DEBPHN=+$P(ADDRSTR,U,7)
 W !!,"Debtor: ",$$NAM^RCFN01(DEBTOR)
 W ?40,"SSN/TIN: ",$S(DEBSSN>0:$E(DEBSSN,1,3)_"-"_$E(DEBSSN,4,5)_"-"_$E(DEBSSN,6,9),1:"N/A")
 W ?64,"DOB: ",$S(DEBDOB="":"N/A",1:DEBDOB)
 W !,"Address: ",$P(ADDRSTR,U)," ",$P(ADDRSTR,U,2)," ",$P(ADDRSTR,U,3),", ",$P(ADDRSTR,U,4),", ",$P(ADDRSTR,U,5)," ",$P(ADDRSTR,U,6)
 W !,"Phone: ",$S(DEBPHN>0:$$FMTPHONE^RCRPINQ(DEBPHN),1:"N/A"),!
 W !,"Plan #: ",$P(N0,U),?28,"Status: ",$$EXTERNAL^DILFD(340.5,.07,"",$P(N0,U,7)),?49,"Last status date: ",$$FMTE^XLFDT($P(N0,U,8),"5DZ"),!
 S CBAL=$P(N0,U,11)-$$PMNTS^RCRPINQ(RPIEN),RAMNT=$P(N0,U,6)
 W !,?2,"Current balance: $",$FN(CBAL,"",2),?37,"Number of payments remaining: ",CBAL\RAMNT+$S(CBAL#RAMNT:1,1:0)
 W !,?1,"Orig amount owed: $",$FN($P(N0,U,13),"",2),?38,"Original number of payments: ",$P(N0,U,14)
 W !,"Total amount owed: $",$FN($P(N0,U,11),"",2),?41,"Total number of payments: ",$P(N0,U,5)
 W !,?1,"Repayment amount: $",$FN(RAMNT,"",2),?47,"Auto-add New Bills: ",$$GET1^DIQ(340.5,RPIEN_",",.12,"E"),!
 W !,?8,"Plan date: ",$$FMTE^XLFDT($P(N0,U,3),"5DZ"),?43,"First Payment Due Date: ",$$FMTE^XLFDT($P(N0,U,4),"5DZ"),!
 ;
 S LN=14
 Q LN
 ;
PRTSCHED(RPIEN,LN) ; Print the schedule
 ;
 ; LN - current line #
 ;
 ; RPIEN is defined in tag EN
 ;
 ; returns next line # or 0 for user exit
 ;
 N CNT,TMP,TMPDT,TMPIEN
 S LN=$$WRTLN($$CJ^XLFSTR("Plan Schedule",80),LN) Q:'LN 0
 S LN=$$WRTLN($$LJ^XLFSTR("",80,"-"),LN) Q:'LN 0
 S LN=$$WRTLN("   Due Date    Paid?   Due Date    Paid?   Due Date    Paid?",LN) Q:'LN 0
 S LN=$$WRTLN($$LJ^XLFSTR("",80,"-"),LN) Q:'LN 0
 S CNT=0,TMPDT=0 F  S TMPDT=$O(^RCRP(340.5,RPIEN,2,"B",TMPDT)) Q:'TMPDT  D  Q:'LN
 .S TMPIEN="" F  S TMPIEN=+$O(^RCRP(340.5,RPIEN,2,"B",TMPDT,TMPIEN)) Q:'TMPIEN  D  Q:'LN
 ..S TMP=$G(^RCRP(340.5,RPIEN,2,TMPIEN,0)) Q:TMP=""
 ..I CNT#3=0 S LN=$$WRTLN("",LN) Q:'LN
 ..W:CNT#3=0 ?2 W:CNT#3=1 ?22 W:CNT#3=2 ?42 W $$FMTE^XLFDT($P(TMP,U),"5DZ")
 ..W:CNT#3=0 ?17 W:CNT#3=1 ?37 W:CNT#3=2 ?57 W $S($P(TMP,U,3):"F",$P(TMP,U,2):"Y",1:"N")
 ..S CNT=CNT+1
 ..Q
 .Q
 Q:'LN 0
 I $E(IOST,1,2)["C-",'$D(ZTQUEUED) D  Q:'LN 0
 .I LN>(IOSL-6) S LN=$$NEWPG() Q
 .S LN=$$WRTLN("",LN)
 .Q
 Q LN
 ;
PRTFORB(RPIEN,LN) ; Print the forbearances previously granted
 ;
 ; LN - current line #
 ;
 ; RPIEN is defined in tag EN
 ;
 ; returns next line # or 0 for user exit
 ;
 N TMP,TMPDT,TMPIEN,RCUSER
 S LN=$$WRTLN($$CJ^XLFSTR("Forbearances",80),LN) Q:'LN 0
 S LN=$$WRTLN($$LJ^XLFSTR("",80,"-"),LN) Q:'LN 0
 S LN=$$WRTLN("   Date      User             Month/Year Forborne            Month/Year Added",LN) Q:'LN 0
 S LN=$$WRTLN($$LJ^XLFSTR("",80,"-"),LN) Q:'LN 0
 S TMPDT=0 F  S TMPDT=$O(^RCRP(340.5,RPIEN,5,"B",TMPDT)) Q:'TMPDT  D  Q:'LN
 .S TMPIEN="" F  S TMPIEN=+$O(^RCRP(340.5,RPIEN,5,"B",TMPDT,TMPIEN)) Q:'TMPIEN  D  Q:'LN
 ..S TMP=$G(^RCRP(340.5,RPIEN,5,TMPIEN,0)) Q:TMP=""
 ..S RCUSER=$$GET1^DIQ(340.55,TMPIEN_","_RPIEN_",","3","E")
 ..S LN=$$WRTLN($$LJ^XLFSTR($$FMTE^XLFDT($P(TMP,U),"5DZ"),13)_$$LJ^XLFSTR($E(RCUSER,1,20),22)_$$LJ^XLFSTR($$FMTE^XLFDT($P(TMP,U,2),"1DZ"),29)_$$FMTE^XLFDT($P(TMP,U,3),"1DZ"),LN)
 ..Q
 .Q
 Q:'LN 0
 I $E(IOST,1,2)["C-",'$D(ZTQUEUED) D  Q:'LN 0
 .I LN>(IOSL-6) S LN=$$NEWPG() Q
 .S LN=$$WRTLN("",LN)
 .Q
 Q LN
 ;
PRTBILLS(RPIEN,LN) ; print list of bills
 ;
 ; LN - current line #
 ;
 ; returns next line # or 0 for user exit
 S:+$G(LN)=0 LN=1
 ;
 N BILL,BSTAT,BCAT,BAMNT
 S LN=$$WRTLN($$CJ^XLFSTR("List of Bills in Plan",80),LN) Q:'LN 0
 S LN=$$WRTLN($$LJ^XLFSTR("",80,"-"),LN) Q:'LN 0
 S LN=$$WRTLN("Bill No.            Bill Status          Category          Current Balance",LN) Q:'LN 0
 S LN=$$WRTLN($$LJ^XLFSTR("",80,"-"),LN) Q:'LN 0
 S LN=$$WRTLN("",LN) Q:'LN 0
 ;
 S BILL=0 F  S BILL=$O(^RCRP(340.5,RPIEN,6,"B",BILL)) Q:'BILL  D  Q:'LN 
 .S BSTAT=$$GET1^DIQ(430,BILL_",",8)
 .S BCAT=$$GET1^DIQ(430,BILL_",",2)
 .S BAMNT=$S(BSTAT="ACTIVE":"$"_$FN($$BALANCE^RCRPRPU(BILL),"",2),1:"")
 .S LN=$$WRTLN($$LJ^XLFSTR($P(^PRCA(430,BILL,0),U),23)_$$LJ^XLFSTR($E(BSTAT,1,16),18)_$$LJ^XLFSTR($E(BCAT,1,14),22)_BAMNT,LN)
 .Q
 Q:'LN 0
 I $E(IOST,1,2)["C-",'$D(ZTQUEUED) D  Q:'LN 0
 .I LN>(IOSL-6) S LN=$$NEWPG() Q
 .S LN=$$WRTLN("",LN)
 .Q
 Q LN
 ;
PRTPMTS(RPIEN,LN) ; print payments
 ;
 ; LN - current line #
 ;
 ; RPIEN is defined in tag EN
 ;
 ; returns next line # or 0 for user exit
 ;
 N CNT,TMP,TMPDT,TMPIEN
 S LN=$$WRTLN($$CJ^XLFSTR("Payments Applied to Plan",80),LN) Q:'LN 0
 S LN=$$WRTLN($$LJ^XLFSTR("",80,"-"),LN) Q:'LN 0
 S LN=$$WRTLN("   Date         Amount             Date         Amount",LN) Q:'LN 0
 S LN=$$WRTLN($$LJ^XLFSTR("",80,"-"),LN) Q:'LN 0
 S CNT=0,TMPDT=0 F  S TMPDT=$O(^RCRP(340.5,RPIEN,3,"B",TMPDT)) Q:'TMPDT  D  Q:'LN
 .S TMPIEN="" F  S TMPIEN=+$O(^RCRP(340.5,RPIEN,3,"B",TMPDT,TMPIEN)) Q:'TMPIEN  D  Q:'LN
 ..S TMP=$G(^RCRP(340.5,RPIEN,3,TMPIEN,0)) Q:TMP=""
 ..I CNT#2=0 S LN=$$WRTLN("",LN) Q:'LN
 ..W:CNT#2=1 ?32 W $$FMTE^XLFDT($P(TMP,U),"5DZ")
 ..W:CNT#2=0 ?14 W:CNT#2=1 ?46 W $$CJ^XLFSTR("$"_$FN($P(TMP,U,2),"",2),10)
 ..S CNT=CNT+1
 ..Q
 .Q
 Q:'LN 0
 I $E(IOST,1,2)["C-",'$D(ZTQUEUED) D  Q:'LN 0
 .I LN>(IOSL-6) S LN=$$NEWPG() Q
 .S LN=$$WRTLN("",LN)
 .Q
 Q LN
 ;
PRTAUDT(RPIEN,LN) ; print audit log
 ;
 ; LN - current line #
 ;
 ; RPIEN is defined in tag EN
 ;
 ; returns next line # or 0 for user exit
 ;
 N TMP,TMPDT,TMPIEN,RCRSN,RCRSNCD,RCRSNTX
 S LN=$$WRTLN($$CJ^XLFSTR("Audit Log",80),LN) Q:'LN 0
 S LN=$$WRTLN($$LJ^XLFSTR("",80,"-"),LN) Q:'LN 0
 S LN=$$WRTLN("   Date            User                 Type         Comment",LN) Q:'LN 0
 S LN=$$WRTLN($$LJ^XLFSTR("",80,"-"),LN) Q:'LN 0
 S TMPDT=0 F  S TMPDT=$O(^RCRP(340.5,RPIEN,4,"B",TMPDT)) Q:'TMPDT  D  Q:'LN
 .S TMPIEN="" F  S TMPIEN=+$O(^RCRP(340.5,RPIEN,4,"B",TMPDT,TMPIEN)) Q:'TMPIEN  D  Q:'LN
 ..S TMP=$G(^RCRP(340.5,RPIEN,4,TMPIEN,0)) Q:TMP=""
 ..S RCRSNCD=$P(TMP,U,4),RCRSNTX=$P(TMP,U,5)
 ..S RCRSN=$S(RCRSNCD'="":$$EXTERNAL^DILFD(340.54,3,"",RCRSNCD),1:RCRSNTX)
 ..S LN=$$WRTLN($$LJ^XLFSTR($$FMTE^XLFDT($P(TMP,U),"5DZ"),12)_$$LJ^XLFSTR($E($$EXTERNAL^DILFD(340.54,2,"",$P(TMP,U,3)),1,30),28)_$$LJ^XLFSTR($$EXTERNAL^DILFD(340.54,1,"",$P(TMP,U,2)),13)_RCRSN,LN)
 ..Q
 .Q
 I $E(IOST,1,2)["C-",'$D(ZTQUEUED),LN>(IOSL-3) S LN=$$NEWPG()
 Q LN
