PSOHLNE4 ;BIR/LE - Process Edit Information from CPRS - CONTINUED FROM PSOHLNE3 ;02/27/04
 ;;7.0;OUTPATIENT PHARMACY;**201,225**;DEC 1997;Build 29
 ;
 ;This API is used to update the prescription file when ICD-9 diagnosis
 ; and SC/EI's are updated as a result of an e-sig in CPRS.
 Q
COPAY ;For IB, cancel copay charges if SC<50% and SC/EI changed and released; For PFS, send charge update msgs for SC 0-100%
 ;  must have PSODA,PSO,PSODAYS,PSOFLAG,PSOREF,PSOIB,PSOPAR7,PSOOLD,PSONW before call to PSOCPA
 N PSODA,PSO,PSODAYS,PSOFLAG,PSOREF,PSOIB,PSZ,PSOPAR7,PSOCSEQ,PSZ1,PSZ2,RELDAT,PSOOLD,PSONW,PSOSITE,PREA,PSOFLD,PSOPFS
 S PSODA=RXN,PSO=3,PSODAYS=$$GET1^DIQ(52,PSODA_",","8")
 S PSOOLD="Copay"
 S PSONW="No Copay"
 S PSOSITE=$P(^PSRX(PSODA,2),"^",9)
 S PSOPAR7=$G(^PS(59,PSOSITE,"IB"))
 S PSOFLAG=1  ;1 used here to eliminate display/print of messages.
