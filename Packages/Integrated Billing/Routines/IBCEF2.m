IBCEF2 ;ALB/TMP - FORMATTER SPECIFIC BILL FUNCTIONS ;8/6/03 10:54am
 ;;2.0;INTEGRATED BILLING;**52,85,51,137,232,155,296,349,403,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
HOS(IBIFN) ; Extract rev codes for inst. episode into IBXDATA
 ; Moved for space
 D HOS^IBCEF22(IBIFN)
 Q
 ;
OTHINS(IBIFN) ;Determine 'other insurance' node (I1,I2)
 ; If primary bill, other ins is secondary
 ; If sec or tert bill, other ins is primary
 ;IBIFN = bill ien
 N Z
 S Z=$$COBN^IBCEF(IBIFN)
 Q "I"_$S(Z=1:2,1:1)
 ;
OTHINS1(IBIFN) ; Returns the COB #'s of all 'other insurance' as a string
 ;IBIFN = bill ien
 N IBC,Z
 S Z=$$COBN^IBCEF(IBIFN)
 I Z=1 S IBC=$S($D(^DGCR(399,IBIFN,"I2")):$S($D(^DGCR(399,IBIFN,"I3")):23,1:2),1:"") ;Primary=>2 or 23
 I Z=2 S IBC="1"_$S($D(^DGCR(399,IBIFN,"I3")):3,1:"") ;Secondary=>1 or 13
 I Z=3 S IBC="12" ;Tertiary =>12
OTHQ Q IBC
 ;
