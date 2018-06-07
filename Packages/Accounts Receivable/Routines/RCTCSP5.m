RCTCSP5 ;ALBANY/PAW-CROSS-SERVICING RECALL REPORT ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**315,339**;Mar 20, 1995;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CSRCLRT ;cross-servicing recall report, prints sorted individual bills that make up a cross-servicing account
 N RCSORT,PAGE,DASH,DTOUT,DUOUT,DIROUT,VALUE,SSN,PROMPT,EXCEL,RCIEN,BILLN,RCDTV,RCUSER,RCTRAN,RCDATE,TERMDIG,CURDT,DATE,DBTR
 N DTFRM,DTTO,DTFRMTO,POP,ZTDESC,ZTREQ,ZTSAVE,ZTRTN,ZTSK,X,Y,DIRUT,STOP,FLAG,TRANTYP
 S PAGE=0,DASH="",$P(DASH,"-",78)="",SSN=0000
 W !
 K ^TMP("RCTCSP5",$J)
 S DIR(0)="S^1:Bill Number;2:Debtor Name",DIR("A")="Sort by",DIR("B")=2 D ^DIR K DIR
 S RCSORT=Y Q:($D(DTOUT)!$D(DUOUT)!$D(DIROUT))
 S DTFRMTO=$$DTFRMTO^RCTCSP2 Q:'DTFRMTO  ;Get date range as per PRCA*4.5*315
 S (DATE,DTFRM)=$$FMADD^XLFDT(+$P(DTFRMTO,U,2)),DTTO=$P(DTFRMTO,U,3),CURDT=0
 S EXCEL=0,PROMPT="CAPTURE Report data to an Excel Document",DIR(0)="Y",DIR("?")="^D HEXC^RCTCSJR"
 S EXCEL=$$SELECT^RCTCSJR(PROMPT,"NO") I "01"'[EXCEL S STOP=1 Q
 I EXCEL=1 D EXCMSG^RCTCSJR ; Display Excel display message
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .S ZTSAVE("RCSORT")="",ZTSAVE("EXCEL")="",ZTSAVE("DTFRM")="",ZTSAVE("DTTO")=""
 .S ZTSAVE("PAGE")="",ZTSAVE("SSN")="",ZTSAVE("DASH")=""
 .S ZTRTN="PRTSORT^RCTCSP5",ZTDESC="CROSS-SERVICING RECALL REPORT"
 .D ^%ZTLOAD,^%ZISC
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 .Q
 ;
 I $E(IOST,1,2)="C-" W !!,"Compiling Cross-Servicing Recall Report.  Please wait ... ",!
 ;
