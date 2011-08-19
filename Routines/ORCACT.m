ORCACT ; SLC/MKB - Act on orders ;4/2/02  16:41
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,48,92,94,141**;Dec 17, 1997
ADD ; -- add new order via NW on pkg results tab
 ;    Requires ORDIALOG = name of pkg dialog
 N ORPTLK,OREVENT,X S VALMBCK="" G:'$L($G(ORDIALOG)) ADQ
 S ORPTLK=$$LOCK^ORX2(+ORVP) I 'ORPTLK W !!,$C(7),$P(ORPTLK,U,2) H 2 Q
 D FREEZE^ORCMENU S VALMBCK="R"
 I $G(ORTAB)'="COVER" S X=$$DELAY G:X="^" ADQ I X D  G:X="^" ADQ
 . S X=$$PTEVENT^OREVNT(+ORVP,1)
 . S:X'="^" OREVENT=+X
 S ORNP=$$PROVIDER^ORCMENU1 G:ORNP="^" ADQ
 S:'$G(ORL) ORL=$$LOCATION^ORCMENU1 G:ORL["^" ADQ
 S ORDIALOG=$O(^ORD(101.41,"AB",$E(ORDIALOG,1,63),0)) G:'ORDIALOG ADQ
 D ADD^ORCDLG,REBLD^ORCMENU:$D(^TMP("ORNEW",$J))
 K ORDIALOG,^TMP("ORWORD",$J),^TMP("ORECALL",$J) S VALMBCK="R"
ADQ S:$D(^TMP("OR",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 D:'$D(^TMP("ORNEW",$J)) UNLOCK^ORX2(+ORVP) ;unlock if no new orders
 Q
 ;
EDIT ; -- change orders
 D EN("XX") Q
 ;
RENEW ; -- renew orders
 D EN("RN") Q
 ;
REWRITE ; -- rewrite orders
 N OREVENT,X S X=$$DELAY Q:X="^"  I X D  Q:X="^"
 . S X=$$PTEVENT^OREVNT(+ORVP,1)
 . S:X'="^" OREVENT=+X
 D EN("RW") Q
 ;
HOLD ; -- hold orders
 D EN("HD") Q
 ;
UNHOLD ; -- release hold on orders
 D EN("RL") Q
 ;
EN(ORACT) ; -- start here with:
 ;    ORNMBR = #,#,...,# of selected orders
 ;    ORACT  = action to be taken on orders
 ;
 ;    OREBUILD defined on return if Orders tab needs to be rebuilt
 ;
 N ORI,NMBR,ORQUIT,ORIFN,ORIG,ORSIG,OREL,ORPTLK,ORLK,IDX,ORDITM,ORPRINT,ORERR,ORDER,ORSTS,ORPRNT,ORNOW,ORDG,ORXNP S VALMBCK=""
 S ORPTLK=$$LOCK^ORX2(+ORVP) I 'ORPTLK W !!,$C(7),$P(ORPTLK,U,2) H 2 Q
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("") G:'ORNMBR ENQ
 D FREEZE^ORCMENU S VALMBCK="R" K OREBUILD
 S ORNP=$$PROVIDER^ORCMENU1 G:ORNP="^" ENQ
 S:'$G(ORL) ORL=$$LOCATION^ORCMENU1 G:ORL="^" ENQ
EN1 F ORI=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",ORI) D:NMBR  Q:$D(ORQUIT)
 . S IDX=$G(^TMP("OR",$J,ORTAB,"IDX",NMBR))
 . S ORIFN=$S(ORTAB="MEDS":$P(IDX,U,4),1:$P(IDX,U)) Q:'ORIFN
 . I '$D(^OR(100,+ORIFN,0)) W !,"This order has been deleted!" H 2 Q
 . S:'$P(ORIFN,";",2) ORIFN=+ORIFN_";"_+$P($G(^OR(100,+ORIFN,3)),U,7)
 . S ORIG=+ORIFN,ORDITM=$$ORDITEM(ORIFN) D SUBHDR(ORDITM)
 . I '$$VALID^ORCACT0(ORIFN,ORACT,.ORERR) W !,ORERR H 2 Q
 . I $$NMSP^ORCD(+$P(^OR(100,+ORIFN,0),U,14))="PS" D PROVIDER^ORCDPSIV Q:$G(ORQUIT)
 . S ORLK=$S('$D(^TMP("ORNEW",$J,ORIG)):$$LOCK1^ORX2(ORIG),1:1) I 'ORLK W !,$P(ORLK,U,2) H 2 Q
 . D @(ORACT_"^ORCACT4") ;sets ^TMP("ORNEW",$J,ORIFN),[ORIFN]
 . D:'$O(^TMP("ORNEW",$J,ORIG,0)) UNLK1^ORX2(ORIG) ;unlk if not chngd
 S:$O(^TMP("ORNEW",$J,0)) OREBUILD=1
ENQ D:'$D(^TMP("ORNEW",$J)) UNLOCK^ORX2(+ORVP) ;unlock if no new orders
 S:$G(ORXNP) ORNP=ORXNP
 Q
 ;
ORDITEM(ID) ; -- Returns order text
 ;N X,I,MORE S X=""
 ;I $P(ID,";",2)>1 S I=$P($G(^OR(100,+ID,8,+$P(ID,";",2),0)),U,2),X=$S(I="DC":"Discontinue ",I="HD":"Hold ",1:"")
 ;S I=$O(^OR(100,+ID,1,0)) Q:'I "" S MORE=$O(^(I)),X=X_$G(^(I,0))
 ;I $L(X)>68 S MORE=1,X=$E(X,1,68)
 ;S:MORE X=X_" ..."
 N X,ORX D TEXT^ORQ12(.ORX,ID,68) S X=ORX(1)_$S(ORX>1:" ...",1:"")
 Q X
 ;
SUBHDR(X) ; -- Display subheader of order being acted on
 W !!,?(36-($L(X)\2)),"-- "_X_" --",!
 Q
 ;
DELAY() ; -- Delay release of orders?
 I '$D(^ORD(100.5,"C")) Q 0 ;no active events
 N X,Y,DIR S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Delay release of these orders? "
 S DIR("?")="Enter NO to release these orders immediately upon signature; YES will delay release of these orders until the specified patient movement occurs."
 D ^DIR S:$D(DTOUT)!$D(DUOUT) Y="^"
 Q Y
 ;
EX ; -- exit action
 I $G(OREBUILD) D  ;rebuild tabs
 . I $G(ORTAB)="ORDERS"!($G(ORTAB)="DELAY") D  Q
 .. N TAB D TAB^ORCHART(ORTAB,1)
 .. F TAB="MEDS","CONSULTS" S:$D(^TMP("OR",$J,TAB,0)) $P(^(0),U)=""
 . S:$D(^TMP("OR",$J,"ORDERS",0)) $P(^(0),U)="" ;rebld next time
 . D:$G(ORTAB)="NEW" INIT^ORCMENU2 ;when called from RV
 I $G(ORTAB)'="NEW",$D(^TMP("OR",$J,"CURRENT","MENU")) S XQORM("HIJACK")=^("MENU")
 Q
