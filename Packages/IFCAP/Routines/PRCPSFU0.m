PRCPSFU0 ;WISC/RFJ-fms code sheet utilities (find iv line) ;9.9.97
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
FINDLINE(PRCPDA,LINEDA) ;  find fms line number for lineda
 ;  return acct,subacct,fmsline
 N %,DATA
 S %=$G(^PRCS(410,PRCPDA,"IT",LINEDA,445))
 S ACCT=$P($P(%,"^"),"-"),SUBACCT=$P($P(%,"^"),"-",2),FMSLINE=+$P(%,"^",2)
 I ACCT,SUBACCT,FMSLINE Q
 S DATA=$G(^PRCS(410,PRCPDA,"IT",LINEDA,0))
 S SUBACCT=+$P(DATA,"^",4) S:'SUBACCT SUBACCT=$P($G(^PRC(441,+$P(DATA,"^",5),0)),"^",10) S SUBACCT=$E(SUBACCT_"0000",1,4)
 S ACCT=$$ACCT1^PRCPUX1($P($$NSN^PRCPUX1($P(DATA,"^",5)),"-"))
 ;  look to see if a line has already been created for acct-subacct
 S FMSLINE=+$O(^PRCS(410,PRCPDA,"IT","FMSLINE","A"_ACCT_"-"_SUBACCT,0))
 I FMSLINE D SETLINE(PRCPDA,LINEDA,"A"_ACCT_"-"_SUBACCT,FMSLINE) Q
 ;  get next fms line number and set it for line
 S FMSLINE=$$GETNEXT(PRCPDA)
 D SETLINE(PRCPDA,LINEDA,"A"_ACCT_"-"_SUBACCT,FMSLINE)
 Q
 ;
 ;
SETLINE(PRCPDA,LINEDA,ACCTNG,FMSLINE)  ;  set fms line on issue book line
 ;  fmsline=fmsline number to set; acctng=acct-subaact
 I '$D(^PRCS(410,PRCPDA,"IT",LINEDA,0)) Q
 S $P(^PRCS(410,PRCPDA,"IT",LINEDA,445),"^",1,2)=ACCTNG_"^"_FMSLINE
 S ^PRCS(410,PRCPDA,"IT","FMSLINE",ACCTNG,FMSLINE,LINEDA)=""
 Q
 ;
 ;
GETNEXT(PRCPDA)    ;  get next fmsline for issue book
 ;  all fmsline numbers are odd, even numbers used for profit
 I '$D(^PRCS(410,PRCPDA,0)) Q 0
 N FMSLINE
 S FMSLINE=$P($G(^PRCS(410,PRCPDA,445)),"^",2)
 I 'FMSLINE S $P(^PRCS(410,PRCPDA,445),"^",2)=1 Q 1
 S FMSLINE=FMSLINE+2,$P(^PRCS(410,PRCPDA,445),"^",2)=FMSLINE
 Q FMSLINE
 ;
 ;
XREFFMS(PRCPDA,LINEDA,VALUE,FIELD,SETKILL)       ;  build fms cross reference
 ;  used for issue book IV document
 ;  x = value of data in field
 ;  field = field number for x
 ;  setkill = "SET" to set; "KILL" (or anything other than set) to kill
 N %,ACCTNG,FMSLINE
 S %=$G(^PRCS(410,PRCPDA,"IT",LINEDA,445)) I %="" Q
 S ACCTNG=$P(%,"^"),FMSLINE=+$P(%,"^",2)
 D
 .   I FIELD=445.01 S ACCTNG=X Q
 .   I FIELD=445.02 S FMSLINE=X Q
 I ACCTNG=""!('FMSLINE) Q
 I SETKILL="SET" S ^PRCS(410,PRCPDA,"IT","FMSLINE",ACCTNG,FMSLINE,LINEDA)="" Q
 K ^PRCS(410,PRCPDA,"IT","FMSLINE",ACCTNG,FMSLINE,LINEDA)
 Q
