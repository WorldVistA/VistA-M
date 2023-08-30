IBCECOB1 ;ALB/CXW - IB COB MANAGEMENT SCREEN/REPORT ;14-JUN-99
 ;;2.0;INTEGRATED BILLING;**137,155,288,348,377,417,432,447,488,516,547,592,727**;21-MAR-94;Build 34
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IBMRANOT = 1 when dealing with the COB Management Worklist.   
 ;            It is set by the entry action in the option file. 
 ;
BLD ; Build list entrypoint
 ;
 N I,IB3611,IB364,IBAMT,IBAPY,IBB,IBB364,IBBPY,IBDA,IBDA1,IBDAY
 N IBDENDUP,IBDIV,IBDT,IBDTN,IBEOBREV,IBEUT,IBEXPY,IBFND,IBHIS
 N IBIFN,IBINS,IBINS1,IBINS2,IBMRACNT,IBMUT,IBNBAL,IBNDI1,IBNDI2
 N IBNDI3,IBNDM,IBNDS,IBOAM,IBPTNM,IBPTRSP,IBPY,IBQ,IBSEQ,IBSRVC
 N EOBTYPE,MSEFLG,Z,Z0
 ;
 K ^TMP("IBCECOB",$J),^TMP("IBCECOB1",$J),^TMP("IBCOBST",$J),^TMP("IBCOBSTX",$J)
 D CLEAN^VALM10      ; kill data and video control arrays
 S (VALMCNT,MSEFLG)=0,IBHIS=""
 ; IB*2.0*432 IF not MRA, use new CAP index on 399 file
 D:$G(IBMRANOT)=1 CAP^IBCAPP2
 ; since 0 is a valid Review Status, init w/null
 S IBEOBREV=""
 ; get EOB's w/Review Status of 0, 1, 1.5 or 2; If 3 or higher, not needed
 I $G(IBMRANOT)'=1 F  S IBEOBREV=$O(^IBM(361.1,"AMRA",1,IBEOBREV)) Q:IBEOBREV=""  Q:IBEOBREV>2  D
 . S IBDA="A" F  S IBDA=$O(^IBM(361.1,"AMRA",1,IBEOBREV,IBDA),-1) Q:'IBDA  D BLD1
 ;
 ; no data accumulated
 I $O(^TMP("IBCOBST",$J,""))="" D NMAT Q
 ;
 ; display accumulated data
 D SCRN
 Q
 ;
