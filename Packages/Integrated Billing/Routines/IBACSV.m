IBACSV ;WOIFO/AAT - CODE SET VERSIONING IB UTILITIES ;19-FEB-03
 ;;2.0;INTEGRATED BILLING;**210,266,461**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;*** DD calls ***
 ; Called from Data Dictionary of 399, subfile 399.30416, field .02
B30416 ;
 S ICPTVDT=$$BDATE($G(DA(2)),$G(DA(1))) ; Date of service
 S DIC("S")="I $$MODP^ICPTMOD(+$G(^DGCR(399,DA(2),""CP"",DA(1),0)),+Y,""I"",ICPTVDT)>0"
 S DIC("W")="D EN^DDIOL(""   ""_$P($$MOD^ICPTMOD(+Y,""I"",ICPTVDT),U,3),,""?0"")"
 Q
 ;
 ;*** API calls ***
 ;
 ;Returns data of the CPT code, NULL if error
 ;Input: IBC-code, IBDT-date (default is today)
 ;Output: (by reference) - IBERROR - error string if error happened
 ;DO NOT USE THIS CALL TO DETERMINE ACTIVE/INACTIVE STATUS OF THE CODE
CPT(IBC,IBDT,IBERROR) N IBINF
 I '$G(IBDT) S IBDT=DT
 S IBERROR=""
 S IBINF=$$CPT^ICPTCOD(IBC,IBDT,1) ;Local codes supported
 I IBINF<0 S IBERROR=$P(IBINF,U,2),IBINF=""
 Q $P(IBINF,U,2,999) ;Remove the first piece (IEN)
 ;
 ;Returns data of the ICD Operational code, NULL if error
 ;Input: IBC-code, IBDT-date (default is today)
 ;Output: (by reference) - IBERROR - error string if error happened
 ;DO NOT USE THIS CALL TO DETERMINE ACTIVE/INACTIVE STATUS OF THE CODE
ICD0(IBC,IBDT,IBERROR) N IBINF
 I '$G(IBDT) S IBDT=DT
 S IBERROR=""
 S IBINF=$$ICDOP^ICDEX(IBC,IBDT,,"I",1) ;Local codes supported
 I IBINF<0 S IBERROR=$P(IBINF,U,2),IBINF=""
 Q $P(IBINF,U,2,999) ;Remove the first piece (IEN)
 ;
 ;Returns data of the ICD Diagnosis code, NULL if error
 ;Input: IBC-code, IBDT-date (default is today)
 ;Output: (by reference) - IBERROR - error string if error happened
 ;DO NOT USE THIS CALL TO DETERMINE ACTIVE/INACTIVE STATUS OF THE CODE
ICD9(IBC,IBDT,IBERROR) N IBINF
 I '$G(IBDT) S IBDT=DT
 S IBERROR=""
 S IBINF=$$ICDDX^ICDEX(IBC,IBDT,,"I",1) ; Local codes supported
 I IBINF<0 S IBERROR=$P(IBINF,U,2),IBINF=""
 Q $P(IBINF,U,2,999) ;Remove the first piece (IEN)
 ;
 ;Returns data of the DRG code, NULL if error
 ;Input: IBC-code, IBDT-date (default is today)
 ;Output: (by reference) - IBERROR - error string if error happened
DRG(IBC,IBDT,IBERROR) N IBINF
 I '$G(IBDT) S IBDT=DT
 S IBERROR=""
 S IBINF=$$DRG^ICDGTDRG(IBC,IBDT)
 I IBINF<0 S IBERROR=$P(IBINF,U,2),IBINF=""
 Q IBINF ;Format of the DRG API is different - the first piece doesn't need to be removed.
 ;
 ;
 ; ==== Determine Active Status for CPT,ICD0,ICD9 and DRG codes ====
 ;Used by DD for screening CPT codes
 ;Is the given code active for the date? (default-today)
CPTACT(IEN,IBDT) N IBINF,IBRES
 I '$G(IBDT) S IBDT=DT
 S IBRES=0
 S IBINF=$$CPT^ICPTCOD(IEN,IBDT)
 I IBINF'<0,$P(IBINF,U,7) S IBRES=1
 Q IBRES
 ;
 ;Is the given code active for the date? (default-today)
ICD0ACT(IEN,IBDT) N IBINF,IBRES
 I '$G(IBDT) S IBDT=DT
 S IBRES=0
 S IBINF=$$LS^ICDEX(80.1,IEN,IBDT)
 I IBINF>0 S IBRES=1
 Q IBRES
 ;
 ;Is the given code active for the date? (default-today)
ICD9ACT(IEN,IBDT) N IBINF,IBRES
 I '$G(IBDT) S IBDT=DT
 S IBRES=0
 S IBINF=$$LS^ICDEX(80,IEN,IBDT)
 I IBINF>0 S IBRES=1
 Q IBRES
 ;
 ;Is the given code active for the date? (default-today)
DRGACT(IEN,IBDT) N IBINF,IBRES
 I '$G(IBDT) S IBDT=DT
 S IBRES=0
 S IBINF=$$DRG^ICDGTDRG(IEN,IBDT)
 I IBINF'<0,$P(IBINF,U,14) S IBRES=1
 Q IBRES
 ;
 ;
 ; ==== Determine Record Number (IEN) for CPT, ICD0, ICD9 and DRG codes ====
 ; Note: the Date of Service doesn't matter here!
 ;Input: IBC-name
 ;Returns: IEN of the code (or NULL if not valid)
