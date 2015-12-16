VPRDLRA ;SLC/MKB -- Laboratory extract by accession ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,2,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^LAB(60                      10054
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
 ; LRPXAPIU                      4246
 ; PXAPI                         1894
 ; XUAF4                         2171
 ;
 ; ------------ Get results from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's lab results
 N VPRTYPE,SUB,VPRSUB,VPRIDT,VPRP,VPRITM,LRDFN,LR0,ORD,X,I
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S VPRTYPE=$G(FILTER("type"),"CH;MI;CY;EM;SP;AU")
 S LRDFN=$G(^DPT(DFN,"LR")),SUB=$$SUB(VPRTYPE)
 K ^TMP("LRRR",$J,DFN)
 ;
 ; get result(s)
 I $L($G(ID)) D  ;reset search parameters
 . S SUB=$P(ID,";"),VPRIDT=+$P(ID,";",2)
 . S:VPRIDT (BEG,END)=9999999-VPRIDT
 . S:"CH^MI"'[SUB SUB="AP"
 ;
 D RR^LR7OR1(DFN,,BEG,END,SUB,,,MAX)
 S VPRSUB="" F  S VPRSUB=$O(^TMP("LRRR",$J,DFN,VPRSUB)) Q:VPRSUB=""  D
 . Q:$G(VPRTYPE)'[VPRSUB  ;requested types only
 . S VPRIDT=0 F  S VPRIDT=$O(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT)) Q:VPRIDT<1  I $O(^(VPRIDT,0)) D
 .. K VPRITM,ORD,CMMT,^TMP("VPRTEXT",$J)
 .. I "CH^MI"'[VPRSUB D AP(.VPRITM),XML(.VPRITM) Q
 .. S VPRITM("type")=VPRSUB,VPRITM("id")=VPRSUB_";"_VPRIDT
 .. S VPRITM("collected")=9999999-VPRIDT,VPRITM("status")="completed"
 .. S LR0=$G(^LR(LRDFN,VPRSUB,VPRIDT,0))
 .. S VPRITM("resulted")=$P(LR0,U,3),X=+$P(LR0,U,5) I X D
 ... N IENS,VPRY S IENS=X_","
 ... D GETS^DIQ(61,IENS,".01;2;4.1",,"VPRY")
 ... S VPRITM("specimen")=$G(VPRY(61,IENS,2))_U_$G(VPRY(61,IENS,.01)) ;SNOMED^name
 ... S VPRITM("sample")=$G(VPRY(61,IENS,4.1)) ;name
 .. S X=$P(LR0,U,6),VPRITM("name")=$$AREA(X),VPRITM("groupName")=X
 .. S I=$S(VPRSUB="CH":10,1:7),X=+$P(LR0,U,I)
 .. S:X VPRITM("provider")=X_U_$P($G(^VA(200,X,0)),U)_U_$$PROVSPC^VPRD(X)
 .. S X=+$P(LR0,U,14) S:X VPRITM("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 .. I 'X S VPRITM("facility")=$$FAC^VPRD ;local stn#^name
 .. I VPRSUB="MI" D  ;report
 ... I '$P(LR0,U,3) S VPRITM("status")="incomplete" Q
 ... S VPRITM("document",1)=VPRSUB_";"_VPRIDT_"^LR MICROBIOLOGY REPORT^LABORATORY NOTE^4697105"
 ... S:$G(VPRTEXT) VPRITM("document",1,"content")=$$TEXT(DFN,VPRSUB,VPRIDT)
 .. S VPRP=0 F  S VPRP=$O(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT,VPRP)) Q:VPRP<1  D
 ... S X=$S(VPRSUB="MI":$$MI,1:$$CH)
 ... S:$L(X) VPRITM("value",VPRP)=X
 ... S:$G(ORD) VPRITM("labOrderID")=ORD
 .. I $D(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT,"N")) M CMMT=^("N") S VPRITM("comment")=$$STRING^VPRD(.CMMT)
 .. D XML(.VPRITM)
 K ^TMP("LRRR",$J,DFN),^TMP("VPRTEXT",$J)
 Q
 ;
