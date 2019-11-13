ORUTL3 ;SLC/JLC - OE/RR Utilities ;08/28/17  14:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**111,397**;Dec 17, 1997;Build 22
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
ISSUPPLY(ORDDIEN) ;IS THIS DISPENSE DRUG A SUPPLY ORDER
 ;INPUT: ORDDIEN - DISPENSE DRUG TO BE CHECKED
 D ZERO^PSS50(ORDDIEN,,,,,"ORDRUG")
 I ^TMP($J,"ORDRUG",0)<1 Q
 I "^XA^XX^"[("^"_$E(^TMP($J,"ORDRUG",ORDDIEN,2),1,2)_"^") Q 1
 I ^TMP($J,"ORDRUG",ORDDIEN,2)="DX900",$G(^TMP($J,"ORDRUG",ORDDIEN,3))["S" Q 1
 Q 0
 ;
ISOISPLY(OROIIEN) ;is this orderable item a supply order
 ; Input: OROIIEN - Orderable Item IEN (#101.43) to be checked
 N ORDRUG,ORLST,ORSPLY
 ;
 S ORSPLY=1
 ;
 D OI2DD^ORKCHK5(.ORLST,OROIIEN,"O")
 I '$O(ORLST(0)) S ORSPLY=0
 S ORDRUG=""
 F  S ORDRUG=$O(ORLST(ORDRUG)) Q:ORDRUG=""!('ORSPLY)  D
 . I '$$ISSUPPLY(+ORDRUG) S ORSPLY=0
 ;
 Q ORSPLY
