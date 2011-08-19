IBCEF1 ;ALB/TMP - FORMATTER SPECIFIC BILL FUNCTIONS - CONT ;30-JAN-96
 ;;2.0;INTEGRATED BILLING;**52,124,51,137,210,155,349,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
OCC(IBIFN,REL,TEXT) ;Sets up an arrays of occurrence codes for various cks
 ;RETURNS 1^additional data for entry IBXSAVE("OCC",n) if REL or TEXT
 ;   parameters have been met or null if conditions not met
 ;If no REL or TEXT parameters sent, just extract codes array
 ; IBIFN = bill ien
 ; REL = 'OCC RELATED TO' value to check for
 ; TEXT = text to check for the .01 field of 399.1 entry pointed to
 ;         by the occurrence code
 N OCC,SORT,ARR,N,DATA,CODE,CT
 I '$D(IBXSAVE("OCC")),'$D(IBXSAVE("OCCS")) D
 .N IBI,Z,CT1,CT2,Z0 S (IBI,CT1,CT2)=0
 .F  S IBI=$O(^DGCR(399,IBIFN,"OC",IBI)) Q:'IBI  S Z=$G(^(IBI,0)) D
 ..S Z0=$G(^DGCR(399.1,+Z,0))
 ..Q:'$P(Z0,U,10)&'$P(Z0,U,4)  ;Not an occurrence code
 ..I $P(Z0,U,10) S CT2=CT2+1,IBXSAVE("OCCS",CT2)=$S($P(Z0,U,4):$P(Z0,U,2)_U_$P(Z,U,2),1:U)_U_$P(Z,U,4)_U_$P(Z0,U)_U_$P(Z0,U,9)_U_$P(Z,U,3)_U_$P(Z,U,2)
 ..I '$P(Z0,U,10) S CT1=CT1+1,IBXSAVE("OCC",CT1)=$S($P(Z0,U,4):$P(Z0,U,2)_U_$P(Z,U,2),1:U)_U_U_$P(Z0,U)_U_$P(Z0,U,9)_U_$P(Z,U,3)_U_$P(Z,U,2)
 I '$D(IBXSAVE("OCC"))&'$D(IBXSAVE("OCCS")) S IBXSAVE("OCC")="" G OCCQ
 ;
 ; esg - IB*2*349 - order the occurrence codes
 ;       Build the SORT array sorted by the occ code
 F ARR="OCC","OCCS" S N=0 F  S N=$O(IBXSAVE(ARR,N)) Q:'N  S DATA=$G(IBXSAVE(ARR,N)) I $P(DATA,U,1)'="" S CODE=" "_$P(DATA,U,1),SORT(ARR,CODE,N)=DATA
 ;       Loop thru the SORT array and re-build the IBXSAVE array
 F ARR="OCC","OCCS" K IBXSAVE(ARR) S CODE="",CT=0 F  S CODE=$O(SORT(ARR,CODE)) Q:CODE=""  S N=0 F  S N=$O(SORT(ARR,CODE,N)) Q:'N  S CT=CT+1,IBXSAVE(ARR,CT)=SORT(ARR,CODE,N)
 ;
 I $G(REL)'=""!($G(TEXT)'="") D OCC1("",.OCC,$G(REL),$G(TEXT)) D:'$D(OCC) OCC1("S",.OCC,$G(REL),$G(TEXT))
OCCQ Q $G(OCC)
 ;
OCC1(ARR,OCC,REL,TEXT) ; Search thru local array for parameters met
 ; ARR = null to search OCC subscript, "S" to search OCCS subscript
 N Z
 S ARR="OCC"_ARR,Z=0
 F  S Z=$O(IBXSAVE(ARR,Z)) Q:'Z  D
 .I $G(REL)'="",$P(IBXSAVE(ARR,Z),U,5)=REL S OCC="1"_$S(REL=2:U_$P(IBXSAVE(ARR,Z),U,6),1:"") Q
 .I $G(TEXT)'="",$P(IBXSAVE(ARR,Z),U,4)=TEXT S OCC="1^"_$P(IBXSAVE(ARR,Z),U,7)
 Q
 ;
