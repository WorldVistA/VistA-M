PRCB1GE1 ;WISC/PLT/LKG-PRCB1GE continue ;10/22/21  10:38
V ;;5.1;IFCAP;**225**;Oct 20, 2000;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;prcduz - user id #
 ;prca data=fiscal year, ^2=quarter, ^3=fisca year start year, ^4=fy start month, ^5=fy start day, ...
 ;prctd data ^1= today's fiscal year, ^2=today's fy quarter
 ;prcdes = description
TMEN ;accrual
 N PRCB,PRCD,PRCE,PRCG,PRCRI,PRCID,PRCAMT,PRCBOC,PRCPND
 N PRCDT,PRCFDT,PRCQUEUE
 N A,B,C,%
 S PRCDT=DT,PRCID=$P(PRCA,"^",11),PRC("SITE")=$P(PRCID,"-",2)
 S PRCPND=$P($$DT^PRC0B2($H,"H"),"^",4)
 D NOW^%DTC S PRCFDT=$E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3)
 D ACCR(PRCA,PRCTD)
REP ; Assemble extract and then call MailMan to send the data message
 K ^TMP("PRCACCRUAL",$J) N PRCLINE,PRCA,PRCSTR,PRCA,PRCB,PRCC,PRCDATA,PRCMSG,PRCLIMIT,PRCMSGS,PRCDATE,PRCTIME,X,Y,Z
 S X=$$NOW^XLFDT(),PRCTIME=$E($P(X,".",2)_"000000",1,6)
 S Z=$E(X,1,3)_"0101",PRCDATE=(1700+$E(X,1,3))_$E(1000+($$FMDIFF^XLFDT($P(X,"."),Z,1)+1),2,4)
 ; Variable PRCLIMIT specifies the maximum number of lines per message
 S PRCMSG=0,PRCLIMIT=1000 S PRCMSGS=$$MSGCNT(PRCLIMIT)
 S PRCLINE=2
 S ^TMP("PRCACCRUAL",$J,PRCLINE)="COMP_DT,STN,FUND,BBFY,AO,ACC,COSTC,BOC,PCO_NBR,ORDER_DT,ORACLE_ID,TXN_DT,CARD_HOLDER,CARD_NBR,ORDER_AMT,UNPAID_AMT,PAID_AMT,UNREC_AMT,ACCRUAL_AMT,VENDOR,~"
 S (PRCA,PRCB,PRCC)=""
 F  S PRCA=$O(^TMP("PRCB1GE1",$J,PRCA)) Q:PRCA=""  D
 . F  S PRCB=$O(^TMP("PRCB1GE1",$J,PRCA,PRCB)) Q:PRCB=""  D
 . . F  S PRCC=$O(^TMP("PRCB1GE1",$J,PRCA,PRCB,PRCC)) Q:PRCC=""  D
 . . . D:PRCLINE'<PRCLIMIT MAIL
 . . . S PRCSTR=^TMP("PRCB1GE1",$J,PRCA,PRCB,PRCC)
 . . . S PRCDATA=PRCFDT_","_PRC("SITE")_","_$TR(PRCA,"/",",")_","_$S(PRCB=1:PRCC,1:$P(PRCSTR,"^",11))_","
 . . . S PRCDATA=PRCDATA_$P(PRCSTR,"^",8)_","_$S(PRCB=2:PRCC,1:$P(PRCSTR,"^",10))_","_$P(PRCSTR,"^",9)_","
 . . . S PRCDATA=PRCDATA_$P(PRCSTR,"^",6)_","_$P(PRCSTR,"^",7)_","_$P(PRCSTR,"^",4)_","_$P(PRCSTR,"^",2)_","
 . . . S PRCDATA=PRCDATA_$P(PRCSTR,"^",3)_","_$P(PRCSTR,"^",5)_","_($P(PRCSTR,"^",2)-$P(PRCSTR,"^",5))_","""_$P(PRCSTR,"^",12)_""""
 . . . S PRCLINE=PRCLINE+1,^TMP("PRCACCRUAL",$J,PRCLINE)=PRCDATA_",~"
 D:PRCLINE>1 MAIL
 K ^TMP("PRCB1GE1",$J),PRCA,PRCTD,PRCDUZ
 Q 
MAIL ;
 S PRCMSG=PRCMSG+1
 S ^TMP("PRCACCRUAL",$J,1)=$$HDR(PRCDATE,PRCTIME,PRC("SITE"),PRCMSG,PRCMSGS)
 S ^(PRCLINE)=^TMP("PRCACCRUAL",$J,PRCLINE)_$S(PRCMSG=PRCMSGS:"{",1:"}")
 N XMDUZ,XMY,XMTEXT,XMSUB,DIFROM S XMY(DUZ)="",XMDUZ=DUZ
 S PRCQUEUE=$S($$PROD^XUPROD():"XXX@Q-IFM.DOMAIN.EXT",1:"XXX@Q-IFT.DOMAIN.EXT")
 S XMY(PRCQUEUE)=""
 S XMSUB="Station "_PRC("SITE")_" IFCAP YTD Conversion Accrual Extract Msg "_PRCMSG_" of "_PRCMSGS
 S XMTEXT="^TMP(""PRCACCRUAL"","_$J_","
 D ^XMD
 K ^TMP("PRCACCRUAL",$J) S PRCLINE=1
 Q
 ;
 ;prca = date data, prctd= current date data
ACCR(PRCA,PRCTD) ;compiling accrual data
 N PRC,PRCRI,PRCB,PRCC,PRCD,PRCE,PRCF,PRCG,PRCID,PRCDF,PRCDE,PRCAMT,PRCBOC,PRCBBFY,PRCBBEY
 N A,B,C,X,Y,PRCHLDR,PRCCARD,PRCPODT,PRCTXND,PRCPAID,PRCTXN,PRCTRAMT
 D:'$D(ZTQUEUED) EN^DDIOL("Compiling...")
 S PRCID=$P(PRCA,"^",11),PRC("SITE")=$P(PRCID,"-",2)
 K ^TMP("PRCB1GE1",$J)
 S PRCB=$P(PRCA,"^",7)
 S PRCDF=+PRCA,PRCDE=+PRCA
 D 410,4406
 QUIT
 ;
 ; Modules set up data strings consisting of
 ;IEN-F442^UnpaidAmt^PaidAmt^PCardTxnAmt^UnreconcileAmt^PCHolderLastname^
 ; PCard#^PCOrderDate^ChargeTxnDate^Oracle Doc ID^PCOrder#
 ; The 4th subscript is 1 if data associated with PC Order and 2 if data
 ; is not linked to a specific PC Order.
 ; 5th subscript is the PC Order Number if known or Oracle Document
 ; ID where charge is not linked to PC Order
410 ;compiling purchase card orders
 N PRCVEN
 S PRCRI=PRCB_"-"_PRC("SITE"),PRCC=PRCRI
 F  S PRCC=$O(^PRCS(410,"RB",PRCC)) QUIT:$P(PRCC,"-",1,2)'=PRCRI!'PRCC  D
 . S PRCRI(410)=0 F  S PRCRI(410)=$O(^PRCS(410,"RB",PRCC,PRCRI(410))) QUIT:'PRCRI(410)  S PRCD=^PRCS(410,PRCRI(410),0),PRCE=$G(^(4)) I "EC"'[$P(PRCD,"^",12)&($P(PRCE,"^",5)]"") D
 .. ;Skip entry if txn # in RB x-ref does not match actual txn #
 .. QUIT:$P(PRCC,"-",$L(PRCC,"-"))'=$P($P(PRCD,"^"),"-",$L($P(PRCD,"^"),"-"))
 .. S A=$P(^PRCS(410,PRCRI(410),3),"^",11),PRCAMT=$P(PRCE,"^",8),PRCBBFY=$P($$YEAR^PRC0C($E(A,2,3)),"^")
 .. QUIT:+PRCAMT=0
 .. S PRCF=PRC("SITE")_"-"_$P(PRCE,"^",5)
 .. S PRCRI(442)=$O(^PRC(442,"B",PRCF,0)) QUIT:'PRCRI(442)  S PRCF=$G(^PRC(442,PRCRI(442),1)) QUIT:$P(^(0),"^",2)'=25!($P(^(0),"^",12)'=PRCRI(410))  D:$P(PRCF,"^",15)'>PRCDT
 ... S PRCG=^PRC(442,PRCRI(442),0),PRCRI(9999)=$P(PRCG,"^") QUIT:$P($G(^(7)),"^",2)=40!($P($G(^(7)),"^",2)=41)
 ... S A=$$ACC^PRC0C($P(PRCD,"-"),$P(PRCD,"-",4)_"^"_$P(PRCD,"-",2)_"^"_PRCBBFY)
 ... QUIT:$P(A,"^",6)>PRCDE
 ... QUIT:$P(A,"^",7)<PRCDF&($P(A,"^",13)'="Y")
 ... S PRCRI(442.01)=$O(^PRC(442,PRCRI(442),2,0)) QUIT:'PRCRI(442.01)
 ... S PRCBOC=$P(^PRC(442,PRCRI(442),2,PRCRI(442.01),0),"^",4),PRCBOC=$P(PRCBOC," ")
 ... S B=$P(A,"^",5)_"/"_$P(A,"^",6)_"/"_$P(A,"^")_"/"_$P(A,"^",3)_"/"_$P(PRCG,"^",5)_"/"_PRCBOC
 ... S PRCHLDR=$P($$GET1^DIQ(442,PRCRI(442)_",",61),",")
 ... S PRCCARD=$$GET1^DIQ(442,PRCRI(442)_",",46),PRCCARD=$E(PRCCARD,$L(PRCCARD)-5,99)
 ... S PRCVEN=$TR($$GET1^DIQ(442,PRCRI(442)_",",5),"~{","")
 ... S PRCTRAMT=PRCAMT
 ... S PRCPODT=$P($G(^PRC(442,PRCRI(442),1)),"^",15)
 ... S PRCPODT=$E(PRCPODT,4,5)_"/"_$E(PRCPODT,6,7)_"/"_$E(PRCPODT,2,3)
 ... S PRCPAID=+$P($$FP^PRCH0A(PRCRI(442)),"^",2)
 ... S PRCAMT=PRCAMT-PRCPAID
 ... S ^TMP("PRCB1GE1",$J,B,1,PRCRI(9999))=PRCRI(442)_"^"_PRCAMT_"^"_PRCPAID_"^"_PRCTRAMT_"^0^"_PRCHLDR_"^"_PRCCARD_"^"_PRCPODT_"^^^"_PRCRI(9999)_"^"_PRCVEN
 ... QUIT
 .. QUIT
 . QUIT
 QUIT
 ;
4406 ;compiling unreconciled records
 N A,B,C,X,Y,PRCODI,PRCVEN
 S PRCRI="N"
 F  S PRCRI=$O(^PRCH(440.6,"ST",PRCRI)) Q:PRCRI'?1"N".E  S PRCRI(440.6)=0 F  S PRCRI(440.6)=$O(^PRCH(440.6,"ST",PRCRI,PRCRI(440.6))) Q:'PRCRI(440.6)  S A=^PRCH(440.6,PRCRI(440.6),0),B=$P(A,"^",6),C=^(5) D:B-1<PRCDT
 . QUIT:PRC("SITE")-$P(A,"^",8)
 . S PRCBBFY=$P($$YEAR^PRC0C($E($P(A,"^",11),2,3)),"^")
 . S PRCBBEY=$P($$YEAR^PRC0C($E($P(A,"^",12),2,3)),"^")
 . S B=$O(^PRCD(420.3,"B",$P(C,"^",1),"")) I B S B=$P(^PRCD(420.3,B,0),"^",8)
 . QUIT:PRCBBFY>PRCDE
 . QUIT:PRCBBEY<PRCDF&(B'="Y")
 . S B=$P(C,"^",1)_"/"_PRCBBFY_"/"_$P(C,"^",5)_"/"_$TR($P(C,"^",2,4),"^","/")
 . S PRCHLDR=$P($$GET1^DIQ(440.6,PRCRI(440.6)_",",16),",")
 . S PRCCARD=$$GET1^DIQ(440.6,PRCRI(440.6)_",",3),PRCCARD=$E(PRCCARD,$L(PRCCARD)-5,99)
 . S PRCODI=$$GET1^DIQ(440.6,PRCRI(440.6)_",",.01)
 . S PRCTXN=$$GET1^DIQ(440.6,PRCRI(440.6)_",",9)
 . S PRCTXND=$P($G(^PRCH(440.6,PRCRI(440.6),0)),"^",7),PRCTXND=$E(PRCTXND,4,5)_"/"_$E(PRCTXND,6,7)_"/"_$E(PRCTXND,2,3)
 . S PRCVEN=$TR($$GET1^DIQ(440.6,PRCRI(440.6)_",",31),"~{","")
 . S PRCRI(442)="",PRCRI(9999)=$$GET1^DIQ(440.6,PRCRI(440.6)_",",20)
 . ; Format any Vendor Purchase Order value
 . S PRCRI(9999)=$$UP^XLFSTR(PRCRI(9999))
 . ; Stripping field, record line, and end of file delimiters from PO#
 . S PRCRI(9999)=$TR(PRCRI(9999),",~{","")
 . I PRCRI(9999)?3N6UN S PRCRI(9999)=$E(PRCRI(9999),1,3)_"-"_$E(PRCRI(9999),4,9)
 . I PRCRI(9999)?6UN S PRCRI(9999)=$E($P(A,"^",8),1,3)_"-"_PRCRI(9999)
 . ; No PC Order linked to this charge so data placed in branch 2 for unassociated charges
 . S ^TMP("PRCB1GE1",$J,B,2,PRCODI)=PRCRI(442)_"^^^^"_(+$P(A,"^",14))_"^"_PRCHLDR_"^"_PRCCARD_"^^"_PRCTXND_"^"_PRCODI_"^"_PRCRI(9999)_"^"_PRCVEN
 . QUIT
 QUIT
 ;
MSGCNT(PRCLIMIT) ;Calculates total number of messages
 N PRCA,PRCB,PRCD,PRCCNT,PRCMSGS S (PRCA,PRCB,PRCC)="",PRCCNT=0
 F  S PRCA=$O(^TMP("PRCB1GE1",$J,PRCA)) Q:PRCA=""  D
 . F  S PRCB=$O(^TMP("PRCB1GE1",$J,PRCA,PRCB)) Q:PRCB=""  D
 . . F  S PRCC=$O(^TMP("PRCB1GE1",$J,PRCA,PRCB,PRCC)) Q:PRCC=""  D
 . . . S PRCCNT=PRCCNT+1
 S PRCMSGS=PRCCNT\PRCLIMIT S:PRCCNT#PRCLIMIT PRCMSGS=PRCMSGS+1
 Q PRCMSGS
 ; Sets up YTD header line
HDR(PRCDATE,PRCTIME,PRCSTN,PRCSEQ,PRCTSEQ) ;
 N PRCSTR,X,Y
 S PRCSEQ=$E(1000+PRCSEQ,2,4),PRCTSEQ=$E(1000+PRCTSEQ,2,4)
 S PRCSTR="IFM,"_PRCSTN_",200,YTD,"_PRCDATE_","_PRCTIME_",                    ,"
 S PRCSTR=PRCSTR_PRCSEQ_","_PRCTSEQ_",001~"
 Q PRCSTR
