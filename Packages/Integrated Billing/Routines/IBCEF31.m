IBCEF31 ;ALB/ESG - FORMATTER SPECIFIC BILL FLD FUNCTIONS - CONT ;14-NOV-03
 ;;2.0;INTEGRATED BILLING;**155,296,349,400,432,488,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
ALLTYP(IBIFN) ; returns codes to translate to ALL ins types on a bill
 ; IBIFN = ien of bill
 N IBX,Z
 F Z=1:1:3 S $P(IBX,U,Z)=$$INSTYP(IBIFN,Z)
 ; IBX = primary code^secondary code^tertiary code
 Q IBX
 ;
INSTYP(IBIFN,SEQ) ; Returns insurance type code for an ins on a bill
 ; IBIFN = ien of bill
 ; SEQ = sequence (1,2,3) of insurance wanted - prim, second, tert
 ;       Default is current insurance co
 ;
 N IBA,Z
 ;
 I '$G(SEQ) S SEQ=$$COBN^IBCEF(IBIFN)
 S Z=+$G(^DGCR(399,IBIFN,"I"_SEQ))
 ;Codes 1:HMO;2:COMMERCIAL;3:MEDICARE;4:MEDICAID;5:GROUP POLICY;9:OTHER
 I Z D
 . S IBA=$P($G(^DIC(36,Z,3)),U,9)
 . I $$MCRWNR^IBEFUNC(Z) S IBA=3   ; force Medicare (WNR) definition to be correct
 . I IBA="" S IBA=5 ;Default is group policy - 5 if blank
 ;
 Q $G(IBA)
 ;
POLTYP(IBIFN,IBSEQ) ; Returns ins electronic policy type code for one
 ;   ins policy on a bill
 ; IBIFN = ien of bill
 ; IBSEQ = sequence (1,2,3) of ins policy wanted - prim, second, tert
 ;       Default is current insurance co
 ;
 N IBPLAN,IBPLTYP
 ;
 I '$G(IBSEQ) S IBSEQ=+$$COBN^IBCEF(IBIFN)
 S IBPLAN=$G(^IBA(355.3,+$P($G(^DGCR(399,IBIFN,"I"_IBSEQ)),U,18),0))
 S IBPLTYP=$P(IBPLAN,U,15)
 ;
 ; esg - 06/30/05 - IB*2.0*296 - Force Medicare (WNR) to be correct
 I $$WNRBILL^IBEFUNC(IBIFN,IBSEQ),$$FT^IBCEF(IBIFN)=2 S IBPLTYP="MB"   ; CMS-1500 ----> Medicare Part B
 I $$WNRBILL^IBEFUNC(IBIFN,IBSEQ),$$FT^IBCEF(IBIFN)=3 S IBPLTYP="MA"   ; UB-04 -------> Medicare Part A
 ;
 I IBPLTYP="" S IBPLTYP="CI" ;Default is commercial - 'CI'
 I IBPLTYP="MX" D
 . I $P(IBPLAN,U,14)'="","AB"[$P(IBPLAN,U,14) S IBPLTYP="M"_$P(IBPLAN,U,14) Q
 . S IBPLTYP="CI"
 Q $G(IBPLTYP)
 ;
ALLPTYP(IBIFN) ; returns insurance policy type codes for ALL ins on a bill
 ; IBIFN = ien of bill
 N IBX,Z S IBX=""
 F Z=1:1:3 I $D(^DGCR(399,IBIFN,"I"_Z)) S $P(IBX,U,Z)=$$POLTYP(IBIFN,Z)
 ; IBX = primary code^secondary code^tertiary code
 Q IBX
 ;
