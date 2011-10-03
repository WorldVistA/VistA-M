ORQOR1 ; slc/CLA - Functions which return order information ;12/15/97 [ 04/02/97  3:01 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**78,127,242**;Dec 17, 1997;Build 6
LIST(ORY,PATIENT,GROUP,FLAG,ORSDT,OREDT,ORXREF,GETKID) ;return list of patient orders
 ; return PATIENT's orders for a display GROUP of type FLAG
 ; between start (ORSDT) and end dates (OREDT)
 ; dates can be in Fileman or T, T-14 formats
 N GIEN S GIEN=""
 I $L($G(ORSDT)) D DT^DILF("T",ORSDT,.ORSDT,"","")
 I $L($G(OREDT)) D DT^DILF("T",OREDT,.OREDT,"","")
 I (ORSDT=-1)!(OREDT=-1) S ORY(1)="^Error in date range." Q
 S PATIENT=PATIENT_";DPT("
 S:$L($G(GROUP)) GIEN=$O(^ORD(100.98,"B",GROUP,GIEN))
 K ^TMP("ORR",$J)
 D EN^ORQ1(PATIENT,GIEN,FLAG,"",ORSDT,OREDT,1,0,$G(ORXREF),$G(GETKID))
 N J,HOR,SEQ,X S J=1,HOR=0,SEQ=0
 S HOR=$O(^TMP("ORR",$J,HOR)) Q:+HOR<1
 F  S SEQ=$O(^TMP("ORR",$J,HOR,SEQ)) Q:+SEQ<1  D
 .S X=^TMP("ORR",$J,HOR,SEQ)
 .S ORY(J)=$P(X,U)_U_$E(^TMP("ORR",$J,HOR,SEQ,"TX",1),1,60)_U_$P(X,U,4)_U_$P(X,U,6),J=J+1
 K ^TMP("ORR",$J)
 S:+$G(ORY(1))<1 ORY(1)="^No orders found."
 Q
STATI(ORY) ; return stati from ORDER STATUS file [#100.01]
 N STATUS,IEN,I S STATUS="",IEN=0,I=1
 F  S STATUS=$O(^ORD(100.01,"B",STATUS)) Q:STATUS=""  D
 .S IEN=$O(^ORD(100.01,"B",STATUS,IEN))
 .Q:$$SCREEN^XTID(100.01,,IEN_",")  ;inactive VUID
 .S ORY(I)=IEN_"^"_STATUS,IEN=0,I=I+1
 Q
DG(DGNAME) ; extrinsic function returns display group ien
 Q:'$L($G(DGNAME)) ""
 N DGIEN S DGIEN=0
 S DGIEN=$O(^ORD(100.98,"B",DGNAME,DGIEN))
 Q +$G(DGIEN)
OI(OINAME) ; extrinsic function returns orderable item ien
 Q:'$L($G(OINAME)) ""
 N OI S OI=""
 S OI=$O(^ORD(101.43,"B",OINAME,OI))
 Q +$G(OI)
TEXTSTAT(ORNUM) ;extrinsic function returns the first 200 chars of order text
 ;and order status in format: <order text>^<order status>
 ;ORNUM - order number (main order number - $P(ORNUM,";",1))
 S ORNUM=+ORNUM
 Q:'$L($G(ORNUM)) ""
 Q:'$L($G(^OR(100,ORNUM,0))) ""
 N ORSTATUS,ORY
 D TEXT^ORQ12(.ORY,ORNUM,200)
 Q:+$G(ORY)<1 "Order text not found.^"
 S ORSTATUS=$P(^OR(100,ORNUM,3),U,3)
 S ORSTATUS=$G(^ORD(100.01,+ORSTATUS,0))
 S ORSTATUS=$P(ORSTATUS,U)
 Q ORY(1)_U_ORSTATUS
FULLTEXT(ORNUM) ;extrinsic function returns the full text of an order
 ;and order status in format: <order text>^<order status>
 ;ORNUM - order number (main order number - $P(ORNUM,";",1))
 N ORX,ORTXT
 S ORTXT=""
 S ORNUM=+ORNUM
 Q:'$L($G(ORNUM)) ""
 Q:'$L($G(^OR(100,ORNUM,0))) ""
 N ORSTATUS,ORY
 D TEXT^ORQ12(.ORY,ORNUM,"")
 Q:+$G(ORY)<1 "Order text not found.^"
 S:ORY>2 ORY=2  ;only display first two lines of text
 F ORX=1:1:ORY S ORTXT=ORTXT_ORY(ORX)_" "
 S ORSTATUS=$P(^OR(100,ORNUM,3),U,3)
 S ORSTATUS=$G(^ORD(100.01,+ORSTATUS,0))
 S ORSTATUS=$P(ORSTATUS,U)
 Q ORTXT_U_ORSTATUS
