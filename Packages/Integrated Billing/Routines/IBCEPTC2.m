IBCEPTC2 ;ALB/TMK - EDI PREVIOUSLY TRANSMITTED CLAIMS LIST MGR ;01/20/05
 ;;2.0;INTEGRATED BILLING;**296,320,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; IA 3337 for file 430.3
 ;
HDR ;
 K VALMHDR
 S VALMHDR(1)="** A claim may appear multiple times if transmitted more than once. **"
 ;
 I $G(IBSORT)=1 D
 . S VALMHDR(2)="Claims Selected: "_+$G(^TMP("IB_PREV_CLAIM_SELECT",$J))_" (marked with *)"
 . Q
 ;
 I $G(IBSORT)=2 D
 . S VALMHDR(2)="** T = Test Claim   ** R = Batch Rejected"
 . S VALMHDR(3)="Claims Selected: "_+$G(^TMP("IB_PREV_CLAIM_SELECT",$J))_" (marked with *)"
 . Q
 ;
 Q
 ;
INIT ;
 S VALMCNT=0,VALMBG=1
 D BLD
 Q
 ;
BLD ; Build display lines
 N IBDA,IBS1,IBS2,IBIFN,IB0,IBX,IBCNT,IBLEV1,IBBDA
 K ^TMP("IB_PREV_CLAIM_LIST",$J),^TMP("IB_PREV_CLAIM_SELECT",$J),^TMP("IB_PREV_CLAIM_BATCH",$J)
 S IBCNT=0
 I $O(^TMP("IB_PREV_CLAIM",$J,""))="" D  G BLDQ
 . S IBX=" ** NO PREVIOUSLY TRANSMITTED CLAIMS EXIST FOR SEARCH CRITERIA SELECTED **"
 . D WRT(IBX,"",0,0,"","S","",.IBCNT,0)
 ;
 S IBS1="" F  S IBS1=$O(^TMP("IB_PREV_CLAIM",$J,IBS1)) Q:IBS1=""  D
 . ; First level sort
 . ; for sort by batch, display batch ID and transmit date
 . I IBSORT=1 D
 .. S IBLEV1="  Batch: "_$P(IBS1,U,2)_"  Last Transmitted: "_$G(^TMP("IB_PREV_CLAIM",$J,IBS1))
 .. S IBBDA=+$O(^IBA(364.1,"B",$P(IBS1,U,2),0))
 .. I $P(IBS1,U,3) S IBLEV1=IBLEV1_" ** Test"
 .. I $P(IBS1,U,4) S IBLEV1=IBLEV1_" ** Rejected"
 .. Q
 . ;
 . ; for sort by payer, display ins co name and payer address
 . I IBSORT=2 D
 .. S IBLEV1="  "_$P(IBS1,U)_"  "_$$CURRINS(+$G(^TMP("IB_PREV_CLAIM",$J,IBS1)),0)
 .. Q
 . ;
 . ; output sort header line
 . D WRT(IBLEV1,"",0,0,IBSORT,"S","",IBCNT,0) ; Add header line
 . ;
 . I IBSORT=1,IBBDA S ^TMP("IB_PREV_CLAIM_BATCH",$J,IBBDA)=VALMCNT
 . S IBS2="" F  S IBS2=$O(^TMP("IB_PREV_CLAIM",$J,IBS1,IBS2)) Q:IBS2=""  S IBDA=0 F  S IBDA=$O(^TMP("IB_PREV_CLAIM",$J,IBS1,IBS2,IBDA)) Q:'IBDA  D
 .. N IBX,IBTEST
 .. S IBIFN=+$G(^IBA(364,+IBDA,0)),IB0=$G(^DGCR(399,IBIFN,0))
 .. S IBX=$P(^TMP("IB_PREV_CLAIM",$J,IBS1,IBS2,IBDA),U,1)
 .. I IBX=1 S IBTEST=0    ; live 364 transmission
 .. I IBX=2 S IBTEST=1    ; test 364 transmission
 .. I IBX=3 S IBTEST=1    ; test 361.4 transmission
 .. D WRT(IBS1,IBS2,IBDA,IBIFN,IBSORT,"S","",.IBCNT,0,IBTEST)
 .. I IBSORT=1,IBBDA S ^TMP("IB_PREV_CLAIM_BATCH",$J,IBBDA,VALMCNT)=IBIFN_U_IBCNT
 .. Q
 . Q
 ;