CPTIEN(IBC) N IBINF,IBRES
 S IBRES=""
 S IBINF=$$CPT^ICPTCOD(IBC)
 I IBINF>0 S IBRES=$P(IBINF,U)
 Q IBRES
 ;
 ;Input: IBC-name
 ;Returns: IEN of the code (or NULL if not valid)
ICD0IEN(IBC) N IBINF,IBRES
 S IBRES=""
 S IBINF=$$ICDOP^ICDEX(IBC,,,"E")
 I IBINF>0 S IBRES=$P(IBINF,U)
 Q IBRES
 ;
 ;Input: IBC-name
 ;Returns: IEN of the code (or NULL if not valid)
ICD9IEN(IBC) N IBINF,IBRES
 S IBRES=""
 S IBINF=$$ICDDX^ICDEX(IBC,,,"E")
 I IBINF>0 S IBRES=$P(IBINF,U)
 Q IBRES
 ;
 ;Input: IBC-name
 ;Returns: IEN of the code (or NULL if not valid)
DRGIEN(IBC) N IBINF,IBRES
 S IBRES=""
 S IBINF=$$DRG^ICDGTDRG(IBC)
 I IBINF'<0 S IBRES=$P(IBINF,U,17)
 Q IBRES
 ;
 ;
 ; ==== Determine Coding Version ICD0, ICD9 codes ====
 ;Returns the ICD Procedure code version (ICD9=2, ICD10=31)
ICD0VER(IEN) N IBINF,IBRES
 S IBRES=""
 S IBINF=$$ICDOP^ICDEX(IEN,,,"I")
 I IBINF>0 S IBRES=$P(IBINF,U,15)
 Q IBRES
 ;
 ;Returns the ICD Diagnosis code version (ICD9=1, ICD10=30)
ICD9VER(IEN) N IBINF,IBRES
 S IBRES=""
 S IBINF=$$ICDDX^ICDEX(IEN,,,"I")
 I IBINF>0 S IBRES=$P(IBINF,U,20)
 Q IBRES
 ;
 ;
 ; ==== Determine Coding System ICD-9, ICD-10 ====
 ;Returns ICD Procedure system on date (ICD9=2, ICD10=31)
ICD0SYS(IBDT) N IBINF,IBRES
 S IBRES=""
 I '$G(IBDT) S IBDT=DT
 S IBINF=$$SYS^ICDEX(80.1,IBDT)
 I IBINF>0 S IBRES=+IBINF
 Q IBRES
 ;
 ;Returns ICD Diagnosis system on date (ICD9=1, ICD10=30)
ICD9SYS(IBDT) N IBINF,IBRES
 S IBRES=""
 I '$G(IBDT) S IBDT=DT
 S IBINF=$$SYS^ICDEX(80,IBDT)
 I IBINF>0 S IBRES=+IBINF
 Q IBRES
 ;
 ;
 ; ==== Bill's Date of Service (for diagnosis codes, revenue codes) ====
 ; The STATEMENT TO DATE of the bill is used as a date of service for CSV
BDATE(IBIFN,PROC) ;
 ; PROC (Optional) - IEN of PROCEDURES sub-file.
 ; if PROC is defined, the function will try to return the date of procedure first.
 N IBDAT
 S IBDAT=""
 I '$G(IBIFN) Q ""
 ; The following line of code is for entering new procedures.
 ; If PROC is defined, but NULL - that means adding new procedure to 399.
 ; Therefore we try to use DGPROCDT variable prior to the bill's Service Date
 ; This is limited to CPTs, ICD Procedures use the bills service date (ICD-10)
 I $D(PROC),$P($G(^DGCR(399,+IBIFN,0)),U,9)=9 K PROC
 I $D(PROC),'PROC,$G(DGPROCDT)>0 S IBDAT=DGPROCDT
 I $G(PROC) S IBDAT=$P($P($G(^DGCR(399,+IBIFN,"CP",+PROC,0)),U,2),".")
 I 'IBDAT S IBDAT=$P($P($G(^DGCR(399,+IBIFN,"U")),U,2),".")
 Q $S(IBDAT>0:IBDAT,1:"")
 ;
 ; === Coding System Implementation Date ===
CSVDATE(IBSYS) ;
 N IBRES,IBINF S (IBRES,IBINF)=""
 I $G(IBSYS)'="" S IBINF=$$IMPDATE^LEXU(IBSYS)
 I IBINF>0 S IBRES=IBINF
 Q IBRES
 ;
 ; === PTF Date of Service ===
PTFDATE(IBPTF) ;
 I '$G(IBPTF) Q ""
 Q $$GETDATE^ICDGTDRG(+$G(IBPTF))
 ;
 ; === Date of service, associated with the Tracking Number ===
TRNDATE(IBTRN) ; The EPISODE DATE is used to determine the date of service
 ; for the given Tracking Number
 I '$G(IBTRN) Q ""
 Q $P($P($G(^IBT(356,+IBTRN,0)),U,6),".")
 ;
 ; === DRG Text Descriptor (1st line only) ===
DRGTD(IEN,IBDT) ;
 N IBARR,IBRES
 S IBDT=$P($G(IBDT),".")
 I $T(DRGD^ICDGTDRG)="" Q $G(^ICD(+IEN,1,1,0))
 S IBRES=$$DRGD^ICDGTDRG(IEN,"IBARR",,IBDT)
 Q $G(IBARR(1))
 ;
