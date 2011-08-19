IBCECOB2 ;ALB/CXW - IB COB MANAGEMENT SCREEN ;16-JUN-1999
 ;;2.0;INTEGRATED BILLING;**137,155,433**;21-MAR-1994;Build 36
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EDI ;history detail display
 N IBIFN,IBDA
 D SEL(.IBDA,1)
 S IBDA=+$O(IBDA(0)),IBIFN=+$G(IBDA(IBDA))
 D EDI1(IBIFN)
 S VALMBCK="R"
 Q
 ;
EDI1(IBIFN) ;
 N DFN
 Q:'IBIFN
 S DFN=$P($G(^DGCR(399,IBIFN,0)),U,2)
 D EN^VALM("IBJT EDI STATUS")
 K:$D(IBFASTXT) IBFASTXT
 Q
 ;
EDI2(IBIFN) ;
 N DFN
 Q:'IBIFN
 S DFN=$P($G(^DGCR(399,IBIFN,0)),U,2)
 D EN^VALM("IBJT EDI STATUS ALONE")
 K:$D(IBFASTXT) IBFASTXT
 Q
 ;
CSA ;claims status awaiting resolution
 N IBDAX
 D EN^IBCECSA
 I $D(IBFASTXT) K IBFASTXT
 S VALMBCK="R"
 Q
 ;
RVEOB ;Review EOB
 D FULL^VALM1 W !
 N IBDA,IBIFN,IBCMT,IBSEL
 D SEL(.IBDA,1)
 S IBSEL=+$O(IBDA(0))
 S IBDA=$G(IBDA(IBSEL))
 S IBIFN=$P(IBDA,U),IBDA=$P(IBDA,U,3)
 I 'IBIFN G VEOBQ
 S IBCMT=$G(^TMP("IBCECOB1",$J,IBSEL))
 I IBCMT'="" D EN^VALM("IBCEM MRA REVIEW")
VEOBQ K ^TMP("IBCECOC",$J)
 S VALMBCK="R"
 Q
 ;
TPJI ;Third Party joint Inquiry
 N IBDA,IBIFN
 D SEL(.IBDA,1)
 S IBDA=+$O(IBDA(0)),IBIFN=+$G(IBDA(IBDA))
 I IBDA="" G TPJIQ
 D TPJI1(IBIFN)
TPJIQ S VALMBCK="R"
 Q
 ;
TPJI1(IBIFN) ;
 N DFN,IBNOTPJI
 Q:'IBIFN
 S DFN=$P($G(^DGCR(399,IBIFN,0)),U,2),IBNOTPJI=1
 D EN^VALM("IBJT CLAIM INFO")
 K:$D(IBFASTXT) IBFASTXT
 Q
 ;
PBILL ;Print bill
 N IBIFN,IBDA,IBRESUB
 D SEL(.IBDA,1)
 S IBDA=$O(IBDA(0)),IBIFN=+$G(IBDA(+IBDA))
 I IBDA="" G PBOUT
 S IBRESUB=$$RESUB^IBCECSA4(IBIFN,1,"P")
 I IBRESUB'>0 W !,*7,"This is not a transmittable bill or review not needed" D PAUSE^VALM1 G PBOUT
 I IBRESUB=2 D  G PBOUT
 . N IB364
 . S IB364=+$P($G(IBDA(IBDA)),U,2)
 . D PRINT1^IBCEM03(IBIFN,.IBDA,IB364)
 D PBILL1(IBIFN)
PBOUT S VALMBCK="R"
 Q
 ;
PMRA ;Print MRA
 N IBIFN,IBDA
 D SEL(.IBDA,1)
 S IBDA=$O(IBDA(0)),IBIFN=+$G(IBDA(+IBDA))
 G:'IBIFN PRMQ
 D MRA^IBCEMRAA(.IBIFN)
PRMQ S VALMBCK="R"
 Q
