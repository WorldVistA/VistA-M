IBCAPP2 ;ALB/GEF - Claims Auto Processing  ;14-OCT-10
 ;;2.0;INTEGRATED BILLING;**432,447**;21-MAR-94;Build 80
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; IBMRANOT = 1 when dealing with the COB Management Worklist.   
 ;            It is set by the entry action in the option file. 
 ;
CAP ; Build list from CAP x-ref entrypoint.  Called from BLD^IBCECOB1 for non-MRA worklist
 N IBDA,IBIFN
 S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"CAP",1,IBIFN)) Q:'IBIFN  D
 .; screen all eob's for the claim to see if claim can be on worklist
 .; IBDA= ien of 1st eob to pass all checks - or - 0 if none passed - or - -1 if process as paper EOB
 .S IBDA=$$MELG(IBIFN,IBMRADUP) Q:'IBDA
 .D BLD1(IBIFN,$S(IBDA=-1:"",1:IBDA))
 Q
BLD1(IBIFN,IBDA) ;
 N IB3611,IBTXT,IBX,IBPY,I,IB364,IBDT,IBAPY,IBB,IBB364,IBBPY,IBDAY,IBEUT
 N IBINS1,IBINS2,IBMRACNT,Z,Z0,IBMUT,IBNBAL,IBNDI1,IBNDI2,IBNDI3,IBNDM
 N IBPTRSP,IBQ,IBSEQ,IBSRVC,IBEXPY,IBFND,IBINS,IBNDS,IBOAM,IBPTNM,IBDENDUP
 Q:$D(^TMP("IBCOBSTX",$J,IBIFN))  ;show each bill once on the worklist
 S IBB=$G(^DGCR(399,IBIFN,0))
 S IBNDS=$G(^DGCR(399,IBIFN,"S")),IBNDI1=$G(^("I1")),IBNDI2=$G(^("I2")),IBNDI3=$G(^("I3")),IBNDM=$G(^("M"))
 S IBMUT=+$P(IBNDS,U,8),IBEUT=+$P(IBNDS,U,2)
 S IBINS="",IBSEQ=$$COBN^IBCEF(IBIFN),IB364="UNKNOWN",IBDT="UNKNOWN"
 S IB3611=$S($G(IBDA)'="":$G(^IBM(361.1,IBDA,0)),1:"")
 I $G(IB3611)'="" S IB364=$P(IB3611,U,19),IBDT=+$P(IB3611,U,6),IBSEQ=$P(IB3611,U,15)
 F I=1:1:3 S Z="IBNDI"_I I @Z D
 . N Q
 . S Q=(IBSEQ=I)
 . I Q S IBINS1=+@Z_U_$P($G(^DIC(36,+@Z,0)),U)
 . S IBINS=IBINS_$S(IBINS="":"",1:", ")_$P($G(^DIC(36,+@Z,0)),U)
 ; Get the payer/insurance company that comes after Medicare WNR
 ; If WNR is Primary, get the secondary ins. co.
 ; If WNR is secondary, get the tertiary ins. co.
 D  I $P($G(IBINS2),U,2)="" S $P(IBINS2,U,2)="UNKNOWN"
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
 S IBAPY=$$TPR^PRCAFN(IBIFN) ; payment on this bill from A/R  IA#380
 S:$G(IBDA)'="" IBEXPY=+$G(^IBM(361.1,IBDA,1))       ; payer paid amount
 S IBPY=$S(IBAPY:IBAPY,1:+$G(IBEXPY))
 S IBOAM=+$G(^DGCR(399,IBIFN,"U1"))     ; total charges for bill
 ; Don't include claim if AR STATUS is COLLECTED/CLOSED and no subsequent payer and not one of the TRICARE/Champus claims that needs to be evaluated for Pt Payment,remove from list and quit
 I $P($$BILL^RCJIBFN2(IBIFN),U,2)=22 S IBX=$$EOB^IBCNSBL2(IBIFN,IBOAM,IBPY,.IBTXT) I '$D(IBTXT) D RMV(IBIFN) Q
 S IBNBAL=IBOAM-IBPY
 S IBPTRSP=$S(IBNBAL>0:IBNBAL,1:0)
 I IBNBAL'>0 S IBQ=2
 S IBPTNM=$P($G(^DPT(+$P($G(^DGCR(399,IBIFN,0)),U,2),0)),U) I IBPTNM="" S IBPTNM="UNKNOWN"
 S IBSRVC=$P($G(^DGCR(399,IBIFN,"U")),U)
 S Z0=$S(IBSRT="B":IBMUT,IBSRT="D":-IBDAY,IBSRT="I":$P(IBINS2,U,2)_"~"_$P(IBINS2,U),IBSRT="M":$$EXTERNAL^DILFD(361.1,.13,"",$P(IB3611,"^",13)),IBSRT="R":-IBPTRSP,IBSRT="P":IBPTNM,IBSRT="S":+IBSRVC,1:+IBDT)
 S:((IBSRT="M")&(Z0="")) Z0="UNKNOWN"   ;USE UNKNOWN IF NOT SET - BI;IB*2.0*432
 S ^TMP("IBCOBST",$J,Z0,IBIFN)=IBSRVC_U_IBOAM_U_IBAPY_U_$S(IBNBAL>0:IBNBAL,1:0)_U_$P(IBB,U,5)_U_$P(IBB,U,19)_U_IBBPY_U_$P(IBMUT,"~")_U_IBINS_U_$G(IBDA)_U_$$HIS(IBIFN)_U_$G(IBDAY)_U_$G(IBDT)_U_IBQ_U_$G(IB364)_U_IBSEQ_U_$G(IBEXPY)_U_IBPTRSP
 S ^TMP("IBCOBST",$J,Z0,IBIFN,1)=$S($G(IB3611)="":"No EEOB Received ",1:$$EXTERNAL^DILFD(361.1,.13,"",$P(IB3611,"^",13))_", "_$$FMTE^XLFDT($P($P(IB3611,"^",6),"."))_"^"_$P(IB3611,"^",16))
 S ^TMP("IBCOBSTX",$J,IBIFN)=$G(IBDA)  ;keep track of compiled IBIFN's
 ;
 ; Save some data when there are multiple MRA's on file for this bill
 S IBMRACNT=$$MRACNT^IBCEMU1(IBIFN,$G(IBMRANOT))   ;WCJ IB*2.0*432
 I IBMRACNT>1 S $P(^TMP("IBCOBST",$J,Z0,IBIFN,1),U,1)="Multiple "_$S($G(IBMRANOT):"EOBs",1:"MRA's")_" on file"  ;WCJ IB*2.0*432
 S $P(^TMP("IBCOBST",$J,Z0,IBIFN,1),U,3)=IBMRACNT
 S $P(^TMP("IBCOBST",$J,Z0,IBIFN,1),U,4)=$G(IBDENDUP)
 S:$G(IBDA)'="" $P(^TMP("IBCOBST",$J,Z0,IBIFN,1),U,4)=$$DENDUP^IBCEMU4(IBDA,1)
 Q
 ;
HIS(IBIFN) ; COB history
 N A,B,IBST,IBBIL,IBHIS
 S IBHIS="",A=0 F  S A=$O(^IBM(361.1,"ABS",IBIFN,A)) Q:'A  S B=0 F  S B=$O(^IBM(361.1,"ABS",IBIFN,A,B)) Q:'B  D
 . S IBST=$P($G(^IBM(361.1,B,0)),U,4),IBBIL=$P($G(^DGCR(399,IBIFN,"M1")),U,4+A)   ;WCJ IB*2.0*432 added $G
 . Q:IBBIL=""
 . S IBHIS=IBHIS_$S(IBHIS="":"",1:";")_$S(A=1:"PRIMARY",A=2:"SECONDARY",1:"TERTIARY")_" "_$S(IBST:"MRA",1:"EOB")_" RECEIVED - "_IBBIL
 I '$D(^IBM(361.1,"ABS",IBIFN)) F A=1:1:3 S IBBIL=$P($G(^DGCR(399,IBIFN,"M1")),U,4+A) I IBBIL'="" S IBHIS=IBHIS_$S(IBHIS="":"",1:";")_$S(A=1:"PRIMARY",A=2:"SECONDARY",A=3:"TERTIARY",1:"UNKNOWN")_" No EOB RECEIVED - "_IBBIL
 Q IBHIS
 ;
MELG(IBIFN,IBMRADUP) ; function to check all EOBs for a claim and determine if they are
 ; eligible for inclusion on the COB management worklist, uses both B & C x-ref
 ; IBIFN - claim ien (required)
 ; IBMRADUP - indicates user said NO to "include denied for duplicate" prompt
 ;
 ; Returns EOB ien to use for display, if at least 1 EOB passed all checks
 ; if multiple EOBs passed but some have filing errors, returns the 1st EOB found that does NOT have filing errors
 ; if all EOBs have filing errors, tries to find one that is a PROCESSED status and return that one for CBW display
 ; Returns -1 if claim should appear on the worklist with no EOB
 ; Returns 0 if no EOBs passed the checks and claim should not appear on the worklist, also removes it
 ;
 ; IBCK = Total number of EOBs found for this claim ien
 ; IBECT = Total number of EOBs that failed the EOB TYPE check
 ; IBCT = Total number of EOBs for a claim that passed ALL the checks
 ;
 N IBDA,IBCT,IBEOBNDX,IBEOB,IB3611,IBCK,IBETC
 S IBCT=0,IBCK=0,IBETC=0
 F IBEOBNDX="B","C" D
 .S IBDA=0 F  S IBDA=$O(^IBM(361.1,IBEOBNDX,IBIFN,IBDA)) Q:'+IBDA  D
 ..Q:$D(IBEOB(IBDA))
 ..S IB3611=$G(^IBM(361.1,IBDA,0)),IBCK=IBCK+1
 ..Q:$D(^IBM(361.1,IBDA,"ERR"))
 ..; if this is a denied EOB and user does NOT want to include denied as duplicates and this EOB was denied as duplicate, don't include
 ..I $P(IB3611,U,13)=2,'$G(IBMRADUP),$$DENDUP^IBCEMU4(IBDA,1) Q
 ..; eob type must be correct for this worklist
 ..I $P(IB3611,U,4)=1 S IBETC=IBETC+1 Q
 ..; allow filing errors on worklist, but try to find at least 1 Processed EOB w/out errors
 ..I $D(^IBM(361.1,IBDA,"ERR")) S:$P($G(^IBM(361.1,IBDA,0)),U,13)'=1 IBEOB("DER",IBDA)="" S:$P($G(^IBM(361.1,IBDA,0)),U,13)=1 IBEOB("PER",IBDA)="" Q
 ..S IBEOB(IBDA)="",IBCT=IBCT+1
 ; if no EOB was found to check, return -1 to process as no EOB
 Q:IBCK=0 -1
 ; if no EOB passed, check to see if the EOBs were all MRA primaries that failed the EOB type check (2ndary/tertiaries were paper)
 I IBCT=0,$$WNRBILL^IBEFUNC(IBIFN,1),$$COBN^IBCEF(IBIFN)>1,(IBCK=IBETC) Q -1
 ; if no EOB's passed, check for filing errors and use that EOB, with Processed EOB's taking priority over denied
 I IBCT=0,$D(IBEOB("PER")) Q $O(IBEOB("PER",0))
 I IBCT=0,$D(IBEOB("DER")) Q $O(IBEOB("DER",0))
 ; if no EOB passed and not MRA primary w/subsequent paper EOB's or filing errors, do not put on CBW
 Q:IBCT=0 0
 ; if one or more EOBs passed, return the 1st one that passed the checks as the one to use for CBW display
 Q $O(IBEOB(0))
 ;
RMV(DA) ;remove from worklist claims that are erroneously there
 N DIE,DR
 S DIE="^DGCR(399,",DR="35////@" D ^DIE ; Should never have been on the WORKLIST
 Q
 ;
