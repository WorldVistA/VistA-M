IBCEF31 ;ALB/ESG - FORMATTER SPECIFIC BILL FLD FUNCTIONS - CONT ;14-NOV-03
 ;;2.0;INTEGRATED BILLING;**155,296,349,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 N JUMP,IBPG,VAL
 F JUMP=DXCNT+4:4 Q:'$D(IBXSAVE("DX",JUMP))  D  ;
 . ;calculate page number where Dx number JUMP will print
 . S IBPG=JUMP\4+(JUMP#4>0)
 . S VAL=$P($$ICD9^IBACSV(+IBXSAVE("DX",JUMP)),U)   ; resolve Dx pointer
 . S VAL=$$FORMAT^IBCEF3(VAL,$G(IBX0),$G(IBXDA))  ;format Dx value
 . D SETGBL^IBCEFG(IBPG,IBXLN,IBXCOL,VAL,.IBXSIZE) ;store in output global
 Q  ;PGDX
 ;
DXSV(IB,IBXSAVE) ; output formatter subroutine
 ; save off DX codes in IBXSAVE("DX")
 N Z,IBCT
 S (Z,IBCT)=0
 F  S Z=$O(IB(Z)) Q:'Z  I $G(IB(Z)) S IBCT=IBCT+1 M IBXSAVE("DX",IBCT)=IB(Z)
 Q
