HMPDLR ;SLC/MKB,ASMR/RRB - Laboratory extract;Nov 05, 2015 19:21:53
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^LAB(61                        524
 ; ^LRO(69                       2407
 ; ^LR                            525
 ; DIC                           2051
 ; DIQ                           2056
 ; LR7OR1,^TMP("LRRR",$J)        2503
 ; XUAF4                         2171
 Q
 ; ------------ Get results from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's lab results, DE2818
 N HMPSUB,HMPIDT,HMPN,HMPITM,LRDFN,SUB
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 K ^TMP("LRRR",$J,DFN)
 S LRDFN=$$LRDFN^HMPXGLAB(DFN),HMPSUB="CH"  ;DE2818, (#63) LABORATORY REFERENCE
 ;
 ; get result(s)
 I $L($G(ID)) D  Q:HMPN  ;done
 . S HMPSUB=$P(ID,";"),HMPIDT=+$P(ID,";",2),(BEG,END)=9999999-HMPIDT
 . S HMPN=$P(ID,";",3) I HMPN D  ;skip loop - single result
 .. D RR^LR7OR1(DFN,,BEG,END,HMPSUB)
 .. S SUB=$S("CH^MI"[HMPSUB:HMPSUB,1:"AP")_"(.HMPITM)"
 .. D @SUB,XML(.HMPITM)
 .. K ^TMP("LRRR",$J,DFN)
 ;
 D RR^LR7OR1(DFN,,BEG,END,HMPSUB,,,MAX)
 S HMPSUB="" F  S HMPSUB=$O(^TMP("LRRR",$J,DFN,HMPSUB)) Q:HMPSUB=""  D
 . S HMPIDT=0 F  S HMPIDT=$O(^TMP("LRRR",$J,DFN,HMPSUB,HMPIDT)) Q:HMPIDT<1  D
 .. S HMPN=0 F  S HMPN=$O(^TMP("LRRR",$J,DFN,HMPSUB,HMPIDT,HMPN)) Q:HMPN<1  D
 ... K HMPITM S SUB=$S("CH^MI"[HMPSUB:HMPSUB,1:"AP")_"(.HMPITM)"
 ... D @SUB,XML(.HMPITM)
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
CH(LAB) ; -- return a Chemistry result in LAB("attribute")=value
 ;      Expects ^TMP("LRRR",$J,DFN,"CH",HMPIDT,HMPN),LRDFN
 N CDT,LR0,LRI,X0,X,LOINC,ORD,CMMT K LAB
 S LAB("id")="CH;"_HMPIDT_";"_HMPN,LAB("type")="CH"
 S CDT=9999999-HMPIDT,LAB("collected")=CDT
 S LR0=$G(^LR(LRDFN,"CH",HMPIDT,0)),LRI=$G(^(HMPN))
 S LAB("status")="completed",LAB("resulted")=$P(LR0,U,3)
 S X0=$G(^TMP("LRRR",$J,DFN,"CH",HMPIDT,HMPN))
 S LAB("test")=$$LABTSTNM^HMPXGLAB(+X0)  ; DE2818
 S:$L($P(X0,U,2)) LAB("result")=$P(X0,U,2)
 S:$L($P(X0,U,4)) LAB("units")=$P(X0,U,4)
 S:$L($P(X0,U,3)) LAB("interpretation")=$P(X0,U,3)
 S X=$P(X0,U,5) I $L(X),X["-" S LAB("low")=$P(X,"-"),LAB("high")=$P(X,"-",2)
 S LAB("localName")=$S($L($P(X0,U,15)):$P(X0,U,15),1:LAB("test"))
 S LAB("groupName")=$P(X0,U,16) ;accession#
 S X=+$P(X0,U,19) I X D  ;specimen
 . N IENS,HMPY S IENS=X_","
 . D GETS^DIQ(61,IENS,".01;2",,"HMPY")
 . S LAB("specimen")=$G(HMPY(61,IENS,2))_U_$G(HMPY(61,IENS,.01)) ;SNOMED^name
 . S LAB("sample")=$$GET1^DIQ(61,X_",",4.1) ;name
 S ORD=+$P(X0,U,17) S:ORD LAB("labOrderID")=ORD
 S X=$$ORDER(ORD,+X0) S:X LAB("orderID")=X
 S X=$P($P(LRI,U,3),"!",3) S:X LOINC=$$GET1^DIQ(95.3,X_",",.01)
 I $G(LOINC) S LAB("loinc")=LOINC,LAB("vuid")=$$VUID^HMPD(+LOINC,95.3)
 S X=$P(LR0,U,14)
 S:X LAB("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 I 'X S LAB("facility")=$$FAC^HMPD ;local stn#^name
 I $D(^TMP("LRRR",$J,DFN,"CH",HMPIDT,"N")) M CMMT=^("N") S LAB("comment")=$$STRING^HMPD(.CMMT)
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
 ;    Expects ^TMP("LRRR",$J,DFN,"MI",HMPIDT,HMPN),LRDFN
 N ID,CDT,X0,X,CMMT,LR0 K LAB
 S X0=$G(^TMP("LRRR",$J,DFN,"MI",HMPIDT,HMPN)) Q:$L($P(X0,U))'>1
 S LAB("id")="MI;"_HMPIDT_"#"_HMPN,LAB("status")="completed"
 S LAB("type")="MI",CDT=9999999-HMPIDT,LAB("collected")=CDT
 S LR0=$G(^LR(LRDFN,"MI",HMPIDT,0)),LAB("resulted")=$P(LR0,U,3)
 S:$L($P(X0,U,2)) LAB("result")=$P(X0,U,2)
 S:$L($P(X0,U,4)) LAB("units")=$P(X0,U,4)
 S:$L($P(X0,U,3)) LAB("interpretation")=$P(X0,U,3)
 S (LAB("test"),LAB("localName"))=$P(X0,U,15)
 S X=+$P(X0,U,19) I X D  ;specimen
 . N IENS,HMPY S IENS=X_","
 . D GETS^DIQ(61,IENS,".01;2",,"HMPY")
 . S LAB("specimen")=$G(HMPY(61,IENS,2))_U_$G(HMPY(61,IENS,.01)) ;SNOMED^name
 . S LAB("sample")=$$GET1^DIQ(61,X_",",4.1) ;name
 S X=$P(LR0,U,14)
 S:X LAB("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 I 'X S LAB("facility")=$$FAC^HMPD ;local stn#^name
 I $D(^TMP("LRRR",$J,DFN,"MI",HMPIDT,"N")) M CMMT=^("N") S LAB("comment")=$$STRING^HMPD(.CMMT)
 Q
 ;
AP(LAB) ; -- return a Pathology result in LAB("attribute")=value
 K LAB  ;implemented in HMPDLRA
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(LAB) ; -- Return result as XML in @HMP@(#)
 N ATT,X,Y,P,NAMES,TAG
 D ADD("<lab>") S HMPTOTL=$G(HMPTOTL)+1
 S ATT="" F  S ATT=$O(LAB(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S X=$G(LAB(ATT)),Y="" Q:'$L(X)
 . I ATT="comment" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^HMPD(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^HMPD(X)_"' />" Q
 . I $L(X)>1 D  S Y=""
 .. S Y="<"_ATT_" ",NAMES="code^name^Z"
 .. F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 .. S Y=Y_"/>" D ADD(Y)
 D ADD("</lab>")
 Q
 ;
ADD(X) ; -- Add a line @HMP@(n)=X
 S HMPI=$G(HMPI)+1
 S @HMP@(HMPI)=X
 Q
 ;
