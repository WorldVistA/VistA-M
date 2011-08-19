ORCACT1 ;SLC/MKB-Act on orders cont ;7/29/97  08:26
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,27,56,48,86,92,116,149,215**;Dec 17, 1997
 ;
FLAG ; -- flag orders
 D EN("FL") Q
 ;
UNFLAG ; -- unflag orders
 D EN("UF") Q
 ;
COMMENT ; -- add ward comments to orders
 D EN("CM") Q
 ;
ALERT ; -- alert provider when results available
 D EN("AL") Q
 ;
UNHOLD ; -- release hold on orders - no longer in use
 Q  ; see UNHOLD^ORCACT instead
 ;
EN(ORACT) ; -- Actions that don't create orders
 ;    ORNMBR = #,#,...,# of selected orders
 ;    ORACT  = action to be taken
 ;
 ;    OREBUILD defined on return if Orders tab needs to be rebuilt
 ;
 N ORLK,ORI,NMBR,IDX,ORIFN,ORDITM,ORERR,ORQUIT
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("") Q:'ORNMBR
 D FREEZE^ORCMENU S VALMBCK="R" K OREBUILD
 F ORI=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",ORI) D:NMBR  Q:$D(ORQUIT)
 . S IDX=$G(^TMP("OR",$J,ORTAB,"IDX",NMBR)),ORIFN=$P(IDX,U)
 . Q:'ORIFN  S:'$P(ORIFN,";",2) ORIFN=+ORIFN_";1"
 . I '$D(^OR(100,+ORIFN,0)) W !,"This order has been deleted!" H 1 Q
 . S ORDITM=$$ORDITEM^ORCACT(ORIFN) D SUBHDR^ORCACT(ORDITM)
 . I '$$VALID^ORCACT0(ORIFN,ORACT,.ORERR) W !,ORERR H 1 Q
 . S ORLK=$$LOCK1^ORX2(+ORIFN) I 'ORLK W !,$P(ORLK,U,2) H 1 Q
 . D @ORACT,UNLK1^ORX2(+ORIFN)
ENQ Q
 ;
FL ; -- Flag order ORIFN
 D EN^ORCFLAG
 Q
 ;
UF ; -- Unflag order ORIFN
 D UN^ORCFLAG
 Q
 ;
CM ; -- Ward Comments on order ORIFN
 N DIC,DWPK,DIWEPSE,DIWESUB,DDWRW
 S DIC="^OR(100,"_+ORIFN_",8,"_+$P(ORIFN,";",2)_",5,",(DWPK,DIWEPSE)=1
 S DIWESUB=ORDITM,DDWRW="B" ;go to bottom of text
 D EN^DIWE
 Q
 ;
AL ; -- Alert when results are available for order ORIFN
 S $P(^OR(100,+ORIFN,3),U,10)=1
 W !?10,"... done." H 1
 Q
 ;
RL ; -- Release hold on order ORIFN [No longer used]
 D EN^ORCSEND(+ORIFN,ORACT,3,1,,,.ORERR)
 W !,"... order "_$S($G(ORERR):"not ",1:"")_"released from hold."
 W:$L($P($G(ORERR),U,2)) !,"  >> "_$P(ORERR,U,2) H 1
 S OREBUILD=1 ; print?
 Q
 ;
