PSOTPCUL ;BIR/RTR-Utility Routine for TBP Project ;08/09/03
 ;;7.0;OUTPATIENT PHARMACY;**145,160**;DEC 1997
 ;
EN(PSOTRXN) ;CPRS call to determine if an RX is a TPB Rx
 ;PSOTRXN = internal Rx number
 ;OUTPUT = 1 for TBP Rx, 0 for non-TPB Rx
 Q:'$G(PSOTRXN) 0
 Q $S($P($G(^PSRX(PSOTRXN,"TPB")),"^"):1,1:0)
 ;
ACTRX(DFN,TPB) ; Checks if Patient has at least one Active Rx on File
 ; Input: DFN: Patient IEN (#2)
 ;        TPB: 0 - Looks for active VA prescriptions only (Default)
 ;             1 - Looks for active TPB prescriptions only
 ;             2 - Looks for active VA or TPB prescriptions
 ;Output: 1 - Active Rx found / 0 - None found
 ;
 N SEQ,ACTRX,EXPDT
 I '$G(DFN) Q 0
 S TPB=+$G(TPB),(SEQ,ACTRX)=0
 F  S SEQ=$O(^PS(55,DFN,"P",SEQ)) Q:'SEQ  D  I ACTRX Q
 . S RX=$G(^PS(55,DFN,"P",SEQ,0)),TPBRX=+$G(^PSRX(RX,"TPB"))
 . I '$$ACTIVE(RX) Q
 . I TPB=2 S ACTRX=1 Q 
 . I TPB=1,TPBRX S ACTRX=1 Q
 . I TPB=0,'TPBRX S ACTRX=1 Q
 ;
 Q ACTRX
 ;
ACTIVE(RX) ; Checks if Rx is Active or not
 N RXSTS,TPBRX,EXPDT
 S RXSTS=+$G(^PSRX(RX,"STA")) I RXSTS>9,(RXSTS'=16) Q 0
 S EXPDT=$P($G(^PSRX(RX,2)),"^",6) I EXPDT,EXPDT<DT Q 0
 Q 1
 ;
TPBSC(LOC) ; Checks if Location Stop Code is from TPB Clinic
 ;
 N I,J,Z0,C1,C2,CODE
 F I=322,323,350 F J="000",185,186,187 S CODE(I_J)=""
 S Z0=$G(^SC(+LOC,0)) I Z0="" Q 0
 S C1=$P($G(^DIC(40.7,+$P(Z0,U,7),0)),U,2)
 S C2=$P($G(^DIC(40.7,+$P(Z0,U,18),0)),U,2)
 S C1=$E(C1_"000",1,3),C2=$E(C2_"000",1,3)
 I $D(CODE(C1_C2)) Q 1
 Q 0
 ;
SXMY(GRP) ; Set XMY array with users from Mail Group GRP
 N GRPIEN,MBRIEN,CDRIEN
 ;
 I $G(GRP)="" Q
 S GRPIEN=$O(^XMB(3.8,"B",GRP,"")) I 'GRPIEN Q
 S CDRIEN=$$GET1^DIQ(3.8,GRPIEN,5.1,"I")
 K XMY S MBRIEN="" I CDRIEN'="" S XMY(CDRIEN)=""
 F  S MBRIEN=$O(^XMB(3.8,GRPIEN,1,"B",MBRIEN)) Q:'MBRIEN  D
 . S XMY(MBRIEN)=""
 Q
