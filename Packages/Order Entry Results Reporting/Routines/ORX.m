ORX ; slc/dcm - OE/RR old entry points ;12/26/96  09:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
FILE ;No longer a valid entry point for filing orders
 ;Calls to this entry point will not file an order and will
 ;generate an error in the OE/RR Error file.
 S ORIFN=""
 D ERR("FILE~ORX")
 Q
RETURN ;No longer a valid entry point for updating orders.
 ;Calls to this entry point will not update an order and will
 ;generate an error in the OE/RR Error file.
 D ERR("RETURN~ORX")
 Q
ST ;No longer a valid entry point for updating orders.
 ;Calls to this entry point will not update an order and will
 ;generate an error in the OE/RR Error file.
 D ERR("ST~ORX")
 Q
ERR(TXT) ;Generates an error for call to invalid entry points
 ;TXT=Name of invalid entry point
 Q:'$P($G(^ORD(100.99,1,0)),"^",8)  ;Only file if DEBUG on
 N X,PKG,VAR S:'$D(TXT) TXT=""
 I $G(ORIFN) S X=$G(^OR(100,+ORIFN,0)),PKG=$P(X,"^",14)
 I '$G(PKG) D
 . I $G(ORNS) S PKG=ORNS Q
 . I $G(ORPCL),$L($P(ORPCL,";",2)),$D(@("^"_$P(ORPCL,";",2)_+ORPCL_",0)")),$P(^(0),"^",12) S PKG=$P(^(0),"^",12) Q
 S PKG=$P($G(^DIC(9.4,+$G(PKG),0)),"^"),TXT=$S($L(PKG):PKG,1:"UNKNOWN")_" package called "_TXT,VAR("XQY0")=""
 D EN^ORERR(TXT,,.VAR)
 Q
