VPRDOR ;SLC/MKB -- Orders extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;;Sep 01, 2011;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC                          10040
 ; ^VA(200)                     10060
 ; DIQ                           2056
 ; ORQ1,^TMP("ORR",$J)           3154
 ; ORQ12                         5704
 ; ORX8                          2467
 ; XUAF4                         2171
 ;
 ; ------------ Get data from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find a patient's orders
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 N ORLIST,VPRN,VPRITM,VPRCNT
 ;
 ; get one order
 I $G(IFN) D  Q
 . N ORLST S ORLST=0,ORLIST=$H
 . D GET^ORQ12(IFN,ORLIST,1) S VPRN=1
 . D EN1(VPRN,.VPRITM),XML(.VPRITM)
 . K ^TMP("ORGOTIT",$J)
 ;
 ; get all orders
 D EN^ORQ1(DFN_";DPT(",,6,,BEG,END,1) S VPRCNT=0
 S VPRN=0 F  S VPRN=$O(^TMP("ORR",$J,ORLIST,VPRN)) Q:VPRN<1  D  Q:VPRCNT'<MAX
 . K VPRITM D EN1(VPRN,.VPRITM) Q:'$D(VPRITM)
 . D XML(.VPRITM) S VPRCNT=VPRCNT+1
 K ^TMP("ORR",$J)
 Q
 ;
EN1(NUM,ORD) ; -- return an order in ORD("attribute")=value
 ;  from EN: expects ^TMP("ORR",$J,ORLIST,VPRN)
 N X0,IFN,LOC,VPRT K ORD
 S X0=$G(^TMP("ORR",$J,ORLIST,NUM)),IFN=+X0
 S ORD("id")=IFN,ORD("name")=$$OI^ORX8(+X0)
 S ORD("group")=$P(X0,U,2),ORD("entered")=$P(X0,U,3)
 S ORD("start")=$P(X0,U,4),ORD("stop")=$P(X0,U,5)
 S ORD("status")=$P(X0,U,7)_U_$P(X0,U,6)_U_$$STS($P(X0,U,7))
 M VPRT=^TMP("ORR",$J,ORLIST,VPRN,"TX") S ORD("content")=$$STRING^VPRD(.VPRT)
 S X=$$GET1^DIQ(100,IFN_",",1,"I"),ORD("provider")=X_U_$P($G(^VA(200,+X,0)),U)
 S X=$$GET1^DIQ(100,IFN_",",6),LOC="" I $L(X) D
 . S LOC=+$O(^SC("B",X,0)),ORD("location")=LOC_U_X
 S ORD("facility")=$$FAC^VPRD(LOC)
 Q
 ;
STS(X) ; -- return VUID for status abbreviation X
 N Y,I,STS
 S STS="dc^comp^hold^flag^pend^actv^exp^schd^part^dlay^unr^dc/e^canc^laps^rnew^none"
 F I=1:1:16 Q:$P(STS,U,I)=X
 S Y=$$VUID^VPRD(I,100.01)
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(ORD) ; -- Return patient data as XML in @VPR@(n)
 ; as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,NAMES
 D ADD("<order>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(ORD(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S X=$G(ORD(ATT)),Y="" Q:'$L(X)
 . S NAMES="code^name^vuid^Z"
 . I ATT="content" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^VPRD(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</order>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
