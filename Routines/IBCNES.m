IBCNES ;ALB/ESG - eIV elig/Benefit screen ;14-Jul-2009
 ;;2.0;INTEGRATED BILLING;**416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EB(IBVF,IBVIENS,IBVEBFLG,IBVV,IBVSUB) ; entry point for main list display
 ; see below at tag INIT for a description of the parameters
 ; IBVSUB is required at this entry point because the ListMan array uses this variable
 ;
 D EN^VALM("IBCNE ELIGIBILITY/BENEFIT INFO")
EBX ;
 Q
 ;
HDR ; -- header code - called by ListManager
 ; build the header area based on the values of IBVF and IBVIENS
 ;
 ; pt. insurance
 I IBVF=2.322 D
 . N DFN,IBCDFN,PNB,PN,LPID,INS,INSNM
 . S DFN=+$P(IBVIENS,",",2)
 . S IBCDFN=+$P(IBVIENS,",",1)
 . S PNB=$$PT^IBEFUNC(DFN)
 . S PN=$P(PNB,U,1)    ; pt name
 . S LPID=$P(PNB,U,2)  ; pt id
 . S INS=+$P($G(^DPT(DFN,.312,IBCDFN,0)),U,1),INSNM=""
 . I INS S INSNM=$P($G(^DIC(36,INS,0)),U,1)
 . S VALMHDR(1)=$$FO^IBCNEUT1(PN,30)_"  "_$$FO^IBCNEUT1(LPID,15)_"  "_$$FO^IBCNEUT1(INSNM,30)
 . Q
 ;
 ; eIV response file
 I IBVF=365.02 D
 . N RSPIEN,IBX,DFN,INS,PNB,PN,LPID,INSNM
 . S RSPIEN=+IBVIENS
 . S IBX=$G(^IBCN(365,RSPIEN,0))
 . S DFN=+$P(IBX,U,2)   ; pt ien
 . S INS=+$P(IBX,U,3)   ; payer ien
 . S INSNM=""
 . S PNB=$$PT^IBEFUNC(DFN)
 . S PN=$P(PNB,U,1)     ; pt name
 . S LPID=$P(PNB,U,2)   ; pt id
 . I INS S INSNM=$P($G(^IBE(365.12,INS,0)),U,1)   ; payer name
 . S VALMHDR(1)=$$FO^IBCNEUT1(PN,30)_"  "_$$FO^IBCNEUT1(LPID,15)_"  "_$$FO^IBCNEUT1(INSNM,30)
 . Q
 ;
 Q
 ;
