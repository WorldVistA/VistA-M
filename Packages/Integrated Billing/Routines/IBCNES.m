IBCNES ;ALB/ESG - eIV elig/Benefit screen ; 14-Jul-2009
 ;;2.0;INTEGRATED BILLING;**416,438,497,506,702,806,822**;21-MAR-94;Build 21
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
 . N DFN,IBCDFN,PNB,PN,LPID,INS,INSNM,IENS,RSDATE,RSTYPE
 . S DFN=+$P(IBVIENS,",",2)
 . S IBCDFN=+$P(IBVIENS,",",1)
 . S PNB=$$PT^IBEFUNC(DFN)
 . S PN=$P(PNB,U,1)    ; pt name
 . S LPID=$P(PNB,U,2)  ; pt id
 . S INS=+$P($G(^DPT(DFN,.312,IBCDFN,0)),U,1),INSNM=""
 . I INS S INSNM=$P($G(^DIC(36,INS,0)),U,1)
 . S IENS=IBCDFN_","_DFN_","
 . S RSDATE=$$GET1^DIQ(2.312,IENS,8.01,"I"),RSTYPE=$$GET1^DIQ(2.312,IENS,8.02,"I")
 . S VALMHDR(1)=$$FO^IBCNEUT1(PN,30)_"  "_$$FO^IBCNEUT1(LPID,15)_"  "_$$FO^IBCNEUT1(INSNM,30)
 . S VALMHDR(2)="** Based on service date "_$S(RSDATE:$$FMTE^XLFDT(RSDATE,"5Z"),1:"UNKNOWN")_" and service type: "_$S(RSTYPE:$P($G(^IBE(365.013,RSTYPE,0)),U,2),1:"UNKNOWN")_" **"
 . S RSPIEN=$$GET1^DIQ(2.312,IENS,8.03,"I")
 ;
 ; eIV response file
 I IBVF=365.02 D
 . N RSPIEN,IBX,DFN,INS,PNB,PN,LPID,INSNM,TQIEN,NODE0,RSTYPE,RSDATE
 . S RSPIEN=+IBVIENS
 . S IBX=$G(^IBCN(365,RSPIEN,0))
 . ; IB*702/TAZ,CKB - Set the RSTYPE=REQUESTED SERVICE TYPE CODE (365,.15), and
 . ; RSDATE=REQUESTED SERVICE DATE (365,.14)
 . ;S TQIEN=$P(IBX,U,5),NODE0=$G(^IBCN(365.1,TQIEN,0)),RSTYPE=$P(NODE0,U,20)
 . S RSTYPE=$$GET1^DIQ(365,RSPIEN_",",.15,"I")
 . ;S RSDATE=$P($G(^IBCN(365,RSPIEN,1)),U,10) I RSDATE="" S RSDATE=$P(NODE0,U,12)
 . S RSDATE=$P($G(^IBCN(365,RSPIEN,1)),U,10) I RSDATE="" S RSDATE=$$GET1^DIQ(365,RSPIEN_",",.14,"I")
 . S DFN=+$P(IBX,U,2)   ; pt ien
 . S INS=+$P(IBX,U,3)   ; payer ien
 . S INSNM=""
 . S PNB=$$PT^IBEFUNC(DFN)
 . S PN=$P(PNB,U,1)     ; pt name
 . S LPID=$P(PNB,U,2)   ; pt id
 . I INS S INSNM=$P($G(^IBE(365.12,INS,0)),U,1)   ; payer name
 . S VALMHDR(1)=$$FO^IBCNEUT1(PN,30)_"  "_$$FO^IBCNEUT1(LPID,15)_"  "_$$FO^IBCNEUT1(INSNM,30)
 . S VALMHDR(2)="** Based on service date "_$S(RSDATE:$$FMTE^XLFDT(RSDATE,"5Z"),1:"UNKNOWN")_" and service type: "_$S(RSTYPE:$P($G(^IBE(365.013,RSTYPE,0)),U,2),1:"UNKNOWN")_" **"
 ;
 I $G(IBBUFDA) D
 .N SRVARRAY,Z
 .D SERVLN^IBCNBLE(IBBUFDA,.SRVARRAY) I SRVARRAY F Z=1:1:SRVARRAY S VALMHDR(Z+1)=SRVARRAY(Z)
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
 N IBVDA,GLO,IBVLIST,IEN,IBVEBIEN,IBVEBTOT,IBVEBCNT
 ;N IBECODE,IIVSTAT,PLNDESC,IBINSTYP,OTHINS,MWNRIEN     ;IB*2.0*506 to be used to create EBSummary
 ;
 S OTHINS=0 ;IB*2.0*506/TAZ Initialize Other Insurance variable
 S MWNRIEN=$P($G(^IBE(350.9,1,51)),U,25) ;IB*2.0*506/TAZ Initialize Medicare WNR payer IEN
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
 D RPDM^IBCNES3($S(IBVF=365.02:365,1:2.312),.IBVDA,IBVV,IBVSUB)  ; IB*2*497  display group level eligibility information
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
 ;IB*506 -  Count EBs and gather EB Summary Data
 ;  IB*806 All related code to IB*506 for EB count and EB Summary Data was replaced
 ;         
 D SUMMARY   ; Summary of EB loops
 ;
 ;
 S IBVEBIEN=1,IBVEBCNT=0  ;IB*806/DJW  initialize IBVEBIEN to 1 to skip 1st EB loop (FSC generated loop)
 F  S IBVEBIEN=$O(IBVLIST(IBVEBIEN)) Q:'IBVEBIEN  D
 . S IBVEBCNT=IBVEBCNT+1
 . N TXVIENS
 . ;
 . ; if there is more than 1 EB group, then display a header line for separation
 . I IBVEBTOT>1 D
 .. N DSP,LN,IBZ
 .. S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))
 .. S LN=+$O(@DSP@(""),-1)
 .. S IBZ="eIV Eligibility/Benefit Data Group# "_IBVEBCNT_" of "_(IBVEBTOT-1)  ;IB*806 added -1
 .. S IBZ=$$FO^IBCNEUT1($J("",20)_IBZ,80)
 .. S LN=LN+1 D SET^IBCNES1(LN,1,IBZ,,IBVV)   ;section hdr "eIV Elig ... x of x"
 .. S IBZ="---------------------------------------------"
 .. S IBZ=$$FO^IBCNEUT1($J("",20)_IBZ,80)
 .. S LN=LN+1 D SET^IBCNES1(LN,1,IBZ,,IBVV)
 . ;
 . ; add this EB ien to the list of iens
 . S TXVIENS=IBVEBIEN_","_IBVIENS
 . ;
 . ; call the screen sections to build the display
 . D EB^IBCNES1(IBVF,TXVIENS,IBVV,IBVSUB)
 . D CMPI^IBCNES1(IBVF,TXVIENS,IBVV,IBVSUB)
 . D HCSD^IBCNES1(IBVF,TXVIENS,IBVV,IBVSUB)
 . D NTE^IBCNES1(IBVF,TXVIENS,IBVV,IBVSUB)
 . D BRE^IBCNES1(IBVF,TXVIENS,IBVV,IBVSUB)
 ;
 S VALMCNT=$O(^TMP(IBVSUB,$J,"DISP"," "),-1)
 ;
