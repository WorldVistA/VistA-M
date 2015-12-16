VPRDLR ;SLC/MKB -- Laboratory extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**2,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^LAB(60                      10054
 ; ^LAB(61                        524
 ; ^LRO(69                       2407
 ; ^LR                            525
 ; DIC                           2051
 ; DIQ                           2056
 ; LR7OR1,^TMP("LRRR",$J)        2503
 ; LRPXAPIU                      4246
 ; XUAF4                         2171
 ;
 ; ------------ Get results from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's lab results
 N VPRSUB,VPRIDT,VPRN,VPRP,VPRITM,LRDFN,SUB,X
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S LRDFN=$G(^DPT(DFN,"LR")),VPRSUB=$G(FILTER("type"),"CH")
 K ^TMP("LRRR",$J,DFN)
 ;
 ; get result(s)
 I $L($G(ID)) D  ;reset for LR7OR1
 . S VPRSUB=$P(ID,";"),VPRIDT=+$P(ID,";",2)
 . S:VPRIDT (BEG,END)=9999999-VPRIDT
 ;
 D RR^LR7OR1(DFN,,BEG,END,VPRSUB,,,MAX)
 S VPRSUB="" F  S VPRSUB=$O(^TMP("LRRR",$J,DFN,VPRSUB)) Q:VPRSUB=""  D
 . S VPRIDT=0 F  S VPRIDT=$O(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT)) Q:VPRIDT<1  D
 .. S VPRP=0 F  S VPRP=$O(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT,VPRP)) Q:VPRP<1  S X=+$G(^(VPRP)) D
 ... S VPRN=$$LRDN^LRPXAPIU(X) I $L($G(ID),";")>2,VPRN'=$P(ID,";",3) Q
 ... K VPRITM S SUB=$S("CH^MI"[VPRSUB:VPRSUB,1:"AP")_"(.VPRITM)"
 ... D @SUB,XML(.VPRITM):$D(VPRITM)
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
CH(LAB) ; -- return a Chemistry result in LAB("attribute")=value
 ;      Expects ^TMP("LRRR",$J,DFN,"CH",VPRIDT,VPRP),VPRN,LRDFN
 N X0,CDT,LR0,LRI,X,LOINC,ORD,CMMT K LAB
 S X0=$G(^TMP("LRRR",$J,DFN,"CH",VPRIDT,VPRP))
 S LAB("id")="CH;"_VPRIDT_";"_VPRN,LAB("type")="CH"
 S CDT=9999999-VPRIDT,LAB("collected")=CDT
 S LR0=$G(^LR(LRDFN,"CH",VPRIDT,0)),LRI=$G(^(VPRN))
 S LAB("status")="completed",LAB("resulted")=$P(LR0,U,3)
 S LAB("test")=$P($G(^LAB(60,+X0,0)),U) ;$P(X0,U,10)?
 S:$L($P(X0,U,2)) LAB("result")=$P(X0,U,2)
 S:$L($P(X0,U,4)) LAB("units")=$P(X0,U,4)
 S:$L($P(X0,U,3)) LAB("interpretation")=$P(X0,U,3)
 S X=$P(X0,U,5) I $L(X),X["-" S LAB("low")=$$TRIM^XLFSTR($P(X,"-")),LAB("high")=$$TRIM^XLFSTR($P(X,"-",2))
 S LAB("localName")=$S($L($P(X0,U,15)):$P(X0,U,15),1:LAB("test"))
 S LAB("groupName")=$P(X0,U,16) ;accession#
 S X=+$P(X0,U,19) I X D  ;specimen
 . N IENS,VPRY S IENS=X_","
 . D GETS^DIQ(61,IENS,".01;2",,"VPRY")
 . S LAB("specimen")=$G(VPRY(61,IENS,2))_U_$G(VPRY(61,IENS,.01)) ;SNOMED^name
 . S LAB("sample")=$$GET1^DIQ(61,X_",",4.1) ;name
 S ORD=+$P(X0,U,17) S:ORD LAB("labOrderID")=ORD
 S X=$$ORDER(ORD,+X0) S:X LAB("orderID")=X
 S X=$P($P(LRI,U,3),"!",3) S:X LOINC=$$GET1^DIQ(95.3,X_",",.01)
 I $G(LOINC) S LAB("loinc")=LOINC,LAB("vuid")=$$VUID^VPRD(+LOINC,95.3)
 S X=$P(LRI,U,9) S:X LAB("performingLab")=$$NAME^XUAF4(X)
 S X=+$P(LR0,U,10) S:X LAB("provider")=X_U_$P($G(^VA(200,X,0)),U)_U_$$PROVSPC^VPRD(X)
 S X=$P(LR0,U,14) S:X LAB("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 I 'X S LAB("facility")=$$FAC^VPRD ;local stn#^name
 I $D(^TMP("LRRR",$J,DFN,"CH",VPRIDT,"N")) M CMMT=^("N") S LAB("comment")=$$STRING^VPRD(.CMMT)
 Q
 ;
ORDER(LABORD,TEST) ; -- return #100 order for Lab order# & Test
 N Y,D,S,T S Y=""
 S D=$O(^LRO(69,"C",LABORD,0)) I D D
 . S S=0 F  S S=$O(^LRO(69,"C",LABORD,D,S)) Q:S<1  D
 .. S T=0 F  S T=$O(^LRO(69,D,1,S,2,T)) Q:T<1  I +$G(^(T,0))=TEST S Y=+$P(^(0),U,7)
 Q Y
 ;
MI(LAB) ; -- return a Microbiology result in LAB("attribute")=value
 ;    Expects ^TMP("LRRR",$J,DFN,"MI",VPRIDT,VPRP),LRDFN
 N ID,CDT,X0,X,CMMT,LR0 K LAB
 S X0=$G(^TMP("LRRR",$J,DFN,"MI",VPRIDT,VPRP)) Q:$L($P(X0,U))'>1
 S LAB("id")="MI;"_VPRIDT_"#"_VPRP,LAB("status")="completed"
 S LAB("type")="MI",CDT=9999999-VPRIDT,LAB("collected")=CDT
 S LR0=$G(^LR(LRDFN,"MI",VPRIDT,0)),LAB("resulted")=$P(LR0,U,3)
 I '$P(LR0,U,3) S LAB("status")="incomplete"
 S:$L($P(X0,U,2)) LAB("result")=$P(X0,U,2)
 S:$L($P(X0,U,4)) LAB("units")=$P(X0,U,4)
 S:$L($P(X0,U,3)) LAB("interpretation")=$P(X0,U,3)
 S (LAB("test"),LAB("localName"))=$P(X0,U,15)
 S X=+$P(X0,U,19) I X D  ;specimen
 . N IENS,VPRY S IENS=X_","
 . D GETS^DIQ(61,IENS,".01;2",,"VPRY")
 . S LAB("specimen")=$G(VPRY(61,IENS,2))_U_$G(VPRY(61,IENS,.01)) ;SNOMED^name
 . S LAB("sample")=$$GET1^DIQ(61,X_",",4.1) ;name
 S X=+$P(LR0,U,7) S:X LAB("provider")=X_U_$P($G(^VA(200,X,0)),U)_U_$$PROVSPC^VPRD(X)
 S X=$P(LR0,U,14)
 S:X LAB("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 I 'X S LAB("facility")=$$FAC^VPRD ;local stn#^name
 I $D(^TMP("LRRR",$J,DFN,"MI",VPRIDT,"N")) M CMMT=^("N") S LAB("comment")=$$STRING^VPRD(.CMMT)
 Q
 ;
AP(LAB) ; -- return a Pathology result in LAB("attribute")=value
 K LAB  ;implemented in VPRDLRA
 Q
 ;
LOINC(DFN,ORPK,TEST) ; -- return LOINC code for ordered TEST
 N LRDT,LRN,Y Q:$P(ORPK,";",4)'="CH" ""
 S LRDT=$$LRIDT^LRPXAPIU($P(ORPK,";",5)),Y=""
 D VALUE^LRPXAPI(.LRN,DFN,LRDT,TEST) ;LRN="" if panel
 S X=$P($P(LRN,U,3),"!",3) S:X Y=$$GET1^DIQ(95.3,X_",",.01)
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(LAB) ; -- Return result as XML in @VPR@(#)
 N ATT,X,Y,P,NAMES,TAG
 D ADD("<lab>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(LAB(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S X=$G(LAB(ATT)),Y="" Q:'$L(X)
 . I ATT="comment" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^VPRD(X)_"</"_ATT_">" Q
 . ;
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 D  S Y=""
 .. S Y="<"_ATT_" ",NAMES="code^name^Z"
 .. S:ATT="provider" NAMES="code^name^"_$$PROVTAGS^VPRD_"^Z"
 .. F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 .. S Y=Y_"/>" D ADD(Y)
 D ADD("</lab>")
 Q
 ;
ADD(X) ; -- Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
