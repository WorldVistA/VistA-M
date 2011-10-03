PRCPSFSV ;WOIFO/RFJ,LKG-create fms sv adjustment code sheet ;7/8/05  10:11
 ;;5.1;IFCAP;**81,85**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SV(INVPT,TRANID,TRANDATE,STACKDA) ;  create fms sv document for adjustment
 ;  tranid=transaction register id number
 ;  pass trandate for optional FMS acctg period, otherwise it uses the
 ;                                               transaction date
 ;  pass stackda for regeneration of document
 ;  loop transaction register for adjusted items
 ;  variables required:
 ;    prcpwbfy = whse beg fy  ;  prcpwfcp = whse fcp
 ;    prcpwsta = whse station #
 N ACCT,BFY,DATA,EFY,FUND,GECSFMS,INVCOST,LINE,LINEDOC,PRCPFMS,PRCPSEC1,REASON,SIGN,TABLE,TOTAL,TRANDA,XPROG
 K PRCPFMS
 S (TRANDA,TOTAL)=0 F  S TRANDA=$O(^PRCP(445.2,"T",INVPT,TRANID,TRANDA)) Q:'TRANDA  S DATA=$G(^PRCP(445.2,TRANDA,0)) I DATA'="" D
 .   I '$P(DATA,"^",5) Q
 .   S INVCOST=$P(DATA,"^",22) I 'INVCOST Q
 .   I 'TRANDATE S TRANDATE=$P(DATA,"^",3)
 .   S ACCT=$$ACCT1^PRCPUX1($P($$NSN^PRCPUX1($P(DATA,"^",5)),"-"))
 .   S REASON=+$P(DATA,"^",10) I 'REASON S REASON=+$G(^PRCP(445.2,TRANDA,1))
 .   S TOTAL=TOTAL+INVCOST
 .   S PRCPFMS(ACCT,REASON)=$G(PRCPFMS(ACCT,REASON))+INVCOST
 .   I PRCPFMS(ACCT,REASON)=0 K PRCPFMS(ACCT,REASON)
 I '$D(PRCPFMS) Q
 ;
SVCOTS ;Entry point for SV from COTS inventory transaction
 ;  set up document variables
 ;   table=^^xprogram(fcp/prj)^^linefund^beginfy^endfy^^^job
 S TABLE=$$ACC^PRC0C(PRCPWSTA,PRCPWFCP_"^"_$E(DT,2,3)_"^"_PRCPWBFY)
 S XPROG=$P(TABLE,"^",3),FUND=$P(TABLE,"^",5),BFY=$E($P(TABLE,"^",6),3,4),EFY=$E($P(TABLE,"^",7),3,4)
 I EFY=BFY S EFY=""
 ;
 ;  build control segments in gcs
 S PRCPSEC1=$$SEC1^PRC0C(PRCPWSTA) S:PRCPSEC1="" PRCPSEC1=10
 I '$G(STACKDA) D CONTROL^GECSUFMS("I",PRCPWSTA,PRCPWSTA_TRANID,"SV",PRCPSEC1,0,"","Other adjustment tranid: "_TRANID)
 I $G(STACKDA) D REBUILD^GECSUFM1(STACKDA,"I",PRCPSEC1,"","Rebuild of Other adjustment tranid: "_TRANID) S GECSFMS("DA")=STACKDA
 D SETPARAM^GECSSDCT(GECSFMS("DA"),TRANID)
 ;
 ;  build iv2 segment
 S LINEDOC="SV2^"_$E(TRANDATE,2,3)_"^"_$E(TRANDATE,4,5)_"^"_$E(TRANDATE,6,7)
 S $P(LINEDOC,"^",7)="E"
 S $P(LINEDOC,"^",16)=$J($S(TOTAL<0:-TOTAL,1:TOTAL),0,2)
 D SETCS^GECSSTAA(GECSFMS("DA"),LINEDOC_"^~")
 ;
 ;  build line documents
 S (ACCT,LINE)=0 F  S ACCT=$O(PRCPFMS(ACCT)) Q:'ACCT  S REASON="" F  S REASON=$O(PRCPFMS(ACCT,REASON)) Q:REASON=""  S INVCOST=PRCPFMS(ACCT,REASON) I INVCOST D
 .   S SIGN="I" I INVCOST<0 S INVCOST=-INVCOST,SIGN="D"
 .   S LINE=LINE+1
 .   S LINEDOC="LIN^~SVA^"_$E("000",$L(LINE)+1,3)_LINE_"^S"_$$TRANTYPE(REASON,ACCT)_"^"_BFY_"^"_EFY_"^"_FUND_"^^"_PRCPWSTA_"^^^^"_XPROG
 .   S $P(LINEDOC,"^",24)="220"
 .   S LINEDOC=LINEDOC_"^~SVB^"_$J(INVCOST,0,2)_"^"_SIGN_"^^G^~"
 .   D SETCS^GECSSTAA(GECSFMS("DA"),LINEDOC)
 ;
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 D EN^DDIOL("FMS SV "_PRCPWSTA_TRANID_" document automatically "_$S($G(STACKDA):"RE-",1:"")_"transmitted.","","!?4")
 Q
 ;
 ;
TRANTYPE(TYPE,ACCT) ;  return transaction type based on type (1-7) and acct
 ;  type=1:transfer stock to VAMC whse
 ;  type=2:sale of stock to OGA
 ;  type=3:transfer excess stock to GSA
 ;  type=4:adjustment to stock valuation
 ;  type=5:writeoff damaged stock
 ;  type=6:transfer transportation to stock
 ;  type=7:inventory refund adjustment
 I TYPE=1 Q $S(ACCT=1:"A",ACCT=2:"B",ACCT=3:"C",ACCT=8:"D",ACCT=6:"N",1:0)
 I TYPE=2 Q $S(ACCT=1:"E",ACCT=2:"F",ACCT=3:"G",ACCT=8:"H",ACCT=6:"N",1:0)
 I TYPE=3 Q $S(ACCT=1:"J",ACCT=2:"J",ACCT=3:"J",ACCT=8:"J",ACCT=6:"N",1:0)
 I TYPE=4 Q $S(ACCT=1:"M",ACCT=2:"N",ACCT=3:"N",ACCT=8:"N",ACCT=6:"N",1:0)
 I TYPE=5 Q $S(ACCT=1:"M",ACCT=2:"N",ACCT=3:"N",ACCT=8:"N",ACCT=6:"N",1:0)
 I TYPE=6 Q $S(ACCT=1:"Q",ACCT=2:"Q",ACCT=3:"Q",ACCT=8:"Q",ACCT=6:"N",1:0)
 I TYPE=7 Q $S(ACCT=1:"U",ACCT=2:"U",ACCT=3:"U",ACCT=8:"U",ACCT=6:"N",1:0)
 Q 0
