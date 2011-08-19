PRCV442B ;WOIFO/CC-GET DATA WHEN ITEM DELETED, SET UP AUDIT FILE;1/29/05
V ;;5.1;IFCAP;**81,86**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
RRAUD(POIEN,PRCV,PRCVCR,PRCVDAT) ; add deleted Receiving Report to audit file
 ;
 ;   POIEN  = the ien of the purchase order from which the receiving
 ;            report is being deleted.
 ;   PRCV   = the string of info about the item (from PRCV442A)
 ;            DM DOC ID ^ Item ien ^ line item # ^ 2237 ien ^ UOP ^ 
 ;            qty ordered ^ unit price ^ NIF ^ pkg mult ^ qty rec'd
 ;            ^ total item cost ^ total discount ^ delivery date
 ;   PRCVCR = the date/time the receiving report was created
 ;  PRCVDAT = The date/time of deletion processing
 ;
 N PRCVRA,PRCVRN,PRCVIEN,PRCVY
 S PRCVID=$P(PRCV,"^",1) Q:PRCVID']""  ; DM DOC ID
 S PRCVRN=$O(^PRCV(414.02,"B",PRCVID,0)) ; find DM DOC ID record
 I +PRCVRN'>0 D MAIL("X1",POIEN,PRCVID,$P(PRCV,"^",2)) Q  ; notify users that DM DOC ID record not in audit file
 S PRCVIEN="+1,"_PRCVRN_","
 S PRCVRA(414.021,PRCVIEN,.01)=PRCVDAT ; D/T RR deleted
 S PRCVRA(414.021,PRCVIEN,1)=DUZ ; user deleting RR
 S PRCVRA(414.021,PRCVIEN,2)=PRCVCR ; RR create D/T
 S PRCVRA(414.021,PRCVIEN,3)=0-$P(PRCV,"^",10) ; Qty
 S PRCVRA(414.021,PRCVIEN,4)=0-$P(PRCV,"^",11) ; total cost
 S PRCVRA(414.021,PRCVIEN,5)=0-$P(PRCV,"^",12) ; discount
 D UPDATE^DIE("","PRCVRA","PRCVY")
 I $D(^TMP("DIERR",$J)) D MAIL("X5",POIEN,PRCVID,$P(PRCV,"^",2)) ; tell users that Audit file could not be updated
 S $P(^TMP("PRCV442A",$J,POIEN),"^",7)=PRCVDAT
 Q
 ;
DELAUD(PRCVID,PRCVDATE,PRCVDUZ,POIEN,PRCVITEM,PRCVIT) ; UPDATE AUDIT FILE FOR DELETED ITEMS
 ;
 ; PRCVID   = the DM Doc ID of the item being deleted
 ; PRCVDATE = the date/time the item is deleted or PO is cancelled
 ; PRCVDUZ  = the user deleting the item or canceling the PO
 ; POIEN    = the ien of the purchase order from which the receiving
 ;            report is being deleted.
 ; PRCVITEM = the item number
 ; PRCVIT   = set to 1 if deleted at line item level, else PC cancel
 ;
 N PRCVD,PRCVDA,PRCVIEN,PRCVY
 S PRCVY="C" I PRCVIT=1 S PRCVY="D"
 S PRCVDA=$O(^PRCV(414.02,"B",PRCVID,0)) ; find DM DOC ID record
 I PRCVDA']"" D MAIL(PRCVY_1,POIEN,PRCVID,PRCVITEM) Q  ; DM DOC ID not in audit file
 S PRCVD(414.02,PRCVDA_",",8)=PRCVDATE
 S PRCVD(414.02,PRCVDA_",",9)=PRCVDUZ
 D UPDATE^DIE("","PRCVD")
 I $D(^TMP("DIERR",$J)) D MAIL(PRCVY_5,POIEN,PRCVID,PRCVITEM) ; tell user audit file not updated
 Q
 ;
 ;