INITX ;
 Q
 ;
SUMMARY ;
 N ARRAY,DSP,LN,IBZ,IBINSTYP,IBPEDT,XX,HLDT,IIVSTAT,DFN,RSPIEN,IBX,DATA
 ;
 KILL ARRAY
 ;
 I IBVF=2.322 D
 . S DFN=+$G(IBVDA(1))
 . S RSPIEN=$$GET1^DIQ(2.312,+$G(IBVDA)_","_DFN_",",8.03,"I")
 I IBVF=365.02 D
 . S RSPIEN=+$G(IBVDA)
 . S IBX=$G(^IBCN(365,RSPIEN,0)),DFN=+$P(IBX,U,2)
 ;
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))
 S LN=+$O(@DSP@(""),-1)
 S IBZ="Summary of eIV Eligibility/Benefit Data"
 S IBZ=$$FO^IBCNEUT1($J("",20)_IBZ,80)
 S LN=LN+1 D SET^IBCNES1(LN,1,IBZ,,IBVV)
 S IBZ="---------------------------------------"
 S IBZ=$$FO^IBCNEUT1($J("",20)_IBZ,80)
 S LN=LN+1 D SET^IBCNES1(LN,1,IBZ,,IBVV)
 ;
 D EBSUMMARY^IBCNEUT2(DFN,RSPIEN,"",.ARRAY)
 ;
 S IBPEDT=$P($G(RPTDATA(1)),U,11)  ; get Effective dt  from above
 I '$O(ARRAY(0)) D  G SUMX  ; IB*806/DTG blank summary section use $O instead of $D
 . S LN=LN+1 D SET^IBCNES1(LN,1,"Insurance Type","Unknown")
 . S LN=LN+1 D SET^IBCNES1(LN,5,"Coverage Status","Unknown")
 . S LN=LN+1 D SET^IBCNES1(LN,5,"Plan Date/Effective Date",$S(IBPEDT'="":IBPEDT,1:"Unknown"))  ;use eff dt from above / uknown if not there
 . S LN=LN+1 D SET^IBCNES1(LN)
 ;
 S XX="" F  S XX=$O(ARRAY(XX)) Q:XX=""  D
 . S IBINSTYP="" F  S IBINSTYP=$O(ARRAY(XX,IBINSTYP)) Q:IBINSTYP=""  D
 .. S DATA=ARRAY(XX,IBINSTYP),IIVSTAT=$P(DATA,U,5),HLDT=$$FMTE^XLFDT($P(DATA,U,3),"5Z")
 .. ;I HLDT="" S HLDT="Unknown"
 .. I HLDT="" S HLDT=IBPEDT  ; use eff dt from above
 .. I HLDT="" S HLDT="Unknown"  ; if date is still null use Unknown
 .. S LN=LN+1 D SET^IBCNES1(LN,1,"Insurance Type",IBINSTYP)
 .. S LN=LN+1 D SET^IBCNES1(LN,5,"Coverage Status",IIVSTAT)
 .. S LN=LN+1 D SET^IBCNES1(LN,5,"Plan Date/Effective Date",HLDT)
 .. S LN=LN+1 D SET^IBCNES1(LN)
 ;
 I $D(ARRAY("OHI")) D
 . S LN=LN+1 D SET^IBCNES1(LN,1,"Other insurance was potentially found")
 . S LN=LN+1 D SET^IBCNES1(LN)
 ;
SUMX ; end of summary section  ;IB*806/DTG
 ;
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
