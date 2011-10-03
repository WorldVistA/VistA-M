IBCECSA1 ;ALB/CXW - IB STATUS AWAITING RESOLUTION SCREEN ;28-JUL-99
 ;;2.0;INTEGRATED BILLING;**137,283,288,320,368**;21-MAR-94;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; DBIA for $$BN1^PRCAFN()
 ;
BLD ; Build list entrypoint
 N IBDA,IBREV,IBIFN,IBPAY,IBSSN,IBSER,IB399,IBLOC,IBDIV,IBUER,IBMSG,IBERR,IBPEN,SEVERITY,A,IBOAM,IBPAT,IBSTSMSG,SV1,SV2,SV3
 K ^TMP("IBCECSA",$J),^TMP("IBCECSB",$J),^TMP("IBCECSD",$J)
 W !!,"Compiling CSA status messages ... "
 S IBSEV=$G(IBSEV,"R")
 S VALMCNT=0,IB364=""
 S SEVERITY=""
 F  S SEVERITY=$O(^IBM(361,"ACSA",SEVERITY)) Q:SEVERITY=""  I SEVERITY="R"!(IBSEV="B") S IBREV="" F  S IBREV=$O(^IBM(361,"ACSA",SEVERITY,IBREV)) Q:IBREV=""  I IBREV<2 S IBDA=0 F  S IBDA=$O(^IBM(361,"ACSA",SEVERITY,IBREV,IBDA)) Q:'IBDA  D
 . S IB=$G(^IBM(361,IBDA,0)),IBIFN=+IB
 . S IBPEN=$$FMDIFF^XLFDT(DT,$P(IB,U,2),1)
 . ;quit if not pending for at least the minimum # of days requested
 . Q:IBDAYS>IBPEN
 . S IB399=$G(^DGCR(399,IBIFN,0))
 . ;
 . ; no cancelled claims allowed on the CSA screen
 . ; if we find one, then update the appropriate EDI files
 . I $P(IB399,U,13)=7 D UPDEDI^IBCEM(+$P(IB,U,11),"C") Q
 . ;
 . ; automatically review this message if the claim was last printed on
 . ; or after the MCS - 'Resubmit by Print' date
 . I $P(IB,U,16),($P($G(^DGCR(399,IBIFN,"S")),U,14)\1)'<$P(IB,U,16) D UPDEDI^IBCEM(+$P(IB,U,11),"P") Q
 . ;
 . S IBDIV=+$P(IB399,U,22)
 . S IBUER=+$P($G(^DGCR(399,IBIFN,"S")),U,11)
 . ;
 . ; If Request MRA bill, pull the MRA Requestor user instead
 . I 'IBUER,$P(IB399,U,13)=2 S IBUER=+$P($G(^DGCR(399,IBIFN,"S")),U,8)
 . I $D(^TMP("IBBIL",$J)),'$D(^TMP("IBBIL",$J,IBUER)) Q  ; User not selected
 . I $D(^TMP("IBDIV",$J)),'$D(^TMP("IBDIV",$J,IBDIV)) Q  ; Div not selected
 . ;
 . S IBPAY=$P($G(^DIC(36,+$P($G(^DGCR(399,IBIFN,"MP")),U),0)),U)
 . I IBPAY="" S IBPAY=$P($G(^DIC(36,+$$CURR^IBCEF2(IBIFN),0)),U)
 . I IBPAY="" S IBPAY="UNKNOWN PAYER"
 . S IBPAT=$G(^DPT(+$P(IB399,U,2),0))
 . S IBSSN=$E($P(IBPAT,U,9),6,9) I IBSSN="" S IBSSN="~unk"
 . S IBPAT=$P(IBPAT,U,1) I IBPAT="" S IBPAT="~UNKNOWN PATIENT NAME"
 . S IBSER=$P($G(^DGCR(399,IBIFN,"U")),U)
 . S IBLOC=$P(IB399,U,4)
 . S IBLOC=$S(IBLOC=1:"HOSPITAL",IBLOC=2:"SKILLED NURSING",1:"CLINIC")
 . I IBDIV S IBDIV=$P($G(^DG(40.8,IBDIV,0)),U)
 . I IBDIV=""!(IBDIV=0) S IBDIV="UNSPECIFIED"
 . S IBMSG=$S($P(IB,U,8):"PAYER",1:"NON-PAYER")
 . S IBUER=$S(IBUER:$P($G(^VA(200,IBUER,0)),U),1:"UNKNOWN")_"~"_IBUER
 . S IB364=$P(IB,U,11)
 . S IBOAM=$G(^DGCR(399,IBIFN,"U1"))
 . S IBOAM=$P(IBOAM,U,1)-$P(IBOAM,U,2)     ; current balance (total charges - offset)
 . ;
 . S IBSTSMSG=$$TXT(IBDA)       ; status message text
 . S IBERR=$E(IBSTSMSG,1,60)
 . I IBERR="" S IBERR="-"
 . ;
 . S IB=$$BN1^PRCAFN(IBIFN)     ; external bill#
 . S A=IBIFN_U_IBPAY_U_IBPAT_U_IBSSN_U_IBSER_U_IBOAM_U_IBLOC_U_IBDIV_U_IBUER_U_IBMSG_U_IBPEN_U_$S(IBREV:"*",1:"")_U_IB364_U_IB
 . ;
 . S SV1=$$SRTV($G(IBSORT1),IBDA)
 . S SV2=$$SRTV($G(IBSORT2),IBDA)
 . S SV3=$$SRTV($G(IBSORT3),IBDA)
 . S ^TMP("IBCECSB",$J,SV1,SV2,SV3,IBDA)=A
 . S ^TMP("IBCECSB",$J,SV1,SV2,SV3,IBDA,"MSG")=IBSTSMSG
 . Q
 ;
 I '$D(^TMP("IBCECSB",$J)) D NMAT Q
 D SCRN
 Q
 ;
