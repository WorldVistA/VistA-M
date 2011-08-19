PRCPSFIV ;WOIFO/RFJ,LKG-create fms iv issues code sheet ;4/27/05  14:08
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
IV(INVPT,TRANID,TRANNO,TRANDATE,STACKDA) ;  create fms iv document
 ;  tranid=transaction register id number; tranno=ib number (from 410)
 ;  trandate=optional FMS acctg period, otherwise it uses the
 ;                                               transaction date
 ;  pass stackda for regeneration of document
 ;  loop transaction register for posted items
 ;  variables required:
 ;    prcpwsta = whse station #;  prcppsta = buyer station #
 ;    prcpwfcp = whse fcp      ;  prcppfcp = buyer fcp
 ;    prcpwbfy = whse beg fy   ;  prcppbfy = buyer beg fy
 N ACCT,BUYBFY,BUYEFY,BUYFUND,BUYJOB,BUYLINE,BUYTABLE,BUYXPROG,COSTCNTR,DATA,FMSLINE,GECSFMS,INVCOST,LINEDA,LINEDOC,PRCPDA,PRCPFMOD,PRCPFMS,PRCPSEC1,PROFIT,PROFLINE
 N SELBFY,SELEFY,SELFUND,SELLCOST,SELLINE,SELTABLE,SELXPROG,SIGN,SUBACCT,TOTAL,TRANDA,VOUCHER
 S PRCPDA=$O(^PRCS(410,"B",TRANNO,0)) I 'PRCPDA Q
 I $D(^PRCS(410,PRCPDA,"IT","FMSLINE")) S PRCPFMOD=1
 K PRCPFMS
 S (TRANDA,TOTAL)=0 F  S TRANDA=$O(^PRCP(445.2,"T",INVPT,TRANID,TRANDA)) Q:'TRANDA  S DATA=$G(^PRCP(445.2,TRANDA,0)) I DATA'="" D
 .   S LINEDA=+$P(DATA,"^",24) I 'LINEDA Q
 .   I 'TRANDATE S TRANDATE=$P(DATA,"^",3)
 .   D FINDLINE^PRCPSFU0(PRCPDA,LINEDA)
 .   ;  invcost and sellcost is minus when coming out of the whse
 .   ;  inventory point.  fms is positive when coming out of the whse.
 .   S INVCOST=-$P(DATA,"^",22),SELLCOST=-$P(DATA,"^",23)
 .   S PROFIT=SELLCOST-INVCOST
 .   ;  total is total of unsigned amounts on all lines
 .   S TOTAL=TOTAL+SELLCOST
 .   I '$D(PRCPFMS(FMSLINE)) S PRCPFMS(FMSLINE)=ACCT_"^"_SUBACCT
 .   S $P(PRCPFMS(FMSLINE),"^",3)=$P(PRCPFMS(FMSLINE),"^",3)+INVCOST
 .   S $P(PRCPFMS(FMSLINE),"^",4)=$P(PRCPFMS(FMSLINE),"^",4)+PROFIT
 I '$D(PRCPFMS) Q
