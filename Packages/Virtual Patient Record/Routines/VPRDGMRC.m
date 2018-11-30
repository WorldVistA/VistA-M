VPRDGMRC ;SLC/MKB -- Consult extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,4,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DIQ                           2056
 ; GMRCGUIB                      2980
 ; GMRCSLM1,^TMP("GMRCR",$J)     2740
 ; XUAF4                         2171
 ;
 ; ------------ Get consults from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find patient's consults
 N VPRN,VPRX,VPRITM K ^TMP("GMRCR",$J,"CS")
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 ;
 D OER^GMRCSLM1(DFN,"",BEG,END,"")
 S VPRN=0 F  S VPRN=$O(^TMP("GMRCR",$J,"CS",VPRN)) Q:VPRN<1!(VPRN>MAX)  S VPRX=$G(^(VPRN,0)) Q:$E(VPRX)="<"  D
 . I $G(IFN),IFN'=+VPRX Q
 . K VPRITM D EN1(+VPRX,.VPRITM),XML(.VPRITM)
 K ^TMP("GMRCR",$J,"CS"),^TMP("VPRTEXT",$J)
 Q
 ;
EN1(ID,CONS) ; -- return a consult in CONS("attribute")=value
 ;     Expects DFN, VPRX=^TMP("GMRCR",$J,"CS",VPRN,0) [from EN]
 N VPRD,X0,VPRJ,X,VPRTIU
 K CONS,^TMP("VPRTEXT",$J)
 S CONS("id")=ID,CONS("requested")=$P(VPRX,U,2)
 S CONS("status")=$P(VPRX,U,3),CONS("service")=$P(VPRX,U,4)
 S CONS("procedure")=$P(VPRX,U,5),CONS("name")=$P(VPRX,U,7)
 I $P(VPRX,U,6)="*" S CONS("result")="SIGNIFICANT FINDINGS"
 S CONS("orderID")=$P(VPRX,U,8),CONS("type")=$P(VPRX,U,9)
 D DOCLIST^GMRCGUIB(.VPRD,ID) S X0=$G(VPRD(0)) ;=^GMR(123,ID,0)
 S X=$P(X0,U,14) S:X CONS("provider")=X_U_$P($G(^VA(200,X,0)),U)_U_$$PROVSPC^VPRD(X)
 S VPRJ=0 F  S VPRJ=$O(VPRD(50,VPRJ)) Q:VPRJ<1  S X=$G(VPRD(50,VPRJ)) D
 . N Y S Y=$$INFO^VPRDTIU(+X) Q:Y<1  ;draft or retracted
 . S CONS("document",VPRJ)=Y
 . S:$G(VPRTEXT) CONS("document",VPRJ,"content")=$$TEXT^VPRDTIU(X)
 S X=$P(X0,U,21),CONS("facility")=$S(X:$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U),1:$$FAC^VPRD)
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(CONS) ; -- Return patient consult as XML
 ;  as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,J,NAMES
 D ADD("<consult>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(CONS(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S NAMES=$S(ATT="document":"id^localTitle^nationalTitle^vuid",ATT="provider":"code^name^"_$$PROVTAGS^VPRD,1:"code^name")_"^Z"
 . I $O(CONS(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(CONS(ATT,I)) Q:I<1  D
 ... S X=$G(CONS(ATT,I)),Y="<"_ATT_" "_$$LOOP
 ... S X=$G(CONS(ATT,I,"content")) I '$L(X) S Y=Y_"/>" D ADD(Y) Q
 ... S Y=Y_">" D ADD(Y)
 ... S Y="<content xml:space='preserve'>" D ADD(Y)
 ... S J=0 F  S J=$O(@X@(J)) Q:J<1  S Y=$$ESC^VPRD(@X@(J)) D ADD(Y)
 ... D ADD("</content>"),ADD("</"_ATT_">")
 .. D ADD("</"_ATT_"s>")
 . S X=$G(CONS(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</consult>")
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
