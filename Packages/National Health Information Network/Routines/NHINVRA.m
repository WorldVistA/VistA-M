NHINVRA ;SLC/MKB -- Radiology extract
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC(                         10040
 ; ^VA(200                      10060
 ; DIQ                           2056
 ; ICPTCOD                       1995
 ; RAO7PC1                       2043
 ; RAO7PC3                       2877
 ;
 ; ------------ Get exam(s) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's radiology exams
 N NHITM,NHICNT,NHXID
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 K ^TMP($J,"RAE1") D EN1^RAO7PC1(DFN,BEG,END,MAX)
 ;
 ; get exam(s)
 I $G(ID) D EN1(ID,.NHITM),XML(.NHITM) Q
 ;
 ; get all exams
 S NHICNT=0,NHXID=""
 F  S NHXID=$O(^TMP($J,"RAE1",DFN,NHXID)) Q:NHXID=""  D  Q:NHICNT'<MAX
 . K NHITM D EN1(NHXID,.NHITM) Q:'$D(NHITM)
 . D XML(.NHITM) S NHICNT=NHICNT+1
 K ^TMP($J,"RAE1")
 Q
 ;
EN1(ID,EXM) ; -- return an exam in EXM("attribute")=value
 ;   Expects ^TMP($J,"RAE1",DFN,ID) from EN1^RAO7PC1
 N VPRN,VPR,X0,DATE,LOC,X,Y,IENS,NHMOD K EXM
 S X0=$G(^TMP($J,"RAE1",DFN,ID))
 S EXM("id")=ID,EXM("name")=$P(X0,U),EXM("case")=$P(X0,U,2)
 S DATE=9999999.9999-+ID,EXM("dateTime")=DATE
 I $P(X0,U,5) S EXM("document",1)=ID_U_$P(X0,U)_"^^"_$P(X0,U,3) ;id^localTitle^^status, if rpt exists
 S:$L($P(X0,U,6)) EXM("status")=$P($P(X0,U,6),"~",2)
 S X=$P(X0,U,7),LOC="" I $L(X) D
 . S LOC=+$O(^SC("B",X,0)),EXM("location")=LOC_U_X
 S EXM("facility")=$$FAC^NHINV(LOC)
 I $L($P(X0,U,8)) S X=$TR($P(X0,U,8),"~","^"),EXM("imagingType")=X
 S IENS=$P(ID,"-",2)_","_+ID_","_DFN_","
 S X=$P(X0,U,10) I X D
 . S EXM("type")=$$CPT(X)
 . I $D(^TMP($J,"RAE1",DFN,ID,"CMOD")) M EXM("modifier")=^("CMOD")
 S EXM("hasImages")=$S($P(X0,U,12)="Y":1,1:0)
 I $P(X0,U,4)="Y"!($P(X0,U,9)="Y") S EXM("interpretation")="ABNORMAL"
 S EXM("encounter")=$$GET1^DIQ(70.03,IENS,27,"I")
 S X=$$GET1^DIQ(70.03,IENS,15,"I") ;S:'X X=$$GET1^DIQ(70.03,IENS,12,"I")
 I X S EXM("provider")=X_U_$P($G(^VA(200,X,0)),U)
 S EXM("category")="RA"
 Q
 ;
CPT(IEN) ; -- return code^description for CPT code, or "^" if error
 N X0,NHX,N,I,X,Y S IEN=+$G(IEN)
 S X0=$$CPT^ICPTCOD(IEN) I X0<0 Q "^"
 S Y=$P(X0,U,2,3)                  ;CPT Code^Short Name
 S N=$$CPTD^ICPTCOD($P(Y,U),"NHX") ;CPT Description
 I N>0,$L($G(NHX(1))) D
 . S X=$G(NHX(1)),I=1
 . F  S I=$O(NHX(I)) Q:I<1  Q:NHX(I)=" "  S X=X_" "_NHX(I)
 . S $P(Y,U,2)=X
 Q Y
 ;
RPT(DFN,ID,RPT) ; -- return report as a TIU document
 S DFN=+$G(DFN),ID=$G(ID) Q:DFN<1  Q:ID<1
 N EXAM,CASE,PROC,X0,I,X,Y,IENS
 S EXAM=DFN_U_$TR(ID,"-","^") D
 . N DFN D EN3^RAO7PC3(EXAM)
 S CASE=$O(^TMP($J,"RAE3",DFN,0)),PROC=$O(^(CASE,"")),X0=$G(^(PROC))
 S I=$O(^TMP($J,"RAE3",DFN,CASE,PROC,0)),Y=$G(^(I))
 F  S I=$O(^TMP($J,"RAE3",DFN,CASE,PROC,I)) Q:I<1  S X=^(I),Y=Y_$C(13,10)_X
 S RPT("id")=ID,RPT("content")=Y
 S X=9999999.9999-(+ID),RPT("referenceDateTime")=X
 S RPT("localTitle")=PROC,RPT("status")=$P(X0,U)
 S IENS=+ID_","_DFN_",",X=$$GET1^DIQ(70.02,IENS,4,"I")
 S RPT("facility")=$$FAC^NHINV(X)
 S IENS=$P(ID,"-",2)_","_IENS
 S RPT("encounter")=$$GET1^DIQ(70.03,IENS,27,"I")
 S X=$$GET1^DIQ(70.03,IENS,15,"I") S:'X X=$$GET1^DIQ(70.03,IENS,12,"I")
 I X S RPT("clinician",1)=X_U_$P($G(^VA(200,X,0)),U)
 K ^TMP($J,"RAE3",DFN)
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(EXM) ; -- Return exams as XML
 N ATT,X,Y,NAMES
 D ADD("<radiology>") S NHINTOTL=$G(NHINTOTL)+1
 S ATT="" F  S ATT=$O(EXM(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S NAMES=$S(ATT="document":"id^localTitle^nationalTitle^status^Z",1:"code^name^Z")
 . I $O(EXM(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(EXM(ATT,I)) Q:I<1  D
 ... S X=$G(EXM(ATT,I))
 ... S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(EXM(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^NHINV(X)_"' />" Q
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</radiology>")
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