CH() ; -- return a Chemistry result as:
 ;   id^test^result^interpretation^units^low^high^localName^loinc^vuid^order^performingLab
 ;   Expects ^TMP("LRRR",$J,DFN,"CH",VPRIDT,VPRP),LRDFN
 N X,Y,X0,VPRN,NODE,CMMT,LOINC
 S X0=$G(^TMP("LRRR",$J,DFN,"CH",VPRIDT,VPRP)),VPRN=$$LRDN^LRPXAPIU(+X0)
 S NODE=$G(^LR(LRDFN,"CH",VPRIDT,VPRN))
 S X=$P($G(^LAB(60,+X0,0)),U)
 S Y="CH;"_VPRIDT_";"_VPRN_U_X_U_$P(X0,U,2,4)
 S X=$P(X0,U,5) I $L(X),X["-" S X=$TR(X,"- ","^"),$P(Y,U,6,7)=X
 S $P(Y,U,8)=$P(X0,U,15) ;test short name
 S X=$P($P(NODE,U,3),"!",3) S:X LOINC=$$GET1^DIQ(95.3,X_",",.01)
 S:$G(LOINC) $P(Y,U,9,10)=LOINC_U_$$VUID^VPRD(+LOINC,95.3)
 S ORD=+$P(X0,U,17),X=$$ORDER(ORD,+X0) S:X $P(Y,U,11)=X
 S X=+$P(NODE,U,9) S:X $P(Y,U,12)=$$NAME^XUAF4(X) ;performing lab
 Q Y
 ;
MI() ; -- return a Microbiology result as:
 ;   id^test^result^interpretation^units
 ;   Expects ^TMP("LRRR",$J,DFN,"MI",VPRIDT,VPRP)
 N Y,X0
 S X0=$G(^TMP("LRRR",$J,DFN,"MI",VPRIDT,VPRP)),Y=""
 S:$L($P(X0,U))>1 Y="MI;"_VPRIDT_";"_VPRP_U_$P(X0,U,1,4)
 S ORD=+$P(X0,U,17)
 Q Y
 ;
AP(LAB) ; -- return a Pathology result in LAB("attribute")=value
 N LR0,X,I,NODE
 S LR0=$G(^LR(LRDFN,VPRSUB,VPRIDT,0)) I VPRSUB="AU" D
 . N AU S AU=$G(^LR(LRDFN,"AU")) ;set pieces needed into LR0
 . S LR0=+AU_U_$P(AU,U,10)_"^^^^"_$P(AU,U,6)_U_$P(AU,U,12)_"^^^^"_$P(AU,U,15)
 S LAB("type")=VPRSUB,LAB("id")=VPRSUB_";"_VPRIDT
 S LAB("collected")=9999999-VPRIDT,LAB("resulted")=$P(LR0,U,11)
 S X=$P(LR0,U,6),LAB("groupName")=X,LAB("name")=$$AREA(X)
 S X=+$P(LR0,U,2) S:X LAB("pathologist")=X_U_$P($G(^VA(200,X,0)),U)_U_$$PROVSPC^VPRD(X)
 S X=+$P(LR0,U,7) S:X LAB("provider")=X_U_$P($G(^VA(200,X,0)),U)_U_$$PROVSPC^VPRD(X)
 S LAB("status")=$S('$P(LR0,U,11):"incomplete",1:"completed")
 S X="",I=0 F  S I=$O(^LR(LRDFN,VPRSUB,VPRIDT,.1,I)) Q:I<1  S X=X_$S($L(X):", ",1:"")_$P($G(^(I,0)),U)
 S:$L(X) LAB("specimen")=U_X
 S LAB("facility")=$$FAC^VPRD
 S NODE=$S(VPRSUB="AU":$NA(^LR(LRDFN,101)),1:$NA(^LR(LRDFN,VPRSUB,VPRIDT,.05)))
 S I=0 F  S I=$O(@NODE@(I)) Q:I<1  S X=+$P($G(@NODE@(I,0)),U,2) I X D
 . N Y S Y=$$INFO^VPRDTIU(+X) Q:Y<1  ;draft or retracted
 . S LAB("document",I)=Y
 . S:$G(VPRTEXT) LAB("document",I,"content")=$$TEXT^VPRDTIU(+X)
 I '$O(LAB("document",0)),$P(LR0,U,11) D  ;non-TIU reports
 . S LAB("document",1)=VPRSUB_";"_VPRIDT_"^LR "_$$NAME(VPRSUB)_" REPORT^LABORATORY NOTE^4697105"
 . S:$G(VPRTEXT) LAB("document",1,"content")=$$TEXT(DFN,VPRSUB,VPRIDT)
 Q
 ;
SUB(X) ; -- return string of type(s) needed for LR api
 N Y S Y="",X=$G(X)
 S:X["CH" Y=Y_"CH"
 S:X["MI" Y=Y_"MI"
 I X["AP"!(X["CY")!(X["EM")!(X["SP")!(X["AU") S Y=Y_"AP"
 Q Y
 ;
ORDER(LABORD,TEST) ; -- return #100 order number for Lab order# & Test
 N Y,D,S,T
 S D=$P(9999999-VPRIDT,"."),Y=""
 S S=0 F  S S=$O(^LRO(69,"C",LABORD,D,S)) Q:S<1  D  Q:Y
 . S T=0 F  S T=$O(^LRO(69,D,1,S,2,T)) Q:T<1  I 'TEST!(+$G(^(T,0))=TEST) S Y=+$P(^(0),U,7)
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
 N X,Y,VPRA
 S X=$P($G(ACCNUM)," "),Y=""
 I $L(X) D FIND^DIC(68,,.01,"QX",X,,,,,"VPRA")
 S Y=$G(VPRA("DILIST",1,1))
 Q Y
 ;
 ; ------------ Get report(s) [via VPRDTIU] ------------
 ;
RPTS(DFN,BEG,END,MAX) ; -- find patient's lab reports
 N VPRSUB,VPRIDT,VPRITM,VPRTIU,LR0,VPRXID,LRDFN,VPRN,DA
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S LRDFN=$G(^DPT(DFN,"LR"))
 K ^TMP("LRRR",$J,DFN) D RR^LR7OR1(DFN,,BEG,END,"AP",,,MAX)
 S VPRSUB="" F  S VPRSUB=$O(^TMP("LRRR",$J,DFN,VPRSUB)) Q:VPRSUB=""  D
 . S VPRIDT=0 F  S VPRIDT=$O(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT)) Q:VPRIDT<1  I $O(^(VPRIDT,0)) D
 .. S VPRTIU=$S(VPRSUB="AU":$NA(^LR(LRDFN,101)),1:$NA(^LR(LRDFN,VPRSUB,VPRIDT,.05)))
 .. S LR0=$S(VPRSUB="AU":$G(^LR(LRDFN,"AU")),1:$G(^LR(LRDFN,VPRSUB,VPRIDT,0)))
 .. K VPRITM S VPRXID=VPRSUB_";"_VPRIDT
 .. ; generate report from Lab if not in TIU
 .. I '$O(@VPRTIU@(0)) D  Q
 ... Q:'$P(LR0,U,$S(VPRSUB="AU":15,1:11))  ;Rpt Release Date
 ... D RPT1(DFN,VPRXID,.VPRITM),XML^VPRDTIU(.VPRITM):$D(VPRITM)
 .. S VPRN=0 F  S VPRN=$O(@VPRTIU@(VPRN)) Q:VPRN<1  D
 ... S DA=+$P($G(@VPRTIU@(VPRN,0)),U,2) Q:DA<1  K VPRITM
 ... Q:$$INFO^VPRDTIU(DA)<1  ;draft or retracted
 ... D EN1^VPRDTIU(DA,.VPRITM),XML^VPRDTIU(.VPRITM):$D(VPRITM)
 K ^TMP("LRRR",$J,DFN),^TMP("VPRTEXT",$J)
 Q
 ;
RPT1(DFN,ID,RPT) ; -- return report as a TIU document
 S DFN=+$G(DFN),ID=$G(ID) Q:DFN<1  Q:'$L(ID)
 N SUB,IDT,LRDFN,LR0,X,LOC
 K RPT,^TMP("VPRTEXT",$J)
 S SUB=$P(ID,";"),IDT=+$P(ID,";",2),LRDFN=$G(^DPT(DFN,"LR"))
 S LR0=$S(SUB="AU":$G(^LR(LRDFN,"AU")),1:$G(^LR(LRDFN,SUB,IDT,0)))
 S RPT("id")=ID,RPT("referenceDateTime")=9999999-IDT
 S RPT("localTitle")="LR "_$$NAME(SUB)_" REPORT"
 S RPT("documentClass")="LR LABORATORY REPORTS"
 S RPT("nationalTitle")="4697105^LABORATORY NOTE"
 S RPT("nationalTitleSubject")="4697104^LABORATORY"
 S RPT("nationalTitleType")="4696120^NOTE"
 S RPT("type")="LR",RPT("status")="UNRELEASED"
 S:$G(FILTER("loinc")) RPT("loinc")=$P(FILTER("loinc"),U)
 S X=$P(LR0,U,$S(SUB="AU":5,1:8)),LOC="" S:$L(X) LOC=+$O(^SC("B",X,0))
 S RPT("facility")=$$FAC^VPRD(LOC)
 I LOC D  ;look-up visit
 . N CDT S CDT=9999999-IDT
 . S X=$$GETENC^PXAPI(DFN,CDT,LOC)
 . S:X RPT("encounter")=+X
 S X=+$P(LR0,U,$S(SUB="AU":10,1:2)) ;pathologist
 S:X RPT("clinician",1)=X_U_$P($G(^VA(200,X,0)),U)_"^A^^^"_$$PROVSPC^VPRD(X)
 ; check if Report Released
 S X=$S(SUB="AU":$P(LR0,U,15,16),1:$P(LR0,U,11)_U_$P(LR0,U,13)) I X D
 . N Y S Y=$P(X,U,2),RPT("status")="COMPLETED"
 . S RPT("clinician",2)=Y_U_$P($G(^VA(200,+Y,0)),U)_"^S^"_+X_U_$P($G(^VA(200,+Y,20)),U,2)_U_$$PROVSPC^VPRD(+Y)
 . S:$G(VPRTEXT) RPT("content")=$$TEXT(DFN,SUB,IDT)
 Q
 ;
TEXT(DFN,SUB,IDT) ; -- Get report text, return temp array name
 N LRDFN,DATE,NAME,VPRS,VPRY,I,X,Y
 K ^TMP("LRC",$J),^TMP("LRH",$J),^TMP("LRT",$J)
 S DATE=9999999-+$G(IDT),NAME=$S(SUB="EM":"EM",1:$$NAME(SUB)),VPRS(NAME)=""
 D EN^LR7OSUM(.VPRY,DFN,DATE,DATE,,,.VPRS)
 S Y=$NA(^TMP("VPRTEXT",$J,SUB_";"_IDT)) K @Y
 S I=+$G(^TMP("LRH",$J,NAME)) ;LRH=header
 F  S I=$O(^TMP("LRC",$J,I)) Q:I<1  S X=$G(^(I,0)) Q:X?1."="  S @Y@(I)=X
 K ^TMP("LRC",$J),^TMP("LRH",$J),^TMP("LRT",$J)
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(LAB) ; -- Return result as XML in @VPR@(#)
 N ATT,X,Y,NAMES,I,J
 D ADD("<accession>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(LAB(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(LAB(ATT,0)) D  S Y="" Q
 .. D ADD("<"_ATT_"s>")
 .. S NAMES=$S(ATT="document":"id^localTitle^nationalTitle^vuid^Z",ATT="value":"id^test^result^interpretation^units^low^high^localName^loinc^vuid^order^performingLab^Z",1:"code^name^Z")
 .. S I=0 F  S I=$O(LAB(ATT,I)) Q:I<1  D
 ... S X=$G(LAB(ATT,I))
 ... S Y="<"_ATT_" "_$$LOOP ;_"/>" D ADD(Y)
 ... S X=$G(LAB(ATT,I,"content")) I '$L(X) S Y=Y_"/>" D ADD(Y) Q
 ... S Y=Y_">" D ADD(Y)
 ... S Y="<content xml:space='preserve'>" D ADD(Y)
 ... S J=0 F  S J=$O(@X@(J)) Q:J<1  S Y=$$ESC^VPRD(@X@(J)) D ADD(Y)
 ... D ADD("</content>"),ADD("</"_ATT_">")
 .. D ADD("</"_ATT_"s>")
 . S X=$G(LAB(ATT)),Y="" Q:'$L(X)
 . I ATT="comment" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^VPRD(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 D  S Y=""
 .. S NAMES="code^name"_$S(ATT="provider"!(ATT="pathologist"):U_$$PROVTAGS^VPRD,1:"")_"^Z"
 .. S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 D ADD("</accession>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; -- Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