CSORT ; get orig fill copay info if released.
 S RELDAT=$$GET1^DIQ(52,PSODA_",","31","I")
 I RELDAT'="" S PSOCSEQ("A",0)=$G(^PSRX(PSODA,"IB"))
 ;I RELDAT="" S PREA="R" D:'$G(PSOSI)&(PSOSCP<50)&($P($G(^PS(53,+$G(PTSTATUS),0)),"^",7)'=1) ACTLOG^PSOCPA G SET ;set act log when unreleased, but SC/EI changed copay
 I RELDAT="" S PREA="R" D:+$G(PSOCPAY)>0&(PSOIBQC[1&(PSOPIBQ'[1)) ACTLOG^PSOCPA G SET ;set act log when unreleased, but SC/EI changed copay
 ; get copay info for all released refills; if any
 F PSZ=0:0 S PSZ=$O(^PSRX(PSODA,1,PSZ)) Q:PSZ'>0  D
 . S RELDAT="",RELDAT=$$GET1^DIQ(52.1,PSZ_","_PSODA_",","17","I")
 . Q:RELDAT=""
 . S PSOCSEQ("A",PSZ)=$G(^PSRX(PSODA,1,PSZ,"IB"))
 ; Sort potential refills to be cancelled first starting with last fill
 ;    then orig fill then the rest of the entries.
 S (PSZ1,PSZ2,PSZ)="" F  S PSZ=$O(PSOCSEQ("A",PSZ),-1) Q:PSZ=""  D
 . I PSZ>0&($P(PSOCSEQ("A",PSZ),"^",2)'="") S PSZ1=PSZ1+1,PSOCSEQ("B",PSZ1,PSZ)="" Q
 . I PSZ>0&($P(PSOCSEQ("A",PSZ),"^",2)="") S PSZ2=PSZ2+1000,PSOCSEQ("B",PSZ2,PSZ)="" Q
 . I PSZ=0&($P(PSOCSEQ("A",PSZ),"^",4)'="") S PSZ1=PSZ1+1,PSOCSEQ("B",PSZ1,PSZ)="" Q
 . I PSZ=0&($P(PSOCSEQ("A",PSZ),"^",4)="") S PSZ2=PSZ2+1000,PSOCSEQ("B",PSZ2,PSZ)="" Q
 ;
 ;S (PSZ,PSZ1)="",PSOFLD=0,PREA="R" D:'$G(PSOSI)&(PSOSCP<50)&($P($G(^PS(53,+$G(PTSTATUS),0)),"^",7)'=1) ACTLOG^PSOCPA F  S PSZ1=$O(PSOCSEQ("B",PSZ1)) Q:PSZ1=""  D
 S (PSZ,PSZ1)="",PSOFLD=0,PREA="R" D:+$G(PSOCPAY)>0&(PSOIBQC[1&(PSOPIBQ'[1)) ACTLOG^PSOCPA F  S PSZ1=$O(PSOCSEQ("B",PSZ1)) Q:PSZ1=""  D
 . F  S PSZ=$O(PSOCSEQ("B",PSZ1,PSZ)) Q:PSZ=""  D
 .. S (PSOREF,PSOIB)="",PSOFLD=PSOFLD+1 S PREA="C" ;$S(PSOFLD=1:"R",1:"C")
 .. ;I PSOFLD>1
 .. S (PSOOLD,PSONW)=""
 .. S PSOREF=PSZ
 .. ;
 .. S PSOPFS="",PSOPFS=$P($S('PSOREF:$G(^PSRX(PSODA,"PFS")),1:$G(^PSRX(PSODA,1,PSOREF,"PFS"))),"^",1,2)
 .. I +$G(PSOPFS)>0&('$P($G(PSOPFS),"^",2)) K PSOPFS Q   ;don't send unreleased charge msg
 .. I +$G(PSOPFS)<1 K PSOPFS  ;invalid PFSS ACCT REF/ SEND TO IB
 .. I +$G(PSOPFS)>0 S PSOPFS="1^"_PSOPFS
 .. ;
 .. N TYPE S PSOIB=PSOCSEQ("A",PSOREF),TYPE=PSOREF
 .. I +$G(PSOPFS) D CHRG^PSOPFSU1(PSODA,PSOREF,"CG",PSOPFS) D:+$G(PSOCPAY)>0&(PSOIBQC[1&(PSOPIBQ'[1)) ACTLOG^PSOCPA Q  ;PFSS charge update only
 .. I PSOSCP<50 D RXED^PSOCPA  ;IB - if SC<50 and not billed via PFSS
SET S:$D(^PSRX(RXN,"IB"))&(PSOSCP<50)&('$G(PSOSI)) $P(^PSRX(RXN,"IB"),"^",1)=""
 K PSOSCP
 Q
 ;
OBR ;Flag/Unflag orders
 I PSOTYPE'="OBR"!($G(PSOSEG)="") Q
 N PSOFLAG,PSORDER,PSOPEN,DR,PSOREA,PSOBY,PSONOW
 S PSORDER=+$P($P(PSOSEG,"|",2),"^")           ; Pointer to ORDER file (#100)
 S PSOPEN=+$O(^PS(52.41,"B",PSORDER,0))        ; Pointer to PENDING OUTPATIENT ORDERS file (#52.41)
 S PSOFLAG=$P(PSOSEG,"|",4)                    ; "FL" for Flag and "UF" for Unflag action
 S PSOREA=$P(PSOSEG,"|",13)                    ; Reason for Flag/Unflag (Freetext up to 80chars)
 S PSOBY=$P(PSOSEG,"|",16)                     ; Flagged/Unflagged By - Pointer to NEW PERSON file (#200)
 S PSONOW=$E($$NOW^XLFDT(),1,12)               ; CURRENT DATE/TIME wihtout seconds
 ;
 I 'PSOPEN!'$P($G(^PS(52.41,PSOPEN,0)),"^") D EN^ORERR("Invalid Pending Order/Flag Msg",.MSG) Q
 ;
 I PSOFLAG="FL" D
 . S $P(^PS(52.41,PSOPEN,"FLG"),"^",1,3)=PSONOW_"^"_PSOBY_"^"_$E(PSOREA,1,80)
 . S $P(^PS(52.41,PSOPEN,"FLG"),"^",4,6)="^^"
 . S $P(^PS(52.41,PSOPEN,0),"^",23)=1
 E  D
 . S $P(^PS(52.41,PSOPEN,"FLG"),"^",4,6)=PSONOW_"^"_PSOBY_"^"_$E(PSOREA,1,80)
 . S $P(^PS(52.41,PSOPEN,0),"^",23)=""
 ;
 Q
