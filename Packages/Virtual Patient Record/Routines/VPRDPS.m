VPRDPS ;SLC/MKB -- Pharmacy extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,4,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^OR(100)                      5771
 ; ORX8                          2467
 ; PSOORRL,^TMP("PS",$J)         2400
 ; PSS50,^TMP($J                 4533
 ; PSS50P7,^TMP($J               4662
 ; PSSDI                         4551
 ;
 ; ------------ Get medications from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ORIFN) ; -- find patient's meds
 N PS0,VPRN,VPRITM,TYPE,ID K ^TMP("PS",$J)
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 ;
 ; get one med
 I $G(ORIFN) D EN1^VPRDPSOR(ORIFN,.VPRITM),XML(.VPRITM):$D(VPRITM) Q
 ;
 ; get all meds
 D OCL^PSOORRL(DFN,BEG,END) M ^TMP("VPRPS",$J)=^TMP("PS",$J)
 S TYPE=$G(FILTER("vaType"))
 S VPRN=0 F  S VPRN=$O(^TMP("VPRPS",$J,VPRN)) Q:VPRN<1!(VPRN>MAX)  S PS0=$G(^(VPRN,0)) D  I $D(VPRITM)>9 D XML(.VPRITM)
 . S ID=$P(PS0,U),ORIFN=+$P(PS0,U,8) K VPRITM
 . Q:'ORIFN!'$D(^OR(100,ORIFN,0))
 . I $L(TYPE) Q:'$$MATCH
 . D:ORIFN EN1^VPRDPSOR(ORIFN,.VPRITM)
 K ^TMP("VPRPS",$J),^TMP("PS",$J),^TMP($J,"PSOI")
 Q
 ;
MATCH() ; -- Return 1 or 0, if order matches FILTER criteria
 N Y S Y=0
 I ID["O" D
 . I TYPE="N",ID["N" S Y=1 Q
 . I TYPE="O",ID'["N" S Y=1 Q
 . ; TYPE="S",ID'["N",$$SUPPLY(ORIFN) S Y=1 Q
 I ID["I" D
 . N IV S IV=$S(ID["V":1,$G(^TMP("VPRPS",$J,VPRN,"B",0)):1,1:0)
 . I TYPE="V",IV S Y=1
 . I TYPE="I",'IV S Y=1
 Q Y
 ;
SUPPLY(ORDER) ; -- Return 1 or 0, if ORDER is for a supply item
 N OI,Y S OI=$$OI^ORX8(ORDER),Y=0
 D ZERO^PSS50P7(+$P(OI,U,3),,,"PSOI")
 S Y=+$G(^TMP($J,"PSOI",+$P(OI,U,3),.09))
 Q Y
 ;
NDF(DRUG,VPI,ORD) ; -- Set NDF data for dispense DRUG ien
 N VPRX,STR,VUID,X,I
 S DRUG=+$G(DRUG) Q:'DRUG
 D EN^PSSDI(50,,50,"901;902",DRUG,"VPRX")
 S STR=$S($G(VPRX(50,DRUG,901)):$G(VPRX(50,DRUG,901))_" "_$G(VPRX(50,DRUG,902)),1:"")
 D NDF^PSS50(DRUG,,,,,"NDF") S VPI=+$G(VPI,1)
 S MED("product",VPI)=DRUG_U_$G(^TMP($J,"NDF",DRUG,.01))_"^^D^"_STR_U_$G(ORD) ;Drug
 S X=$G(^TMP($J,"NDF",DRUG,20)) ;VA Generic
 S MED("product",VPI,"G")=X_U_$$VUID^VPRD(+X,50.6)
 S X=$G(^TMP($J,"NDF",DRUG,22)) ;VA Product
 S MED("product",VPI,"P")=X_U_$$VUID^VPRD(+X,50.68)
 S X=$G(^TMP($J,"NDF",DRUG,25)) ;VA Drug Class
 S MED("product",VPI,"C")=$P(X,U,2,3)_U_$$VUID^VPRD(+X,50.605)
 K ^TMP($J,"NDF",DRUG)
 Q
 ;
VUID(ORDER) ; -- return VUID for VA Product in ORDER
 N X,Y,DRUG S Y=""
 S DRUG=$$VALUE^ORX8(+$G(ORDER),"DRUG")
 I DRUG D
 . D NDF^PSS50(DRUG,,,,,"NDF")
 . S X=$G(^TMP($J,"NDF",DRUG,22)),Y=$$VUID^VPRD(+X,50.68)
 . K ^TMP($J,"NDF")
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(MED) ; -- Return patient meds as XML
 N ATT,X,Y,I,NAMES
 D ADD("<med>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(MED(ATT)) Q:ATT=""  D  I $L(Y) D ADD(Y)
 . I $O(MED(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(MED(ATT,I)) Q:I<1  D
 ... S X=$G(MED(ATT,I)),NAMES=""
 ... I ATT="dose" S NAMES="dose^units^unitsPerDose^noun^route^schedule^duration^conjunction^doseStart^doseStop^order^Z"
 ... I ATT="fill" S NAMES="fillDate^fillRouting^releaseDate^fillQuantity^fillDaysSupply^partial^Z"
 ... I ATT="product" S NAMES="code^name^vuid^role^concentration^order^Z"
 ... S Y="<"_ATT_" "_$$LOOP_$S(ATT'="product":"/>",1:">") D ADD(Y)
 ... Q:ATT'="product"
 ... S X=$G(MED(ATT,I,"O")) I $L(X) S Y="<ordItem "_$$LOOP_"/>" D ADD(Y)
 ... S X=$G(MED(ATT,I,"C")) I $L(X) S Y="<class "_$$LOOP_"/>" D ADD(Y)
 ... S X=$G(MED(ATT,I,"G")) I $L(X) S Y="<vaGeneric "_$$LOOP_"/>" D ADD(Y)
 ... S X=$G(MED(ATT,I,"P")) I $L(X) S Y="<vaProduct "_$$LOOP_"/>" D ADD(Y)
 ... D ADD("</product>")
 .. D ADD("</"_ATT_"s>")
 . S X=$G(MED(ATT)),Y="" Q:'$L(X)
 . I ATT="sig"!(ATT?1"ptIn"1.A) S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^VPRD(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 S NAMES="code^name"_$S(ATT["Provider":U_$$PROVTAGS^VPRD,1:"")_"^Z",Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</med>")
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
