HMPDOR ;SLC/MKB,ASMR/RRB - Orders extract;8/2/11  15:29
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^ORA(102.4)                   5769
 ; ^SC                          10040
 ; ^VA(200)                     10060
 ; DIQ                           2056
 ; ORQ1,^TMP("ORR",$J)           3154
 ; ORQ12,^TMP("ORGOTIT",$J)      5704
 ; ORX8                          2467
 Q
 ; ------------ Get data from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find a patient's orders
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 N ORLIST,HMPN,HMPITM,HMPCNT
 ;
 ; get one order
 I $G(IFN) D  G ENQ
 . N ORLST S ORLST=0,ORLIST=$H
 . D GET^ORQ12(IFN,ORLIST,1) S HMPN=1
 . D EN1(HMPN,.HMPITM),XML(.HMPITM)
 . K ^TMP("ORGOTIT",$J)
 ;
 ; get all orders
 D EN^ORQ1(DFN_";DPT(",,6,,BEG,END,1) S HMPCNT=0
 S HMPN=0 F  S HMPN=$O(^TMP("ORR",$J,ORLIST,HMPN)) Q:HMPN<1  D  Q:HMPCNT'<MAX
 . K HMPITM D EN1(HMPN,.HMPITM) Q:'$D(HMPITM)
 . D XML(.HMPITM) S HMPCNT=HMPCNT+1
ENQ ; end
 K ^TMP("ORR",$J),^TMP("HMPTEXT",$J)
 Q
 ;
EN1(NUM,ORD) ; -- return an order in ORD("attribute")=value
 ;  from EN: expects ^TMP("ORR",$J,ORLIST,HMPN)
 N X0,IFN,LOC,X,DA
 K ORD,^TMP("HMPTEXT",$J)
 S X0=$G(^TMP("ORR",$J,ORLIST,NUM)),IFN=+X0
 S ORD("id")=IFN,ORD("name")=$$OI^ORX8(+X0)
 S ORD("group")=$P(X0,U,2),ORD("entered")=$P(X0,U,3)
 S ORD("start")=$P(X0,U,4),ORD("stop")=$P(X0,U,5)
 S ORD("status")=$P(X0,U,7)_U_$P(X0,U,6)_U_$$STS($P(X0,U,7))
 M ^TMP("HMPTEXT",$J,IFN)=^TMP("ORR",$J,ORLIST,HMPN,"TX")
 S ORD("content")=$NA(^TMP("HMPTEXT",$J,IFN))
 S X=$$GET1^DIQ(100,IFN_",",1,"I"),ORD("provider")=X_U_$P($G(^VA(200,+X,0)),U) ;ICR 10060 DE2818 ASF 11/10/15
 S X=$$GET1^DIQ(100,IFN_",",6),LOC="" I $L(X) D
 . S LOC=+$O(^SC("B",X,0)),ORD("location")=LOC_U_X ;ICR 10040 DE2818 ASF 11/9/15
 S ORD("facility")=$$FAC^HMPD(LOC)
 S ORD("service")=$$GET1^DIQ(100,IFN_",","12:1")
 ; acknowledgements
 S DA=0 F  S DA=$O(^ORA(102.4,"B",+IFN,DA)) Q:DA<1  D  ;ICR 5769 DE2818 ASF 11/9/15
 . S X0=$G(^ORA(102.4,DA,0)) Q:'$P(X0,U,3)  ;stub - not ack'd
 . S X=+$P(X0,U,2),X=$S(X:X_U_$P($G(^VA(200,X,0)),U),1:U)
 . S ORD("acknowledgement",DA)=X_U_$P(X0,U,3)
 Q
 ;
STS(X) ; -- return VUID for status abbreviation X
 N Y,I,STS
 S STS="dc^comp^hold^flag^pend^actv^exp^schd^part^dlay^unr^dc/e^canc^laps^rnew^none"
 F I=1:1:16 Q:$P(STS,U,I)=X
 S Y=$$VUID^HMPD(I,100.01)
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(ORD) ; -- Return patient data as XML in @HMP@(n)
 ; as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,NAMES
 D ADD("<order>") S HMPTOTL=$G(HMPTOTL)+1
 S ATT="" F  S ATT=$O(ORD(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S NAMES="code^name^"_$S(ATT?1"ack".E:"date",1:"vuid")_"^Z"
 . I ATT?1"ack".E D  S Y="" Q
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(ORD(ATT,I)) Q:I<1  D
 ... S X=$G(ORD(ATT,I))
 ... S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(ORD(ATT)),Y="" Q:'$L(X)
 . I ATT="content" D  S Y="" Q  ;text
 .. S Y="<content xml:space='preserve'>" D ADD(Y)
 .. S I=0 F  S I=$O(@X@(I)) Q:I<1  S Y=$$ESC^HMPD(@X@(I)) D ADD(Y)
 .. D ADD("</content>")
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^HMPD(X)_"' />" Q
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</order>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; Add a line @HMP@(n)=X
 S HMPI=$G(HMPI)+1
 S @HMP@(HMPI)=X
 Q
