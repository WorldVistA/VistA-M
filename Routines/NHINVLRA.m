NHINVLRA ;SLC/MKB -- Laboratory extract by accession
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^LAB(60                      10054
 ; ^LRO(69                       2407
 ; ^LR                            525
 ; ^VA(200                      10060
 ; DIC                           2051
 ; DIQ                           2056
 ; LR7OR1,^TMP("LRRR",$J)        2503
 ; LR7OSUM,^TMP("LRC")           2766
 ; PXAPI                         1894
 ; XUAF4                         2171
 ;
 ; ------------ Get results from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's lab results
 N NHSUB,NHIDT,NHI,NHITM,LRDFN,LR0,ORD,X
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 S LRDFN=$G(^DPT(DFN,"LR")),NHSUB=""
 K ^TMP("LRRR",$J,DFN)
 ;
 ; get result(s)
 I $L($G(ID)) D  ;reset search parameters
 . S NHSUB=$P(ID,";"),NHIDT=+$P(ID,";",2)
 . S:NHIDT (BEG,END)=9999999-NHIDT
 ;
 D RR^LR7OR1(DFN,,BEG,END,NHSUB,,,MAX)
 S NHSUB="" F  S NHSUB=$O(^TMP("LRRR",$J,DFN,NHSUB)) Q:NHSUB=""  D
 . S NHIDT=0 F  S NHIDT=$O(^TMP("LRRR",$J,DFN,NHSUB,NHIDT)) Q:NHIDT<1  I $O(^(NHIDT,0)) D
 .. K NHITM,CMMT I "CH^MI"'[NHSUB D AP(.NHITM),XML(.NHITM) Q
 .. S NHITM("type")=NHSUB,NHITM("id")=NHSUB_";"_NHIDT
 .. S NHITM("collected")=9999999-NHIDT,NHITM("status")="completed"
 .. S LR0=$G(^LR(LRDFN,NHSUB,NHIDT,0))
 .. S NHITM("resulted")=$P(LR0,U,3),X=+$P(LR0,U,5) I X D
 ... N IENS,NHY S IENS=X_","
 ... D GETS^DIQ(61,IENS,".01:2",,"NHY")
 ... S NHITM("specimen")=$G(NHY(61,IENS,2))_U_$G(NHY(61,IENS,.01)) ;SNOMED^name
 ... S NHITM("sample")=$$GET1^DIQ(61,X_",",4.1) ;name
 .. S NHITM("groupName")=$P(LR0,U,6),X=+$P(LR0,U,14)
 .. S:X NHITM("facility")=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 .. I 'X S NHITM("facility")=$$FAC^NHINV ;local stn#^name
 .. S:NHSUB="MI" NHITM("content")=$$TEXT(DFN,NHSUB,NHIDT)
 .. S NHI=0 F  S NHI=$O(^TMP("LRRR",$J,DFN,NHSUB,NHIDT,NHI)) Q:NHI<1  D
 ... S X=$S(NHSUB="MI":$$MI,1:$$CH)
 ... S:$L(X) NHITM("lab",NHI)=X
 ... S:$G(ORD) NHITM("labOrderID")=ORD
 .. I $D(^TMP("LRRR",$J,DFN,NHSUB,NHIDT,"N")) M CMMT=^("N") S NHITM("comment")=$$STRING^NHINV(.CMMT)
 .. D XML(.NHITM)
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
CH() ; -- return a Chemistry result as:
 ;   id^test^result^interpretation^units^low^high^loinc^vuid^order
 ;   Expects ^TMP("LRRR",$J,DFN,"CH",NHIDT,NHI),LRDFN
 N X,Y,X0,NODE,CMMT,LOINC
 S X0=$G(^TMP("LRRR",$J,DFN,"CH",NHIDT,NHI)),NODE=$G(^LR(LRDFN,"CH",NHIDT,NHI))
 S X=$P($G(^LAB(60,+X0,0)),U)
 S Y="CH;"_NHIDT_";"_NHI_U_X_U_$P(X0,U,2,4)
 S X=$P(X0,U,5) I $L(X),X["-" S X=$TR(X,"- ","^"),$P(Y,U,6,7)=X
 S X=$P($P(NODE,U,3),"!",3) S:X LOINC=$$GET1^DIQ(95.3,X_",",.01)
 I '$G(LOINC) S X=+$P(X0,U,19) S:X LOINC=$$LOINC(+X0,X)
 S $P(Y,U,8,9)=$G(LOINC)_U_$$VUID^NHINV(+LOINC,95.3)
 S ORD=+$P(X0,U,17),X=$$ORDER(ORD,+X0) S:X $P(Y,U,10)=X
 Q Y
 ;
MI() ; -- return a Microbiology result as:
 ;   id^test^result^interpretation^units
 ;   Expects ^TMP("LRRR",$J,DFN,"MI",NHIDT,NHI)
 N Y,X0
 S X0=$G(^TMP("LRRR",$J,DFN,"MI",NHIDT,NHI)),Y=""
 S:$L($P(X0,U))>1 Y="MI;"_NHIDT_";"_NHI_U_$P(X0,U,1,4)
 Q Y
 ;
AP(LAB) ; -- return a Pathology result in LAB("attribute")=value
 N LR0,X,I,NODE
 S LR0=$G(^LR(LRDFN,NHSUB,NHIDT,0))
 S LAB("type")=NHSUB,LAB("id")=NHSUB_";"_NHIDT
 S LAB("collected")=9999999-NHIDT,LAB("status")="completed"
 S LAB("resulted")=$P(LR0,U,11),LAB("groupName")=$P(LR0,U,6)
 S X="",I=0 F  S I=$O(^LR(LRDFN,NHSUB,NHIDT,.1,I)) Q:I<1  S X=X_$S($L(X):", ",1:"")_$P($G(^(I,0)),U)
 S:$L(X) LAB("specimen")=U_X
 S LAB("facility")=$$FAC^NHINV
 S NODE=$S(NHSUB="AU":$NA(^LR(LRDFN,101)),1:$NA(^LR(LRDFN,NHSUB,NHIDT,.05)))
 S I=0 F  S I=$O(@NODE@(I)) Q:I<1  S X=+$P($G(@NODE@(I,0)),U,2) I X D
 . N LT,NT
 . S LT=$$GET1^DIQ(8925,+X_",",.01) Q:$P(LT," ")="Addendum"
 . S NT=$$GET1^DIQ(8925,+X_",",".01:1501")
 . S LAB("document",I)=+X_U_LT_U_NT
 I '$O(NHITM("document",0)) S NHITM("content")=$$TEXT(DFN,NHSUB,NHIDT)
 Q
 ;
LOINC(TEST,SPEC) ; -- Look up LOINC code, if not mapped
 N Y,LAM,NHIN,IENS S Y=""
 S TEST=+$G(TEST),SPEC=+$G(SPEC)
 S LAM=$G(^LAB(60,TEST,64)),LAM=$S($P(LAM,U,2):$P(LAM,U,2),1:+LAM)
 D GETS^DIQ(64.01,SPEC_","_LAM_",","30*",,"NHIN")
 S IENS=$O(NHIN(64.02,"")) S:IENS Y=$G(NHIN(64.02,IENS,4))
 S:'Y Y=$$GET1^DIQ(60.01,SPEC_","_TEST_",",95.3)
 Q Y
 ;
ORDER(LABORD,TEST) ; -- return #100 order for Lab order# & Test
 N Y,D,S,T S Y=""
 S D=$O(^LRO(69,"C",LABORD,0)) I D D
 . S S=0 F  S S=$O(^LRO(69,"C",LABORD,D,S)) Q:S<1  D
 .. S T=0 F  S T=$O(^LRO(69,D,1,S,2,T)) Q:T<1  I +$G(^(T,0))=TEST S Y=+$P(^(0),U,7)
 Q Y
 ;
NAME(X) ; -- Return name of subscript X
 I X="AU" Q "AUTOPSY"
 I X="BB" Q "BLOOD BANK"
 I X="CH" Q "CHEM,HEM,TOX,RIA,SER,etc."
 I X="CY" Q "CYTOLOGY"
 I X="EM" Q "ELECTRON MICROSCOPY"
 I X="MI" Q "MICROBIOLOGY"
 I X="SP" Q "SURGICAL PATHOLOGY"
 Q "ANATOMIC PATHOLOGY"
 ;
RPT(DFN,ID,RPT) ; -- return report as a TIU document
 S DFN=+$G(DFN),ID=$G(ID) Q:DFN<1  Q:'$L(ID)
 N SUB,IDT,LRDFN,LR0,X
 S SUB=$P(ID,";"),IDT=+$P(ID,";",2)
 S LRDFN=$G(^DPT(DFN,"LR")),LR0=$G(^LR(LRDFN,SUB,IDT,0))
 S RPT("id")=ID,RPT("referenceDateTime")=9999999-IDT
 S RPT("localTitle")=$$NAME(SUB),RPT("status")="COMPLETED"
 S X=+$P(LR0,U,14),RPT("facility")=$$FAC^NHINV(X)
 S X=$P(LR0,U,13) I X["SC(" D
 . N CDT,HLOC S HLOC=+X,CDT=9999999-IDT
 . S X=$$GETENC^PXAPI(DFN,CDT,HLOC)
 . S:X RPT("encounter")=+X
 S X=+$P(LR0,U,4) S:X RPT("clinician",1)=X_U_$P($G(^VA(200,X,0)),U)
 S RPT("content")=$$TEXT(DFN,SUB,IDT)
 Q
 ;
TEXT(DFN,SUB,IDT) ; -- return report text as a string
 N LRDFN,DATE,NAME,NHS,NHY,I,X,Y
 K ^TMP("LRC",$J),^TMP("LRH",$J),^TMP("LRT",$J)
 S DATE=9999999-+$G(IDT),NAME=$$NAME(SUB),NHS(NAME)=""
 D EN^LR7OSUM(.NHY,DFN,DATE,DATE,,,.NHS)
 S I=+$G(^TMP("LRH",$J,NAME))+1,Y=$G(^TMP("LRC",$J,I,0)) ;LRH=header: Y=1st line
 F  S I=$O(^TMP("LRC",$J,I)) Q:I<1  S X=$G(^(I,0)) Q:X?1."="  S Y=Y_$C(13,10)_X
 K ^TMP("LRC",$J),^TMP("LRH",$J),^TMP("LRT",$J)
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(LAB) ; -- Return result as XML in @NHIN@(#)
 N ATT,X,Y,NAMES
 D ADD("<accession>") S NHINTOTL=$G(NHINTOTL)+1
 S ATT="" F  S ATT=$O(LAB(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(LAB(ATT,0)) D  S Y="" Q
 .. D ADD("<"_ATT_"s>")
 .. S NAMES=$S(ATT="document":"id^localTitle^nationalTitle^Z",ATT="lab":"id^test^result^interpretation^units^low^high^loinc^vuid^order^Z",1:"code^name^Z")
 .. S I=0 F  S I=$O(LAB(ATT,I)) Q:I<1  D
 ... S X=$G(LAB(ATT,I))
 ... S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(LAB(ATT)),Y="" Q:'$L(X)
 . I ATT="comment" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^NHINV(X)_"</"_ATT_">" Q
 . I ATT="content" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^NHINV(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^NHINV(X)_"' />" Q
 . I $L(X)>1 D  S Y=""
 .. S NAMES="code^name^Z"
 .. S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 D ADD("</accession>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^NHINV($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; -- Add a line @NHIN@(n)=X
 S NHINI=$G(NHINI)+1
 S @NHIN@(NHINI)=X
 Q