PRTSORT ;loop through all bills, find recall bills and corrsponding tranactions
 K ^TMP("RCTCSP5",$J)
 S (RCIEN)=0 F  S RCIEN=$O(^PRCA(430,RCIEN)) Q:'RCIEN  D
 .S FLAG=0
 .Q:('+$P($G(^PRCA(430,RCIEN,15)),U,2))  ;QUIT if 'TCSP RECALL FLAG' is Null
 .I $P($G(^PRCA(430,RCIEN,15)),U,3)'="" Q:$P($G(^PRCA(430,RCIEN,15)),U,3)<DTFRM!($P($G(^PRCA(430,RCIEN,15)),U,3)>DTTO)  ;If using "recall effective date" to screen
 .K RCLIST,LIST,MSG D GETS^DIQ(430,RCIEN_",",".01;9;155;151;153;154","IE","LIST","MSG") Q:$D(LIST)<10  S RCLIST=$NA(LIST(430,RCIEN_","))
 .S DEBTOR=$P($G(^PRCA(430,RCIEN,0)),U,9)
 .I '$D(^RCD(340,DEBTOR,0)) S SSN="    "  ;set SSN to blank if not VA employee or Patient
 .I $D(^RCD(340,DEBTOR,0)) S SSN=$E($$SSN^RCFN01($P($G(^RCD(340,DEBTOR,0)),"^")),6,9) S TERMDIG=$E(@RCLIST@(9,"E"),1)_$S(SSN'="":SSN,1:"     ")
 .;
 .;locate recall transaction - loop thru backwards, getting the most recent transaction. stop when we find one.
 .S RCUSER="",RCTRAN=""
 .;
 .; TCSP RECALL EFFECTIVE DATE is not there
 .I $P(^PRCA(430,RCIEN,15),U,3)="" D
 ..F  S RCTRAN=$O(^PRCA(433,"C",RCIEN,RCTRAN),-1) Q:RCTRAN=""  D  Q:FLAG
 ...S TRANTYP=$$GET1^DIQ(433,RCTRAN,12)   ; transaction type description
 ...I $F(".CS BILL RECALL.CS CASE RECALL.CS DEBTOR RECALL.CS RECALL PLACED.","."_TRANTYP_".") D
 ....S RCUSER=$E($$GET1^DIQ(433,RCTRAN,42),1,10),FLAG=1
 .;
 .; TCSP RECALL EFFECTIVE DATE exists
 .I $P(^PRCA(430,RCIEN,15),U,3)'="" D
 ..F  S RCTRAN=$O(^PRCA(433,"C",RCIEN,RCTRAN),-1) Q:RCTRAN=""  D  Q:FLAG
 ...S TRANTYP=$$GET1^DIQ(433,RCTRAN,12)   ; transaction type description
 ...I $F(".CS BILL RECALL.CS CASE RECALL.CS DEBTOR RECALL.","."_TRANTYP_".") D
 ....S RCUSER=$E($$GET1^DIQ(433,RCTRAN,42),1,10),FLAG=1
 .;
 .;We want to sort by date, but when the date is NULL we need to use alternate
 .;data field, so if a date is present use negative value otherwise use RCIEN 
 .;that allows us to sort by date (newest first).  When we print if the number
 .;is longer than 8 (negative date) char print "Pending".
 .S RCDTV=@RCLIST@(153,"I"),RCDTV=$S(RCDTV'="":-RCDTV,1:RCIEN)
 .I RCDTV>0 S RCDTV=-RCDTV D
 ..I $L(RCDTV)<10 S RCDTV=$E(-99999999,1,(11-$L(RCDTV)))_$E(RCDTV,2,9) Q  ;Ensure that entries that use IEN are 9 characters, this makes empty dates float to the top
 ..I $E(RCDTV,2)<3 S $E(RCDTV,1,4)=-999  ;If IEN is long we need to assure that the first 4 characters are -999 , so that null dates float to the top
 .;
 .;write records to ^TMP
 .I RCSORT=1 D
 ..S ^TMP("RCTCSP5",$J,@RCLIST@(.01,"E"),RCDTV)=@RCLIST@(.01,"E")_U_$E(@RCLIST@(9,"E"),1,17)_U_TERMDIG
 ..S ^TMP("RCTCSP5",$J,@RCLIST@(.01,"E"),RCDTV)=^TMP("RCTCSP5",$J,@RCLIST@(.01,"E"),RCDTV)_U_$J(@RCLIST@(155,"E"),9,2)_U_$S($L(RCDTV)=8:$$FMTE^XLFDT(-RCDTV,"2Z"),1:"Pending")_U_@RCLIST@(154,"I")_"-"_$E(@RCLIST@(154,"E"),1,7)_U_RCUSER
 .I RCSORT=2 D  ; rewrite for EXCEL and faster processing, added User ID (as per PRCA*4.5*315)
 .. I EXCEL D  Q
 ...S ^TMP("RCTCSP5",$J,@RCLIST@(9,"E"),RCIEN,RCDTV)=$E(@RCLIST@(9,"E"),1,16)_U_@RCLIST@(.01,"E")_U_TERMDIG_U_$J(@RCLIST@(155,"E"),9,2)_U
 ...S ^TMP("RCTCSP5",$J,@RCLIST@(9,"E"),RCIEN,RCDTV)=^TMP("RCTCSP5",$J,@RCLIST@(9,"E"),RCIEN,RCDTV)_$S($L(RCDTV)=8:$$FMTE^XLFDT(-RCDTV,"2Z"),1:"Pending")_U_@RCLIST@(154,"I")_"-"_$E(@RCLIST@(154,"E"),1,7)_U_RCUSER Q
 ..I 'EXCEL D  Q
 ...S ^TMP("RCTCSP5",$J,@RCLIST@(9,"E"),RCIEN,RCDTV)=$E(@RCLIST@(9,"E"),1,16)_U_@RCLIST@(.01,"E")_U_SSN_U_$J(@RCLIST@(155,"E"),9,2)_U_$S($L(RCDTV)=8:$$FMTE^XLFDT(-RCDTV,"2Z"),1:"Pending")
 ...S ^TMP("RCTCSP5",$J,@RCLIST@(9,"E"),RCIEN,RCDTV)=^TMP("RCTCSP5",$J,@RCLIST@(9,"E"),RCIEN,RCDTV)_U_@RCLIST@(154,"I")_"-"_$E(@RCLIST@(154,"E"),1,7)_U_RCUSER
 ;
 ;^TMP global loaded, now print report
 U IO
 I RCSORT=1 D  ;Print bill number sort
 .D CSRCLH1
 .S (BILLN,RCDTV)="" F  S BILLN=$O(^TMP("RCTCSP5",$J,BILLN)) Q:BILLN=""!$D(DIRUT)  F  S RCDTV=$O(^TMP("RCTCSP5",$J,BILLN,RCDTV)) Q:RCDTV=""!$D(DIRUT)  D  Q:$D(DIRUT)
 ..I EXCEL W !,$P(^TMP("RCTCSP5",$J,BILLN,RCDTV),U,1,4)_U_$S($L(RCDTV)=8:$$FMTE^XLFDT(-RCDTV,"2Z"),1:"Pending")_U_$P(^TMP("RCTCSP5",$J,BILLN,RCDTV),U,6,10) Q
 .. ; non-Excel output
 ..W !,$P(^TMP("RCTCSP5",$J,BILLN,RCDTV),U),?13,$P(^TMP("RCTCSP5",$J,BILLN,RCDTV),U,2),?31,$P(^TMP("RCTCSP5",$J,BILLN,RCDTV),U,3)
 ..W ?33,$P(^TMP("RCTCSP5",$J,BILLN,RCDTV),U,4),?47,$P(^TMP("RCTCSP5",$J,BILLN,RCDTV),U,5)
 ..W ?56,$P(^TMP("RCTCSP5",$J,BILLN,RCDTV),U,6),?67,$P(^TMP("RCTCSP5",$J,BILLN,RCDTV),U,7)
 .. ; check for page breaks
 .. I ($Y+3)>IOSL D
 ... I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR K DIR Q:$D(DIRUT)
 ... D CSRCLH1
 ;
 I RCSORT=2 D  ;Print debtor sort
 .D CSRCLH2
 .S (DBTR,RCDTV,RCIEN)="" F  S DBTR=$O(^TMP("RCTCSP5",$J,DBTR)) Q:DBTR=""!$D(DIRUT)  F  S RCIEN=$O(^TMP("RCTCSP5",$J,DBTR,RCIEN)) Q:RCIEN=""!$D(DIRUT)  F  S RCDTV=$O(^TMP("RCTCSP5",$J,DBTR,RCIEN,RCDTV)) Q:RCDTV=""!$D(DIRUT)  D  Q:$D(DIRUT)
 ..I EXCEL W !,^TMP("RCTCSP5",$J,DBTR,RCIEN,RCDTV) Q
 .. ; non-Excel output
 ..W !,$P(^TMP("RCTCSP5",$J,DBTR,RCIEN,RCDTV),U),?18,$P(^TMP("RCTCSP5",$J,DBTR,RCIEN,RCDTV),U,2)
 ..W ?31,$P(^TMP("RCTCSP5",$J,DBTR,RCIEN,RCDTV),U,3),?36,$P(^TMP("RCTCSP5",$J,DBTR,RCIEN,RCDTV),U,4)
 ..W ?47,$P(^TMP("RCTCSP5",$J,DBTR,RCIEN,RCDTV),U,5),?56,$P(^TMP("RCTCSP5",$J,DBTR,RCIEN,RCDTV),U,6)
 ..W ?67,$P(^TMP("RCTCSP5",$J,DBTR,RCIEN,RCDTV),U,7)
 .. ; check for page breaks
 .. I ($Y+3)>IOSL D
 ... I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR K DIR Q:$D(DIRUT)
 ... D CSRCLH2
 ;
 ;Finish up report
 I '$D(^TMP("RCTCSP5",$J)) W !,"No records found",!!
 K ^TMP("RCTCSP5",$J)
 I $E(IOST,1,2)="C-",'$D(DIRUT) R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 K IOP,%ZIS,ZTQUEUED
 Q
 ;
CSRCLH1 ;header for cross-servicing recall report 1
 S PAGE=PAGE+1
 I 'EXCEL D  Q
 .W @IOF
 .W !,"PAGE "_PAGE,?12,"CROSS-SERVICING RECALL REPORT (SORTED BY BILL NUMBER)",?68,$$FMTE^XLFDT(DT,"2Z")
 .W !,DASH
 .W !,"BILL NO.",?13,"DEBTOR",?31,"Pt ID",?37,"RECL AMT",?47,"RECL DT",?56,"RECALL RSN",?67,"USER ID"
 .W !,"--------",?13,"------",?31,"-----",?37,"--------",?47,"-------",?56,"----------",?67,"-------"
 ;EXCEL FORM
 W !,"PAGE "_PAGE_U_U_"CS RECALL RPT (BILL)"_U_U_$$FMTE^XLFDT(DT,"2Z")
 W !,"BILL NO."_U_"DEBTOR"_U_"Pt ID"_U_"RECL AMT"_U_"RECALL DT"_U_"RECALL RSN"_U_"USER ID"
 Q
 ;
CSRCLH2 ;header for cross-servicing recall report 2
 S PAGE=PAGE+1
 I 'EXCEL D  Q
 .W @IOF
 .W !,"PAGE "_PAGE,?14,"CROSS-SERVICING RECALL REPORT (SORTED BY DEBTOR)",?68,$$FMTE^XLFDT(DT,"2Z")
 .W !,DASH
 .W !,"DEBTOR",?18,"BILL NO.",?31,"Pt ID",?37,"RECL AMT",?47,"RECL DT",?56,"RECALL RSN",?67,"USER ID"
 .W !,"------",?18,"--------",?31,"-----",?37,"--------",?47,"-------",?56,"----------",?67,"-------"
 ;EXCEL FORMAT
 W !,"PAGE "_PAGE_U_U_"CS RECALL RPT (DEBTOR)"_U_U_$$FMTE^XLFDT(DT,"2Z")
 W !,"DEBTOR"_U_"BILL NO."_U_"Pt ID"_U_"RECL AMT"_U_"RECALL DT"_U_"RECALL RSN"_U_"USER ID"
 Q
 ;
IAIRPT ;Treasury Cross-Servicing IAI Report
 ;This report displays a record of current VHA bills at Treasury. It is a tool that can be used to identify bills erroneously 
 ;listed in a referral status in VistA when reconciled with the Print Cross-Servicing Report.
 ;
 N RDATES,RDGBL,NODE,PAGE,DASH,EXCEL,DEBTOR,BILLDA,RCBILL,CNT,CURDT,POP,RCNAME,ZTDESC,ZTREQ,ZTSAVE,ZTSK,ZTRTN,X,Y,STOP,DIRUT
 S PAGE=0,DASH="",$P(DASH,"-",78)=""
 ;Get available report dates
 S RDGBL="RCTCSP6",CNT=1 F  S RDGBL=$O(^XTMP(RDGBL),-1) Q:RDGBL=""!($E(RDGBL,1)="Q")  I RDGBL["RCTCSP5" D
 . I $P(RDGBL," - ",2)="" S VALUE="No report data to print" Q
 . S RDATES(CNT)=$P(RDGBL," - ",2)_U_$$FMTE^XLFDT($P(RDGBL," - ",2),"2Z"),RDGBL(CNT)=RDGBL,CNT=CNT+1
 . Q
 I '$D(RDATES(1)) W !,?5,"There is no data available for the report, quitting.",! Q
 ; Show dates sorted by newest first and only show the last two report dates if they exist
 I '$D(RDATES(2)) S DIR(0)="S^1:"_$P(RDATES(1),U,2),DIR("A")="Print date?",DIR("B")=1 D ^DIR K DIR
 I $D(RDATES(2)) S DIR(0)="S^1:"_$P(RDATES(1),U,2)_";2:"_$P(RDATES(2),U,2),DIR("A")="     Print IAI report date?",DIR("B")=1 D ^DIR K DIR
 Q:$G(DUOUT)
 S NODE=RDGBL(Y),RDATES=+RDATES(Y)
 S EXCEL=0,PROMPT="CAPTURE Report data to an Excel Document",DIR(0)="Y",DIR("?")="^D HEXC^RCTCSJR"
 S EXCEL=$$SELECT^RCTCSJR(PROMPT,"NO") I "01"'[EXCEL S STOP=1 Q
 I EXCEL=1 D EXCMSG^RCTCSJR ; Display Excel display message
 ;
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .S ZTSAVE("NODE")="",ZTSAVE("EXCEL")="",ZTSAVE("RDATES")=""
 .S ZTRTN="IAIPRNT^RCTCSP5",ZTDESC="CROSS-SERVICING IAI REPORT"
 .D ^%ZTLOAD,^%ZISC
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",!
 .Q
 .;
IAIPRNT ;
 N GETNM,GETBL,GLO
 S PAGE=0
 S GLO=$NA(^TMP("RCTCSP5",$J)) K @GLO
 U IO
 D IAIHDR
 ;
 ; report compile
 S DEBTOR=0 F  S DEBTOR=$O(^XTMP(NODE,DEBTOR)) Q:'DEBTOR  D
 . S BILLDA="" F  S BILLDA=$O(^XTMP(NODE,DEBTOR,BILLDA)) Q:'BILLDA  D
 ..S RCBILL=$P($G(^PRCA(430,BILLDA,0)),U),RCNAME=$E($$GET1^DIQ(430,BILLDA,9),1,20)
 ..S SSN=$S($P($G(^RCD(340,DEBTOR,0)),U)'="":$$SSN^RCFN01($P(^RCD(340,DEBTOR,0),"^")),1:"None")
 ..I SSN<1 S SSN="None"
 ..S @GLO@(RCNAME,RCBILL)=RCBILL_U_RCNAME_U_SSN Q
 ;
 ; report print
 S GETNM="" F  S GETNM=$O(@GLO@(GETNM)) Q:GETNM=""!$D(DIRUT)  S GETBL="" F  S GETBL=$O(@GLO@(GETNM,GETBL)) Q:GETBL=""!$D(DIRUT)  D  Q:$D(DIRUT)
 .I 'EXCEL W $P(@GLO@(GETNM,GETBL),U),?15,$P(@GLO@(GETNM,GETBL),U,2),?40,$P(@GLO@(GETNM,GETBL),U,3),!
 .I EXCEL W @GLO@(GETNM,GETBL),!
 .;check for end of page here, if necessary form feed and print header
 .I 'EXCEL,($Y+3)>IOSL D
 ..I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR Q:$D(DIRUT)
 ..D IAIHDR
 I 'EXCEL,'$D(DIRUT),$E(IOST,1,2)="C-" R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
 K @GLO
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
IAIHDR ;
 S PAGE=PAGE+1
 I 'EXCEL D  Q
 .W @IOF
 .W ?10,"Treasury Cross-Servicing IAI Report",!!,"IAI data compiled date: ",$$FMTE^XLFDT(RDATES,"2Z"),?50,"Page ",PAGE
 .W !!,"Bill Number",?20,"Debtor",?43,"SSN"
 .W !,"-----------",?15,"-----------------------",?40,"---------",!
 ;EXCEL FORMAT
 W !,"PAGE "_PAGE_U_U_"Treasury Cross-Servicing IAI Report"_U_U_$$FMTE^XLFDT(RDATES,"2Z")
 W !,"Bill Number"_U_"Debtor"_U_"SSN",!
 Q
