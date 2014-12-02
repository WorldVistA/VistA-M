ORUTL3 ;SLC/JLC - OE/RR Utilities ;6/30/11  17:54
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**111**;Dec 17, 1997;Build 1
 ;
 ;
 ;
NATURE(ORIFN) ;find nature of order
 ;ORIFN is the order;action being requested
 ;if no action is present, the API will find the most recent action that has
 ;a nature of order
 N OR8,ORACT,ORNAT,ORNATURE
 S ORACT=$P(ORIFN,";",2),ORIFN=$P(ORIFN,";")
 I '$D(^OR(100,ORIFN,0)) Q 0 ; not a valid order
 I ORACT="" D
 . N S1,A
 . S S1=0
 . F  S S1=$O(^OR(100,ORIFN,8,S1)) Q:'S1  S A=$P($G(^(S1,0)),"^",12) I A]"" S ORACT=S1
 I ORACT="" Q 0 ;not a valid order action
 I '$D(^OR(100,ORIFN,8,ORACT)) Q 0 ;not a valid order action
 S OR8=$G(^OR(100,ORIFN,8,ORACT,0)) S ORNATURE=$P(OR8,"^",12),ORNAT=$$TEXT(ORNATURE)
 Q ORNATURE_"^"_ORNAT
TEXT(X) ; -- Returns 3 ^-piece identifier for nature X
 N ORN,Y S ORN=$G(^ORD(100.02,+$G(X),0))
 S Y=$P(ORN,U,2)_U_$P(ORN,U)_"^99ORN"
 Q Y
