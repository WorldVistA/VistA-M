HMPDJ08 ;SLC/MKB,ASMR/RRB,HM - TIU Documents;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;11/19/14 - Fix missing MCAR documents tag EN1+4, EN1+13  js
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
 ; All tags expect DFN, ID, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 Q
 ;
TIU1(ID) ; -- document
 I ID[";" D   Q
 . I ID D EN1($$CP1^HMPDJ08A(DFN,ID),"CP") Q  ;CP
 . D EN1($$LR1^HMPDJ08A(DFN,ID),"LR") Q       ;Lab
 I ID["-" D  Q                                ;Radiology
 . S (BEG,END)=9999999.9999-+ID D EN1^RAO7PC1(DFN,BEG,END,"99P")
 . Q:'$D(^TMP($J,"RAE1",DFN,ID))              ;deleted
 . D EN1($$RA1^HMPDJ08A(DFN,ID),"RA") K ^TMP($J,"RAE1")
 D EN1(ID,38)
 Q
 ;
EN1(HMPX,TIU,OUTPUT) ; -- document
 ;  Expects DFN, HMPX=IEN^$$RESOLVE^TIUSRVLO(IEN) or equivalent
 ;          TIU = document class#, or code (CP, RA, LR) if non-TIU
 ;          OUTPUT = store the result in the output array instead (by reference)
 N DOC,IEN,X,HMPTIU,NT,ES,I,TEXT,SUB,HMPY,ERR
 ; --- CP HMPX records with $p1 not the file ien  --- 
 S IEN=$P($G(HMPX),U),TIU=$G(TIU) I TIU="CP" I IEN="" D  Q:IEN=""  ;invalid ien
 . S HMPIEN=+$P(HMPX,$J_",""",2)
 . I +HMPIEN>0 S IEN=+HMPIEN
 . Q
 ; ---
 I +HMPX=HMPX,TIU D  ;get TIU data string, if needed
 . N SHOWADD,DA S SHOWADD=1,DA=+HMPX
 . S HMPX=DA_U_$$RESOLVE^TIUSRVLO(DA)
 ; --- CP HMPX records with $p1 not the file ien  ---
 I +HMPX="" I TIU="CP" D  ;get TIU data string, if needed
 . N SHOWADD,DA S SHOWADD=1,DA=+IEN
 . S HMPX=DA_U_$$RESOLVE^TIUSRVLO(DA)
 ; ---
 Q:"UNKNOWN"[$P($G(HMPX),U,2)  ;null or invalid
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_IEN_" for the document domain"
 S DOC("localId")=IEN,DOC("uid")=$$SETUID^HMPUTILS("document",DFN,IEN)
 S DOC("localTitle")=$P(HMPX,U,2)
 S DOC("referenceDateTime")=$$JSONDT^HMPUTILS($P(HMPX,U,3))
 S X=$P(HMPX,U,6) D  ;S:$L(X) DOC("location")=X
 . N LOC,FAC S LOC=$S($L(X):+$O(^SC("B",X,0)),1:0) ;ICR 10040 DE2818 ASF 11/10/15
 . S X=$$FAC^HMPD(LOC)
 . S DOC("facilityCode")=$P(X,U),DOC("facilityName")=$P(X,U,2)
 S X=$P(HMPX,U,7) I $L(X) S DOC("status")=$$UP^XLFSTR(X)
 S:$P(HMPX,U,11) DOC("images")=+$P(HMPX,U,11)
 S:$L($P(HMPX,U,12)) DOC("subject")=$P(HMPX,U,12)
 I $P(HMPX,U,14)>5 S DOC("parentUid")=$$SETUID^HMPUTILS("document",DFN,$P(HMPX,U,14)) ;ID notes
B ; other TIU data
 D:TIU EXTRACT^TIULQ(IEN,"HMPTIU",,,,1,,1) ;".01:.04;1501:1508")
 S X=$G(HMPTIU(IEN,.01,"I")) S:X DOC("documentDefUid")=$$SETUID^HMPUTILS("doc-def",,X)
 S NT=$S(X:+$G(^TIU(8925.1,X,15)),1:$P(HMPX,U,10)) I NT D  ;ICR 2321 DE2818 ASF 11/110/15
 . S DOC("nationalTitle","vuid")="urn:va:vuid:"_$$VUID^HMPD(NT,8926.1)
 . S DOC("nationalTitle","name")=$$GET1^DIQ(8926.1,NT_",",.01)
 S X=$G(HMPTIU(IEN,1201,"I")) S:X DOC("entered")=$$JSONDT^HMPUTILS(X)
 S X=$G(HMPTIU(IEN,.09,"E")) S:$L(X) DOC("urgency")=X
 S X=TIU I TIU S X=+$G(HMPTIU(IEN,.01,"I")),X=$$CATG^HMPDTIU(X) ;2U type code
 S DOC("documentTypeCode")=X,DOC("documentTypeName")=$$TYPE(X)
 S DOC("documentClass")=$S(X="LR":"LR LABORATORY REPORTS",X="SR":"SURGICAL REPORTS",X="CP":"CLINICAL PROCEDURES",X="RA":"RADIOLOGY REPORTS",X="DS":"DISCHARGE SUMMARY",1:"PROGRESS NOTES")
 S X=$S(TIU:$G(HMPTIU(IEN,.03,"I")),1:$P(HMPX,U,8)) ;visit#
 S:X DOC("encounterUid")=$$SETUID^HMPUTILS("visit",DFN,X),DOC("encounterName")=$$NAME^HMPDJ04(X)
C ; text blocks, signatures
 N HMPT,HMPA,HMPADD
 S DOC("text",1,"dateTime")=DOC("referenceDateTime")
 S DOC("text",1,"status")=$G(DOC("status"))
 S DOC("text",1,"uid")=DOC("uid")
 S HMPT=1,X=$P(HMPX,U,5),I=0
 I X D USER(.I,+X,$P(X,";",3),"AU")    ;author
 M ES=HMPTIU(IEN) S X=$P(HMPX,"//",2) ;non-TIU, put into ES for use:
 I $L(X) S ES(1502,"I")=+X,ES(1502,"E")=$P(X,";",2),ES(1501,"I")=$P(X,";",3)
 I $G(ES(1501,"I")) D USER(.I,ES(1502,"I"),ES(1502,"E"),"S",ES(1501,"I"),$G(ES(1503,"E")),$G(ES(1504,"E")))
 I $G(ES(1507,"I")) D USER(.I,ES(1508,"I"),ES(1508,"E"),"C",ES(1507,"I"),$G(ES(1509,"E")),$G(ES(1510,"E")))
 I $G(ES(1204,"I")) D USER(.I,ES(1204,"I"),ES(1204,"E"),"ES")    ;expected signer
 I $G(ES(1208,"I")) D USER(.I,ES(1208,"I"),ES(1208,"E"),"EC")    ;expected cosigner
 I $G(ES(1302,"I")) D USER(.I,ES(1302,"I"),ES(1302,"E"),"E")     ;entered
 I $G(ES(1209,"I")) D USER(.I,ES(1209,"I"),ES(1209,"E"),"ATT")   ;attending
 I $G(HMPTEXT) D
 . S X=$S(TIU:$NA(HMPTIU(IEN,"TEXT")),1:$NA(^TMP("HMPTEXT",$J,IEN)))
 . K ^TMP($J,"HMP TIU TEXT")
 . D SETTEXT^HMPUTILS(X,$NA(^TMP($J,"HMP TIU TEXT")))
 . M DOC("text",1,"content","\")=^TMP($J,"HMP TIU TEXT")
D ; addenda
 S HMPA=0 F  S HMPA=$O(HMPTIU(IEN,"ZADD",HMPA)) Q:HMPA<1  D
 . S HMPT=HMPT+1,I=0 K HMPADD M HMPADD=HMPTIU(IEN,"ZADD",HMPA)
 . S DOC("text",HMPT,"status")=$G(HMPADD(.05,"E"))
 . S DOC("text",HMPT,"uid")=$$SETUID^HMPUTILS("document",DFN,HMPA)
 . S DOC("text",HMPT,"dateTime")=$$JSONDT^HMPUTILS($G(HMPADD(1301,"I")))
 . I $G(HMPADD(1302,"I")) D USER(.I,HMPADD(1302,"I"),HMPADD(1302,"E"),"E")
 . I $G(HMPADD(1202,"I")) D USER(.I,HMPADD(1202,"I"),HMPADD(1202,"E"),"AU")
 . I $G(HMPADD(1501,"I")) D USER(.I,HMPADD(1502,"I"),HMPADD(1502,"E"),"S",HMPADD(1501,"I"))
 . I $G(HMPADD(1507,"I")) D USER(.I,HMPADD(1508,"I"),HMPADD(1508,"E"),"C",HMPADD(1507,"I"))
 . I $G(HMPADD(1204,"I")) D USER(.I,HMPADD(1204,"I"),HMPADD(1204,"E"),"ES")
 . I $G(HMPADD(1208,"I")) D USER(.I,HMPADD(1208,"I"),HMPADD(1208,"E"),"EC")
 . I $G(HMPADD(1209,"I")) D USER(.I,HMPADD(1209,"I"),HMPADD(1209,"E"),"ATT")
 . Q:'$G(HMPTEXT)  K ^TMP($J,"HMP TIU TEXT")
 . D  ; DE3153, replace "not PRINT" with "not VIEW" MARCH 17, 2016 HM
 ..  N V,X,T,R,L S V="HMPTIU",T=" You may not PRINT",R=" You may not VIEW",L=$L(T)
 ..  F  S V=$Q(@V) Q:V=""  S X=@V S:$E(X,1,L)=T @V=R_$E(X,L+1,$L(X))
 . S X=$NA(HMPTIU(IEN,"ZADD",HMPA,"TEXT"))
 . D SETTEXT^HMPUTILS(X,$NA(^TMP($J,"HMP TIU TEXT")))
 . M DOC("text",HMPT,"content","\")=^TMP($J,"HMP TIU TEXT")
ENQ ; end
 K ^TMP($J,"HMP TIU TEXT")
 S DOC("lastUpdateTime")=$$EN^HMPSTMP("document") ;RHL 20150102
 S DOC("stampTime")=DOC("lastUpdateTime") ; RHL 20150102
 ;US6734 - pre-compile metastamp
 I '$D(OUTPUT),$G(HMPMETA) D ADD^HMPMETA("document",DOC("uid"),DOC("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 I '$D(OUTPUT) D ADD^HMPDJ("DOC","document") Q
 M OUTPUT=DOC
 Q
 ;
USER(N,IEN,NAME,ROLE,DATE,SBN,SBT) ; -- set author, signer(s)
 Q:'$G(IEN)  S N=+$G(N)+1
 S DOC("text",HMPT,"clinicians",N,"uid")=$$SETUID^HMPUTILS("user",,IEN)
 S DOC("text",HMPT,"clinicians",N,"name")=$S($L($G(NAME)):NAME,1:$P($G(^VA(200,IEN,0)),U)) ;ICR 10060 DE2818 ASF 11/10/15
 S DOC("text",HMPT,"clinicians",N,"role")=$G(ROLE)
 Q:'$G(DATE)  ;not co/signed
 S DOC("text",HMPT,"clinicians",N,"signedDateTime")=$$JSONDT^HMPUTILS(DATE)
 I '$D(SBN) S SBN=NAME
 S DOC("text",HMPT,"clinicians",N,"signature")=SBN_$S($L($G(SBT)):" "_SBT,1:"")
 ;$$SIG^HMPDTIU(IEN)
 Q
 ;
 ;
 ; ------------ Get/apply search criteria ------------
 ;               [from DOCUMENT^HMPDJ0]
 ;
SETUP ; -- convert FILTER("attribute") = value to TIU criteria
 ; Expects: FILTER("category") = code (see $$CATG)
 ;          FILTER("status")   = 'signed','unsigned','all'
 ; Returns: CLASS,[SUBCLASS,STATUS]
 ;
 K CLASS,SUBCLASS,STATUS
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
 N Y S Y=+$O(^TIU(8925.1,"B","LR LABORATORY REPORTS",0)) ;ICR 2321 DE2818 ASF 11/10/15
 I Y>0,$S($P($G(^TIU(8925.1,Y,0)),U,4)="CL":0,$P($G(^(0)),U,4)="DC":0,1:1) S Y=0
 Q Y
 ;
MATCH(DOC,STS) ; -- Return 1 or 0, if document DA matches search criteria
 N Y,DA,LOCAL,OK S Y=0
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
