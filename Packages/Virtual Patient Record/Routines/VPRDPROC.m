VPRDPROC ;SLC/MKB -- Procedure extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 ;
 N VPRN,VPRCNT,VPRITM,VPRY,VPRCATG
 S VPRCATG=$G(FILTER("category"),"SR;RA") ;NwHIN default
 ;
 ; get one procedure
 I $G(ID),ID'[";" D  D:$D(VPRITM) XML(.VPRITM) Q
 . I ID'["-" D EN1^VPRDSR(ID,.VPRITM) Q    ;Surgery
 . S (BEG,END)=9999999.9999=+ID D EN1^RAO7PC1(DFN,BEG,END,"1P")
 . D EN1^VPRDRA(ID,.VPRITM)                ;Radiology
 . K ^TMP($J,"RAE1")
 I $G(ID),ID[";" D EN^VPRDMC(DFN,,,,ID) Q  ;CP/Medicine
 ;
SR ; get all surgeries
 I VPRCATG'["SR" G RA
 N SHOWADD S SHOWADD=1 ;to omit leading '+' with note titles
 D LIST^SROESTV(.VPRY,DFN,BEG,END,MAX,1)
 S VPRN=0 F  S VPRN=$O(@VPRY@(VPRN)) Q:VPRN<1  D
 . K VPRITM D ONE^VPRDSR(VPRN,.VPRITM) Q:'$D(VPRITM)
 . ;Q:$G(VPRITM("status"))'?1"COMP".E
 . D XML(.VPRITM)
 K @VPRY
 ;
RA ; get all radiology exams
 I VPRCATG'["RA" G CP
 K ^TMP($J,"RAE1") D EN1^RAO7PC1(DFN,BEG,END,MAX)
 S VPRCNT=+$G(VPRTOTL),VPRN=""
 F  S VPRN=$O(^TMP($J,"RAE1",DFN,VPRN)) Q:VPRN=""   D  Q:VPRCNT'<MAX  ;I $P($P($G(^(VPRN)),U,6),"~",2)?1"COMP".E
 . K VPRITM D EN1^VPRDRA(VPRN,.VPRITM) Q:'$D(VPRITM)
 . D XML(.VPRITM) S VPRCNT=VPRCNT+1
 K ^TMP($J,"RAE1")
 ;
CP ; get CP procedures
 D:VPRCATG["CP" EN^VPRDMC(DFN,BEG,END,MAX)
 ;
 ; V-CPT
 ;
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(PROC) ; -- Return procedures as XML
 N ATT,X,Y,I,J,NAMES
 D ADD("<procedure>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(PROC(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S NAMES=$S(ATT="document"!(ATT="opReport"):"id^localTitle^nationalTitle^vuid^status^Z",1:"code^name^Z")
 . I $O(PROC(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(PROC(ATT,I)) Q:I<1  D
 ... S X=$G(PROC(ATT,I))
 ... S Y="<"_ATT_" "_$$LOOP ;_"/>" D ADD(Y)
 ... S X=$G(PROC(ATT,I,"content")) I '$L(X) S Y=Y_"/>" D ADD(Y) Q
 ... S Y=Y_">" D ADD(Y)
 ... S Y="<content xml:space='preserve'>" D ADD(Y)
 ... S J=0 F  S J=$O(@X@(J)) Q:J<1  S Y=$$ESC^VPRD(@X@(J)) D ADD(Y)
 ... D ADD("</content>"),ADD("</"_ATT_">")
 .. D ADD("</"_ATT_"s>")
 . S X=$G(PROC(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</procedure>")
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