BLDQ Q
 ;
EXIT ; Clean up code
 ;
 K ^TMP("IB_PREV_CLAIM_LIST",$J)
 K ^TMP("IB_PREV_CLAIM_SELECT",$J)
 K ^TMP("IB_PREV_CLAIM_LIST_DX",$J)
 K ^TMP("IB_PREV_CLAIM_BATCH",$J)
 D CLEAR^VALM1
 Q
 ;
WRT(IBS1,IBS2,IBDA,IBIFN,IBSORT,IBREP,IBHDR,IBPAGE,IBSTOP,IBTEST) ; Wrt/output
 ;
 N IBX,IB0,Z,IBCNT,ARSTAT
 S IBCNT=IBPAGE
 ;
 I 'IBIFN D  G WRTQ
 . ;
 . ; for report output
 . I IBREP="R" D  Q
 .. S Z="",$P(Z,"=",133)=""
 .. D SET(Z,1,IBDA,IBREP,IBHDR,1,0,.IBPAGE,.IBSTOP)
 .. D SET(IBS1,2,IBDA,IBREP,IBHDR,1,0,.IBPAGE,.IBSTOP)
 .. Q
 . ;
 . ; for ListMan screen output
 . D SET(IBS1,0,IBDA,IBREP,IBHDR,IBCNT+1,.VALMCNT,.IBPAGE,.IBSTOP)
 . Q
 ;
 S IB0=$G(^DGCR(399,IBIFN,0))
 S IBX=$$FO^IBCNEUT1($P(IB0,U,1),8)        ; claim#
 S IBX=IBX_$S(IBSORT=2&$G(IBTEST):"T",1:" ")_" "
 S IBX=IBX_$S($P(IB0,U,19)=2:"1500",1:"UB04")_" "
 S Z=$$INPAT^IBCEF(IBIFN) S IBX=IBX_$S(Z:"INPT ",1:"OUTPT")
 S IBX=IBX_$J($P(IB0,U,21),3)_"  "
 S Z=$$EXTERNAL^DILFD(399,.13,"",$P(IB0,U,13))
 S IBX=IBX_$$FO^IBCNEUT1(Z,11)_"  "             ; claim status
 S ARSTAT=+$P($$BILL^RCJIBFN2(IBIFN),U,2)       ; ien
 S ARSTAT=$P($G(^PRCA(430.3,ARSTAT,0)),U,2)     ; abbreviation
 S IBX=IBX_$$FO^IBCNEUT1(ARSTAT,4)              ; a/r status display
 ;
 I IBSORT=1 D                    ; sort by batch
 . N Z,IBZ,IBXDATA
 . ; Print current payer, payer address, other payers, pat name
 . D F^IBCEF("N-CURR INSURANCE COMPANY NAME","IBZ",,IBIFN)
 . S IBX=IBX_$$FO^IBCNEUT1(IBZ,25)_" "                     ; ins co name
 . S IBX=IBX_$$FO^IBCNEUT1($$CURRINS(IBIFN,1),29)_" "      ; address
 . K IBZ D F^IBCEF("N-OTH INSURANCE CO. NAME","IBZ",,IBIFN)
 . S IBX=IBX_$$FO^IBCNEUT1($P($G(IBZ(1)),U,1),15)_" "      ; other payer
 . S Z=$P($G(^DPT(+$P(IB0,U,2),0)),U,1)
 . S IBX=IBX_$E(Z,1,18)                       ; patient name
 . ;
 . ; set line into list
 . S IBCNT=IBCNT+1
 . D SET(.IBX,1,IBDA,IBREP,IBHDR,IBCNT,.VALMCNT,.IBPAGE,.IBSTOP)
 . S IBX=""
 . ;
 . I $G(IBZ(2))'="" D    ; other payer #2 if it exists
 .. S IBX=$J("",98)_$E($P(IBZ(2),U,1),1,15)
 .. D SET(.IBX,1,IBDA,IBREP,IBHDR,IBCNT,.VALMCNT,.IBPAGE,.IBSTOP)
 .. Q
 . Q
 ;
 I IBSORT=2 D                    ; sort by payer
 . N Z,IBZ
 . S IBX=IBX_"  "
 . ; Print other payers, patient name, date last trans, batch #, reject flag
 . D F^IBCEF("N-OTH INSURANCE CO. NAME","IBZ",,IBIFN)
 . S IBX=IBX_$$FO^IBCNEUT1($P($G(IBZ(1)),U,1),18)_"  "   ; oth payer#1
 . S Z=$P($G(^DPT(+$P(IB0,U,2),0)),U,1)
 . S IBX=IBX_$$FO^IBCNEUT1(Z,18)_"    "                  ; patient name
 . ;
 . S Z=+$P($G(^IBA(364,+IBDA,0)),U,2) ; Batch ptr
 . S IBX=IBX_$$FO^IBCNEUT1($$FMTE^XLFDT($P($G(^IBA(364.1,+Z,1)),U,3)\1,"1"),17)     ; date last transmitted
 . S IBX=IBX_$$FO^IBCNEUT1($P($G(^IBA(364.1,Z,0)),U,1),10)   ; batch#
 . S IBX=IBX_$S($P($G(^IBA(364.1,Z,0)),U,5):" R",1:"")  ; batch rejected flag
 . ;
 . ; set line into list
 . S IBCNT=IBCNT+1
 . D SET(.IBX,1,IBDA,IBREP,IBHDR,IBCNT,.VALMCNT,.IBPAGE,.IBSTOP)
 . S IBX=""
 . ;
 . I $G(IBZ(2))'="" D       ; other payer#2 if it exists
 .. S IBX=$J("",44)_$E($P(IBZ(2),U),1,18)
 .. D SET(.IBX,1,IBDA,IBREP,IBHDR,IBCNT,.VALMCNT,.IBPAGE,.IBSTOP)
 .. Q
 . Q
 ;
