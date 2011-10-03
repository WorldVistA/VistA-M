IBNCPNB ;OAK/ELZ - UTILITIES FOR NCPCP ;5/22/08  15:23
 ;;2.0;INTEGRATED BILLING;**276,342,384**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;NCPDP PHASE III
 Q
 ;
 ;
NONBR(DFN,IBRX,IBFIL,IBADT,IBCR,IBPAP,IBRC,IBCC,IBUSER) ; Set non-billable reason to CT
 ; input:
 ;    DFN - Patient
 ;    IBRX - Rx IEN
 ;    IBFIL - fill#
 ;    IBADT - fill date
 ;    IBCR - Close Claim Reason (#356.8)
 ;    IBPAP - Autobillable flag (billable (1) / non-billable (0) flag)
 ;    IBRC - Release Copay (entered by OPECC)
 ;    IBCC - Close Reason Comment (entered by OPECC)
 ;    IBUSER - DUZ of user triggering the billing event
 N IBTRKRN,DIE,IBRESN,DR,DA,IBRMARK,IBLOCK,IBEABD,IBEABD,IBACT,IBFDA
 ; update claims tracking
 S IBTRKRN=+$O(^IBT(356,"ARXFL",IBRX,IBFIL,0))
 I 'IBTRKRN D  ; if it doesn't exist - create it
 . N IBTRKR
 . S IBTRKR=$G(^IBE(350.9,1,6)) ; claims tracking info
 . ; date can't be before parameters
 . S $P(IBTRKR,U)=$S('$P(IBTRKR,U,4):0,+IBTRKR&(IBADT<+IBTRKR):0,1:IBADT)
 . I 'IBTRKR Q  ; CT Disabled
 . D CT^IBNCPDPU(DFN,IBRX,IBFIL,IBADT,$G(IBCR))
 . S IBTRKRN=+$O(^IBT(356,"ARXFL",IBRX,IBFIL,0))
 I 'IBTRKRN Q  ; CT disabled
 L +^IBT(356,IBTRKRN):10 S IBLOCK=$T
 S DIE="^IBT(356,",DA=IBTRKRN
 ;
 ;
 ; if Billable - set EABD+60
 I '$G(IBCR) D  G NONBRQ
 .Q:$$GET1^DIQ(356,IBTRKRN_",",.19,"I")  ;quit if non-billable
 .S IBEABD=$$EABD^IBTUTL($O(^IBE(356.6,"AC",4,0)),IBADT)
 .I IBEABD S IBEABD=$$FMADD^XLFDT(IBEABD,60)
 .S DR=".17////^S X=IBEABD" D ^DIE
 ;
 ; if still billable, set the EABD.
 ;
 ; Don't check for the 2nd insurance in Phase 3 --
 ; allow the claim to become non-billable, ECME has already warned
 ; the user and provided information about the 2nd insurance
 ; in the User Screen
 ; I IBPAP!$$MOREINS(DFN,IBADT) D  G NONBRQ
 ;
 I IBPAP D  G NONBRQ
 . S IBEABD=$$EABD^IBTUTL($O(^IBE(356.6,"AC",4,0)),IBADT)
 . I IBEABD<DT S IBEABD=DT
 . S DR=".19///@" D ^DIE ; it re-sets .17 (trigger in #356)
 . S DR=".17////^S X=IBEABD"
 . S IBRMARK=$$REASON^IBNCPDPU(IBCR)
 . I IBCC'="" S IBRMARK=IBRMARK_"; "_IBCC
 . I $L($G(IBCC))>2 S DR=DR_";1.08////^S X=$E(IBRMARK,1,80)"
 . D ^DIE
 ;
 ; set non-billable reason
 S IBRMARK=$$REASON^IBNCPDPU(IBCR)
 I IBRMARK="" S IBRMARK="OTHER" S IBCC="Unknown NBR '"_IBCR_"'. "_$G(IBCC)
 S DR=".19///"_IBRMARK
 I $L($G(IBCC))>2 S DR=DR_";1.08////^S X=$E(IBCC,1,80)"
 D ^DIE
 ;
NONBRQ ;
 I $G(IBRC) D  ; Release Copay
 . S IBACT=+$$RELCOPAY(DFN,IBRX,IBFIL,1,IBADT,0) ; release copay charges off hold
 . ;if 0 (not found on HOLD) we will have one more attempt, it was scheduled inside RELCOPAY
 . ; so doesn't make sense to send "NOT RELEASED" e-mail
 . ; if the 2nd attempt fails then e-mail will be send from RCTASK
 . ;we send e-mail only if -1 i.e. if charge was found on hold but
 . ; ^IBR gave an error when we tried to release it
 . I IBACT=-1 D RELBUL^IBNCPEB(DFN,IBRX,IBFIL,IBADT,IBACT,IBCR,$G(IBCC),0,1)
 . ;if -2 (there is no copay) then do nothing
 S IBFDA(356,IBTRKRN_",",1.03)=DT  ; date last edited
 S IBFDA(356,IBTRKRN_",",1.04)=IBUSER   ; last edited by
 D FILE^DIE("","IBFDA"),MSG^DIALOG()
 I IBLOCK L -^IBT(356,IBTRKRN)
 Q
 ;
 ;
RELCOPAY(DFN,IBRX,IBFIL,IBRETRY,IBADT,IBIFN) ; Release copay charges on hold
 ; Input:
 ;    DFN - Patient IEN
 ;    IBRX - Rx IEN
 ;    IBFIL - fill/refill #
 ;    IBRETRY - retry flag
 ;    IBADT - fill date
 ;    IBIFN - 3rd party bill IEN
 ; output:
 ;    -2  == there is no any copay
 ;    -1^error code if unsuccessful  == if ^IBR error
 ;    0   == charge was not found (and depends on IBRETRY another attempt can be scheduled)
 ;    >0  == charge was released from HOLD
 ; this procedure will be called if the Payer agreed to pay 0.00
 ; or the claim was closed as non-billable by the OPECC.
 ; if patient exempt from RX copay then there is nothing to release from HOLD - quit
 I +$$RXEXMT^IBARXEU0(DFN,IBADT)=1 Q -2
 N IBACT,IBZ,IBFOUND,IBX,IBSEQNO,IBNOS,Y,IBDUZ,RCDUZ
 ; Schedule the task to speed up the whole process
 I 'IBRETRY D RCTASK(DFN,IBRX,IBFIL,+IBRETRY,IBADT,IBIFN) Q 0
 S IBFOUND=0
 S IBACT="A" F  S IBACT=$O(^IB("AH",DFN,IBACT),-1) Q:'IBACT  D  Q:IBFOUND
 . S IBZ=$G(^IB(IBACT,0)) Q:IBZ=""
 . S IBX=$P(IBZ,U,4)
 . I +IBX'=52 Q  ; not an Rx
 . I +$P(IBX,":",2)'=IBRX Q  ; other Rx
 . I +$P(IBX,":",3)'=IBFIL Q  ; other fill
 . S IBFOUND=IBACT
 I 'IBFOUND D RCTASK(DFN,IBRX,IBFIL,+$G(IBRETRY),IBADT,IBIFN) Q 0
 S IBSEQNO=1,IBNOS=IBFOUND
 S IBDUZ=$P($G(^IB(IBFOUND,1)),U) ; who entered the copay charge?
 S RCDUZ=IBDUZ
 D ^IBR I Y<0 Q Y
 Q IBFOUND
 ;
 ;Called by TaskMan
RELCRG ;
 N IBACT
 S IBACT=+$$RELCOPAY(DFN,IBRX,IBFIL,IBRETRY,IBADT,IBIFN)
 ;if 0 (not found on HOLD) we will have another attempt
 ;we send e-mail only if -1 (^IBR error)
 I IBACT=-1 D RELBUL^IBNCPEB(DFN,IBRX,IBFIL,IBADT,IBACT,0,"",IBIFN,IBRETRY)
 ;
 Q
 ;
 ;Schedule Release Copay
RCTASK(DFN,IBRX,IBFIL,IBRETRY,IBADT,IBIFN) ;
 N I,ZTRTN,ZTSAVE,ZTDESC,ZTDTH,ZTIO
 S IBRETRY=IBRETRY+1
 I IBRETRY>2 D  Q  ; Only two extra attempts
 . ;if all attempts were unsuccessful then send e-mail, set IBACT=0 since we do not have it
 . D RELBUL^IBNCPEB(DFN,IBRX,IBFIL,IBADT,0,0,"",IBIFN,2)
 S ZTRTN="RELCRG^IBNCPNB"
 F I="DFN","IBRX","IBFIL","IBRETRY","IBADT","IBIFN" S ZTSAVE(I)=""
 S ZTDESC="RELEASE COPAY RX IEN# "_IBRX
 S ZTIO=""
 S ZTDTH=$$HADD^XLFDT($H,0,0,0,$S(IBRETRY=1:10,1:600))
 D ^%ZTLOAD
 Q
 ;
 ;
 ; does the pat have >1 billable insur with pharm coverage?
MOREINS(DFN,IBADT) ;
 ; DFN - ptr to the patient
 ; IBADT - the effective date
 N IBANY,IBX,IBINS,IBT,IBRES,IBCAT
 S IBRES=0 ; No by default
 S IBCAT=$O(^IBE(355.31,"B","PHARMACY",0))
 ; -- look up insurance for patient
 D ALL^IBCNS1(DFN,"IBINS",1,IBADT,1)
 S IBX=0 F  S IBX=$O(IBINS("S",IBX)) Q:'IBX  D  Q:IBRES>1
 . S IBT=0 F  S IBT=$O(IBINS("S",IBX,IBT)) Q:'IBT  D  Q:IBRES>1
 . . N IBPL
 . . S IBPL=+$P($G(IBINS(IBT,0)),U,18) Q:'IBPL
 . . I '$$PLCOV^IBCNSU3(IBPL,IBADT,IBCAT) Q
 . . S IBRES=IBRES+1
 ;
 Q (IBRES>1)
 ;
 ;Relocated from IBNCPDPU
NDC(X) ; Massage the NDC as it is stored in Pharmacy
 ;  Input:  X  --  The NDC as it is stored in Pharmacy
 ; Output:  X  --  The NDC in the format 5N 1"-" 4N 1"-" 2N
 ;
 I $G(X)="" S X="" G NDCQ
 ;
 N LEN,PCE,Y,Z
 ;
 S Z(1)=5,Z(2)=4,Z(3)=2
 S PCE=0 F  S PCE=$O(Z(PCE)) Q:'PCE  S LEN=Z(PCE) D
 .S Y=$P(X,"-",PCE)
 .I $L(Y)>LEN S Y=$E(Y,2,LEN+1)
 .I $L(+Y)<LEN S Y=$$FILL^IBNCPDPU(Y,LEN)
 .S $P(X,"-",PCE)=Y
 ;
NDCQ Q X
 ;
ERMSG(IBSTL) ; Inactive status reason
 N IBSTA,IBI,IBARR,IBTXT
 D STATAR^IBCNRU1(.IBARR)
 F IBI=1:1:$L(IBSTL,",")+1 S IBSTA=+$P(IBSTL,",",IBI) Q:"^100^200^300^400^"'[(U_IBSTA_U)
 S IBTXT=$G(IBARR(+IBSTA),"Plan is not active.")
 Q IBTXT
 ;
PAPERBIL(IBTRKRN) ; 'paper' bill in CT?
 N IBZ,IBIFN
 S IBZ=$G(^IBT(356,IBTRKRN,0)) I IBZ="" Q 0
 S IBIFN=+$P(IBZ,U,11) I 'IBIFN Q 0
 I $P($G(^DGCR(399,IBIFN,0)),U,13)=7 Q 0  ; cancelled
 I $P($G(^DGCR(399,IBIFN,"M1")),U,8)'="" Q 0  ; ecme bill
 Q 1
 ;IBNCPNB
