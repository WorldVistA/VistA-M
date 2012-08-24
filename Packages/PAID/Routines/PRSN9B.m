PRSN9B ;;WOIFO/PLT - RPC POC Daily Time Extraction ; 08/14/2009  7:56 AM
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ;.ret - rpc return value with return value type: global array
 ;prsnseq - rpc parameter 1 with type: literal after sequence number requested in format nnnn...
 ;prsnrec - rpc parameter 2 with type: literal number of records requested in format nnn...
POCTIME(RET,PRSNSEQ,PRSNREC) ;remote procedure call - extract poc daily time records
 N PRSNA,PRSNB,PRSNC,PRSNSITE,PRSNGLB,PRSNEND
 ;get the current last record in file #451.7
 S PRSNEND=$O(^PRSN(451.7,":"),-1)
 K ^TMP("PRSN",$J,"RPCPOC") S PRSNGLB=$NAME(^TMP("PRSN",$J,"RPCPOC"))
 ;start record after prsnseq
 S PRSNA=PRSNSEQ,PRSNB=0 F  S PRSNA=$O(^PRSN(451.7,PRSNA)),PRSNB=PRSNB+1 QUIT:PRSNA>PRSNEND!(PRSNB>PRSNREC)!'PRSNA  S @PRSNGLB@(PRSNA)=^(PRSNA,0)
 ;set the header node
 S PRSNSITE=$P($G(^XMB(1,1,"XUS")),"^",17),PRSNSITE=$S(+PRSNSITE>0:$P($G(^DIC(4,PRSNSITE,99)),"^",1),1:"")
 S PRSNA=$O(@PRSNGLB@(0)),PRSNC=$O(@PRSNGLB@(":"),-1),PRSNB=PRSNB-1
 S @PRSNGLB@(0)=PRSNSITE_"^"_PRSNA_"^"_PRSNC_"^"_PRSNB_"^"_PRSNEND
 S RET=$NAME(^TMP("PRSN",$J,"RPCPOC"))
 QUIT
 ;
