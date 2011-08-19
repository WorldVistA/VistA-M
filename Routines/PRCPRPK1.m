PRCPRPK1 ;WISC/RFJ-packaging discrepancy report (find errors)       ;04 Oct 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PROCESS ;  start finding errors
 N ITEMDA,ITEMDATA,MANNAME,MANSRCE,NSN,OUTSDATA,OUTST,OUTSTERR,OUTSUNIT,PSDA,PSDATA,PSUNIT,TRANDA,TRANUNIT,UNITISS,VENDA,VENDATA,VENUNIT
 K ^TMP($J,"PRCPRPKG")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  I $G(PRCPALLI)!($D(^TMP($J,"PRCPURS4",ITEMDA))) D
 .   I '$$PURCHASE^PRCPU441(ITEMDA) Q  ;  not purchasable
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),UNITISS=$$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),NSN=$$NSN^PRCPUX1(ITEMDA)
 .   I NSN="" S NSN=" " I PRCP("DPTYPE")="W" S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,15)=""
 .   I PRCP("DPTYPE")="W",$P(ITEMDATA,"^",5)'=$P($G(^PRC(441,ITEMDA,3)),"^",8) S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,16)=$$UNITCODE^PRCPUX1($P($G(^PRC(441,ITEMDA,3)),"^",8))_"^"_$$UNITCODE^PRCPUX1($P(ITEMDATA,"^",5))
 .   S MANSRCE=$P($G(^PRC(441,ITEMDA,0)),"^",8)_";PRC(440,",MANNAME=""
 .   I 'MANSRCE S MANSRCE=""
 .   E  S MANNAME=$E($$VENNAME^PRCPUX1(MANSRCE),1,15)_"#"_+MANSRCE
 .   ;  mandatory source defined
 .   ;  only check mandatory source vendor data (except for whse)
 .   I MANSRCE D
 .   .   S VENDATA=$G(^PRC(441,ITEMDA,2,+MANSRCE,0)),VENUNIT=$$UNITVAL^PRCPUX1($P(VENDATA,"^",8),$P(VENDATA,"^",7),"/")
 .   .   I VENDATA="" S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,1)=MANNAME
 .   .   I VENUNIT["?" S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,2)=VENUNIT_"^"_MANNAME
 .   .   ;  for warehouse, set mandatory source=null and check vendors
 .   .   I PRCP("DPTYPE")="W",+MANSRCE=+WHSESRCE D  S MANSRCE="" Q
 .   .   .   I UNITISS'=VENUNIT S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,3)=UNITISS_"^"_VENUNIT_"^"_MANNAME
 .   .   I PRCP("DPTYPE")="W" Q
 .   .   ;  for primaries
 .   .   I $P(ITEMDATA,"^",12)'=MANSRCE S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,4)=$P(ITEMDATA,"^",12)_"^"_MANNAME
 .   .   S PSDATA=$$GETVEN^PRCPUVEN(PRCP("I"),ITEMDA,MANSRCE,1) I 'PSDATA S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,5)=MANNAME
 .   .   S PSUNIT=$$UNITVAL^PRCPUX1($P(PSDATA,"^",3),$P(PSDATA,"^",2),"/")
 .   .   I PSUNIT'=VENUNIT S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,6)=PSUNIT_"^"_MANNAME_"^"_VENUNIT
 .   ;
 .   ;mandatory source is not defined
 .   I 'MANSRCE D
 .   .   ;  loop vendors and check item master file for errors
 .   .   S VENDA=0 F  S VENDA=$O(^PRC(441,ITEMDA,2,VENDA)) Q:'VENDA  S VENDATA=$G(^(VENDA,0)) I VENDATA'="",'$P($G(^PRC(440,VENDA,10)),"^",5) D
 .   .   .   I PRCP("DPTYPE")="W",VENDA=WHSESRCE Q  ;do not want to add warehouse as a procurement source
 .   .   .   S VENUNIT=$$UNITVAL^PRCPUX1($P(VENDATA,"^",8),$P(VENDATA,"^",7),"/")
 .   .   .   I VENUNIT["?" S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,7,VENDA,0)=VENUNIT ;im file unit of purchase wrong
 .   .   .   S PSDATA=$$GETVEN^PRCPUVEN(PRCP("I"),ITEMDA,VENDA_";PRC(440,",0)
 .   .   .   I 'PSDATA S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,7,VENDA,1)="" ;vendor needs adding as procurement source
 .   .   ;  loop procurement sources and check inventory point for errors
 .   .   S PSDA=0 F  S PSDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA,5,PSDA)) Q:'PSDA  S PSDATA=^(PSDA,0) D
 .   .   .   I $D(^TMP($J,"PRCPRPKG",NSN,ITEMDA,7,+PSDATA)) Q  ;other errors already found
 .   .   .   S PSUNIT=$$UNITVAL^PRCPUX1($P(PSDATA,"^",3),$P(PSDATA,"^",2),"/")
 .   .   .   S VENDATA=$G(^PRC(441,ITEMDA,2,+PSDATA,0)),VENUNIT=$$UNITVAL^PRCPUX1($P(VENDATA,"^",8),$P(VENDATA,"^",7),"/")
 .   .   .   ;unit per receipt not equal to unit per purchase
 .   .   .   I PSUNIT'=VENUNIT S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,7,+PSDATA,2)=PSUNIT_"^"_VENUNIT
 .   ;
 .   ;  check for vendors which need to be removed as procurement sources
 .   S PSDA=0 F  S PSDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA,5,PSDA)) Q:'PSDA  S PSDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,5,PSDA,0)) D
 .   .   I '$D(^PRC(441,ITEMDA,2,+PSDATA,0))!($P($G(^PRC(440,+PSDATA,10)),"^",5)) K ^TMP($J,"PRCPRPKG",NSN,ITEMDA,7,+PSDATA) S ^(+PSDATA,3)="" Q  ;vendor needs to be removed as a procurement source
 .   .   I MANSRCE,$P(PSDATA,"^")'=MANSRCE K ^TMP($J,"PRCPRPKG",NSN,ITEMDA,7,+PSDATA) S ^(+PSDATA,3)=""
 .   ;
 .   ;  check outstanding transactions
 .   S TRANDA=0 F  S TRANDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA,7,TRANDA)) Q:'TRANDA  D CHECKOUT^PRCPUTRA(PRCP("I"),ITEMDA,TRANDA) D
 .   .   I $D(OUTSTERR) S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,8,TRANDA,3)=OUTSTERR Q
 .   .   I '$D(OUTSDATA) Q
 .   .   S OUTST=$G(^PRCP(445,PRCP("I"),1,ITEMDA,7,TRANDA,0))
 .   .   S OUTSUNIT=$$UNITVAL^PRCPUX1($P(OUTST,"^",4),$P(OUTST,"^",3),"/")
 .   .   S TRANUNIT=$$UNITVAL^PRCPUX1($P(OUTSDATA,"^",2),$P(OUTSDATA,"^",3),"/")
 .   .   S ^TMP($J,"PRCPRPKG",NSN,ITEMDA,8,TRANDA,4)=OUTSUNIT_"^"_TRANUNIT
 Q
