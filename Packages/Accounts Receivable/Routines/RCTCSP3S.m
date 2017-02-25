RCTCSP3S ;ALBANY/BDB-CROSS-SERVICING DPN SERVER ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**301**;Mar 20, 1995;Build 144
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
READ ;READS MESSAGE INTO TEMPORARY GLOBAL
 N FDT S FDT=0
 K ^XTMP("RCTCSP3S",$J)
 S ^XTMP("RCTCSP3S",0)=$$FMADD^XLFDT(DT,3)_"^"_DT
 K ^XTMP("RCTCSPD",$J)
 S ^XTMP("RCTCSPD",0)=$$FMADD^XLFDT(DT,3)_"^"_DT
 S XMA=0
READ1 X XMREC I $D(XMER) G:XMER<0 READQ
 I $E(XMRG,1)="H" S FDT=$E(XMRG,2,9)
 S ^XTMP("RCTCSP3S",$J,"READ",FDT,XMPOS)=XMRG
 G READ1
 ;
READQ K XMA,XMER,XMREC,XMPOS,XMRG
 N REC
 S LN=0
 F  S LN=$O(^XTMP("RCTCSP3S",$J,"READ",FDT,LN)) Q:LN=""  S REC=$G(^(LN)) D
 .S TYPE=$E(REC,1)
 .I TYPE="H" K TYPE Q
 .I TYPE="C" D DPN K TYPE Q
 .I TYPE="Z" K TYPE Q
 .Q
 ;
 D LTRPDT
 D ERRCD
 Q
 ;
LTRPDT ;sends mailman message to user for due process notification letter print date
 Q:'$D(^XTMP("RCTCSPD",$J,"L"))
 S XMDUZ="AR PACKAGE",XMY("G.TCSP")=""
 N TCT,TDEB,TBIL,TBCNT
 S XMSUB="CS DUE PROCESS NOTIFICATION LETTERS "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S ^XTMP("RCTCSPD",$J,"LTR",1)="The following Debt Due Process Notification letters have been printed."
 S ^XTMP("RCTCSPD",$J,"LTR",2)=""
 S ^XTMP("RCTCSPD",$J,"LTR",3)="Name                             Bill #    DPN File Date   Letter Print Date"
 S ^XTMP("RCTCSPD",$J,"LTR",4)="----                             ------    -------------   -----------------"
 S TDEB="",TBCNT=0,TCT=4
 F  S TDEB=$O(^XTMP("RCTCSPD",$J,"L",TDEB)) Q:TDEB=""  D
 .S TBIL=""
 .F  S TBIL=$O(^XTMP("RCTCSPD",$J,"L",TDEB,TBIL)) Q:TBIL=""  S TBCNT=TBCNT+1 D
 ..S TCT=TCT+1
 ..S ^XTMP("RCTCSPD",$J,"LTR",TCT)=^XTMP("RCTCSPD",$J,"L",TDEB,TBIL)
 S TCT=TCT+1
 S ^XTMP("RCTCSPD",$J,"LTR",TCT)="Total records: "_TBCNT
 S XMTEXT="^XTMP(""RCTCSPD"","_$J_",""LTR"","
 D ^XMD K XMDUZ,XMSUB,XMTEXT,XMY
LTRQ Q
 ;
ERRCD ;sends mailman message to user for due process notification letter print date
 Q:'$D(^XTMP("RCTCSPD",$J,"E"))
 S XMDUZ="AR PACKAGE",XMY("G.TCSP")=""
 N TCT,TDEB,TBIL,TBCNT
 S XMSUB="CS DUE PROCESS NOTIFICATION REJECT RECORDS "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S ^XTMP("RCTCSPD",$J,"ERRCD",1)="The following Debt Due Process Notification file records have been rejected."
 S ^XTMP("RCTCSPD",$J,"ERRCD",2)=""
 S ^XTMP("RCTCSPD",$J,"ERRCD",3)="Name                     Bill #   DPN File Date  Reject Error Codes"
 S ^XTMP("RCTCSPD",$J,"ERRCD",4)="----                     ------   -------------  ------------------"
 S TDEB="",TBCNT=0,TCT=4
 F  S TDEB=$O(^XTMP("RCTCSPD",$J,"E",TDEB)) Q:TDEB=""  D
 .S TBIL=""
 .F  S TBIL=$O(^XTMP("RCTCSPD",$J,"E",TDEB,TBIL)) Q:TBIL=""  S TBCNT=TBCNT+1 D
 ..S TCT=TCT+1
 ..S ^XTMP("RCTCSPD",$J,"ERRCD",TCT)=^XTMP("RCTCSPD",$J,"E",TDEB,TBIL)
 S TCT=TCT+1
 S ^XTMP("RCTCSPD",$J,"ERRCD",TCT)="Total records: "_TBCNT
 S XMTEXT="^XTMP(""RCTCSPD"","_$J_",""ERRCD"","
 D ^XMD
