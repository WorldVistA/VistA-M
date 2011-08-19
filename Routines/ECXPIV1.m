ECXPIV1 ;ALB/JAP,BIR/DMA-Store Data from IV Package into 728.113 ; 03 Nov 95 / 12:58 PM
 ;;3.0;DSS EXTRACTS;**8,24**;Dec 22, 1997
 ;called from the IV routine PSIVSTAT
 ;load IV data into intermediate file #728.113
 N DA,DIK
 I '$D(^ECX(728.113)) Q
 L +^ECX(728.113,0):1 Q:'$T
 S EC=$O(^ECX(728.113,999999999),-1),EC=EC+1
 S ^ECX(728.113,EC,0)=EC_U_ECUD L -^ECX(728.113,0)
 S DA=EC,DIK="^ECX(728.113," D IX^DIK
 K EC
 Q
