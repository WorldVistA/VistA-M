RCTCSP1 ;ALBANY/BDB-CROSS-SERVICING TRANSMISSION ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**301,331,315,339,341,336,350,343,433,449**;Mar 20, 1995;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*331 Modify code to ensure that the debtor address info
 ;             is correct on transmission of foreign veterans 
 ;             debtor/bills to Treasury.
 ;
 ;PRCA*4.5*336 Remove IOP set from device request as it causes
 ;             issue when set after %ZIS call and then jumping
 ;             to new option using ^%ZIS call.
 ;             Also, Set CS call switch for correct address
 ;             when debtor file (340) does not have address
 ;             node 1. 
 ;             Also, ensure that the phone number defaults
 ;             to 10 spaces if non-numeric.
 ;
 ;PRCA*4.5*343 Ensure a phone number of all zeros defaults 
 ;             to a null entry.
 ;
 ;PRCA*4.5*433 Add AR Category to Cross Servicing Report
 ;
 ;PRCA*4.5*449 Adjusted parameter sent to allow use of Confidential Address in tag ADDR
 Q
 ;
BILLREP ;Cross-servicing bill report, prints individual bills that make up a cross-servicing account
 N DIC,DEBTOR,ZTSAVE,ZTDESC,ZTRTN,POP,DTFRMTO,PROMPT,EXCEL
 K ^TMP("RCTCSP1",$J)
 S DIC=340,DIC(0)="AEQM",DIC("S")="I $D(^RCD(340,""TCSP"",+Y))" D ^DIC
 Q:Y<1  S DEBTOR=+Y
 S DTFRMTO=$$DTFRMTO^RCTCSP2 Q:'DTFRMTO  ;Get date range as per PRCA*4.5*315
 S EXCEL=0,PROMPT="CAPTURE Report data to an Excel Document",DIR(0)="Y",DIR("?")="^D HEXC^RCTCSJR"
 S EXCEL=$$SELECT^RCTCSJR(PROMPT,"NO") I "01"'[EXCEL S STOP=1 Q
 I EXCEL=1 D EXCMSG^RCTCSJR ; Display Excel display message
 I 'EXCEL W !,"It is recommended that you Queue this report to a device that is 132 characters wide. " ;PRCA*4.5*433
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" D ^%ZIS G:POP BILLREPQ     ;PRC*4.5*336
 I $D(IO("Q")) D  G BILLREPQ
 .S ZTSAVE("DEBTOR")="",ZTSAVE("DTFRMTO")="",ZTSAVE("EXCEL")=""
 .S ZTRTN="BILLREPP^RCTCSP1",ZTDESC="CROSS-SERVICING BILL REPORT"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 .Q
 ;
