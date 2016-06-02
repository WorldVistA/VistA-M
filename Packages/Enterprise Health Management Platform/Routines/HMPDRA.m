HMPDRA ;SLC/MKB,ASMR/RRB - Radiology extract;8/2/11  15:29
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^RADPT                        2480
 ; ^RARPT                        8000005
 ; ^SC(                         10040
 ; ^VA(200                      10060
 ; DIQ                           2056
 ; ICPTCOD                       1995
 ; RAO7PC1                  2043,2265
 ; RAO7PC3                       2877
 Q
 ; ------------ Get exam(s) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's radiology exams
 N HMPITM,HMPXID
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)_"P"
 K ^TMP($J,"RAE1") D EN1^RAO7PC1(DFN,BEG,END,MAX)
 ;
 ; get exam(s)
 I $G(ID) D EN1(ID,.HMPITM),XML(.HMPITM) G ENQ
 ;
 ; get all exams
 S HMPXID="" F  S HMPXID=$O(^TMP($J,"RAE1",DFN,HMPXID)) Q:HMPXID=""  D
 . K HMPITM D EN1(HMPXID,.HMPITM) Q:'$D(HMPITM)
 . D XML(.HMPITM)
ENQ ; end
 K ^TMP($J,"RAE1"),^TMP("HMPTEXT",$J)
 Q
 ;
EN1(ID,EXAM) ; -- return an exam in EXAM("attribute")=value
 ;   Expects ^TMP($J,"RAE1",DFN,ID) from EN1^RAO7PC1
 N X0,SET,PROC,DATE,LOC,X,Y,IENS
 K EXAM,^TMP("HMPTEXT",$J)
 S X0=$G(^TMP($J,"RAE1",DFN,ID)),SET=$G(^(ID,"CPRS")),PROC=$P(X0,U)
 S EXAM("id")=ID,EXAM("name")=PROC,EXAM("case")=$P(X0,U,2)
 S DATE=9999999.9999-+ID,EXAM("dateTime")=DATE
 I $P(X0,U,5) D  ;report exists
 . N NM S NM=$S(+SET=2:$P(SET,U,2),1:PROC)     ;2 = shared report
 . S EXAM("document",1)=ID_U_NM_"^^"_$P(X0,U,3) ;id^localTitle^^status
 . S:$G(HMPTEXT) EXAM("document",1,"content")=$$TEXT(DFN,ID)
 S:$L($P(X0,U,6)) EXAM("status")=$P($P(X0,U,6),"~",2)
 S X=$P(X0,U,7),LOC="" I $L(X) D
 . S LOC=+$O(^SC("B",X,0)),EXAM("location")=LOC_U_X ;ICR 10040 DE2818 ASF 11/18/15
 S EXAM("facility")=$$FAC^HMPD(LOC)
 I $L($P(X0,U,8)) S X=$TR($P(X0,U,8),"~","^"),EXAM("imagingType")=X
 S IENS=$P(ID,"-",2)_","_+ID_","_DFN_","
 S X=$P(X0,U,10) I X D
 . S EXAM("type")=$$CPT(X)
 . I $D(^TMP($J,"RAE1",DFN,ID,"CMOD")) M EXAM("modifier")=^("CMOD")
 I $P(X0,U,11) S EXAM("order")=+$P(X0,U,11)_U_$S($L(SET):$P(SET,U,2),1:PROC)
 S EXAM("hasImages")=$S($P(X0,U,12)="Y":1,1:0)
 I $P(X0,U,4)="Y"!($P(X0,U,9)="Y") S EXAM("interpretation")="ABNORMAL"
 S EXAM("encounter")=$$GET1^DIQ(70.03,IENS,27,"I")
 S ID=DFN_U_$TR(ID,"-","^") D EN3^RAO7PC1(ID) D  ;get additional values
 . S X=+$G(^TMP($J,"RAE2",DFN,+$P(ID,U,3),PROC,"P"))
 . I X S EXAM("provider")=X_U_$P($G(^VA(200,X,0)),U) ;ICR10060 DE2818 ASF 11/18/15
 S EXAM("category")="RA"
 Q
 ;
CPT(IEN) ; -- return code^description for CPT code, or "^" if error
 N X0,HMPX,N,I,X,Y S IEN=+$G(IEN)
 S X0=$$CPT^ICPTCOD(IEN) I X0<0 Q "^"
 S Y=$P(X0,U,2,3)                  ;CPT Code^Short Name
 S N=$$CPTD^ICPTCOD($P(Y,U),"HMPX") ;CPT Description
 I N>0,$L($G(HMPX(1))) D
 . S X=$G(HMPX(1)),I=1
 . F  S I=$O(HMPX(I)) Q:I<1  Q:HMPX(I)=" "  S X=X_" "_HMPX(I)
 . S $P(Y,U,2)=X
 Q Y
 ;
TEXT(PAT,ID) ; -- Get report text, return temp array name
 S PAT=+$G(PAT),ID=$G(ID) I PAT<1!(ID<1) Q ""
 N DFN,EXAM,CASE,PROC,I,X,Y
 S EXAM=PAT_U_$TR(ID,"-","^") D EN3^RAO7PC3(EXAM)
 S Y=$NA(^TMP("HMPTEXT",$J,ID)) K @Y
 S CASE=$O(^TMP($J,"RAE3",PAT,0)),PROC=$O(^(CASE,""))
 S I=0 F  S I=$O(^TMP($J,"RAE3",PAT,CASE,PROC,I)) Q:I<1  S X=^(I),@Y@(I)=X
 K ^TMP($J,"RAE3",PAT)
 Q Y
 ;
 ; ------------ Get report(s) [via HMPDTIU] ------------
 ;
RPTS(DFN,BEG,END,MAX) ; -- find patient's radiology reports
 N HMPITM,HMPXID,STS,PSET
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)_"P"
 K ^TMP($J,"RAE1") D EN1^RAO7PC1(DFN,BEG,END,MAX)
 S HMPXID="" F  S HMPXID=$O(^TMP($J,"RAE1",DFN,HMPXID)) Q:HMPXID=""  D
 . S STS=$P($G(^TMP($J,"RAE1",DFN,HMPXID)),U,3),PSET=$G(^(HMPXID,"CPRS"))
 . Q:STS="No Report"!(STS="Deleted")  ;!(STS["Draft") ??
 . I +PSET=2,$G(PSET(+HMPXID,$P(PSET,U,2))) Q  ;already have report
 . K HMPITM D RPT1(DFN,HMPXID,.HMPITM) D:$D(HMPITM) XML^HMPDTIU(.HMPITM)
 . I +PSET=2 S PSET(+HMPXID,$P(PSET,U,2))=$P(HMPXID,"-",2) ;parent
 K ^TMP($J,"RAE1"),^TMP("HMPTEXT",$J)
 Q
 ;
RPT1(DFN,ID,RPT) ; -- return report as a TIU document
 S DFN=+$G(DFN),ID=$G(ID) Q:DFN<1  Q:ID<1
 N EXAM,CASE,PROC,RAE3,RAE1,I,X,Y,IENS,LOC
 K RPT,^TMP("HMPTEXT",$J)
 S EXAM=DFN_U_$TR(ID,"-","^") D
 . N DFN D EN3^RAO7PC3(EXAM) ;report
 . D EN3^RAO7PC1(EXAM)       ;add'l values
 S CASE=$O(^TMP($J,"RAE3",DFN,0)),PROC=$O(^(CASE,"")),RAE3=$G(^(PROC))
 S RAE1=$G(^TMP($J,"RAE1",DFN,ID))
 I $G(HMPTEXT) D
 . S Y=$NA(^TMP("HMPTEXT",$J,ID))
 . S I=0 F  S I=$O(^TMP($J,"RAE3",DFN,CASE,PROC,I)) Q:I<1  S X=^(I),@Y@(I)=X
 . S RPT("content")=Y
 S RPT("id")=ID,RPT("status")=$P(RAE3,U)
 S X=9999999.9999-(+ID),RPT("referenceDateTime")=X
 S X=+$G(^TMP($J,"RAE2",DFN,CASE,PROC,"P"))
 I X S RPT("clinician",1)=X_U_$P($G(^VA(200,X,0)),U)_"^A" ;ICR10060 DE2818 ASF 11/18/15
 S X=$G(^TMP($J,"RAE2",DFN,CASE,PROC,"V")) I X D
 . N Y S Y=$$GET1^DIQ(74,+$P(RAE1,U,5)_",",7,"I")
 . S RPT("clinician",2)=+X_U_$P($G(^VA(200,+X,0)),U)_"^S^"_Y_U_$P(X,U,2) ;ICR10060 DE2818 ASF 11/18/15
 I $D(^TMP($J,"RAE3",DFN,"PRINT_SET")) S PROC=$G(^("ORD")) ;use parent, if printset
 S RPT("localTitle")=PROC,RPT("category")="RA"
 S RPT("nationalTitle")="4695068^RADIOLOGY REPORT"
 S RPT("nationalTitleSubject")="4693357^RADIOLOGY"
 S RPT("nationalTitleType")="4696123^REPORT"
 S X=$P(RAE1,U,7),LOC="" I $L(X) D
 . S LOC=+$O(^SC("B",X,0)) ;,EXAM("location")=LOC_U_X ICR 10040 DE2818 ASF 11/18/15
 S RPT("facility")=$$FAC^HMPD(LOC)
 S IENS=$P(ID,"-",2)_","_+ID_","_DFN_","
 S RPT("encounter")=$$GET1^DIQ(70.03,IENS,27,"I")
 S:$G(FILTER("loinc")) RPT("loinc")=$P(FILTER("loinc"),U)
 K ^TMP($J,"RAE3",DFN),^TMP($J,"RAE2",DFN)
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(EXAM) ; -- Return exams as XML
 N ATT,X,Y,NAMES,I,J
 D ADD("<radiology>") S HMPTOTL=$G(HMPTOTL)+1
 S ATT="" F  S ATT=$O(EXAM(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S NAMES=$S(ATT="document":"id^localTitle^nationalTitle^status^Z",1:"code^name^Z")
 . I $O(EXAM(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(EXAM(ATT,I)) Q:I<1  D
 ... S X=$G(EXAM(ATT,I))
 ... S Y="<"_ATT_" "_$$LOOP ;_"/>" D ADD(Y)
 ... S X=$G(EXAM(ATT,I,"content")) I '$L(X) S Y=Y_"/>" D ADD(Y) Q
 ... S Y=Y_">" D ADD(Y)
 ... S Y="<content xml:space='preserve'>" D ADD(Y)
 ... S J=0 F  S J=$O(@X@(J)) Q:J<1  S Y=$$ESC^HMPD(@X@(J)) D ADD(Y)
 ... D ADD("</content>"),ADD("</"_ATT_">")
 .. D ADD("</"_ATT_"s>")
 . S X=$G(EXAM(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^HMPD(X)_"' />" Q
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</radiology>")
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
