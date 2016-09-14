IBJTU6 ;ALB/ESG - TPJI UTILITIES/APIs ;9/2/11
 ;;2.0;INTEGRATED BILLING;**452,530**;21-MAR-94;Build 71
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
IBDSP(TYPE,IBIFN,DFN,IBCDFN,IBLMDISPA,VALMHDR) ; Build IB display array data
 ; The purpose of this API is to build the List Manager display array scratch global
 ; and return it to the calling application in the scratch global array specified.
 ;
 ;  Input:
 ;      TYPE - type of IB screen data to build, can be one of the following:
 ;         1 = TPJI Claim Information screen (default)
 ;         2 = TPJI AR Account Profile screen
 ;         3 = TPJI AR Comment History screen
 ;         4 = TPJI ECME Rx Response screen
 ;         5 = Patient Insurance Policy Information screen
 ;     IBIFN - claim ien (#399) Required for any TPJI screen, otherwise optional
 ;       DFN - patient ien (#2) Required for Insurance screen, otherwise optional
 ;    IBCDFN - insurance type ien (#2.312) Required for Insurance screen, otherwise optional
 ;
 ; Output:
 ;    IBLMDISPA - Destination scratch global reference in which to store the results
 ;                Pass closed scratch global reference.
 ;                Data will be returned in @IBLMDISPA@(LN,0), where LN is a sequential line# counter
 ;      VALMHDR - LM display header array.  Pass by reference
 ;
 N VALMAR,IBRTN
 N I,IBX,IBXARRAY,IBXARRY,IBXERR,IBXSAVE,VALMBG,VALMSG,VALMCNT,X,Y,Z,IBPOLICY,IBARCOMM
 N D0,IB1ST,IBCNS,IBCPOL,IBCPOLD,IBCPOLD1,IBCPOLD2,VALM,VALMDDF,GX,IBPPOL
 K @IBLMDISPA,VALMHDR
 ;
 I '$F(".1.2.3.4.5.","."_$G(TYPE)_".") S TYPE=1
 ;
 I $F(".1.2.3.4.","."_TYPE_"."),'$G(IBIFN) G IBDSPX    ; IBIFN required for TPJI screens
 I $F(".1.2.3.4.","."_TYPE_"."),'$G(DFN) S DFN=+$P($G(^DGCR(399,+$G(IBIFN),0)),U,2) I 'DFN G IBDSPX
 I TYPE=5,'$G(DFN) G IBDSPX       ; DFN required for ins
 I TYPE=5,'$G(IBCDFN) G IBDSPX    ; IBCDFN required for ins
 ;
 I TYPE=1 S VALMAR=$NA(^TMP("IBJTCA",$J)),IBRTN="INIT^IBJTCA,HDR^IBJTCA"   ; tpji claim info
 I TYPE=2 S VALMAR=$NA(^TMP("IBJTTA",$J)),IBRTN="INIT^IBJTTA,HDR^IBJTTA"   ; tpji AR acct profile
 I TYPE=3 S VALMAR=$NA(^TMP("IBJTTC",$J)),IBRTN="INIT^IBJTTC,HDR^IBJTTC"   ; tpji AR comment
 I TYPE=4 S VALMAR=$NA(^TMP("IBJTRX",$J)),IBRTN="INIT^IBJTRX,HDR^IBJTRX"   ; tpji ECME Rx
 I TYPE=5 S VALMAR=$NA(^TMP("IBCNSVP",$J)),IBRTN="INIT^IBCNSP"             ; pt ins policy detail
 ;
 I TYPE=2 S VALM("IFN")=+$$FIND1^DIC(409.61,,,"IBJT AR ACCOUNT PROFILE"),GX="D COL^VALM" X GX
 I TYPE=5 S IBPPOL=U_2_U_DFN_U_IBCDFN_U_$G(^DPT(DFN,.312,IBCDFN,0))
 K @VALMAR
 D @IBRTN
 ;
 ; merge IB display lines into target array
 M @IBLMDISPA=@VALMAR
 ;
 ; clean up IB scratch arrays
 K @VALMAR,^TMP($J,"IBTPJI"),^TMP("IBJTTAX",$J)
 ;
IBDSPX ;
 Q
 ;
BILLREJ(BILL) ;Is the bill a reject?
 ; Input:
 ; BILL - Bill number from #399 - External Value (.01), not IEN
 ; Output:
 ; REJECT - Reject status (blank = not found, 0 = not a reject, 1 = rejected)
 ;
 N IEN,PTR,SEV,REJECT
 I BILL="" Q ""  ;no bill #
 S REJECT=0,IEN=$O(^DGCR(399,"B",BILL,"")) Q:'IEN ""
 I '$D(^IBM(361,"B",IEN)) Q ""  ;no entry in #361
 S PTR=0 F  S PTR=$O(^IBM(361,"B",IEN,PTR)) Q:'PTR  D  Q:REJECT
 . S SEV=$$GET1^DIQ(361,PTR_",",.03,"I")
 . I SEV="R" S REJECT=1
 Q REJECT
