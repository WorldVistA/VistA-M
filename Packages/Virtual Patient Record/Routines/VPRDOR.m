VPRDOR ;SLC/MKB -- Orders extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,4,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^OR(100)                      5771
 ; ^ORA(102.4)                   5769
 ; ^ORD(100.98)                   873
 ; ^ORD(101.43)                  2843
 ; ^SC                          10040
 ; ^VA(200)                     10060
 ; DIQ                           2056
 ; ORQ1,^TMP("ORR",$J)           3154
 ; ORQ12,^TMP("ORGOTIT",$J)      5704
 ; ORX8                     2467,3071
 ;
 ; ------------ Get data from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find a patient's orders
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 N ORLIST,ORDG,ORFLG,ORIGVIEW,ORACT,ORDER,VPRN,VPRITM,VPRCNT
 ;
 ; get one order
 I $G(IFN) D  G ENQ
 . N ORLST S ORLST=0,ORLIST=$H
 . S:$P(IFN,";",2)'>1 ORIGVIEW=2 ;force orig order text
 . D GET^ORQ12(+IFN,ORLIST,1,$P(IFN,";",2)) S VPRN=1
 . D EN1(VPRN,.VPRITM),XML(.VPRITM)
 . K ^TMP("ORGOTIT",$J)
 ;
 ; get [all] orders
 S ORDG=$G(FILTER("group"),"ALL"),ORDG=+$O(^ORD(100.98,"B",ORDG,0))
 S ORFLG=+$G(FILTER("view"),6) ;default = Released Orders
 S ORACT=$S("^2^8^9^10^11^13^14^20^21^"[(U_ORFLG_U):1,1:0)
 I 'ORACT S ORIGVIEW=2 ;get original view of order unless action req'd
 D EN^ORQ1(DFN_";DPT(",ORDG,ORFLG,,BEG,END,1,1) S VPRCNT=0
 S VPRN=0 F  S VPRN=$O(^TMP("ORR",$J,ORLIST,VPRN)) Q:VPRN<1  S ORDER=$G(^(VPRN)) D  Q:VPRCNT'<MAX
 . I $P($P(ORDER,U),";",2)>1,'$G(ORACT) Q  ;skip order actions
 . K VPRITM D EN1(VPRN,.VPRITM) Q:'$D(VPRITM)
 . D XML(.VPRITM) S VPRCNT=VPRCNT+1
ENQ ; end
 K ^TMP("ORR",$J),^TMP("VPRTEXT",$J)
 Q
 ;
EN1(NUM,ORD) ; -- return an order in ORD("attribute")=value
 ;  from EN: expects ^TMP("ORR",$J,ORLIST,VPRN)
 N X0,X8,IFN,OI,LOC,PKG,ORPK,X,DA
 K ORD,^TMP("VPRTEXT",$J)
 S X0=$G(^TMP("ORR",$J,ORLIST,NUM)),IFN=$P(X0,U)
 S ORD("id")=IFN,OI=$$OI^ORX8(+IFN),ORD("name")=$P(OI,U,1,2)
 S ORD("codingSystem")=$P($G(^ORD(101.43,+OI,0)),U,3,4)
 S ORD("group")=$P(X0,U,2),ORD("entered")=$P(X0,U,3)
 S ORD("start")=$P(X0,U,4),ORD("stop")=$P(X0,U,5)
 S ORD("status")=$P(X0,U,7)_U_$P(X0,U,6)_U_$$STS($P(X0,U,7))
 M ^TMP("VPRTEXT",$J,IFN)=^TMP("ORR",$J,ORLIST,VPRN,"TX")
 S ORD("content")=$NA(^TMP("VPRTEXT",$J,IFN))
 S X=$$GET1^DIQ(100,+IFN_",",6),LOC="" I $L(X) D
 . S LOC=+$O(^SC("B",X,0)),ORD("location")=LOC_U_X
 S ORD("facility")=$$FAC^VPRD(LOC)
 S PKG=$$GET1^DIQ(100,+IFN_",","12:1"),ORD("service")=PKG
 S X=$P(X0,U,2),X=$S($L(X):+$O(^ORD(100.98,"B",X,0)),1:0)
 S:X ORD("type")=$P($G(^ORD(100.98,X,0)),U,2)
 S ORPK=$$PKGID^ORX8(+IFN)
 S X=$S(PKG?1"PS".E:+IFN,1:ORPK)         ;order#(PS) or 4-node
 S ORD("resultID")=$S(PKG="GMRC":+X,1:X) ;strip trailing string
 S:PKG?1"PS".E ORD("vuid")=$$VUID^VPRDPS(+IFN)
 I PKG="LR" D
 . N LNC S LNC=$$LOINC^VPRDLR(DFN,ORPK,+$P(OI,U,3)) Q:'LNC
 . S ORD("codingSystem")=LNC_"^LNC"
 . S ORD("vuid")=$$VUID^VPRD(+LNC,95.3)
ENA ; order [NEW] action info
 S DA=$P(IFN,";",2) S:DA<1 DA=1
 S X8=$G(^OR(100,+IFN,8,DA,0)),X=$P(X8,U,3)
 S:X ORD("provider")=X_U_$P($G(^VA(200,X,0)),U)_U_$$PROVSPC^VPRD(X)
 S ORD("signatureStatus")=$$EXTERNAL^DILFD(100.008,4,,$P(X8,U,4))
 S X=$P(X8,U,6) S:X ORD("signed")=X S X=$P(X8,U,5)
 S:X ORD("signer")=X_U_$P($G(^VA(200,X,0)),U)_U_$$PROVSPC^VPRD(X)
 S X=$P(X8,U,16) S:X ORD("released")=X
 I "dca"[$E(ORD("status"),1,2) D  ;discontinued
 . N DC,X6 S X6=$G(^OR(100,+IFN,6))
 . S DC=$P(X6,U,3),X=+$P(X6,U,2) Q:DC<1
 . S DC=DC_U_$S(X:X_U_$P($G(^VA(200,X,0)),U),1:U)
 . S X=$P(X6,U,5) I X="" S X=$$EXTERNAL^DILFD(100,64,,$P(X6,U,4))
 . S ORD("discontinued")=DC_$S($L(X):U_X,1:"")
 ; acknowledgements
 S DA=0 F  S DA=$O(^ORA(102.4,"B",+IFN,DA)) Q:DA<1  D
 . S X0=$G(^ORA(102.4,DA,0)) Q:'$P(X0,U,3)  ;stub - not ack'd
 . S X=+$P(X0,U,2),X=$S(X:X_U_$P($G(^VA(200,X,0)),U),1:U)
 . S ORD("acknowledgement",DA)=X_U_$P(X0,U,3)
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
 . S NAMES=$$LABELS(ATT)
 . I ATT?1"ack".E D  S Y="" Q
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(ORD(ATT,I)) Q:I<1  D
 ... S X=$G(ORD(ATT,I))
 ... S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(ORD(ATT)),Y="" Q:'$L(X)
 . I ATT="content" D  S Y="" Q  ;text
 .. S Y="<content xml:space='preserve'>" D ADD(Y)
 .. S I=0 F  S I=$O(@X@(I)) Q:I<1  S Y=$$ESC^VPRD(@X@(I)) D ADD(Y)
 .. D ADD("</content>")
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
 ;
LABELS(X) ; -- return string of attribute labels for element X
 N Y S Y="code^name"
 I X?1"ack".E S Y=Y_"^date"
 I X="status" S Y=Y_"^vuid"
 I X="provider"!(X="signer") S Y=Y_U_$$PROVTAGS^VPRD
 I X="discontinued" S Y="date^by^byName^reason"
 S Y=Y_"^Z"
 Q Y