PGDX(DXCNT,IBX0,IBXDA,IBXLN,IBXCOL,IBXSIZE,IBXSAVE) ; Subroutine - Checks for Diagnosis Codes (Dx) beyond 
 ; the first four, that relate to the current Dx position passed in DXCNT.
 ; This subroutine stores the Diagnosis Codes in output global using display parameters (IBXLN,IBXCOL)
 ;  THE PAGE IS ALWAYS 1 NOW SO WE DON'T NEED 4 LINES BELOW  BAA *488*
 ; If DXCNT is 1, check for Dx's 5,9,...etc & display on pages 2,3,...etc
 ; If DXCNT is 2, check for Dx's 6,10,...etc & display on pages 2,3,...etc
 ; If DXCNT is 3, check for Dx's 7,11,...etc & display on pages 2,3,...etc
 ; If DXCNT is 4, check for Dx's 8,12,...etc & display on pages 2,3,...etc
 ;
 ; Input: DXCNT= position of current Dx (from 1 to 4)
 ;        IBX0= zero-level of file 364.7 of current Dx
 ;        IBXDA= ien# of file 364.6 of current Dx
 ;        IBXLN IBXCOL= line# & Column# of current Dx
 ;        IBXSIZE= size counter
 ;        IBXSAVE("DX")= local array with all Dx's on current bill
 ;
 ;  For patch *488* 
 ;  S DXNM = 12  This is the number of diagnosis on a 1500 form  
 ;  S IBPG=1  This is the page number.  All 12 print on page 1
 N IBPG,VAL
 S IBPG=1
 I '$D(IBXSAVE("DX",DXCNT)) Q
 S VAL=$P($$ICD9^IBACSV(+IBXSAVE("DX",DXCNT)),U)   ; resolve Dx pointer
 S VAL=$$FORMAT^IBCEF3(VAL,$G(IBX0),$G(IBXDA))  ;format Dx value
 D SETGBL^IBCEFG(IBPG,IBXLN,IBXCOL,VAL,.IBXSIZE) ;store in output global
 Q  ;PGDX
 ;
DXSV(IB,IBXSAVE) ; output formatter subroutine
 ; save off DX codes in IBXSAVE("DX")
 N Z,IBCT
 S (Z,IBCT)=0
 F  S Z=$O(IB(Z)) Q:'Z  I $G(IB(Z)) S IBCT=IBCT+1 M IBXSAVE("DX",IBCT)=IB(Z)
 Q
 ;
AUTRF(IBXIEN,IBL,Z) ; returns auth # and referral# if room for both, separated by a space - IB*2.0*432
 ; IBXIEN=  claim ien
 ; IBL   =  field length-1 to allow for 1 blank space between numbers (28 for CMS 1500, 30 for UB-04)
 ; Z     =  1 for PRIMARY, 2 for SECONDARY, 3 for TERTIARY
 ; 
 N IBXDATA,IBZ
 Q:$G(IBXIEN)="" ""
 ; if CMS 1500, find current codes
 I $G(Z)="",$G(IBL)=28 S Z=$$COBN^IBCEF(IBXIEN)
 Q:$G(Z)="" ""
 ; if length not defined, default to shortest
 S:IBL="" IBL=28
 D F^IBCEF("N-"_$P("PRIMARY^SECONDARY^TERTIARY",U,Z)_" AUTH CODE",,,IBXIEN)
 D F^IBCEF("N-"_$P("PRIMARY^SECONDARY^TERTIARY",U,Z)_" REFERRAL NUMBER","IBZ",,IBXIEN)
 ; if length of auth and referral combined is too long, only return auth code
 Q $S(IBZ="":IBXDATA,IBXDATA="":IBZ,$L(IBXDATA)+$L(IBZ)>IBL:IBXDATA,1:IBXDATA_" "_IBZ)
 ;
GRPNAME(IBIEN,IBXDATA) ; Populate IBXDATA with the Group Name(s).
 ; MRD;IB*2.0*516 - Created this procedure as extract code for
 ; ^IBA(364.5,199), N-ALL INSURANCE GROUP NAME.
 N A,Z
 F Z=1:1:3 I $D(^DGCR(399,IBIEN,"I"_Z)) D
 . S IBXDATA(Z)=$$POLICY^IBCEF(IBIEN,15,Z) I IBXDATA(Z)'="" Q
 . S A=$$POLICY^IBCEF(IBIEN,1,Z)           ; Pull piece 1, Ins. Type.
 . I A'="" S IBXDATA(Z)=$P($G(^DIC(36,+A,0)),U)
 . Q
 Q
 ;
GRPNUM(IBXIEN,IBXDATA) ; Populate IBXDATA with the Group Number(s).
 ; MRD;IB*2.0*516 - Created this procedure as extract code for
 ; ^IBA(364.5,200), N-ALL INSURANCE GROUP NUMBER.
 N Z
 F Z=1:1:3 I $D(^DGCR(399,IBXIEN,"I"_Z)) S IBXDATA(Z)=$$POLICY^IBCEF(IBXIEN,3,Z)
 Q
 ;
