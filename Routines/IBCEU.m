IBCEU ;ALB/TMP - EDI UTILITIES ;02-OCT-96
 ;;2.0;INTEGRATED BILLING;**51,137,207,232,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; DBIA SUPPORTED REF: GET^XUA4A72 = 1625
 ; DBIA SUPPORTED REF: $$ESBLOCK^XUSESIG1 = 1557
 ;
TESTPT(DFN) ; Determine if pt is test pt
 ; Returns 1 if a test pt, 0 if not
 Q $E($P($G(^DPT(+DFN,0)),U,9),1,5)="00000"
 ;
MAINPRV(IBIFN) ; Returns name^id^ien^type code of 'main' prov on bill IBIFN
 N IBPRV,IBCOB,IBQ,Z
 D GETPRV(IBIFN,"3,4",.IBPRV)
 S IBQ="",IBCOB=$$COBN^IBCEF(IBIFN)
 F Z=3,4 I $G(IBPRV(Z,1))'="" D  Q
 . S IBQ=IBPRV(Z,1),$P(IBQ,U,4)=Z
 . I $G(IBPRV(Z,1,IBCOB))'="" S $P(IBQ,U,2)=IBPRV(Z,1,IBCOB)
 Q IBQ
 ;
PRVOK(VAL,IBIFN) ; Check bill form & prov function agree
 ; VAL = internal value of prov function
 ;
 ; OTHER(9) valid on institutional (UB-04) bills
 ; REFERRING(1) valid only on professional (1500) claims
 ; Valid functions by bill types
 ;  OUTPATIENT/UB-04: ATTENDING(4), OPERATING(2)-BILL TYPE 83X
 ;                     AND A PRIN. PROC EXISTS
 ;  INPATIENT/UB-04 : ATTENDING(4), OPERATING(2)-BILL TYPE 11X
 ;                     AND A PRIN. PROC EXISTS
 ;  OUTPATIENT/CMS-1500 : RENDERING(3), SUPERVISING(5)
 ;  INPATIENT/CMS-1500  : RENDERING(3), SUPERVISING(5)
 ;
 N OK,IBUB
 S VAL=$$UP^XLFSTR(VAL)
 S OK=$S(VAL'="":1,1:0)
 G:'OK!'$G(IBIFN) PRVQ
 ;
 S IBUB=($$FT^IBCEF(IBIFN)=3) ; 1 if UB-04 ; 0 if CMS-1500
 ;
 I VAL=1 S:IBUB OK=0 G PRVQ
 ;
 I "249"[VAL,'IBUB S OK=0 G PRVQ
 I $S(VAL=3:1,1:VAL=5),IBUB S OK=0 G PRVQ
 ;
PRVQ Q OK
 ;
PRVOK1(VAL,IBIFN) ; Check for both attending and rendering on bill
 N OK
 S OK=1
 I $S("34"'[VAL:0,1:$D(^DGCR(399,IBIFN,"PRV","B",$S(VAL=3:4,1:3)))) D EN^DDIOL($S(VAL=3:"ATTENDING",1:"RENDERING")_" ALREADY EXISTS - CAN'T HAVE BOTH ON ONE BILL") S OK=0
 Q OK
 ;
SPEC(IBPRV,IBDT) ; Returns spec code for vp ien IBPRV from file 355.9
 ;  (for new person entries, as of date in IBDT)
 ; DBIA 1625
 N IBSPEC
 S:'$G(IBDT) IBDT=DT
 I IBPRV'["IBA(355.93" S IBSPEC=$S(IBPRV:$P($$GET^XUA4A72(+IBPRV,IBDT),U,8),1:"") ; VA
 I IBPRV["IBA(355.93" S IBSPEC=$P($G(^IBA(355.93,+IBPRV,0)),U,4) ; Non-VA
 Q IBSPEC
 ;
CRED(IBPRV,IBIFN,IBPIEN,IBTYP) ; Returns prov credentials
 ; IBPRV = vp of provider for file 200 or 355.93
 ; IBIFN = bill ien in file 399 (optional)
 ; IBPIEN = prov ien - file 399.0222 (optional)
 ; IBTYP = the prov type
 ;
 N IBCRED
 S IBCRED=""
 I $G(IBIFN),'$D(^DGCR(399,IBIFN,"PRV",0)) G CREDQ
 I $G(IBIFN),($G(IBPIEN)!$G(IBTYP)) D
 . I '$G(IBPIEN) S IBPIEN=+$O(^DGCR(399,IBIFN,"PRV","B",IBTYP,0))
 . S IBCRED=$P($G(^DGCR(399,IBIFN,"PRV",IBPIEN,0)),U,3)
 I $G(IBPRV),IBCRED="" D
 . I IBPRV'["IBA(355.93" S IBCRED=$P($$ESBLOCK^XUSESIG1(+IBPRV),U,2)
 . I IBPRV["IBA(355.93" S IBCRED=$P($G(^IBA(355.93,+IBPRV,0)),U,3)
CREDQ Q IBCRED
 ;
GETPRV(IBIFN,IBTYP,IBPRV) ; Returns prov(s) of type(s) IBTYP for
 ;  bill ien IBIFN.
 ;  IBTYP = prov types needed, separated by ',' or ALL
 ; 
 ; OUTPUT:
 ;  IBPRV array: IBPRV(type)= 1 if prov is from old prov flds
 ;               IBPRV(type,ct)=name^current COB id^vp provider ien^cred
 ;               IBPRV(type,ct,seq)=COB seq specific id
 ;               IBPRV(type)=default nm^def id
 ;               IBPRV(type,"NOTOPT")= defined if a required prov type
 ;
 N IB,IBCT,IBD,IBY,IBZ,IBMRAND,IBID,IBWNR,IBPNM,Z ;,IBZFID
 ;S IBZFID=""
 D F^IBCEF("N-CURRENT INS POLICY TYPE","IBZ",,IBIFN)
 ;I IBZ="CI" D F^IBCEF("N-FEDERAL TAX ID","IBZFID",,IBIFN) S IBZFID=$TR(IBZFID,"-")
 S IBPRV=U_$G(IBZ),IBY=0
 S IBMRAND=$$MCRONBIL^IBEFUNC(IBIFN)
 I IBMRAND D
 . F Z=1:1:3,5,6,7,8,9 S:Z=3&($$FT^IBCEF(IBIFN)=3) Z=4 S IBPRV(Z)=$S(Z=3!(Z=4):"DEPT VETERANS AFFAIRS",1:"")_"^VAD000"
 . I '$$INPAT^IBCEF(IBIFN,1),$$FT^IBCEF(IBIFN)=3 S IBPRV(4,1)="^SLF000"
 ;
 I '$D(^DGCR(399,+IBIFN,"PRV",0)) D  G GETQ
 . N IBALL
 . S IBALL=(IBTYP="ALL")
 . I IBTYP[4!IBALL S:$P($G(^DGCR(399,+IBIFN,"U1")),U,13)'="" IBPRV(4,1)=$P(^("U1"),U,13),IBPRV(4)=1 Q:IBTYP=4
 . I IBTYP[3!IBALL S:$P($G(^DGCR(399,+IBIFN,"UF2")),U)'="" IBPRV(3,1)=$P(^("UF2"),U),IBPRV(3)=1 Q:IBTYP=3
 . I IBTYP[9!IBALL S:$P($G(^DGCR(399,+IBIFN,"U1")),U,14)'="" IBPRV(9,1)=$P(^("U1"),U,14),IBPRV(9)=1
 ;
 S IBID=4+$$COBN^IBCEF(IBIFN),IBWNR=$$WNRBILL^IBEFUNC(IBIFN)
 F IBZ=1:1:$S(IBTYP="ALL":99,1:$L(IBTYP,",")) S (IBCT,IB)=0,IBY=$S(IBTYP'="ALL":$P(IBTYP,",",IBZ),1:$O(^DGCR(399,+IBIFN,"PRV","B",IBY))) Q:IBY=""  F  S IB=$O(^DGCR(399,+IBIFN,"PRV","B",IBY,IB)) Q:'IB  D
 . S IBCT=IBCT+1
 . S IBD=$G(^DGCR(399,+IBIFN,"PRV",IB,0))
 . Q:'$P(IBD,U,2)
 . S IBPNM=$$EXPAND^IBTRE(399.0222,.02,$P(IBD,U,2))
 . I IBWNR Q:'$D(IBPRV(IBY))  S $P(IBD,U,IBID)=$P(IBPRV(IBY),U,2)
 . S IBPRV(IBY,IBCT)=IBPNM_U_$S($P(IBD,U,IBID)'="":$P(IBD,U,IBID),$P($G(IBPRV(IBY)),U,2)'="":$P(IBPRV(IBY),U,2),1:$P($$DEFID^IBCEF74(IBIFN,IB),U,IBID-4))_U_$P(IBD,U,2)
 . S $P(IBPRV(IBY,IBCT),U,4)=$$CRED($P(IBPRV(IBY,IBCT),U,3),IBIFN,$S($P(IBD,U,3)'=""!'$P(IBPRV(IBY,IBCT),U,3):IB,1:""))
 . F Z=1:1:3 D
 .. ;I IBZFID'="",'$$INPAT^IBCEF(IBIFN,1),$P(IBPRV(IBY,IBCT),U,2)="SLF000" S IBZFID=""
 .. ;I $S(Z=1:1,1:$D(^DGCR(399,IBIFN,"I"_Z))) S IBPRV(IBY,IBCT,Z)=$S($G(IBZFID)'="":IBZFID,$P(IBD,U,Z+4)'="":$P(IBD,U,Z+4),1:"")
 .. I $S(Z=1:1,1:$D(^DGCR(399,IBIFN,"I"_Z))) S IBPRV(IBY,IBCT,Z)=$S($P(IBD,U,Z+4)'="":$P(IBD,U,Z+4),1:$P($$DEFID^IBCEF74(IBIFN,IB),U,Z))
GETQ D NEEDPRV(IBIFN,IBTYP,.IBPRV)
 Q
 ;
NEEDPRV(IBIFN,IBTYP,IBPRV) ; Check for needed prov
 ; If needed, not entered, insert defaults for MCR only
 N IB0,IBINP,IBFT,IBMRAND,IBTOB
 S IB0=$G(^DGCR(399,+IBIFN,0))
 S IBFT=($$FT^IBCEF(IBIFN)=3),IBINP=$$INPAT^IBCEF(IBIFN,1),IBTOB=$$TOB^IBCBB(IB0)
 ; Only allow defaults for MCR
 S IBMRAND=$$WNRBILL^IBEFUNC(IBIFN) ;$$MCRONBIL^IBEFUNC(IBIFN)
 ;
 I IBTYP="ALL"!((IBTYP_",")["2,") D:IBFT
 . ; only for bill type inpt - 11X, outpt - 83X
 . Q:$S(IBINP:$E(IBTOB,1,2)'="11",1:$E(IBTOB,1,2)'="83")
 . ; UB-04 bill includes HCPCS procs - operating phys required
 . N Z
 . S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"CP",Z)) Q:'Z  I $P($G(^(Z,0)),U)["ICP" D  Q
 .. S IBPRV(2,"NOTOPT")=1
 .. Q:'IBMRAND
 .. I '$O(IBPRV(2,0)) S IBPRV(2,"REQ")=1,IBPRV(2,1)=$G(IBPRV(2))
 ;
 I IBTYP="ALL"!((IBTYP_",")["3,") D:'IBFT
 . ; if a CMS-1500 bill, rendering is required
 . S IBPRV(3,"NOTOPT")=1
 . Q:'IBMRAND
 . I '$O(IBPRV(3,0)) S IBPRV(3,1)=$G(IBPRV(3)),IBPRV(3,"REQ")=1
 ;
 I IBTYP="ALL"!((IBTYP_",")["4,") D:IBFT
 . ; if a UB-04, attending required
 . S IBPRV(4,"NOTOPT")=1
 . Q:'IBMRAND
 . I '$O(IBPRV(4,0)) S IBPRV(4,1)=$G(IBPRV(4)),IBPRV(4,"REQ")=1
 Q
 ;
CKPROV(IBIFN,IBTYP,IBVAL) ; Checks if prov of type IBTYP in 'PRV' node
 ; of bill IBIFN
 ; If IBVAL = 1, skips the check for an existing provider, just looks
 ;               for existence of the function itself
 N OK,IBFT,Z,R
 S OK=0,IBFT=$$FT^IBCEF(IBIFN)
 S Z=+$O(^DGCR(399,IBIFN,"PRV","B",+IBTYP,0))
 I $G(^DGCR(399,IBIFN,"PRV",Z,0))'="" D
 . ; Only outpt UB-04 can have SLF000 as prov ID with no name
 . I IBFT=3,'$$INPAT^IBCEF(IBIFN,1),$P(^DGCR(399,IBIFN,"PRV",Z,0),U,2)="",$P(^(0),U,5)="SLF000" S OK=1 Q
 . I '$G(IBVAL) Q:$P(^DGCR(399,IBIFN,"PRV",Z,0),U,2)=""
 . S OK=1
 Q OK
 ;
XFER(IBQ) ; Transfer DILIST
 ; IBQ = # of entries already found
 N Z,IBZ
 S (Z,IBZ)=0
 F  S Z=$O(^TMP("DILIST",$J,1,Z)) Q:'Z  S IBZ=IBZ+1,^TMP("IBLIST",$J,1,IBZ+IBQ)=^TMP("DILIST",$J,1,Z),^TMP("IBLIST",$J,2,IBZ+IBQ)=^TMP("DILIST",$J,2,Z) M ^TMP("IBLIST",$J,"ID",IBZ+IBQ)=^TMP("DILIST",$J,"ID",Z)
 ;
 I $D(^TMP("DILIST",$J,0)) S ^TMP("IBLIST",$J,0)=^TMP("DILIST",$J,0)
 S $P(^TMP("IBLIST",$J,0),U)=IBQ+IBZ
 Q
 ;
DATE(X) ; Convert date X in YYYYMMDD or YYMMDD to FM format
 ; FP = flag to indicate if past or future dates are expected
 N %DT,Y
 I $L(X)=8,$E(X,1,4)<2100,$E(X,5,6)<13,$E(X,7,8)<32 S X=$E(X,1,4)-1700_$E(X,5,8) G DTQ
 I $L(X)=6,$E(X,3,4)<13,$E(X,5,6)<32 S X=$E(X,3,4)_"/"_$E(X,5,6)_"/"_$E(X,1,2),%DT="N" D ^%DT I Y>0 S X=Y
DTQ Q X
 ;
BCLASS(IBIFN) ; Returns actual bill classif. code from ptr fld
 ;  .25 in file 399 for bill ien IBIFN
 Q $P($G(^DGCR(399.1,+$P($G(^DGCR(399,IBIFN,0)),U,25),0)),U,2)
 ;
ADMHR(IBIFN,IBDTTM) ; Extract admit hr from admit dt/tm
 ;  Default 00 if no time and bill is 11X or 18X
 N TM
 S TM=$P(IBDTTM,".",2)
 I TM="","18"[$$BCLASS(IBIFN),$P($G(^DGCR(399,IBIFN,0)),U,24)=1 S TM="00"
 I TM'="",TM'="00" S TM=$E(TM_"0000",1,4)
 Q TM
 ;
OLAB(IBIFN) ; Returns 1 if bill IBIFN is outside lab
 N IBL,IBLAB
 S IBL=0
 S IBLAB=$P($G(^DGCR(399,IBIFN,"U2")),U,11)
 I IBLAB,"24"[IBLAB S IBL=1
 Q IBL
 ;
PSRV(IBIFN) ; Returns 1 if bill IBIFN has any purch services
 N IBZ,IBXDATA,IBXSAVE,Z
 S IBZ=0
 D F^IBCEF("N-HCFA 1500 PROCEDURES",,,IBIFN)
 S Z=0 F  S Z=$O(IBXSAVE("BOX24",Z)) Q:'Z  I $P(IBXSAVE("BOX24",Z),U,11) S IBZ=1 Q
 Q IBZ
 ;
SEQBILL(IBIFN) ; Returns the ien's of all bills in COB sequence for bill IBIFN
 ; Return value is "^" delimited: primary ien^secondary ien^tertiary ien
 N IBSEQ,Z
 S IBSEQ=$P($G(^DGCR(399,IBIFN,"M1")),U,5,7)
 S Z=$$COBN^IBCEF(IBIFN)
 I $P(IBSEQ,U,Z)="" S $P(IBSEQ,U,Z)=IBIFN
 Q IBSEQ
 ;
