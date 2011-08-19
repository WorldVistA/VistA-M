PRCPWIU ;WISC/RFJ/DGL-update duein (difference between PO and 2237; ; 6/18/01 3:09pm
 ;;5.1;IFCAP;**34**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
UPDATE ;  update dueins (called from PRCH routines);
 ;  da=internal purchase order number
 N %,ACTDUEIN,CANCFLAG,CONV,D,DATA,DUEIN,ITEMDA,INVPT,LI,OUTST,TRAN,TRANDA,VENDOR
 N NEWPO
 I $D(^PRC(442,DA,23)) S NEWPO=$P($G(^PRC(442,DA,23)),"^",4)
 I $P($G(^PRC(442,DA,7)),"^")=45,NEWPO="" S CANCFLAG=1
 ;  get original duein qty from transactions
 ;  remove due-in if po cancelled (cancflag=1)
 K ^TMP($J,"PRCP")
 S TRANDA=0 F  S TRANDA=$O(^PRC(442,DA,13,TRANDA)) Q:'TRANDA  S INVPT=+$P($G(^(TRANDA,0)),"^",11) I INVPT D
 .   I $D(^TMP($J,"PRCP"))'=10 W !,"...checking on due-ins at inventory point(s)..."
 .   S ^TMP($J,"PRCP","I",TRANDA)=INVPT
 .   S LI=0 F  S LI=$O(^PRCS(410,TRANDA,"IT",LI)) Q:'LI  S D=$G(^(LI,0)) D
 .   .   S ITEMDA=+$P(D,"^",5),OUTST=$G(^PRCP(445,INVPT,1,ITEMDA,7,TRANDA,0)) I OUTST="" Q
 .   .   ;  if order is cancelled, remove due-in
 .   .   I $G(CANCFLAG) D KILLTRAN^PRCPUTRA(INVPT,ITEMDA,TRANDA) Q
 .   .   S CONV=+$P(OUTST,"^",5) S:'CONV CONV=1
 .   .   S ^("ORIG")=$G(^TMP($J,"PRCP","D",INVPT,ITEMDA,TRANDA,"ORIG"))+($P(D,"^",2)*CONV)
 I $G(CANCFLAG) K ^TMP($J,"PRCP") Q
 ;
 ;  get actual duein quantity from purchase order
 S VENDOR=+$P($G(^PRC(442,DA,1)),"^"),TRANDA=+$P($G(^PRC(442,DA,0)),"^",12),LI=0
 F  S LI=$O(^PRC(442,DA,2,LI)) Q:'LI  S D=$G(^(LI,0)) D
 .   S ITEMDA=+$P(D,"^",5) I 'ITEMDA,$P(D,"^",13)'="" S ITEMDA=+$O(^PRC(441,"BB",$P(D,"^",13),0))
 .   S TRAN=+$P(D,"^",10) S:'TRAN TRAN=TRANDA S INVPT=+$G(^TMP($J,"PRCP","I",TRANDA))
 .   I '$D(^PRCP(445,INVPT,1,ITEMDA,0)) Q
 .   S OUTST=$G(^PRCP(445,INVPT,1,ITEMDA,7,TRANDA,0))
 .   S DATA=$$GETVEN^PRCPUVEN(INVPT,ITEMDA,VENDOR_";PRC(440,",0),CONV=$P(DATA,"^",4) S:'CONV CONV=+$P(OUTST,"^",5) S:'CONV CONV=1
 .   ;  get correct units for outstanding transaction of they exist
 .   S $P(DATA,"^",4)=CONV S:'$P(DATA,"^",3) $P(DATA,"^",3)=$P(OUTST,"^",4) S:'$P(DATA,"^",2) $P(DATA,"^",2)=$P(OUTST,"^",3)
 .   ;  if units still do not exist, get them from the po
 .   S:'$P(DATA,"^",2) $P(DATA,"^",2)=$P(D,"^",3) S:'$P(DATA,"^",3) $P(DATA,"^",3)=$P(D,"^",12)
 .   ;  find qty previously received
 .   S $P(D,"^",2)=($P(D,"^",2)-$$RECD^PRCPRDI1(DA,LI))\1 S:$P(D,"^",2)<0 $P(D,"^",2)=0
 .   S ^("ACT")=$G(^TMP($J,"PRCP","D",INVPT,ITEMDA,TRANDA,"ACT"))+($P(D,"^",2)*CONV),^("UNITS")=$P(DATA,"^",2,4)
 ;  update current duein qty at inv pt
 S INVPT=0 F  S INVPT=$O(^TMP($J,"PRCP","D",INVPT)) Q:'INVPT  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCP","D",INVPT,ITEMDA)) Q:'ITEMDA  S TRANDA=0 F  S TRANDA=$O(^TMP($J,"PRCP","D",INVPT,ITEMDA,TRANDA)) Q:'TRANDA  D
 .   S ACTDUEIN=+$G(^TMP($J,"PRCP","D",INVPT,ITEMDA,TRANDA,"ACT")),OUTST=$G(^PRCP(445,INVPT,1,ITEMDA,7,TRANDA,0)),DUEIN=+$P(OUTST,"^",2)
 .   I DUEIN'=0,ACTDUEIN=DUEIN D CHECK Q  ;actual and current duein are the same
 .   I ACTDUEIN=0 D KILLTRAN^PRCPUTRA(INVPT,ITEMDA,TRANDA) Q  ;actual duein=0, remove transaction,decrement dueins
 .   I ACTDUEIN'=0,OUTST="" D ADDTRAN^PRCPUTRA(INVPT,ITEMDA,TRANDA,ACTDUEIN_"^"_$G(^TMP($J,"PRCP","D",INVPT,ITEMDA,TRANDA,"UNITS"))),CHECK Q  ;actual duein and no outstanding transaction
 .   D OUTST^PRCPUTRA(INVPT,ITEMDA,TRANDA,ACTDUEIN-DUEIN),CHECK
 K ^TMP($J,"PRCP")
 Q
 ;
 ;
CHECK ;  make sure units and data on outstanding transaction is correct
 S %=$G(^PRCP(445,INVPT,1,ITEMDA,7,TRANDA,0)),DATA=$G(^TMP($J,"PRCP","D",INVPT,ITEMDA,TRANDA,"UNITS")) I %=""!(DATA="") Q
 Q:$P(DATA,"^",1,3)=$P(%,"^",3,5)  S:+$P(DATA,"^") $P(%,"^",3)=$P(DATA,"^") S:+$P(DATA,"^",2) $P(%,"^",4)=$P(DATA,"^",2) S:+$P(DATA,"^",3) $P(%,"^",5)=$P(DATA,"^",3) S ^PRCP(445,INVPT,1,ITEMDA,7,TRANDA,0)=%
 Q
