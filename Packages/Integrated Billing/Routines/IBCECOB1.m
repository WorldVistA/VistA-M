IBCECOB1 ;ALB/CXW - IB COB MANAGEMENT SCREEN/REPORT ;14-JUN-99
 ;;2.0;INTEGRATED BILLING;**137,155,288,348,377,417**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
BLD ; Build list entrypoint
 N I,IBFND,IBB,IBIFN,IB364,IBDA1,IBDTN,IBDA,IBDAY,IBHIS,IBNDS,IBEUT,IBAPY,IBOAM,IBDT,IBMUT,IBBPY,IBINS,IBNDM,IBQ,IBNDI1,IBNDI2,IBNDI3,Z,Z0,IBSEQ,IB3611,IBINS1,IBINS2,IBEXPY,IBNBAL,IBPTRSP,IBAMT,IBMRACNT,IBPTNM,IBSRVC,IBPY,IBB364
 N IBEOBREV,IBDENDUP
 K ^TMP("IBCECOB",$J),^TMP("IBCECOB1",$J),^TMP("IBCOBST",$J),^TMP("IBCOBSTX",$J)
 D CLEAN^VALM10      ; kill data and video control arrays
 S VALMCNT=0,IBHIS=""
 ; since 0 is a valid Review Status, init w/null
 S IBEOBREV=""
 ; get EOB's w/Review Status of 0, 1, 1.5 or 2; If 3 or higher, not needed
 F  S IBEOBREV=$O(^IBM(361.1,"AMRA",1,IBEOBREV)) Q:IBEOBREV=""  Q:IBEOBREV>2  D  ;
 . S IBDA="A" F  S IBDA=$O(^IBM(361.1,"AMRA",1,IBEOBREV,IBDA),-1) Q:'IBDA  D BLD1
 ; no data accumulated
 I $O(^TMP("IBCOBST",$J,""))="" D NMAT Q
 ; display accumulated data
 D SCRN
 Q