RX(IBIFN) ; Format billable prescription data for refills for 837
 N Z,IBXDATA,CT
 I '$D(IBXSAVE("BOX24")) D B24^IBCEF3(.IBXSAVE,IBIFN,1)
 S Z="",CT=0
 F  S Z=$O(IBXSAVE("BOX24",Z)) Q:Z=""  I $D(IBXSAVE("BOX24",Z,"RX")) S CT=CT+1,IBXDATA(Z)=IBXSAVE("BOX24",Z,"RX")
RXQ Q CT
 ;
OTHPAY(IBIFN,SEQ) ; Return the other insurance payment amount for bill
 ;  IBIFN and payer sequence SEQ (1-3)
 N AMT,IBIFN1
 S IBIFN1=$P($G(^DGCR(399,IBIFN,"M1")),U,SEQ+4)
 I IBIFN1 D
 . I $$MCRWNR^IBEFUNC(+$G(^DGCR(399,IBIFN,"I"_SEQ))) S AMT=$$MCRPAY^IBCEU0(IBIFN) Q
 . S AMT=+$$TPR^PRCAFN(IBIFN1) Q:AMT  ; A/R amount
 . S AMT=+$P($G(^DGCR(399,IBIFN,"U2")),U,SEQ+3) ; amount on bill
 Q $G(AMT)
 ;
OUTPT(IBIFN,IBPRINT) ; Moved for space
 D OUTPT^IBCEF11(IBIFN,$G(IBPRINT))
 Q
 ;
OCC92 ;Reformats IBXSAVE("OCC") and IBXSAVE("OCCS") to fit blocks on UB-04
 ; Set up IBXSAVE(32-36) arrays
 N IBPG,IB32,IB33,IB34,IB35,IB36,IBFL,Z,Z0,PG
 S IBPG=0
 F Z=32:1:36 K IBFL(Z) S IBFL(Z)=0
 M IB32=IBXSAVE("OCC"),IB36=IBXSAVE("OCCS")
 S IB32=$O(IB32(""),-1),IB36=$O(IB36(""),-1),PG=1
 D OCC^IBCF32
 F Z=32:1:36 S Z0="" F  S Z0=$O(IBFL(Z,Z0)) Q:'Z0  S IBXSAVE("OC92",Z,Z0)=$P(IBFL(Z,Z0),U,1,3)
 Q
 ;
BATCH() ; Moved for space IB*2*349
 Q $$BATCH^IBCEF11()
 ;
