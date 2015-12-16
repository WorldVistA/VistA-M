VPRDTIU ;SLC/MKB -- TIU extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,2,4,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC(                         10040
 ; ^TIU(8925.1              2321,5677
 ; ^TIU(8926.1                   5678
 ; ^VA(200                      10060
 ; DIQ                           2056
 ; RAO7PC1                       2043
 ; TIUCNSLT                      5546
 ; TIUCP                         3568
 ; TIULQ                         2693
 ; TIULX                         3058
 ; TIUSROI                       5676
 ; TIUSRVLO                 2834,2865
 ; TIUSRVR1                      2944
 ; XLFSTR                       10104
 ;
 ; ------------ Get documents from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's documents
 N VPRITM,VPRN,VPRX,VPRY,VPRCNT
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 ;
 ; get one document
 I $L($G(ID)),ID[";" D  G ENQ
 . I ID D RPT1^VPRDMC(DFN,ID,.VPRITM),XML(.VPRITM) Q  ;CP
 . D RPT1^VPRDLRA(DFN,ID,.VPRITM),XML(.VPRITM) Q      ;Lab
 I $G(ID),ID["-" D  G ENQ                             ;Radiology
 . S (BEG,END)=9999999.9999-+ID D EN1^RAO7PC1(DFN,BEG,END,"99P")
 . D RPT1^VPRDRA(DFN,ID,.VPRITM),XML(.VPRITM)
 . K ^TMP($J,"RAE1")
 I $G(ID) D EN1(ID,.VPRITM),XML(.VPRITM):$D(VPRITM) G ENQ
 ;
 ; get all documents
 N CLASS,SUBCLASS,TITLE,SERVICE,SUBJECT,NOTSUBJ,STATUS,VPRC,CLS,VPRS,CTXT
 D SETUP S VPRCNT=0 ;define search criteria
 I CLASS="CP" D RPTS^VPRDMC(DFN,BEG,END,MAX) Q
 I CLASS="RA" D RPTS^VPRDRA(DFN,BEG,END,MAX) Q
 I CLASS="LR" D RPTS^VPRDLRA(DFN,BEG,END,MAX) Q
 F VPRC=1:1:$L(CLASS,U) S CLS=$P(CLASS,U,VPRC) D  Q:VPRCNT'<MAX
 . F VPRS=1:1:$L(STATUS,U) S CTXT=$P(STATUS,U,VPRS) D  Q:VPRCNT'<MAX
 .. D CONTEXT^TIUSRVLO(.VPRY,CLS,CTXT,DFN,BEG,END,,,,1)
 .. S VPRN=0 F  S VPRN=$O(@VPRY@(VPRN)) Q:VPRN<1  D  Q:VPRCNT'<MAX
 ... S VPRX=$G(@VPRY@(VPRN)) Q:'$$MATCH(VPRX)
 ... K VPRITM D EN1(VPRX,.VPRITM) Q:'$D(VPRITM)
 ... D XML(.VPRITM) S VPRCNT=VPRCNT+1
 .. K @VPRY
ENQ ; end
 K ^TMP("VPRTEXT",$J)
 Q
 ;
EN1(VPRX,DOC) ; -- return a document in DOC("attribute")=value
 ;  Expects DFN, VPRX=IEN^$$RESOLVE^TIUSRVLO(IEN)
 N IEN,X,NAME,VPRTIU,ES,I,VPRY
 K DOC,^TMP("VPRTEXT",$J)
 S IEN=+$G(VPRX) Q:IEN<1  ;invalid ien
 I +VPRX=VPRX D  ;get data string, if needed
 . N SHOWADD,DA S SHOWADD=1,DA=+VPRX
 . S VPRX=DA_U_$$RESOLVE^TIUSRVLO(DA)
 Q:"UNKNOWN"[$P($G(VPRX),U,2)  ;null or invalid
 S NAME=$P(VPRX,U,2) ;I $P(VPRX,U,14),$P(NAME," ")="Addendum" Q
 S DOC("id")=IEN,DOC("localTitle")=NAME
 D EXTRACT^TIULQ(IEN,"VPRTIU",,".01:.04;1501:1508")
 S X=$$GET1^DIQ(8925,IEN_",",".01:1501","I") I X D
 . N IENS,TIU,Y,FNUM
 . S IENS=X_"," D GETS^DIQ(8926.1,IENS,"*","IE","TIU")
 . S DOC("nationalTitle")=$G(TIU(8926.1,IENS,99.99,"E"))_U_$G(TIU(8926.1,IENS,.01,"E"))
 . F I=".04^Subject^2",".05^Role^3",".06^Setting^4",".07^Service^5",".08^Type^6" D
 .. S Y=+$G(TIU(8926.1,IENS,+I,"I")) Q:Y'>0
 .. S FNUM="8926."_+$P(I,U,3)
 .. S DOC("nationalTitle"_$P(I,U,2))=$$VUID^VPRD(Y,FNUM)_U_$G(TIU(8926.1,IENS,+I,"E"))
 S:$G(FILTER("loinc")) DOC("loinc")=$P(FILTER("loinc"),U)
 S X=+$G(VPRTIU(IEN,.01,"I")),X=$$CATG(X),(DOC("type"),DOC("category"))=X
 S DOC("documentClass")=$S(X="LR":"LR LABORATORY REPORTS",X="SR":"SURGICAL REPORTS",X="CP":"CLINICAL PROCEDURES",X="DS":"DISCHARGE SUMMARY",1:"PROGRESS NOTES")
 S DOC("referenceDateTime")=$P(VPRX,U,3)
 S X=$P(VPRX,U,6) D  ;S:$L(X) DOC("location")=X
 . N LOC S LOC=$S($L(X):+$O(^SC("B",X,0)),1:0)
 . S DOC("facility")=$$FAC^VPRD(LOC)
 S X=$P(VPRX,U,7) S:$L(X) DOC("status")=X
 S:$P(VPRX,U,11) DOC("images")=+$P(VPRX,U,11)
 S:$L($P(VPRX,U,12)) DOC("subject")=$P(VPRX,U,12)
 ; X=$S($P(VPRX,U,13)[">":"C",$P(VPRX,U,13)["<":"I",1:"") ;componentType
 I $P(VPRX,U,14)>5 S DOC("parent")=$P(VPRX,U,14) ;ID notes
 S DOC("encounter")=$G(VPRTIU(IEN,.03,"I"))
 S:$G(VPRTEXT) DOC("content")=$$TEXT(IEN)
 ; providers &/or signatures
 S X=$P(VPRX,U,5),I=0               ;author
 S:X I=I+1,DOC("clinician",I)=+X_U_$P(X,";",3)_"^A^^^"_$$PROVSPC^VPRD(+X)
 M ES=VPRTIU(IEN) I ES(1501,"I") D  ;signed
 . S I=I+1,X=ES(1502,"I")
 . S DOC("clinician",I)=X_U_ES(1502,"E")_"^S^"_ES(1501,"I")_U_$$SIG(X)_U_$$PROVSPC^VPRD(X)
 I ES(1507,"I") D                   ;cosigned
 . S I=I+1,X=ES(1508,"I")
 . S DOC("clinician",I)=X_U_ES(1508,"E")_"^C^"_ES(1507,"I")_U_$$SIG(X)_U_$$PROVSPC^VPRD(X)
 Q
 ;
CATG(DA) ; -- Return a code for document type #8925.1 DA
 N X
 D ISCNSLT^TIUCNSLT(.X,DA) I X Q "CR"  ;consult result
 I $$ISA^TIULX(DA,25) Q "A"            ;CWAD note/Allergy
 I $$ISA^TIULX(DA,27) Q "D"            ;CWAD note/Advance Directive
 I $$ISA^TIULX(DA,30) Q "C"            ;CWAD note/Crisis Note
 I $$ISA^TIULX(DA,31) Q "W"            ;CWAD note/Clinical Warning
 I $$ISA^TIULX(DA,3) Q "PN"            ;progress note
 ;
 I $$ISA^TIULX(DA,244) Q "DS"          ;discharge summary
 D ISCP^TIUCP(.X,DA) I X Q "CP"        ;clinical procedure
 D ISSURG^TIUSROI(.X,DA) I X Q "SR"    ;surgery
 I $$ISA^TIULX(DA,$$LR) Q "LR"         ;laboratory
 Q ""
 ;
LR() ; -- Return ien of Lab class
 N Y S Y=+$O(^TIU(8925.1,"B","LR LABORATORY REPORTS",0))
 I Y>0,$S($P($G(^TIU(8925.1,Y,0)),U,4)="CL":0,$P($G(^(0)),U,4)="DC":0,1:1) S Y=0
 Q Y
 ;
SIG(X) ; -- Return Signature Block Name_Title
 N X20,Y S X20=$G(^VA(200,+$G(X),20))
 S Y=$P(X20,U,2)_" "_$P(X20,U,3)
 Q Y
 ;
RPT(VPRY,IFN) ; -- Return text of document in @VPRY@(n)
 N I,J ;protect for calling loops
 D TGET^TIUSRVR1(.VPRY,IFN)
 Q
 ;
TEXT(VPRIFN) ; -- Get document IFN text, return temp array name
 N VPRY,Y
 N IEN,IFN,CLASS,STATUS,CNT,X0,X,I,J ;protect for calling loops
 S VPRIFN=+$G(VPRIFN) D TGET^TIUSRVR1(.VPRY,VPRIFN)
 M ^TMP("VPRTEXT",$J,VPRIFN)=@VPRY K @VPRY
 S Y=$NA(^TMP("VPRTEXT",$J,VPRIFN))
 Q Y
 ;
INFO(IFN) ; -- Returns ien^localTitle^natlTitle^VUID
 ; or -1^STATUS if not viewable
 N X,Y,VPRTIU,LT,NT,VUID,I,J S IFN=+$G(IFN)
 I '$D(^TIU(8925,IFN,0)) Q "-1^DELETED"
 D EXTRACT^TIULQ(IFN,"VPRTIU",,".01;.05")
 I VPRTIU(IFN,.05,"I")<7!(VPRTIU(IFN,.05,"I")>13) Q "-1^"_VPRTIU(IFN,.05,"E")
 S LT=$G(VPRTIU(IFN,.01,"E")),VUID=""
 I $P(LT," ")="Addendum" Q "-1^ADDENDUM"
 S NT=$P($G(^TIU(8925.1,+$G(VPRTIU(IFN,.01,"I")),15)),U) I NT D
 . S VUID=$$VUID^VPRD(+NT,8926.1)
 . S NT=$$GET1^DIQ(8926.1,+NT_",",.01)
 S Y=IFN_U_LT_U_NT_U_VUID
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(DOC) ; -- Return patient documents as XML
 N ATT,X,Y,NAMES,TYPE,I
 D ADD("<document>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(DOC(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(DOC(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(DOC(ATT,I)) Q:I<1  D
 ... S X=$G(DOC(ATT,I)),NAMES=""
 ... I ATT="clinician" S NAMES="code^name^role^dateTime^signature^"_$$PROVTAGS^VPRD_"^Z"
 ... S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(DOC(ATT)),Y="" Q:'$L(X)
 . I ATT="content" D  S Y="" Q  ;text
 .. S Y="<content xml:space='preserve'>" D ADD(Y)
 .. S I=0 F  S I=$O(@X@(I)) Q:I<1  S Y=$$ESC^VPRD(@X@(I)) D ADD(Y)
 .. D ADD("</content>")
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 S NAMES="code^name^Z",Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</document>")
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
 ; ------------ Get/apply search criteria ------------
 ;
SETUP ; -- convert FILTER("attribute") = value to TIU criteria
 ; Expects: FILTER("category") = code (see $$CATG)
 ;          FILTER("loinc")    = LOINC
 ;          FILTER("status")   = 'all','completed','unsigned'
 ; Returns CLASS,[SUBCLASS,TITLE,SERVICE,SUBJECT,STATUS]
 ;
 N LOINC,TYPE,STS,CP
 S LOINC=+$G(FILTER("loinc")),TYPE=$$UP^XLFSTR($G(FILTER("category")))
 S CLASS="3^244",(SUBCLASS,TITLE,SERVICE,SUBJECT,NOTSUBJ,STATUS)=""
 ;
 ; status [default='complete']
 S STS=$$LOW^XLFSTR($G(FILTER("status")))
 S STATUS=$S(STS?1"unsig".E:2,STS="all":"5^2",1:5)  ;TIUSRVLO statuses
 ;
 ; progress notes
 I TYPE="PN" S CLASS=3 Q
 I TYPE="CR"!(LOINC=11488) S CLASS=3,SUBCLASS=+$$CLASS^TIUCNSLT Q
 ; LOINC=26442 S CLASS=3,SUBJECT="^114^" Q         ;OB/GYN
 I LOINC=34117 S CLASS=3,SERVICE="^88^" Q          ;H&P
 I TYPE="CWAD" S CLASS=3,SUBCLASS="25^27^30^31" Q  ;CWAD
 I TYPE="C" S CLASS=3,SUBCLASS=30 Q                ;Crisis Note
 I TYPE="W" S CLASS=3,SUBCLASS=31 Q                ;Clinical Warning
 I TYPE="A" S CLASS=3,SUBCLASS=25 Q                ;Allergy Note
 I TYPE="D"!(LOINC=42348) S CLASS=3,SUBCLASS=27 Q  ;Advance Directive
 ;
 ; discharge summaries
 I TYPE="DS"!(LOINC=18842) S CLASS=244 Q
 ;
 ; procedures
 I TYPE="SR"!(LOINC=29752) S CLASS=+$$CLASS^TIUSROI("SURGICAL REPORTS") Q
 D CPCLASS^TIUCP(.CP)
 I TYPE="CP" S CLASS=$S(STATUS=2:CP,1:"CP") Q       ;CLINICAL PROCEDURES
 I LOINC=26441 D  Q                                 ;CARDIOLOGY
 . S CLASS=CP_"^3"
 . S SUBJECT="^18^142^174^",SERVICE="^75^76^115^"
 I LOINC=27896 D  Q                                 ;PULMONARY
 . S CLASS=CP_"^3"
 . S SUBJECT="^23^142^",SERVICE="^75^76^115^"
 I LOINC=27895 D  Q                                 ;GASTROENTEROLOGY
 . S CLASS=CP_"^3"
 . S SUBJECT="^20^",SERVICE="^75^76^115^"
 I LOINC=27897 D  Q                                 ;NEUROLOGY
 . S CLASS=CP_"^3"
 . S SUBJECT="^44^45^52^111^112^143^146^",SERVICE="^75^76^115^"
 I LOINC=28619 D  Q                                 ;OPHTH/OPTOMETRY
 . S CLASS=CP_"^3"
 . S SUBJECT="^13^14^103^",SERVICE="^75^76^115^"
 I LOINC=28634 D  Q                                 ;MISC/ALL OTHERS
 . S CLASS=CP_"^3",SERVICE="^75^76^115^"
 . S NOTSUBJ="^18^142^174^23^142^20^44^45^52^111^112^143^146^13^14^103^"
 I LOINC=28570 D  Q                                 ;UNSPECIFIED/ALL
 . S CLASS=CP_"^3"
 . S SERVICE="^75^76^115^"
 ;
 ; pathology/lab
 I TYPE="LR"!(LOINC=27898) S CLASS=$S(STATUS=2:$$LR,1:"LR") Q
 ;
 ; radiology
 I TYPE="RA"!(LOINC=18726) S CLASS="RA" Q
 ;
 ; unknown
 I $L(TYPE)!LOINC S CLASS=0
 Q
 ;
MATCH(DOC) ; -- Return 1 or 0, if document DA matches search criteria
 N Y,DA,LOCAL,NATL,X0,OK S Y=0
 S DA=+$G(DOC) G:DA<1 MQ
 ; both parent + addenda returned by TIU if any match search criteria
 ; include addenda if pulling only unsigned items:
 I $P(DOC,U,2)?1"Addendum ".E,STATUS'=2 G MQ
 ; remove completed parent notes from TIU unsigned list:
 I CTXT=2,$P(DOC,U,7)'="unsigned" G MQ
 ; remove Uncosigned notes from 'complete' view:
 I STATUS=5,$P(DOC,U,7)="uncosigned" G MQ
 ; Check title & attributes for a match ...
 S LOCAL=$$GET1^DIQ(8925,DA_",",.01,"I") ;local Title 8925.1 ien
 I $L(SUBCLASS) D  G:'OK MQ
 . N I,X S OK=0
 . F I=1:1:$L(SUBCLASS,"^") S X=$P(SUBCLASS,U,I) I $$ISA^TIULX(LOCAL,X) S OK=1 Q
 S NATL=+$$GET1^DIQ(8925.1,LOCAL_",",1501,"I") ;Natl Title 8926.1 ien
 I $L(TITLE) G:TITLE'[(U_+NATL_U) MQ
 S X0=$G(^TIU(8926.1,NATL,0))
 I $L(SERVICE) G:SERVICE'[(U_+$P(X0,U,7)_U) MQ
 I $L(SUBJECT) G:SUBJECT'[(U_+$P(X0,U,4)_U) MQ
 I $L(NOTSUBJ) G:NOTSUBJ[(U_+$P(X0,U,4)_U) MQ
 S Y=1
MQ Q Y
