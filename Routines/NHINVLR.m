NHINVLR ;SLC/MKB -- Laboratory extract
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^LAB(60                      10054
 ; ^LRO(69                       2407
 ; ^LR                            525
 ; DIC                           2051
 ; DIQ                           2056
 ; LR7OR1,^TMP("LRRR",$J)        2503
 ;
 ; ------------ Get results from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's lab results
 N NHSUB,NHIDT,NHI,NHITM,LRDFN,SUB
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 K ^TMP("LRRR",$J,DFN) S LRDFN=$G(^DPT(DFN,"LR")),NHSUB="CH"
 ;
 ; get result(s)
 I $L($G(ID)) D  Q:NHI  ;done
 . S NHSUB=$P(ID,";"),NHIDT=+$P(ID,";",2),(BEG,END)=9999999-NHIDT
 . S NHI=$P(ID,";",3) I NHI D  ;skip loop - single result
 .. D RR^LR7OR1(DFN,,BEG,END,NHSUB)
 .. S SUB=$S("CH^MI"[NHSUB:NHSUB,1:"AP")_"(.NHITM)"
 .. D @SUB,XML(.NHITM)
 .. K ^TMP("LRRR",$J,DFN)
 ;
 D RR^LR7OR1(DFN,,BEG,END,NHSUB,,,MAX)
 S NHSUB="" F  S NHSUB=$O(^TMP("LRRR",$J,DFN,NHSUB)) Q:NHSUB=""  D
 . S NHIDT=0 F  S NHIDT=$O(^TMP("LRRR",$J,DFN,NHSUB,NHIDT)) Q:NHIDT<1  D
 .. S NHI=0 F  S NHI=$O(^TMP("LRRR",$J,DFN,NHSUB,NHIDT,NHI)) Q:NHI<1  D
 ... K NHITM S SUB=$S("CH^MI"[NHSUB:NHSUB,1:"AP")_"(.NHITM)"
 ... D @SUB,XML(.NHITM)
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
CH(LAB) ; -- return a Chemistry result in LAB("attribute")=value
 ;      Expects ^TMP("LRRR",$J,DFN,"CH",NHIDT,NHI),LRDFN
 N CDT,LR0,LRI,X0,X,LOINC,ORD,CMMT K LAB
 S LAB("id")="CH;"_NHIDT_";"_NHI,LAB("type")="CH"
 S CDT=9999999-NHIDT,LAB("collected")=CDT
 S LR0=$G(^LR(LRDFN,"CH",NHIDT,0)),LRI=$G(^(NHI))
 S LAB("status")="completed",LAB("resulted")=$P(LR0,U,3)
 S X0=$G(^TMP("LRRR",$J,DFN,"CH",NHIDT,NHI))
 S LAB("test")=$P($G(^LAB(60,+X0,0)),U) ;$P(X0,U,10)?
 S:$L($P(X0,U,2)) LAB("result")=$P(X0,U,2)
 S:$L($P(X0,U,4)) LAB("units")=$P(X0,U,4)
 S:$L($P(X0,U,3)) LAB("interpretation")=$P(X0,U,3)
 S X=$P(X0,U,5) I $L(X),X["-" S LAB("low")=$P(X,"-"),LAB("high")=$P(X,"-",2)
 S LAB("localName")=$S($L($P(X0,U,15)):$P(X0,U,15),1:LAB("test"))
 S LAB("groupName")=$P(X0,U,16) ;accession#
 S X=$P($P(LRI,U,3),"!",3) S:X LOINC=$$GET1^DIQ(95.3,X_",",.01)
 S X=+$P(X0,U,19) I X D  ;specimen
 . N VUID,IENS,NHY S VUID="",IENS=X_","
 . D GETS^DIQ(61,IENS,".01;2",,"NHY")
 . S LAB("specimen")=$G(NHY(61,IENS,2))_U_$G(NHY(61,IENS,.01)) ;SNOMED^name
 . S LAB("sample")=$$GET1^DIQ(61,X_",",4.1) ;name
 . ; LOINC=+$G(^LAB(60,+X0,1,X,95.3))
 . S:'$G(LOINC) LOINC=$$GET1^DIQ(60.01,X_","_+X0_",",95.3)
 . I LOINC S LAB("loinc")=LOINC,VUID=$$VUID^NHINV(+LOINC,95.3)
 . S:VUID LAB("vuid")=VUID
 S ORD=+$P(X0,U,17) S:ORD LAB("labOrderID")=ORD
 S X=$$ORDER(ORD,+X0) S:X LAB("orderID")=X
 S X=$P(LR0,U,14)
 S:X LAB("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 I 'X S LAB("facility")=$$FAC^NHINV ;local stn#^name
 I $D(^TMP("LRRR",$J,DFN,"CH",NHIDT,"N")) M CMMT=^("N") S LAB("comment")=$$STRING^NHINV(.CMMT)
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
 ;    Expects ^TMP("LRRR",$J,DFN,"MI",NHIDT,NHI),LRDFN
 N ID,CDT,X0,X,CMMT,LR0 K LAB
 S X0=$G(^TMP("LRRR",$J,DFN,"MI",NHIDT,NHI)) Q:$L($P(X0,U))'>1
 S LAB("id")="MI;"_NHIDT_"#"_NHI,LAB("status")="completed"
 S LAB("type")="MI",CDT=9999999-NHIDT,LAB("collected")=CDT
 S LR0=$G(^LR(LRDFN,"MI",NHIDT,0)),LAB("resulted")=$P(LR0,U,3)
 S:$L($P(X0,U,2)) LAB("result")=$P(X0,U,2)
 S:$L($P(X0,U,4)) LAB("units")=$P(X0,U,4)
 S:$L($P(X0,U,3)) LAB("interpretation")=$P(X0,U,3)
 S (LAB("test"),LAB("localName"))=$P(X0,U,15)
 S X=+$P(X0,U,19) I X D  ;specimen
 . N IENS,NHY S IENS=X_","
 . D GETS^DIQ(61,IENS,".01;2",,"NHY")
 . S LAB("specimen")=$G(NHY(61,IENS,2))_U_$G(NHY(61,IENS,.01)) ;SNOMED^name
 . S LAB("sample")=$$GET1^DIQ(61,X_",",4.1) ;name
 S X=$P(LR0,U,14)
 S:X LAB("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 I 'X S LAB("facility")=$$FAC^NHINV ;local stn#^name
 I $D(^TMP("LRRR",$J,DFN,"MI",NHIDT,"N")) M CMMT=^("N") S LAB("comment")=$$STRING^NHINV(.CMMT)
 Q
 ;
AP(LAB) ; -- return a Pathology result in LAB("attribute")=value
 K LAB ;not implemented yet
 Q
 ;
TYPE(X) ; -- Return name of lab section
 N NHIY,Y S Y=X
 D FIND^DIC(68,,.01,"PQX",X,,"B",,,"NHIY")
 S:$G(NHIY("DILIST",1,0)) Y=$P(NHIY("DILIST",1,0),U,2) ;name
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(LAB) ; -- Return result as XML in @NHIN@(#)
 N ATT,X,Y,P,NAMES,TAG
 D ADD("<lab>") S NHINTOTL=$G(NHINTOTL)+1
 S ATT="" F  S ATT=$O(LAB(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S X=$G(LAB(ATT)),Y="" Q:'$L(X)
 . I ATT="comment" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^NHINV(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^NHINV(X)_"' />" Q
 . I $L(X)>1 D  S Y=""
 .. S Y="<"_ATT_" ",NAMES="code^name^Z"
 .. F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^NHINV($P(X,U,P))_"' "
 .. S Y=Y_"/>" D ADD(Y)
 D ADD("</lab>")
 Q
 ;
ADD(X) ; -- Add a line @NHIN@(n)=X
 S NHINI=$G(NHINI)+1
 S @NHIN@(NHINI)=X
 Q
