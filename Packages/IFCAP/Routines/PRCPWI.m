PRCPWI ;WISC/RFJ-increment/decrement due-ins/due-outs for a 2237  ;09 Sep 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EN2 ;  increment due-ins/due-outs and outstanding transactions
 ;  da=internal entry number to 410
 N %,TRAN,FORM,INVPT,VENDOR,WHSE,PRCPLI,ITEMDA,QTY,PRCPDATA,V,VENDATA,CONV
 S:'$D(DA) DA=0 S TRAN=$G(^PRCS(410,+DA,0)),FORM=$P(TRAN,"^",4) I FORM<3 Q
 S INVPT=$P(TRAN,"^",6) Q:'$D(^PRCP(445,+INVPT,0))  S VENDOR=+$P($G(^PRCS(410,DA,3)),"^",4)_";PRC(440," Q:+VENDOR=0
 ;  get whse inv point for issue books (due-outs)
 K WHSE I $P(TRAN,"^",4)=5 S %=0 F  S %=$O(^PRCP(445,"AC","W",%)) Q:'%  I +$G(^PRCP(445,+%,0))=$P(TRAN,"^",5) S WHSE=% Q
 ;  loop items in transaction
 W !!?4,"incrementing due-ins  in inventory point: ",$P($$INVNAME^PRCPUX1(INVPT),"-",2,99)
 I $D(WHSE) W !?4,"incrementing due-outs in inventory point: ",$P($$INVNAME^PRCPUX1(WHSE),"-",2,99)
 S PRCPLI=0 F  S PRCPLI=$O(^PRCS(410,DA,"IT",PRCPLI)) Q:'PRCPLI  S PRCPDATA=$G(^(PRCPLI,0)),ITEMDA=+$P(PRCPDATA,"^",5),QTY=+$P(PRCPDATA,"^",2) I QTY>0 D
 .   ;  increment due-outs if issue book request and warehouse inv point
 .   I $D(WHSE),$D(^PRCP(445,WHSE,1,ITEMDA,0)) D SETOUT^PRCPUDUE(WHSE,ITEMDA,QTY)
 .   ;  increment due-ins
 .   I '$D(^PRCP(445,INVPT,1,ITEMDA,0)) Q
 .   S VENDATA=$$GETVEN^PRCPUVEN(INVPT,ITEMDA,VENDOR,1),QTY=QTY*$P(VENDATA,"^",4)
 .   S:'+$P(VENDATA,"^",2) $P(VENDATA,"^",2)=$P(PRCPDATA,"^",3) S:'+$P(VENDATA,"^",3) $P(VENDATA,"^",3)=1
 .   ;  add/update outstanding transaction and due-ins
 .   D ADDUPD^PRCPUTRA(INVPT,ITEMDA,DA,QTY_"^"_$P(VENDATA,"^",2,4))
 Q
 ;
 ;
EN3 ;  decrement due-ins/due-outs and outstanding transactions
 ;  for return to service
 ;  da=internal entry number to 410
 N %,TRAN,FORM,INVPT,VENDOR,WHSE,PRCPLI,ITEMDA,QTY,PRCPDATA
 S:'$D(DA) DA=0 S TRAN=$G(^PRCS(410,+DA,0)),FORM=$P(TRAN,"^",4) I FORM<3 Q
 S INVPT=$P(TRAN,"^",6) Q:'$D(^PRCP(445,+INVPT,0))  S VENDOR=+$P($G(^PRCS(410,DA,3)),"^",4)_";PRC(440," Q:+VENDOR=0
 ;  get whse inv point for issue books (due-outs)
 K WHSE I $P(TRAN,"^",4)=5 S %=0 F  S %=$O(^PRCP(445,"AC","W",%)) Q:'%  I +$G(^PRCP(445,+%,0))=$P(TRAN,"^",5) S WHSE=% Q
 ;  loop items in transaction
 W !!?4,"decrementing due-ins  in inventory point: ",$P($$INVNAME^PRCPUX1(INVPT),"-",2,99)
 I $D(WHSE) W !?4,"decrementing due-outs in inventory point: ",$P($$INVNAME^PRCPUX1(WHSE),"-",2,99)
 S PRCPLI=0 F  S PRCPLI=$O(^PRCS(410,DA,"IT",PRCPLI)) Q:'PRCPLI  S PRCPDATA=$G(^(PRCPLI,0)),ITEMDA=+$P(PRCPDATA,"^",5),QTY=+$P(PRCPDATA,"^",2) I QTY>0 D
 .   ;  decrement due-outs if issue book request and warehouse inv point
 .   I $D(WHSE),$D(^PRCP(445,WHSE,1,ITEMDA,0)) D SETOUT^PRCPUDUE(WHSE,ITEMDA,-QTY)
 .   ;  decrement due-ins and kill outstanding transaction
 .   D KILLTRAN^PRCPUTRA(INVPT,ITEMDA,DA)
 Q
 ;
 ;
SPLIT(INVPT,ITEMDA,OLDTRAN,TRANDA) ;  split request (called from prchsp)
 ;  oldtran=old trans da, tranda=new trans da
 I '$D(^PRCP(445,+INVPT,1,+ITEMDA,7,+OLDTRAN,0)) Q
 S %=$P(^PRCP(445,INVPT,1,ITEMDA,7,OLDTRAN,0),"^",2,5) D ADDTRAN^PRCPUTRA(INVPT,ITEMDA,TRANDA,%),KILLTRAN^PRCPUTRA(INVPT,ITEMDA,OLDTRAN)
 Q
