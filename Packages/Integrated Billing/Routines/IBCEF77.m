IBCEF77 ;WOIFO/SS - FORMATTER/EXTRACT BILL FUNCTIONS ;31-JUL-03
 ;;2.0;INTEGRATED BILLING;**232,280,155,290,291,320,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
SORT(IBPRNUM,IBPRTYP,IB399,IBSRC,IBDST,IBN,IBEXC,IBSEQ,IBLIMIT) ;
 N IBXIEN,IBXDATA,IBNET,IBTRI,IB1,IB2,IBID,Z,IBZ,IBZ1,IBSVP
 S (IB1,IB2,IBZ,IBZ1,IBTRI)=""
 D F^IBCEF("N-ALL ATT/RENDERING PROV SSN","IBZ",,IB399)
 S IBZ1=$$ALLPTYP^IBCEF3(IB399)
 F Z=1:1:3 S $P(IBZ1,U,Z)=$S($P(IBZ1,U,Z)="CH":1,1:"") S:$P(IBZ1,U,Z) IBTRI=1
 S IBNET=$$NETID^IBCEP() ; netwrk id type
 I $G(IBN) D
 . S Z=0 F  S Z=$O(IBDST(IBPRNUM,IBPRTYP,Z)) Q:'Z  S IBID(+$P(IBDST(IBPRNUM,IBPRTYP,Z),U,9))=""
 F  S IB1=$O(IBSRC(IB1)) Q:IB1=""  D  Q:IBN=IBLIMIT
 . N OK,IBSTLIC
 . S IBSTLIC=""
 . F  S IB2=$O(IBSRC(IB1,IB2)) Q:IB2=""  D  Q:IBN=IBLIMIT
 . . S IBSVP=$P(IBSRC(IB1,IB2),U)
 . . ; If ID overridden, output no others of this type
 . . I $G(IBEXC),$P($G(IBSRC(IB1,IB2)),U,9)=IBEXC Q
 . . ; Ck state of care/lic match if st lic#
 . . I $P($G(IBSRC(IB1,IB2)),U,3)="0B" S OK=1 D  Q:'OK
 . . . I +$$CAREST^IBCEP2A(IB399)'=$P(IBSRC(IB1,IB2),U,7) S IBSTLIC=1 Q
 . . . I $G(IBSTLIC(0))'="" S OK=0 Q
 . . . S IBSTLIC(0)=$G(IBSRC(IB1,IB2)),OK=0
 . . ; Exclude SSN from sec ids unless required
 . . I $P($G(IBSRC(IB1,IB2)),U,3)="SY" Q
 . . ; Only 1 of each prov id type
 . . Q:$D(IBID(+$P($G(IBSRC(IB1,IB2)),U,9)))
 . . S IBN=IBN+1,IBID(+$P($G(IBSRC(IB1,IB2)),U,9))=""
 . . S IBDST(IBPRNUM,IBPRTYP,IBN)=$G(IBSRC(IB1,IB2))
 . I IBN'=IBLIMIT,'$G(IBSTLIC),$G(IBSTLIC(0))'="" S IBN=IBN+1,IBDST(IBPRNUM,IBPRTYP,IBN)=IBSTLIC(0)
 I $$FT^IBCEF(IB399)=2,$G(IBID(IBNET))="",IBTRI,$P(IBZ1,U,IBSEQ) D    ; WCJ 02/13/2006
 . Q:$P(IBZ,U,IBPRTYP)=""
 . ; here, no network id & TRICARE ins co.
 . N Z
 . S Z=+$O(^DGCR(399,IB399,"PRV","B",IBPRTYP,0)),Z=$P($G(^DGCR(399,IB399,"PRV",Z,0)),U,2)
 . S IBN=IBN+1,IBDST(IBPRNUM,IBPRTYP,IBN)=Z_U_+$$POLICY^IBCEF(IB399,1,IBSEQ)_U_$P($G(^IBE(355.97,IBNET,0)),U,3)_U_$P(IBZ,U,IBPRTYP)_U_"0^0^^^"_IBNET
 Q
 ;
 ; esg - 8/25/06 - IB*2*348 - CFIDS function
 ;
