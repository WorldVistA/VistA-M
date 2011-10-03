OR3C100 ; SLC/MKB - Orders file conversion for CPRS/OE3 ;8/8/97  15:27
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
ORDERS(ORVP) ; -- Convert all orders for patient ORVP
 N ORPARAM,ORIDT,ORDG,ORIFN,OR0,OR3,OR6,ORSTRT,ORSTOP,ORSTS,DC,DC0,ORACT,ORCAT,RIFN,ORYD,ORNOW,ORDA,CURR,I S U="^"
 S ORPARAM=$$GET^XPAR("SYS","ORPF ACTIVE ORDERS CONTEXT HRS",1,"Q")
ORD1 S ORIDT=0 F  S ORIDT=$O(^OR(100,"AO",ORVP,ORIDT)) Q:ORIDT'>0  S ORDG=0 F  S ORDG=$O(^OR(100,"AO",ORVP,ORIDT,ORDG)) Q:ORDG'>0  S ORIFN=0 F  S ORIFN=$O(^OR(100,"AO",ORVP,ORIDT,ORDG,ORIFN)) Q:ORIFN'>0  D
 . S OR0=$G(^OR(100,ORIFN,0)),OR3=$G(^(3)),OR6=$G(^(6)) G:'$L(OR0) QQ
 . I 'ORVP!('$D(^DPT(+ORVP,0)))!('ORDG)!('$D(^ORD(100.98,+ORDG,0))) D CLEAN(ORIFN) G QQ ; bad record
 . I $P(OR0,U,5)["ORD(101,",$P($G(^ORD(101,+$P(OR0,U,5),0)),U)?1"ORGY ".E S $P(^OR(100,ORIFN,3),U,8)=1 G QQ
 . S ORSTRT=$P(OR3,U,6),ORSTOP=$P(OR0,U,9),ORSTS=$P(OR3,U,3)
 . K DC,DC0,ORACT,ORCAT I $D(^OR(100,ORIFN,8)) D  ; look for DC order
 . . S RIFN=0 F  S RIFN=$O(^OR(100,ORIFN,8,RIFN)) Q:RIFN'>0  I $D(^OR(100,RIFN,0)),"^1^2^11^"[(U_$P($G(^(3)),U,3)_U),$E($G(^(1,1,0)),1,2)="DC" S DC=RIFN
 . S ORYD=$$ORYD(ORPARAM),ORNOW=$$NOW^XLFDT
NW . S ORDA=1,ORACT(ORDA,0)=$P(OR0,U,7)_"^NW^"_$P(OR3,U,7)_U_$P(OR3,U,13)_U_$P(OR3,U,10)_U_$P(OR3,U,12)_U_$P(OR3,U,14)_"^^^^^"_$$NATURE($P(OR0,U,12))_U_$P(OR0,U,6)_U_U_$S($P(OR3,U,3)=11:11,1:"")_U_$P(OR6,U,8,9) ; encrypt ES
 . S ORACT("C","NW",ORDA)="",CURR=1 D ACT($P(OR0,U,7),$P(OR3,U,13))
 . I ORSTS,"^1^2^7^14^99^"'[(U_ORSTS_U) D AC($P(OR0,U,7))
 . I ORYD,"^1^2^7^"[(U_ORSTS_U),ORSTOP'<ORYD D AC($P(OR0,U,7))
 . I $P(OR6,U)'="" S ORACT(ORDA,3)=$$FLAG(ORIFN)
 . I ORSTS=11 D BUILD G SET ; build 4.5 nodes if unreleased
DC . I $G(DC) D  ; add DC action
 . . S ORDA=ORDA+1,DC0=$$DCACTION(DC),ORACT(ORDA,0)=DC0
 . . S ORACT("C","DC",ORDA)="" D ACT($P(DC0,U),$P(DC0,U,4))
 . . I $P(DC0,U,15)=11 D AC($P(DC0,U))
 . . I $P(DC0,U,15)=13,ORYD,$P(DC0,U)'<ORYD D AC($P(DC0,U))
 . . I $P($G(^OR(100,DC,6)),U)'="" S ORACT(ORDA,3)=$$FLAG(DC)
 . . K ^OR(100,"AW",ORVP,ORDG,$S($P($G(^OR(100,DC,3)),U,6):$P(^(3),U,6),1:9999999),DC),^OR(100,DC) ; delete DC order
SET . I $P(OR0,U,14)=+$O(^DIC(9.4,"C","OR",0)) D ORG ; convert text orders
 . S $P(OR0,U,8)=$P(OR3,U,6),$P(OR0,U,12)=$S($D(ORCAT):ORCAT,1:$$CLASS($P(OR0,U,10))),$P(OR0,U,16,17)=$S($P(OR3,U,13)=3:0,1:2)_U
 . I $P(OR0,U,14)=+$O(^DIC(9.4,"C","GMRV",0)) S I=+$O(^DIC(9.4,"C","OR",0)) S:I $P(OR0,U,14)=I ; reset pkg to OR, for HL7 msgs
 . S $P(OR3,U,7)=CURR F I=5,6,10,12,13,14,15 S $P(OR3,U,I)=""
 . K ^OR(100,ORIFN,6),^(8),^(9) ; Flag/DC, Related Orders, Notifications
 . S:$P(OR6,U,12) I=$$NATURE($P(OR6,U,11)),^OR(100,ORIFN,6)=$S(I:I,1:$P($G(DC0),U,12))_U_$P(OR6,U,12,13)
 . S ^OR(100,ORIFN,0)=OR0,^(3)=OR3,^(8,0)="^100.008DA^"_ORDA_U_ORDA M ^OR(100,ORIFN,8)=ORACT
 . I $D(^OR(100,ORIFN,5)) M ^OR(100,ORIFN,8,1,5)=^OR(100,ORIFN,5) K ^OR(100,ORIFN,5)
 . I ORSTRT,ORSTRT>ORNOW,ORSTS=8 S ^OR(100,"AD",ORSTRT,ORIFN)=""
 . I ORSTOP,"^1^2^7^12^13^"'[(U_ORSTS_U) S ^OR(100,"AE",ORSTOP,ORIFN)=""
QQ . K ^OR(100,"AO",ORVP,ORIDT,ORDG,ORIFN)
 Q
 ;
DCACTION(IFN) ; -- Returns related DC order
 N OR0,OR3,OR6,X S OR0=$G(^OR(100,IFN,0)),OR3=$G(^(3)),OR6=$G(^(6))
 S X=$P(OR0,U,7)_"^DC^"_$P(OR3,U,7)_U_$P(OR3,U,13)_U_$P(OR3,U,10)_U_$P(OR3,U,12)_U_$P(OR3,U,14)_"^^^^^"_$$NATURE($P(OR0,U,12))_U_$P(OR0,U,6)_U_U_$S($P(OR3,U,3)=11:11,$P(OR3,U,3)=1:13,1:"")_U_$P(OR6,U,8,9)
 Q X
 ;
FLAG(IFN) ; -- Returns fields for flag
 N OR6,X S OR6=$G(^OR(100,IFN,6))
 S X=$P(OR6,U)_U_$P(OR6,U,4)_U_$P(OR6,U,2,3)_U_$P(OR6,U,7)_U_$P(OR6,U,5,6),$P(OR6,U,1,7)="^^^^^^"
 Q X
 ;
NATURE(X) ; -- Returns ptr to #100.02 for nature X
 N Y S Y=$S(X="":"",1:$O(^ORD(100.02,"C",X,0)))
 Q Y
 ;
AC(X) ; -- Set AC xref
 S:X ^OR(100,"AC",ORVP,9999999-X,ORIFN,ORDA)=""
 Q
 ;
ACT(X,SIG) ; -- ACT & AS xrefs
 S:X ^OR(100,"ACT",ORVP,9999999-X,ORDG,ORIFN,ORDA)="",^OR(100,"AF",X,ORIFN,ORDA)=""
 S:$G(SIG)=2 ^OR(100,"AS",ORVP,9999999-X,ORIFN,ORDA)=""
 Q
 ;
CLASS(LOC) ; -- Returns patient classification for order
 N X S X=$S($D(ORCAT):ORCAT,1:"I")
 I +LOC,$P($G(^SC(+LOC,0)),U,3)'="W" S X="O"
 Q X
 ;
ORYD(Y) ; -- Returns Current Orders context hours
 ;    Y = ORPF ACTIVE ORDERS CONTEXT HRS parameter value
 N X,X1,X2,X3,%,%H
 I Y S X=$H,X=+X*24+($P(X,",",2)/3600),X2=Y,X1=X-X2,X3=X1#24,X1=X1\24,X2=$J(X3*3600,0,0),%H=X1_","_X2 D YMD^%DTC S Y=+(X_%)
 Q Y
 ;
CLEAN(DA) ; -- Clean up bad entries
 M ^ORYX("ORDERS",DA)=^OR(100,DA)
 N DIK S DIK="^OR(100," D ^DIK
 Q
 ;
BUILD ; -- Build Response multiple for unreleased orders
 N ORPK,ORPKG,ORDIALOG,ORQUIT
 S ORPKG=$$NMSP^ORCD($P(OR0,U,14)) Q:"PS"[ORPKG
 S ORPK=$G(^OR(100,ORIFN,4)) K ^(4),^TMP("ORWORD",$J)
 D ^OR3C100A Q:$G(ORQUIT)  D RESPONSE^ORCSAVE ; build, save responses
 S:$G(ORDIALOG) $P(OR0,U,5)=+ORDIALOG_";ORD(101.41,"
 K ^TMP("ORWORD",$J)
 Q
 ;
ORG ; -- Convert generic orders from protocols to dialogs
 I '$O(^OR(100,ORIFN,4.5,0)) D WP Q
 N PITEM,DITEM,DA,PDA,PTR S PITEM=$P(OR3,U,4)
 I $S('PITEM:1,PITEM'[";ORD(101,":1,'$D(^ORD(101,+PITEM,0)):1,1:0) D WP Q
 S DITEM=$$ITEM^ORCONVRT(+PITEM) I 'DITEM D WP Q
 S DA=0 F  S DA=$O(^OR(100,ORIFN,4.5,DA)) Q:DA'>0  S PDA=+$G(^(DA,0)) D
 . I 'PDA K ^OR(100,ORIFN,4.5,DA) Q
 . S PTR=+$P($G(^ORD(101.41,DITEM,10,DA,0)),U,2)
 . S:PTR ^OR(100,ORIFN,4.5,DA,0)=PDA_U_PTR_"^1"
 S $P(^OR(100,ORIFN,0),U,5)=DITEM_";ORD(101.41,"
 Q
 ;
WP ; -- Save as Word Processing dialog
 N WP S WP=+$O(^ORD(101.41,"AB","OR GTX WORD PROCESSING 1",0))
 K ^OR(100,ORIFN,4.5) S ^(4.5,0)="^100.045A^1^1",^(1,0)="1^"_WP_"^1"
 M ^OR(100,ORIFN,4.5,1,2)=^OR(100,ORIFN,1)
 N X S X=$G(^OR(100,ORIFN,4.5,1,2,1,0)) I $E(X,1,3)=">> " S X=$E(X,4,999),^(0)=X
 S $P(^OR(100,ORIFN,0),U,5)=+$O(^ORD(101.41,"AB","OR GXTEXT WORD PROCESSING ORDER",0))_";ORD(101.41,"
 Q