BLD1 ;
 I '$$ELIG(IBDA) Q
 S IBDENDUP=$$DENDUP^IBCEMU4(IBDA)
 I '$G(IBMRADUP),IBDENDUP Q     ; don't include denied MRAs for Duplicate Claim/Service
 S IB3611=$G(^IBM(361.1,IBDA,0))
 S IBIFN=+IB3611,IB364=$P(IB3611,U,19),IBDT=+$P(IB3611,U,6)
 I $D(^TMP("IBCOBSTX",$J,IBIFN)) Q  ;show each bill once on the worklist
 S IBB=$G(^DGCR(399,IBIFN,0))
 S IBNDS=$G(^DGCR(399,IBIFN,"S")),IBNDI1=$G(^("I1")),IBNDI2=$G(^("I2")),IBNDI3=$G(^("I3")),IBNDM=$G(^("M"))
 S IBMUT=+$P(IBNDS,U,8),IBEUT=+$P(IBNDS,U,2)
 S IBINS="",IBSEQ=$P(IB3611,U,15)
 F I=1:1:3 S Z="IBNDI"_I I @Z D
 . N Q
 . S Q=(IBSEQ=I)
 . I Q S IBINS1=+@Z_U_$P($G(^DIC(36,+@Z,0)),U)
 . S IBINS=IBINS_$S(IBINS="":"",1:", ")_$P($G(^DIC(36,+@Z,0)),U)
 ; Get the payer/insurance company that comes after Medicare WNR
 ; If WNR is Primary, get the secondary ins. co.
 ; If WNR is secondary, get the tertiary ins. co.
 D  I $P(IBINS2,U,2)="" S $P(IBINS2,U,2)="UNKNOWN"
 . I $$WNRBILL^IBEFUNC(IBIFN,1) S IBINS2=+IBNDI2_U_$P($G(^DIC(36,+IBNDI2,0)),U) Q
 . S IBINS2=+IBNDI3_U_$P($G(^DIC(36,+IBNDI3,0)),U)
 S IBFND=0
 ; biller entry not ALL and no biller, then get entered/edited by user
 I $D(^TMP("IBBIL",$J)) D  Q:'IBFND
 . S IBFND=$S($D(^TMP("IBBIL",$J,IBMUT)):IBMUT,$D(^TMP("IBBIL",$J,IBEUT)):IBEUT,1:0)
 S Z=$S(IBFND:IBFND,IBMUT:IBMUT,1:IBEUT)
 S IBMUT=$P($G(^VA(200,+Z,0)),U)_"~"_Z
 S:'$P(IBMUT,"~",2) IBMUT="UNKNOWN~0"
 S IBBPY=+$$COBN^IBCEF(IBIFN),IBQ=1
 ;IBQ;1=EOB without subsequent insurer,0=COB,2=0 balance
 D  ;I IBQ Q
 . ;Check for no reimbursable subsequent insurance
 .  F I=IBBPY+1:1:3 D  Q:'IBQ
 .. S Z="IBNDI"_I,Z=$G(@Z)
 .. I $P($G(^DIC(36,+Z,0)),U,2)="N" S IBQ=0 Q
 . ;Check if next ins doesn't exist or next bill# already created
 . S Z="IBNDI"_(IBBPY+1),Z=$G(@Z)
 . I Z,'$P($G(^DGCR(399,IBIFN,"M1")),U,5+IBBPY) S IBQ=0
 ;
 ; Days since transmission of latest bill in COB - IBDAY
 S IBDAY=+$P($G(^DGCR(399,IBIFN,"TX")),U,2) I IBDAY S IBDAY=$$FMDIFF^XLFDT(DT,IBDAY,1)
 ; if no Last Electronic Extract Date on file 399, get it from file 364
 I 'IBDAY D  I IBDAY S IBDAY=$$FMDIFF^XLFDT(DT,IBDAY,1) ;calc. the difference
 . S IBB364=$$LAST364^IBCEF4(IBIFN) I IBB364'="" S IBDAY=+$P($P($G(^IBA(364,IBB364,0)),U,4),".",1)
 ;
 S IBAPY=$$TPR^PRCAFN(IBIFN) ; payment on this bill from A/R
 S IBEXPY=+$G(^IBM(361.1,IBDA,1))       ; payer paid amount
 S IBPTRSP=$$PREOBTOT^IBCEU0(IBIFN)     ; patient resp. function
 S IBPY=$S(IBAPY:IBAPY,1:IBEXPY)
 S IBOAM=+$G(^DGCR(399,IBIFN,"U1"))     ; total charges for bill
 S IBNBAL=IBOAM-IBPY
 I IBNBAL'>0 S IBQ=2
 S IBPTNM=$P($G(^DPT(+$P($G(^DGCR(399,IBIFN,0)),U,2),0)),U) I IBPTNM="" S IBPTNM="UNKNOWN"
 S IBSRVC=$P($G(^DGCR(399,IBIFN,"U")),U)
 S Z0=$S(IBSRT="B":IBMUT,IBSRT="D":-IBDAY,IBSRT="I":$P(IBINS2,U,2)_"~"_$P(IBINS2,U),IBSRT="M":$$EXTERNAL^DILFD(361.1,.13,"",$P(IB3611,"^",13)),IBSRT="R":-IBPTRSP,IBSRT="P":IBPTNM,IBSRT="S":IBSRVC,1:IBDT)
 S ^TMP("IBCOBST",$J,Z0,IBIFN)=IBSRVC_U_IBOAM_U_IBAPY_U_$S(IBNBAL>0:IBNBAL,1:0)_U_$P(IBB,U,5)_U_$P(IBB,U,19)_U_IBBPY_U_$P(IBMUT,"~")_U_IBINS_U_IBDA_U_$$HIS(IBIFN)_U_IBDAY_U_IBDT_U_IBQ_U_IB364_U_IBSEQ_U_IBEXPY_U_IBPTRSP
 S ^TMP("IBCOBST",$J,Z0,IBIFN,1)=$$EXTERNAL^DILFD(361.1,.13,"",$P(IB3611,"^",13))_", "_$$FMTE^XLFDT($P($P(IB3611,"^",6),"."))_"^"_$P(IB3611,"^",16)
 S ^TMP("IBCOBSTX",$J,IBIFN)=IBDA  ;keep track of compiled IBIFN's
 ;
 ; Save some data when there are multiple MRA's on file for this bill
 S IBMRACNT=$$MRACNT^IBCEMU1(IBIFN)
 I IBMRACNT>1 S $P(^TMP("IBCOBST",$J,Z0,IBIFN,1),U,1)="Multiple MRA's on file"
 S $P(^TMP("IBCOBST",$J,Z0,IBIFN,1),U,3)=IBMRACNT
 S $P(^TMP("IBCOBST",$J,Z0,IBIFN,1),U,4)=IBDENDUP
 Q
 ;