CFIDS(IBIFN,PRVTYP,ALLOWIDS) ; Claim Form IDs for human providers
 ; Function returns a 3 piece string:  [1] default secondary ID qual
 ;                                     [2] default secondary ID
 ;                                     [3] NPI
 ; Input:   IBIFN - internal claim#
 ;         PRVTYP - internal provider type ID number
 ;                - 1:REFER;2:OPER;3:REND;4:ATT;5:SUPER;9:OTHER
 ;                - if blank, then default Att/Rend based on form type
 ;         ALLOWIDS - List of allowable Secondary IDS ^ delimited. 
 ;                  ex "^1A^1B^1C^1H^G2^LU^N5^"
 ;                  UB-04 only wants IDs provided by the payer, not the providers own IDS
 ;                  Also, they want the qualifier to be G2 (Commercial)
 ;                  if it is a payer provided ID
 NEW ID,FT,IBZ,IBQ,IBSID,IBNPI,I,OK
 S ID=""
 I '$G(IBIFN) G CFIDSX
 S FT=$$FT^IBCEF(IBIFN)
 I '$G(PRVTYP) S PRVTYP=3 I FT=3 S PRVTYP=4
 D ALLIDS^IBCEF75(IBIFN,.IBZ,1)
 S OK=0 I $G(ALLOWIDS)="" S OK=1
 F I=1:1 D  Q:OK
 . S IBQ=$P($G(IBZ("PROVINF",IBIFN,"C",1,PRVTYP,I)),U,3)    ; qualifier
 . S IBSID=$P($G(IBZ("PROVINF",IBIFN,"C",1,PRVTYP,I)),U,4)  ; ID#
 . I IBQ="",IBSID="" S OK=1 Q
 . Q:OK
 . I $G(ALLOWIDS)[(U_IBQ_U) S OK=1,IBQ="G2" Q
 . S (IBQ,IBSID)=""
 S IBNPI=""
 D F^IBCEF("N-PROVIDER NPI CODES","IBNPI",,IBIFN)
 S IBNPI=$P(IBNPI,U,PRVTYP)                               ; NPI
 ;
 ; special check for the referring doc
 I PRVTYP=1,$D(IBZ("PROVINF",IBIFN,"C",1,PRVTYP)),IBQ="",IBSID="" S IBQ="1G",IBSID="VAD000"
 ;
 ; If UB-04 and no IDs, use VA UPIN as deafult
 I $D(IBZ("PROVINF",IBIFN,"C",1,PRVTYP)),FT=3,IBQ="",IBSID="" S IBQ="1G",IBSID="VAD000"
 ;
 ; determine if legacy ID's should be displayed
 I '$$PRTLID(IBIFN,IBNPI) S (IBQ,IBSID)=""
 ;
 S ID=IBQ_U_IBSID_U_IBNPI
CFIDSX ;
 Q ID
 ;
DOL(AMT,LEN,DEC) ; format dollar amounts for printed claim forms
 ; AMT = amount to be formatted
 ; LEN = length of field - right justified to this length
 ; DEC = flag to include the decimal point or not
 ;       DEFAULT value is to not include the decimal point
 ;       if DEC is not defined or 0, assume no decimal point
 ;       so 15 will be returned as 1500, 6.77 will be returned as 677
 ;       if DEC is 1, then the decimal point will be included
 ;
 S LEN=$G(LEN,10),DEC=$G(DEC,0)     ; defaults
 S AMT=$FN(+$G(AMT),"",2)           ; format # with 2 decimals
 I 'DEC S AMT=$TR(AMT,".")          ; strip or leave decimal
 S AMT=$J(AMT,LEN)                  ; right justify
 Q AMT
 ;
PRTLID(IBIFN,NPI) ; YMG; Print Legacy IDs on the CMS-1500 or UB-04 form
 ; Function fetches form type associated with given claim number
 ; (values: 2 - CMS-1500 form, 3 - UB-04 form), then looks at
 ; "Print Legacy ID" site parameter for this particular form type.
 ; 
 ; Possible site parameter values are:
 ;   "Y" - always print Legacy ID
 ;   "N" - never print Legacy ID
 ;   "C" - only print Legacy ID if NPI is not available.
 ;   
 ; This information is used to determine if Legacy ID should be printed
 ; for claim number in question.
 ; 
 ; Note: Situation when "Print Legacy ID" site parameter is not set is treated
 ;       as if this parameter was set to "Y" - always print Legacy ID.
 ; 
 ; Input:
 ;             IBIFN - internal claim number
 ;       NPI   - NPI number (or "" if no NPI is available)
 ; 
 ; Returns:
 ;       0  - Legacy ID should not be printed
 ;       1  - Legacy ID should be printed
 ;
 Q $S(NPI="":"YC",1:"Y")[$P($G(^IBE(350.9,1,1)),U,$S($$FT^IBCEF(IBIFN)=2:32,1:33))
 ;
REMARK(IBIFN,IBXDATA,OFLG) ; procedure to return array of UB-04 remark text
 ; for claim IBIFN.  Data pulled from field# 402 of file 399 and
 ; formatted into an array IBXDATA(n) where each line is not greater
 ; than 24 characters long.  This will fit into UB-04 FL-80.
 ;
 ; OFLG=1 only when called in the output formatter.  In this case, only
 ; 4 lines in IBXDATA will be returned.
 ;
 NEW TEXT,LEN,IBZ,J,PCE,CHS,NEWCHS,IBK,J,TX
 K IBXDATA
 S TEXT=$P($G(^DGCR(399,+$G(IBIFN),"UF2")),U,3) I TEXT="" Q
 ;
 ; need to break up large words for word wrapping purposes to get
 ; as many characters as possible in the box.
 S LEN=17
 F PCE=1:1 Q:PCE>$L(TEXT," ")  S CHS=$P(TEXT," ",PCE) I $L(CHS)>LEN D
 . S NEWCHS=$E(CHS,1,LEN)_" "_$E(CHS,LEN+1,999)
 . S $P(TEXT," ",PCE)=NEWCHS
 . Q
 ;
 ; When calling FSTRNG^IBJU1 which calls ^DIWP, FileMan builds the
 ; array with strings of max length=1 less than what you tell it.
 ;
 S LEN=20                             ; line 1 is 19 chars
 D FSTRNG^IBJU1(TEXT,LEN,.IBZ)        ; build IBZ array
 S IBK=$$TRIM^XLFSTR($G(IBZ(1)))      ; save off the first line
 S TEXT=$P(TEXT,IBK,2,99)             ; restore the rest of the text
 S TEXT=$$TRIM^XLFSTR(TEXT)           ; trim spaces
 ;
 S LEN=25                             ; the rest is 24 chars
 D FSTRNG^IBJU1(TEXT,LEN,.IBZ)        ; build IBZ array
 S IBXDATA(1)="     "_IBK             ; line 1
 S J=0 F  S J=$O(IBZ(J)) Q:'J  D      ; lines 2-n
 . I J>3,$G(OFLG) Q                   ; only 4 lines for output formatter
 . S TX=$$TRIM^XLFSTR($G(IBZ(J)))
 . I TX'="" S IBXDATA(J+1)=TX
 . Q
 Q
 ;
