PRCPPOL1 ;WISC/RFJ-receive purchase order (list manager)            ; 6/18/01 1:21pm
 ;;5.1;IFCAP;**34**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
RECEIVE ;  start receiving po into inventory point
 D FULL^VALM1
 S VALMBCK="R"
 N X
 I $G(PRCPFLAG) D  Q
 .   K X S X(1)="You must FIX all errors before receiving this purchase order into your inventory point.  Failure to correctly fix the errors may lead to incorrect values in your inventory point."
 .   D DISPLAY^PRCPUX2(5,75,.X)
 .   D R^PRCPUREP
 ;
 I $G(PRCPFCOS) D
 .   K X S X(1)="This is a friendly WARNING.  There are items on this purchase order which are either not stored in your inventory point OR have not been costed to a distribution point."
 .   S X(2)="If you continue receiving this purcase order, these items will NOT be received or costed to any inventory point."
 .   D DISPLAY^PRCPUX2(5,75,.X)
 ;
 N %,DATA,DRUGACCT,ISMSFLAG,ITEMDA,ITEMDATA,LINEDA,ORDERNO,PONO,PRCPPOL1,QTYRECVE,QUANTITY,REFDA,TOTCOST,TRANDA,TRANID,Y
 I PRCPTYPE="P",$P($G(^PRCP(445,PRCPINPT,0)),"^",20)="D" S X="PSAGIP" I $D(^%ZOSF("TEST")) X ^("TEST") I $T S DRUGACCT=1 K X S X(1)="NOTE:  This is a DRUG ACCOUNTABILITY inventory point." D DISPLAY^PRCPUX2(1,79,.X)
 ;
 S XP="ARE YOU SURE YOU WANT TO RECEIVE THIS PURCHASE ORDER"
 W ! I $$YN^PRCPUYN(1)'=1 Q
 ;