HIS(IBIFN) ; COB history
 N A,B,IBST,IBBIL,IBHIS
 S IBHIS="",A=0 F  S A=$O(^IBM(361.1,"ABS",IBIFN,A)) Q:'A  S B=0 F  S B=$O(^IBM(361.1,"ABS",IBIFN,A,B)) Q:'B  D
 . S IBST=$P($G(^IBM(361.1,B,0)),U,4),IBBIL=$P(^DGCR(399,IBIFN,"M1"),U,4+A)
 . Q:IBBIL=""
 . S IBHIS=IBHIS_$S(IBHIS="":"",1:";")_$S(A=1:"PRIMARY",A=2:"SECONDARY",1:"TERTIARY")_" "_$S(IBST:"MRA",1:"EOB")_" RECEIVED - "_IBBIL
 Q IBHIS
 ;
NMAT ;No COB list
 S VALMCNT=2,IBCNT=2
 S ^TMP("IBCECOB",$J,1,0)=" "
 S ^TMP("IBCECOB",$J,2,0)="    No MRA's Matching Selection Criteria Were Found"
 Q
 ;
SCRN ;
 N IBX,IBCNT,IBIFN,IBDA,IB,X,IBS1,IBPAT,Z,IBK,IBFORM
 S IBCNT=0
 S IBS1=$S(IBSRT="B":"BILLER",IBSRT="D":"Days Since Last Transmission",IBSRT="L":"Date Last MRA Received",IBSRT="I":"SECONDARY INSURANCE COMPANY",IBSRT="M":"MRA Status",1:"")
 S IBX="" F  S IBX=$O(^TMP("IBCOBST",$J,IBX)) Q:IBX=""  D
 . I IBSRT="B"!(IBSRT="I")!(IBSRT="M") D
 .. D:IBCNT SET("",IBCNT+1)
 .. D SET(IBS1_": "_$P(IBX,"~"),IBCNT+1)
 . S IBIFN=0 F  S IBIFN=$O(^TMP("IBCOBST",$J,IBX,IBIFN)) Q:'IBIFN  D
 .. S IB=$G(^TMP("IBCOBST",$J,IBX,IBIFN))
 .. S Z=$G(^DPT(+$P($G(^DGCR(399,IBIFN,0)),U,2),0))
 .. S IBPAT=$$LJ^XLFSTR($E($P(Z,U),1,18),18," ")_" "_$E($P(Z,U,9),6,9)
 .. S IBDA=$P(IB,U,10) ;361.1-ien
 .. S IBQ=$P(IB,U,14),IB364=$P(IB,U,15)
 .. S IBFORM=$$EXTERNAL^DILFD(399,.19,,+$P(IB,U,6))
 .. I +$P(IB,U,6)=2 S IBFORM=1500   ; for space reasons
 .. S IBPTRSP=$P(IB,U,18)
 .. S IBAMT=$P(IB,U,2)
 .. S IBCNT=IBCNT+1
 .. S X=""
 .. S X=$$SETFLD^VALM1(IBCNT,X,"NUMBER")
 .. S X=$$SETFLD^VALM1($$BN1^PRCAFN(IBIFN)_$S($P($G(^DGCR(399,IBIFN,"TX")),U,10)=1:"*",1:""),X,"BILL")
 .. S X=$$SETFLD^VALM1($$DAT1^IBOUTL($P(IB,U)),X,"SERVICE")
 .. S X=$$SETFLD^VALM1(IBPAT,X,"PATNM")
 .. S X=$$SETFLD^VALM1($$RJ^XLFSTR($FN(IBPTRSP,"",2),9," "),X,"PTRESP")
 .. S X=$$SETFLD^VALM1($$RJ^XLFSTR($FN(IBAMT,"",2),9," "),X,"IBAMT")
 .. S X=$$SETFLD^VALM1($$TYPE^IBJTLA1($P(IB,U,5))_"/"_IBFORM,X,"BTYPE")
 .. D SET(X,IBCNT,IBIFN,IBDA,IBQ,IB364,IBX,IB)
 .. ;For R (Pt Resp), P (Pt Name) and S (Service Date) don't display sub-headers
 .. I "BIMRPS"'[IBSRT D
 ... S Z=$S(IBSRT="L":$$DAT1^IBOUTL(IBX),IBSRT="D":-IBX,1:IBX)
 ... D SET("   "_IBS1_": "_Z,IBCNT)
 .. S X=$$SETSTR^VALM1("Insurers:  "_$P(IB,U,9),"",7,74)
 .. D SET(X,IBCNT,IBIFN,IBDA,IBQ,IB364,IBX,IB)
 .. ;
 .. ; line 3 of display:  MRA status/date/split claim indicator
 .. S X=$$SETSTR^VALM1("MRA Status:  ","",5,13)
 .. S IBK=$G(^TMP("IBCOBST",$J,IBX,IBIFN,1))
 .. S X=$$SETSTR^VALM1($P(IBK,U,1),X,18,63)
 .. I $P(IBK,U,2)=2 S X=$$SETSTR^VALM1("** SPLIT CLAIM **",X,63,18)
 .. I $P(IBK,U,4),$P(IBK,U,2)'=2,$P(IBK,U,3)=1 S X=$$SETSTR^VALM1("** Denied for Duplicate **",X,54,27)
 .. D SET(X,IBCNT,IBIFN,IBDA,IBQ,IB364,IBX,IB)
 .. ;
 .. ; conditionally update video attributes of line 3
 .. I '$D(IOINHI) D ENS^%ZISS
 .. ; split claim
 .. I $P(IBK,U,2)=2 D CNTRL^VALM10(VALMCNT,63,17,IOINHI,IOINORM)
 .. ; multiple mra's on file
 .. I $P(IBK,U,3)>1 D CNTRL^VALM10(VALMCNT,18,22,IOINHI,IOINORM)
 .. ; Denied for Duplicate - no split claim and single MRA only
 .. I $P(IBK,U,4),$P(IBK,U,2)'=2,$P(IBK,U,3)=1 D CNTRL^VALM10(VALMCNT,54,26,IOINHI,IOINORM)
 .. Q
 Q
 ;
