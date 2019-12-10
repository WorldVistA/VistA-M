RCTCSP2 ;ALBANY/BDB - CROSS-SERVICING TRANSMISSION ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**301,315,339,340,344,350**;Mar 20, 1995;Build 66
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*344 Added total record control (>50) to 5B transaction
 ;             handler to insure mail messages stay within a
 ;             record count of 50 transactions.
 ;
 Q
 ;
COMPILE ;
 N RCMSG,BCNTR,REC,RECC,AMOUNT,RCNTR,ACTION,SEQ
 S BCNTR=0,REC=0,RECC=0,AMOUNT=0,SEQ=0
 F  S BCNTR=$O(^XTMP("RCTCSPD",$J,BCNTR)) Q:+BCNTR'>0  D
 .I REC>50 D
 ..D TRAILER^RCTCSP1A
 ..D AITCMSG
 ..S REC=0,RECC=0
 ..Q
 .S ACTION="" F  S ACTION=$O(^XTMP("RCTCSPD",$J,BCNTR,ACTION)) Q:ACTION=""  D
 ..I REC=0 D HEADER^RCTCSP1A
 ..F RCNTR=1,2,"2A","2C",3 I $D(^XTMP("RCTCSPD",$J,BCNTR,ACTION,RCNTR)) D
 ...S REC=REC+1
 ...S RECC=RECC+1 ;record count for 'c' records on trailer record
 ...S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(^XTMP("RCTCSPD",$J,BCNTR,ACTION,RCNTR),1,225)_$C(94)
 ...S REC=REC+1
 ...S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(^XTMP("RCTCSPD",$J,BCNTR,ACTION,RCNTR),226,999)_$C(126)
 ...I $E(^XTMP("RCTCSPD",$J,BCNTR,ACTION,RCNTR),2)="1" S AMOUNT=AMOUNT+$E(^(RCNTR),91,104)
 ...Q
 ..I $D(^XTMP("RCTCSPD",$J,BCNTR,ACTION,"5B")) D
 ...N TRNNUM
 ...S TRNNUM=0
 ...F  S TRNNUM=$O(^XTMP("RCTCSPD",$J,BCNTR,ACTION,"5B",TRNNUM)) Q:TRNNUM'?1N.N  D
 ....I REC>50 D    ;PRCA*4.5*344
 .....D TRAILER^RCTCSP1A
 .....D AITCMSG
 .....S REC=0,RECC=0
 .....Q
 ....I REC=0 D HEADER^RCTCSP1A   ;PRCA*4.5*344
 ....S REC=REC+1
 ....S RECC=RECC+1 ;record count for 'c' records on trailer record
 ....S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(^XTMP("RCTCSPD",$J,BCNTR,ACTION,"5B",TRNNUM),1,225)_$C(94)
 ....S REC=REC+1
 ....S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(^XTMP("RCTCSPD",$J,BCNTR,ACTION,"5B",TRNNUM),226,999)_$C(126)
 ....S AMOUNT=AMOUNT+$TR($E(^XTMP("RCTCSPD",$J,BCNTR,ACTION,"5B",TRNNUM),173,186),"-")
 ....Q
 ...Q
 ..Q
 .Q
 D TRAILER^RCTCSP1A
 D AITCMSG
 D USRMSG
 Q
 ;
