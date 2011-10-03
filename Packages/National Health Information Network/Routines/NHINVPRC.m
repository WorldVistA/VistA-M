NHINVPRC ;SLC/MKB -- Procedure extract
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; RAO7PC1                       2043
 ; SROESTV                       3533
 ;
 ; ------------ Get procedure(s) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's procedures
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 ;
 N NHI,NHICNT,NHITM,NHY
 ;
 ; get one procedure
 I $G(ID) D  D:$D(NHITM) XML(.NHITM) Q
 . I ID'["-" D EN1^NHINVSR(ID,.NHITM) Q
 . S (BEG,END)=9999999.9999=+ID
 . D EN1^RAO7PC1(DFN,BEG,END),EN1^NHINVRA(ID,.NHITM)
 ;
 ; get all surgeries
 N SHOWADD S SHOWADD=1 ;to omit leading '+' with note titles
 D LIST^SROESTV(.NHY,DFN,BEG,END,MAX,1)
 S NHI=0 F  S NHI=$O(@NHY@(NHI)) Q:NHI<1  D
 . K NHITM D ONE^NHINVSR(NHI,.NHITM) Q:'$D(NHITM)
 . ;Q:$G(NHITM("status"))'?1"COMP".E
 . D XML(.NHITM)
 K @NHY
 ;
 ; get all radiology exams
 K ^TMP($J,"RAE1") D EN1^RAO7PC1(DFN,BEG,END,MAX)
 S NHICNT=0,NHI=""
 F  S NHI=$O(^TMP($J,"RAE1",DFN,NHI)) Q:NHI=""   D  Q:NHICNT'<MAX  ;I $P($P($G(^(NHI)),U,6),"~",2)?1"COMP".E
 . K NHITM D EN1^NHINVRA(NHI,.NHITM) Q:'$D(NHITM)
 . D XML(.NHITM) S NHICNT=NHICNT+1
 K ^TMP($J,"RAE1")
 ;
 ; Consults/ClinProc
 ; V-files [CPT, Exam, Treatment, Patient ED]
 ;
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(PRC) ; -- Return procedures as XML
 N ATT,X,Y,I,NAMES
 D ADD("<procedure>") S NHINTOTL=$G(NHINTOTL)+1
 S ATT="" F  S ATT=$O(PRC(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S NAMES=$S(ATT="document"!(ATT="opReport"):"id^localTitle^nationalTitle^status^Z",1:"code^name^Z")
 . I $O(PRC(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(PRC(ATT,I)) Q:I<1  D
 ... S X=$G(PRC(ATT,I))
 ... S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(PRC(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^NHINV(X)_"' />" Q
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</procedure>")
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