SET(X,CNT,IBIFN,IBDA,IBQ,IB364,IBX,IB) ;set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCECOB",$J,VALMCNT,0)=X
 S ^TMP("IBCECOB",$J,"IDX",VALMCNT,CNT)=""
 I $G(IBIFN),$G(^TMP("IBCECOB",$J,CNT))="" S ^TMP("IBCECOB",$J,CNT)=VALMCNT_U_IBIFN_U_IB364_U_IBDA_U_IBQ_U_IBX,^TMP("IBCECOB1",$J,CNT)=IB
 Q
 ;
FTYPE(Y) ;type classification
 Q $E($P($G(^IBE(353,Y,0)),U),1,8)
 ;
PTRESPI(IBEOB) ; Function - Computes the Patient's Responsibility based on IBEOB
 ; of 361.1 for Claims/Bills with form type 3=UB
 ; Input IBEOB - a single EOB ien; Required
 ; Output      - Function Returns IBPTRES - Patient Responsibility Amount for the EOB
 ;
 N IBPTRES,IBC,EOBADJ
 S IBPTRES=0,IBEOB=+$G(IBEOB)
 I 'IBEOB Q IBPTRES   ;PTRESPI
 ; filing error
 Q:$D(^IBM(361.1,IBEOB,"ERR")) IBPTRES
 ;
 ; get claim level adjustments
 K EOBADJ M EOBADJ=^IBM(361.1,IBEOB,10)
 S IBPTRES=$$CALCPR^IBCEU0(.EOBADJ)
 ;
 ; get line level adjustments
 S IBC=0 F  S IBC=$O(^IBM(361.1,IBEOB,15,IBC)) Q:'IBC  D
 . K EOBADJ M EOBADJ=^IBM(361.1,IBEOB,15,IBC,1)
 . S IBPTRES=IBPTRES+$$CALCPR^IBCEU0(.EOBADJ)
 Q IBPTRES
 ;
ELIG(IBEOB) ; Function to determine if an EOB entry is eligible for
 ; inclusion on the MRA management worklist or not.
 ; IBEOB - ien into file 361.1 (required)
 ; Returns 1 if EOB should appear on the worklist
 ; Returns 0 if EOB should not appear on the worklist
 ;
 NEW ELIG,IB3611,IBIFN
 S ELIG=0,IBEOB=+$G(IBEOB)
 S IB3611=$G(^IBM(361.1,IBEOB,0))
 I $P(IB3611,U,4)'=1 G ELIGX    ; eob type must be Medicare MRA
 I $P(IB3611,U,16)>2 G ELIGX    ; review status must be <= 2
 S IBIFN=+IB3611
 I $P($G(^DGCR(399,IBIFN,0)),U,13)'=2 G ELIGX  ; Request MRA bill status
 I $D(^IBM(361.1,IBEOB,"ERR")) G ELIGX         ; filing errors
 ;
 S ELIG=1    ; this EOB is eligible for the worklist
 ;
ELIGX ;
 Q ELIG
 ;
