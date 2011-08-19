PRCVPOU ;WOIFO/AS-SEND PO AMENDMENT TO DYNAMED ; 01/24/05
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; PO amendment
 ; Input: PRCHPO (PO number)
 ;        PRCHAM (amendment number)
 ; Called from PRCHAM (Amendment to Purchase Order/Card)
 ;             PRCFFMOM (Amendment Processing)
 ;
 Q
ENT(PRCHPO,PRCHAM) ;
 N AMEND,PRCV,CHG,FLD,ITM,NPO,NXT,ALL,EXT,AMD,PRCVP,DIQ,DIC,DA,DR,DONE
 S AMEND=0,DIQ="PRCVP",DIQ(0)="IE",DIC=442,DA=PRCHPO,DR=".07;7;62"
 D EN^DIQ1
 S EXT=PRCVP(442,PRCHPO,62,"E"),DONE=0
 I EXT']"" S EXT=PRCVP(442,PRCHPO,.07,"E")
 S $P(EXT,"^",2)=PRCVP(442,PRCHPO,7,"I") ; delivery date
 F  S AMEND=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND)) Q:AMEND'>0  D
 . S NXT="E"_+AMEND
 . I $T(@NXT)'="" D @NXT
 Q
E22 ;Line Item Delete
 S FLD=0 K PRCV("DEL"),^TMP("PRCV442A",$J,PRCHPO)
 F  S FLD=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",22,FLD)) Q:FLD'>0  D
 . S CHG=0
 . F  S CHG=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",22,FLD,CHG)) Q:CHG'>0  D
 .. S ITM=+$P($G(^PRC(442,PRCHPO,6,PRCHAM,3,CHG,0)),"^",4)
 .. S PRCV("DEL",ITM)=""
 .. ; only item with DM document ID will be passed back
 .. D ITEM
 .. ; Insert Amendment Type of "Line Item Delete"
 .. S:$D(^TMP("PRCV442A",$J,PRCHPO,ITM)) $P(^(ITM),"^",14)=2
 ;    create header only if item exist
 I $D(^TMP("PRCV442A",$J,PRCHPO)) D 
 . D HEADER
 . ;    If there is no Line Item Edit, send out this message
 . I '$D(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",23)) D SEND
 Q
E23 ;Line Item Edit
 ;  If delivery date changed, send all items, Quit
 I PRCFA("DLVDATE")'=$P(EXT,"^",2) S ALL=1 D ALLITEM Q
 ;
 S FLD=0 K PRCV("EDT")
 ;    remove duplicated line item
 F  S FLD=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",23,FLD)) Q:'FLD  D
 . S CHG=0
 . F  S CHG=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",23,FLD,CHG)) Q:'CHG  D
 .. S ITM=+$P($G(^PRC(442,PRCHPO,6,PRCHAM,3,CHG,0)),"^",4)
 .. ;   no transmission if item already deleted
 .. S:'$D(PRCV("DEL",ITM)) PRCV("EDT",ITM)=""
 ;
 ; Process edited line items after duplicated lines removed
 S ITM=0
 F  S ITM=$O(PRCV("EDT",ITM)) Q:'ITM  D
 . D ITEM
 . ; Insert Amendment Type of "Line Item Edit"
 . S:$D(^TMP("PRCV442A",$J,PRCHPO,ITM)) $P(^(ITM),"^",14)=1
 ;
 ;    create header only if item exist
 I $D(^TMP("PRCV442A",$J,PRCHPO)) D HEADER,SEND S DONE=1
 Q
E31 ; Change Vendor
 ;    Send new vendor only
 ;       New vendor already in 442
 ;          No need to find it elsewhere
 S ALL=3
 D ALLITEM S DONE=1
 Q
E32 ; Replace PO Number
 ;    Send new PO number information including DynaMed Doc ID
 S NPO=$P($G(^PRC(442,PRCHPO,23)),"^",4)
 Q:'NPO
 S PRCHPO=NPO
 S ALL=4
 D ALLITEM
 Q
E34 ; Authority Edit
 Q:DONE    ; if Change Vendor and Line Edit already done.
 ;  If change to delivery date only without any other amendment
 ;  Authority Edit became No Charge Amendment
 I $P($G(^PRC(442,PRCHPO,6,PRCHAM,0)),"^",4)'=5,PRCFA("DLVDATE")'=$P(EXT,"^",2) D
 . S ALL=1 D ALLITEM
 ;    Send PO Cancelled only
 Q:$P($G(^PRC(442,PRCHPO,6,PRCHAM,0)),"^",4)'=5
 ; change amendment type to Cancel
 S ALL=5
 D ALLITEM
 Q
 ;
HEADER ;
 ; Get PO header information
 D PO^PRCV442A(PRCHPO)
 ;   Change transaction type to PO Amendment
 S $P(^TMP("PRCV442A",$J,PRCHPO),"^",2)=2
 ;   Amendment signed date
 S $P(^TMP("PRCV442A",$J,PRCHPO),"^",7)=$P($G(^PRC(442,PRCHPO,6,PRCHAM,1)),"^",3)
 Q
ITEM ;
 D ITEM^PRCV442A(PRCHPO,ITM,EXT)
 Q
ALLITEM ;
 ; If header level amendment, send all items to DynaMed
 ;     1.   Collect all deleted item
 K ^TMP("PRCV442A",$J,PRCHPO),PRCV("DEL")
 S AMD=0 F  S AMD=$O(^PRC(442,PRCHPO,6,AMD)) Q:'AMD  D
 . S FLD=0
 . F  S FLD=$O(^PRC(442,PRCHPO,6,AMD,3,"AC",22,FLD)) Q:'FLD  D
 .. S CHG=0
 .. F  S CHG=$O(^PRC(442,PRCHPO,6,AMD,3,"AC",22,FLD,CHG)) Q:'CHG  D
 ... S ITM=+$P($G(^PRC(442,PRCHPO,6,AMD,3,CHG,0)),"^",4)
 ... S PRCV("DEL",ITM)=""
 ;     2.   pickup all items to DynaMed except deleted items
 S ITM=0 F  S ITM=$O(^PRC(442,PRCHPO,2,ITM)) Q:'ITM  D
 . I '$D(PRCV("DEL",ITM)) D ITEM
 . S:$D(^TMP("PRCV442A",$J,PRCHPO,ITM)) $P(^(ITM),"^",14)=ALL
 ;    create header and send only if item exist
 I $D(^TMP("PRCV442A",$J,PRCHPO)) D HEADER,SEND
 Q
SEND ;
 ;  Do not send if no item collected
 Q:'$O(^TMP("PRCV442A",$J,PRCHPO,0))
 M ^TMP("ASU442A",$J)=^TMP("PRCV442A",$J)
 D EN^PRCVPOSD(PRCHPO)
 Q
