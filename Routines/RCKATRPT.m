RCKATRPT ;ALB/MAF-KATRINA FINANCIAL STATEMENT REPORT ;12/1/05  4:14 PM
V ;;4.5;Accounts Receivable;**242,246**;Mar 20, 1995
 ;
EN1 ;
 N RCTYPE,X,%,DUOUT,DTOUT,DIR,RCDATE,Y
 S DIR("A")="(S)UMMARY OR (D)ETAIL?: ",DIR(0)="SBA^S:SUMMARY TOTALS ONLY;D:DETAILS AND SUMMARY"
 S DIR("B")="S" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G RPTQ
 S RCTYPE=Y
 D NOW^%DTC
 S RCDATE=DT
 ; Ask device
 N ZTRTN,ZTSK,ZTSAVE,ZTDESC,%ZIS,POP
 S %ZIS="QM" D ^%ZIS G:POP RPTQ
 I $D(IO("Q")) D  G RPTQ
 . S ZTRTN="EN^RCKATRPT",ZTSAVE("RCTYPE")="",ZTSAVE("RCDATE")="",ZTDESC="KATRINA REPORT"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unavailable")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 D EN^RCKATRPT
RPTQ Q
EN ;
 N BBAL,DEB,RCDFN,X,SITE,Y,%,%H,%I,RCSITE,DFN,BN,RCDCL,RCDL,RCPAG,STAT,TOTAMT,TOTVET,BAL,DATA,INT,RCTOT,AC,OP,PRE,ADM,PB,RCFLAG,X1,X2
 K ^XTMP("RCKATRPT")
 D NOW^%DTC S X1=DT,X2=30 D C^%DTC
 S ^XTMP("RCKATRPT",0)=DT_"^"_X_"^Katrina Detailed Report"
 S (DEB,TOTAMT,TOTVET)=0
 K ^TMP("RCDEBTOR",$J),^TMP("RCTOT",$J),^TMP("DEBTOR",$J),^TMP("RCSITE",$J),^TMP("RCDFN",$J),^TMP("RCBBL",$J)
 F  S DEB=$O(^RCD(340,"AB","DPT(",DEB)) Q:DEB=""  D
 .   I $L(+$$SSN^RCFN01(DEB))<5 Q
 .   ;Check for Emergency Response Indicator (ERI) Flag.
 .   ;N RCDFN S RCDFN=$P($G(^RCD(340,DEB,0)),"^",1) I $$EMERES^PRCAUTL(+RCDFN)']"" Q
 .   N RCDFN S RCDFN=$P($G(^RCD(340,DEB,0)),"^",1) I $$EMGRES^DGUTL(+RCDFN)']"" Q
 .   S BBAL=0 D BBAL ;get bill bal
 D PRINT
 K ^TMP("RCDEBTOR",$J),^TMP("RCTOT",$J),^TMP("DEBTOR",$J),^TMP("RCSITE",$J),^TMP("RCDFN",$J),^TMP("RCBBL",$J)
 Q
BBAL ;get bills balances return array
 G:'DEB BBALQ
 S AC=+$O(^PRCA(430.3,"AC",102,0)),OP=+$O(^PRCA(430.3,"AC",112,0))
 F STAT=AC,OP F BN=0:0 S BN=$O(^PRCA(430,"AS",DEB,STAT,BN)) Q:'BN  D
 .I '$D(^TMP("RCBBL",$J,DEB)) S (BBAL,PB,INT,ADM)=0 S ^TMP("RCBBL",$J,DEB)=""
 .S BAL=$G(^PRCA(430,BN,7))
 .S SITE=$S($P($G(^PRCA(430,BN,0)),"^",12):$P($G(^PRCA(430,BN,0)),"^",12),1:"SITE UNKNOWN")
 .I '$D(^TMP("DEBTOR",$J,SITE,DEB)) S TOTVET=TOTVET+1
 .S PB=PB+$P(BAL,"^",1),INT=INT+$P(BAL,"^",2),ADM=ADM+$P(BAL,"^",3)
 .S BBAL=$P(BAL,"^",1)+$P(BAL,"^",2)+$P(BAL,"^",3)
 .S ^TMP("DEBTOR",$J,SITE,DEB,+RCDFN,BN)=$P(BAL,"^",1)_"^"_$P(BAL,"^",2)_"^"_$P(BAL,"^",3)_"^"_BBAL
 .S ^TMP("RCDEBTOR",$J,SITE,DEB,+RCDFN)=PB_"^"_INT_"^"_ADM_"^"_(PB+INT+ADM)
 .S RCTOT=$G(^TMP("RCTOT",$J,SITE)),$P(^TMP("RCTOT",$J,SITE),"^",1)=$P(RCTOT,"^",1)+$P(BAL,"^",1),$P(^TMP("RCTOT",$J,SITE),"^",2)=$P(RCTOT,"^",2)+$P(BAL,"^",2)
 .S $P(^TMP("RCTOT",$J,SITE),"^",3)=$P(RCTOT,"^",3)+$P(BAL,"^",3),$P(^TMP("RCTOT",$J,SITE),"^",4)=$P(RCTOT,"^",4)+BBAL
 .Q
