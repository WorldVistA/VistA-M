DGAINP0 ;ALB/RMO - Calculate 45 Patient Days of Care for Psych on AMIS 334 ; 14 MAY 90 11:10 am
 ;;5.3;Registration;;Aug 13, 1993
 ;=======================================================================
 ;The Psych 1-45 patient days of care are calculated by looping
 ;through the admission and transfer movements.
 ;
 ;Input:
 ; DGBOM   -First day of Month/Year in internal date format
 ; DGEOM   -Last day of Month/Year in internal date format
 ;
 ;Output:
 ; DGL45   -Array contains 1-45 day psych stats by division
 ;=======================================================================
START ;Starting 45 days Prior to the BOM check Admissions and Transfers
 S DGMVTP="^2^3^25^26^" F I=0:0 S I=$O(^DG(40.8,I)) Q:'I  S DGL45(I)=0
 S X1=DGBOM,X2=-45 D C^%DTC S DGSTDT=X,X1=DGEOM,X2=1 D C^%DTC S DGENDT=X
 F DGPMTT="ATT1","ATT2" F DGPMTDT=DGSTDT:0 S DGPMTDT=$O(^DGPM(DGPMTT,DGPMTDT)) Q:'DGPMTDT!(DGPMTDT>DGENDT)  S DGPMVDT=DGPMTDT\1 D MVT
 ;
Q K DFN,DGABD,DGABF,DGADM,DGBDT,DGDIV,DGDMDT,DGDV,DGEDT,DGENDT,DGLOD,DGLSD,DGLSDT,DGMVTP,DGNPF,DGPM0,DGPMCA,DGPMCA0,DGPMDT,DGPMI,DGPMTDT,DGPMTT,DGPMVDT,DGREC,DGSEG,DGSTDT,DGTMDT,DGW0,I,X,X1,X2
 Q
 ;
MVT ;Check Patient Movements associated with Psych Service
 F DGPMI=0:0 S DGPMI=$O(^DGPM(DGPMTT,DGPMTDT,DGPMI)) Q:'DGPMI  I $D(^DGPM(DGPMI,0)) S DGPM0=^(0) D SER I DGSEG S DGDIV=DGDV D CHK
 Q
 ;
CHK ;Check Corresponding Admission Movements
 Q:$P(DGPM0,"^",18)=13!($P(DGPM0,"^",18)=44)  ;NHCU/DOM Transfer
 S DFN=+$P(DGPM0,"^",3),DGPMCA=+$P(DGPM0,"^",14),DGPMCA0=$S($D(^DGPM(DGPMCA,0)):^(0),1:0) Q:'DGPMCA0
 S DGPMDT=$O(^DGPM("APMV",DFN,DGPMCA,(9999999.9999999-DGPMTDT))) I DGPMDT,$D(^DGPM(+$O(^(DGPMDT,0)),0)) S DGPM0=^(0) D SER Q:DGSEG
 S DGADM=$P(DGPMCA0,"^"),DGDMDT=$S($D(^DGPM(+$P(DGPMCA0,"^",17),0)):$P(^(0),"^"),1:0)\1
 S X1=DGPMVDT,X2=44 D C^%DTC S DGLSDT=X,DGBDT=DGPMVDT,DGTMDT=0,(DGNPF,DGABF)=0
 F DGPMDT=DGPMTDT:0 S DGPMDT=$O(^DGPM("APCA",DFN,DGPMCA,DGPMDT)) Q:'DGPMDT!(DGNPF)!(DGPMDT\1>DGLSDT)!(DGPMDT\1>DGEOM)  I $D(^DGPM(+$O(^(DGPMDT,0)),0)),$P(^(0),"^",2)=2 S DGPM0=^(0),DGTMDT=DGPMDT\1 D TRF
 D CAL
 Q
 ;
TRF ;Check Transfer Movement
 D SER S DGNPF=$S('DGSEG:1,1:0),DGABF=$S(DGMVTP[("^"_$P(DGPM0,"^",18)_"^"):1,1:0)
 Q
 ;
SER ;Check if Ward associate with the Movement is Psych Service
 S DGW0=$S($D(^DIC(42,+$P(DGPM0,"^",6),0)):^(0),1:""),DGDV=$S($D(^DG(40.8,+$P(DGW0,"^",11),0)):+$P(DGW0,"^",11),1:0),DGSEG=$S(DGDV&($P(DGW0,"^",3)="P"):334,1:0)
 Q
 ;
CAL ;Calculate Patient Days of Care Less than Forty-five
 S DGEDT=$S(DGTMDT&(DGNPF):DGTMDT,DGDMDT&(DGDMDT'>DGEOM)&(DGDMDT'>DGLSDT):DGDMDT,DGEOM>DGLSDT:DGLSDT,1:DGEOM)
 Q:DGEDT<DGBOM
 S DGBDT=$S(DGBDT<DGBOM:DGBOM,1:DGBDT)
 S X2=DGBDT,X1=DGEDT D ^%DTC S DGLOD=X
 D CALC^DGUTL2 S DGABD=DGREC
 S DGLSD=$S((DGADM\1)=DGDMDT:1,(DGTMDT&(DGNPF))!(DGDMDT&(DGDMDT'>DGEOM)&(DGDMDT'>DGLSDT))!(DGABF):0,1:1)
 S DGL45=DGLOD-DGABD+DGLSD
 S DGL45(DGDIV)=DGL45(DGDIV)+DGL45
 Q