CHKFINAL ;This block of the code will check and flag any incomplete Partial
 ;receipt for selected Final PO. NOIS=LIT-0800-72295.
 G:'$D(^PRC(442,PRCPORDR,11,0)) OKFINAL
 N LOOPCNT,PARTMSG,PARTNUM,PARTCNT,NODATA
 S LOOPCNT=1,(CHKDATA,PARTMSG,PARTCNT,NODATA)=0
 S PARTNUM=""
 S PARTCNT=$P($G(^PRC(442,PRCPORDR,11,0)),"^",4)
 I PARTCNT'="" G:PARTCNT'=PRCPPART OKFINAL
 I (PARTCNT'=""),(PARTCNT>0) S PARTCNT=PARTCNT-1
 F LOOPCNT=1:1:PARTCNT  D
 .S CHKDATA=$G(^PRC(442,PRCPORDR,11,LOOPCNT,0))
 .I CHKDATA="" S NODATA=1
 .I $P(CHKDATA,"^",16)="" S PARTMSG=1,PARTNUM=PARTNUM_LOOPCNT_","
 G:'PARTMSG OKFINAL
 I PARTMSG D  Q
 . S WRD1="number: " S:$L(PARTNUM)>2 WRD1="numbers: "
 . S WRD2="is" S:$L(PARTNUM)>2 WRD2="are"
 . S PARTNUM=$E(PARTNUM,1,$L(PARTNUM)-1)
 . K X S X(1)=" WARNING:  There is more than one partial pending receipt for this purchase order."
 . S X(2)="Please make sure that receipts are posted in sequence order to prevent any problem."
 . S X(3)="Partial "_WRD1_PARTNUM_" "_WRD2_" missing for this purchase order."
 . D DISPLAY^PRCPUX2(5,75,.X)
 . D R^PRCPUREP
 . K LOOPCNT,CHKDATA,PARTMSG,PARTNUM,NODATA,WRD1,WRD2
 ;
OKFINAL ;
 L +^PRCP(445,PRCPINPT,1):5 I '$T D SHOWWHO^PRCPULOC(445,PRCPINPT_"-1",0),R^PRCPUREP Q
 D ADD^PRCPULOC(445,PRCPINPT_"-1",0,"Receive Purchase Order")
 ;
 S ORDERNO=$$ORDERNO^PRCPUTRX(PRCPINPT)
 S LINEDA=0 F  S LINEDA=$O(^TMP($J,"PRCPPOLMREC",LINEDA)) Q:'LINEDA  S DATA=^(LINEDA) D
 .   S ITEMDA=$P(DATA,"^"),QTYRECVE=$P(DATA,"^",2),TOTCOST=$P(DATA,"^",3),TRANDA=$P(DATA,"^",4)
 .   I '$D(^PRCP(445,PRCPINPT,1,ITEMDA,0)) S %=$G(^TMP($J,"PRCPPOLMCOS",LINEDA)) D:$P(%,"^",2) COSTCNTR^PRCPUCC($P(%,"^",2),PRCPINPT,$P(%,"^",3),TOTCOST) Q
 .   ;
 .   ;  for items stored in the inventory point
 .   ;  update beginning balance
 .   I '$D(^PRCP(445.1,PRCPINPT,1,ITEMDA,1,$E(DT,1,5),0)) D BALANCE^PRCPUBAL(PRCPINPT,ITEMDA,$E(DT,1,5))
 .   ;
 .   ;  update inventory point
 .   S ITEMDATA=^PRCP(445,PRCPINPT,1,ITEMDA,0)
 .   S $P(ITEMDATA,"^",7)=$P(ITEMDATA,"^",7)+QTYRECVE
 .   S $P(ITEMDATA,"^",27)=$P(ITEMDATA,"^",27)+TOTCOST
 .   ;  update average cost
 .   S $P(ITEMDATA,"^",22)=0,QUANTITY=$P(ITEMDATA,"^",7)+$P(ITEMDATA,"^",19)
 .   I QUANTITY>0 S $P(ITEMDATA,"^",22)=$J($P(ITEMDATA,"^",27)/QUANTITY,0,3) I $P(ITEMDATA,"^",22)'>0 S $P(ITEMDATA,"^",22)=0
 .   ;  update last cost in invpt
 .   S $P(ITEMDATA,"^",15)=$J(TOTCOST/QTYRECVE,0,3),$P(ITEMDATA,"^",3)=DT
 .   S ^PRCP(445,PRCPINPT,1,ITEMDA,0)=ITEMDATA
 .   ;
 .   ;  update last cost for supply whse vendor in IM file
 .   I PRCPTYPE="W",$D(^PRC(441,ITEMDA,2,+$O(^PRC(440,"AC","S",0)),0)) S $P(^(0),"^",2)=$S($P(ITEMDATA,"^",15)>$P(ITEMDATA,"^",22):$P(ITEMDATA,"^",15),1:$P(ITEMDATA,"^",22))
 .   ;  update due-in
 .   D OUTST^PRCPUTRA(PRCPINPT,ITEMDA,TRANDA,-QTYRECVE)
 .   ;  update receipt history
 .   D RECEIPTS^PRCPUSAG(PRCPINPT,ITEMDA,QTYRECVE)
 .   ;  update drug accountability
 .   I $G(DRUGACCT) S %=+$P(ITEMDATA,"^",29) S:'% %=1 D EN^PSAGIP(PRCPINPT,ITEMDA,QTYRECVE*%,TRANDA,PRCPORDN,"RC"_ORDERNO,TOTCOST)
 .   ;  transaction register
 .   I ORDERNO D
 .   .   K PRCPPOL1
 .   .   S PRCPPOL1("QTY")=QTYRECVE,(PRCPPOL1("INVVAL"),PRCPPOL1("SELVAL"))=TOTCOST,PRCPPOL1("PKG")=$P(DATA,"^",5),PRCPPOL1("2237PO")=PRCPORDN,PRCPPOL1("REF")=$E($P(PRCPORDN,"-",2))_$E($P(PRCPORDN,"-",2),3,6)
 .   .   D ADDTRAN^PRCPUTRX(PRCPINPT,ITEMDA,"RC",ORDERNO,.PRCPPOL1)
 ;
 I $G(DRUGACCT) D EX^PSAGIP
 ;  enter receiving information for partial
 S Y="" D ENCODE^PRCHES2(PRCPORDR,PRCPPART,+DUZ,.Y) I Y>0 D NOW^%DTC S $P(^PRC(442,PRCPORDR,11,PRCPPART,0),"^",17,18)=%_"^"_+DUZ
 ;  clean up outstanding transactions
 I $P(^PRC(442,PRCPORDR,11,PRCPPART,0),"^",9)="F" D
 .   S REFDA=0 F  S REFDA=$O(^PRC(442,PRCPORDR,13,REFDA)) Q:'REFDA  S TRANDA=$P(^(REFDA,0),"^"),LINEDA=0 F  S LINEDA=$O(^PRCS(410,TRANDA,"IT",LINEDA)) Q:'LINEDA  D KILLTRAN^PRCPUTRA(PRCPINPT,+$P(^(LINEDA,0),"^",5),TRANDA)
 K X S X(1)="***** RECEIVING HAS BEEN POSTED *****" D DISPLAY^PRCPUX2(2,40,.X)
 D CLEAR^PRCPULOC(445,PRCPINPT_"-1",0)
 L -^PRCP(445,PRCPINPT,1)
 K VALMBCK
 I PRCPTYPE'="W" D R^PRCPUREP Q
 ;
 ;  create code sheets
 K X S X(1)="The program will automatically create and transmit the code sheets to Austin.  Please verify the accuracy of the data and submit adjustment code sheets if necessary."
 D DISPLAY^PRCPUX2(2,75,.X)
 S PRCPFLAG=0,PONO=PRCPORDN,TRANID="RC"_ORDERNO
 S ISMSFLAG=$$ISMSFLAG^PRCPUX2(PRC("SITE")) I ISMSFLAG'=2 D DQ^PRCPSLOR
 I ISMSFLAG=2 D DQ^PRCPSMPR
 D R^PRCPUREP
 Q
