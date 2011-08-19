NHINVTIU ;SLC/MKB -- TIU extract
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC(                         10040
 ; ^VA(200                      10060
 ; DIQ                           2056
 ; TIUSRVLO                 2834,2865
 ; TIUSRVR1                      2944
 ;
 ; ------------ Get documents from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's documents
 N NHITM,NHI,NHX,NHY,NHDAD
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 ;
 ; get one document
 I $L($G(ID)),ID[";" D RPT^NHINVLRA(DFN,ID,.NHITM),XML(.NHITM) Q  ;Lab
 I $G(ID),ID["-" D RPT^NHINVRA(DFN,ID,.NHITM),XML(.NHITM) Q  ;Radiology
 I $G(ID) D  Q
 . N SHOWADD S SHOWADD=1
 . S NHX=ID_U_$$RESOLVE^TIUSRVLO(ID)
 . D EN1(ID,.NHITM),XML(.NHITM)
 ;
 ; get all documents via
 D CONTEXT^TIUSRVLO(.NHY,3,1,DFN,BEG,END,,MAX,,1)
 S NHI=0 F  S NHI=$O(@NHY@(NHI)) Q:NHI<1  D
 . S NHX=$G(@NHY@(NHI)),IFN=+NHX
 . K NHITM D EN1(IFN,.NHITM)
 . D:$D(NHITM) XML(.NHITM)
 Q
 ;
EN1(IEN,DOC) ; -- return a document in DOC("attribute")=value
 ;  Expects DFN, NHX=IEN ^ $$RESOLVE^TIUSRVLO(IEN)
 N X,NAME,NHINX,ES,I K DOC
 S IEN=+$G(IEN) Q:IEN<1  ;invalid ien
 Q:"UNKNOWN"[$P($G(NHX),U,2)  ;null or invalid
 S DOC("id")=IEN,NAME=$P(NHX,U,2),DOC("localTitle")=NAME
 I $P(NHX,U,14),$P(NAME," ")="Addendum" D  Q
 . N DATE,PARENT K DOC
 . S DATE=$P(NHX,U,3),PARENT=$P(NHX,U,14)
 . I DATE,PARENT>1 S NHDAD(PARENT,DATE)=NHX
 S X=$$GET1^DIQ(8925,IEN_",",".01:1501") S:$L(X) DOC("nationalTitle")=X
 S X=$$GET1^DIQ(8925,IEN_",",".01:1501:99.99") S:$L(X) DOC("nationalTitleCode")=X
 S X=$$GET1^DIQ(8925,IEN_",",.04) S:$L(X) DOC("documentClass")=X
 S DOC("referenceDateTime")=$P(NHX,U,3)
 S X=$P(NHX,U,6) D  ;S:$L(X) DOC("location")=X
 . N LOC S LOC=$S($L(X):+$O(^SC("B",X,0)),1:0)
 . S DOC("facility")=$$FAC^NHINV(LOC)
 S X=$P(NHX,U,7) S:$L(X) DOC("status")=X
 S:$L($P(NHX,U,12)) DOC("subject")=$P(NHX,U,12)
 ; X=$S($P(NHX,U,13)[">":"C",$P(NHX,U,13)["<":"I",1:"") ;componentType
 S DOC("encounter")=$$GET1^DIQ(8925,IEN_",",.03,"I") ;$$VSTR(IEN)
 S DOC("content")=$$TEXT(IEN)
 ; providers &/or signatures
 S X=$P(NHX,U,5),I=0 S:X I=I+1,DOC("clinician",I)=+X_U_$P(X,";",3)_"^A" ;author
 D GETS^DIQ(8925,IEN_",","1501;1502;1507;1508","IE","NHINX")
 M ES=NHINX(8925,IEN_",") I ES(1501,"I") D
 . S I=I+1
 . S DOC("clinician",I)=ES(1502,"I")_U_ES(1502,"E")_"^S^"_ES(1501,"I")_U_$$SIG(ES(1502,"I"))
 I ES(1507,"I") D  ; cosigner
 . S I=I+1
 . S DOC("clinician",I)=ES(1508,"I")_U_ES(1508,"E")_"^C^"_ES(1507,"I")_U_$$SIG(ES(1508,"I"))
 Q
 ;
VSTR(DA) ; -- get visit string for document DA
 ;  Expects DFN, NHX = IEN ^ $$RESOLVE^TIUSRVLO(IEN)
 N VDT,VTYP,VLOC,Y
 S VDT=$P($P(NHX,U,8),";",2)
 S VTYP=$$GET1^DIQ(8925,DA_",",.13)
 S VLOC=$$GET1^DIQ(8925,DA_",",1211,"I")
 S Y=VLOC_";"_VDT_";"_VTYP
 Q Y
 ;
SIG(X) ; -- Return Signature Block Name_Title
 N X20,Y S X20=$G(^VA(200,+$G(X),20))
 S Y=$P(X20,U,2)_" "_$P(X20,U,3)
 Q Y
 ;
RPT(NHY,IFN) ; -- Return text of document in @NHY@(n)
 D TGET^TIUSRVR1(.NHY,IFN)
 Q
 ;
TEXT(IFN) ; -- Return document IFN as a text string
 N I,Y,NHY S IFN=+$G(IFN),Y=""
 I IFN D
 . D TGET^TIUSRVR1(.NHY,IFN)
 . S I=0 F  S I=$O(@NHY@(I)) Q:I<1  S Y=Y_$S($L(Y):$C(13,10),1:"")_@NHY@(I)
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(DOC) ; -- Return patient documents as XML
 N ATT,X,Y,NAMES,TYPE
 D ADD("<document>") S NHINTOTL=$G(NHINTOTL)+1
 S ATT="" F  S ATT=$O(DOC(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(DOC(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(DOC(ATT,I)) Q:I<1  D
 ... S X=$G(DOC(ATT,I)),NAMES=""
 ... I ATT="clinician" S NAMES="code^name^role^dateTime^signature^Z"
 ... S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(DOC(ATT)),Y="" Q:'$L(X)
 . I ATT="content" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^NHINV(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^NHINV(X)_"' />" Q
 . I $L(X)>1 S NAMES="code^name^Z",Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</document>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^NHINV($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; Add a line @NHIN@(n)=X
 S NHINI=$G(NHINI)+1
 S @NHIN@(NHINI)=X
 Q