BILLREPP ;Call to build array of bills referred
 U IO
 N BILL,B7,B14,B15,B16,D4,FND,BAMT,TAMT,DIRUT,TNM,TID,TDT,DASH,CSTAT,PAGE,TMP,I,DATE,DTFRM,DTTO,DATDATE
 K ^TMP("RCTCSP1",$J)
 S DASH="",$P(DASH,"-",97)=""  ;PRCA*4.5*433
 S (DATE,DTFRM)=$$FMADD^XLFDT(+$P(DTFRMTO,U,2)),DTTO=$P(DTFRMTO,U,3)
 S (BAMT,TAMT,BILL,PAGE)=0
 ; rewritten to sort by "TCSP" (#151 date referred to TCSP) not the "AB" xref... PRCA*4.5*315 (TV8)
 F  S BILL=$O(^PRCA(430,"TCSP",BILL)) Q:BILL=""!($D(DIRUT))  D
 .Q:$P($G(^PRCA(430,BILL,0)),U,9)'=DEBTOR
 .Q:'+$G(^PRCA(430,BILL,15))
 .S DATDATE=$P($G(^PRCA(430,BILL,15)),U) Q:DATDATE<DTFRM!(DATDATE>DTTO)
 .S B7=$G(^PRCA(430,BILL,7))
 .S BAMT=0 F I=1:1:5 S BAMT=BAMT+$P(B7,U,I)
 .S TAMT=TAMT+BAMT
 .S ^TMP("RCTCSP1",$J,DEBTOR,BILL)=BAMT
 D BILLREPH
 S DEBTOR="" F  S DEBTOR=$O(^TMP("RCTCSP1",$J,DEBTOR)) Q:'DEBTOR!($D(DIRUT))  D
 . S BILL=0 F  S BILL=$O(^TMP("RCTCSP1",$J,DEBTOR,BILL)) Q:'BILL  D
 ..Q:'+$G(^PRCA(430,BILL,15))
 ..S FND=1 W !,$P(^PRCA(430,BILL,0),U) S CSTAT=$P(^(0),U,8),B7=$G(^(7)),B15=$G(^(15)),B16=$G(^(16))
 ..I 'EXCEL W ?12,$P(^PRCA(430.3,CSTAT,0),U,2)
 ..I EXCEL W U_$P(^PRCA(430.3,CSTAT,0),U,2)
 ..I 'EXCEL W ?15
 ..I EXCEL W U
 ..W $E($P(^PRCA(430.2,$P(^PRCA(430,BILL,0),U,2),0),U),1,10) ;AR CAT PRCA*4.5*433
 ..I 'EXCEL W ?27 ;PRCA*4.5*433
 ..I EXCEL W U ;PRCA*4.5*433
 ..W $J($P(B16,U,9),8,2)
 ..S BAMT=^TMP("RCTCSP1",$J,DEBTOR,BILL)
 ..I 'EXCEL W ?37 ;PRCA*4.5*433
 ..I EXCEL W U
 ..W $J(BAMT,8,2)
 ..I 'EXCEL W ?47,$J($P(B7,U,1),9,2),?57,$J($P(B7,U,2),9,2),?67,$J($P(B7,U,3),9,2),?77,$J($P(B7,U,4),9,2) ;PRCA*4.5*433
 ..I EXCEL W U,$J($P(B7,U,1),8,2)_U_$J($P(B7,U,2),7,2)_U_$J($P(B7,U,3),7,2)_U_$J($P(B7,U,4),8,2)
 ..S TMP=$$FMTE^XLFDT($P(B15,U,1),"2Z")  ;Format date to n/n/nn  (as per PRCA*4.5*315)
 ..I 'EXCEL W ?87,TMP  ;$P(TMP,", ",1)_","_$P(TMP,", ",2)  ;
 ..I EXCEL W U_TMP
 ..;check for end of page here, if necessary form feed and print header
 ..I ($Y+3)>IOSL D
 ...I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR Q:$D(DIRUT)
 ...D BILLREPH
 I $E(IOST,1,2)="C-" R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP("RCTCSP1",$J)
 K IOP,%ZIS,ZTQUEUED
BILLREPQ Q
 ;
BILLREPH ;header for cross-servicing bill report
 W @IOF
 S PAGE=PAGE+1
 I 'EXCEL W "PAGE "_PAGE,?24,"CROSS-SERVICING BILL REPORT",?60,$$FMTE^XLFDT(DT,"2Z"),!,DASH
 I EXCEL W "PAGE "_PAGE_U_"CROSS-SERVICING BILL REPORT"_U_U_$$FMTE^XLFDT(DT,"2Z")
 N RCHDR,RCSSN
 S RCHDR=$$ACCNTHDR^RCDPAPLM(DEBTOR),RCSSN=$S($P(RCHDR,U,2)["P":$E($P(RCHDR,U,2),7,11),1:$E($P(RCHDR,U,2),6,9))  ;Pseudo SSN shouldn't be allowed but we allowed for it to print
 I 'EXCEL D  Q 
 . W !!,"DEBTOR: ",$E($P(RCHDR,U,1),1,18),?26,"SSN: ",RCSSN,?45,"CURRENT CS DEBT: ",$J(TAMT,8,2),!,DASH
 . W !,"BILL NO.",?12,"ST",?15,"AR CAT",?27,"ORIG AMT",?37,"CURR AMT",?47,"PRIN",?57,"INT",?67,"ADMIN",?77,"COURT",?87,"CS REF DT" ;PRCA*4.5*433
 . W !,"-----------",?12,"--",?15,"----------",?27,"--------",?37,"--------",?47,"---------",?57,"---------",?67,"---------",?77,"---------",?87,"---------" ;PRCA*4.5*433
 W !,"DEBTOR: "_$E($P(RCHDR,U,1),1,18)_U_U_"SSN: "_RCSSN_U_U_U_"CURRENT CS DEBT: "_$J(TAMT,8,2)
 W !,"BILL NO."_U_"ST"_U_"AR CAT"_U_"ORIG AMT"_U_"CURR AMT"_U_"PRIN"_U_"INT"_U_"ADMIN"_U_"COURT"_U_"CS REF DATE"
 Q
 ;
CSRPRT ;Print Cross-Servicing Report, prints sorted individual bills that make up a cross-servicing account
 ;
 K ^TMP("RCTCSP1",$J)
 N DIC,RCSORT,PAGE,DASH,DTOUT,DIRUT,DUOUT,DIROUT,RCIEN,RCDEBTOR,RCREFDT,RCSSN,RCORIG,RCCAMT,RCREFDT,RCBILL,ITEM,DBTR,SDT,SSN,NCIEN,TERMDIG
 S PAGE=0,DASH="",$P(DASH,"-",89)=""
 W !
 S DIR(0)="S^1:Bill Number;2:Debtor Name;3:CS Referred Date",DIR("A")="Sort by" D ^DIR K DIR
 S RCSORT=Y Q:($D(DTOUT)!$D(DUOUT)!$D(DIROUT))
 ; The following sections were rewritten to eliminate using ^DIP - (as per PRCA*4.5*315 reformat dates and SSN)
 S DTFRMTO=$$DTFRMTO^RCTCSP2 Q:'DTFRMTO  ;Get date range as per PRCA*4.5*315
 S (DATE,DTFRM)=$$FMADD^XLFDT(+$P(DTFRMTO,U,2)),DTTO=$P(DTFRMTO,U,3)
 S EXCEL=0,PROMPT="CAPTURE Report data to an Excel Document",DIR(0)="Y",DIR("?")="^D HEXC^RCTCSJR"
 S EXCEL=$$SELECT^RCTCSJR(PROMPT,"NO") I "01"'[EXCEL S STOP=1 Q
 I EXCEL=1 D EXCMSG^RCTCSJR ; Display Excel display message
 I 'EXCEL W !,"It is recommended that you Queue this report to a device that is 132 characters wide. " ;PRCA*4.5*433
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" D ^%ZIS Q:POP     ;PRC*4.5*336
 I $D(IO("Q")) D  Q
 .S ZTSAVE("RCSORT")="",ZTSAVE("DTFRMTO")="",ZTSAVE("EXCEL")="",ZTSAVE("PROMPT")="",ZTSAVE("PAGE")="",ZTSAVE("DASH")=""
 .S ZTRTN="CSRPRTR^RCTCSP1",ZTDESC="PRINT CROSS-SERVICING REPORT"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 .Q
CSRPRTR ; compile/print job - either foreground or background
 U IO
 K ^TMP("RCTCSP1",$J)
 ;
 I RCSORT=1 D
 . D CSRPRTH1^RCTCSP1A
 . S (DATE,DTFRM)=$$FMADD^XLFDT(+$P(DTFRMTO,U,2)),DTTO=$P(DTFRMTO,U,3)
 . S RCIEN="" F  S RCIEN=$O(^PRCA(430,"TCSP",RCIEN)) Q:RCIEN=""  D
 .. Q:'$D(^PRCA(430,RCIEN,15))   ;cross servicing data fields
 ..Q:$P($G(^PRCA(430,RCIEN,15)),U)<DTFRM!($P($G(^PRCA(430,RCIEN,15)),U)>DTTO)
 ..K LIST,MSG,RCLIST D GETS^DIQ(430,RCIEN_",",".01;2;9;121,141,161;169;151;11","IE","LIST","MSG") S RCLIST=$NA(LIST(430,RCIEN_",")) ;PRCA*4.5*433 added field 2
 ..;Q:$G(@RCLIST@(141,"E"))'=""   ;Date sent to TOP
 ..S SSN=$E($$SSN^RCFN01(@RCLIST@(9,"I")),6,9) S SSN=$S(SSN'="":SSN,1:"     ") ;PRCA*4.5*433
 ..I SSN S TERMDIG=$E(@RCLIST@(9,"E"),1)_SSN ;PRCA*4.5*433
 ..I 'SSN S TERMDIG=SSN ;PRCA*4.5*433
 ..; SSN=$E($$SSN^RCFN01(@RCLIST@(9,"I")),6,9) S SSN=$S(SSN'="":SSN,1:"     "),TERMDIG=$E(@RCLIST@(9,"E"),1)_SSN
 ..I EXCEL D  Q 
 ...S ^TMP("RCTCSP1",$J,RCIEN,@RCLIST@(.01,"E"))=@RCLIST@(.01,"E")_U_$E(@RCLIST@(2,"E"),1,10)_U_$E(@RCLIST@(9,"E"),1,19)_U_TERMDIG_U_$J(@RCLIST@(169,"E"),8,2)_U_$$FMTE^XLFDT(@RCLIST@(151,"I"),"2Z") ;PRCA*4.5*433
 ...S ^TMP("RCTCSP1",$J,RCIEN,@RCLIST@(.01,"E"))=^TMP("RCTCSP1",$J,RCIEN,@RCLIST@(.01,"E"))_U_$J(@RCLIST@(11,"E"),8,2) ;PRCA*4.5*433
 ...Q
 ..S ^TMP("RCTCSP1",$J,RCIEN,@RCLIST@(.01,"E"))=@RCLIST@(.01,"E")_U_$E(@RCLIST@(2,"E"),1,10)_U_$E(@RCLIST@(9,"E"),1,19)_U_TERMDIG_U_$J(@RCLIST@(169,"E"),8,2)_U_$$FMTE^XLFDT(@RCLIST@(151,"I"),"2Z") ;PRCA*4.5*433
 ..S ^TMP("RCTCSP1",$J,RCIEN,@RCLIST@(.01,"E"))=^TMP("RCTCSP1",$J,RCIEN,@RCLIST@(.01,"E"))_U_$J(@RCLIST@(11,"E"),8,2) ;PRCA*4.5*433
 .;
 .; print report for sort 1
 .S (NCIEN,ITEM)="" F  S NCIEN=$O(^TMP("RCTCSP1",$J,NCIEN)) Q:NCIEN=""!$D(DIRUT)  F  S ITEM=$O(^TMP("RCTCSP1",$J,NCIEN,ITEM)) Q:ITEM=""!$D(DIRUT)  D  Q:$D(DIRUT)
 ..I EXCEL W !,$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U)_U_$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,2)_U_$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,3)
 ..I EXCEL W U_$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,4)_U_$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,5)_U_$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,6)_U_$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,7) ;PRCA*4.5*433
 ..I EXCEL Q
 ..; non-Excel output
 ..W !,$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U),?14,$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,2),?25,$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,3) ;PRCA*4.5*433
 ..W ?46,$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,4),?54,$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,5),?69,$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,6),?79,$P(^TMP("RCTCSP1",$J,NCIEN,ITEM),U,7) ;PRCA*4.5*433
 ..; page break check
 ..I ($Y+3)>IOSL D
 ...I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR K DIR Q:$D(DIRUT)
 ...D CSRPRTH1^RCTCSP1A
 ...Q
 ..Q
 .Q
 ;
 I RCSORT=2 D
 . D CSRPRTH2^RCTCSP1A
 . S (DATE,DTFRM)=$$FMADD^XLFDT(+$P(DTFRMTO,U,2),-1),DTTO=$P(DTFRMTO,U,3)
 . S RCIEN="" F  S RCIEN=$O(^PRCA(430,"TCSP",RCIEN)) Q:RCIEN=""  D
 ..Q:'$D(^PRCA(430,RCIEN,15))   ;cross servicing data fields
 ..Q:$P($G(^PRCA(430,RCIEN,15)),U)<DTFRM!($P($G(^PRCA(430,RCIEN,15)),U)>DTTO)
 ..K LIST,MSG,RCLIST D GETS^DIQ(430,RCIEN_",",".01;2;9;121,141,161;169;151;11","IE","LIST","MSG") S RCLIST=$NA(LIST(430,RCIEN_",")) ;PRCA*4.5*433 added field 2
 ..;Q:$G(@RCLIST@(121,"E"))'=""   ;Date sent to DMC
 ..;Q:$G(@RCLIST@(141,"E"))'=""   ;Date sent to TOP
 ..S SSN=$E($$SSN^RCFN01(@RCLIST@(9,"I")),6,9) S SSN=$S(SSN'="":SSN,1:"     ") ;PRCA*4.5*433
 ..I SSN S TERMDIG=$E(@RCLIST@(9,"E"),1)_SSN ;PRCA*4.5*433
 ..I 'SSN S TERMDIG=SSN ;PRCA*4.5*433 
 ..I EXCEL D  Q
 ...S ^TMP("RCTCSP1",$J,@RCLIST@(9,"E"),RCIEN)=$E(@RCLIST@(9,"E"),1,19)_U_$E(@RCLIST@(2,"E"),1,10)_U_@RCLIST@(.01,"E")_U_TERMDIG_U_$J(@RCLIST@(169,"E"),8,2)_U_$$FMTE^XLFDT(@RCLIST@(151,"I"),"2Z")_U_$J(@RCLIST@(11,"E"),8,2) Q  ;PRCA*4.5*433
 ..S ^TMP("RCTCSP1",$J,@RCLIST@(9,"E"),RCIEN)=$E(@RCLIST@(9,"E"),1,19)_U_$E(@RCLIST@(2,"E"),1,10)_U_@RCLIST@(.01,"E")_U_SSN_U_$J(@RCLIST@(169,"E"),8,2)_U_$$FMTE^XLFDT(@RCLIST@(151,"I"),"2Z")_U_$J(@RCLIST@(11,"E"),8,2) ;PRCA*4.5*433
 .;
 .; print report for sort 2
 .S (DBTR,NCIEN)="" F  S DBTR=$O(^TMP("RCTCSP1",$J,DBTR)) Q:DBTR=""!$D(DIRUT)  F  S NCIEN=$O(^TMP("RCTCSP1",$J,DBTR,NCIEN)) Q:NCIEN=""!$D(DIRUT)  D  Q:$D(DIRUT)
 ..I EXCEL W !,$P(^TMP("RCTCSP1",$J,DBTR,NCIEN),U,1,4)_U_$P(^TMP("RCTCSP1",$J,DBTR,NCIEN),U,5)_U_$P(^TMP("RCTCSP1",$J,DBTR,NCIEN),U,6)_U_$P(^TMP("RCTCSP1",$J,DBTR,NCIEN),U,7) ;PRCA*4.5*433
 ..I EXCEL Q
 ..; non-Excel output
 ..W !,$P(^TMP("RCTCSP1",$J,DBTR,NCIEN),U),?21,$P(^TMP("RCTCSP1",$J,DBTR,NCIEN),U,2),?33,$P(^TMP("RCTCSP1",$J,DBTR,NCIEN),U,3),?46,$P(^TMP("RCTCSP1",$J,DBTR,NCIEN),U,4) ;PRCA*4.5*433
 ..W ?54,$P(^TMP("RCTCSP1",$J,DBTR,NCIEN),U,5),?69,$P(^TMP("RCTCSP1",$J,DBTR,NCIEN),U,6),?80,$P(^TMP("RCTCSP1",$J,DBTR,NCIEN),U,7) ;PRCA*4.5*433
 ..; page break check
 ..I ($Y+3)>IOSL D
 ...I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR K DIR Q:$D(DIRUT)
 ...D CSRPRTH2^RCTCSP1A
 ...Q
 ..Q
 .Q
 ;
 I RCSORT=3 D
 .D CSRPRTH3^RCTCSP1A
 .S (DATE,DTFRM)=$$FMADD^XLFDT(+$P(DTFRMTO,U,2),-1),DTTO=$P(DTFRMTO,U,3)
 .S RCIEN="" F  S RCIEN=$O(^PRCA(430,"TCSP",RCIEN)) Q:RCIEN=""  D
 ..Q:'$D(^PRCA(430,RCIEN,15))   ;cross servicing data fields
 ..Q:$P(^PRCA(430,RCIEN,15),U)<DTFRM!($P(^PRCA(430,RCIEN,15),U)>DTTO)
 ..K LIST,MSG,RCLIST D GETS^DIQ(430,RCIEN_",",".01;2;9;121,141,161;169;151;11","IE","LIST","MSG") S RCLIST=$NA(LIST(430,RCIEN_",")) ;PRCA*4.5*433 Added field 2
 ..;Q:$G(@RCLIST@(121,"E"))'=""   ;Date sent to DMC
 ..;Q:$G(@RCLIST@(141,"E"))'=""   ;Date sent to TOP
 ..;S SSN=$E($$SSN^RCFN01(@RCLIST@(9,"I")),6,9) S SSN=$S(SSN'="":SSN,1:"     "),TERMDIG=$E(@RCLIST@(9,"E"),1)_SSN
 ..S SSN=$E($$SSN^RCFN01(@RCLIST@(9,"I")),6,9) S SSN=$S(SSN'="":SSN,1:"     ") ;PRCA*4.5*433
 ..I SSN S TERMDIG=$E(@RCLIST@(9,"E"),1)_SSN ;PRCA*4.5*433
 ..I 'SSN S TERMDIG=SSN ;PRCA*4.5*433  
 ..I EXCEL S ^TMP("RCTCSP1",$J,@RCLIST@(151,"I"),RCIEN)=$$FMTE^XLFDT(@RCLIST@(151,"I"),"2Z")_U_$E(@RCLIST@(2,"E"),1,10)_U_$E(@RCLIST@(9,"E"),1,19)_U_@RCLIST@(.01,"E")_U_TERMDIG_U_$J(@RCLIST@(169,"E"),8,2)_U_$J(@RCLIST@(11,"E"),8,2) ;PRCA*4.5*433
 ..I 'EXCEL D  ;PRCA*4.5*433
 ... S ^TMP("RCTCSP1",$J,@RCLIST@(151,"I"),RCIEN)=$$FMTE^XLFDT(@RCLIST@(151,"I"),"2Z")_U_$E(@RCLIST@(2,"E"),1,10)_U_$E(@RCLIST@(9,"E"),1,19)_U_@RCLIST@(.01,"E")_U_TERMDIG_U_$J(@RCLIST@(169,"E"),8,2)_U_$J(@RCLIST@(11,"E"),8,2) ;PRCA*4.5*433
 .;
 .; print report for sort 3
 .S (SDT,NCIEN)="" F  S SDT=$O(^TMP("RCTCSP1",$J,SDT)) Q:SDT=""!$D(DIRUT)  F  S NCIEN=$O(^TMP("RCTCSP1",$J,SDT,NCIEN)) Q:NCIEN=""!$D(DIRUT)  D  Q:$D(DIRUT)
 ..I EXCEL W !,$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U)_U_$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,2)_U_$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,3)_U_$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,4) ;PRCA*4.5*433
 ..I EXCEL W U_$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,5)_U_$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,6)_U_$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,7) ;PRCA*4.5*433
 ..I EXCEL Q
 ..; non-Excel output
 ..W !,$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U),?13,$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,2),?25,$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,3),?47 ;PRCA*4.5*433
 ..W $P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,4),?60,$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,5),?68,$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,6),?80,$P(^TMP("RCTCSP1",$J,SDT,NCIEN),U,7) ;PRCA*4.5*433
 ..; page break check
 ..I ($Y+3)>IOSL D
 ...I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR K DIR Q:$D(DIRUT)
 ...D CSRPRTH3^RCTCSP1A
 ...Q
 ..Q
 .Q
 ;
 ;end of report
 I $E(IOST,1,2)="C-",'$D(DIRUT) R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
 ;
 K ^TMP("RCTCSP1",$J)          ; kill scratch
 D ^%ZISC                      ; close device
 I $D(ZTQUEUED) S ZTREQ="@"    ; purge the task
 Q
 ;
