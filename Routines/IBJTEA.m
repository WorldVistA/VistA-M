IBJTEA ;ALB/ARH-TPI PATIENT ELIGIBLITY SCREEN ;16-FEB-1995
 ;;2.0;INTEGRATED BILLING;**39,153,183**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; the EL Patient Eligibility screen is based on the Eligibility Inquiry for Patient Billing 
 ;       [DG PATIENT ELIGIBILITY INQUIRY] display option
 ;
EN ; -- main entry point for IBJ TP CLAIMS INFO
 D EN^VALM("IBJT PT ELIGIBILITY")
 Q
 ;
HDR ; -- header code
 D HDR^IBJTU1(+$G(IBIFN),+DFN,1)
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBJTEA",$J)
 I '$G(DFN) S VALMQUIT="" G INITQ
 I '$G(IBIFN) D PRTCL^IBJU1("IBJT SHORT MENU")
 D BLD
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJTEA",$J)
 D CLEAR^VALM1
 Q
 ;
BLD ; DFN, required, uses Statment From date of the bill if available, DT if not
 I '$G(DFN) G BLDQ
 N IBX,IBY,IBI,IBDU,IBDT,IBDTE,IBLN,IBD,IBT,IBTC,IBTW,IBSW,IBLR,IBGRPB,IBGRPE,IBCNT
 S (IBLN,VALMCNT)=1
 S IBTC(1)=1,IBTW(1)=25,IBSW(1)=23,IBTC(2)=52,IBTW(2)=15,IBSW(2)=11,IBTC(4)=1,IBTW(4)=0,IBSW(4)=38
 ;
 S IBGRPB=IBLN,IBLR=1
 ;
 S IBX=$$LST^DGMTU(DFN)
 S IBT="Means Test: ",IBD=$P(IBX,U,4)
 S IBD=$S('IBX:"Not in Means Test File",IBD="P":"PEN",IBD="C":"YES",IBD="G":"GMT",IBD="R":"REQ",1:"NO")
 S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 S IBT="Date of Test: ",IBD=$$DATE^IBJU1($P(IBX,U,2)) S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 S IBX=$$LST^DGMTU(DFN,"",2)
 S IBT="Co-pay Exemption Test: ",IBD=$P(IBX,U,3) S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 S IBT="Date of Test: ",IBD=$$DATE^IBJU1($P(IBX,U,2)) S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 ;
 I +$$BIL^DGMTUB(DFN) S IBT="",IBD="Patient has agreed to pay deductible" S IBLN=$$SET(IBT,IBD,IBLN,4)
 ;
 S IBGRPE=IBLN,IBLN=IBGRPB,IBLR=2
 ;
 S IBT="Insured: ",IBD=$S(+$$INSURED^IBCNS1(DFN):"Yes",1:"No") S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 D SVC^VADPT
 S IBT="A/O Exposure: ",IBD=$S(+VASV(2):"Yes",1:"") S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 S IBT="Rad. Exposure: ",IBD=$S(+VASV(3):"Yes",1:"") S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 K VASV
 ;
 S (IBLN,VALMCNT)=$S(IBLN>IBGRPE:IBLN,1:IBGRPE)
 S IBTC(5)=1,IBTW(5)=25,IBSW(5)=53,IBLR=5
 S (IBT,IBD)="" S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 ;
 D ELIG^VADPT
 S IBT="Primary Elig. Code: ",IBD=$P(VAEL(1),U,2)_$S(VAEL(8)'="":"  --  "_$P(VAEL(8),U,2),1:"") S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 I $D(VAEL(1))>1 S IBT="Other Elig. Code(s): ",IBI=0 F  S IBI=$O(VAEL(1,IBI)) Q:'IBI  D
 . S IBD=$P(VAEL(1,IBI),U,2) S IBLN=$$SET(IBT,IBD,IBLN,IBLR),IBT=""
 S (IBT,IBD)="" S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 ;
 S IBT="Service Connected: ",IBD=$S('VAEL(3):"No",1:$P(VAEL(3),U,2)_"%")  S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 S IBT="Rated Disabilities: " D
 . I 'VAEL(4) S IBD="Not a Veteran" S IBLN=$$SET(IBT,IBD,IBLN,IBLR) Q
 . I '$O(^DPT(DFN,.372,0)) S IBD="None" S IBLN=$$SET(IBT,IBD,IBLN,IBLR) Q
 . S IBI=0 F  S IBI=$O(^DPT(DFN,.372,IBI)) Q:'IBI  D
 .. S IBX=$G(^DPT(DFN,.372,IBI,0)),IBY=$G(^DIC(31,+IBX,0))
 .. S IBD=$S($P(IBY,U,4)="":$P(IBY,U,1),1:$P(IBY,U,4))_" ("_$P(IBX,U,2)_"%-"_$S(+$P(IBX,U,3):"SC",1:"NSC")_")"
 .. S IBLN=$$SET(IBT,IBD,IBLN,IBLR),IBT=""
 K VAEL
 ;
 ; initially requested by a test site, but group decided only rated disablities should be displayed
 ;I $O(^DPT(DFN,.373,0)) D
 ;. ;
 ;. S IBTC(1)=0,IBTW(1)=0,IBSW(1)=79,IBLR=1
 ;. S (IBT,IBD)="" S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 ;. ;
 ;. S IBT="",IBD="  Service Connected Conditions as stated by applicant" S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 ;. S IBT="",IBD="  ---------------------------------------------------" S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 ;. ;
 ;. S (IBT,IBD)="",(IBCNT,IBI)=0
 ;. F  S IBI=$O(^DPT(DFN,.373,IBI)) Q:'IBI  D
 ;.. S IBX=$G(^DPT(DFN,.373,IBI,0)) Q:IBX=""
 ;.. S IBY=$P(IBX,U,1)_" ("_$P(IBX,U,2)_"%)"
 ;.. S IBD=IBD_"  "_IBY_$J("",(37-$L(IBY))),IBCNT=IBCNT+1
 ;.. I IBCNT>1 S IBLN=$$SET(IBT,IBD,IBLN,IBLR),IBD="",IBCNT=0
 ;. I IBD'="" S IBLN=$$SET(IBT,IBD,IBLN,IBLR),IBD="",IBCNT=0
 ;
 S VALMCNT=IBLN-1
 ;
BLDQ K VAERR
 Q
 ;
SET(TTL,DATA,LN,LR) ;
 N IBY
 S IBY=$J(TTL,IBTW(LR))_DATA D SET1(IBY,LN,IBTC(LR),(IBTW(LR)+IBSW(LR)))
 S LN=LN+1
 Q LN
 ;
SET1(STR,LN,COL,WD,RV) ; set up TMP array with screen data
 N IBX S IBX=$G(^TMP("IBJTEA",$J,LN,0))
 S IBX=$$SETSTR^VALM1(STR,IBX,COL,WD)
 D SET^VALM10(LN,IBX) I $G(RV)'="" D CNTRL^VALM10(LN,COL,WD,IORVON,IORVOFF)
 Q
