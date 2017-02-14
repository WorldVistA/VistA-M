RCTCSP2 ;ALBANY/BDB-CROSS-SERVICING TRANSMISSION ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**301**;Mar 20, 1995;Build 144
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
COMPILE ;
 N RCMSG,BCNTR,REC,RECC,AMOUNT,RCNTR,ACTION,SEQ
 S BCNTR=0,REC=0,RECC=0,AMOUNT=0,SEQ=0
 F  S BCNTR=$O(^XTMP("RCTCSPD",$J,BCNTR)) Q:+BCNTR'>0  D
 .I REC>50 D
 ..D TRAILER^RCTCSP1
 ..D AITCMSG
 ..S REC=0,RECC=0
 ..Q
 .S ACTION="" F  S ACTION=$O(^XTMP("RCTCSPD",$J,BCNTR,ACTION)) Q:ACTION=""  D
 ..I REC=0 D HEADER^RCTCSP1
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
 D TRAILER^RCTCSP1
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
 ..S $P(^PRCA(430,BILL,15),U,5)=$P(^PRCA(430,BILL,16),U,10) ;set the recall amount to the current tcsp amount
 ..S $P(^PRCA(430,BILL,15),U,7)=1 ;set the stop flag
 ..S $P(^PRCA(430,BILL,15),U,8)=DT ;set the stop date
 ..S $P(^PRCA(430,BILL,15),U,9)="O" ;set the stop date
 ..S $P(^PRCA(430,BILL,15),U,10)="AUTORECALL <$25" ;set the stop reason
 ..S B15=^PRCA(430,BILL,15)
 ..D REC1^RCTCSPD
 ..K ^PRCA(430,"TCSP",BILL) ;set the bill to not sent to cross-servicing
 ..S $P(^PRCA(430,BILL,19),U,10)=1 ;stop interest admin calc
 ..S B19=$G(^PRCA(430,BILL,19))
 ..Q
 .Q
 Q 0
 ;
RCRPRT ;print reconciliation report
 N ZTDESC,ZTRTN,POP,%ZIS
 W !
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" D ^%ZIS Q:POP  S IOP=ION_";"_IOM_";"_IOSL
 I $D(IO("Q")) D  Q
 .S ZTRTN="RCRPRTP^RCTCSP2",ZTDESC="RECONCILIATION REPORT"
 .D ^%ZTLOAD,HOME^%ZIS
 .Q
 ;
RCRPRTP ;print reconciliation report, call to build array of bills returned
 U IO
 N DASH,PAGE,DBTR,DBTRN,RCOUT
 K ^XTMP("RCTCSPP",$J)
 S ^XTMP("RCTCSPP",0)=$$FMADD^XLFDT(DT,3)_"^"_DT
 S DBTR=0
 F  S DBTR=$O(^PRCA(430,"C",DBTR)) Q:DBTR'?1N.N  D
 .N BILL
 .S BILL=0,FND1=0
 .F  S BILL=$O(^PRCA(430,"C",DBTR,BILL)) Q:BILL'?1N.N  D  Q:FND1
 ..I +$P($G(^PRCA(430,BILL,30)),U,1)=0 Q
 ..S DBTRN=$$GET1^DIQ(430,BILL,9) Q:DBTRN']""
 ..S ^XTMP("RCTCSPP",$J,DBTRN,DBTR)=""
 ..S FND1=1
 S PAGE=0,RCOUT=0
 S DASH="",$P(DASH,"-",81)=""
 D RCRPRTH2
 S DBTRN=0
 F  S DBTRN=$O(^XTMP("RCTCSPP",$J,DBTRN)) Q:DBTRN=""  D  Q:RCOUT
 .S DBTR=$O(^XTMP("RCTCSPP",$J,DBTRN,0)) Q:'+DBTR
 .S BILL=0
 .F  S BILL=$O(^PRCA(430,"C",DBTR,BILL)) Q:BILL'?1N.N  D  Q:RCOUT
 ..N B0,B30
 ..S B0=$G(^PRCA(430,BILL,0)),B30=$G(^PRCA(430,BILL,30))
 ..I +$P($G(^PRCA(430,BILL,30)),U,1)=0 Q
 ..W $E($$GET1^DIQ(430,BILL,9),1,30)
 ..W ?33,$P(B0,U,1)
 ..W ?50,$$GET1^DIQ(430,BILL,301)
 ..W ?68,$E($$GET1^DIQ(430,BILL,305),1,12)
 ..I $P(B30,U,2)]"" W !,?6,$$GET1^DIQ(430.5,$P(B30,U,2),1),!
 ..W:$P($G(^PRCA(430,BILL,30)),U,3)="Y" ?6,"COMPROMISE, PLEASE WRITE THIS BILL OFF BY THE MANUAL PROCESS.",!,?6,"COMPROMISED AMOUNT (NOT COLLECTED): "_$J($P($G(^PRCA(430,BILL,30)),U,4),9,2),!
 ..W:+$P($G(^PRCA(430,BILL,30)),U,7) ?6,"DATE OF DEATH:  "_$$UPPER^VALM1($$FMTE^XLFDT($P($G(^PRCA(430,BILL,30)),U,7))),!
 ..W:+$P($G(^PRCA(430,BILL,30)),U,6) ?6,"BANKRUPTCY DATE:  "_$$UPPER^VALM1($$FMTE^XLFDT($P($G(^PRCA(430,BILL,30)),U,6))),!
 ..W:+$P($G(^PRCA(430,BILL,30)),U,8) ?6,"DATE OF DISSOLUTION:  "_$$UPPER^VALM1($$FMTE^XLFDT($P($G(^PRCA(430,BILL,30)),U,8))),!
 ..;check for end of page here, if necessary form feed and print header
 ..W ! I ($Y+3)>IOSL D
 ...I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S RCOUT=1 K X,Y,DIRUT,DTOUT,DUOUT,DIROUT Q
 ...D RCRPRTH2
 I $E(IOST,1,2)="C-" R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
 D:'$D(ZTQUEUED) ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 K ZTQUEUED
 Q
 ;
RCRPRTH2 ;header for reconciliation report print report 2
 W @IOF
 S PAGE=PAGE+1
 W "PAGE "_PAGE,?12,"BILLS RETURNED FROM CROSS-SERVICING (SORTED BY DEBTOR)",?68,$$UPPER^VALM1($$FMTE^XLFDT(DT))
 W !,DASH,!
 W !,"DEBTOR",?33,"BILL NO.",?50,"RETURNED DATE",?68,"CLOSED DATE"
 W !,"------",?33,"---- ---",?50,"-------- ----",?68,"------ ----",!
 Q
 ;
AITCMSG ;
 N XMY,XMDUZ,XMSUB,XMTEXT,CNTLID
 S CNTLID=$$JD^RCTCSP1()_$$RJZF^RCTCSP1(SEQ,4)
 S XMDUZ="AR PACKAGE"
 S XMY("XXX@Q-TPC.DOMAIN.EXT")=""
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
 .S ^XTMP("RCTCSPD",$J,"BILL","MSG",1)="Bill#                             TIN        TYPE       AMOUNT"
 .S ^XTMP("RCTCSPD",$J,"BILL","MSG",2)="-----                             ---        ----       ------"
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
 S ^XTMP("RCTCSPD",$J,"THIRD",4)="Name                               Bill #"
 S ^XTMP("RCTCSPD",$J,"THIRD",5)="----                               ------"
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
 S DEBTNR=$E(SITE,1,3)_$$LJZF(KNUM,7)_$TR($J(BILL,20)," ",0),REC=REC_DEBTNR
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
