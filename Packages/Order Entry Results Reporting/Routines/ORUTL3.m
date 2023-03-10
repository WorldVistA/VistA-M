ORUTL3 ;SLC/JLC - OE/RR Utilities ;Oct 12, 2021@10:42:54
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**111,397,405**;Dec 17, 1997;Build 211
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
 ;
ISTITR(ORIFN) ; Is this a titration order?
 ;
 ; ORIFN is the Order (#100) IEN
 ;
 N OR0,ORDG,ORTITR,ORTITRVAL
 ;
 S OR0=$G(^OR(100,+ORIFN,0))
 S ORDG=$P($G(^ORD(100.98,+$P(OR0,U,11),0)),U,3)
 I ORDG'="O RX" Q 0
 ;
 S ORTITR=+$O(^OR(100,+ORIFN,4.5,"ID","TITR",0))
 I ORTITR D  Q $G(ORTITRVAL)
 . S ORTITRVAL=+$G(^OR(100,+ORIFN,4.5,ORTITR,1))
 ;
 ; also check backdoor pharmacy (in case of orders marked
 ; in backdoor pharmacy as titrating pre-v32/p405)
 S PSIFN=$G(^OR(100,+ORIFN,4))
 I PSIFN["S" Q 0
 I $$TITRX^PSOUTL(PSIFN)="t" Q 1
 ;
 Q 0
