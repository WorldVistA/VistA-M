IBCEF31 ;ALB/ESG - FORMATTER SPECIFIC BILL FLD FUNCTIONS - CONT ;14-NOV-03
 ;;2.0;INTEGRATED BILLING;**155,296,349,400,432,488,516,592,608**;21-MAR-94;Build 90
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
 ;JRA IB*2.0*592 Treat Dental Form 7 (J430D) the same as CMS-1500
 ;I $$WNRBILL^IBEFUNC(IBIFN,IBSEQ),$$FT^IBCEF(IBIFN)=2 S IBPLTYP="MB"   ; CMS-1500 ----> Medicare Part B  ;JRA IB*2.0*592 ';'
 ;I $$WNRBILL^IBEFUNC(IBIFN,IBSEQ),$$FT^IBCEF(IBIFN)=3 S IBPLTYP="MA"   ; UB-04 -------> Medicare Part A
 N FT S FT=$$FT^IBCEF(IBIFN)  ;JRA IB*2.0*592
 I $$WNRBILL^IBEFUNC(IBIFN,IBSEQ),(FT=2!(FT=7)) S IBPLTYP="MB"   ; CMS-1500 ----> Medicare Part B  ;JRA IB*2.0*592 same for J430D
 I $$WNRBILL^IBEFUNC(IBIFN,IBSEQ),FT=3 S IBPLTYP="MA"   ; UB-04 -------> Medicare Part A  ;JRA IB*2.0*592 Use 'FT' vs function call
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
CMNDATA(IBXIEN,IBPROC,FLD,INT) ;JRA;IB*2.0*608 Return data for specified Certificate of Medical Necessity (CMN) field.
 ;Created to return data for a specific CMN field, which is a subfield of file 399, field 304 (Procedure).  Returns data
 ; in External format by default.
 ;
 ;Input:  IBXIEN = Internal bill/claim number
 ;        IBPROC = Procedure # (subscript in ^DGCR)
 ;        FLD    = Field number of desired field
 ;        INT    = Flag set to 'I' if the subfield's Internal value is to be returned (optional)
 ;
 ;Output: VAL    = External (or optionally Internal) value of the CMN subfield specified by FLD
 ;
 Q:('$G(IBXIEN)!('$G(FLD)!('$G(IBPROC)))) ""
 S INT=$G(INT)
 N ND,VAL,X
 S ND=IBPROC_","_IBXIEN
 S VAL=$$GET1^DIQ(399.0304,ND,FLD,INT)
 Q VAL
 ;
CMNDEX(IBXIEN,IBXSAVE) ;JRA;IB*2.0*608 Data Extract for LQ, CMN and MEA segments
 Q:'$G(IBXIEN)
 ;
 N CMNREQ,ND,X,IBXDATA
 ;Get Procedure Links for all Procedures on the claim.
 D OUTPT^IBCEF11(IBXIEN,0) Q:'$D(IBXDATA)
 N LP,Z,CNT
 S LP=0 F  S LP=$O(IBXDATA(LP)) Q:'+LP  D
 . S CNT=$G(CNT)+1
 . Q:'$D(IBXDATA(LP,"CPLNK"))
 . S ND=IBXDATA(LP,"CPLNK")
 . S ND=ND_","_IBXIEN_","
 . S CMNREQ=$$GET1^DIQ(399.0304,ND,23,"I")
 . S:CMNREQ="" CMNREQ=0
 . Q:'+CMNREQ
 . S Z=$G(Z)+1
 . S IBXSAVE("CMNDEX",Z)=IBXDATA(LP,"CPLNK")_U_CNT
 Q
 ;
FRM(IBXIEN,IBXSAVE) ;JRA;IB*2.0*608 Data Extract for FRM segment
 Q:'$G(IBXIEN)
 ;
 N CMNREQ,CNT,DEL,IBXDATA,LP,ND,PAIRQ,QUIT,RESPTYP,X,Z,Z1
 ;Get Procedure Data for all Procedures on the claim.
 D OUTPT^IBCEF11(IBXIEN,0) Q:'$D(IBXDATA)
 S LP=0 F  S LP=$O(IBXDATA(LP)) Q:'+LP  D
 . Q:'$D(IBXDATA(LP,"CPLNK"))
 . S CNT=$G(CNT)+1
 . S ND=IBXDATA(LP,"CPLNK")
 . S ND=ND_","_IBXIEN_","
 . S CMNREQ=$$GET1^DIQ(399.0304,ND,23,"I")
 . S:CMNREQ="" CMNREQ=0
 . Q:'+CMNREQ
 . S Z=$G(Z)+1
 . ;WHAT FORM
 . N DATA,FORM,FLD,FLDS,INTEXT,QUES,QUESNUM,X
 . S FORM=$TR($$GET1^DIQ(399.0304,ND,"24:3","I"),"-")  ; get the form number to figure what fields go with it
 . Q:FORM=""  ; quit if no form number
 . ;
 . S FLDS=$P($T(@FORM),";;",2,9999)   ; get all the associated data fields from below
 . ;
 . N PAIREDQA
 . ;Parse FLDS to get DD field, question number, type of response (2=Y/N, 3=text/code, 4=date, 5=percent/decimal), and the response data.
 . F X=1:1 S QUES=$P(FLDS,"~",X)  Q:QUES=""  D
 .. S FLD=$P(QUES,U)
 .. S QUESNUM=$P(QUES,U,2)
 .. S RESPTYP=$P(QUES,U,3)
 .. I RESPTYP=4 S INTEXT="I"
 .. E  S INTEXT=$P(QUES,U,4) S:INTEXT="" INTEXT="E"
 .. S DATA=$$GET1^DIQ(399.0304,ND,FLD,INTEXT)
 .. ;
 .. ; KLUDGE; On form CMN10126 If 4A or 3A is blank, don't send the other (which means get rid of the previous Q/A)
 .. ; same for 4B/3B
 .. I FORM="CMN10126",".3A.3B.4A.4B."[QUESNUM S PAIRQ=0 D  Q:PAIRQ
 ... I QUESNUM="3A"!(QUESNUM="3B") S PAIREDQA(QUESNUM)=DATA Q
 ... I QUESNUM="4A",$G(PAIREDQA("3A"))="" S PAIRQ=1 Q
 ... I QUESNUM="4B",$G(PAIREDQA("3B"))="" S PAIRQ=1 Q
 ..;
 .. Q:DATA=""  ;Do not include FRM rec for unanswered questions
 .. ;
 .. S:RESPTYP=2 DATA=$E(DATA)  ; only want Y or N
 .. I QUESNUM=4,"YN"'[DATA S DATA="W"
 .. S:RESPTYP=4 DATA=$$DT^IBCEFG1(DATA,"","D8")  ;YYYYMMDD date format
 .. ;Procedure# has a 1 to many ratio with Question# but can't have 2 subscripts so combine into 1, ordering IBXSAVE by Question#.
 .. S IBXSAVE("FRM",(Z_"_"_(X/10)))=QUESNUM_U
 .. S $P(IBXSAVE("FRM",(Z_"_"_(X/10))),U,RESPTYP)=DATA
 .. S $P(IBXSAVE("FRM",(Z_"_"_(X/10))),U,6)=CNT
 ;
 ;Re-subscript IBXSAVE with sequential integers as current subscript format will not work with Output Formatter.
 S (Z,Z1)=0 F  S Z=$O(IBXSAVE("FRM",Z)) Q:'Z  S Z1=Z1+1,IBXSAVE("FRM",Z1)=IBXSAVE("FRM",Z),DEL(Z)=""
 S Z=0 F  S Z=$O(DEL(Z)) Q:'Z  K IBXSAVE("FRM",Z)
 Q
 ;
PTWT(IBXIEN) ;JRA;IB*2.0*608 Return CMN Patient Weight from 1st Service Line # that has it (or NULL if none)
 Q:'$G(IBXIEN)
 N FOUND,IBPROC,IBXSAVE,PTWT
 D CMNDEX(IBXIEN,.IBXSAVE)
 S (FOUND,Z)=0,PTWT="" F  S Z=$O(IBXSAVE("CMNDEX",Z)) Q:Z=""  D  Q:FOUND
 . S IBPROC=+IBXSAVE("CMNDEX",Z) Q:'IBPROC 
 . S PTWT=$$CMNDATA(IBXIEN,IBPROC,24.03) S:PTWT FOUND=1
 Q PTWT
 ;
 ;JRA;IB*2.0*608 Tags CMN484 & CMN10126 added
 ; FIELD#^QUESTION#^RESPONSE_TYPE^INT/EXT
CMN484 ;;24.1^1A^3~24.102^1B^5~24.103^1C^4~24.107^2^3^I~24.108^3^3^I~24.109^4^2^I~24.11^5^3~24.111^6A^3~24.113^6B^5~24.114^6C^4~24.104^7^2~24.105^8^2~24.106^9^2~24.115^C^3
 ;
CMN10126 ;;24.201^1^2~24.202^2^2~24.204^3A^3~24.219^3B^3~24.203^4A^3~24.218^4B^3~24.205^5^3^I~24.206^6^3~24.207^7^2~24.208^8A^3~24.209^8B^5~24.21^8C^3~24.211^8D^3~24.212^8E^5~24.213^8F^3~24.215^8G^3~24.216^8H^5~24.214^9^3^I
 ;
