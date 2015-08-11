IBJTCA2 ;ALB/ARH - TPI CLAIMS INFO BUILD (CONT) ;16-FEB-1995
 ;;2.0;INTEGRATED BILLING;**39,80,155,320,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
CONT ; Continuation of Claim Information Screen Build
 ; reason cancelled
 I $P(IBD0,U,13)=7 D
 . S (IBNC(1),IBTC(1))=2,(IBNC(2),IBTC(2))=0,IBNC(3)=28,IBTW(1)=29,IBTW(2)=0,IBSW(1)=49,IBSW(2)=0
 . S (IBT,IBD)="" S IBLN=$$SET(IBT,IBD,IBLN,1)
 . ;
 . S IBGRPB=IBLN,IBLR=1
 . K IBY D RCANC^IBJTU2(IBIFN,.IBY,50)
 . S IBT="Reason Cancelled by ("_$P(IBY,U,3)_"): "
 . S IBI=0 F  S IBI=$O(IBY(IBI)) Q:'IBI  S IBD=IBY(IBI) S IBLN=$$SET(IBT,IBD,IBLN,IBLR),IBT=""
 ;
 S (IBLN,VALMCNT)=$S(IBLN>IBGRPE:IBLN,1:IBGRPE)
 S (IBNC(1),IBTC(1))=2,IBTW(1)=16,IBSW(1)=50
 S (IBT,IBD)="" S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 ;
 S IBGRPB=IBLN,IBLR=1
 ;
 I +$P(IBDS,U,1) S IBT="Entered: ",IBD=$$EXT(IBDS,1,2) S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 I +$P(IBDS,U,4) S IBT="Initial Review: ",IBD=$$EXT(IBDS,4,5) S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 I +$P(IBDS,U,7) S IBT="MRA Request: ",IBD=$$EXT(IBDS,7,8) S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 I +$P(IBDS,U,10) S IBT="Authorized: ",IBD=$$EXT(IBDS,10,11) S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 I +$P(IBDS,U,12) S IBT="First Printed: ",IBD=$$EXT(IBDS,12,13) S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 I $P(IBDS,U,14)>$P(IBDS,U,12) S IBT="Last Printed: ",IBD=$$EXT(IBDS,14,15) S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 I +$P(IBDS,U,17) S IBT="Cancelled: ",IBD=$$EXT(IBDS,17,18) S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 ;
 ; Patch 320 - added bill cloning history to TPJI report. 
 N IBCCR,IBCURR,IBNEXT,IBBCH,IBINDENT
 S IBINDENT=0
 D EN^IBCCR(IBIFN,.IBCCR)   ; utility to pull cloning history
 ;
 ; attempt to go one claim forward from the current claim
 S IBCURR="IBCCR("_+$P(IBDS,U,1)_","_IBIFN_")"
 S IBNEXT=$Q(@IBCURR)
 I IBNEXT'="" D
 . N IBX S IBX=@IBNEXT
 . S IBT="Copied: "
 . S IBD=$$FMTE^XLFDT($P(IBX,U,1),"2Z")_"  by  "_$P(IBX,U,3)
 . S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 . S IBT="Copied To: ",IBD=$P(IBX,U,2),IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 . S IBINDENT=1
 . Q
 ;
 ; now go backwards for claim cloning history all the way back
 S IBBCH=IBCURR
 F  S IBBCH=$Q(@IBBCH,-1) Q:IBBCH=""  D
 . N IBX S IBX=@IBBCH
 . S IBT="Copied: " I IBINDENT S IBT="                  "_IBT
 . S IBD=$$FMTE^XLFDT($P(IBX,U,1),"2Z")_"  by  "_$P(IBX,U,3)
 . S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 . S IBT="Copied From: " I IBINDENT S IBT="             "_IBT
 . S IBD=$P(IBX,U,2),IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 . S IBT="Reason Copied: " I IBINDENT S IBT="           "_IBT
 . S IBD=$P(IBX,U,4),IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 . S IBINDENT=1
 . Q
 ;
 I $D(^DGCR(399,IBIFN,"R","AC",1)) S IBT="Returned to AR: ",X=0 F  S X=$O(^DGCR(399,IBIFN,"R","AC",1,X)) Q:'X  D
 . S IBY=$G(^DGCR(399,IBIFN,"R",X,0)),IBD=$$EXT(IBY,1,2) S IBLN=$$SET(IBT,IBD,IBLN,IBLR)
 ;
 N IBCOB,IBX,IBY,IBI,IBJ,IBK D BCOB^IBCU3(IBIFN,.IBCOB) I $O(IBCOB(0)) D
 . S IBTC(1)=2,IBTW(1)=12,IBSW(1)=68,IBLR=1,IBNC(1)=26,IBTW(0)=0
 . S (IBT,IBD)="" S IBLN=$$SET(IBT,IBD,IBLN,1)
 . S IBT="Payers and Related Bills" S IBLN=$$SETN^IBJTCA1(IBT,IBLN,IBLR,1)
 . S (IBT,IBD)="" S IBLN=$$SET(IBT,IBD,IBLN,1)
 . S IBTC(1)=0,IBTW(1)=0,IBSW(1)=68,IBLR=1,IBNC(1)=0
 . S IBT="",IBD="Insurance Co.    Bill #     Status   Original  Collected    Balance"
 . S IBLN=$$SET(IBT,IBD,IBLN,IBLR) D CNTRL^VALM10(IBLN-1,(IBTC(1)+IBTW(1)),IBSW(1),IOUON,IOUOFF)
 . S IBI=0 F  S IBI=$O(IBCOB(IBI)) Q:'IBI  D
 .. S IBT=$S(IBI=1:"Primary",IBI=2:"Secondary",IBI=3:"Tertiary",1:"Other")_":  "
 .. S IBJ=0 F  S IBJ=$O(IBCOB(IBI,IBJ)) Q:'IBJ  S IBK="" F  S IBK=$O(IBCOB(IBI,IBJ,IBK)) Q:IBK=""  D
 ... S IBD="",IBY=$$BILL^RCJIBFN2(IBK)
 ... S IBX=$P($G(^DIC(36,+IBJ,0)),U,1) S IBD=$$SLINE(IBD,IBX,0,15)
 ... I +IBK D
 .... S IBX=$P($G(^DGCR(399,+IBK,0)),U,1) S IBD=$$SLINE(IBD,IBX,17,10)
 .... S IBX=$P($$STNO^RCJIBFN2(+$P(IBY,U,2)),U,2) ;bill status
 .... ; if MRA active & bill pyr seq >1 & dsply'g prmry & prmry ins is WNR
 .... I $$EDIACTV^IBCEF4(2),$$COBN^IBCEF(+IBK)>1,IBI=1,$$MCRWNR^IBEFUNC(+IBJ) D
 ..... S IBX=" ",IBY="0^^0^0^0" ;blank out status & reset WNR amounts
 .... S IBD=$$SLINE(IBD,IBX,30,3)
 .... S IBX=$J($P(IBY,U,1),10,2) S IBD=$$SLINE(IBD,IBX,35,10)
 .... S IBX=$J($P(IBY,U,4),10,2) S IBD=$$SLINE(IBD,IBX,46,10)
 .... S IBX=$J($P(IBY,U,3),10,2) S IBD=$$SLINE(IBD,IBX,57,10)
 ... S IBLN=$$SET(IBT,IBD,IBLN,IBLR),IBT=""
 ;
 ;IB*2.0*516 - Display links from 3rd party bill to 1st party bill(s)
 K ^TMP("IBRBF",$J)
 D RELBILL^IBRFN(IBIFN)
 N IBCIFN,IBCNT
 S IBCNT=0,IBCIFN="" F  S IBCIFN=$O(^TMP("IBRBF",$J,IBIFN,IBCIFN)) Q:IBCIFN=""  D
 . I $P(^(IBCIFN),"^",6)["RX COPAY" K ^TMP("IBRBF",$J,IBIFN,IBCIFN) Q
 . S IBCNT=IBCNT+1
 D HDR2
 I IBCNT=0 S (IBT,IBD)="",IBX="No Links to 1st Party Bills Found",IBD=$$SLINE(IBD,IBX,0,35),IBLN=$$SET(IBT,IBD,IBLN,IBLR) Q
 S (IBD,IBX,IBT)=""
 S IBCIFN="" F  S IBCIFN=$O(^TMP("IBRBF",$J,IBIFN,IBCIFN)) Q:IBCIFN=""  D PRINT2
 K ^TMP("IBRBF",$J)
 Q
 ;
EXT(STR,DT,USER) ; returns external form of user and date, given their position in the string
 N X,Y S Y="",STR=$G(STR),DT=+$G(DT),USER=+$G(USER)
 S X=$P(STR,U,DT),DT="" I +X S DT=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 S X=$P(STR,U,USER),USER="" I +X S USER=$P($G(^VA(200,+X,0)),U,1)
 S Y=DT_"  by  "_$S(USER="":"UNKNOWN",1:USER)
 Q Y
 ;
SET(IBT,IBD,IBLN,IBLR) ;
 N LN S LN=$$SET^IBJTCA1(IBT,IBD,IBLN,IBLR)
 Q LN
 ;
SLINE(IBD,DATA,COL,WD) ; format a single line with multiple data fields
 S IBD=$E(IBD,1,(COL-1)),IBD=IBD_$J("",(COL-$L(IBD))),IBD=IBD_$E(DATA,1,WD)
 Q IBD
 ;
HDR2 ;Print the header for first party bills - IB*2*516
 S (IBT,IBD)="",IBLR=1,IBNC(1)=26
 S IBLN=$$SET(IBT,IBD,IBLN,1)
 S IBT="Related First Party Charges" S IBLN=$$SETN^IBJTCA1(IBT,IBLN,IBLR,1)
 S (IBT,IBD)="" S IBLN=$$SET(IBT,IBD,IBLN,1)
 S IBTC(1)=0,IBTW(1)=1,IBSW(1)=80,IBLR=1,IBNC(1)=26
 S IBT="Bill#         Charge Type  Status      Amt Billed     On Hold    Balance"
 S IBLN=$$SET(IBT,IBD,IBLN,IBLR) D CNTRL^VALM10(IBLN-1,(IBTC(1)+IBTW(1)),IBSW(1),IOUON,IOUOFF)
 Q
 ;
PRINT2 ;Print the detail line for a first party bill - IB*2*516
 S IBTC(1)=0,IBTW(1)=0,IBSW(1)=80,IBLR=1
 S IBDAT=$G(^TMP("IBRBF",$J,IBIFN,IBCIFN)),IBD=""
 S IBX=$P(IBDAT,"^",4) S:IBX="" IBX="Not Assigned" S IBD=$$SLINE(IBD,IBX,0,13)
 S IBX=$P(IBDAT,"^",6),IBD=$$SLINE(IBD,IBX,14,12)
 S IBX=$$GET1^DIQ(350,IBCIFN_",",.05) S:IBX="" IBX="Incomplete" S IBD=$$SLINE(IBD,IBX,27,11)
 S IBFN=$P(IBDAT,"^",4) I IBFN S IBFN=$O(^PRCA(430,"B",IBFN,0))
 S IBX=$J($P(IBDAT,"^",5),9,2),IBD=$$SLINE(IBD,IBX,40,10)
 S IBX=$P(IBDAT,"^",7),IBD=$$SLINE(IBD,IBX,53,10)
 S IBX=$J($S($G(^PRCA(430,+IBFN,7)):+($P(^(7),"^")+$P(^(7),"^",2)+$P(^(7),"^",3)+$P(^(7),"^",4)+$P(^(7),"^",4)),1:0),9,2),IBD=$$SLINE(IBD,IBX,63,10)
 S IBLN=$$SET(IBT,IBD,IBLN,1)
 Q
 ;
STAT(RCIBFN) ;AR Status
 I '$G(RCIBFN) Q ""
 N RCSTAT
 S RCSTAT=$P($G(^PRCA(430,+RCIBFN,0)),"^",8),RCSTAT=$P($G(^PRCA(430.3,+RCSTAT,0)),"^",2)
 Q RCSTAT
 ;
DATE(X) ; Convert FileMan date to mm/dd/yy
 Q $S($G(X):$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")
 ;
