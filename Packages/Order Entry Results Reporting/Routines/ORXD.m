ORXD ;SLC/MKB-OE/RR Order Dialog entry points ;3/25/97  09:46
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4**;Dec 17, 1997
DISABLE(PKG,MSG) ; -- Disable all dialogs for PKG
 Q:'$G(PKG)  S:'$L($G(MSG)) MSG=$$GET1^DIQ(9.4,+PKG_",",.01)_" disabled."
 D LOOP
 Q
 ;
ENABLE(PKG) ; -- Enable all dialogs for PKG
 Q:'$G(PKG)  N MSG S MSG="" D LOOP
 Q
 ;
LOOP ; -- loop thru all PKG dlgs, set MSG
 N IFN S IFN=0
 F  S IFN=$O(^ORD(101.41,"APKG",PKG,IFN)) Q:IFN'>0  S $P(^ORD(101.41,IFN,0),U,3)=$E(MSG,1,40)
 Q
 ;
MSG(IFN) ; -- Returns 1^Message if dialog IFN is out of order
 N X,Y S X=$P($G(^ORD(101.41,IFN,0)),U,3),Y=$S($L(X):"1^"_X,1:0)
 Q Y
 ;
SAVE ; -- Save off OR* variables
 N I Q:'$G(ORVP)
 F I="ORVP","ORPNM","ORSSN","ORDOB","ORAGE","ORSEX","ORTS","ORWARD","ORATTEND","ORSC","ORNP","ORL","ORL(0)","ORL(1)","ORTAB","ORMENU" I $D(@I) S ^TMP("OROLD",$J,I)=@I
 Q
 ;
RSTR ; -- Restore OR* variables
 N I Q:'$D(^TMP("OROLD",$J))
 S I="OR" F  S I=$O(^TMP("OROLD",$J,I)) Q:I'?1"OR".E  S @I=^(I)
 K ^TMP("OROLD",$J)
 Q
