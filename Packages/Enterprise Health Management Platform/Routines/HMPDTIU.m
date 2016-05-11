HMPDTIU ;SLC/MKB,ASMR/RRB - TIU extract;Nov 23, 2015 18:02:20
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
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
 Q
 ; ------------ Get documents from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's documents
 N HMPITM,HMPN,HMPX,HMPY,HMPCNT
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 ;
 ; get one document
 I $L($G(ID)),ID[";" D  G ENQ
 . I ID D RPT1^HMPDMC(DFN,ID,.HMPITM),XML(.HMPITM) Q  ;CP
 . D RPT1^HMPDLRA(DFN,ID,.HMPITM),XML(.HMPITM) Q      ;Lab
 I $G(ID),ID["-" D  G ENQ                             ;Radiology
 . S (BEG,END)=9999999.9999-+ID D EN1^RAO7PC1(DFN,BEG,END,"99P")
 . D RPT1^HMPDRA(DFN,ID,.HMPITM),XML(.HMPITM)
 . K ^TMP($J,"RAE1")
 I $G(ID) D EN1(ID,.HMPITM),XML(.HMPITM):$D(HMPITM) G ENQ
 ;
 ; get all documents
 N CLASS,SUBCLASS,TITLE,SERVICE,SUBJECT,NOTSUBJ,STATUS,HMPC,CLS,HMPS,CTXT
 D SETUP S HMPCNT=0 ;define search criteria
 I CLASS="CP" D RPTS^HMPDMC(DFN,BEG,END,MAX) Q
 I CLASS="RA" D RPTS^HMPDRA(DFN,BEG,END,MAX) Q
 I CLASS="LR" D RPTS^HMPDLRA(DFN,BEG,END,MAX) Q
 F HMPC=1:1:$L(CLASS,U) S CLS=$P(CLASS,U,HMPC) D  Q:HMPCNT'<MAX
 . F HMPS=1:1:$L(STATUS,U) S CTXT=$P(STATUS,U,HMPS) D  Q:HMPCNT'<MAX
 .. D CONTEXT^TIUSRVLO(.HMPY,CLS,CTXT,DFN,BEG,END,,MAX,,1)
 .. S HMPN=0 F  S HMPN=$O(@HMPY@(HMPN)) Q:HMPN<1  D  Q:HMPCNT'<MAX
 ... S HMPX=$G(@HMPY@(HMPN)) Q:'$$MATCH(HMPX,$G(SUBCLASS),$G(SERVICE),$G(SUBJECT),$G(NOTSUBJ))
 ... Q:$D(^TMP("HMPD",$J,+HMPX))  ;already included
 ... K HMPITM D EN1(HMPX,.HMPITM) Q:'$D(HMPITM)
 ... D XML(.HMPITM) S HMPCNT=HMPCNT+1
 .. K @HMPY
ENQ ; end
 K ^TMP("HMPTEXT",$J)
 Q
 ;
EN1(HMPX,DOC) ; -- return a document in DOC("attribute")=value
 ;  Expects DFN, HMPX=IEN^$$RESOLVE^TIUSRVLO(IEN)
 N IEN,X,NAME,HMPTIU,ES,I,HMPY
 K DOC,^TMP("HMPTEXT",$J)
 S IEN=+$G(HMPX) Q:IEN<1  ;invalid ien
 I +HMPX=HMPX D  ;get data string, if needed
 . N SHOWADD,DA S SHOWADD=1,DA=+HMPX
 . S HMPX=DA_U_$$RESOLVE^TIUSRVLO(DA)
 Q:"UNKNOWN"[$P($G(HMPX),U,2)  ;null or invalid
 S NAME=$P(HMPX,U,2) ;I $P(HMPX,U,14),$P(NAME," ")="Addendum" Q
 S DOC("id")=IEN,DOC("localTitle")=NAME
 D EXTRACT^TIULQ(IEN,"HMPTIU",,".01:.04;1501:1508")
 S X=$$GET1^DIQ(8925,IEN_",",".01:1501","I") I X D
 . N IENS,TIU,Y,FNUM
 . S IENS=X_"," D GETS^DIQ(8926.1,IENS,"*","IE","TIU")
 . S DOC("nationalTitle")=$G(TIU(8926.1,IENS,99.99,"E"))_U_$G(TIU(8926.1,IENS,.01,"E"))
 . F I=".04^Subject^2",".05^Role^3",".06^Setting^4",".07^Service^5",".08^Type^6" D
 .. S Y=+$G(TIU(8926.1,IENS,+I,"I")) Q:Y'>0
 .. S FNUM="8926."_+$P(I,U,3)
 .. S DOC("nationalTitle"_$P(I,U,2))=$$VUID^HMPD(Y,FNUM)_U_$G(TIU(8926.1,IENS,+I,"E"))
 S:$G(FILTER("loinc")) DOC("loinc")=$P(FILTER("loinc"),U)
 S X=+$G(HMPTIU(IEN,.01,"I")),X=$$CATG(X),(DOC("type"),DOC("category"))=X
 S DOC("documentClass")=$S(X="LR":"LR LABORATORY REPORTS",X="SR":"SURGICAL REPORTS",X="CP":"CLINICAL PROCEDURES",X="DS":"DISCHARGE SUMMARY",1:"PROGRESS NOTES")
 S DOC("referenceDateTime")=$P(HMPX,U,3)
 S X=$P(HMPX,U,6) D  ;S:$L(X) DOC("location")=X
 . ; DE2818, ICR 10040 for ^SC, this doesn't handle duplicate entries and should be corrected
 . N LOC S LOC=$S($L(X):+$O(^SC("B",X,0)),1:0)
 . S DOC("facility")=$$FAC^HMPD(LOC)
 S X=$P(HMPX,U,7) S:$L(X) DOC("status")=X
 S:$P(HMPX,U,11) DOC("images")=+$P(HMPX,U,11)
 S:$L($P(HMPX,U,12)) DOC("subject")=$P(HMPX,U,12)
 ; X=$S($P(HMPX,U,13)[">":"C",$P(HMPX,U,13)["<":"I",1:"") ;componentType
 I $P(HMPX,U,14)>5 S DOC("parent")=$P(HMPX,U,14) ;ID notes
 S DOC("encounter")=$G(HMPTIU(IEN,.03,"I"))
 S:$G(HMPTEXT) DOC("content")=$$TEXT(IEN)
 ; providers &/or signatures
 S X=$P(HMPX,U,5),I=0 S:X I=I+1,DOC("clinician",I)=+X_U_$P(X,";",3)_"^A" ;author
 M ES=HMPTIU(IEN) I ES(1501,"I") D
 . S I=I+1
 . S DOC("clinician",I)=ES(1502,"I")_U_ES(1502,"E")_"^S^"_ES(1501,"I")_U_$$SIG(ES(1502,"I"))
 I ES(1507,"I") D  ; cosigner
 . S I=I+1
 . S DOC("clinician",I)=ES(1508,"I")_U_ES(1508,"E")_"^C^"_ES(1507,"I")_U_$$SIG(ES(1508,"I"))
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
 N Y S Y=+$O(^TIU(8925.1,"B","LR LABORATORY REPORTS",0))  ;DE2818, ICRs 2700 and 5677
 I Y>0,$S($P($G(^TIU(8925.1,Y,0)),U,4)="CL":0,$P($G(^(0)),U,4)="DC":0,1:1) S Y=0
 Q Y
 ;
SIG(X) ; -- Return Signature Block Name_Title
 N X20,Y S X20=$G(^VA(200,+$G(X),20))
 S Y=$P(X20,U,2)_" "_$P(X20,U,3)
 Q Y
 ;
RPT(HMPY,IFN) ; -- Return text of document in @HMPY@(n)
 N I,J ;protect for calling loops
 D TGET^TIUSRVR1(.HMPY,IFN)
 Q
 ;
TEXT(IFN) ; -- Get document IFN text, return temp array name
 N HMPY,Y,I,J ;protect I&J for calling loops
 S IFN=+$G(IFN) D TGET^TIUSRVR1(.HMPY,IFN)
 M ^TMP("HMPTEXT",$J,IFN)=@HMPY K @HMPY
 S Y=$NA(^TMP("HMPTEXT",$J,IFN))
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(DOC) ; -- Return patient documents as XML
 N ATT,X,Y,NAMES,TYPE,I
 D ADD("<document>") S HMPTOTL=$G(HMPTOTL)+1
 S ATT="" F  S ATT=$O(DOC(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(DOC(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(DOC(ATT,I)) Q:I<1  D
 ... S X=$G(DOC(ATT,I)),NAMES=""
 ... I ATT="clinician" S NAMES="code^name^role^dateTime^signature^Z"
 ... S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(DOC(ATT)),Y="" Q:'$L(X)
 . I ATT="content" D  S Y="" Q  ;text
 .. S Y="<content xml:space='preserve'>" D ADD(Y)
 .. S I=0 F  S I=$O(@X@(I)) Q:I<1  S Y=$$ESC^HMPD(@X@(I)) D ADD(Y)
 .. D ADD("</content>")
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^HMPD(X)_"' />" Q
 . I $L(X)>1 S NAMES="code^name^Z",Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</document>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; Add a line @HMP@(n)=X
 S HMPI=$G(HMPI)+1
 S @HMP@(HMPI)=X
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
 ;DE2818 begin, changed function below to use FileMan for ^TIU(8926.1) references, ICR 5678
MATCH(DOC,SBCLSS,SRVC,SBJCT,NTSBJ) ; Boolean function, Return 1 or 0, if document matches search criteria
 ; DOC - IEN in TIU DOCUMENT file (#8925)
 ; SBCLSS - subclass
 ; SRVC - service
 ; two pointers to TIU LOINC SUBJECT MATTER DOMAIN (#8926.2):
 ;    SBJCT - subject to include, NTSUBJ - subject to exclude
 N DA,HMSBJMD,LOCAL,NATL,OK,Y
 ; Y is the return value
 S Y=0,DA=+$G(DOC) G:DA<1 MQ
 ; include addenda if pulling only unsigned items
 I $P(DOC,U,2)?1"Addendum ".E,STATUS'=2 G MQ
 ; TIU unsigned list can include completed parent notes
 I CTXT=2,$P(DOC,U,7)'="unsigned" G MQ
 S LOCAL=$$GET1^DIQ(8925,DA_",",.01,"I") ;local Title 8925.1 ien
 I $L(SBCLSS) D  G:'OK MQ
 . N I,X S OK=0
 . F I=1:1:$L(SBCLSS,U) S X=$P(SBCLSS,U,I) I $$ISA^TIULX(LOCAL,X) S OK=1 Q
 S NATL=+$$GET1^DIQ(8925.1,LOCAL_",",1501,"I") ;Natl Title 8926.1 ien
 I $L(TITLE) G:TITLE'[(U_+NATL_U) MQ
 ;S X0=$G(^TIU(8926.1,NATL,0))
 I $L(SRVC) G:SRVC'[(U_$$GET1^DIQ(8926.1,NATL_",",.07,"I")_U) MQ  ;(#.07) SERVICE
 S HMSBJMD=+$$GET1^DIQ(8926.1,NATL_",",.07,"I")  ;(#.04) SUBJECT MATTER DOMAIN
 I $L(SBJCT) G:SBJCT'[(U_HMSBJMD_U) MQ
 I $L(NTSBJ) G:NTSBJ[(U_HMSBJMD_U) MQ
 S Y=1
MQ Q Y
 ;