NMAT ;No CSA list
 S VALMCNT=2,IBCNT=2
 S ^TMP("IBCECSA",$J,1,0)=" "
 S ^TMP("IBCECSA",$J,2,0)="No Messages Matching Selection Criteria Found"
 Q
 ;
SRTV(SORT,IBDA) ; sort value calculation given the sort code letter
 I SORT="" Q IBDA
 Q $$SV^IBCECSA(SORT)
 ;
SCRN ;
 NEW IBSRT1,IBSRT2,IBSRT3,IBX,IBCNT,IBIFN,IBDA,IB,INFX,DAT,X
 W !,"Building the CSA list display ... "
 S IBCNT=0,IBSRT1=""
 F  S IBSRT1=$O(^TMP("IBCECSB",$J,IBSRT1)) Q:IBSRT1=""  D
 . D SRTBRK(1,$G(IBSORT1),IBSRT1)
 . S IBSRT2=""
 . F  S IBSRT2=$O(^TMP("IBCECSB",$J,IBSRT1,IBSRT2)) Q:IBSRT2=""  D
 .. D SRTBRK(2,$G(IBSORT2),IBSRT2)
 .. S IBSRT3=""
 .. F  S IBSRT3=$O(^TMP("IBCECSB",$J,IBSRT1,IBSRT2,IBSRT3)) Q:IBSRT3=""  D
 ... D SRTBRK(3,$G(IBSORT3),IBSRT3)
 ... S IBDA=0
 ... F  S IBDA=$O(^TMP("IBCECSB",$J,IBSRT1,IBSRT2,IBSRT3,IBDA)) Q:'IBDA  D
 .... S IB=$G(^TMP("IBCECSB",$J,IBSRT1,IBSRT2,IBSRT3,IBDA))
 .... S IBSTSMSG=$G(^TMP("IBCECSB",$J,IBSRT1,IBSRT2,IBSRT3,IBDA,"MSG"))
 .... S IBIFN=+IB
 .... S IB364=$P(IB,U,13)
 .... S DAT=IBIFN_U_IBDA_U_IBSRT1_U_IBSRT2_U_IB364_U_IBSRT3
 .... ;
 .... S IBCNT=IBCNT+1
 .... S X=$$SETFLD^VALM1($J(IBCNT,3),"","NUMBER")
 .... D SETL1(IB,.X)
 .... D SET(X,IBCNT,DAT)
 .... ;
 .... S X=$$SETSTR^VALM1(IBSTSMSG,"",6,75)
 .... D SET(X,IBCNT,DAT)
 .... Q
 ... Q
 .. Q
 . Q
 Q
 ;
