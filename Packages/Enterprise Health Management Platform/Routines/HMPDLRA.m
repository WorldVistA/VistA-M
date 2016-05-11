HMPDLRA ;SLC/MKB,ASMR/RRB - Laboratory extract by accession;Nov 05, 2015 19:21:53
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^LAB(61                        524
 ; ^LRO(68                       1963
 ; ^LRO(69                       2407
 ; ^LR                            525
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIC                           2051
 ; DIQ                           2056
 ; LR7OR1,^TMP("LRRR",$J)        2503
 ; LR7OSUM,^TMP("LRC",$J),       2766
 ;  ^TMP("LRH",$J),^TMP("LRT",$J)
 ; ORX8                          2467
 ; PXAPI                         1894
 ; XUAF4                         2171
 Q
 ; ------------ Get results from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's lab results
 N HMPSUB,HMPIDT,HMPN,HMPITM,LRDFN,LR0,ORD,X
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S HMPSUB=$G(FILTER("type")),LRDFN=$$LRDFN^HMPXGLAB(DFN)  ;DE2818, (#63) LABORATORY REFERENCE
 K ^TMP("LRRR",$J,DFN)
 ;
 ; get result(s)
 I $L($G(ID)) D  ;reset search parameters
 . S HMPSUB=$P(ID,";"),HMPIDT=+$P(ID,";",2)
 . S:HMPIDT (BEG,END)=9999999-HMPIDT
 ;
 D RR^LR7OR1(DFN,,BEG,END,HMPSUB,,,MAX)
 S HMPSUB="" F  S HMPSUB=$O(^TMP("LRRR",$J,DFN,HMPSUB)) Q:HMPSUB=""  D
 . S HMPIDT=0 F  S HMPIDT=$O(^TMP("LRRR",$J,DFN,HMPSUB,HMPIDT)) Q:HMPIDT<1  I $O(^(HMPIDT,0)) D
 .. K HMPITM,ORD,CMMT,^TMP("HMPTEXT",$J)
 .. I "CH^MI"'[HMPSUB D AP(.HMPITM),XML(.HMPITM) Q
 .. S HMPITM("type")=HMPSUB,HMPITM("id")=HMPSUB_";"_HMPIDT
 .. S HMPITM("collected")=9999999-HMPIDT,HMPITM("status")="completed"
 .. S LR0=$G(^LR(LRDFN,HMPSUB,HMPIDT,0))
 .. S HMPITM("resulted")=$P(LR0,U,3),X=+$P(LR0,U,5) I X D
 ... N IENS,HMPY S IENS=X_","
 ... D GETS^DIQ(61,IENS,".01;2;4.1",,"HMPY")
 ... S HMPITM("specimen")=$G(HMPY(61,IENS,2))_U_$G(HMPY(61,IENS,.01)) ;SNOMED^name
 ... S HMPITM("sample")=$G(HMPY(61,IENS,4.1)) ;name
 .. S X=$P(LR0,U,6),HMPITM("name")=$$AREA(X),HMPITM("groupName")=X
 .. S X=+$P(LR0,U,14) S:X HMPITM("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 .. I 'X S HMPITM("facility")=$$FAC^HMPD ;local stn#^name
 .. I HMPSUB="MI" D  ;report
 ... S HMPITM("document",1)=HMPSUB_";"_HMPIDT_"^LR MICROBIOLOGY REPORT^LABORATORY NOTE"
 ... S:$G(HMPTEXT) HMPITM("document",1,"content")=$$TEXT(DFN,HMPSUB,HMPIDT)
 .. S HMPN=0 F  S HMPN=$O(^TMP("LRRR",$J,DFN,HMPSUB,HMPIDT,HMPN)) Q:HMPN<1  D
 ... S X=$S(HMPSUB="MI":$$MI,1:$$CH)
 ... S:$L(X) HMPITM("value",HMPN)=X
 ... S:$G(ORD) HMPITM("labOrderID")=ORD
 .. I $D(^TMP("LRRR",$J,DFN,HMPSUB,HMPIDT,"N")) M CMMT=^("N") S HMPITM("comment")=$$STRING^HMPD(.CMMT)
 .. D XML(.HMPITM)
 K ^TMP("LRRR",$J,DFN),^TMP("HMPTEXT",$J)
 Q
 ;
CH() ; -- return a Chemistry result as:
 ;   id^test^result^interpretation^units^low^high^localName^loinc^vuid^order
 ;   Expects ^TMP("LRRR",$J,DFN,"CH",HMPIDT,HMPN),LRDFN
 N X,Y,X0,NODE,CMMT,LOINC
 S X0=$G(^TMP("LRRR",$J,DFN,"CH",HMPIDT,HMPN)),NODE=$G(^LR(LRDFN,"CH",HMPIDT,HMPN))
 S X=$$LABTSTNM^HMPXGLAB(+X0)  ; DE2818
 S Y="CH;"_HMPIDT_";"_HMPN_U_X_U_$P(X0,U,2,4)
 S X=$P(X0,U,5) I $L(X),X["-" S X=$TR(X,"- ","^"),$P(Y,U,6,7)=X
 S $P(Y,U,8)=$P(X0,U,15) ;test short name
 S X=$P($P(NODE,U,3),"!",3) S:X LOINC=$$GET1^DIQ(95.3,X_",",.01)
 S:$G(LOINC) $P(Y,U,9,10)=LOINC_U_$$VUID^HMPD(+LOINC,95.3)
 S ORD=+$P(X0,U,17),X=$$ORDER(ORD,+X0) S:X $P(Y,U,11)=X
 Q Y
 ;
MI() ; -- return a Microbiology result as:
 ;   id^test^result^interpretation^units
 ;   Expects ^TMP("LRRR",$J,DFN,"MI",HMPIDT,HMPN)
 N Y,X0
 S X0=$G(^TMP("LRRR",$J,DFN,"MI",HMPIDT,HMPN)),Y=""
 S:$L($P(X0,U))>1 Y="MI;"_HMPIDT_";"_HMPN_U_$P(X0,U,1,4)
 S ORD=+$P(X0,U,17)
 Q Y
 ;
AP(LAB) ; -- return a Pathology result in LAB("attribute")=value
 N LR0,X,I,NODE
 S LR0=$G(^LR(LRDFN,HMPSUB,HMPIDT,0))
 S LAB("type")=HMPSUB,LAB("id")=HMPSUB_";"_HMPIDT
 S LAB("collected")=9999999-HMPIDT,LAB("status")="completed"
 S LAB("resulted")=$P(LR0,U,11),LAB("groupName")=$P(LR0,U,6)
 S X="",I=0 F  S I=$O(^LR(LRDFN,HMPSUB,HMPIDT,.1,I)) Q:I<1  S X=X_$S($L(X):", ",1:"")_$P($G(^(I,0)),U)
 S:$L(X) LAB("specimen")=U_X
 S LAB("facility")=$$FAC^HMPD
 S NODE=$S(HMPSUB="AU":$NA(^LR(LRDFN,101)),1:$NA(^LR(LRDFN,HMPSUB,HMPIDT,.05)))
 S I=0 F  S I=$O(@NODE@(I)) Q:I<1  S X=+$P($G(@NODE@(I,0)),U,2) I X D
 . N LT,NT,HMPY
 . S LT=$$GET1^DIQ(8925,+X_",",.01) Q:$P(LT," ")="Addendum"
 . S NT=$$GET1^DIQ(8925,+X_",",".01:1501") S:NT="" NT="LABORATORY NOTE"
 . S LAB("document",I)=+X_U_LT_U_NT
 . S:$G(HMPTEXT) LAB("document",I,"content")=$$TEXT^HMPDTIU(+X)
 I '$O(LAB("document",0)) D  ;non-TIU reports
 . S LAB("document",1)=HMPSUB_";"_HMPIDT_"^LR "_$$NAME(HMPSUB)_" REPORT^LABORATORY NOTE"
 . S:$G(HMPTEXT) LAB("document",1,"content")=$$TEXT(DFN,HMPSUB,HMPIDT)
 Q
 ;
ORDER(LABORD,TEST) ; -- return #100 order^name for Lab order# & Test
 N Y,D,S,T
 S D=$P(9999999-HMPIDT,"."),Y=""
 S S=0 F  S S=$O(^LRO(69,"C",LABORD,D,S)) Q:S<1  D  Q:Y
 . S T=0 F  S T=$O(^LRO(69,D,1,S,2,T)) Q:T<1  I 'TEST!(+$G(^(T,0))=TEST) S Y=+$P(^(0),U,7)
 ;I Y S Y=Y_U_$P($$OI^ORX8(Y),U,2)
 Q Y
 ;
NAME(X) ; -- Return name of subscript X
 I X="AU" Q "AUTOPSY"
 I X="BB" Q "BLOOD BANK"
 I X="CH" Q "CHEM,HEM,TOX,RIA,SER,etc."
 I X="CY" Q "CYTOPATHOLOGY"
 I X="EM" Q "ELECTRON MICROSCOPY"
 I X="MI" Q "MICROBIOLOGY"
 I X="SP" Q "SURGICAL PATHOLOGY"
 Q "ANATOMIC PATHOLOGY"
 ;
AREA(ACCNUM) ; -- Return name of accession area
 N X,Y,HMPA
 S X=$P($G(ACCNUM)," "),Y=""
 I $L(X) D FIND^DIC(68,,.01,"QX",X,,,,,"HMPA")
 S Y=$G(HMPA("DILIST",1,1))
 Q Y
 ;
 ; ------------ Get report(s) [via HMPDTIU] ------------
 ;
RPTS(DFN,BEG,END,MAX) ; -- find patient's lab reports
 N HMPSUB,HMPIDT,HMPITM,HMPTIU,HMPXID,LRDFN,HMPN,DA
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S LRDFN=$$LRDFN^HMPXGLAB(DFN)  ;DE2818, (#63) LABORATORY REFERENCE
 K ^TMP("LRRR",$J,DFN) D RR^LR7OR1(DFN,,BEG,END,"AP",,,MAX)
 S HMPSUB="" F  S HMPSUB=$O(^TMP("LRRR",$J,DFN,HMPSUB)) Q:HMPSUB=""  D
 . S HMPIDT=0 F  S HMPIDT=$O(^TMP("LRRR",$J,DFN,HMPSUB,HMPIDT)) Q:HMPIDT<1  I $O(^(HMPIDT,0)) D
 .. S HMPTIU=$S(HMPSUB="AU":$NA(^LR(LRDFN,101)),1:$NA(^LR(LRDFN,HMPSUB,HMPIDT,.05)))
 .. K HMPITM S HMPXID=HMPSUB_";"_HMPIDT
 .. I '$O(@HMPTIU@(0)) D RPT1(DFN,HMPXID,.HMPITM),XML^HMPDTIU(.HMPITM):$D(HMPITM) Q
 .. S HMPN=0 F  S HMPN=$O(@HMPTIU@(HMPN)) Q:HMPN<1  D
 ... S DA=+$P($G(@HMPTIU@(HMPN,0)),U,2) Q:DA<1  K HMPITM
 ... D EN1^HMPDTIU(DA,.HMPITM),XML^HMPDTIU(.HMPITM):$D(HMPITM)
 K ^TMP("LRRR",$J,DFN),^TMP("HMPTEXT",$J)
 Q
 ;
RPT1(DFN,ID,RPT) ; -- return report as a TIU document
 S DFN=+$G(DFN),ID=$G(ID) Q:DFN<1  Q:'$L(ID)
 N SUB,IDT,LRDFN,LR0,X,LOC
 K RPT,^TMP("HMPTEXT",$J)
 S SUB=$P(ID,";"),IDT=+$P(ID,";",2),LRDFN=$$LRDFN^HMPXGLAB(DFN)  ;DE2818, (#63) LABORATORY REFERENCE
 S LR0=$S(SUB="AU":$G(^LR(LRDFN,"AU")),1:$G(^LR(LRDFN,SUB,IDT,0)))
 S RPT("id")=ID,RPT("referenceDateTime")=9999999-IDT
 S RPT("localTitle")="LR "_$$NAME(SUB)_" REPORT"
 S RPT("documentClass")="LR LABORATORY REPORTS"
 S RPT("nationalTitle")="4697105^LABORATORY NOTE"
 S RPT("nationalTitleSubject")="4697104^LABORATORY"
 S RPT("nationalTitleType")="4696120^NOTE"
 S RPT("type")="LR",RPT("status")="COMPLETED"
 S:$G(FILTER("loinc")) RPT("loinc")=$P(FILTER("loinc"),U)
 S X=$P(LR0,U,$S(SUB="AU":5,1:8)),LOC="" S:$L(X) LOC=+$O(^SC("B",X,0))  ;DE2818, ***fix needed to get location IEN***
 S RPT("facility")=$$FAC^HMPD(LOC)
 I LOC D  ;look-up visit
 . N CDT S CDT=9999999-IDT
 . S X=$$GETENC^PXAPI(DFN,CDT,LOC)
 . S:X RPT("encounter")=+X
 S X=+$P(LR0,U,$S(SUB="AU":10,1:2)) ;pathologist
 S:X RPT("clinician",1)=X_U_$$GET1^DIQ(200,X_",",.01)_"^A"  ;DE2818, changed global read to FileMan
 S X=$S(SUB="AU":$P(LR0,U,15,16),1:$P(LR0,U,11)_U_$P(LR0,U,13)) I X D
 . N Y S Y=$P(X,U,2)
 . ;DE2818, changed global read to FileMan - (#.01) NAME and (#1) INITIAL
 . S RPT("clinician",2)=Y_U_$$GET1^DIQ(200,+Y_",",.01)_"^S^"_+X_U_$$GET1^DIQ(200,+Y_",",1)
 S:$G(HMPTEXT) RPT("content")=$$TEXT(DFN,SUB,IDT)
 Q
 ;
TEXT(DFN,SUB,IDT) ; -- Get report text, return temp array name
 N LRDFN,DATE,NAME,HMPS,HMPY,I,X,Y
 K ^TMP("LRC",$J),^TMP("LRH",$J),^TMP("LRT",$J)
 S DATE=9999999-+$G(IDT),NAME=$$NAME(SUB),HMPS(NAME)=""
 D EN^LR7OSUM(.HMPY,DFN,DATE,DATE,,,.HMPS)
 S Y=$NA(^TMP("HMPTEXT",$J,SUB_";"_IDT)) K @Y
 S I=+$G(^TMP("LRH",$J,NAME)) ;LRH=header
 F  S I=$O(^TMP("LRC",$J,I)) Q:I<1  S X=$G(^(I,0)) Q:X?1."="  S @Y@(I)=X
 K ^TMP("LRC",$J),^TMP("LRH",$J),^TMP("LRT",$J)
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(LAB) ; -- Return result as XML in @HMP@(#)
 N ATT,X,Y,NAMES,I,J
 D ADD("<accession>") S HMPTOTL=$G(HMPTOTL)+1
 S ATT="" F  S ATT=$O(LAB(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(LAB(ATT,0)) D  S Y="" Q
 .. D ADD("<"_ATT_"s>")
 .. S NAMES=$S(ATT="document":"id^localTitle^nationalTitle^Z",ATT="value":"id^test^result^interpretation^units^low^high^localName^loinc^vuid^order^Z",1:"code^name^Z")
 .. S I=0 F  S I=$O(LAB(ATT,I)) Q:I<1  D
 ... S X=$G(LAB(ATT,I))
 ... S Y="<"_ATT_" "_$$LOOP ;_"/>" D ADD(Y)
 ... S X=$G(LAB(ATT,I,"content")) I '$L(X) S Y=Y_"/>" D ADD(Y) Q
 ... S Y=Y_">" D ADD(Y)
 ... S Y="<content xml:space='preserve'>" D ADD(Y)
 ... S J=0 F  S J=$O(@X@(J)) Q:J<1  S Y=$$ESC^HMPD(@X@(J)) D ADD(Y)
 ... D ADD("</content>"),ADD("</"_ATT_">")
 .. D ADD("</"_ATT_"s>")
 . S X=$G(LAB(ATT)),Y="" Q:'$L(X)
 . I ATT="comment" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^HMPD(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^HMPD(X)_"' />" Q
 . I $L(X)>1 D  S Y=""
 .. S NAMES="code^name^Z"
 .. S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 D ADD("</accession>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; -- Add a line @HMP@(n)=X
 S HMPI=$G(HMPI)+1
 S @HMP@(HMPI)=X
 Q
