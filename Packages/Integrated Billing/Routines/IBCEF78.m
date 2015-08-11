IBCEF78 ;ALB/WCJ - Provider ID functions ;13 May 2007
 ;;2.0;INTEGRATED BILLING;**371,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 G AWAY
AWAY Q
 ;
PAYERIDS(IBXIEN,IBRET) ; This function returns all the PAYER IDS for the current and other insurance(s)
 ; 
 D PRIPAYID(IBXIEN,.IBRET)
 D SECPAYID(IBXIEN,.IBRET)
 Q
 ;
PRIPAYID(IBXIEN,IBXRET) ; Primary Payer IDs
 ; Incoming:
 ; IBXIEN = IEN for File # 399
 ; IBXRET = Return Array for Qualifiers and IDs
 ;
 ; Outgoing
 ; IBXRET("CI_PID",1)=QUAL^ID
 ; IBXRET("OI_PID",#)=QUAL^ID
 ; 
 N RET,I
 S RET=$$PAYERID^IBCEF2(IBXIEN)
 I RET]"" S IBXRET("CI_PID",1)="PI"_U_RET
 ;
 ; MRD;IB*2.0*516 - Added HPID here (CI) and below (OI).
 S RET=$$HPID(IBXIEN)
 I RET]"" S IBXRET("CI_HPID",1)="XV"_U_RET
 ;
 S RET=""
 D OTHINSID^IBCEF72(IBXIEN,.RET)
 F I=1,2 D
 . I $P($G(RET(I)),U)]"" S IBXRET("OI_PID",I)="PI"_U_$P(RET(I),U)
 . I $P($G(RET(I)),U,2)]"" S IBXRET("OI_HPID",I)="XV"_U_$P(RET(I),U,2)
 . Q
 Q
 ;
SECPAYID(IBXIEN,IBXRET) ; This returns all of the secondary payer IDs from file #36 
 ; for the insurance companies on a given claim
 ; 
 ; Incoming:
 ; IBXIEN = IEN for File # 399
 ; IBXRET = Return Array for Qualifiers and IDs
 ;
 ; Outgoing
 ; IBXRET("CI_PSIDS",1)=QUAL^ID^QUAL^ID
 ; IBXRET("OI_PSIDS",#)=QUAL^ID^QUAL^ID
 ;
 N Z,C,IBZ,Z0,FT
 F Z=1:1:3 S IBZ(Z)=$$POLICY^IBCEF(IBXIEN,1,Z)
 S Z0=0,C=$$COBN^IBCEF(IBXIEN),FT=$$FT^IBCEF(IBXIEN)
 F Z=1:1:3 S:C'=Z Z0=Z0+1 S IBXRET($S(C=Z:"CI_PSIDS",1:"OI_PSIDS"),$S(C=Z:1,1:Z0))=$$SPIDS(+IBZ(Z),FT)
 Q
 ;
SPIDS(INS,FT) ;
 ; FT = FORM TYPE (2 PROFESSIONAL 3 INSTITUTIONAL)
 ; INS = INSURANCE COMPANY (FILE #36) IEN
 ; Returns String (^ delimited)
 ; [1] = QUAL 1
 ; [2] = PAYER ID 1
 ; [3] = QUAL 2
 ; [4] = PAYER ID 2
 Q:'+INS ""
 ;
 N DATA,PCE
 S DATA=$S(FT=3:$P($G(^DIC(36,+INS,6)),U,1,4),FT=2:$P($G(^DIC(36,+INS,6)),U,5,8),1:"")
 ;
 ; Check for dangling IDs/Qualifiers
 F PCE=1,3 D
 . I $P(DATA,U,PCE)'="",$P(DATA,U,PCE+1)'="" Q
 . S ($P(DATA,U,PCE),$P(DATA,U,PCE+1))=""
 ;
 ; fill in the gap if there is one
 I $P(DATA,U,1)="",$P(DATA,U,3)'="" D
 . S $P(DATA,U,1)=$P(DATA,U,3)
 . S $P(DATA,U,2)=$P(DATA,U,4)
 . S ($P(DATA,U,3),$P(DATA,U,4))=""
 ;
 Q DATA
 ;
HPID(IBXIEN) ; Determine HPID for current payer.
 ; MRD;IB*2.0*516 - Added HPID.
 ;
 N IBHPID,IBSEQ
 S IBSEQ=$$COBN^IBCEF(IBXIEN)  ; IBSEQ should be 1, 2 or 3.
 I IBSEQ S IBHPID=$P($G(^DGCR(399,IBXIEN,"M1")),U,12+IBSEQ)  ; Pull piece 13, 14 or 15.
 Q IBHPID
 ;
CLEANUP(IBRET) ;
 K IBRET("CI_PID"),IBRET("OI_PID"),IBRET("CI_PSIDS"),IBRET("OI_PSIDS"),IBRET("CI_HPID"),IBRET("OI_HPID")
 Q
 ;