IVCOTS ;Entry Point for building IV for COTS inventory transaction
 ;  set up document variables
 S COSTCNTR=$P($G(^PRCS(410,PRCPDA,3)),"^",3),COSTCNTR=$S($D(^PRCD(420.1,+COSTCNTR,0)):$P(^(0),"^"),1:COSTCNTR)
 S VOUCHER=$P($G(^PRCS(410,PRCPDA,445)),"^") S VOUCHER=$E(VOUCHER_"00000",1,6)
 ;  seller=whse
 ;   table=^^xprogram(fcp/prj)^^linefund^beginfy^endfy^^^job
 S SELTABLE=$$ACC^PRC0C(PRCPWSTA,PRCPWFCP_"^"_$P(TRANNO,"-",2)_"^"_PRCPWBFY)
 S SELXPROG=$P(SELTABLE,"^",3),SELFUND=$P(SELTABLE,"^",5),SELBFY=$E($P(SELTABLE,"^",6),3,4),SELEFY=$E($P(SELTABLE,"^",7),3,4)
 I SELEFY=SELBFY S SELEFY=""
 ;  buyer
 S BUYTABLE=$$ACC^PRC0C(PRCPPSTA,PRCPPFCP_"^"_$P(TRANNO,"-",2)_"^"_PRCPPBFY)
 S BUYXPROG=$P(BUYTABLE,"^",3),BUYFUND=$P(BUYTABLE,"^",5),BUYBFY=$E($P(BUYTABLE,"^",6),3,4),BUYEFY=$E($P(BUYTABLE,"^",7),3,4),BUYJOB=$P(BUYTABLE,"^",10)
 I BUYEFY=BUYBFY S BUYEFY=""
 ;
 ;  build control segments in gcs
 S PRCPSEC1=$$SEC1^PRC0C(PRCPWSTA) S:PRCPSEC1="" PRCPSEC1=10
 I '$G(STACKDA) D CONTROL^GECSUFMS("I",PRCPWSTA,PRCPWSTA_VOUCHER,"IV",PRCPSEC1,+$G(PRCPFMOD),"Y","post issue book: "_TRANNO_"  tranid: "_TRANID)
 I $G(STACKDA) D REBUILD^GECSUFM1(STACKDA,"I",PRCPSEC1,"Y","Rebuild post issue book: "_TRANNO_"  tranid: "_TRANID) S GECSFMS("DA")=STACKDA
 D SETPARAM^GECSSDCT(GECSFMS("DA"),TRANID)
 ;
 ;  build iv2 segment
 S LINEDOC="IV2^"_$E(TRANDATE,2,3)_"^"_$E(TRANDATE,4,5)_"^"_$E(TRANDATE,6,7)
 S $P(LINEDOC,"^",9)=$S($D(GECSFMS("BAT")):"M",1:"E")
 S $P(LINEDOC,"^",21)=$E($TR($P(TRANNO,"-",2,5),"-"),1,12)
 S $P(LINEDOC,"^",22)=$J($S(TOTAL<0:-TOTAL,1:TOTAL),0,2)
 D SETCS^GECSSTAA(GECSFMS("DA"),LINEDOC_"^~")
 ;
 ;  build line documents
 S LINEDA=0 F  S LINEDA=$O(PRCPFMS(LINEDA)) Q:'LINEDA  S DATA=PRCPFMS(LINEDA) D
 .   S ACCT=$P(DATA,"^"),SUBACCT=$P(DATA,"^",2),INVCOST=$P(DATA,"^",3),PROFIT=$P(DATA,"^",4)
 .   S SIGN="I" I INVCOST<0 S INVCOST=-INVCOST,SIGN="D"
 .   S SELLINE="LIN^~IVA^"_$E("000",$L(LINEDA)+1,3)_LINEDA_"^"_$J(INVCOST,0,2)_"^"_SIGN_"^^"_SELBFY_"^"_SELEFY_"^"_SELFUND_"^"_PRCPWSTA_"^^^^"_SELXPROG_"^^^^SFCS^^^0"_$S(ACCT=1:4,ACCT=2:6,ACCT=8:2,1:8)_"^^"
 .   S BUYLINE="^"_BUYBFY_"^"_BUYEFY_"^"_BUYFUND_"^"_PRCPPSTA_"^^"_$E(COSTCNTR,1,4)_"00^"_$E(COSTCNTR,5,6)_"^"_BUYXPROG_"^"_SUBACCT_"^~"
 .   S LINEDOC=SELLINE_BUYLINE_"IVB^01^~"
 .   I INVCOST D SETCS^GECSSTAA(GECSFMS("DA"),LINEDOC)
 .   I 'PROFIT Q
 .   ;  create profit line
 .   S SIGN="I" I PROFIT<0 S PROFIT=-PROFIT,SIGN="D"
 .   S PROFLINE=LINEDA+1
 .   S SELLINE="LIN^~IVA^"_$E("000",$L(PROFLINE)+1,3)_PROFLINE_"^"_$J(PROFIT,0,2)_"^"_SIGN_"^^"_SELBFY_"^"_SELEFY_"^"_SELFUND_"^"_PRCPWSTA_"^^^^"_SELXPROG_"^^^^SFPR^^^0"_($S(ACCT=1:4,ACCT=2:6,ACCT=8:2,1:8)+1)_"^^"
 .   S BUYLINE="^"_BUYBFY_"^"_BUYEFY_"^"_BUYFUND_"^"_PRCPPSTA_"^^"_$E(COSTCNTR,1,4)_"00^"_$E(COSTCNTR,5,6)_"^"_BUYXPROG_"^"_SUBACCT_"^~"
 .   S LINEDOC=SELLINE_BUYLINE_"IVB^01^~"
 .   D SETCS^GECSSTAA(GECSFMS("DA"),LINEDOC)
 ;
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 D EN^DDIOL("FMS IV "_$S($D(GECSFMS("BAT")):"MODIFICATION ",1:"")_PRCPWSTA_VOUCHER_" document automatically "_$S($G(STACKDA):"RE-",1:"")_"transmitted.","","!?4")
 Q