INIT(IBVF,IBVIENS,IBVEBFLG,IBVV,IBVSUB) ; List Entry
 ;
 ;     IBVF = file# 2.322 or 365.02 (required)
 ;  IBVIENS = std IENS list of internal entry numbers - NOT including any EB iens (required)
 ; IBVEBFLG = flag indicating which EB records to pull
 ;            "A" - all of them
 ;            "L" - only the last one (default)
 ;            "F" - only the first one
 ;            "M" - multiple, pass IBEBFLG by reference and include the IB iens in
 ;                  an array as follows:
 ;                  IBVEBFLG="M"
 ;                  IBVEBFLG(3)=""
 ;                  IBVEBFLG(5)=""
 ;     IBVV = Video attributes flag
 ;            1 = reverse video (default)
 ;            2 = bold
 ;            3 = underline
 ;   IBVSUB = literal subscript to use in the display scratch global
 ;
 NEW IBVDA,GLO,IBVLIST,IEN,IBVEBIEN,IBVEBTOT,IBVEBCNT
 ;
 S IBVSUB=$G(IBVSUB)
 I IBVSUB="" S IBVSUB="EB ELIG/BEN"
 K ^TMP(IBVSUB,$J)
 I $D(VALMEVL) D CLEAN^VALM10,KILL^VALM10()
 ;
 D DA^DILF(IBVIENS,.IBVDA)    ; build the IBVDA array for the iens
 I '$D(IBVDA) D NODATA G INITX
 ;
 I $D(VALMEVL),'$G(IBVV) S IBVV=1    ; default reverse video for ListMan
 I '$D(VALMEVL) S IBVV=""            ; no video attributes for non-ListMan
 ;
 I IBVF=2.322 S GLO=$NA(^DPT(+$G(IBVDA(1)),.312,+$G(IBVDA),6))   ; pt. insurance
 I IBVF=365.02 S GLO=$NA(^IBCN(365,+$G(IBVDA),2))                ; response file
 I $G(GLO)="" D NODATA G INITX
 ;
 S IBVEBFLG=$G(IBVEBFLG,"L")
 K IBVLIST
 I IBVEBFLG="L" S IEN=+$O(@GLO@(" "),-1) I IEN S IBVLIST(IEN)=""            ; last EB ien on file
 I IBVEBFLG="F" S IEN=+$O(@GLO@(0)) I IEN S IBVLIST(IEN)=""                 ; first EB ien on file
 I IBVEBFLG="A" S IEN=0 F  S IEN=$O(@GLO@(IEN)) Q:'IEN  S IBVLIST(IEN)=""   ; all EB iens on file
 I IBVEBFLG="M" S IEN=0 F  S IEN=$O(IBVEBFLG(IEN)) Q:'IEN  I $D(@GLO@(IEN)) S IBVLIST(IEN)=""   ; multiple
 ;
 I '$D(IBVLIST) D NODATA G INITX
 ;
 ; count them
 S IEN=0 F IBVEBTOT=0:1 S IEN=$O(IBVLIST(IEN)) Q:'IEN
 I 'IBVEBTOT D NODATA G INITX
 ;
 S (IBVEBIEN,IBVEBCNT)=0
 F  S IBVEBIEN=$O(IBVLIST(IBVEBIEN)) Q:'IBVEBIEN  D
 . S IBVEBCNT=IBVEBCNT+1
 . N TXVIENS
 . ;
 . ; if there is more than 1 EB group, then display a header line for separation
 . I IBVEBTOT>1 D
 .. N DSP,LN,IBZ
 .. S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))
 .. S LN=+$O(@DSP@(""),-1)
 .. S IBZ="eIV Eligibility/Benefit Data Group# "_IBVEBCNT_" of "_IBVEBTOT
 .. S IBZ=$$FO^IBCNEUT1($J("",20)_IBZ,80)
 .. S LN=LN+1 D SET^IBCNES1(LN,1,IBZ,,IBVV)
 .. S LN=LN+1 D SET^IBCNES1(LN)
 .. Q
 . ;
 . ; add this EB ien to the list of iens
 . S TXVIENS=IBVEBIEN_","_IBVIENS
 . ;
 . ; call the screen sections to build the display
 . D EB^IBCNES1(IBVF,TXVIENS,IBVV,IBVSUB)
 . D CMPI^IBCNES1(IBVF,TXVIENS,IBVV,IBVSUB)
 . D HCSD^IBCNES1(IBVF,TXVIENS,IBVV,IBVSUB)
 . D BRE^IBCNES1(IBVF,TXVIENS,IBVV,IBVSUB)
 . ;
 . Q
 ;
 S VALMCNT=$O(^TMP(IBVSUB,$J,"DISP"," "),-1)
 ;
INITX ;
 Q
 ;
NODATA ; display no data found
 N DSP,LN
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))       ; scratch global display array
 S LN=+$O(@DSP@(""),-1)                  ; last line# used in scratch global
 S LN=LN+1 D SET^IBCNES1(LN)
 S LN=LN+1 D SET^IBCNES1(LN,5,"No eIV Eligibility/Benefit Data Found")
 S VALMCNT=$O(^TMP(IBVSUB,$J,"DISP"," "),-1)
NODATAX ;
 Q
 ;
HELP ; -- help code
 S X="?",VALMANS="??" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP(IBVSUB,$J)
 I $D(VALMEVL) D CLEAN^VALM10,KILL^VALM10()
 Q
 ;
