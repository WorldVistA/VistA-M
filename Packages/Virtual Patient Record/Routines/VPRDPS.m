VPRDPS ;SLC/MKB -- Pharmacy extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;;Sep 01, 2011;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; PSOORRL,^TMP("PS",$J)         2400
 ; PSS50,^TMP($J                 4483
 ;
 ; ------------ Get medications from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's meds
 N PS0,VPRN,VPRITM,IV K ^TMP("PS",$J)
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 ;
 ; get one med
 I $G(ID) D  D:$D(VPRITM)>9 XML(.VPRITM) K ^TMP("PS",$J) Q
 . I ID["N" D NVA^VPRDPSO(ID,.VPRITM) Q
 . I ID["O",(ID'["P")&(ID'["S") D RX^VPRDPSO(ID,.VPRITM) Q
 . D OEL^PSOORRL(DFN,ID)
 . I ID["O",(ID["P")!(ID["S") D PEN1^VPRDPSO(ID,.VPRITM) Q
 . S IV=$S(ID["V":1,$G(^TMP("PS",$J,"B",0)):1,1:0)
 . D @($S(IV:"IV1",1:"IN1")_"^VPRDPSI(ID,.VPRITM)")
 ;
 ; get all meds
 D OCL^PSOORRL(DFN,BEG,END)
 S VPRN=0 F  S VPRN=$O(^TMP("PS",$J,VPRN)) Q:VPRN<1!(VPRN>MAX)  S PS0=$G(^(VPRN,0)) D  I $D(VPRITM)>9 D XML(.VPRITM)
 . S ID=$P(PS0,U) K VPRITM
 . I ID["N" D NVA^VPRDPSO(ID,.VPRITM) Q
 . I ID["O" D RX^VPRDPSO(ID,.VPRITM) Q
 . S IV=$S(ID["V":1,$G(^TMP("PS",$J,VPRN,"B",0)):1,1:0)
 . D @($S(IV:"IV",1:"IN")_"^VPRDPSI(ID,.VPRITM)")
 K ^TMP("PS",$J)
 Q
 ;
NDF(DRUG,I) ; -- Set NDF data for dispense DRUG ien
 N VUID,X
 S DRUG=+$G(DRUG) Q:'DRUG
 D NDF^PSS50(DRUG,,,,,"NDF") S I=+$G(I)+1
 S MED("product",I)=DRUG_U_$G(^TMP($J,"NDF",DRUG,.01))_"^^D" ;Drug
 S X=$G(^TMP($J,"NDF",DRUG,20)) ;VA Generic
 S MED("product",I,"G")=X_U_$$VUID^VPRD(+X,50.6)
 S X=$G(^TMP($J,"NDF",DRUG,22)) ;VA Product
 S MED("product",I,"P")=X_U_$$VUID^VPRD(+X,50.68)
 S X=$G(^TMP($J,"NDF",DRUG,25)) ;VA Drug Class
 S MED("product",I,"C")=$P(X,U,2,3)_U_$$VUID^VPRD(+X,50.605)
 K ^TMP($J,"NDF",DRUG)
 Q
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
 ... I ATT="dose" S NAMES="dose^units^unitsPerDose^noun^route^schedule^duration^conjunction^doseStart^doseStop^Z"
 ... I ATT="fill" S NAMES="fillDate^fillRouting^releaseDate^fillQuantity^fillDaysSupply^partial^Z"
 ... I ATT="product" S NAMES="code^name^vuid^role^concentration^Z"
 ... S Y="<"_ATT_" "_$$LOOP_$S(ATT'="product":"/>",1:">") D ADD(Y)
 ... Q:ATT'="product"
 ... S X=$G(MED(ATT,I,"C")) I $L(X) S Y="<class "_$$LOOP_"/>" D ADD(Y)
 ... S X=$G(MED(ATT,I,"G")) I $L(X) S Y="<vaGeneric "_$$LOOP_"/>" D ADD(Y)
 ... S X=$G(MED(ATT,I,"P")) I $L(X) S Y="<vaProduct "_$$LOOP_"/>" D ADD(Y)
 ... D ADD("</product>")
 .. D ADD("</"_ATT_"s>")
 . S X=$G(MED(ATT)),Y="" Q:'$L(X)
 . I ATT="sig"!(ATT?1"ptIn"1.A) S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^VPRD(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 S NAMES="code^name^Z",Y="<"_ATT_" "_$$LOOP_"/>"
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