PROC(T,TYPE) ; Find procedure code, strip '.' Function returns result
 ; T = Procedure internal entry #;file reference
 ; TYPE = "CPT" for only CPT/HCPCS valid
 ;        "ICD" for only ICD9 valid or null for either
 N Q,S
 S Q="",S="^"_$P($P(T,";",2),"(")
 I $G(TYPE)="" D
 . I $E(S,2,3)="IC" S Q=$P($$PRCD(T),U) Q
 . I T["DIC(81.3" S Q=$$MOD^ICPTMOD(+T,"I") S Q=$S(Q>0:$P(Q,U,4),1:"")
 I $G(TYPE)="CPT",$E(S,2,3)="IC" S Q=$$PRCD(T) Q
 I $G(TYPE)="ICD",T["ICD0" S Q=$P($$ICD0^IBACSV(+T),U)
 Q $TR(Q,".")
 ;
FACILITY(IBIFN) ;return the Facility (Institution pointer-#4) for a bill
 ; the institution of the Bill Division (399,.22) if defined, otherwise the Facility Name (350.9,.02)
 ;
 N IB0,IBIN S IBIN=0
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) I +$P(IB0,U,22) S IBIN=$$SITE^VASITE(+$P(IB0,U,3),+$P(IB0,U,22))
 I IBIN'>0 S IBIN=+$P($G(^IBE(350.9,1,0)),U,2)
 Q +IBIN
 ;
ISRX(IBIFN) ; Function to determine if bill is a prescription refill bill
 ; Returns 0 if no Rx on bill or 1 if there is.
 ;
 N IBRX
 I $D(^IBA(362.4,"AIFN"_IBIFN)) S IBRX=1
 Q +$G(IBRX)
 ;
ISPROS(IBIFN) ; Function to determine if bill is a prosthetics bill
 ; Returns 0 if no Prosthetics on bill or 1 if there is.
 ;
 N IBPROS
 I $D(^IBA(362.5,"AIFN"_IBIFN)) S IBPROS=1
 Q +$G(IBPROS)
 ;
FINDINS(IBIFN,IBSEQ) ; Returns the internal entry number of the insurance
 ;  company for bill ien IBIFN for payer sequence IBSEQ (or current if
 ;  IBSEQ is null)
 Q $P($G(^DGCR(399,IBIFN,"I"_$$COBN^IBCEF(IBIFN,$G(IBSEQ)))),U)
 ;
TOB(IBIFN) ; Returns UB-04 type of bill from data in the output formatter
 N IBTOB,IBZ1,IBZ2,IBZ3
 D F^IBCEF("N-UB-04 LOCATION OF CARE","IBZ1",,IBIFN)
 D F^IBCEF("N-UB-04 BILL CLASSIFICATION","IBZ2",,IBIFN)
 D F^IBCEF("N-UB-04 TIMEFRAME OF BILL","IBZ3",,IBIFN)
 S IBTOB=IBZ1_IBZ2_IBZ3
 Q IBTOB
 ;
PRCD(PRIEN,ALL,EDT) ; Function returns the code that corresponds to the variable
 ; pointer data in PRIEN (ien;file)
 ; ALL = if ALL=1, returns the entire $$CPT^ICPTCOD for CPT or
 ;       ^code^name format for ICD result
 ;       or null if lookup fails
 ; EDT = Effective date to check (not used if +$G(ALL)=0)
 N CODE,IBX
 S CODE=""
 ;Modified for Code Set Versioning
 I PRIEN["ICPT" S IBX=$$CPT^ICPTCOD(+PRIEN,$G(EDT)) G:IBX'>0 PRCDQ S CODE=$S($G(ALL):IBX,1:$P(IBX,U,2))
 I PRIEN["ICD0" S IBX=$$ICD0^IBACSV(+PRIEN,$G(EDT)) G:IBX="" PRCDQ S CODE=$S($G(ALL):U_$P(IBX,U)_U_$P(IBX,U,4),1:$P(IBX,U))
PRCDQ Q CODE
 ;
NFT(FT,IBIFN) ; Returns 1 if bill IBIFN is not of form type FT (internal)
 ; so the data element should not be required
 S FT=$S($$FT^IBCEF(IBIFN)=FT:0,1:1)
 Q FT
 ;
REQ(FT,INP,IBIFN) ; Determine if bill IBIFN is of form type FT and
 ; Inpatient (I) or Outpatient (O) status INP [or either if (null)] 
 ;
 ;Returns 1 if both conditions FT and INP match for the bill
 ; or 0 if either of these conditions are not true
 ; I $$REQ^IBCEF1(2,"I",1) would mean if bill entry #1 is
 ;                         CMS-1500/inpatient the data would be required
 ; I '$$REQ^IBCEF1(2,"I",1) would mean if bill entry #1 is anything but
 ;                          CMS-1500/inpatient, the data would not be
 ;                          required
 N Z
 S Z=1
 S:$$NFT(FT,IBIFN) Z=0 ; Not the form type for requirement
 I Z,$G(INP)'="" D
 . S Z0=$$INPAT^IBCEF(IBIFN,1),INP=$G(INP)
 . S Z=$S(Z0:INP="I",1:INP="O") ;Check if I/O matches required state
 Q Z
 ;
SET1(IBIFN,A,IBZ,IBXDATA,IBXNOREQ) ; Utility to set variables for output
 ; formatter for professional EDI 
 ; Returns values of A, IBXDATA, IBZ, IBXNOREQ
 N Z,CT
 S A="^TMP($J,""IBLCT"")"
 S (Z,CT)=0
 F  S Z=$O(IBXDATA(Z)) Q:'Z  D  ; Don't transmit 0-charges
 . I $P(IBXDATA(Z),U,9),$P(IBXDATA(Z),U,8) S CT=CT+1 M IBZ(CT)=IBXDATA(Z)
 K IBXDATA
 S IBXNOREQ='$$REQ(2,"O",IBIFN)
 Q
 ;
CIADDR(IBXDATA,IBXSAVE,LINE,FORM) ; Format current ins co address line LINE for FORM
 ; FORM = 1 for CMS-1500, 2 for UB-04
 ; Called from output formatter - both IBXDATA, IBXSAVE parameters are
 ;  passed by reference
 ;
 K IBXDATA
 I $G(FORM)'=1 D
 . ;
 . ; esg - 11/17/06 - IB*2*349 - UB-04 FL-38 contains the payer name
 . ;       and address on 4 lines within this 5 line box.  All 5 lines
 . ;       are formatted here into the IBXDATA array.  This is the
 . ;       address that shows through the envelope window.
 . ;
 . ; esg - 9/13/07 - IB*2*371 - Line 1 of this box contains the print
 . ;       status (i.e. copy, 2nd notice, 3rd notice, MRA needed).
 . ;
 . N Z,Z1,LM,Q,ADDR,X,IBPSTAT
 . S LM=$P($G(^IBE(350.9,1,1)),U,31)   ; UB address column parameter
 . S Z=""
 . I LM S $P(Z," ",LM)=""              ; beginning spaces indent
 . S ADDR=$G(IBXSAVE("CADR"))          ; address data string
 . ;
 . D F^IBCEF("N-PRINT BILL SUBMIT STATUS","IBPSTAT",,+$G(IBXIEN))
 . S Z1=Z I Z1="" S Z1=" "     ; line 1 can't start in column 1
 . S IBXDATA(1)=Z1_$G(IBPSTAT),Q=1             ; line 1 print status
 . S Q=Q+1
 . S IBXDATA(Q)=Z_$G(IBXSAVE("CADR_NAME"))     ; line 2 payer name
 . S X=$P(ADDR,U,1)
 . I X'="" S Q=Q+1,IBXDATA(Q)=Z_X              ; address line 1
 . S X=$P(ADDR,U,2)
 . I X'="" S Q=Q+1,IBXDATA(Q)=Z_X D            ; address line 2
 .. S X=$P(ADDR,U,3)
 .. I X'="" S IBXDATA(Q)=IBXDATA(Q)_" "_X      ; address line 3
 .. Q
 . S Q=Q+1                                     ; city,st,zip on last line
 . S IBXDATA(Q)=Z_$P(ADDR,U,4)_", "_$$STATE^IBCEFG1($P(ADDR,U,5))_" "_$P(ADDR,U,6)
 . KILL IBXSAVE("CADR_NAME"),IBXSAVE("CADR")   ; cleanup
 . Q
 ;
 I $G(FORM)=1 D           ; CMS-1500
 . N CT,X,Z
 . S:'$D(IBXSAVE("INDENT")) Z="",$P(Z," ",+$P($G(^IBE(350.9,1,1)),U,27)+1)="",IBXSAVE("INDENT")=Z
 . S CT=0
 . S X=$P(IBXSAVE("CADR"),U) S:X'="" CT=CT+1,IBXDATA(CT)=IBXSAVE("INDENT")_X
 . S X=$S($P(IBXSAVE("CADR"),U,2)'="":$P(IBXSAVE("CADR"),U,2),1:"")_$S($P(IBXSAVE("CADR"),U,2)'="":" ",1:"")_$P(IBXSAVE("CADR"),U,3) S:X'="" CT=CT+1,IBXDATA(CT)=IBXSAVE("INDENT")_X
 . S CT=CT+1,IBXDATA(CT)=IBXSAVE("INDENT")_$P(IBXSAVE("CADR"),U,4)_", "_$$STATE^IBCEFG1($P(IBXSAVE("CADR"),U,5))_" "_$P(IBXSAVE("CADR"),U,6)
 . Q
 ;
 Q
 ;