WRTQ I IBREP="S" S IBPAGE=IBCNT
 Q
 ;
SET(IBX,IBLINE,IBDA,IBREP,IBHDR,IBCNT,VALMCNT,IBPAGE,IBSTOP) ;
 N Q,Z,IBZ
 S IBZ=IBX,IBX=""
 I IBREP="R" D  Q
 . D:($Y+5)>IOSL!'IBPAGE HDR^IBCEPTC1(IBHDR,IBSORT,.IBPAGE,.IBSTOP) D
 . I IBLINE F Z=1:1:IBLINE W !
 . W:'IBSTOP IBZ
 . Q
 ;
 ; only display the counter if we have a line with the claim#
 S VALMCNT=VALMCNT+1
 I IBDA,$TR($E(IBZ,1,8)," ")'="" S IBZ=$$FO^IBCNEUT1($J(IBCNT,3),6)_IBZ
 I IBDA,$TR($E(IBZ,1,8)," ")="" S IBZ="      "_IBZ
 ;
 S ^TMP("IB_PREV_CLAIM_LIST",$J,VALMCNT,0)=IBZ
 S ^TMP("IB_PREV_CLAIM_LIST",$J,"IDX",VALMCNT,IBCNT)=""
 I IBDA,$TR($E(IBZ,1,8)," ")'="" S ^TMP("IB_PREV_CLAIM_LIST_DX",$J,IBCNT)=VALMCNT_U_IBDA
 Q
 ;
CURRINS(IBIFN,TRUNC) ; Returns Current insurance address for given claim
 ; TRUNC = truncate flag; 1 to truncate the address and city
 N IBX,IBZ,L1,CITY,ST
 D F^IBCEF("N-CURR INS CO FULL ADDRESS","IBZ",,IBIFN)
 S L1=$G(IBZ(1)) I +$G(TRUNC) S L1=$E(L1,1,15)
 S CITY=$G(IBZ(4)) I +$G(TRUNC) S CITY=$E(CITY,1,10)
 S ST=$G(IBZ(5))
 I ST S ST=$P($G(^DIC(5,ST,0)),U,2)
 S IBX=L1_" "_CITY
 I CITY'="",ST'="" S IBX=IBX_","_ST
 E  S IBX=IBX_" "_ST
 Q IBX
 ;
