IBCBB21 ;ALB/AAS - CONTINUATION OF EDIT CHECK ROUTINE FOR UB-04 ;2-NOV-89
 ;;2.0;INTEGRATED BILLING;**51,137,210,232,155,291,348,349,403,400,432,447,461,665,702**;21-MAR-94;Build 53
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN(IBZPRC92) ;
 ;
 N ECODE,IBTXMT,IBXDATA,IBDXTYP,IBDXVER,IBLPRT,IBI,Z,Z0,Z1,IBREQMRA,IBFTP
 I '$D(IBZPRC92) D ALLPROC^IBCVA1(IBIFN,.IBZPRC92)
 S IBREQMRA=$$REQMRA^IBEFUNC(IBIFN)    ; MRA?
 K IBQUIT S IBQUIT=0
 S (Z,Z0,Z1)=0
 F  S Z=$O(IBZPRC92(Z)) Q:'Z  S:IBZPRC92(Z)["CPT" Z0=Z0+1 S:IBZPRC92(Z)["ICD" Z1=Z1+1
 S IBTXMT=$$TXMT^IBCEF4(IBIFN)
 S IBZPRC92=Z0_U_Z1 ;Save # of CPT's and ICD9's
 ; More than 50 procedures on a bill - must print locally
 I IBTXMT,(+IBZPRC92>50!(+$P(IBZPRC92,U,2)>50)) D  Q:IBQUIT
 . I 'IBREQMRA S IBQUIT=$$IBER^IBCBB3(.IBER,308) Q
 . I '$P(IBNDTX,U,9) S IBQUIT=$$IBER^IBCBB3(.IBER,325)
 ; removed 11x check ;WCJ IB*2.0*432
 ; If ICD9 procedures with dates and charges, bill 11x or 83x needs operating physician
 ;I IBTOB12="11",$P(IBZPRC92,U,2),'$$CKPROV^IBCEU(IBIFN,2) S IBER=IBER_"IB304;"
 ;modify 83x check for line level providers and also chacnged the erro check slightly
 ;I IBTOB12="83",$P(IBZPRC92,U,2),'$$CKPROV^IBCEU(IBIFN,2) S IBER=IBER_"IB312;"
 I IBTOB12="83",'$$UBPRVCK^IBCBB12(IBIFN) S IBER=IBER_"IB312;"  ; DEM;432
 ;
 ; If any CPT procedures have more than 2 modifiers, warn
 S Z=0 F  S Z=$O(IBZPRC92(Z)) Q:'Z  I $P(IBZPRC92(Z),U)["ICPT(",$L($P(IBZPRC92(Z),U,15),",")>2 S Z0="Proc "_$$PRCD^IBCEF1($P(IBZPRC92(Z),U))_" has > 2 modifiers - only first 2 will be used" D WARN^IBCBB11(Z0)
 ;
 I $$WNRBILL^IBEFUNC(IBIFN),$$MRATYPE^IBEFUNC(IBIFN)'="A" S IBER=IBER_"IB086;"
 ;
 ; UB-04 Diagnosis Codes
 K IBXDATA D F^IBCEF("N-DIAGNOSES",,,IBIFN)
 ;
 ; Only 24 other dx's + 1 principal dx + 3 ecode dx's are allowed per claim
 ;S (Z,ECODE,IBI)=0 F  S Z=$O(IBXDATA(Z)) Q:'Z  D  Q:IBER["309;"!(ECODE>3)
 ;. S IBI=IBI+1
 ;. S IBDXTYP=$$ICD9^IBACSV(+$P(IBXDATA(Z),U),$$BDATE^IBACSV(IBIFN)) I $P(IBDXTYP,U,19)=1,$E(IBDXTYP)="E" D
 ;.. S:ECODE<=3 ECODE=ECODE+1,IBI=IBI-1
 ;.. I ECODE>3 D WARN^IBCBB11("Claim contains more than 3 External Cause of Injury codes.")
 ;. ;
 ;. ; max DX check does not apply to MRAs
 ;. I IBTXMT,IBI>25 D
 ;.. I 'IBREQMRA Q:$P(IBNDTX,U,8)  S IBER=IBER_"IB309;" Q
 ;.. I '$P(IBNDTX,U,9) S IBER=IBER_"IB326;"
 ;
 ;WCJ;IB*2.0*650v6
 ; Only 24 other dx's/17 printed + 1 principal dx + 12 ecode dx's are allowed per claim electronic/3 printed
 S IBFTP=$$GET1^DIQ(399,IBIFN_",",27,"I")  ; force to print
 S (Z,ECODE,IBI)=0 F  S Z=$O(IBXDATA(Z)) Q:'Z  D
 . S IBI=IBI+1
 . S IBDXTYP=$$ICD9^IBACSV(+$P(IBXDATA(Z),U),$$BDATE^IBACSV(IBIFN))
 . I $P(IBDXTYP,U,19)=30,"VWXY"[$E(IBDXTYP) D
 .. S ECODE=ECODE+1,IBI=IBI-1
 ;IB*2.0*702;JWS;remove 665 fatal error for Diagnosis Codes > allowed amount by claim type, make it a warning
 ;I IBI>$S(IBFTP:18,1:25) S IBER=IBER_$S(IBFTP:"IB393;",1:"IB394;")
 I IBI>$S(IBFTP:18,1:25) D
 . I IBFTP D WARN^IBCBB11("Only the first 17 diagnosis codes will print on a UB-04.") Q
 . D WARN^IBCBB11("A HIPAA Compliant EDI Institutional claim cannot contain more than 24"),WARN^IBCBB11("other diagnosis codes.")
 ;IB*2.0*702;JWS;remove 665 fatal error for External Diagnosis Codes > allow number, make it a warning
 ;I ECODE>$S(IBFTP:3,1:12) S IBER=IBER_$S(IBFTP:"IB395;",1:"IB396;")
 I ECODE>$S(IBFTP:3,1:12) D
 . I IBFTP D WARN^IBCBB11("Only the first 3 e-diagnosis codes will print on a UB-04.") Q
 . D WARN^IBCBB11("A HIPAA Compliant EDI Institutional claim cannot contain more than 12"),WARN^IBCBB11("e-diagnosis codes.")
 ;
 I '$O(IBXDATA(0)) S IBER=IBER_"IB071;"   ;Require Diag code NOIS:OKL-0304-72495
 ;
 ; Principle diagnosis - updated for ICD-10 **461
 I $O(IBXDATA(0)) S IBDXTYP=$$ICD9^IBACSV(+$P(IBXDATA(1),U),$$BDATE^IBACSV(IBIFN)) D
 . S IBDXVER=$P(IBDXTYP,U,19),IBDXTYP=$E(IBDXTYP)
 . I IBDXVER=1,IBDXTYP="E" S IBER=IBER_"IB117;"
 . I IBDXVER=1,$$INPAT^IBCEF(IBIFN),IBDXTYP="V" S Z="Principal Dx V-code may not be valid" D WARN^IBCBB11(Z)
 . I IBDXVER=30,"VWXY"[IBDXTYP S IBER=IBER_"IB355;"
 . I IBDXVER=30,$$INPAT^IBCEF(IBIFN),IBDXTYP="Z" S Z="Principal Dx Z-code may not be valid" D WARN^IBCBB11(Z)
 ;
 I '$$OCC10^IBCBB2(IBIFN,.IBXDATA,3) S IBER=IBER_"IB093;"
 ;
 ; At least one PRV diagnosis is required for outpatient UB-04 claim
 ; IB*2.0*447 BI This warning was removed and replaced with an Error Message in routine IBCBB1.
 ;I '$$INPAT^IBCEF(IBIFN),$$CHKPRV^IBCSC10B=3 D WARN^IBCBB11("Outpatient Institutional claims should contain a Patient Reason for Visit.")
 ;
 K ^TMP($J,"IBC-RC")
 D F^IBCEF("N-UB-04 SERVICE LINE (PRINT)",,,IBIFN)
 ;JWS;IB*2.0*665;US40781;Institutional inpatient claims no greater than 999 X12 2400 loop entries
 I $O(^DGCR(399,IBIFN,"RC","A"),-1)>999 D
 . N IBRC,I
 . S IBRC=0
 . F I=0:1 S IBRC=$O(^DGCR(399,IBIFN,"RC",IBRC)) Q:'+IBRC
 . I I>999,IBER'["IB399" S IBER=IBER_"IB399;"
 . Q
 ;JWS;end IB*2.0*665
 S (Z0,IBI)=0 F  S IBI=$O(^TMP($J,"IBC-RC",IBI)) Q:'IBI  S Z=$G(^(IBI))  Q:+$P(Z,U,2)=1  I $P(Z,U,2),$P(Z,U,1)=1 D
 . ; IB*2.0*432 - The IB system shall provide the ability for users to enter maximum line item dollar amounts of 9999999.99.
 . ;I IBER'["IB090;",$P(Z,U,2)>1,($P(Z,U,7)>99999.99!($P(Z,U,8)>99999.99)) S IBER=IBER_"IB090;"
 . I IBER'["IB090;",$P(Z,U,2)>1,($P(Z,U,7)>9999999.99!($P(Z,U,8)>9999999.99)) S IBER=IBER_"IB090;"
 . Q:$P(Z,U,2)'<180&($P(Z,U,2)'>189)  ;Pass days (LOA) don't matter
 . ; Removed the following warning IB*2.0*447 BI Replaced in IBCBB1.
 . ;I '$P(Z,U,7),'$P(Z,U,8),'Z0,$$COBN^IBCEF(IBIFN)'>1  S Z0="Rev Code(s) having a 0-charge will not be transmitted for the bill" D WARN^IBCBB11(Z0) S Z0=1
 K ^TMP($J,"IBC-RC")
 Q
 ;
