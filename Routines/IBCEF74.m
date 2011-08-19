IBCEF74 ;WOIFO/SS - FORMATTER/EXTRACT BILL FUNCTIONS ;31-JUL-03
 ;;2.0;INTEGRATED BILLING;**232,280,155,290,291,320,358,343,374**;21-MAR-94;Build 16
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SORT(IBPRNUM,IBPRTYP,IB399,IBSRC,IBDST,IBN,IBEXC,IBSEQ,IBLIMIT) ;
 D SORT^IBCEF77($G(IBPRNUM),$G(IBPRTYP),$G(IB399),.IBSRC,.IBDST,$G(IBN),$G(IBEXC),$G(IBSEQ),$G(IBLIMIT))
 Q
 ;
 ;-- PROVINF --
 ;Create array with prov info
 ;Input:
 ; IB399 - ien #399
 ; IBPRNUM - 1=prim ins, 2= sec, 3 -tert
 ; IBRES - for results
 ; IBSORT - to sort OTHER INSURANCE data 
 ;  if PROVINF is called for "C" mode of PROVIDER subroutine then 
 ;    IBSORT can be any (say 1)
 ;  if PROVINF is called for "O" mode then can be more than set of data
 ;    - need to sort array to use it (like IBXDATA(1) and IBXDATA(2))
 ;    for mode "O" it should be 1 or 2 (see PROVIDER section)
 ;IBINSTP -  "C" -current ins, "O"-other
 ;Output:
 ; IBRES(PRNUM,PRTYPE,SEQ#)=PROV^INSUR^IDTYPE^ID^FORMTYP^CARETYP
 ; where:(see PROVIDER)
PROVINF(IB399,IBPRNUM,IBRES,IBSORT,IBINSTP) ;
 I $G(IB399)="" Q
 I +$G(IBSORT)=0 S IBSORT=$G(IBPRNUM)
 N IBPRTYP,IBINSCO,IBPROV,IBFRMTYP,IBCARE,IB35591,IBN,IBCURR,IBEXC,IBALLSSN,IBSSNIEN,IBLIMIT
 S IBN=0
 D F^IBCEF("N-ALL ATT/RENDERING PROV SSN","IBALLSSN",,IB399)
 S Q=0 F  S Q=$O(^IBE(355.97,Q)) Q:'Q  I $P($G(^(Q,0)),U,3)="SY" S IBSSNIEN=Q Q
 S IBINSCO=+$P($G(^DGCR(399,IB399,"M")),"^",IBPRNUM)
 S IBFRMTYP=$$FT^IBCEF(IB399),IBFRMTYP=$S(IBFRMTYP=2:2,IBFRMTYP=3:1,1:0)
 S IBCARE=$S($$ISRX^IBCEF1(IB399):3,1:0) ;if an Rx refill bill
 S:IBCARE=0 IBCARE=$$INPAT^IBCEF(IB399,1) S:'IBCARE IBCARE=2 ;1-inp,2-out
 S IBLIMIT=$S($G(IBINSTP)="C":5,1:3)  ; Limits on secondary IDs
 F IBPRTYP=1:1:9 D
 . N Z,IB355OV
 . S IBPROV=$$PROVPTR^IBCEF7(IB399,IBPRTYP)
 . Q:+IBPROV=0
 . ;don't create anything if form type not CMS-1500 or UB
 . Q:IBFRMTYP=0
 . N IBRETARR S IBRETARR=0
 . D PRACT^IBCEF71(IBINSCO,IBFRMTYP,IBCARE,IBPROV,.IBRETARR,IBPRTYP,$G(IBINSTP))
 . S IB355OV="",IBEXC=""
 . S Z=$O(^DGCR(399,IB399,"PRV","B",IBPRTYP,0))
 . I Z S Z=$G(^DGCR(399,IB399,"PRV",Z,0)) D
 .. I $P(Z,U,IBPRNUM+4)'="",$P(Z,U,IBPRNUM+11)'="" S IB355OV=$P(Z,U,IBPRNUM+4)_U_$P(Z,U,IBPRNUM+11)
 . S IBCURR=$$COB^IBCEF(IB399)
 . S IBN=0,IB35591=$$CH35591^IBCEF72(IBINSCO,IBFRMTYP,IBCARE)
 . I $G(IBINSTP)="C",$G(IBPRNUM)=1,"34"[$G(IBPRTYP),"P"[$G(IBCURR),$G(IBFRMTYP)=2,$$MCRONBIL^IBEFUNC(IB399) S IB355OV=$$MCR24K^IBCEU3(IB399)_"^12"
 . I $G(IBINSTP)="O","34"[$G(IBPRTYP),"ST"[$G(IBCURR),$G(IBFRMTYP)=2,$$MCRONBIL^IBEFUNC(IB399) S IB355OV=$$MCR24K^IBCEU3(IB399)_"^12" ;Calculate MEDICARE (WNR) specific provider qualifier and ID for CMS-1500 secondary claims
 . I $P(IB355OV,U,2) D
 .. I $$CHCKSEC^IBCEF73(IBFRMTYP,IBPRTYP,$G(IBINSTP),$P($G(^IBE(355.97,+$P(IB355OV,U,2),0)),U,3)) D
 ... S IBEXC=$P(IB355OV,U,2),IBN=IBN+1,IBRES(IBSORT,IBPRTYP,IBN)="OVERRIDE^"_IBINSCO_U_$P($G(^IBE(355.97,+IBEXC,0)),U,3)_U_$P(IB355OV,U)_"^^^^^"_+IBEXC
 . I IB35591'="",IBEXC'=$P(IB35591,U,3) S:$$CHCKSEC^IBCEF73(IBFRMTYP,IBPRTYP,$G(IBINSTP),$P(IB35591,"^")) IBN=IBN+1,IBRES(IBSORT,IBPRTYP,IBN)="DEFAULT^"_IBINSCO_"^"_IB35591_"^^",$P(IBRES(IBSORT,IBPRTYP,IBN),U,9)=$P(IB35591,U,3)
 . D SORT(IBSORT,IBPRTYP,IB399,.IBRETARR,.IBRES,IBN,IBEXC,IBPRNUM,IBLIMIT)
 . S IBRES(IBSORT,IBPRTYP)=IBPROV
 S IBRES(IBSORT)=$S(IBPRNUM=3:"T",IBPRNUM=2:"S",1:"P")
 Q
 ;
SECIDCK(IBIFN,IBSEQ,IBTYP,IBIFN1) ; Function returns 1 if ID type ptr in
 ;  IBTYP is valid X12 code for the claim/prov function (IBPROVF)
 ;  as a sec id
 ; IBSEQ = COB seq being checked
 ; IBIFN1 = entry # in PRV multiple being checked
 ;  Called from input transform of fields .12-.14, subfile 399.0222
 I $G(IBIFN)="" Q
 N IBOK,IBFRM,IBCOBN,IBX12,IBPROVF
 S IBPROVF=+$G(^DGCR(399,IBIFN,"PRV",IBIFN1,0))
 S IBFRM=$$FT^IBCEF(IBIFN),IBFRM=$S(IBFRM=3:1,1:2) ; Form type
 S IBCOBN=$$COBN^IBCEF(IBIFN) S:'IBCOBN IBCOBN=1 ; Current COB seq
 S IBX12=$P($G(^IBE(355.97,+IBTYP,0)),U,3) ; X12 code for prov id typ
 Q $$CHSEC^IBCEF73(IBFRM,IBPROVF,$S(IBSEQ=IBCOBN:"C",1:"O"),IBX12)
 ;
DEFID(IBIFN,IBPRV) ;
 ; IBIFN = ien of bill
 ; IBPRV = ien of entry subfile 399.0222
 ;  Function returns default ids: prim id def^sec id def^tert id def
 ;  SSN cannot be the default ID
 I $G(IBIFN)="" Q ""
 N Z,Z1,ID,IBZ,IBINS,IBINS4,IBUB
 S IBZ=""
 S IBUB=($$FT^IBCEF(IBIFN)=3)
 D F^IBCEF("N-ALL ATT/REND PROV SSN/EI","IBZ","",IBIFN)
 S Z=$G(^DGCR(399,IBIFN,"PRV",IBPRV,0)),ID=$P(Z,U,5,7)
 F Z1=1:1:3 I $P(ID,U,Z1)="" D
 . Q:'$G(^DGCR(399,IBIFN,"I"_Z1))  S IBINS=+^("I"_Z1)
 . S $P(ID,U,Z1)=$$GETID^IBCEP2(IBIFN,2,$P(Z,U,2),Z1)
 . ; Set default if null
 . I $P(ID,U,Z1)="" S $P(ID,U,Z1)="VAD000"
 Q ID
 ;
DISPID(IBXIEN) ; Display list of all prov and fac ids that will
 ; extract for this bill if transmitted electronically
 I $G(IBXIEN)="" Q
 N IBID,IBID1,IBZ,IBCT,IBFRM,IBCOBN,IBATT,IBQUIT,IBTYP,DIR,IBIFN,X,Y,Z,Z0,Z1
 N IBNPI,IBNONPI
 S IBIFN=IBXIEN
 S IBFRM=$$FT^IBCEF(IBIFN),IBCOBN=$$COBN^IBCEF(IBIFN),IBATT=$S(IBFRM=2:3,1:4)
 W @IOF
 W !,"If this bill is transmitted electronically, the following IDs will be sent:"
 ; Returns all prov sec ids to be transmitted in indicated segments
 S Z=+$G(^DGCR(399,IBIFN,"I1")) I Z W !,"  Primary Ins Co: ",$$EXTERNAL^DILFD(399,101,"",Z) I IBCOBN=1 W ?54,"<<<Current Ins"
 S Z=+$G(^DGCR(399,IBIFN,"I2")) I Z W !,"Secondary Ins Co: ",$$EXTERNAL^DILFD(399,101,"",Z) I IBCOBN=2 W ?54,"<<<Current Ins"
 S Z=+$G(^DGCR(399,IBIFN,"I3")) I Z W !," Tertiary Ins Co: ",$$EXTERNAL^DILFD(399,101,"",Z) I IBCOBN=3 W ?54,"<<<Current Ins"
 W !!,"Provider IDs: (VistA Records OP1,OP2,OP4,OP8,OP9,OPR2,OPR3,OPR4,OPR5,OPR8):"
 F Z=1:1:3 I $G(^DGCR(399,IBIFN,"I"_Z)) D PROVINF(IBIFN,Z,.IBID,"",$S(IBCOBN=Z:"C",1:"O"))
 S Z=0 F  S Z=$O(IBID(Z)) Q:'Z  S Z0=0 F  S Z0=$O(IBID(Z,Z0)) Q:'Z0  S IBID1(Z0,Z)="",Z1=0 F  S Z1=$O(IBID(Z,Z0,Z1)) Q:'Z1  I $P(IBID(Z,Z0,Z1),U,9) S IBID1(Z0,Z,Z1)=IBID(Z,Z0,Z1)
 ; PRXM/KJH - Add NPI to display for patch 343.
 S IBNPI=$$PROVNPI^IBCEF73A(IBIFN,.IBNONPI)
 S Z=+$O(^DGCR(399,IBIFN,"PRV","B",IBATT,0))
 I Z S Z=$P($G(^DGCR(399,IBIFN,"PRV",Z,0)),U,2)
 W !,?5,"ATTENDING/RENDERING: ",$$EXTERNAL^DILFD(399.0222,.02,"",Z)
 D F^IBCEF("N-ALL ATT/REND PROV SSN/EI","IBZ","",IBIFN)
 W !,?8,"NPI: ",?40,$S($P(IBNPI,U,IBATT)'="":$P(IBNPI,U,IBATT),1:"***MISSING***")
 W !,?8,"SSN: ",?40,$S($P(IBZ,U,IBATT)'="":$P(IBZ,U,IBATT),1:"***MISSING***")
 I $O(IBID1(IBATT,0)) W !,?8,"Secondary IDs"
 S IBQUIT=0
 ;
 ; Attending/Rendering (4/3) secondary IDs
 S Z0=0 F  S Z0=$O(IBID1(IBATT,Z0)) Q:'Z0!IBQUIT  K IBTYP S Z1=0 F  S Z1=$O(IBID1(IBATT,Z0,Z1)) Q:'Z1  D  Q:IBQUIT
 . Q:$D(IBTYP(+$P(IBID1(IBATT,Z0,Z1),U,9)))  ;1st of each type transmits
 . I ($Y+5)>IOSL S IBQUIT=$$NOMORE() Q:IBQUIT
 . S IBTYP(+$P(IBID1(IBATT,Z0,Z1),U,9))=""
 . W !,?8,"(",$E("PST",Z0),") ",$$EXTERNAL^DILFD(36,4.01,"",$P(IBID1(IBATT,Z0,Z1),U,9)),?40,$P(IBID1(IBATT,Z0,Z1),U,4)
 . Q
 I IBQUIT G DISPIDX
 ;
 ; Referring(1), Operating(2), Supervising(5), Other(9) secondary IDs
 ; PRXM/KJH - Patch 343. Modified first loop so it will always display provider and NPI and conditionally display other data.
 ; S Z=0 F  S Z=$O(IBID1(Z)) Q:'Z  I Z<3!(Z>4) D  Q:IBQUIT
 S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"PRV","B",Z)) Q:'Z  I Z<3!(Z>4) D  Q:IBQUIT
 . N Q
 . S Q=+$O(^DGCR(399,IBIFN,"PRV","B",Z,0))
 . W !!,?5,$$EXTERNAL^DILFD(399.0222,.01,"",Z),": "_$$EXTERNAL^DILFD(399.0222,.02,"",$P($G(^DGCR(399,IBIFN,"PRV",Q,0)),U,2))
 . W !,?8,"NPI: ",?40,$S($P(IBNPI,U,Z)'="":$P(IBNPI,U,Z),1:"***MISSING***")
 . S Z0=0 F  S Z0=$O(IBID1(Z,Z0)) Q:'Z0!IBQUIT  K IBTYP S Z1=0 F  S Z1=$O(IBID1(Z,Z0,Z1)) Q:'Z1!IBQUIT  D
 .. Q:$D(IBTYP(+$P(IBID1(Z,Z0,Z1),U,9)))  ; 1st of each type transmits
 .. I ($Y+5)>IOSL S IBQUIT=$$NOMORE() Q:IBQUIT
 .. S IBTYP(+$P(IBID1(Z,Z0,Z1),U,9))=""
 .. W !,?8,"(",$E("PST",Z0),") ",$$EXTERNAL^DILFD(36,4.01,"",$P(IBID1(Z,Z0,Z1),U,9)),?40,$P(IBID1(Z,Z0,Z1),U,4)
 .. Q
 . Q
 I IBQUIT G DISPIDX
 ;
 ; IB*2*320 - display additional IDs for ?ID
 D EN^IBCEF74A(IBIFN,.IBQUIT)
 ;
DISPIDX ;
 I '$G(IBQUIT) S DIR(0)="EA",DIR("A")="Press RETURN to continue " W ! D ^DIR K DIR
 Q
 ;
NOMORE() ;
 S DIR(0)="EA",DIR("A")="Press RETURN for more IDs or '^' to exit: " W ! D ^DIR
 W @IOF
 Q (Y'=1)
 ;
DEFSEC(IBIFN,IBARR) ; Returns array in IBARR for default prov sec ids for ien IBIFN
 ; IBARR if passed by ref is returned   IBARR(prov function,COBN)=def id
 I $G(IBIFN)=""
 N IBCAR,IBCOBN,IBPC,IBINS,IBARRX,Q,Z,Z0,ZINS,X
 K IBARR
 S ZINS="",IBCOBN=$$COBN^IBCEF(IBIFN),IBPC=$S($$FT^IBCEF(IBIFN)=3:2,1:1)
 S IBCAR=$$INPAT^IBCEF(IBIFN,1),IBCAR=$S('IBCAR:2,1:1)
 F Z=1:1:3 S ZINS=ZINS_+$G(^DGCR(399,IBIFN,"I"_Z))_U
 F Z=1:1:3 I $P(ZINS,U,Z),'$P($G(^DIC(36,+$P(ZINS,U,Z),4)),U,IBPC) S $P(ZINS,U,Z)=""
 S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"PRV",Z)) Q:'Z  S Z0=$G(^(Z,0)) D
 . F Q=1:1:3 D
 .. I $P(Z0,U,Q+4)'="" S IBARR(+Z0,Q)=$P(Z0,U,Q+4) Q  ; Override
 .. S IBINS=$P(ZINS,U,Q)
 .. Q:'IBINS
 .. S X=$$IDFIND^IBCEP2(IBIFN,"",$P(Z0,U,2),Q,1)
 .. I X'="" S IBARR(+Z0,Q)=X
 Q
 ;
