VPRSDAOR ;SLC/MKB -- SDA Order utilities ;7/29/22  14:11
 ;;1.0;VIRTUAL PATIENT RECORD;**30**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^OR(100                       5771
 ; ^ORD(100.98                   6982
 ; DIC                           2051
 ; DILFD                         2055
 ; DIQ                           2056
 ; ORQ1, ^TM("ORR",$J)           3154
 ;
 ;
ORDERS(DG) ; -- get orders by Display Group
 ; Query called from GET^DDE, returns DLIST(#)=ien
 ; Expects context variables DFN, DSTRT, DSTOP, DMAX
 ;
 N ORDG,ORIGVIEW,ORKID,ORLIST,VPRI,VPRN,ORDER,X3,X4
 S DG=$G(DG,"ALL"),ORDG=+$O(^ORD(100.98,"B",DG,0))
 ; return original view, child orders for Lab
 S ORIGVIEW=2,ORKID=$S(DG="CH":1,DG="LAB":1,1:0)
 D EN^ORQ1(DFN_";DPT(",ORDG,6,,DSTRT,DSTOP,,,,ORKID) S VPRN=0
 S VPRI=0 F  S VPRI=$O(^TMP("ORR",$J,ORLIST,VPRI)) Q:VPRI<1  S ORDER=$G(^(VPRI)) D  Q:VPRN'<DMAX
 . I $P($P(ORDER,U),";",2)>1 Q  ;skip order actions
 . I $O(^OR(100,+ORDER,2,0)) Q  ;skip parent orders
 . S ORDER=+ORDER,X3=$G(^OR(100,ORDER,3)),X4=$G(^(4))
 . Q:$P(X3,U,3)=13  I X4["P",$P(X3,U,3)=1!($P(X3,U,3)=12) Q  ;cancelled
 . Q:$P(X3,U,3)=14              ;lapsed
 . I DG="RX",'$$RX(ORDER) Q     ;skip non-PS in RX group
 . I DG="LAB",$$BB(ORDER) Q     ;skip blood bank in Lab
 . S VPRN=VPRN+1,DLIST(VPRN)=ORDER
 K ^TMP("ORR",$J)
 Q
RX(ORIFN) ; -- is order really a med? (non-PS order in display group)
 N X,Y,PKG S Y=0
 S X=$P($G(^OR(100,+$G(ORIFN),0)),U,14),PKG=$$GET1^DIQ(9.4,+X_",",1)
 I $E(PKG,1,2)="PS" S Y=1
 Q Y
BB(ORIFN) ; -- return 1 or 0, if order is for Blood Bank
 N X,Y,DG S Y=0
 S X=$P($G(^OR(100,+$G(ORIFN),0)),U,11),DG=$P($G(^ORD(100.98,+X,0)),U,3)
 I DG="BB"!(DG?1"VB".E) S Y=1
 Q Y
 ;
NONORD ; -- get other orders: not Lab, Rad, or Med
 ; Query called from GET^DDE, returns DLIST(#)=ien
 ; Expects context variables DFN, DSTRT, DSTOP, DMAX
 ;
 N ORDG,ORPKG,ORIGVIEW,ORLIST,VPRI,VPRN,ORDER,X
 S ORDG=+$O(^ORD(100.98,"B","ALL",0)) D ORPKG ;get list of pkgs to exclude
 S ORIGVIEW=2 ;get original view of order
 D EN^ORQ1(DFN_";DPT(",ORDG,6,,DSTRT,DSTOP) S VPRN=0
 S VPRI=0 F  S VPRI=$O(^TMP("ORR",$J,ORLIST,VPRI)) Q:VPRI<1  S ORDER=$G(^(VPRI)) D  Q:VPRN'<DMAX
 . I $P($P(ORDER,U),";",2)>1 Q         ;skip order actions
 . Q:$P($G(^OR(100,+ORDER,3)),U,3)=14  ;skip lapsed orders
 . S X=+$P($G(^OR(100,+ORDER,0)),U,14)
 . I $D(ORPKG(X)) Q                    ;skip Lab,Rad,Med
 . S VPRN=VPRN+1,DLIST(VPRN)=+ORDER
 K ^TMP("ORR",$J)
 Q
ORPKG ; -- get list of pkgs to exclude
 N NMSP,X
 F NMSP="LR","RA","PSG","PSIV","PSJ","PSO","PSH" D
 . S X=+$$FIND1^DIC(9.4,,"QX",NMSP,"C")
 . S:X>0 ORPKG(X)=""
 Q
 ;
OR1(ORIFN) ; -- define basic variables for any order [ID Action]
 ; Returns OR0, OR3, OR6, OR8, ORDAD, and ORSIG to Order entities
 S ORIFN=+$G(ORIFN)
 S OR0=$G(^OR(100,ORIFN,0)),OR3=$G(^(3)),OR6=$G(^(6)),OR8=$G(^(8,1,0))
 S ORDAD=$P($G(OR3),U,9) ;parent order
 S ORSIG=$$ORSIG(ORIFN)  ;signature info
 Q
 ;
WP(ORIFN,ID) ; -- return a WP value from an order response as a string
 N DA,I,X,Y S Y=""
 S DA=+$O(^OR(100,+$G(ORIFN),4.5,"ID",ID,0))
 S I=0 F  S I=$O(^OR(100,+$G(ORIFN),4.5,DA,2,I)) Q:'I  S X=$G(^(I,0)) D
 . I '$L(Y) Q:(X="")!(X?1." ")  S Y=X Q
 . I $E(X)=" " S Y=Y_$C(13,10)_X Q
 . S Y=Y_$S($E(Y,$L(Y))=" ":"",1:" ")_X
 Q Y
 ;
ORDG(DG) ; -- return ien^name^VA100.98 for a DG abbreviation
 N X,Y S X=$O(^ORD(100.98,"B",DG,0)),Y=""
 S:X Y=X_U_$P($G(^ORD(100.98,X,0)),U)_"^VA100.98"
 Q Y
 ;
LASTACT(ORIFN) ; -- return DA of current or last order action
 N Y S ORIFN=+$G(ORIFN)
 S Y=+$P($G(^OR(100,ORIFN,3)),U,7)
 I Y<1 S Y=+$O(^OR(100,ORIFN,8,"A"),-1) S:'Y Y=1
 Q Y
 ;
ORSIG(ORIFN) ; -- return string of signature data from Order Action as
 ; Signature Status (#4) ^ Signed By (#5) ^ D/T Signed (#6), or
 ; Signature Status (#4) ^ ^ Release D/T (#16) if not e-signed
 N Y,X0,X,I S Y=""
 S X0=$G(^OR(100,+$G(ORIFN),8,1,0))
 I $P(X0,U,6) S Y=$P(X0,U,4,6)
 ; look for sign on corrected or parent order action
 I Y="",$P(X0,U,15)=12 D  ;replaced
 . S I=+$O(^OR(100,+$G(ORIFN),8,1)),X=$G(^(I,0))
 . I $P(X,U,2)="XX",$P(X,U,6) S Y=$P(X,U,4,6)
 I Y="",$P(X0,U,4)=8,$G(ORDAD) D  ;parent [no longer used]
 . S X=$G(^OR(100,+$G(ORDAD),8,1,0))
 . S:$P(X,U,6) Y=$P(X,U,4,6)
 ; else, return Sig Sts & Release D/T
 S:Y="" Y=$P(X0,U,4)_U_U_$P(X0,U,16)
 S X=$P(Y,U) S:$L(X) $P(Y,U)=$$EXTERNAL^DILFD(100.008,4,,X)
 Q Y