SRTBRK(LVL,SORT,IBSRT) ; sort break for display of certain sort data
 ; LVL   - sort level
 ; SORT  - sort letter code
 ; IBSRT - subscript data
 ;
 NEW IBS,DSPDATA
 I '$F(".A.D.N.","."_$G(SORT)_".") G SRTBRKX
 S IBS=$$SD^IBCECSA(SORT)
 S DSPDATA=IBSRT
 I SORT="A" S DSPDATA=$P(DSPDATA,"~",1)      ; biller name
 I SORT="N" S DSPDATA=-DSPDATA               ; number of days pending
 D SET($J("",LVL-1)_IBS_": "_DSPDATA,IBCNT,"")
SRTBRKX ;
 Q
 ;
SET(X,CNT,DAT) ;set up list manager screen array
 S VALMCNT=VALMCNT+1
 I 'CNT S CNT=1
 S ^TMP("IBCECSA",$J,VALMCNT,0)=X
 S ^TMP("IBCECSA",$J,"IDX",VALMCNT,CNT)=""
 I DAT'="" S ^TMP("IBCECSA",$J,CNT)=VALMCNT_U_DAT
 Q
 ;
SETL1(IB,X) ;
 S X=$$SETFLD^VALM1($P($G(^DGCR(399,+IB,0)),U,1)_$P(IB,U,12),X,"BILL")
 S X=$$SETFLD^VALM1($P(IB,U,2),X,"PNAME")
 S X=$$SETFLD^VALM1($P(IB,U,3),X,"PANAME")
 S X=$$SETFLD^VALM1($P(IB,U,4),X,"SSN")
 S X=$$SETFLD^VALM1($$FMTE^XLFDT($P(IB,U,5),"2Z"),X,"SERVICE")
 S X=$$SETFLD^VALM1($J("$"_$FN($P(IB,U,6),"",2),10),X,"CURBAL")
 Q
 ;
TXT(IBDA,LEN) ; Return a string of status message text
 ; IBDA - ien to file 361
 ;  LEN - desired maximum length of combined text string
 NEW MSG,LN,STOP,TX,HLN,REFN,DELIM
 S MSG="",LN=0,LEN=$G(LEN,75),STOP=0
 F  S LN=$O(^IBM(361,+$G(IBDA),1,LN)) Q:'LN  D  Q:STOP
 . S TX=$G(^IBM(361,IBDA,1,LN,0))
 . S TX=$$TRIM^XLFSTR(TX)
 . ; Don't include parts added by ^IBCE277
 . Q:TX="Informational Message:"
 . Q:TX="Warning Message:"
 . Q:TX="Error Message:"
 . I $E(TX,1,27)="Clearinghouse Trace Number:" S STOP=1 Q
 . I $E(TX,1,18)="Payer Status Date:" S STOP=1 Q
 . I $E(TX,1,19)="Payer Claim Number:" S STOP=1 Q
 . I $E(TX,1,12)="Split Claim:" S STOP=1 Q
 . I $E(TX,1,11)="Claim Type:" S STOP=1 Q
 . I $E(TX,1,8)="Patient:" S STOP=1 Q
 . I $E(TX,1,14)="Service Dates:" S STOP=1 Q
 . I $E(TX,1,11)="Payer Name:" S STOP=1 Q
 . I $E(TX,1,7)="Source:" S STOP=1 Q
 . I TX["HL=" S HLN=+$P(TX,"HL=",2),DELIM="HL="_HLN,TX=$P(TX,DELIM,1)_"HL= "_$P(TX,DELIM,2,9)
 . I TX["ENVOY REF: " S REFN=$E($P(TX,"ENVOY REF: ",2),1,14),DELIM="ENVOY REF: "_REFN,TX=$P(TX,DELIM,1)_"ENVOY REF: "_$P(TX,DELIM,2,9)
 . I ($L(MSG)+$L(TX))>500 S STOP=1 Q
 . S MSG=MSG_$S(MSG="":"",1:" ")_TX
 . I $L(MSG)>LEN S STOP=1
 . Q
 Q $E(MSG,1,LEN)
 ;