RECVR(IBIFN) ; Returns the V.A. internal routing id of the current ins
 ; co for 837
 ;IBIFN = bill ien
 N MCR,NUM,IBPH
 S IBPH=$P("P^H",U,$$FT^IBCEF(IBIFN)-1)
 S NUM="ENVOY"_IBPH
 ; If rate type is CHAMPVA, send 'CHAMVA'
 I $P($G(^DGCR(399.3,+$P($G(^DGCR(399,IBIFN,0)),U,7),0)),U)="CHAMPVA" S NUM="CHAMV"_IBPH
 I NUM["ENVOY",$$MCRWNR^IBEFUNC(+$$CURR(IBIFN)) D
 . S MCR=$P("B^A",U,$$FT^IBCEF(IBIFN)-1)    ; PART A/B for MEDICARE
 . S NUM="PART"_MCR
 Q NUM
 ;
ALLPAYID(IBIFN,IBXDATA,SEQ) ; Returns clearinghouse id for all (SEQ="")
 ;  or a specific (SEQ=1,2,3) ins co's for 837 in IBXDATA(n) for bill ien
 ;  IBIFN
 ; EJK *296* Add IBMRA - MRA Claim type. 
 ; EJK *296* Add IBEBI - Electronic Billing ID
 N Z,Z0,Z1,A,IBM,IBINST,IBMCR,IBX,IBMRA,IBEBI
 S IBXDATA="",IBM=$G(^DGCR(399,IBIFN,"M"))
 F Z=1:1:3 I $S('$G(SEQ):1,1:Z=SEQ) S Z0=$P(IBM,U,Z) I Z0 D  S:A'="" IBXDATA(Z)=A
 . S A=""
 . S IBINST=($$FT^IBCEF(IBIFN)=3) ;Is bill UB-04?
 . ; EJK *296* Get IBEBI based on Prof. or Inst. claim
 . I IBINST S IBEBI=$P($G(^DIC(36,Z0,3)),U,4)
 . I 'IBINST S IBEBI=$P($G(^DIC(36,Z0,3)),U,2)
 . S IBEBI=$$UP^XLFSTR(IBEBI)
 . ; EJK *296* If this is a Medicare claim, it may be printed or transmitted. 
 . S IBMRA=$$MRASEC^IBCEF4(IBIFN)   ;Is claim 2ndary to an MRA? 
 . S IBMCR=$$MCRONBIL^IBEFUNC(IBIFN),Z1=$G(^DGCR(399,IBIFN,"TX"))
 . Q:$P(Z1,U,8)=1!$S('$P(Z1,U,9):0,1:$$MRASEC^IBCEF4(IBIFN))  ;Force local prnt
 . S A=$S($P(Z1,U,8)'=2:$P($G(^DIC(36,Z0,3)),U,$S(IBINST:4,1:2)),1:"")
 . S A=$$UP^XLFSTR(A)
 . ;
 . ; RPRNT = CMS-1500 Rx bills
 . ; IPRNT = Inst MRA secondary claims
 . ; PPRNT = Prof MRA secondary claims
 . ; HPRNT = inst printed bills (non-MRA, force print at clearinghouse)
 . ; SPRNT = prof printed bills (non-MRA, force print at clearinghouse)
 . ;
 . ; Default to appropriate 'xPRNT' if Rx bill or COB bill or forced to
 . ;    print - claims must print at clearinghouse
 . ;
 . ; Rx bills on CMS-1500
 . I 'IBINST,$$ISRX^IBCEF1(IBIFN) S A="RPRNT" Q
 . ;
 . ; Claim forced to print at clearinghouse
 . I $P(Z1,U,8)=2 S A=$S(IBINST:"H",1:"S")_"PRNT" Q
 . ;
 . ; EJK *296* Send IBEBI for MRA secondary claims if it exists
 . I Z>1,IBMRA,IBEBI'="" S A=IBEBI Q
 . ;
 . ; MRA secondary claim
 . I Z>1,IBMCR=1,$P(Z1,U,5)="C" S A=$S(IBINST:"I",1:"P")_"PRNT" Q
 . ;
 . ; Medicare is current payer (MRA request claim)
 . I $$WNRBILL^IBEFUNC(IBIFN,Z) S A=$S(IBINST:"12M61",1:"SMTX1") Q
 . ;
 . ; IB*296 - Do not modify the payer ID for CHAMPVA (HAC)
 . I A=84146 Q
 . I A=84147 Q
 . ;
 . ; If not a primary bill force to print
 . I Z>1,Z=$$COBN^IBCEF(IBIFN) S A=$S(IBINST:"H",1:"S")_"PRNT" Q
 . Q
 ;
 Q
 ;
PAYERID(IBIFN) ; Returns clearinghouse id for current ins co
 ; IBIFN = bill ien
 N NUM,IBSEQ
 ; Determine the current ins co's # to identify at WEBMD
 ; Envoy changed to WEBMD in patch 232
 S IBSEQ=+$$COBN^IBCEF(IBIFN)
 D ALLPAYID(IBIFN,.NUM,IBSEQ) S NUM=$G(NUM(IBSEQ))
 Q $G(NUM)
 ;
CURR(IBIFN) ; Returns ien of the current insurance
 ; company for bill ien IBIFN
 Q $$FINDINS^IBCEF1(IBIFN)
 ;
ADMDT(IBIFN,NOOUTCK) ; Calculate admission/start of care date/time
 D ADMDT^IBCEF21(IBIFN,$G(NOOUTCK))      ; Moved for space
 Q
 ;
DISDT(IBIFN) ; Calculate discharge date
 D DISDT^IBCEF21(IBIFN)                  ; Moved for space
 Q
 ;
INDTS(IBIFN) ; Function returns the admit ^ discharge date/time of admission if patient is an inpatient on bill's event date
 N Z,Z0,DFN,VAINDT,VAIN S Z0=""
 S Z=$G(^DGCR(399,+$G(IBIFN),0)),DFN=$P(Z,U,2),VAINDT=$P(Z,U,3)
 I +DFN,+VAINDT D INP^VADPT I +VAIN(1) S Z0=+VAIN(7)_U_+$G(^DGPM(+$P($G(^DGPM(+VAIN(1),0)),U,17),0))
 Q Z0
 ;
TXMT(IBIFN) ; Function moved - use new call in IBCEF4
 Q $$TXMT^IBCEF4(IBIFN)
 ;
 ;
ID(LN,VAL) ; Set EXTRACT GLOBAL for multi-valued record
 ; ids for Austin
 ; LN = the line # being extracted
 ; VAL = the value of the element being extracted
 ;
 ; Assumes IBXPG exists
 ;
 Q:LN<2
 D SETGBL^IBCEFG(IBXPG,LN,1,VAL,.IBXSIZE)
 Q
 ;
ID1(LN,DX,CT) ;Special entrypoint for diagnoses to 'save' the fact
 ;   a dx code is an e-code.
 ; LN is last entry # output, returned as the entry # (IBXLINE) to assign to this entry
 ; DX = the actual Dx code array(RECORD ID). Pass by reference, DX returned null if
 ;      dx was not output
 ; CT = the ct on the 'DC' entry.  pass by reference, returned null if
 ;      the end of the valid dx codes has been reached
 N IBINS,VAL,CNT,DXIEN,DXQ,EDX,I,POA
 S IBINS=($$FT^IBCEF(IBXIEN)=3)
 S VAL="DC"_CT
 S VAL=$E(VAL_" ",1,4)
 S EDX=($E($G(DX))="E") ; TRUE if e-code DX
 S I=$S(EDX:3,1:2)
 S:'EDX DXQ=$S(+$G(^TMP("DCX",$J,2))>0:"BF",1:"BK") ; first non e-code DX is principal (qulifier "BK"), the rest have qualifier "BF"
 I IBINS D
 .I CT>28 S CT="" Q     ; Max of 28 codes for institutional/UB
 .S DXIEN=$P(DX(CT),U,2) Q:DXIEN=""
 .S POA=$P($G(^IBA(362.3,DXIEN,0)),U,4) I POA="",$$INPAT^IBCEF(IBXIEN) S POA=1 ; POA indicator defaults to "1", if not present on inpatient claim
 .S:EDX DXQ="BN" ; e-code DX qualifier
 .Q
 I 'IBINS S:EDX DXQ="BF" S POA="" ; on CMS-1500 e-code DX qualifiers are "BF" and there's no POA
 I 'IBINS,CT>8 S ^TMP("IBXSAVE",$J,"DX",IBXIEN)=$G(^TMP("IBXSAVE",$J,"DX",IBXIEN))+1,^TMP("IBXSAVE",$J,"DX",IBXIEN,$P(DX(+^TMP("IBXSAVE",$J,"DX",IBXIEN)),U,2))=$G(^TMP("IBXSAVE",$J,"DX",IBXIEN)) S DX="" Q
 I CT'="",DX'="" D
 .; populate ^TMP("DCX") scratch global
 .S ^TMP("DCX",$J,1)=CT,CNT=$G(^TMP("DCX",$J,I))+1,^TMP("DCX",$J,I)=CNT
 .S (^TMP("DCX",$J,I,CNT),^TMP("DCX",$J,1,CT))=DX_U_DXQ_U_POA
 .S LN=LN+1 D ID(LN,VAL) S ^TMP("IBXSAVE",$J,"DX",IBXIEN,$P(DX(LN),U,2))=LN,^TMP("IBXSAVE",$J,"DX",IBXIEN)=CT,CT=CT+1
 .Q
 Q
 ;
M(CT) ; Calculate multi-valued field for 837 extract
 ; CT = passed by reference/the record ID counter
 S CT=CT+1
 Q $E(CT#12+$S(CT#12:0,1:12)_" ",1,2)
 ;
SVITM(IBA,LINE) ; Saves the linked items from the bill data extract into
 ; an array the formatter will use to link Rxs and prosthetics
 ; to an SV1 or SV2 line item, if possible.  Kills off IBA array entries
 ; after they are 'moved'
 ; IBA = array that contains the data to be saved
 ;   subscripts are (line #,item type,item pointer)=ct
 N Z0,Z1
 S Z0="" F  S Z0=$O(IBA("OUTPT",LINE,Z0)) Q:Z0=""  I Z0?1N.N  S Z1="" F  S Z1=$O(IBA("OUTPT",LINE,Z0,Z1)) Q:Z1=""  S ^TMP($J,"IBITEM",Z0,Z1,LINE)=IBA("OUTPT",LINE,Z0,Z1) K IBA("OUTPT",LINE,Z0,Z1)
 Q
 ;
LINK(IBTYP,IBDATA) ; Link the item with a service line, if possible
 ; IBTYP = the code for the type of item
 ;         returned incremented if no link is made
 ; IBDATA = the extracted data string that identifies the item. 
 ; Returns the line to link to or null if no link
 N IBLN,IBKEY,Z
 S IBLN=""
 S IBKEY=$S(IBTYP=3:$P(IBDATA,U,9),IBTYP=5:$P(IBDATA,U,4),1:"") Q:IBKEY=""
 I $D(^TMP($J,"IBITEM",IBTYP,IBKEY)) D  G:IBLN LINKQ
 .S Z=0 F  S Z=$O(^TMP($J,"IBITEM",IBTYP,IBKEY,Z)) Q:'Z  I ^TMP($J,"IBITEM",IBTYP,IBKEY,Z) S IBLN=Z,^TMP($J,"IBITEM",IBTYP,IBKEY,Z)=^TMP($J,"IBITEM",IBTYP,IBKEY,Z)-1 Q
 I $D(^TMP($J,"IBITEM",IBTYP,0)) S IBKEY=0 D
 .S Z=0 F  S Z=$O(^TMP($J,"IBITEM",IBTYP,IBKEY,Z)) Q:'Z  I ^TMP($J,"IBITEM",IBTYP,IBKEY,Z) S IBLN=Z,^TMP($J,"IBITEM",IBTYP,IBKEY,Z)=^TMP($J,"IBITEM",IBTYP,IBKEY,Z)-1 Q
LINKQ Q IBLN
 ;
COID(IBIFN) ; Claim office ID - moved for space
 Q $$COID^IBCEF21(IBIFN)
 ;
PPOL(IBIFN,COB) ; return IFN of patient policy on a bill defined by COB (fields 399,112-114)
 N X,Y,PPOL S PPOL=""
 I +$G(IBIFN) S X=$G(^DGCR(399,+IBIFN,"M")) I +$G(COB),COB<4 S Y=COB+11,PPOL=$P(X,U,Y)
 Q PPOL
 ;
LADJ(SUB,LINE,SEQ1,GRP,IBXSAVE,PIECE) ; Extract line level adjustments
 ; SUB     = 1st subscript in IBXSAVE array to use
 ; LINE    = 2nd subscript
 ; SEQ1    = 4th subscript
 ; GRP     = 5th subscript
 ; IBXSAVE = array that has the data for COB line level adjustments
 ; PIECE   = # of the piece on the 0-node of the line level
 ;           adjustment reason to be extracted
 ;
 N A,B
 S (A,B)=0
 F  S A=$O(IBXSAVE(SUB,LINE,"COB",SEQ1,GRP,A)) Q:'A  D
 . S B=B+1,IBXDATA(B)=$P(IBXSAVE(SUB,LINE,"COB",SEQ1,GRP,A),U,PIECE)
 Q
 ;
ESGHPST(IBIFN,COB) ; return insureds employ status if bill policy defined by COB is an Employer Sponsored Group Health Plan
 Q $$ESGHPST^IBCEF21(IBIFN,COB) ;Tag moved
 ;
ESGHPNL(IBIFN,COB) ; return employer name and location if bill policy defined by COB is an Employer Sponsored Group Health Plan
 Q $$ESGHPNL^IBCEF21(IBIFN,COB) ;Tag moved
 ;
AMTOUT(A,B,C,IBXSAVE) ; format output amount
 ;
 N Z,K,IBZ,IBARR K IBXDATA S (IBZ,K)=0,IBARR="IBXSAVE("""_A_""")" F  S IBZ=$O(@IBARR@(IBZ)) Q:'IBZ  S K=K+1,Z=0 F  S Z=$O(@IBARR@(IBZ,Z)) Q:'Z  I $P($G(@IBARR@(IBZ,Z,B)),U,C) S IBXDATA(K)=$$DOLLAR^IBCEFG1($G(IBXDATA(K))+$P(@IBARR@(IBZ,Z,B),U,C))
 Q
