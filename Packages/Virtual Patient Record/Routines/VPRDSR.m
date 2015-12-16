VPRDSR ;SLC/MKB -- Surgical Procedures ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SRF(130                      5675
 ; ^SRO(136                      4872
 ; DIQ                           2056
 ; ICPTCOD                       1995
 ; ICPTMOD                       1996
 ; SROESTV                       3533
 ;
 ; ------------ Get surgery(ies) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's surgeries
 N VPRN,VPRCNT,VPRITM,VPRY
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 ;
 ; get one surgery
 I $G(ID) D EN1(ID,.VPRITM),XML(.VPRITM) G ENQ
 ;
 ; get all surgeries
 Q:'$L($T(LIST^SROESTV))
 N SHOWADD S SHOWADD=1 ;to omit leading '+' with note titles
 D LIST^SROESTV(.VPRY,DFN,BEG,END,MAX,1)
 S VPRN=0 F  S VPRN=$O(@VPRY@(VPRN)) Q:VPRN<1  D
 . K VPRITM D ONE(VPRN,.VPRITM)
 . I $D(VPRITM) D XML(.VPRITM)
 K @VPRY
ENQ ; end
 K ^TMP("VPRTEXT",$J)
 Q
 ;
ONE(NUM,SURG) ; -- return a surgery in SURG("attribute")=value
 ;  Expects DFN, @VPRY@(NUM) from LIST^SROESTV
 N IEN,VPRX,X,Y,I,VPRMOD,VPROTH
 K SURG,^TMP("VPRTEXT",$J)
 S VPRX=$G(@VPRY@(NUM)),IEN=+$P(VPRX,U) Q:IEN<1
 S SURG("id")=IEN,X=$P(VPRX,U,2),SURG("status")="COMPLETED"
 I X?1"* Aborted * ".E S X=$E(X,13,999),SURG("status")="ABORTED"
 S SURG("name")=X,SURG("dateTime")=$P(VPRX,U,3)
 S X=$P(VPRX,U,4) S:X SURG("provider")=$TR(X,";","^")_U_$$PROVSPC^VPRD(+X)
 S X=$$GET1^DIQ(130,IEN_",",50,"I"),SURG("facility")=$$FAC^VPRD(X)
 S SURG("encounter")=$$GET1^DIQ(130,IEN_",",.015,"I")
 S X=$$GET1^DIQ(136,IEN_",",.02,"I") I X D
 . S SURG("type")=$$CPT(X)
 . D GETS^DIQ(136,IEN_",","1*","I","VPRMOD") ;CPT modifiers
 . S I="" F  S I=$O(VPRMOD(136.01,I)) Q:I=""  D
 .. S X=+$G(VPRMOD(136.01,I,.01,"I")),Y=$$MOD^ICPTMOD(X,"I")
 .. S SURG("modifier",+I)=$P(Y,U,2,3)
 D GETS^DIQ(136,IEN_",","3*","I","VPROTH") ;other procedures
 S I="" F  S I=$O(VPROTH(136.03,I)) Q:I=""  D
 . S X=+$G(VPROTH(136.03,I,.01,"I")) Q:'X
 . S SURG("otherProcedure",+I)=$$CPT(X)
 S I=0 F  S I=$O(@VPRY@(NUM,I)) Q:I<1  S X=$G(@VPRY@(NUM,I)) I X D
 . S Y=$$INFO^VPRDTIU(+X) Q:Y<1  ;draft or retracted
 . S SURG("document",I)=Y
 . S:$G(VPRTEXT) SURG("document",I,"content")=$$TEXT^VPRDTIU(+X)
 . I Y["OPERATION REPORT"!(Y["PROCEDURE REPORT") S SURG("opReport")=Y
 S SURG("category")="SR"
 Q
 ;
EN1(IEN,SURG) ; -- return a surgery in SURG("attribute")=value
 N VPRX,VPRY,X,Y,I,VPRMOD,VPROTH,SHOWADD
 K SURG,^TMP("VPRTEXT",$J)
 S SHOWADD=1 ;to omit leading '+' with note titles
 D ONE^SROESTV("VPRY",IEN) S VPRX=$G(VPRY(IEN)) Q:VPRX=""
 S SURG("id")=IEN,X=$P(VPRX,U,2),SURG("status")="COMPLETED"
 I X?1"* Aborted * ".E S X=$E(X,13,999),SURG("status")="ABORTED"
 S SURG("name")=X,SURG("dateTime")=$P(VPRX,U,3)
 S X=$P(VPRX,U,4) S:X SURG("provider")=$TR(X,";","^")_U_$$PROVSPC^VPRD(+X)
 S X=$$GET1^DIQ(130,IEN_",",50,"I"),SURG("facility")=$$FAC^VPRD(X)
 S SURG("encounter")=$$GET1^DIQ(130,IEN_",",.015,"I")
 S X=$$GET1^DIQ(136,IEN_",",.02,"I") I X D
 . S SURG("type")=$$CPT(X)
 . D GETS^DIQ(136,IEN_",","1*","I","VPRMOD") ;CPT modifiers
 . S I="" F  S I=$O(VPRMOD(136.01,I)) Q:I=""  D
 .. S X=+$G(VPRMOD(136.01,I,.01,"I")),Y=$$MOD^ICPTMOD(X,"I")
 .. S SURG("modifier",+I)=$P(Y,U,2,3)
 D GETS^DIQ(136,IEN_",","3*","I","VPROTH") ;other procedures
 S I="" F  S I=$O(VPROTH(136.03,I)) Q:I=""  D
 . S X=+$G(VPROTH(136.03,I,.01,"I")) Q:'X
 . S SURG("otherProcedure",+I)=$$CPT(X)
 S I=0 F  S I=$O(VPRY(IEN,I)) Q:I<1  S X=$G(VPRY(IEN,I)) I X D
 . S Y=$$INFO^VPRDTIU(+X) Q:Y<1  ;draft or retracted
 . S SURG("document",I)=Y
 . S:$G(VPRTEXT) SURG("document",I,"content")=$$TEXT^VPRDTIU(+X)
 . I Y["OPERATION REPORT"!(Y["PROCEDURE REPORT") S SURG("opReport")=Y
 S SURG("category")="SR"
 Q
 ;
CPT(IEN) ; -- return code^description for CPT code, or "^" if error
 N X0,VPRX,N,I,X,Y S IEN=+$G(IEN)
 S X0=$$CPT^ICPTCOD(IEN) I X0<0 Q "^"
 S Y=$P(X0,U,2,3)                  ;CPT Code^Short Name
 S N=$$CPTD^ICPTCOD($P(Y,U),"VPRX") ;CPT Description
 I N>0,$L($G(VPRX(1))) D
 . S X=$G(VPRX(1)),I=1
 . F  S I=$O(VPRX(I)) Q:I<1  Q:VPRX(I)=" "  S X=X_" "_VPRX(I)
 . S $P(Y,U,2)=X
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(SURG) ; -- Return surgery as XML
 N ATT,X,Y,NAMES,I,J
 D ADD("<surgery>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(SURG(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(SURG(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(SURG(ATT,I)) Q:I<1  D
 ... S X=$G(SURG(ATT,I)),NAMES=""
 ... S NAMES=$S(ATT="document":"id^localTitle^nationalTitle^vuid^Z",1:"code^name^Z")
 ... S Y="<"_ATT_" "_$$LOOP ;_"/>" D ADD(Y)
 ... S X=$G(SURG(ATT,I,"content")) I '$L(X) S Y=Y_"/>" D ADD(Y) Q
 ... S Y=Y_">" D ADD(Y)
 ... S Y="<content xml:space='preserve'>" D ADD(Y)
 ... S J=0 F  S J=$O(@X@(J)) Q:J<1  S Y=$$ESC^VPRD(@X@(J)) D ADD(Y)
 ... D ADD("</content>"),ADD("</"_ATT_">")
 .. D ADD("</"_ATT_"s>")
 . S X=$G(SURG(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . S NAMES=$S(ATT="opReport":"id^localTitle^nationalTitle^vuid",ATT="provider":"code^name^"_$$PROVTAGS^VPRD,1:"code^name")_"^Z"
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</surgery>")
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