PBILL1(IBIFN) ;
 N IBAC1,IBAC,DFN
 Q:'IBIFN
 S DFN=$P($G(^DGCR(399,IBIFN,0)),U,2)
 S IBAC=4,IBAC1=1
 D 4^IBCB1
 D FULL^VALM1,PAUSE^VALM1
 Q
 ;
CANCEL ;Cancel bill
 ; IBDA(IBDA)=IBIFN^IB364^ien of 361.1^user selection seq^user name~duz#
 ;
 N IBIFN,IBDA,IB364,IBEOBIFN
 ;
 ; Check for security key
 I '$$KCHK^XUSRB("IB AUTHORIZE") D  G CANCELQ
 . D FULL^VALM1 S VALMBCK="R"
 . W !!?5,"You don't hold the proper security key to access this function."
 . W !?5,"The necessary key is IB AUTHORIZE.  Please see your manager."
 . D PAUSE^VALM1
 . Q
 ;
 D SEL(.IBDA,1)
 S IBDA=$O(IBDA(0)),IBIFN=+$G(IBDA(+IBDA)),IB364=$P($G(IBDA(+IBDA)),U,2)
 S IBEOBIFN=$P($G(IBDA(+IBDA)),U,3)
 I IBDA D
 . I '$$LOCK^IBCEU0(361.1,IBEOBIFN) Q
 . D CANCEL^IBCEM3(.IBDA,IBIFN,IB364)
 . D UNLOCK^IBCEU0(361.1,IBEOBIFN)
 S VALMBCK="R"
 I $G(IBDA)'="" D BLD^IBCECOB1
CANCELQ Q
 ;
CRD ; Correct Rejected/Denied claim protocol action
 N IBCNCRD
 S IBCNCRD=1
CLONE ; 'Copy/cancel bill' protocol action
 N IBDA,IBQ,IBEOBIFN,IBKEY
 ;
 ; Check for security key
 ;I '$$KCHK^XUSRB("IB AUTHORIZE") D  G CLONEQ
 S IBKEY=$S($G(IBCNCRD)=1:"IB AUTHORIZE",1:"IB CLON")
 I '$$KCHK^XUSRB(IBKEY) D  G CLONEQ
 . D FULL^VALM1 S VALMBCK="R"
 . ;W !!?5,"You don't hold the proper security key to access this function."
 . ;W !?5,"The necessary key is IB AUTHORIZE.  Please see your manager."
 . W !!?5,"You must hold the "_IBKEY_" security key to access this function."
 . W !?5,"Please see your manager."
 . D PAUSE^VALM1
 . Q
 ;
 D SEL(.IBDA,1)
 S IBDA=$O(IBDA(""))
 I IBDA="" G CLONEQ
 S IBEOBIFN=$P($G(IBDA(+IBDA)),U,3)
 I '$$LOCK^IBCEU0(361.1,IBEOBIFN) G CLONEQ
 D COPYCLON(+$G(IBDA(IBDA)),$P($G(IBDA(+IBDA)),U,2),.IBQ)
 D UNLOCK^IBCEU0(361.1,IBEOBIFN)
CLONEQ ;
 S VALMBCK="R"
 D:$G(IBQ)'="" BLD^IBCECOB1
 Q
 ;