ERRQ Q
 ;
DPN ;due process notification record
 N BILL,X,ERRCD,ERRCDD,Y,PRNTDT,DEBTOR,DEBTORN,REC1
 S BILL=+$E(REC,2,11)
 S X=$E(REC,221,228) I +X D  Q  ;check for a letter print date
 .D ^%DT S PRNTDT=Y
 .S $P(^PRCA(430,BILL,20),U,5)=PRNTDT ;set the aitc print date
 .S DEBTOR=$P($G(^PRCA(430,BILL,0)),U,9)
 .I DEBTOR D
 ..S DEBTORN=$$GET1^DIQ(430,BILL,9)
 ..S DEBTORN=$E(DEBTORN,1,31)
 ..S REC1=DEBTORN_$$BLANK(33-$L(DEBTORN))_$$LJSF($P($P(^PRCA(430,BILL,0),U,1),"-",2),7)_"   "
 ..S REC1=REC1_$$LJSF($$FMTE^XLFDT($P($G(^PRCA(430,BILL,20)),U,4)),13)_"   "_$$LJSF($$FMTE^XLFDT(PRNTDT),13)
 ..S ^XTMP("RCTCSPD",$J,"L",DEBTOR,BILL)=REC1
 .S $P(^PRCA(430,BILL,20),U,6,8)="^^" ;clear the error codes
 S ERRCD=$E(REC,231,248) I ERRCD'?1" "." " D  Q  ;check for error codes
 .S DEBTOR=$P($G(^PRCA(430,BILL,0)),U,9)
 .I DEBTOR D
 ..N ERRCDD,RCJ
 ..S DEBTORN=$$GET1^DIQ(430,BILL,9)
 ..S DEBTORN=$E(DEBTORN,1,23)
 ..S REC1=DEBTORN_$$BLANK(25-$L(DEBTORN))_$$LJSF($P($P(^PRCA(430,BILL,0),U,1),"-",2),7)_"  "
 ..S REC1=REC1_$$LJSF($$FMTE^XLFDT($P($G(^PRCA(430,BILL,20)),U,4)),13)_"  "
 ..S ERRCDD=$E(ERRCD,1,2)
 ..F RCJ=3:2:17 Q:$E(ERRCD,RCJ)'?1AN  S ERRCDD=ERRCDD_","_$E(ERRCD,RCJ,RCJ+1)
 ..S REC1=REC1_$$LJSF(ERRCDD,27)
 ..S ^XTMP("RCTCSPD",$J,"E",DEBTOR,BILL)=REC1
 .S $P(^PRCA(430,BILL,20),U,7)=DT ;set the aitc error date
 .S $P(^PRCA(430,BILL,20),U,8)=ERRCD ;set the aitc error codes
 .S $P(^PRCA(430,BILL,20),U,4,6)="^^" ;clear the request date, referral date, and the print date
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
AMOUNT9(X) ;changes amount to zero filled, right justified
 S:X<0 X=-X
 S X=$TR($J(X,0,2),".")
 S X=$E("000000000000",1,9-$L(X))_X
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
JD() ; returns today's Julian date YDOY
 N XMDDD,XMNOW,XMDT
 S XMNOW=$$NOW^XLFDT
 S XMDT=$E(XMNOW,1,7)
 S XMDDD=$$RJ^XLFSTR($$FMDIFF^XLFDT(XMDT,$E(XMDT,1,3)_"0101",1)+1,3,"0")
 Q $E(DT,3)_XMDDD
 ;
NAMEFF(DFN) ;returns name for document and name in file
 N FN,LN,MN,NM,DOCNM,VA,VADM
 S NM=""
 D DEM^VADPT
 I $D(VADM) S NM=VADM(1)
 S LN=$TR($P(NM,",")," .'-"),MN=$P($P(NM,",",2)," ",2)
 I ($E(MN,1,2)="SR")!($E(MN,1,2)="JR")!(MN?2.3"I")!(MN?0.1"I"1"V"1.3"I") S MN=""
 S FN=$P($P(NM,",",2)," ")
 S DOCNM=LN_", "_FN_" "_MN
 Q DOCNM
 ;