DELITEM(POIEN) ; delete line item, get key info for DYNAMED
 ; called from "AK" cross ref in DD - .01 of file 442.01 (Item multiple)
 ;
 ; POIEN = the ien of the purchase order (file 442)
 ;
 N PRCV,PRCVP
 S PRCVP=""
 D OP^XQCHK I $P(XQOPT,"^",1)="PRCHPC PO REMOVE 2237" Q  ; this option does not cancel item out of IFCAP
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1 Q  ; DM interface not active
 D GETS^DIQ(442,POIEN_",",".01;.02;.07;5;7;62","IE","PRCVP") ; get PO data
 S $P(PRCV,"^",7)=POIEN,POIEN=POIEN_","
 I $D(^TMP("DIERR",$J)) G DELITEM1 ; PO data not on file,send to DM anyway
 S $P(PRCV,"^",8)=PRCVP(442,POIEN,.02,"I") ; MOP (#.02 - n0,p2)
 S $P(PRCV,"^",1)=PRCVP(442,POIEN,.01,"E") ; PO# (#.01 n0,p1)
 S $P(PRCV,"^",4)=PRCVP(442,POIEN,5,"I") ; vendor IEN (#5 n1 p1)
 S $P(PRCV,"^",5)=PRCVP(442,POIEN,62,"E") ; for PC orders MOP=25, 2237 is in #62 N23,P23
 S $P(PRCV,"^",6)=PRCVP(442,POIEN,.07,"E") ; for inv/rec MOP=1, 2237 is in #.07 - n0,p12
 S $P(PRCV,"^",2)=PRCVP(442,POIEN,7,"I") ; delivery date (#7 n0p10)
DELITEM1 S $P(PRCV,"^",10)=$$NOW^XLFDT
 S $P(PRCV,"^",11)=DA
 ;
 ; get DUZ
 S $P(PRCV,"^",3)=DUZ
 ;
 ; X1 is the array of variables set in the execution of the 'AK' cross reference
 S X1(999999)=PRCV ; save PO data to variables passed to background job
 ;
 D OPKG^XUHUI("","PRCV 442 ITEM DELETE","K","AK") ; invoke background job
 K X1(999999) ; not to go back DD
 Q
 ;
DELJOB ; send deleted item's info to DynaMed (collected by DELITEM subroutine)
 ; called from protocol PRCV 442 ITEM DELETE and jobbed by TaskMan
 ; builds
 ; PRCVI (string for each item)  
 ;   DM DOC ID ^ Item ien ^ line item # ^ 2237 ien ^ UOP ^ qty ordered
 ;   ^ unit price ^ NIF ^ pkg mult ^ qty rec'd ^ total item cost ^
 ;   total discount ^ delivery date
 ; PRCV (header) variable -
 ;   PO# ^ txn type ^ DUZ ^ vendor IEN ^ FMS vendor # ^Alt add ind ^
 ;   txn D/T ^ Station# ^ Purchasing Station
 ;
 N POIEN,PRCV,PRCVERR,PRCVI,PRCVP,PRCVV,PRCV2237
 ; QUIT IF mop'1 AND '=25
 S PRCVP=XUHUIX1(999999) I $P(PRCVP,"^",8)'=1,$P(PRCVP,"^",8)'=25 Q
 S POIEN=$P(PRCVP,"^",7)
 K ^TMP("PRCV442A",$J,POIEN)
 S PRCV=$P(PRCVP,"^",1,4),$P(PRCV,"^",7)=$P(PRCVP,"^",10)
 ; get FMS vendor ID & alt addr code from file 440, #34&#35 - n3 p4&5
 I $P(PRCV,"^",4)]"" D GETS^DIQ(440,$P(PRCV,"^",4)_",","34:35","E","PRCVV")
 I $D(^TMP("DIERR",$J)) G DELJOB1 ; vendor data not on file
 S $P(PRCV,"^",2)=5 ; DELETE
 S $P(PRCV,"^",5)=PRCVV(440,$P(PRCV,"^",4)_",",34,"E") ; FMS vendor ID
 S $P(PRCV,"^",6)=PRCVV(440,$P(PRCV,"^",4)_",",35,"E") ; FMA alt add ind
 ; get Station Number
DELJOB1 S $P(PRCV,"^",8)=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S ^TMP("PRCV442A",$J,POIEN)=PRCV
 S PRCVI=XUHUIX1(2)_"^"_XUHUIX1(3)_"^"_XUHUIX1(1)_"^^^"_XUHUIX1(4)_"^"_XUHUIX1(7)_"^^"_XUHUIX1(6)
 S $P(PRCVI,"^",5)=$$GET1^DIQ(420.5,XUHUIX1(5),.01,"E") ; UOP
 S $P(PRCVI,"^",8)=$$GET1^DIQ(441,XUHUIX1(3),51) ; NIF
 S $P(PRCVI,"^",13)=$P(PRCVP,"^",2) ; DELIVERY DATE FOR PO
 S PRCV2237=XUHUIX1(8)
 I PRCV2237]"" S PRCV2237=$$GET1^DIQ(410,PRCV2237,.01,"E")
 I PRCV2237']"" S PRCV2237=$P(PRCVP,"^",6)
 I PRCV2237']"" S PRCV2237=$P(PRCVP,"^",5)
 S $P(PRCVI,"^",4)=PRCV2237
 D DELAUD($P(PRCVI,"^",1),$P(PRCV,"^",7),$P(PRCV,"^",3),POIEN,$P(PRCVI,"^",2),1)
 S ^TMP("PRCV442A",$J,POIEN,$P(PRCVP,"^",11))=PRCVI
 I $O(^TMP("PRCV442A",$J,POIEN,""))']"" S PRCVERR=1 D Q  Q  ; no DynaMed items
 D EN^PRCVPOSD(POIEN)
 Q
 ;
MAIL(PRCVCODE,PRCVPIEN,PRCVID,PRCVITEM) ; PREPARE VALUES FOR MESSAGE TO USERS
 ;
 ; $E(PRCVCODE,1) = U if the error occurred approving a PO
 ;                = C if the error occurred canceling a PO
 ;                = D if error occurred while deleting a line item
 ;                = R if the error occurred signing a Receipt Report
 ;                = X if the error occurred deleting a Receipt Report
 ; $E(PRCVCODE,2) = DM Doc ID not in Audit File
 ;                = 2 if the PO data could not be found
 ;                = 3 if the item data could not be found
 ;                = 4 if the receiving report info for item was not found
 ;                = 5 if data could not be saved in audit file
 ;
 ; PRCVPIEN       IEN of selected purchase order
 ; PRCVID         DM Doc ID of affected item
 ; PRCVITEM       ien of item (item#)
 ;
 N PRCVSITE,PRCVFCP,PRCVPO,XMB
 K ^TMP($J,"PRCV442B")
 S XMB(1)=$S($E(PRCVCODE,1)="C":"cancelling a PC order",$E(PRCVCODE,1)="D":"deleting a line item from a purchase order",1:"deleting a receiving report")
 S XMB(2)=PRCVID
 S XMB(3)=" "_PRCVID_" is not in file 414.02 - can't add related data"
 I $E(PRCVCODE,2)=5 D
 . S XMB(3)="System can't update Audit File (414.02) for "_PRCVID
 . D TMPERR
 S PRCVPO=$P($G(^PRC(442,PRCVPIEN,0)),"^",1)
 S ^TMP($J,"PRCV442B",1)="Purchase Order# "_PRCVPO
 S ^TMP($J,"PRCV442B",2)="ITEM# "_PRCVITEM
 S ^TMP($J,"PRCV442B")=2
 S PRCVSITE=PRCVPO+0 I PRCVSITE=0 S PRCVSITE=PRC("SITE")
 S PRCVFCP=$P($G(^PRC(442,PRCVPIEN,0)),"^",3)
 S PRCVFCP=$P(PRCVFCP," ",1)
 D DMERXMB^PRCVLIC("PRCV442B",PRCVSITE,PRCVFCP)
 K ^TMP($J,"PRCV442B")
 Q
 ;
TMPERR ;
 ;
 ;
 N PRCJ,PRCK S PRCK=$G(^TMP($J,"PRCV442B")),PRCJ=0
 F  S PRCJ=$O(^TMP("DIERR",$J,PRCJ)) Q:PRCJ'?1.N  D
 . I $D(^TMP("DIERR",$J,PRCJ,"TEXT",1)) D
 . . S PRCK=PRCK+1,^TMP($J,"PRCV442B",PRCK)="Reason: "_^TMP("DIERR",$J,PRCJ,"TEXT",1)
 . . S:$D(^TMP("DIERR",$J,PRCJ,"PARAM","IENS")) ^TMP($J,"PRCV442B",PRCK)=$E(^TMP($J,"PRCV442B",PRCK),1,220)_"-IENS: "_^TMP("DIERR",$J,PRCJ,"PARAM","IENS")
 S:PRCK>0 ^TMP($J,"PRCV442B")=PRCK
 K ^TMP("DIERR",$J)
 Q
 ;
FCP(PRCVPO) ; return FCP for PO#
 ;
 ;    PRCVPO = the external purchase order number
 ;    returns -1 if the PO or its FCP cannot be found
 ;
 N PRCVF,PRCVI
 S PRCVF=-1
 S PRCVI=$O(^PRC(442,"B",PRCVPO,0))
 I PRCVI]"" D
 . S PRCVI=$$GET1^DIQ(442,PRCVI_",",1,"E")
 . I PRCVI]"" S PRCVF=$P(PRCVI," ",1)
 Q PRCVF
 ;
Q I PRCVERR K ^TMP("PRCV442A",$J)
 Q