COPYCLON(IBIFN,IB364,IBQ) ; Generic entry point for clone a bill from EDI processing
 ; IBIFN = original bill ien
 ; IB364 = the ien of the transmission bill entry in file 364
 ; IBQ = If bill is not cancelled, this is returned as null
 ;        - pass by reference -
 ;
 N IBQUIT,IBCCCC,IBHV,Y,IBCAN,IBCE,IBDA,IBCNCOPY
 ;I '$$CANCKS^IBCEM3("CC",IBIFN) S IBQ="" G CCQ
 I $G(IBCNCRD)'=1,'$$CANCKS^IBCEM3("CC",IBIFN) S IBQ="" G CCQ
 ;
 ;S IBCAN=2,IBCE("EDI")=1,Y=IBIFN,IBCCCC=0,IBHV("IBIFN")=IBIFN,IBHV("IBIFN1")="",IBCNCOPY=1
 S IBCAN=2,IBCE("EDI")=1,Y=IBIFN,IBCCCC=0,IBHV("IBIFN")=IBIFN,IBHV("IBIFN1")=""
 I $G(IBCNCRD)'=1 S IBCNCOPY=1 D ^IBCCC
 I $G(IBCNCRD)=1 D CRD^IBCCC
 ;D ^IBCCC
 S IBIFN=IBHV("IBIFN")
 K IBCE("EDI") S IBQ=1
 I $P($G(^DGCR(399,IBIFN,0)),U,13)'=7 S IBQ=""
 I IBHV("IBIFN1") D
 . N IBU
 . S IBU="R"
 . S IBNIEN=+IBHV("IBIFN1")
 . I "23"'[$P($G(^DGCR(399,+IBHV("IBIFN1"),0)),U,13) D
 .. W:'$G(IBCEAUTO) !,*7,"Please note: the new bill was not AUTHORIZED.",!,"It can only be accessed now via the normal, non-EDI functions.",!,"Status of new bill is ",$$EXPAND^IBTRE(399,.13,$P(^DGCR(399,IBHV("IBIFN1"),0),U,13)) S IBU="C"
 . D UPDEDI^IBCEM(IB364,IBU)
 ;
 I '$G(IBCEAUTO) D PAUSE^VALM1
CCQ Q
 ;
PRO ; Copy for secondary/tertiary bill
 N VALMY,IBDA,Z,IBIFN,IBIFNH,IB364,IBCE
 I '$P($G(^IBE(350.9,1,8)),U,12) D  G PROQ
 . D FULL^VALM1
 . W !!?5,"MRA's may not be processed at this time."
 . W !?5,"The IB site parameter ""Allow MRA Processing?"" is set to NO."
 . D PAUSE^VALM1
 . Q
 D SEL(.IBDA,1)
 S Z=$O(IBDA(0)),Z=$G(IBDA(+Z)) G:'Z PROQ
 S IBIFN=$P(Z,U),IB364=$P(Z,U,2),IBDA=$P(Z,U,3),IBIFNH=IBIFN
 I 'IBIFN G PROQ
 I '$$LOCK^IBCEU0(361.1,IBDA) G PROQ
 D COBCOPY(IBIFN,IB364,2,IBDA,"BLD^IBCECOB1")
 D UNLOCK^IBCEU0(361.1,IBDA)
PROQ S VALMBCK="R"
 Q
 ;
