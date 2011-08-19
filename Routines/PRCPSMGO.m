PRCPSMGO ;WISC/RFJ/DL-create,batch,transmit code sheet ; 1/30/98
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CODESHT(V1,V2,V3) ;  create,batch,transmit v1=station number,
 ;  v2=trancode (ADJ,etc), v3=reference number for control string
 ;  ^tmp($j,"string",#) stores code sheets where # range is 1 and up
 ;  if $d(ztqueued) return prcpcs(n)=code sheet number, prcpcs(b)=batch number
 I '$O(^TMP($J,"STRING",0)) Q
 I 'V1!(V2="") Q
 N %,%I,DISYS,PRC,PRCF,PRCFASYS,PRCFA,PRCPTASK,STRING,X
 S:$D(ZTQUEUED) PRCPTASK=1 D CONTROL^PRCPSMS0(V1,V2,V3) Q:STRING=""
 S %=0 F X=0:1 S %=$O(^TMP($J,"STRING",%)) Q:'%  S:'$O(^TMP($J,"STRING",%)) ^(%)=^TMP($J,"STRING",%)_"$"
 I V2="REP"!(V2="ISS")!(V2="RET")!(V2="BAL") D LINECNT^PRCPSMS0(X,V3) S STRING=STRING_STRING("LC")
 S PRC("SITE")=V1,PRC("PER")=DUZ D NOW^%DTC
 S PRC("FY")=$E(X,2,3) S:+$E(X,4,5)>9 PRC("FY")=$E(100+PRC("FY")+1,2,3)
 S PRCFA("STRING")=STRING,PRCFASYS="ISM",PRCFA("TTF")=V2 W:'$G(PRCPTASK) !!,"creating ISMS code sheet ..." D ^PRCFACX2 Q:'$D(PRCFA("CSNAME"))
 W:'$G(PRCPTASK) "  CODE SHEET NUMBER: ",PRCFA("CSNAME") S:$G(PRCPTASK) PRCPCS("N")=PRCFA("CSNAME")
 W:'$G(PRCPTASK) !?5,"batching code sheet ..." D ^PRCFACB Q:'$D(PRCF("BTCH"))  W:'$G(PRCPTASK) "  BATCH NUMBER: ",PRCF("BTCH") S:$G(PRCPTASK) PRCPCS("B")=PRCF("BTCH")
 W:'$G(PRCPTASK) !?5,"transmit code sheet ...  QUEUED" D ^PRCFACBT
 K ^TMP($J,"STRING")
 Q
