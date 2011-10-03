PRCPRDI1 ;WISC/RFJ/DGL-update/print due-ins from 410,442 (build tmp) ; 5/3/00 12:43pm
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DQ ;  queue comes here
 N %,CONV,D,PRCPDAT0,PRCPDAT1,PRCPDAT3,PRCPDAT4,PRCPDAT7,PRCPDAT9,DUEIN,ITEMDA,L,L1,PARENT,PRCPCP,PRCPNO,PRCPPO,TRANDA,TRANNO,TRANSTRT,UPKG,UREC,VENDOR
 ;
 ;  tmp($j,"prcprdi1-di",itemda,tranda)=tranno^qtyduein^u/r^pkg^conv
 ;  tmp($j,"prcprdi1-ck",tranda)="" <- to mark transactions checked
 ;          prcprdi1-no <- used temporary
 K ^TMP($J,"PRCPRDI1-DI"),^TMP($J,"PRCPRDI1-CK"),^TMP($J,"PRCPRDI1-NO")
 ;
 S TRANSTRT=PRC("SITE")_"-"_$E(PRCPDATE,2,3)_"-"_$P("2^2^2^3^3^3^4^4^4^1^1^1","^",+$E(PRCPDATE,4,5))
 S PRCPCP=0 F  S PRCPCP=$O(^PRC(420,"AE",PRC("SITE"),PRCP("I"),PRCPCP)) Q:'PRCPCP  S TRANNO=TRANSTRT_"-"_PRCPCP F  S TRANNO=$O(^PRCS(410,"B",TRANNO)) Q:'TRANNO  S TRANDA=+$O(^(TRANNO,0)) I TRANDA D
 .   I $G(PRCPFUPD) L +^PRCS(410,TRANDA)
 .   S ^TMP($J,"PRCPRDI1-CK",TRANDA)=""
 .   S PRCPDAT0=$G(^PRCS(410,TRANDA,0)),PRCPDAT1=$G(^(1))
 .   I PRCPDAT0=""!($P(PRCPDAT1,"^")'>PRCPDATE)  L -^PRCS(410,TRANDA) Q
 .   S PRCPDAT3=$G(^PRCS(410,TRANDA,3)),PRCPDAT4=$G(^(4)),PRCPDAT7=$G(^(7)),PRCPDAT9=$G(^(9))
 .   I $P(PRCPDAT0,"^",6)=PRCP("I"),$P(PRCPDAT0,"^",2)="O",$P(PRCPDAT0,"^",4)>2,$P(PRCPDAT7,"^",6)]"",$S('$D(^PRC(443,TRANDA,0)):1,$P(^(0),"^",3)]"":1,1:0)
 .   I '$T L -^PRCS(410,TRANDA) Q
 .   ;
 .   ;  issue book (9;3 = date recd)
 .   I $P(PRCPDAT0,"^",4)=5,$P(PRCPDAT9,"^",3) L -^PRCS(410,TRANDA) Q
 .   I $P(PRCPDAT0,"^",4)=5,PRCP("DPTYPE")'="W",+PRCPWHSE'=0 D  L -^PRCS(410,TRANDA) Q
 .   .   S L=0 F  S L=$O(^PRCS(410,TRANDA,"IT",L)) Q:'L  S D=$G(^(L,0)) I D'="" S ITEMDA=+$P(D,"^",5) I $D(^PRCP(445,PRCP("I"),1,ITEMDA,0)) D
 .   .   .   S %=$$GETVEN^PRCPUVEN(PRCP("I"),ITEMDA,PRCPWHSE,1),UREC=$P(%,"^",2),UPKG=$P(%,"^",3),CONV=+$P(%,"^",4)
 .   .   .   S DUEIN=$P(D,"^",2)-$P(D,"^",13) S:$P(D,"^",14)'="" DUEIN=0 S DUEIN=DUEIN*CONV
 .   .   .   I DUEIN>0 S %=$P($G(^TMP($J,"PRCPRDI1-DI",ITEMDA,TRANDA)),"^",2),^TMP($J,"PRCPRDI1-DI",ITEMDA,TRANDA)=TRANNO_"^"_(%+DUEIN)_"^"_UREC_"^"_UPKG_"^"_CONV
 .   ;
 .   ;  purchase order
 .   S PRCPNO=$P(PRCPDAT4,"^",5) S:PRCPNO'="" PRCPNO=$O(^PRC(442,"C",PRCPNO,0)) S PARENT=$P($G(^PRCS(410,TRANDA,10)),"^",2) S:PARENT'="" PARENT=$O(^PRCS(410,"B",PARENT,0))
 .   S L=0 F  S L=$O(^PRCS(410,TRANDA,"IT",L)) Q:'L  S D=$G(^(L,0)) I D'="" S ITEMDA=+$P(D,"^",5) I $D(^PRCP(445,PRCP("I"),1,ITEMDA,0)),'$D(^TMP($J,"PRCPRDI1-DI",ITEMDA,TRANDA)) D
 .   .   I PARENT K:$D(^TMP($J,"PRCPRDI1-DI",ITEMDA,PARENT)) ^(PARENT) S ^TMP($J,"PRCPRDI1-NO",ITEMDA,PARENT)="" ;split request, kill old
 .   .   I $D(^TMP($J,"PRCPRDI1-NO",ITEMDA,TRANDA)) Q  ;split request
 .   .   ;
 .   .   ;  purchase order
 .   .   I PRCPNO!($G(^PRC(442,+$P(D,"^",10),0))) S PRCPPO=$S(PRCPNO:PRCPNO,1:+$P(D,"^",10)) Q:+$G(^PRC(442,PRCPPO,7))=45  D  Q
 .   .   .   L:$G(PRCPFUPD) +^PRC(442,PRCPPO)
 .   .   .   S %=$$GETVEN^PRCPUVEN(PRCP("I"),ITEMDA,+$P($G(^PRC(442,PRCPPO,1)),"^")_";PRC(440,",1),UREC=$P(%,"^",2),UPKG=$P(%,"^",3),CONV=+$P(%,"^",4)
 .   .   .   S (L1,DUEIN)=0 F  S L1=$O(^PRC(442,PRCPPO,2,"AE",ITEMDA,L1)) Q:L1=""  I $D(^PRC(442,PRCPPO,2,L1,0)) S DUEIN=DUEIN+$P(^(0),"^",2)-$$RECD(PRCPPO,L1)
 .   .   .   S DUEIN=DUEIN*CONV\1
 .   .   .   I DUEIN>0 S ^TMP($J,"PRCPRDI1-DI",ITEMDA,TRANDA)=TRANNO_"^"_DUEIN_"^"_UREC_"^"_UPKG_"^"_CONV_"^"_PRCPPO
 .   .   .   L -^PRC(442,PRCPPO)
 .   .   ;
 .   .   ;  transaction 2237
 .   .   S %=$$GETVEN^PRCPUVEN(PRCP("I"),ITEMDA,+$P(PRCPDAT3,"^",4)_";PRC(440,",1),UREC=$P(%,"^",2),UPKG=$P(%,"^",3),CONV=+$P(%,"^",4)
 .   .   S DUEIN=$P(D,"^",2)*CONV\1,%=$P($G(^TMP($J,"PRCPRDI1-DI",ITEMDA,TRANDA)),"^",2),^TMP($J,"PRCPRDI1-DI",ITEMDA,TRANDA)=TRANNO_"^"_(%+DUEIN)_"^"_UREC_"^"_UPKG_"^"_CONV
 .   L -^PRCS(410,TRANDA)
 K ^TMP($J,"PRCPRDI1-NO")
 ;
 D PRINT^PRCPRDI2
 K ^TMP($J,"PRCPRDI1-DI"),^TMP($J,"PRCPRDI1-CK")
 Q
 ;
 ;
RECD(PODA,LINEITEM) ;  return qty received for poda and lineitem
 N %,D,PARTDATA,RECD
 S (%,RECD)=0 F  S %=$O(^PRC(442,PODA,2,LINEITEM,3,%)) Q:'%  S D=$G(^(%,0)),PARTDATA=$G(^PRC(442,PODA,11,+$P(D,"^",4),0)) I $P(PARTDATA,"^",17)'="" S RECD=RECD+$P(D,"^",2)
 Q $S(RECD<0:0,1:RECD)
