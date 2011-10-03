FBFHLU ;OIFO/SAB-FPPS HL UTILITIES ;08/24/2003
 ;;3.5;FEE BASIS;**61**;JULY 18, 2003
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
PAYMETH(FBCKNO) ; payment method extrinsic function
 ; input
 ;   FBCHNO - check number
 ; result is string value
 ;   CC, EFT, CHK
 ;   
 I $G(FBCKNO)="" Q "" ; no check number
 I $E(FBCKNO,1,2)="CC" Q "CC" ; credit card payment
 I $L(FBCKNO)<8 Q "EFT" ; electronic funds transfer
 Q "CHK" ; all other are paper check
 ;
POST(FBAAIN,FBFLAG,FBMSG) ; Post Exception/Warning
 ; input
 ;   FBAAIN - invoice number
 ;   FBFLAG - flag (E or W) for (E)xception or (W)arning
 ;            exceptions will prevent transmit of invoice to FPPS
 ;            warnings will not prevent transmit 
 ;   FBMSG  - text of message
 ;
 N FBI
 ; determine last seq number used for invoice
 S FBI=$O(^TMP($J,"FB"_FBFLAG,FBAAIN," "),-1)
 ; post new message
 S ^TMP($J,"FB"_FBFLAG,FBAAIN,FBI+1)=FBMSG
 Q
 ;
STANO(FBBATCH) ; station number extrinsic function
 ; Input
 ;   FBBATCH - ien of entry in FEE BASIS BATCH (#161.7) file
 ; Returns station number or NULL value
 ;
 N FBRET,FBY
 S FBRET=""
 I $G(FBBATCH) D
 . S FBY=$G(^FBAA(161.7,FBBATCH,0))
 . S FBRET=$$SUB^FBAAUTL5(+$P(FBY,U,8)_"-"_$P(FBY,U,2))
 . Q:FBRET]""  ; have value from IFCAP API
 . ; else get from Institution file based on fee site parameters
 . S FBRET=$$GET1^DIQ(161.4,"1,","27:99")
 Q FBRET
 ;
LAST(FBAAIN) ; function to return last entry in file 163.5 for invoice
 ; input
 ;   FBAAIN - invoice number
 ; result is string with ien of last entry in file or null
 N FBRET
 S FBRET=""
 I $G(FBAAIN) S FBRET=$O(^FBHL(163.5,"B",FBAAIN," "),-1)
 Q FBRET
 ;
 ;FBFHLU
