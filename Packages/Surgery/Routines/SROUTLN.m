SROUTLN ;BIR/SJA - UTILITY ROUTINE ;03/14/05
 ;;3.0; Surgery ;**142**;24 Jun 93
 ;
 Q
PROC ; put procedures and CPT code in array for display
 N SRDA,X,XX,Y K SRPROC S K=1,Y=$P($G(^SRO(136,SRTN,0)),"^",2),Y=$S(Y:$P($$CPT^ICPTCOD(Y),"^",2),1:"???")
 I Y'="???" D SSPRIN^SROCPT0
 S SRPROC(K)="CPT Codes: "_Y
OTH S SRDA=0 F  S SRDA=$O(^SRO(136,SRTN,3,SRDA)) Q:'SRDA  D
 .S Y=$P($G(^SRO(136,SRTN,3,SRDA,0)),"^"),Y=$S(Y:$P($$CPT^ICPTCOD(Y),"^",2),1:"???")
 .I Y'="???" D SSOTH^SROCPT0
 .I $L(Y)+$L(SRPROC(K))'>SRL S SRPROC(K)=SRPROC(K)_", "_Y Q
 .S K=K+1,SRPROC(K)=Y
 Q