COBCOPY(IBIFN,IB364,IBFROM,IBIEN,IBBLD) ; Generic entry point for EDI COB copy
 ; IBIFN = original bill ien
 ; IB364 = the ien of the transmission bill entry in file 364
 ; IBFROM = 1 if called from CSA, 2 if called from COB/EOB processing
 ; IBIEN = entry in 361 (IBFROM=1) or 361.1 (IBFROM=2) being processed
 ; IBBLD = the name of the entrypoint that will rebuild the display
 ;
 N IBCBASK,IBCBCOPY,IBCAN,IBIFNH,IBNSTAT,IBOSTAT,IBPRCOB,IBSECHK,IBLMVAR,IBAC,IBMRAIEN,IBDA,IBAUTO
 N IBCOB,IBCOBIL,IBCOBN,IBINS,IBINSN,IBINSOLD,IBMRAIO,IBMRAO,IBNMOLD,IBQUIT
 S (IBCBASK,IBCBCOPY,IBCAN,IBAUTO)=1,(IBPRCOB,IBSECHK)=0,(IBMRAIEN,IBDA)=IBIEN
 I 'IB364!'IBIFN W !,"Transmission record is missing for this bill" D PAUSE^VALM1 G COBCOPX
 ;
 S IBIFNH=IBIFN
 I IBFROM=2 S IBPRCOB=1
 ;
 I $$PREOBTOT^IBCEU0(IBIFN)'>0 D  G COBCOPX
 . D FULL^VALM1
 . W !!?5,"There is no patient responsibility for this claim."
 . W !?5,"This claim may not be processed."
 . D PAUSE^VALM1
 . Q
 ;
 I $P($G(^IBM(361.1,IBDA,0)),U,16)="1.5" D  G COBCOPX
 . W !!,"This claim has already been processed as a secondary claim."
 . W !,"You will need to complete the authorization process for this claim."
 . D PAUSE^VALM1
 . D AUTH
 . Q
 ;
 ; Get out if no next payer
 I '$P($G(^DGCR(399,IBIFN,"I"_($$COBN^IBCEF(IBIFN)+1))),U,1) D  G COBCOPX
 . W !,"There is no next payer for this bill"
 . D PAUSE^VALM1
 . Q
 ;
 D DSPRB^IBCCCB0(IBIFN)        ; display related bills
 S IBCE("EDI")=1
 D CHKB^IBCCCB                 ; process COB, create secondary bill
 S IBIFN=IBIFNH
 I IBSECHK G COBCOPX
 S IBV=1 D VIEW^IBCB2          ; display billing screens
 D AUTH                        ; authorize bill
COBCOPX ;
 Q
 ;
AUTH ; procedure to authorize the claim and refresh the screen
 K ^UTILITY($J) S IBAC=1,IBQUIT=0 D 3^IBCB1
 I '$D(IOUON)!'$D(IORVON) D ENS^%ZISS
 I $P($G(^IBM(361.1,IBMRAIEN,0)),U,16)=3 D UPDEDI^IBCEM(IB364,"Z")
 I $G(IBBLD)'="" D @IBBLD
 D PAUSE^VALM1
AUTHX ;
 Q
 ;
RES ;Resubmit bill by print
 N IBDA,IBIFN,IB364
 D SEL(.IBDA,1)
 S IBDA=+$O(IBDA(0)),IBIFN=+$G(IBDA(+IBDA)),IB364=+$P($G(IBDA(IBDA)),U,2)
 I 'IBIFN G RESQ
 D PRINT1^IBCEM03(IBIFN,.IBDA,IB364)
 D PAUSE^VALM1
 I $G(IBDA)'="" D BLD^IBCECOB1
RESQ S VALMBCK="R"
 Q
 ;
EBI ;View an unauthorized transmitted bill
 N IBFLG,IBDA,IBIFN,IB364,DFN
 K ^TMP($J,"IBBILL")
 D FULL^VALM1
 ;
 D SEL(.IBDA,1)
 S IBDA=+$O(IBDA(""))
 S IBIFN=+$G(IBDA(IBDA)),IB364=+$P($G(IBDA(IBDA)),U,2),DFN=$P($G(^DGCR(399,IBIFN,0)),U,2)
 G:'IBIFN EDITQ
 S IBV=1 D VIEW^IBCB2
 I '$D(IOUON)!'$D(IORVON) D ENS^%ZISS
 D BLD^IBCECOB1
EDITQ S VALMBCK="R"
 Q
 ;
SEL(IBDA,ONE) ; Select entry(s) from list
 ; IBDA = array returned if selections made
 ;    IBDA(n)=ien of bill selected (file 399)
 ; ONE = if set to 1, only one selection can be made at a time
 N IB
 K IBDA
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))
 S IBDA=0 F  S IBDA=$O(VALMY(IBDA)) Q:'IBDA  S IBDA(IBDA)=$P($G(^TMP("IBCECOB",$J,+IBDA)),U,2,6)
 Q
 ;
EXIT ; Exit out of COB
 D FASTEXIT^IBCEFG4
 I $G(IBFASTXT)=1 S IBFASTXT=5
 Q
 ;
