VPRDJ08 ;SLC/MKB -- Documents ;6/25/12  16:11
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC                          10040
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
 ; XLFSTR                       10104
 ;
 ; All tags expect DFN, ID, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;
TIU1(ID) ; -- document
 I ID[";" D   Q
 . I ID D EN1($$CP1^VPRDJ08A(DFN,ID),"CP") Q  ;CP
 . D EN1($$LR1^VPRDJ08A(DFN,ID),"LR") Q       ;Lab
 I ID["-" D  Q                                ;Radiology
 . S (BEG,END)=9999999.9999-+ID D EN1^RAO7PC1(DFN,BEG,END,"99P")
 . Q:'$D(^TMP($J,"RAE1",DFN,ID))              ;deleted
 . D EN1($$RA1^VPRDJ08A(DFN,ID),"RA") K ^TMP($J,"RAE1")
 D EN1(ID,38)
 Q
 ;
EN1(VPRX,TIU) ; -- document
 ;  Expects DFN, VPRX=IEN^$$RESOLVE^TIUSRVLO(IEN) or equivalent
 ;          TIU = document class#, or code (CP, RA, LR) if non-TIU
 N DOC,IEN,X,VPRTIU,ES,I,TEXT,SUB,VPRY,ERR
 S IEN=$P($G(VPRX),U),TIU=$G(TIU) Q:IEN=""  ;invalid ien
 ;
 I +VPRX=VPRX,TIU D  ;get TIU data string, if needed
 . N SHOWADD,DA S SHOWADD=1,DA=+VPRX
 . S VPRX=DA_U_$$RESOLVE^TIUSRVLO(DA)
 Q:"UNKNOWN"[$P($G(VPRX),U,2)  ;null or invalid
 S DOC("localId")=IEN,DOC("uid")=$$SETUID^VPRUTILS("document",DFN,IEN)
 S DOC("localTitle")=$P(VPRX,U,2)
 S DOC("referenceDateTime")=$$JSONDT^VPRUTILS($P(VPRX,U,3))
 S X=$P(VPRX,U,6) D  ;S:$L(X) DOC("location")=X
 . N LOC,FAC S LOC=$S($L(X):+$O(^SC("B",X,0)),1:0)
 . S X=$$FAC^VPRD(LOC)
 . S DOC("facilityCode")=$P(X,U),DOC("facilityName")=$P(X,U,2)
 S X=$P(VPRX,U,7) S:$L(X) DOC("statusName")=X
 S:$P(VPRX,U,11) DOC("images")=+$P(VPRX,U,11)
 S:$L($P(VPRX,U,12)) DOC("subject")=$P(VPRX,U,12)
 I $P(VPRX,U,14)>5 S DOC("parent")=$P(VPRX,U,14) ;ID notes
A ; national title
 S X=$S(TIU:$$GET1^DIQ(8925,IEN_",",".01:1501","I"),1:$P(VPRX,U,10))
 I X D  ;National Title + attributes
 . N IENS,TIU,Y,FNUM,NAME
 . S IENS=X_"," D GETS^DIQ(8926.1,IENS,"*","IE","TIU")
 . S DOC("nationalTitle","vuid")="urn:va:vuid:"_$G(TIU(8926.1,IENS,99.99,"E"))
 . S DOC("nationalTitle","title")=$G(TIU(8926.1,IENS,.01,"E"))
 . F I=".04^Subject^2",".05^Role^3",".06^Setting^4",".07^Service^5",".08^Type^6" D
 .. S Y=+$G(TIU(8926.1,IENS,+I,"I")) Q:Y'>0
 .. S FNUM="8926."_+$P(I,U,3),NAME=$$LOW^XLFSTR($P(I,U,2))
 .. S DOC("nationalTitle"_$P(I,U,2),"vuid")="urn:va:vuid:"_$$VUID^VPRD(Y,FNUM)
 .. S DOC("nationalTitle"_$P(I,U,2),NAME)=$G(TIU(8926.1,IENS,+I,"E"))
B ; other TIU data
 D:TIU EXTRACT^TIULQ(IEN,"VPRTIU",,".01:.05;.09;1201;1202;1208;1209;1301;1501:1508",,1,,1) ;".01:.04;1501:1508")
 S X=$G(VPRTIU(IEN,1201,"I")) S:X DOC("entered")=$$JSONDT^VPRUTILS(X)
 S X=$G(VPRTIU(IEN,.09,"E")) S:$L(X) DOC("urgency")=X
 S X=TIU I TIU S X=+$G(VPRTIU(IEN,.01,"I")),X=$$CATG^VPRDTIU(X) ;2U type code
 S DOC("documentTypeCode")=X,DOC("documentTypeName")=$$TYPE(X)
 S DOC("documentClass")=$S(X="LR":"LR LABORATORY REPORTS",X="SR":"SURGICAL REPORTS",X="CP":"CLINICAL PROCEDURES",X="RA":"RADIOLOGY REPORTS",X="DS":"DISCHARGE SUMMARY",1:"PROGRESS NOTES")
 S X=$S(TIU:$G(VPRTIU(IEN,.03,"I")),1:$P(VPRX,U,8))
 S:X DOC("encounterUid")=$$SETUID^VPRUTILS("visit",DFN,X),DOC("encounterName")=$$NAME^VPRDJ04(X)
C ; text blocks, signatures
 N VPRT,VPRA,VPRADD
 S DOC("text",1,"dateTime")=DOC("referenceDateTime")
 S DOC("text",1,"status")=$G(DOC("statusName"))
 S DOC("text",1,"uid")=DOC("uid")
 S VPRT=1,X=$P(VPRX,U,5),I=0
 I X D USER(.I,+X,$P(X,";",3),"A")    ;author
 M ES=VPRTIU(IEN) S X=$P(VPRX,"//",2) ;non-TIU, put into ES for use:
 I $L(X) S ES(1502,"I")=+X,ES(1502,"E")=$P(X,";",2),ES(1501,"I")=$P(X,";",3)
 I $G(ES(1501,"I")) D USER(.I,ES(1502,"I"),ES(1502,"E"),"S",ES(1501,"I")) ;signer
 I $G(ES(1507,"I")) D USER(.I,ES(1508,"I"),ES(1508,"E"),"C",ES(1507,"I")) ;cosigner
 I $G(ES(1208,"I")) D USER(.I,ES(1208,"I"),ES(1208,"E"),"X")     ;expected cosigner
 S X=+$G(ES(1209,"I")) I X D
 . S DOC("attendingUid")=$$SETUID^VPRUTILS("user",,X)
 . S DOC("attendingName")=$P($G(^VA(200,X,0)),U)
 I $G(VPRTEXT) D
 . S X=$S(TIU:$NA(VPRTIU(IEN,"TEXT")),1:$NA(^TMP("VPRTEXT",$J,IEN)))
 . K ^TMP($J,"VPR TIU TEXT")
 . D SETTEXT^VPRUTILS(X,$NA(^TMP($J,"VPR TIU TEXT")))
 . M DOC("text",1,"content","\")=^TMP($J,"VPR TIU TEXT")
D ; addenda
 S VPRA=0 F  S VPRA=$O(VPRTIU(IEN,"ZADD",VPRA)) Q:VPRA<1  D
 . S VPRT=VPRT+1,I=0 K VPRADD M VPRADD=VPRTIU(IEN,"ZADD",VPRA)
 . S DOC("text",VPRT,"status")=$G(VPRADD(.05,"E"))
 . S DOC("text",VPRT,"uid")=$$SETUID^VPRUTILS("document",DFN,VPRA)
 . S DOC("text",VPRT,"dateTime")=$$JSONDT^VPRUTILS($G(VPRADD(1301,"I")))
 . I $G(VPRADD(1202,"I")) D USER(.I,VPRADD(1202,"I"),VPRADD(1202,"E"),"A")
 . I $G(VPRADD(1501,"I")) D USER(.I,VPRADD(1502,"I"),VPRADD(1502,"E"),"S",VPRADD(1501,"I"))
 . I $G(VPRADD(1507,"I")) D USER(.I,VPRADD(1508,"I"),VPRADD(1508,"E"),"C",VPRADD(1507,"I"))
 . Q:'$G(VPRTEXT)  K ^TMP($J,"VPR TIU TEXT")
 . S X=$NA(VPRTIU(IEN,"ZADD",VPRA,"TEXT"))
 . D SETTEXT^VPRUTILS(X,$NA(^TMP($J,"VPR TIU TEXT")))
 . M DOC("text",VPRT,"content","\")=^TMP($J,"VPR TIU TEXT")
ENQ ; end
 K ^TMP($J,"VPR TIU TEXT")
 D ADD^VPRDJ("DOC","document")
 Q
 ;
USER(N,IEN,NAME,ROLE,DATE) ; -- set author, signer(s)
 Q:'$G(IEN)  S N=+$G(N)+1
 S DOC("text",VPRT,"clinicians",N,"uid")=$$SETUID^VPRUTILS("user",,IEN)
 S DOC("text",VPRT,"clinicians",N,"name")=$S($L($G(NAME)):NAME,1:$P($G(^VA(200,IEN,0)),U))
 S DOC("text",VPRT,"clinicians",N,"role")=$G(ROLE)
 Q:'$G(DATE)  ;not co/signed
 S DOC("text",VPRT,"clinicians",N,"signedDateTime")=$$JSONDT^VPRUTILS(DATE)
 S DOC("text",VPRT,"clinicians",N,"signature")=$$SIG^VPRDTIU(IEN)
 Q
 ;
 ; ------------ Get/apply search criteria ------------
 ;               [from DOCUMENT^VPRDJ0]
 ;
SETUP ; -- convert FILTER("attribute") = value to TIU criteria
 ; Expects: FILTER("category") = code (see $$CATG)
 ;          FILTER("status")   = 'signed','unsigned','all'
 ; Returns: CLASS,[SUBCLASS,STATUS]
 ;
 N TYPE,STS,CP
 S TYPE=$$UP^XLFSTR($G(FILTER("category")))
 S CLASS=0,(SUBCLASS,STATUS)=""
 ;
 ; status [default='signed']
 S STS=$$LOW^XLFSTR($G(FILTER("status")))
 S STATUS=$S(STS?1"unsig".E:2,STS="all":"5^2",1:5)     ;TIUSRVLO statuses
 ;
 ; all documents
 S:TYPE="" TYPE="ALL"
 I TYPE="ALL" S CLASS="3^244^"_+$$CLASS^TIUSROI("SURGICAL REPORTS")_"^CP^LR^RA" Q
 ;
 I TYPE="PN"   S CLASS=3 Q                            ;Progress Notes
 I TYPE="CR"   S CLASS=3,SUBCLASS=$$CLASS^TIUCNSLT Q  ;Consults
 I TYPE="CWAD" S CLASS=3,SUBCLASS="25^27^30^31" Q     ;CWAD
 I TYPE="C"    S CLASS=3,SUBCLASS=30 Q                ;Crisis Note
 I TYPE="W"    S CLASS=3,SUBCLASS=31 Q                ;Clinical Warning
 I TYPE="A"    S CLASS=3,SUBCLASS=25 Q                ;Allergy Note
 I TYPE="D"    S CLASS=3,SUBCLASS=27 Q                ;Advance Directive
 ;
 I TYPE="DS"   S CLASS=244 Q                          ;Discharge Summary
 ;
 I TYPE="SR"   S CLASS=$$CLASS^TIUSROI("SURGICAL REPORTS") Q
 I TYPE="CP" D  Q                                     ;Clin Procedures
 . I STATUS'=2 S CLASS="CP"                           ; if unsigned,
 . E  D CPCLASS^TIUCP(.CP) S CLASS=CP                 ; use TIU class#
 ;
 I TYPE="LR"   S CLASS=$S(STATUS=2:$$LR,1:"LR") Q     ;Lab/Pathology
 ;
 I TYPE="RA"   S CLASS="RA" Q                         ;Radiology
 ;
 Q
 ;
LR() ; -- Return ien of Lab class
 N Y S Y=+$O(^TIU(8925.1,"B","LR LABORATORY REPORTS",0))
 I Y>0,$S($P($G(^TIU(8925.1,Y,0)),U,4)="CL":0,$P($G(^(0)),U,4)="DC":0,1:1) S Y=0
 Q Y
 ;
MATCH(DOC,STS) ; -- Return 1 or 0, if document DA matches search criteria
 N Y,DA,LOCAL,NATL,X0,OK S Y=0
 S DA=+$G(DOC) G:DA<1 MQ
 ; include addenda if pulling only unsigned items
 I $P(DOC,U,2)?1"Addendum ".E,STATUS'=2 G MQ
 ; TIU unsigned list can include completed parent notes
 I $G(STS)=2,$P(DOC,U,7)'="unsigned" G MQ
 S LOCAL=$$GET1^DIQ(8925,DA_",",.01,"I") ;local Title 8925.1 ien
 I $L(SUBCLASS) D  G:'OK MQ
 . N I,X S OK=0
 . F I=1:1:$L(SUBCLASS,"^") S X=$P(SUBCLASS,U,I) I $$ISA^TIULX(LOCAL,X) S OK=1 Q
 S Y=1
MQ Q Y
 ;
TYPE(X) ; -- Return name of category type X
 S X=$G(X)
 I X="PN" Q "Progress Note"
 I X="DS" Q "Discharge Summary"
 I X="CP" Q "Clinical Procedure"
 I X="SR" Q "Surgery Report"
 I X="LR" Q "Laboratory Report"
 I X="RA" Q "Radiology Report"
 I X="CR" Q "Consult Report"
 I X="C"  Q "Crisis Note"
 I X="W"  Q "Clinical Warning"
 I X="A"  Q "Allergy/Adverse Reaction"
 I X="D"  Q "Advance Directive"
 Q ""
