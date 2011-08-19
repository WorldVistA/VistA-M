RCRCVL ;ALB/CMS - RC VIEW BILL LIST ; 27-AUG-1997
V ;;4.5;Accounts Receivable;**63,159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for RCRC VIEW BILL LIST
 D EN^VALM("RCRC VIEW BILL LIST")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=""
 S VALMHDR(2)="Third Party Possible Referrals"
 S VALMSG=$S(+$G(VALMCNT)=0:"NO RECORDS FOUND",1:"|r Ref RC|* Cat C/Hold|+ Multi Ins|x Ret by RC|")
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("RCRCVL",$J),^TMP("RCRCVLX",$J),^TMP("RCRCVLPT",$J)
 K ^TMP("IBJTLA",$J),^TMP("IBJTLAX",$J)
 S VALMCNT=0 D BLDL^RCRCVL1
 ;
INITQ Q
 ;
IB ;Create IB global
 N RCL,RCLNM,RCT,RCY,VALMY,RCSELN,IBIFN,VALMCNT S (RCT,RCY)=0
 S RCLNM="IBJT ACTIVE LIST"
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S RCSELN=0 F  S RCSELN=$O(VALMY(RCSELN)) Q:'RCSELN  D
 . S DFN=+$P($G(^TMP("RCRCVLPT",$J,RCSELN)),U,1)
 . I +DFN S RCT=RCT+1 I '$D(RCL("B",DFN)) S RCL(RCT)=DFN,RCL("B",DFN)=""
 S RCY=0 F  S RCY=$O(RCL(RCY)) Q:'RCY  D
 .S DFN=RCL(RCY)
 .W !,"Getting bill information " D EN^IBJTLA
 S VALMBCK="R"
 Q 
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("RCRCVL",$J),^TMP("RCRCVLX",$J),^TMP("RCRCVLPT",$J)
 K ^TMP("IBJTLA",$J),^TMP("IBJTLAX",$J),^TMP("VALM DATA",$J)
 K ^TMP("RCDOMAIN",$J)
 K DFN,PRCABN,RCOUT,VALMCNT,VALMBCK
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
OPT ; Entry Point for Third Party Review/Referral
 D EN^RCRCVLB
 I $G(RCOUT) G OPTQ
 D EN^RCRCVL
OPTQ K DFN,RCOUT,VALMBCK
 Q
 ;RCRCVL