REC5B ;Create record 5B for Treasury
 ;
 D REC5B^RCTCSP1A ;PRCA*4.5*433 Functinality of tag REC5B moved routine RCTCSP1A for SACC size compliance
 ;
DATE8(X) ;changes fileman date into 8 digit date yyyymmdd
 I +X S X=X+17000000
 S X=$E(X,1,8)
 Q X
 ;
AMOUNT(X,TT) ;changes amount to zero filled, right justified
 ;Zeroes are positive
 ;Increase adjustment are positive (TT=73,74)
 ;All other tranactions are negative (reduce bill balance)
 S X=$TR($J(X,0,2),".")
 S X=$E($S(+X=0:0,TT=73!(TT=74):0,1:"-")_"00000000000",1,14-$L(X))_X
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
TAXID(DEBTOR) ;computes TAXID to place on documents
 N TAXID,DIC,DA,DR,DIQ
 S TAXID=$$SSN^RCFN01(DEBTOR)
 S TAXID=$$LJSF(TAXID,9)
 Q TAXID
 ;
ADDR(RCDFN,RCCSW) ; returns patient file address
 N DFN,ADDRCS,STATEIEN,STATEAB,VAPA,ADDR340,PRCAYY,PRCAPHON
 S DFN=RCDFN
 D ADD^VADPT
 S STATEIEN=+VAPA(5),STATEAB=$$GET1^DIQ(5,STATEIEN,1)
 S ADDRCS=VAPA(1)_U_VAPA(2)_U_VAPA(4)_U_STATEAB_U_VAPA(6)_U_VAPA(8)_U_+VAPA(25)
 S ADDR340=$P($$DADD^RCAMADD(DEBTOR,1,RCCSW),U,1,8)     ;PRCA*4.5*336 PRCA*4.5*449
 I $P(ADDRCS,U,7)>2 S $P(ADDR340,U,6)="     "    ;PRCA*4.5*331/336
 S ADDR340=$P(ADDR340,U,1,2)_"^"_$P(ADDR340,U,4,7)_U_$S($P(ADDRCS,U,7)'="":$P(ADDRCS,U,7),1:1)    ;PRCA*4.5*331        
 I $P(ADDR340,U,7)="" S $P(ADDR340,U,7)=$P(ADDRCS,U,7)     ;PRCA*4.5*331
 I $P(ADDR340,U,7)>2 S $P(ADDR340,U,4)="  "     ;PRCA*4.5*331/336
 S PRCAYY="",PRCAPHON=$P(ADDR340,U,6) F I=1:1:$L(PRCAPHON) I $E(PRCAPHON,I)?1N S PRCAYY=PRCAYY_$E($P(ADDR340,U,6),I)
 S PRCAPHON=PRCAYY I $L(PRCAPHON)'=10!(+PRCAPHON=0) S VAPA(8)="          ",$P(ADDR340,U,6)="          "   ;PRCA*4.5*336/PRCA*4.5*343
 S ADDRCS=ADDR340
 Q ADDRCS
 ;
DEM(RCDFN) ; returns patient file information
 N DFN,VADM
 S DFN=RCDFN
 D DEM^VADPT
 ; return string   sex:m/f ^ dob: yyyymmdd ^ ssn ^ deceased ^ Debtor Name
 Q $P(VADM(5),U,1)_U_$P(VADM(3),U,1)_U_$P(VADM(2),U,1)_U_VADM(6)
