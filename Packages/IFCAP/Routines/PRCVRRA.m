PRCVRRA ;WOIFO/AS-SEND RECEIVING REPORT ADJUSTMENT TO DYNAMED ; 01/24/05
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; PO amendment
 ; Input: PRCVPO (PO number)
 ;        PRCVADJ (Adjustment number from PRCHAV)
 ; Called from PRCHAM
 ;
 Q
ENT(PRCVPO,PRCVADJ) ;
 N PRCV1,PRCV,PRCVCHG,PRCVFLD,PRCVNPO,PRCVAMD,PRCVNXT,PRCVALL,PRCVEXT
 N PRCVP,PRCVERR
 ;  Get partial header information to PRCVEXT
 S PRCV1=0
 D GETS^DIQ(442,PRCVPO_",",".07;7;62","IE","PRCVP")
 S PRCVEXT=PRCVP(442,PRCVPO_",",62,"E")
 I PRCVEXT']"" S PRCVEXT=PRCVP(442,PRCVPO_",",.07,"E")
 S $P(PRCVEXT,"^",2)=PRCVP(442,PRCVPO_",",7,"I") ; delivery date
 ;
 D HEADER
 F  S PRCV1=$O(^PRC(442,PRCVPO,2,PRCV1)) Q:'PRCV1  D
 . Q:'$D(^PRC(442,PRCVPO,2,PRCV1,3,PRCVADJ,0))
 . D ITEM^PRCV442A(PRCVPO,PRCV1,PRCVEXT,.PRCVERR)
 . I 'PRCVERR D
 .. D RR^PRCV442A(PRCVPO,PRCV1,PRCVADJ,.PRCVERR,1)
 .. I $D(^TMP("PRCV442A",$J,PRCVPO,PRCV1)) S $P(^(PRCV1),"^",14)=1
 D SEND
 K ^TMP("PRCV442A",$J)
 Q
HEADER ;
 ; Get PO header information
 D PO^PRCV442A(PRCVPO)
 ;   Change transaction type to RR Adjustment
 S $P(^TMP("PRCV442A",$J,PRCVPO),"^",2)=4
 Q
SEND ;
 ;  Do not send if no item collected
 Q:'$O(^TMP("PRCV442A",$J,PRCVPO,0))
 ;   Adjustment signed date
 S $P(^TMP("PRCV442A",$J,PRCVPO),"^",7)=$P($G(^PRC(442,PRCVPO,6,PRCHAM,1)),"^",3)
 D EN^PRCVPOSD(PRCVPO)
 Q