RCLLCHK(BILL) ;
 N TOTAL
 I $P(B15,U,7) Q 0 ;check stop tcsp referral flag
 I $P(B15,U,2),'$P(B15,U,3) D  ;recall bill
 .N ACTION,BILLCSL
 .S ACTION="L"
 .S $P(^PRCA(430,BILL,15),U,1)="" ;clear the date referred
 .S $P(^PRCA(430,BILL,15),U,3)=DT ;set the recall date
 .S $P(^PRCA(430,BILL,15),U,5)=$$GET1^DIQ(430,BILL,11) ;set the recall amount to the current amount
 .S B15=^PRCA(430,BILL,15)
 .S BILLCSL=BILL ;last cs bill
 .D REC1^RCTCSPD
 .K ^PRCA(430,"TCSP",BILL) ;set the bill to not sent to cross-servicing
 .D RCLL^RCTCSPD4 ; set bill recall non-financial transaction PRCA*4.5*315
 ;
 ;recall bill if total <$25
 S TOTAL=$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 I TOTAL<25 D  Q 0
 .N X1,X2,P366DT,X,PRCAEN,I,RECALL
 .S RECALL=0
 .S X1=DT,X2=-366 D C^%DTC S P366DT=X
 .S PRCAEN=0 F I=0:0 S PRCAEN=$O(^PRCA(433,"C",BILL,PRCAEN)) Q:'PRCAEN  S:$P($G(^PRCA(433,PRCAEN,1)),U,1)>P366DT RECALL=1
 .I RECALL=0 D  Q
 ..S ACTION="L"
 ..S $P(^PRCA(430,BILL,15),U,1)="" ;clear the date referred
 ..S $P(^PRCA(430,BILL,15),U,2)=1 ;set the recall flag
 ..S $P(^PRCA(430,BILL,15),U,3)=DT ;set the recall date
 ..S $P(^PRCA(430,BILL,15),U,4)="07" ;set the recall reason
 ..S $P(^PRCA(430,BILL,15),U,5)=$P($G(^PRCA(430,BILL,16)),U,10) ;set the recall amount to the current tcsp amount
 ..S $P(^PRCA(430,BILL,15),U,7)=1 ;set the stop flag
 ..S $P(^PRCA(430,BILL,15),U,8)=DT ;set the stop date
 ..S $P(^PRCA(430,BILL,15),U,9)="O" ;set the stop date
 ..S $P(^PRCA(430,BILL,15),U,10)="AUTORECALL <$25" ;set the stop reason
 ..S B15=^PRCA(430,BILL,15)
 ..D REC1^RCTCSPD,RCLL^RCTCSPD4 ; set CS Bill Recall transaction PRCA*4.5*315
 ..K ^PRCA(430,"TCSP",BILL) ;set the bill to not sent to cross-servicing
 ..S $P(^PRCA(430,BILL,19),U,10)=1 ;stop interest admin calc
 ..S B19=$G(^PRCA(430,BILL,19))
 ..Q
 .Q
 Q 0
 ;
RCRPRT ;Reconciliation report
 N ZTDESC,ZTRTN,POP,%ZIS,DTFRMTO,DTFRM,DTTO,PROMPT,EXCEL,DATE
 S DTFRMTO=$$DTFRMTO Q:'DTFRMTO  ;Get date range as per PRCA*4.5*315
 S (DATE,DTFRM)=$$FMADD^XLFDT(+$P(DTFRMTO,U,2),-1),DTTO=$P(DTFRMTO,U,3),CURDT=0
 S EXCEL=0,PROMPT="CAPTURE Report data to an Excel Document",DIR(0)="Y",DIR("?")="^D HEXC^RCTCSJR"
 S EXCEL=$$SELECT^RCTCSJR(PROMPT,"NO") I "01"'[EXCEL S STOP=1 Q
 I EXCEL=1 D EXCMSG^RCTCSJR ; Display Excel display message
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ;
 .S ZTSAVE("DTFRMTO")="",ZTSAVE("EXCEL")=""
 .S ZTRTN="RCRPRTP^RCTCSP2",ZTDESC="RECONCILIATION REPORT"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 .Q
 ;