VERIFY(ORVER) ; -- Verify orders
 N ORLK,ORI,NMBR,IDX,ORIFN,ORDITM,ORES,ORERR,ORSIG,OROLDSTS,ORNEW,ORWAIT
 I "^"[$G(ORVER) W $C(7),!!,"You must be a nurse or clerk to verify these orders!" S VALMBCK="" H 2 Q
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("") Q:'ORNMBR
 D FREEZE^ORCMENU S VALMBCK="R" K OREBUILD
 F ORI=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",ORI) D:NMBR  Q:$D(ORQUIT)
 . S IDX=$G(^TMP("OR",$J,ORTAB,"IDX",NMBR)),ORIFN=$P(IDX,U)
 . Q:'ORIFN  S:'$P(ORIFN,";",2) ORIFN=+ORIFN_";1" Q:$D(ORES(ORIFN))
 . I '$$VALID^ORCACT0(ORIFN,"VR",.ORERR) W !!,$$ORDITEM^ORCACT(ORIFN)_" invalid.",!,"  >> "_ORERR H 1 Q
 . S ORLK=$$LOCK1^ORX2(+ORIFN) I 'ORLK W !!,$$ORDITEM^ORCACT(ORIFN)_" invalid.",!,"  >> "_$P(ORLK,U,2) H 1 Q
 . S ORES(ORIFN)="" D REPLCD
VR1 Q:'$O(ORES(0))  D COMPLX S ORSIG=$S($$ESIG^ORCSIGN:1,1:0)
 I 'ORSIG W !,"Nothing verified!" D UNLOCK H 1 Q
 W !!,"Verifying orders ..."
 S ORIFN=0 F  S ORIFN=$O(ORES(ORIFN)) Q:ORIFN'>0  D
 . S OROLDSTS=+$P($G(^OR(100,+ORIFN,3)),U,3)
 . D EN^ORCSEND(ORIFN,"VR","","",,,.ORERR),UNLK1^ORX2(+ORIFN)
 . I $G(ORERR) D  Q
 . . W !,$$ORDITEM^ORCACT(ORIFN)_" not verified."
 . . W:$L($P($G(ORERR),U,2)) !,"  >> "_$P(ORERR,U,2) H 1
 . S ORNEW=+$P($G(^OR(100,+ORIFN,3)),U,3) I ORNEW'=OROLDSTS W !,$$ORDITEM^ORCACT(ORIFN)_" is now "_$$STS(ORNEW)_"." S ORWAIT=1
 S OREBUILD=1 D:'$D(XQAID) CKALERT I $G(ORWAIT) H 2
VRQ Q
 ;
STS(X) ; -- Return name of status X
 N Y S Y=$P($G(^ORD(100.01,+$G(X),0)),U)
 Q Y
 ;
REPLCD ; -- Ck for unverified replaced orders for ORIFN, add to ORES(order#)
 ;    [Expects ORVER; also called from VERIFY^ORWDXA,VERIFY^ORRCOR]
 N OR3,ORIG,ORFLD,ORDA,ORI,ORLK
 S ORFLD=$S($G(ORVER)="N":8,1:10),ORDA=+$P(ORIFN,";",2)
 I ORDA>1 D  Q  ;ck for prior unverified actions
 . ;Q:$P($G(^OR(100,+ORIFN,8,ORDA,0)),U,2)'="XX"
 . S ORI=0 F  S ORI=$O(^OR(100,+ORIFN,8,ORI)) Q:ORI<1  Q:ORI'<ORDA  D
 .. Q:$P($G(^OR(100,+ORIFN,8,ORI,0)),U,ORFLD)  ;already verified
 .. S ORLK=$$LOCK1^ORX2(+ORIFN) Q:'ORLK
 .. S ORES(+ORIFN_";"_ORI)=""
 S OR3=$G(^OR(100,+ORIFN,3)) Q:$P(OR3,U,11)'=1
 S ORIG=+$P(OR3,U,5) Q:'ORIG  Q:$P($G(^OR(100,ORIG,3)),U,3)'=12
 S ORDA=0 F  S ORDA=$O(^OR(100,ORIG,8,ORDA)) Q:ORDA'>0  I '$P($G(^(ORDA,0)),U,ORFLD) D
 . S ORLK=$$LOCK1^ORX2(ORIG) Q:'ORLK
 . S ORES(ORIG_";"_ORDA)=""
 Q
 ;
COMPLX ; -- Ck for other child orders to be verified at same time
 N IFN,DAD,CHLD,ALL,P,X,I
 S P=$S(ORVER="N":9,ORVER="C":11,ORVER="R":19,1:0) Q:P<1
 S IFN=0 F  S IFN=$O(ORES(IFN)) Q:IFN<1  D
 . S X=+$P($G(^OR(100,+IFN,0)),U,14) Q:$$NMSP^ORCD(X)'["PS"
 . S X=$P($G(^OR(100,+IFN,8,+$P(IFN,";",2),0)),U,2) Q:X'="NW"&(X'="XX")
 . I $P($G(^OR(100,+IFN,3)),U,9) S DAD(+$P(^(3),U,9))=""
 Q:'$O(DAD(0))  S IFN=0 F  S IFN=+$O(DAD(IFN)) Q:IFN<1  D
 . S CHLD=0,ALL=1
 . F  S CHLD=+$O(^OR(100,IFN,2,CHLD)) Q:CHLD<1  F X="NW","XX" D
 .. S I=+$O(^OR(100,CHLD,8,"C",X,0)) Q:I<1
 .. Q:$P($G(^OR(100,CHLD,8,I,0)),U,P)  Q:$D(ORES(CHLD_";"_I))
 .. S ORES(CHLD_";"_I)="",ALL=0
 . Q:ALL  S X=$$ORDITEM^ORCACT(IFN) D SUBHDR^ORCACT(X)
 . W !,"All doses of this complex order must be verified together;"
 . W !,"adding remaining doses to signature list..."
 Q
 ;
CKALERT ; -- Ck if Unverified Orders alerts can be deleted
 N ORNOW,ORBEG,ORLIST,ORALL,ORMEDS S ORNOW=$$NOW^XLFDT
 S:'$G(ORWARD) ORBEG=$$FMADD^XLFDT(ORNOW,"-30") I $G(ORWARD) D
 . N DFN,VAIN,VAERR S DFN=+ORVP D INP^VADPT
 . S ORBEG=$S($G(VAIN(7)):$P(VAIN(7),U),1:$$FMADD^XLFDT(ORNOW,-30))
 D EN^ORQ1(ORVP,,9,,ORBEG,ORNOW) ;see if any unverified orders remain
 I $G(ORLIST),$G(^TMP("ORR",$J,ORLIST,"TOT")) D  ;see if any are meds
 . N ORRX,ORGRP,I,IFN,DG S ORALL=1
 . S ORRX=+$O(^ORD(100.98,"B","RX",0)) D GRP^ORQ1(ORRX)
 . S I=0 F  S I=$O(^TMP("ORR",$J,ORLIST,I)) Q:I'>0  S IFN=+^(I),DG=+$P($G(^OR(100,IFN,0)),U,11) I $D(ORGRP(DG)) S ORMEDS=1 Q
 D:'$G(ORALL) DELALRT("UNVERIFIED ORDER")
 D:'$G(ORMEDS) DELALRT("UNVERIFIED MEDICATION ORDER")
 Q
 ;
DELALRT(X) ; -- delete alert X
 N ORNIFN,XQAKILL,XQAID
 S ORNIFN=+$O(^ORD(100.9,"B",X,0)) Q:ORNIFN'>0
 S XQAKILL=$$XQAKILL^ORB3F1(ORNIFN)
 S XQAID=$P($G(^ORD(100.9,ORNIFN,0)),U,2)_","_+ORVP_","_ORNIFN
 D DELETEA^XQALERT
 Q
 ;
UNLOCK ; -- Unlock orders in ORES(ORIFN) [from VR1]
 F  S ORIFN=$O(ORES(ORIFN)) Q:ORIFN'>0  D UNLK1^ORX2(+ORIFN)
 Q
 ;
SIGNREQD(IFN) ; -- Returns 2, 1, or 0, if order/actions need ES
 Q +$P($G(^OR(100,IFN,0)),U,16)
 ;
SIGN ; -- Sign orders [no longer used]
 D EN^ORCSIGN
 Q
 ;
COMPLETE ; -- complete orders
 N ORLK,ORI,NMBR,IDX,ORIFN,ORDITM,ORES,ORERR,ORSIG,ORSTOP
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("complete") Q:'ORNMBR
 D FREEZE^ORCMENU S VALMBCK="R" K OREBUILD
 F ORI=1:1:$L(ORNMBR) S NMBR=$P(ORNMBR,",",ORI) D:NMBR  Q:$D(ORQUIT)
 . S IDX=$G(^TMP("OR",$J,ORTAB,"IDX",NMBR)),ORIFN=$P(IDX,U)
 . Q:'ORIFN  S:'$P(ORIFN,";",2) ORIFN=+ORIFN_";1"
 . I '$$VALID^ORCACT0(ORIFN,"CP",.ORERR) W !!,$$ORDITEM^ORCACT(ORIFN)_" invalid.",!,"  >> "_ORERR H 1 Q
 . S ORLK=$$LOCK1^ORX2(+ORIFN) I 'ORLK W !!,$$ORDITEM^ORCACT(ORIFN)_" invalid.",!,"  >> "_$P(ORLK,U,2) H 1 Q
 . S ORES(ORIFN)=""
CP1 Q:'$O(ORES(0))  S ORSIG=$S($$ESIG^ORCSIGN:1,1:0)
 I 'ORSIG W !,"Nothing completed!" D UNLOCK H 1 Q
 W !!,"Completing orders ..." S ORSTOP=+$E($$NOW^XLFDT,1,12),ORIFN=0
 F  S ORIFN=$O(ORES(ORIFN)) Q:ORIFN'>0  D COMP^ORCSAVE2(ORIFN,DUZ,ORSTOP),UNLK1^ORX2(+ORIFN)
 S OREBUILD=1
CPQ Q