BBALQ Q
PRINT ;PRINT THE REPORT
 S $P(RCDCL,"=",81)="",(SITE,RCPAG)=0
 D HEAD
 I '$D(^TMP("RCDEBTOR",$J)) W !!,"No data meets this criteria" Q
 I RCTYPE="D" D
 .S RCFLAG=0 F  S SITE=$O(^TMP("DEBTOR",$J,SITE)) Q:SITE=""!(RCFLAG)  S DEB=0 F  S DEB=$O(^TMP("DEBTOR",$J,SITE,DEB)) Q:DEB=""!(RCFLAG)  D
 ..S DFN=0 F  S DFN=$O(^TMP("DEBTOR",$J,SITE,DEB,DFN)) Q:DFN=""!(RCFLAG)  S BN=0 F  S BN=$O(^TMP("DEBTOR",$J,SITE,DEB,DFN,BN)) Q:BN=""!(RCFLAG)  D:$Y+5>IOSL RET Q:RCFLAG  D PRDATA
 ..Q
 .Q
 I RCTYPE="D" Q:RCFLAG  S RCTYPE="S" S RCPAG=0 D RET Q:RCFLAG
 I RCTYPE="S" D
 .F  S SITE=$O(^TMP("RCTOT",$J,SITE)) Q:SITE=""  D PRDATA
 .Q
 Q
RET ;
 F X=$Y:1:(IOSL-3) W !
 I IOST'?1"C-".E D  Q
 .I RCTYPE="D" K ^TMP("RCSITE",$J,SITE),^TMP("RCDFN",$J,DFN)
 .D HEAD
 N DIR,DUOUT,DTOUT
 S DIR(0)="EA",DIR("A")="Enter <RET> to continue or ^ to quit " D ^DIR
 I $D(DTOUT)!$D(DUOUT) S RCFLAG=1 Q:RCFLAG
 I RCTYPE="D" K ^TMP("RCSITE",$J,SITE),^TMP("RCDFN",$J,DFN)
HEAD ;HEADING DETAILED
 N Y S RCPAG=RCPAG+1
 W @IOF,"Financial"_$S(RCTYPE="S":" Summary ",1:" Detailed ")_"Statement for Hurricane Katrina ",?53 S Y=RCDATE D DD^%DT W Y,"   ",$J("PAGE: "_RCPAG,12),!
 I RCTYPE="S" D
 .W !,"SITE",?25,"#AFFECTED VETS",?48,"TOTAL AMT.",?65,"AVG. AMOUNT/VET"
 I RCTYPE="D" D
 .W !,"BILL #",?17,"PRINC. BAL",?41,"INT.",?56,"ADM.",?75,"TOTAL"
 W !,RCDCL
 Q
PRDATA ;WRITE THE DATA
 ;W !
 I RCTYPE="S" D
 .S TOTAMT=$P($G(^TMP("RCTOT",$J,SITE)),"^",4)
 .W !,$P($$SITE^VASITE(),"^",2),?20,$J(TOTVET,18),?40,$J("$"_TOTAMT,18),?60,$J("$"_$P(TOTAMT/TOTVET,".",1)_"."_$E($P(TOTAMT/TOTVET,".",2),1,2),18)
 .S ^XTMP("RCKATRPT",SITE,"TOTGRAND")=TOTVET_"^"_TOTAMT_"^"_$P(TOTAMT/TOTVET,".",1)_"."_$E($P(TOTAMT/TOTVET,".",2),1,2)
 I RCTYPE="D" D
 .N DATA
 .S DATA=$G(^TMP("DEBTOR",$J,SITE,DEB,DFN,BN))
 . I '$D(^TMP("RCSITE",$J,SITE)) W !,?35,$P($$SITE^VASITE(),"^",2),! S ^TMP("RCSITE",$J,SITE)=""
 . I '$D(^TMP("RCDFN",$J,DFN)) W !,DEB_":"_$P($G(^DPT(DFN,0)),"^",1) S ^TMP("RCDFN",$J,DFN)=""
 . W !,$P($G(^PRCA(430,BN,0)),"^",1),?12,$S($P($G(DATA),"^",1):$J("$"_$P(DATA,"^",1),15),1:$J("$0",15)),?30,$S($P($G(DATA),"^",2):$J("$"_$P(DATA,"^",2),15),1:$J("$0",15))
 .W ?45,$S($P($G(DATA),"^",3):$J("$"_$P(DATA,"^",3),15),1:$J("$0",15)),?65,$S($P($G(DATA),"^",4):$J("$"_$P(DATA,"^",4),15),1:$J("$0",15))
 .S ^TMP("RCSITE",$J,SITE)="",^TMP("RCDFN",$J,DFN)=""
 .I '$O(^TMP("DEBTOR",$J,SITE,DEB,DFN,BN)) D
 ..I $Y+5>IOSL D RET Q:RCFLAG  W !,?35,$P($$SITE^VASITE(),"^",2),!!,DEB_":"_$P($G(^DPT(DFN,0)),"^",1),! S ^TMP("RCSITE",$J,SITE)="",^TMP("RCDFN",$J,DFN)=""
 ..N X
 ..S X=$G(^TMP("RCDEBTOR",$J,SITE,DEB,DFN))
 ..S $P(RCDL,"-",65)="" W !,"------",?16,RCDL
 ..W !,"TOTAL: ",?12,$J("$"_$P(X,"^",1),15),?30,$J("$"_$P(X,"^",2),15),?45,$J("$"_$P(X,"^",3),15),?65,$J("$"_$P(X,"^",4),15),!
 ..S ^XTMP("RCKATRPT",SITE,DEB,DFN,"TOT")=DEB_"^"_"^"_X
 .S ^XTMP("RCKATRPT",SITE,DEB,DFN,BN)=DEB_"^"_BN_"^"_DATA
 .Q
 Q