RCRPRTP ;print the - reconciliation report, call to build array of bills returned
 U IO
 N DASH,PAGE,DBTR,DBTRN,RCOUT,CURDT,RC18,RCRTCD,BILLIEN,DATE
 K ^TMP("RCTCSP2",$J)
 S (DATE,DTFRM)=$$FMADD^XLFDT(+$P(DTFRMTO,U,2),-1),DTTO=$P(DTFRMTO,U,3),CURDT=0
 F  S DATE=$O(^PRCA(430,"AN",DATE)),BILLIEN=0 Q:DATE=""!(DATE>DTTO)  D  ;Use new AN xref PRCA*4.5*315
 . F  S BILLIEN=$O(^PRCA(430,"AN",DATE,BILLIEN)) Q:BILLIEN=""  D
 ..I +$P($G(^PRCA(430,BILLIEN,30)),U,1)=0 Q   ;Returned date is NULL
 ..S DBTR=$P($G(^PRCA(430,BILLIEN,0)),U,9),DBTRN=$$GET1^DIQ(430,BILLIEN,9)
 ..Q:DBTRN']""
 ..S ^TMP("RCTCSP2",$J,DBTRN,DBTR)=""   ; store scratch by Debtor Name, Debtor IEN
 S PAGE=0,RCOUT=0
 S DASH="",$P(DASH,"-",78)=""
 D RCRPRTH2
 ;
 ;New fields added in PRCA*4.5*315:
 ;AMTREF:(#310) REC ORIGINAL TCSP AMOUNT stored in ^PRCA(430,BILL,30), piece 10
 ;CORDT:(#312) REC TCSP RECALL EFF. DATE stored in ^PRCA(430,BILL,30), piece 12
 ;DTREJ: (#172) REJECT DATE (multiple)
 ;See RCTCSPRS for more information on these fields
 ;
 S DBTRN=0
 F  S DBTRN=$O(^TMP("RCTCSP2",$J,DBTRN)) Q:DBTRN=""!RCOUT  S DBTR=0 F  S DBTR=$O(^TMP("RCTCSP2",$J,DBTRN,DBTR)) Q:'DBTR!RCOUT  D  Q:RCOUT
 .S BILL=0
 .F  S BILL=$O(^PRCA(430,"C",DBTR,BILL)) Q:BILL'?1N.N  D  Q:RCOUT
 ..N B0,B30,AMTREF,DTRET,CORDT,SSN
 ..S B0=$G(^PRCA(430,BILL,0)),B30=$G(^PRCA(430,BILL,30))
 ..S AMTREF=$J($P(B30,U,10),8,2)
 ..S DEBTOR=$P(B0,U,9),SSN=$$SSN^RCFN01($P(^RCD(340,DEBTOR,0),"^")),SSN=$S(SSN=-1:"",1:$E(DBTRN))_$E(SSN,6,9)
 ..S CORDT=$$FMTE^XLFDT($P(B30,U,12),"2Z"),DTRET=""
 ..S DTRET=$P(B30,U) I DTRET S DTRET=$$FMTE^XLFDT(DTRET,"2Z")
 ..I +$P(B30,U,1)=0 Q
 ..I 'EXCEL W $E(DBTRN,1,16)
 ..I EXCEL W !,$E(DBTRN,1,14)
 ..I 'EXCEL W ?17,$P(B0,U,1),?29,SSN,?35,AMTREF,?44,CORDT,?53,DTRET,!
 ..I EXCEL W U_$P($P(B0,U,1),"-",2)_U_SSN_U_AMTREF_U_CORDT_U_DTRET
 ..S RCRTCD=$P(B30,U,2)
 ..I 'EXCEL D
 ...D  ;Display return reason code
 ....I RCRTCD="" W ?6,"NO RETURN REASON CODE",! Q
 ....W:$D(^PRCA(430.5,RCRTCD,0)) ?6,$P(^PRCA(430.5,RCRTCD,0),U,2),!
 ....W:'$D(^PRCA(430.5,RCRTCD,0)) ?6,"UNKNOWN RETURN REASON CODE: ",RCRTCD,!
 ....W:RCRTCD=14 ?7,"Compromise, Please write this bill off by the manual process",!,?8,"Amount (not collected): "_$J($P(B30,U,4),9,2),!  ;Added PRCA*4.5*315
 ....W:RCRTCD=2 ?8,"Date of Death:  "_$$FMTE^XLFDT($P(B30,U,7),"2Z"),!  ;date type (as per PRCA*4.5*315)
 ....W:RCRTCD=3 ?8,"Bankruptcy Date:  "_$$FMTE^XLFDT($P(B30,U,6),"2Z"),!
 ...W:+$P(B30,U,8) ?6,"Date of Dissolution:  "_$$FMTE^XLFDT($P(B30,U,8),"2Z"),!
 ..I EXCEL D
 ...I RCRTCD=14 W U_$P(^PRCA(430.5,RCRTCD,0),U,2)_U_"AMT NOT COLL"_U_$P(B30,U,4)
 ...I $P(B30,U,3)="Y" W U_"CP"_U_$J($P(B30,U,4),4,2) Q
 ...I RCRTCD=2 W U_$P(^PRCA(430.5,RCRTCD,0),U,2)_" "_$$FMTE^XLFDT($P(B30,U,7),"2Z") Q
 ...I RCRTCD=3 W U_$P(^PRCA(430.5,RCRTCD,0),U,2)_" "_$$FMTE^XLFDT($P(B30,U,6),"2Z") Q
 ...I RCRTCD]"" W U_$S($D(^PRCA(430.5,RCRTCD,0)):$$GET1^DIQ(430.5,RCRTCD,1),1:RCRTCD) Q
 ..;check for end of page here, if necessary form feed and print header
 ..I 'EXCEL W ! I ($Y+5)>IOSL D
 ...I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S RCOUT=1 K X,Y,DIRUT,DTOUT,DUOUT,DIROUT Q
 ...D RCRPRTH2
 I $E(IOST,1,2)="C-" R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 K IOP,%ZIS,ZTQUEUED
 K ^TMP("RCTCSP2",$J)
 Q
 ;
RCRPRTH2 ;header for reconciliation report print report 2
 W @IOF
 S PAGE=PAGE+1
 I 'EXCEL W "PAGE "_PAGE,?12,"RECONCILIATION REPORT ",?65,$$FMTE^XLFDT(DT,"2Z")
 I 'EXCEL D  Q
 .W !,DASH
 .W !,"DEBTOR",?17,"BILL NO.",?29,"Pt ID",?35,"Amount",?44,"Recall",?53,"Date",!
 .W ?35,"Refer",?44,"Eff. Dt",?53,"Return"
 .W !,"----------------",?17,"-----------",?29,"-----",?35,"--------",?44,"--------",?53,"--------",!
 ;EXCEL FORMAT
 W "PAGE "_PAGE_U_"RECONCILIATION REPORT "_U_$$FMTE^XLFDT(DT,"2Z")
 W !,"DEBTOR"_U_"BILL #"_U_"PT ID"_U_"AMT REF"_U_"DT RCL"_U_"DT RET"_U_"COMMENT"
 Q
 ;
AITCMSG ;
 N XMY,XMDUZ,XMSUB,XMTEXT,CNTLID,SYSTYP
 S SYSTYP=$$PROD^XUPROD(1)
 S CNTLID=$$JD^RCTCSP1A()_$$RJZF^RCTCSP1(SEQ,4)
 S XMDUZ="AR PACKAGE"
 I SYSTYP S XMY("XXX@Q-TPC.DOMAIN.EXT")=""
 I 'SYSTYP S XMY("XXX@Q-TXC.DOMAIN.EXT")=""
 S XMY("G.TCSP")=""
 S XMSUB=SITE_"/CS TRANSMISSION/BATCH#: "_CNTLID
 S XMTEXT="^XTMP(""RCTCSPD"","_$J_","""_SEQ_""",""BUILD"","
 D ^XMD
 Q
 ;
USRMSG ;sends mailman message of documents sent to user
 N XMY,XMDUZ,XMSUB,XMTEXT,X,RCNT,RCDAT1,RCDAT2
 S ACTION="" F  S ACTION=$O(^XTMP("RCTCSPD",$J,"BILL",ACTION)) Q:ACTION=""  D
 .K ^XTMP("RCTCSPD",$J,"BILL","MSG")
 .S XMDUZ="AR PACKAGE"
 .S XMY("G.TCSP")=""
 .S XMSUB="CS "_$S(ACTION="A":"ADD REFERRAL",ACTION="U":"UPDATES",ACTION="L":"RECALLS",ACTION="B":"EXISTING DEBTOR",1:"UNKNOWN")_" SENT ON "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)_" BATCH ID: "_CNTLID
 .S ^XTMP("RCTCSPD",$J,"BILL","MSG",1)="Bill#     TIN        TYPE       AMOUNT"
 .S ^XTMP("RCTCSPD",$J,"BILL","MSG",2)="-----     ---        ----       ------"
 .S X=0,RCNT=2 F  S X=$O(^XTMP("RCTCSPD",$J,"BILL",ACTION,X)) Q:X=""  D
 ..S RCNT=RCNT+1
 ..S RCDAT1=$P(^XTMP("RCTCSPD",$J,"BILL",ACTION,X),U,1)
 ..S RCDAT2=$P(^XTMP("RCTCSPD",$J,"BILL",ACTION,X),U,2)
 ..S ^XTMP("RCTCSPD",$J,"BILL","MSG",RCNT)=$$RJZF($P($G(^PRCA(430,X,0)),U,1),7)_$$BLANK(22)_RCDAT1_"     "_ACTION_"        "_$S(RCDAT2]"":RCDAT2,1:"")
 ..Q
 .S ^XTMP("RCTCSPD",$J,"BILL","MSG",RCNT+1)="Total Bills: "_(RCNT-2)
 .S XMTEXT="^XTMP(""RCTCSPD"","_$J_",""BILL"",""MSG"","
 .D ^XMD
 .K ^XTMP("RCTCSPD",$J,"BILL","MSG")
 Q
 ;
THIRD ;sends mailman message to user if no third letter found
 Q:'$D(^XTMP("RCTCSPD",$J,"THIRD"))
 N XMY,XMDUZ,XMSUB,XMTEXT
 S XMDUZ="AR PACKAGE"
 S XMY("G.TCSP")=""
 N TCT,TDEB,TDEB0,TBIL,TSP,FST
 S XMSUB="TCSP QUALIFIED/NO 3RD LETTER SENT ON "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S ^XTMP("RCTCSPD",$J,"THIRD",1)="The following list of debtor bills were not sent to TCSP."
 S ^XTMP("RCTCSPD",$J,"THIRD",2)="Please review debtor's account to determine why the third"
 S ^XTMP("RCTCSPD",$J,"THIRD",3)="notice letter has not been sent:"
 S ^XTMP("RCTCSPD",$J,"THIRD",4)="Name       Bill #"
 S ^XTMP("RCTCSPD",$J,"THIRD",5)="----       ------"
 S TCT=6,TSP=0,TDEB=""
 F  S TDEB=$O(^XTMP("RCTCSPD",$J,"THIRD",TDEB)) Q:TDEB=""  D
 .S FST=1,TBIL=""
 .I FST,TCT'=6 S ^XTMP("RCTCSPD",$J,"THIRD",TCT)="",TCT=TCT+1,TSP=TSP+1
 .F  S TBIL=$O(^XTMP("RCTCSPD",$J,"THIRD",TDEB,TBIL)) Q:TBIL=""  D
 ..S TDEB0=$S(FST:TDEB,1:"")
 ..S ^XTMP("RCTCSPD",$J,"THIRD",TCT)=TDEB0_$J(" ",35-$L(TDEB0))_TBIL
 ..S TCT=TCT+1,FST=0
 S ^XTMP("RCTCSPD",$J,"THIRD",TCT)="Total records: "_(TCT-(6+TSP))
 S XMTEXT="^XTMP(""RCTCSPD"","_$J_",""THIRD"","
 D ^XMD
 K ^XTMP("RCTCSPD",$J,"THIRD")
THIRDQ Q
 ;
REC3 ;
 N REC,KNUM,DEBTNR,DEBTORNB
 S REC="C3 "_ACTION_"3636001200"_"DM1D "
 S KNUM=$P($P(B0,U,1),"-",2)
 ;S DEBTNR=$E(SITE,1,3)_$$LJZF(KNUM,7)_$TR($J(BILL,20)," ",0),REC=REC_DEBTNR
 S DEBTNR=$$AGDEBTID^RCTCSPD,REC=REC_DEBTNR ; PRCA*4.5*350
 S DEBTORNB=$E(SITE,1,3)_$TR($J(DEBTOR,12)," ",0)
 S REC=REC_DEBTORNB
 S REC=REC_$S(ACTION="L":"15",1:"  ")
 S REC=REC_"SLF"
 S REC=REC_$$BLANK(8)
 S REC=REC_$$AMOUNT(0)
 S REC=REC_$$BLANK(16)
 S REC=REC_"SLFIND"
 S REC=REC_$$BLANK(450-$L(REC))
 S ^XTMP("RCTCSPD",$J,BILL,ACTION,3)=REC
 S $P(^XTMP("RCTCSPD",$J,"BILL",ACTION,BILL),U,1)=$$TAXID(DEBTOR)
 Q
 ;
DATE8(X) ;changes fileman date into 8 digit date yyyymmdd
 I +X S X=X+17000000
 S X=$E(X,1,8)
 Q X
 ;
AMOUNT(X) ;changes amount to zero filled, right justified
 S:X<0 X=-X
 S X=$TR($J(X,0,2),".")
 S X=$E("000000000000",1,14-$L(X))_X
 Q X
 ;
BLANK(X) ;returns 'x' blank spaces
 N BLANK
 S BLANK="",$P(BLANK," ",X+1)=""
 Q BLANK
 ;
RJZF(X,Y) ;right justify zero fill width Y
 S X=$E("000000000000",1,Y-$L(X))_X
 Q X
 ;
LJSF(X,Y) ;left justified space filled
 S X=$E(X,1,Y)
 S X=X_$$BLANK(Y-$L(X))
 Q X
 ;
LJZF(X,Y) ;x left justified, y zero filled
 S X=X_"0000000000"
 S X=$E(X,X,Y)
 Q X
 ;
TAXID(DEBTOR) ;computes TAXID to place on documents
 N TAXID,DIC,DA,DR,DIQ
 S TAXID=$$SSN^RCFN01(DEBTOR)
 S TAXID=$$LJSF(TAXID,9)
 Q TAXID
 ;
DTFRMTO(PROMPT) ;Get from and to dates  (added as per PRCA*4.5*315 to be able to sort by dates for reports)
 ;INPUT:
 ;   PROMPT - Message to display prior to prompting for dates
 ;OUTPUT:
 ;    1^BEGDT^ENDDT - Data found
 ;    0     - User up arrowed or timed out
 ;
 N %DT,Y,X,BEGDT,ENDDT,DTOUT,OUT,DIRUT,DUOUT,DIROUT,DTFROM,DTTO
 S OUT=0
 W !,$G(PROMPT)
 S %DT="AEX"
 S %DT("A")="Date Range: FROM: " ;Enter Beginning Date: "
 S %DT("B")="T-30"
 W !
 D ^%DT
 K %DT
 Q:Y<0 OUT  ;Quit if user time out or didn't enter valid date
 S DTFROM=+Y
 S %DT="AEX"
 S %DT("A")="      TO:   ",%DT("B")="T" ;"TODAY"
 D ^%DT
 K %DT
 ;Quit if user time out or didn't enter valid date
 Q:Y<0 OUT
 S DTTO=+Y
 S OUT=1_U_DTFROM_U_DTTO
 ;Switch dates if Begin Date is more recent than End Date
 S:DTFROM>DTTO OUT=1_U_DTTO_U_DTFROM
 Q OUT
 ;