BLD1 ;
 ;
 S MSEFLG=$$ELIG(IBDA) Q:'MSEFLG
 S IBDENDUP=$$DENDUP^IBCEMU4(IBDA,$G(IBMRANOT))
 I '$G(IBMRADUP),IBDENDUP Q     ; don't include denied MRAs/EOBs for Duplicate Claim/Service
 S IB3611=$G(^IBM(361.1,IBDA,0))
 S IBIFN=+IB3611,IB364=$P(IB3611,U,19),IBDT=+$P(IB3611,U,6)
 I $D(^TMP("IBCOBSTX",$J,IBIFN)) Q  ;show each bill once on the worklist
 S IBB=$G(^DGCR(399,IBIFN,0))
 ;
 ; MRD;IB*2.0*516 - User requested the ability to sort the COB Mgmt
 ; Worklist by Division.  To enable this, the Division was added as
 ; a subscript to the ^TMP("IBCOBST") array. For now, that subscript
 ; will always be "UNKNOWN" when building the MRA Worklist.  To turn
 ; on sort-by-division for the MRA Worklist, uncomment out the fol-
 ; lowing two lines and delete the line Setting IBDIV to "UNKNOWN".
 ;S IBDIV=$P(IBB,U,22) I IBDIV="" S IBDIV="UNKNOWN"
 ;I $D(^TMP("IBBIL-DIV",$J)),'$D(^TMP("IBBIL-DIV",$J,IBDIV)) Q
 S IBDIV="UNKNOWN"
 ;
 S IBNDS=$G(^DGCR(399,IBIFN,"S")),IBNDI1=$G(^("I1")),IBNDI2=$G(^("I2")),IBNDI3=$G(^("I3")),IBNDM=$G(^("M"))
 S IBMUT=+$P(IBNDS,U,8),IBEUT=+$P(IBNDS,U,2)
 S IBINS="",IBSEQ=$P(IB3611,U,15)
 F I=1:1:3 S Z="IBNDI"_I I @Z D
 . N Q
 . S Q=(IBSEQ=I)
 . I Q S IBINS1=+@Z_U_$P($G(^DIC(36,+@Z,0)),U)
 . S IBINS=IBINS_$S(IBINS="":"",1:", ")_$P($G(^DIC(36,+@Z,0)),U)
 . Q
 ; Get the payer/insurance company that comes after Medicare WNR
 ; If WNR is Primary, get the secondary ins. co.
 ; If WNR is secondary, get the tertiary ins. co.
 D  I $P($G(IBINS2),U,2)="" S $P(IBINS2,U,2)="UNKNOWN"
 . I $$WNRBILL^IBEFUNC(IBIFN,1) S IBINS2=+IBNDI2_U_$P($G(^DIC(36,+IBNDI2,0)),U) Q
 . S IBINS2=+IBNDI3_U_$P($G(^DIC(36,+IBNDI3,0)),U)
 . Q
 S IBFND=0
 ; biller entry not ALL and no biller, then get entered/edited by user
 I $D(^TMP("IBBIL",$J)) D  Q:'IBFND
 . S IBFND=$S($D(^TMP("IBBIL",$J,IBMUT)):IBMUT,$D(^TMP("IBBIL",$J,IBEUT)):IBEUT,1:0)
 . Q
 S Z=$S(IBFND:IBFND,IBMUT:IBMUT,1:IBEUT)
 S IBMUT=$P($G(^VA(200,+Z,0)),U)_"~"_Z
 S:'$P(IBMUT,"~",2) IBMUT="UNKNOWN~0"
 S IBBPY=+$$COBN^IBCEF(IBIFN),IBQ=1
 ;
 ;IBQ;1=EOB without subsequent insurer,0=COB,2=0 balance
 D  ;I IBQ Q
 . ;Check for no reimbursable subsequent insurance
 . F I=IBBPY+1:1:3 D  Q:'IBQ
 .. S Z="IBNDI"_I,Z=$G(@Z)
 .. I $P($G(^DIC(36,+Z,0)),U,2)="N" S IBQ=0 Q
 .. Q
 . ;Check if next ins doesn't exist or next bill# already created
 . S Z="IBNDI"_(IBBPY+1),Z=$G(@Z)
 . I Z,'$P($G(^DGCR(399,IBIFN,"M1")),U,5+IBBPY) S IBQ=0
 . Q
 ;
 ; Days since transmission of latest bill in COB - IBDAY
 S IBDAY=+$P($G(^DGCR(399,IBIFN,"TX")),U,2) I IBDAY S IBDAY=$$FMDIFF^XLFDT(DT,IBDAY,1)
 ; if no Last Electronic Extract Date on file 399, get it from file 364
 I 'IBDAY D  I IBDAY S IBDAY=$$FMDIFF^XLFDT(DT,IBDAY,1) ;calc. the difference
 . S IBB364=$$LAST364^IBCEF4(IBIFN) I IBB364'="" S IBDAY=+$P($P($G(^IBA(364,IBB364,0)),U,4),".",1)
 ;
 S IBAPY=$$TPR^PRCAFN(IBIFN) ; payment on this bill from A/R
 S IBEXPY=+$G(^IBM(361.1,IBDA,1))       ; payer paid amount
 ; IB*2.0*447 add excess indicator to MRW screen and adjust calcs to include percentages
 S IBPTRSP=$S($$MSEDT^IBCEMU4(IBIFN)'="":$$MSPRE^IBCEMU4(IBIFN,1),1:$$PREOBTOT^IBCEU0(IBIFN)) ; patient resp. function
 S IBPY=$S(IBAPY:IBAPY,1:IBEXPY)
 S IBOAM=+$G(^DGCR(399,IBIFN,"U1"))     ; total charges for bill
 S IBNBAL=IBOAM-IBPY
 I IBNBAL'>0 S IBQ=2
 S IBPTNM=$P($G(^DPT(+$P($G(^DGCR(399,IBIFN,0)),U,2),0)),U) I IBPTNM="" S IBPTNM="UNKNOWN"
 S IBSRVC=$P($G(^DGCR(399,IBIFN,"U")),U)
 ;
 ; MRD;IB*2.0*516 - Added Division as a subscript.
 S Z0=$S(IBSRT="B":IBMUT,IBSRT="D":-IBDAY,IBSRT="I":$P(IBINS2,U,2)_"~"_$P(IBINS2,U),IBSRT="M":$$EXTERNAL^DILFD(361.1,.13,"",$P(IB3611,"^",13)),IBSRT="R":-IBPTRSP,IBSRT="P":IBPTNM,IBSRT="S":+IBSRVC,1:+IBDT)
 S:((IBSRT="M")&(Z0="")) Z0="UNKNOWN"   ;USE UNKNOWN IF NOT SET - BI;IB*2.0*432
 ;I $D(^TMP("IBCOBST",$J,Z0,IBIFN)),$P(^TMP("IBCOBST",$J,Z0,IBIFN),U,19)=-1 S MSEFLG=-1   ; If a MSE was previously found for IBIFN, we want to insure that we don't ignore that by resetting the 19th piece to something else.
 I $D(^TMP("IBCOBST",$J,IBDIV,Z0,IBIFN)),$P(^TMP("IBCOBST",$J,IBDIV,Z0,IBIFN),U,19)=-1 S MSEFLG=-1   ; If a MSE was previously found for IBIFN, we want to insure that we don't ignore that by resetting the 19th piece to something else.
 ;
 ;S ^TMP("IBCOBST",$J,Z0,IBIFN)=IBSRVC_U_IBOAM_U_IBAPY_U_$S(IBNBAL>0:IBNBAL,1:0)_U_$P(IBB,U,5)_U_$P(IBB,U,19)_U_IBBPY_U_$P(IBMUT,"~")_U_IBINS_U_IBDA_U_$$HIS(IBIFN)_U_IBDAY_U_IBDT_U_IBQ_U_IB364_U_IBSEQ_U_IBEXPY_U_IBPTRSP_U_MSEFLG
 ;S ^TMP("IBCOBST",$J,Z0,IBIFN,1)=$$EXTERNAL^DILFD(361.1,.13,"",$P(IB3611,"^",13))_", "_$$FMTE^XLFDT($P($P(IB3611,"^",6),"."))_"^"_$P(IB3611,"^",16)
 S ^TMP("IBCOBST",$J,IBDIV,Z0,IBIFN)=IBSRVC_U_IBOAM_U_IBAPY_U_$S(IBNBAL>0:IBNBAL,1:0)_U_$P(IBB,U,5)_U_$P(IBB,U,19)_U_IBBPY_U_$P(IBMUT,"~")_U_IBINS_U_IBDA_U_$$HIS(IBIFN)_U_IBDAY_U_IBDT_U_IBQ_U_IB364_U_IBSEQ_U_IBEXPY_U_IBPTRSP_U_MSEFLG
 S ^TMP("IBCOBST",$J,IBDIV,Z0,IBIFN,1)=$$EXTERNAL^DILFD(361.1,.13,"",$P(IB3611,"^",13))_", "_$$FMTE^XLFDT($P($P(IB3611,"^",6),"."))_"^"_$P(IB3611,"^",16)
 S ^TMP("IBCOBSTX",$J,IBIFN)=IBDA  ;keep track of compiled IBIFN's
 ;
 ; Save some data when there are multiple MRA's on file for this bill
 S IBMRACNT=$$MRACNT^IBCEMU1(IBIFN,$G(IBMRANOT))   ;WCJ IB*2.0*432
 ;I IBMRACNT>1 S $P(^TMP("IBCOBST",$J,Z0,IBIFN,1),U,1)="Multiple "_$S($G(IBMRANOT):"EOBs",1:"MRA's")_" on file"  ;WCJ IB*2.0*432
 ;S $P(^TMP("IBCOBST",$J,Z0,IBIFN,1),U,3)=IBMRACNT
 ;S $P(^TMP("IBCOBST",$J,Z0,IBIFN,1),U,4)=IBDENDUP
 I IBMRACNT>1 S $P(^TMP("IBCOBST",$J,IBDIV,Z0,IBIFN,1),U,1)="Multiple "_$S($G(IBMRANOT):"EOBs",1:"MRA's")_" on file"  ;WCJ IB*2.0*432
 S $P(^TMP("IBCOBST",$J,IBDIV,Z0,IBIFN,1),U,3)=IBMRACNT
 S $P(^TMP("IBCOBST",$J,IBDIV,Z0,IBIFN,1),U,4)=IBDENDUP
 Q
 ;
HIS(IBIFN) ; COB history
 N A,B,IBST,IBBIL,IBHIS
 S IBHIS="",A=0 F  S A=$O(^IBM(361.1,"ABS",IBIFN,A)) Q:'A  S B=0 F  S B=$O(^IBM(361.1,"ABS",IBIFN,A,B)) Q:'B  D
 . S IBST=$P($G(^IBM(361.1,B,0)),U,4),IBBIL=$P($G(^DGCR(399,IBIFN,"M1")),U,4+A)   ;WCJ IB*2.0*432 added $G
 . Q:IBBIL=""
 . S IBHIS=IBHIS_$S(IBHIS="":"",1:";")_$S(A=1:"PRIMARY",A=2:"SECONDARY",1:"TERTIARY")_" "_$S(IBST:"MRA",1:"EOB")_" RECEIVED - "_IBBIL
 Q IBHIS
 ;
NMAT ;No COB list
 S VALMCNT=2,IBCNT=2
 S ^TMP("IBCECOB",$J,1,0)=" "
 S ^TMP("IBCECOB",$J,2,0)="    No "_$S($G(IBMRANOT)=1:"EOB's",1:"MRA's")_" Matching Selection Criteria Were Found"
 Q
 ;
SCRN ;
 N IB,IBCNT,IBDA,IBDIV,IBIFN,IBFORM,IBK,IBPAT,IBS1,IBX,MSEFLG,X,Z
 N IBMRANOTMSE  ;TPF;EBILL-2436;IB*2.0*727
 ;
 S IBCNT=0
 ; IB*2.0*547 - Add primary insurance company sort, had to break into 2 lines
 S IBS1=$S(IBSRT="B":"BILLER",IBSRT="D":"Days Since Last Transmission",IBSRT="L":"Date Last "_$S($G(IBMRANOT):"EOB",1:"MRA")_" Received",IBSRT="I":"SECONDARY INSURANCE COMPANY",IBSRT="M":$S($G(IBMRANOT):"EOB",1:"MRA")_" Status",1:"")
 S:IBSRT="K" IBS1="PRIMARY INSURANCE COMPANY"
 ;
 ; MRD;IB*2.0*516 - Added Division as a subscript.
 S IBDIV=""
 F  S IBDIV=$O(^TMP("IBCOBST",$J,IBDIV)) Q:IBDIV=""  D
 . I IBCNT D SET("",IBCNT+1)
 . D SET("Division: "_$$GET1^DIQ(40.8,IBDIV_",",.01,"E"),IBCNT+1)
 . ;
 . ;S IBX="" F  S IBX=$O(^TMP("IBCOBST",$J,IBX)) Q:IBX=""  D
 . S IBX="" F  S IBX=$O(^TMP("IBCOBST",$J,IBDIV,IBX)) Q:IBX=""  D
 .. ; P547
 .. ;I IBSRT="B"!(IBSRT="I")!(IBSRT="M") D
 .. I IBSRT="B"!(IBSRT="I")!(IBSRT="M")!(IBSRT="K") D
 ... I IBCNT D SET("",IBCNT+1)
 ... D SET(IBS1_": "_$P(IBX,"~"),IBCNT+1)
 ... Q
 .. ;
 .. ;S IBIFN=0 F  S IBIFN=$O(^TMP("IBCOBST",$J,IBX,IBIFN)) Q:'IBIFN  D
 .. S IBIFN=0 F  S IBIFN=$O(^TMP("IBCOBST",$J,IBDIV,IBX,IBIFN)) Q:'IBIFN  D
 ... ;S IB=$G(^TMP("IBCOBST",$J,IBX,IBIFN))
 ... S IB=$G(^TMP("IBCOBST",$J,IBDIV,IBX,IBIFN))
 ... S Z=$G(^DPT(+$P($G(^DGCR(399,IBIFN,0)),U,2),0))
 ... S IBPAT=$$LJ^XLFSTR($E($P(Z,U),1,18),18," ")_" "_$E($P(Z,U,9),6,9)
 ... S IBDA=$P(IB,U,10) ;361.1-ien
 ... S IBQ=$P(IB,U,14),IB364=$P(IB,U,15)
 ... ; IB*2.0*447 shorten form column to I for Instutional and P for Professional
 ... ;S IBFORM=$$EXTERNAL^DILFD(399,.19,,+$P(IB,U,6))
 ... ;I +$P(IB,U,6)=2 S IBFORM=1500   ; for space reasons
 ... ;JWS;IB*2.0*592;Add 'D' for Dental display
 ... S IBFORM=$S(+$P(IB,U,6)=2:"P",+$P(IB,U,6)=7:"D",1:"I")
 ... S IBPTRSP=$P(IB,U,18)
 ... S MSEFLG=$P(IB,U,19)
 ... S IBAMT=$P(IB,U,2)
 ... S IBCNT=IBCNT+1
 ... S X=""
 ... ;
 ... ;TPF;EBILL-2436;IB*2.0*727 ADD FLAG FOR MSE ERROR
 ... ;S IBMRANOTMSE=$$GET1^DIQ(399,IBIFN_",",36,"","","")="IB803"  ;EOB CLAIM MSE ERROR?
 ... S IBMRANOTMSE=$$FILERR^IBCAPP2(IBIFN)  ;TPF;EBILL-3061;IB*2.0*727 v15 
 ... ;
 ... S X=$$SETFLD^VALM1(IBCNT,X,"NUMBER")
 ... ;;;S X=$$SETFLD^VALM1($$BN1^PRCAFN(IBIFN)_$S($P($G(^DGCR(399,IBIFN,"TX")),U,10)=1:"*",1:""),X,"BILL")
 ... ;S X=$$SETFLD^VALM1($S(MSEFLG=-1:"!",1:" ")_$$BN1^PRCAFN(IBIFN)_$S($P($G(^DGCR(399,IBIFN,"TX")),U,10)=1:"*",1:""),X,"BILL")  ; per IB*2.0*488
 ... S X=$$SETFLD^VALM1($S((MSEFLG=-1)!($G(IBMRANOT)&$G(IBMRANOTMSE)):"!",1:" ")_$$BN1^PRCAFN(IBIFN)_$S($P($G(^DGCR(399,IBIFN,"TX")),U,10)=1:"*",1:""),X,"BILL")  ; per IB*2.0*488
 ... S X=$$SETFLD^VALM1($$DAT1^IBOUTL($P(IB,U)),X,"SERVICE")
 ... S X=$$SETFLD^VALM1(IBPAT,X,"PATNM")
 ... S X=$$SETFLD^VALM1($$RJ^XLFSTR($FN(IBPTRSP,"",2),9," "),X,"PTRESP")
 ... S X=$$SETFLD^VALM1($$RJ^XLFSTR($FN(IBAMT,"",2),9," "),X,"IBAMT")
 ... S X=$$SETFLD^VALM1($E($$TYPE^IBJTLA1($P(IB,U,5)))_"/"_IBFORM,X,"BTYPE")
 ... D SET(X,IBCNT,IBIFN,IBDA,IBQ,IB364,IBX,IB)
 ... ;
 ... ;For R (Pt Resp), P (Pt Name) and S (Service Date) don't display sub-headers
 ... ;I "BIMRPS"'[IBSRT D  IB*2.0*547
 ... I "BIMRPSK"'[IBSRT D
 .... S Z=$S(IBSRT="L":$$DAT1^IBOUTL(IBX),IBSRT="D":-IBX,1:IBX)
 .... D SET("   "_IBS1_": "_Z,IBCNT)
 .... Q
 ... S X=$$SETSTR^VALM1("Insurers:  "_$P(IB,U,9),"",7,74)
 ... D SET(X,IBCNT,IBIFN,IBDA,IBQ,IB364,IBX,IB)
 ... ;
 ... ; line 3 of display:  MRA status/date/split claim indicator
 ... S X=$$SETSTR^VALM1($S($G(IBMRANOT):"EOB",1:"MRA")_" Status:  ","",5,13)
 ... ;S IBK=$G(^TMP("IBCOBST",$J,IBX,IBIFN,1))
 ... S IBK=$G(^TMP("IBCOBST",$J,IBDIV,IBX,IBIFN,1))
 ... S X=$$SETSTR^VALM1($P(IBK,U,1),X,18,63)
 ... I $P(IBK,U,2)=2 S X=$$SETSTR^VALM1("** SPLIT CLAIM **",X,63,18)
 ... I $P(IBK,U,4),$P(IBK,U,2)'=2,$P(IBK,U,3)=1 S X=$$SETSTR^VALM1("** Denied for Duplicate **",X,54,27)
 ... D SET(X,IBCNT,IBIFN,IBDA,IBQ,IB364,IBX,IB)
 ... ; conditionally update video attributes of line 3
 ... I '$D(IOINHI) D ENS^%ZISS
 ... ; split claim
 ... I $P(IBK,U,2)=2 D CNTRL^VALM10(VALMCNT,63,17,IOINHI,IOINORM)
 ... ; multiple mra's on file
 ... I $P(IBK,U,3)>1 D CNTRL^VALM10(VALMCNT,18,22,IOINHI,IOINORM)
 ... ; Denied for Duplicate - no split claim and single MRA only
 ... I $P(IBK,U,4),$P(IBK,U,2)'=2,$P(IBK,U,3)=1 D CNTRL^VALM10(VALMCNT,54,26,IOINHI,IOINORM)
 ... Q
 .. Q
 . Q
 ;
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
 ; inclusion on the MRA or COB management worklist or not.
 ; IBEOB - ien into file 361.1 (required)
 ; Returns 1 if EOB should appear on the worklist
 ; Returns 0 if EOB should not appear on the worklist
 ; Returns -1 if EOB contains Message Storage Errors
 ;
 NEW ELIG,IB3611,IBIFN
 S ELIG=0,IBEOB=+$G(IBEOB)
 S IB3611=$G(^IBM(361.1,IBEOB,0))
 I $P(IB3611,U,4)'=1 G ELIGX    ; eob type must be correct for this worklist
 I $P(IB3611,U,16)>2 G ELIGX    ; review status must be <= 2
 S IBIFN=+IB3611
 I $P($G(^DGCR(399,IBIFN,0)),U,13)'=2 G ELIGX  ; Request MRA bill status
 I $D(^IBM(361.1,IBEOB,"ERR")) S ELIG=$S('$G(IBMRANOT):-1,1:ELIG) G ELIGX         ; filing errors - contains Message Storage Errors
 ;
 S ELIG=1    ; this EOB is eligible for the worklist
 ;
ELIGX ;
 Q ELIG
 ;
WLRMV ; REMOVE FROM EOB WORK LIST
 ; IBDA(IBDA)=IBIFN^IB364^ien of 361.1^user selection seq^user name~duz#
 N IBIFN,IBDA,DIR,DTOUT,DUOUT,DA,DIE,DR,X
 D SEL^IBCECOB2(.IBDA,1)
 S VALMBCK="R"
 S IBDA=$O(IBDA(0)) I 'IBDA Q
 S IBIFN=$P(IBDA(IBDA),U,1) I 'IBIFN Q
 S DIR("A",1)=""
 S DIR("A",2)="    Bill #: "_$$GET1^DIQ(399,IBIFN_", ",.01,"E")
 S DIR("A",3)="   Patient: "_$$GET1^DIQ(399,IBIFN_", ",.02,"E")
 S DIR("A",4)=" Bill Type: "_$$GET1^DIQ(399,IBIFN_", ",.05,"E")
 S DIR("A",5)="Bill Dates: "_$$GET1^DIQ(399,IBIFN_", ",151,"E")_" - "_$$GET1^DIQ(399,IBIFN_", ",152,"E")
 S DIR("A",6)=" "
 S DIR("A")="Are you sure remove this claim from the worklist? "
 S DIR("B")="NO"
 S DIR(0)="YA" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!'Y Q
 ;FLAG IF USER ANSWERS YES
 S X=$$WLRMVF^IBCECOB1(IBIFN,"RM")
 D BLD^IBCECOB1
 Q
 ;
WLRMVF(IBIFN,METHOD,BKFL) ;
 ; BFKL = 1 means background process, remove NOT initiated by a user
 N SOC,SOCCNT,SOCLIST,STATUS,IBDUZ
 S STATUS=0
 Q:'$G(DUZ) STATUS_"^MISSING DUZ"
 Q:'$G(IBIFN) STATUS_"^MISSING IBIFN"
 Q:'$D(^DGCR(399,IBIFN)) STATUS_"^INVALID IBIFN"
 ; if this is a background process, set user who removed to AUTHORIZER,IB REG
 S IBDUZ=$S($G(BKFL)=1:$$IBREG^IBCAPP(),1:$G(DUZ))
 ; GET DICTIONARY SET OF CODES.
 ; SOC("POINTER")="RM:REMOVE ACTION;PC:PROCESS COB ACTION;CL:CLONE ACTION;"
 D FIELD^DID(399,38,"","POINTER","SOC")
 S SOC=$G(SOC("POINTER"))
 F SOCCNT=1:1:$L(SOC,";")-1 S SOCLIST($P($P(SOC,";",SOCCNT),":",1))=""
 Q:$D(SOCLIST(METHOD))=0 STATUS_"^INVALID METHOD"
 S DA=IBIFN
 S DIE="^DGCR(399,"
 S DR="35////4"                ; AUTO PROCESS, NO LONGER ON WORKLIST
 S:IBDUZ'=-1 DR=DR_";"_"37////"_IBDUZ    ; WHO REMOVED FROM WORKLIST
 S DR=DR_";"_"38////"_METHOD   ; METHOD USED TO REMOVE FROM WORKLIST
 S DR=DR_";"_"39///NOW"        ; DATE STAMP WHEN REMOVED FOR WORKLIST
 D ^DIE
 S STATUS=1
 Q STATUS
