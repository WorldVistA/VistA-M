FBFHLL ;AISC/LEG-FPPS QUEUED INVOICE FILE ;9/10/2003
 ;;3.5;FEE BASIS;**61**;JULY 18, 2003
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
LOG(FBN,FBTYPE) ; processes batch and logs 0.00 invoices to FILE #163.5
 ; input
 ;   FBN - pointer to FEE BASIS BATCH file
 ;   FBTYPE - batch type (B3,B5,B9,BT)
 N FBX,FBERR
 S FBERR=""
 F FBX="FBN","FBTYPE" S:'$L(@FBX) FBERR=FBX_":0 LENGTH"
 I $L(FBERR) W FBERR Q
 I "B3,B5,B9"[FBTYPE D @FBTYPE ;either B3, B5, B9
 Q
 ;
B3 ; process outpatient/ancillary batch
 Q:FBTYPE'="B3"
 N DA,FBAAIN,FBAMTPD,FBINV,FBY0
 ;
 ; loop thru items in batch and build list of EDI invoices and their $
 S DA(3)=0 F  S DA(3)=$O(^FBAAC("AC",FBN,DA(3))) Q:'DA(3)  D
 . S DA(2)=0 F  S DA(2)=$O(^FBAAC("AC",FBN,DA(3),DA(2))) Q:'DA(2)  D
 . . S DA(1)=0
 . . F  S DA(1)=$O(^FBAAC("AC",FBN,DA(3),DA(2),DA(1))) Q:'DA(1)  D
 . . . S DA=0
 . . . F  S DA=$O(^FBAAC("AC",FBN,DA(3),DA(2),DA(1),DA)) Q:'DA  D
 . . . . Q:$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,3)),U)=""  ; not EDI
 . . . . S FBY0=$G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,0))
 . . . . S FBAAIN=$P(FBY0,U,16)
 . . . . S FBAMTPD=$P(FBY0,U,3)
 . . . . I FBAAIN]"" S FBINV(FBAAIN)=$G(FBINV(FBAAIN))+FBAMTPD
 ;
 ; loop thru EDI invoices and queue invoices with 0.00 payment
 S FBAAIN="" F  S FBAAIN=$O(FBINV(FBAAIN)) Q:FBAAIN=""  D
 . Q:$G(FBINV(FBAAIN))>0  ; not zero dollar invoice
 . D FILEQUE(FBAAIN,3)
 Q
 ;
B5 ; processes pharmacy batch
 Q:FBTYPE'="B5"
 N DA,FBAAIN,FBAMTPD,FBINV,FBRXY0,FBY0
 ;
 ; loop thru items in batch and build list of EDI invoices and their $
 S DA(1)=0 F  S DA(1)=$O(^FBAA(162.1,"AE",FBN,DA(1))) Q:'DA(1)  D
 . S DA=0 F  S DA=$O(^FBAA(162.1,"AE",FBN,DA(1),DA)) Q:'DA  D
 . . S FBY0=$G(^FBAA(162.1,DA(1),0))
 . . S FBRXY0=$G(^FBAA(162.1,DA(1),"RX",DA,0))
 . . Q:$P(FBY0,U,13)=""  ; not EDI
 . . S FBAAIN=$P(FBY0,U)
 . . S FBAMTPD=$P(FBRXY0,U,16)
 . . I FBAAIN]"" S FBINV(FBAAIN)=$G(FBINV(FBAAIN))+FBAMTPD
 ;
 ; loop thru EDI invoices and queue invoices with 0.00 payment
 S FBAAIN="" F  S FBAAIN=$O(FBINV(FBAAIN)) Q:FBAAIN=""  D
 . Q:$G(FBINV(FBAAIN))>0  ; not zero dollar invoice
 . D FILEQUE(FBAAIN,5)
 Q
 ;
B9 ; processes inpatient batch
 Q:FBTYPE'="B9"
 N DA,FBAAIN,FBAMTPD,FBY0
 ;
 ; loop thru items in batch and log 0.00 EDI invoices
 S DA=0 F  S DA=$O(^FBAAI("AC",FBN,DA)) Q:'DA  D
 . Q:$P($G(^FBAAI(DA,3)),U)=""  ; not EDI
 . S FBY0=$G(^FBAAI(DA,0))
 . S FBAAIN=$P(FBY0,U)
 . S FBAMTPD=$P(FBY0,U,9)
 . Q:FBAMTPD>0  ; not 0.00 invoice
 . D FILEQUE(FBAAIN,9)
 Q
 ;
PAIDLOG(FBINV) ; process EDI invoices from payment conf/canc message
 ; input FBINV array, passed by reference
 ;   format FBINV(fbtype,fbaain)=""
 ;   where fbtype = 3, 5, or 9
 ;         fbaain = invoice number
 ;
 N FBAAIN,FBTYPE
 ; loop thru type
 F FBTYPE=3,5,9 D
 . ; loop thru invoices
 . S FBAAIN="" F  S FBAAIN=$O(FBINV(FBTYPE,FBAAIN)) Q:FBAAIN=""  D
 . . ; queue invoice
 . . D FILEQUE(FBAAIN,FBTYPE)
 Q
 ;
FILEQUE(FBAAIN,FBTYPE) ; file invoice into FPPS Queue
 ; input
 ;   FBAAIN - invoice number
 ;   FBTYPE - type (3, 5, or 9)
 ;     where 3 = outpatient/ancillary - file 162
 ;           5 = pharmacy - file 162.1
 ;           9 = inpatient - file 162.5
 ;
 N FBDA,FBFDA
 ;
 ;
 S FBDA=$O(^FBHL(163.5,"B",FBAAIN,""),-1) ; last entry for invoice
 I FBDA,$D(^FBHL(163.5,"AC",0,FBDA)) Q  ; already queued to be sent
 ;
 S FBFDA(163.5,"+1,",.01)=FBAAIN
 S FBFDA(163.5,"+1,",1)=FBTYPE
 S FBFDA(163.5,"+1,",2)=0
 D UPDATE^DIE("","FBFDA")
 Q
 ;
CKFPPS(FBAAIN) ; checks if invoice was previously sent to FPPS
 ; input
 ;   FBAAIN - invoice number
 ; result
 ;   status (0,1,X) of 1st entry for invoice in file 163.5
 ;    where 0 = waiting to be transmitted
 ;          1 = transmitted
 ;          X = not logged
 N FBDA,FBRET,FBSTAT
 S FBRET=""
 ;
 ; loop thru entries for invoice (look until end or return value is true)
 S FBDA=0 F  S FBDA=$O(^FBHL(163.5,"B",FBAAIN,FBDA)) Q:'FBDA  D  Q:FBRET
 . S FBSTAT=$P($G(^FBHL(163.5,FBDA,0)),U,3)
 . I "^1^2^"[(U_FBSTAT_U) S FBRET=1 ; status=transmitted or acknowledged
 . I "^0^"[(U_FBSTAT_U) S FBRET=0 ; status=pending
 ;
 ; if no status found for invoice then return X for not logged
 I FBRET="" S FBRET="X"
 Q FBRET
 ;
 ;FBFHLL
