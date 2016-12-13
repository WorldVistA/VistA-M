IBJTTC ;ALB/ARH/PJH - TPI AR COMMENT HISTORY ; 3/18/11 2:15pm
 ;;2.0;INTEGRATED BILLING;**39,377,431,432,447,547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; AR Profile of Comments:  This screen prints the following Comments:
 ;    Bill Comments (430,98)  - entered during auditing
 ;    For each COMMENT Transaction:
 ;           Brief Comment (433,5.02)
 ;           Transaction Comment (433,86)
 ;           Comment (433,41)
 ;
EN ; -- main entry point for IBJT AR COMMENT HISTORY
 D EN^VALM("IBJT AR COMMENT HISTORY")
 Q
 ;
HDR ; -- header code
 D HDR^IBJTU1(+IBIFN,+DFN,13)
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBJTTC",$J)
 I '$G(DFN)!'$G(IBIFN) S VALMQUIT="" G INITQ
 D BLD
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJTTC",$J)
 D CLEAR^VALM1
 Q
 ;
BLD ;
 N CMLN,CMSTR,X,IBCNT,IBZ,IB0,IBI,IBX,IBD,IBDATE,IBDUZ,IBRCT5,IBLN,IBSTR,IBK,IBJ,DIWL,DIWR,DIWF,COM
 ; HIPAA 5010
 N IB3611,FOUND
 ;
 S VALMCNT=0,IBLN=0
 ;
 ; Bill Comments (430,98)
 K COM,^UTILITY($J,"W") D BCOM^RCJIBFN2(IBIFN) I $D(COM)>10 D
 . S IBSTR="",IBD="AR BILL COMMENTS:" S IBSTR=$$SETLN(IBD,IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN)
 . S IBSTR="",IBSTR=$$SETLN("--------------------------",IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN)
 . ;
 . S IBJ="" F  S IBJ=$O(COM(IBJ)) Q:'IBJ  S X=$G(COM(IBJ)) I X'="" S DIWL=1,DIWR=54,DIWF=""  D ^DIWP
 . ;
 . I $D(^UTILITY($J,"W")) S (IBK,IBCNT)=0 F  S IBK=$O(^UTILITY($J,"W",1,IBK)) Q:'IBK  D
 .. S IBD=$G(^UTILITY($J,"W",1,IBK,0)) S IBSTR=$$SETLN(IBD,IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 . K ^UTILITY($J,"W")
 ; AR profile of comment transactions  (433: 5.02, 41, 86)
 K ^TMP("RCJIB",$J),^UTILITY($J,"W") D TRN^RCJIBFN2(IBIFN)
 ;
 ;HIPAA 5010 - check if contact data has been added as a comment 
 I '$$CONTACT D
 .;Check for payer contact data in all entries associated with the bill # (IBIFN)
 .S (FOUND,IB3611)=0 F  S IB3611=$O(^IBM(361.1,"B",IBIFN,IB3611)) Q:'IB3611  Q:FOUND  S FOUND=$$EN^RCDPAYER(IB3611)
 .Q:'FOUND  ; payer contact data does not exist in any of the EOB entries related to claim
 .;Add canned text as a brief comment in file #433 which will serve as a notice that contact data came from 835 ERA
 .D ADD^RCDPAYER(IBIFN) ;IA 5549
 .;Rebuild AR profile of comment transactions
 .K ^TMP("RCJIB",$J),^UTILITY($J,"W") D TRN^RCJIBFN2(IBIFN)
 ;
 I $D(^TMP("RCJIB",$J)) S IBI="" F  S IBI=$O(^TMP("RCJIB",$J,IBI)) Q:'IBI  D
 . S IBX=$G(^TMP("RCJIB",$J,IBI)) I $$STNO^RCJIBFN2(+$P(IBX,U,3))'["COMMENT" Q
 . S IBRCT5=$$N5^RCJIBFN1(IBI)
 . S IBSTR="",IBLN=$$SET(IBSTR,IBLN)
 . S IBD=$P(IBX,U,1) S IBSTR=$$SETLN(IBD,IBSTR,2,8)
 . S IBD=$$DATE(+$P(IBX,U,2)) S IBSTR=$$SETLN(IBD,IBSTR,14,8)
 . S IBD=$P(IBRCT5,U,1) S IBSTR=$$SETLN(IBD,IBSTR,25,30)
 . S IBD="FOLLOW-UP DT: "_$$DATE(+$P(IBRCT5,U,2)) S IBSTR=$$SETLN(IBD,IBSTR,57,22)
 . S IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 .;HIPAA 5010 - check if this comment is contact data
 .I $P(IBRCT5,U)["ERA Payer Contact Information" D
 ..N CONTACT,PHONE,FAX,EMAIL,WEB,NAME,EXT,PAYER,HAVPAYER
 ..;Display contact data IA 5549
 ..; primary, secondary, and tertiary contact data need to be displayed.  Display of contact data
 ..; should only occur for each unique payer at BILL (B) x-ref of IBM(361.1,"B",IBIFN). 
 ..; evaluation starts with the most recent entry.
 ..; Contact data belonging to more than one payer can be distinguished by payer name
 ..S (HAVPAYER,IB3611)=""
 ..F  S IB3611=$O(^IBM(361.1,"B",IBIFN,IB3611),-1) Q:'IB3611  S CONTACT=$$EN^RCDPAYER(IB3611) D
 ...Q:'CONTACT
 ...S PAYER=$P($G(^IBM(361.1,IB3611,0)),U,2),PAYER=$$EXTERNAL^DILFD(361.1,.02,,PAYER) ;IA 4051
 ...Q:PAYER=HAVPAYER  ; payer contact data has already been displayed
 ...S HAVPAYER=PAYER
 ...S FAX=$P(CONTACT,U,5),EMAIL=$P(CONTACT,U,6),WEB=$P(CONTACT,U,3)
 ...S PHONE=$P(CONTACT,U,4),EXT=$P(CONTACT,U,7),NAME=$P(CONTACT,U,2)
 ...S IBD="Payer Name: "_PAYER
 ...S IBSTR=$$SETLN(IBD,IBSTR,25,78)
 ...S IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ...I NAME]"" D
 ....S IBD="Contact Name: "_NAME
 ....S IBSTR=$$SETLN(IBD,IBSTR,25,78)
 ....S IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ...I PHONE]"" D
 ....S IBD="Phone Number: "_PHONE S:EXT]"" IBD=IBD_" Ext: "_EXT
 ....S IBSTR=$$SETLN(IBD,IBSTR,25,78)
 ....S IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ...I FAX]"" D
 ....S IBD="Facsimile Number: "_FAX
 ....S IBSTR=$$SETLN(IBD,IBSTR,25,78)
 ....S IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ...I EMAIL]"" D
 ....S IBD="Email Address: "_EMAIL
 ....S IBSTR=$$SETLN(IBD,IBSTR,25,78)
 ....S IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ...I WEB]"" D
 ....S IBD="Website Address:"_$E(WEB,1,40)
 ....S IBSTR=$$SETLN(IBD,IBSTR,25,78)
 ....S IBLN=$$SET(IBSTR,IBLN),IBSTR="" Q:$L(WEB)<41
 ....S IBSTR=$$SETLN($E(WEB,41,96),IBSTR,25,78)
 ....S IBLN=$$SET(IBSTR,IBLN),IBSTR="" Q:$L(WEB)<97
 ....S IBSTR=$$SETLN($E(WEB,97,115),IBSTR,25,78)
 ....S IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ...S IBLN=$$SET(IBSTR,IBLN)
 . ;
 . ;   -- transaction comments (86)
 . S X=$P($G(^TMP("RCJIB",$J,IBI)),U,6) I X'="" S DIWL=1,DIWR=54,DIWF=""  D ^DIWP
 . ;
 . ;   -- comments  (86 & 41)
 . K COM D N7^RCJIBFN1(IBI) I $D(COM)>2 D
 .. S IBJ="" F  S IBJ=$O(COM(IBJ)) Q:'IBJ  S X=$G(COM(IBJ)) I X'="" S DIWL=1,DIWR=54,DIWF=""  D ^DIWP
 . ;
 . I $D(^UTILITY($J,"W")) S (IBK,IBCNT)=0 F  S IBK=$O(^UTILITY($J,"W",1,IBK)) Q:'IBK  D
 .. S IBD=$G(^UTILITY($J,"W",1,IBK,0)) S IBSTR=$$SETLN(IBD,IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 . K ^UTILITY($J,"W")
 K ^TMP("RCJIB",$J),^UTILITY($J,"W")
 ; MRA comments
 ; check if we have any comments to display
 I $D(^DGCR(399,IBIFN,"TXC","B")) D
 .S IBLN=$$SET("",IBLN)
 .S IBSTR="",IBSTR=$$SETLN("MRA REQUEST CLAIM COMMENTS",IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN)
 .S IBSTR="",IBSTR=$$SETLN("--------------------------",IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN)
 .; loop through all available comments
 .S IBDATE="" F  S IBDATE=$O(^DGCR(399,IBIFN,"TXC","B",IBDATE),-1) Q:IBDATE=""  D
 ..S IBZ=$O(^DGCR(399,IBIFN,"TXC","B",IBDATE,"")),IB0=^DGCR(399,IBIFN,"TXC",IBZ,0),IBDUZ=$P(IB0,U,2)
 ..;S IBLN=$$SET("",IBLN)
 ..S IBSTR=""
 ..S IBSTR=$$SETLN($$FMTE^XLFDT(IBDATE,"2Z"),IBSTR,14,8)
 ..S IBSTR=$$SETLN($J("Entered by "_$$GET1^DIQ(200,IBDUZ,.01),54),IBSTR,25,54)
 ..S IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ..; loop through comment lines
 ..S CMLN=0 F  S CMLN=$O(^DGCR(399,IBIFN,"TXC",IBZ,1,CMLN)) Q:CMLN=""  D
 ...S X=^DGCR(399,IBIFN,"TXC",IBZ,1,CMLN,0) I X'="" S DIWL=1,DIWR=54,DIWF=""  D ^DIWP
 ...Q
 ..I $D(^UTILITY($J,"W")) S IBK=0 F  S IBK=$O(^UTILITY($J,"W",1,IBK)) Q:'IBK  D
 ...S CMSTR=$G(^UTILITY($J,"W",1,IBK,0)) S IBSTR=$$SETLN(CMSTR,IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ...Q
 ..K ^UTILITY($J,"W")
 ..Q
 .;D CLEAN^DILF
 .Q
 ; display RFAI Claim Comments right after MRA REQUEST CLAIM COMMENTS *IB*2.0*547
 D RFAIC
 D EOBC ; IB*2.0*432
 D MDACMTS ; IB*2.0*447 BI
 D CLEAN^DILF
 ;
 I IBLN=0 S IBLN=$$SET("",IBLN),IBLN=$$SET("No Comment Transactions Exist For This Account.",IBLN)
 S VALMCNT=IBLN
 Q
 ;
EOBC ; check for new EOB comments IB*2.0*432
 I $D(^DGCR(399,IBIFN,"TXC2","B")) D
 .S IBLN=$$SET("",IBLN)
 .S IBSTR="",IBSTR=$$SETLN("COB MANAGMENT CLAIM COMMENTS",IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN)
 .S IBSTR="",IBSTR=$$SETLN("----------------------------",IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN)
 .; loop through all available comments
 .S IBDATE="" F  S IBDATE=$O(^DGCR(399,IBIFN,"TXC2","B",IBDATE),-1) Q:IBDATE=""  D
 ..S IBZ=$O(^DGCR(399,IBIFN,"TXC2","B",IBDATE,"")),IB0=^DGCR(399,IBIFN,"TXC2",IBZ,0),IBDUZ=$P(IB0,U,2)
 ..;S IBLN=$$SET("",IBLN)
 ..S IBSTR=""
 ..S IBSTR=$$SETLN($$FMTE^XLFDT(IBDATE,"2Z"),IBSTR,14,8)
 ..S IBSTR=$$SETLN($J("Entered by "_$$GET1^DIQ(200,IBDUZ,.01),54),IBSTR,25,54)
 ..S IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ..; loop through comment lines
 ..S CMLN=0 F  S CMLN=$O(^DGCR(399,IBIFN,"TXC2",IBZ,1,CMLN)) Q:CMLN=""  D
 ...S X=^DGCR(399,IBIFN,"TXC2",IBZ,1,CMLN,0) I X'="" S DIWL=1,DIWR=54,DIWF=""  D ^DIWP
 ...Q
 ..I $D(^UTILITY($J,"W")) S IBK=0 F  S IBK=$O(^UTILITY($J,"W",1,IBK)) Q:'IBK  D
 ...S CMSTR=$G(^UTILITY($J,"W",1,IBK,0)) S IBSTR=$$SETLN(CMSTR,IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ...Q
 ..K ^UTILITY($J,"W")
 ..Q
 .Q
 Q
 ;
CONTACT() ;HIPAA 5010 check for contact data in comments
 N FOUND,IBI
 S FOUND=0,IBI=""
 F  S IBI=$O(^TMP("RCJIB",$J,IBI)) Q:'IBI  D  Q:FOUND
 .S IBX=$G(^TMP("RCJIB",$J,IBI)) Q:$$STNO^RCJIBFN2(+$P(IBX,U,3))'["COMMENT"
 .S:$P($$N5^RCJIBFN1(IBI),U)["ERA Payer Contact Information" FOUND=1
 Q FOUND
 ;
DATE(X) ; date in external format
 N Y S Y="" I +X S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
 ;
SETLN(STR,IBX,COL,WD) ;
 S IBX=$$SETSTR^VALM1(STR,IBX,COL,WD)
 Q IBX
 ;
SET(STR,LN) ; set up TMP array with screen data
 S LN=LN+1 D SET^VALM10(LN,STR)
SETQ Q LN
 ;
MDACMTS ; Check for MDA comments, Load for List Manager Screen IB*2.0*447 BI
 ; INTEGRATION CONTROL REGISTRATION is contained in DBIA #5696.
 D MCOM^PRCAMDA2(IBIFN,.IBLN)
 Q
 ;
RFAIC ; check for new RFAI comments IB*2.0*547 (modeled after EOBC)
 ; uses ^IBA(368,"D",$E(X,1,30),DA) PATIENT CONTROL NUMBER [D] cross-reference 
 ;
 Q:'$D(^IBA(368,"D",IBIFN))
 N IBTNI,IBC,IBCLM,IBDUZ,IBDT,IBK,CMSTR,IBSTR,IBZ
 ; loop through all available comments
 S IBC=0,IBTNI="" F  S IBTNI=$O(^IBA(368,"D",IBIFN,IBTNI)) Q:IBTNI=""  D
 .; not all transactions associated with a claim have comments
 .Q:'$D(^IBA(368,IBTNI,201))
 .; loop through all available comments
 .S IBDT="" F  S IBDT=$O(^IBA(368,IBTNI,201,"B",IBDT),-1) Q:IBDT=""  D
 ..S IBZ=$O(^IBA(368,IBTNI,201,"B",IBDT,"")),IBDUZ=$P($G(^IBA(368,IBTNI,201,IBZ,0)),U,2),IBC=IBC+1
 ..; display header and underline prior to 1st transaction with comment only
 ..D:IBC=1
 ...S IBLN=$$SET("",IBLN)
 ...S IBSTR="",IBSTR=$$SETLN("RFAI CLAIM COMMENTS",IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN)
 ...S IBSTR="",IBSTR=$$SETLN("----------------------------",IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN)
 ..S IBSTR="",IBSTR=$$SETLN($$FMTE^XLFDT(IBDT,"2Z"),IBSTR,14,8),IBSTR=$$SETLN($J("Entered by "_$$GET1^DIQ(200,IBDUZ,.01),54),IBSTR,25,54)
 ..S IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ..; loop through comment lines
 ..S IBCLM=0 F  S IBCLM=$O(^IBA(368,IBTNI,201,IBZ,1,IBCLM)) Q:IBCLM=""  D
 ...S X=$G(^IBA(368,IBTNI,201,IBZ,1,IBCLM,0)) I X'="" S DIWL=1,DIWR=54,DIWF=""  D ^DIWP
 ..I $D(^UTILITY($J,"W")) S IBK=0 F  S IBK=$O(^UTILITY($J,"W",1,IBK)) Q:'IBK  D
 ...S CMSTR=$G(^UTILITY($J,"W",1,IBK,0)) S IBSTR=$$SETLN(CMSTR,IBSTR,25,54),IBLN=$$SET(IBSTR,IBLN),IBSTR=""
 ..K ^UTILITY($J,"W")
 Q
 ;
