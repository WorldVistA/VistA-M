VPRDSR ;SLC/MKB -- Surgical Procedures ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;;Sep 01, 2011;Build 12
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
 ; TIUSRVR1                      2944
 ;
 ; ------------ Get surgery(ies) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's surgeries
 N VPRN,VPRCNT,VPRITM,VPRY
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 ;
 ; get one surgery
 I $G(ID) D EN1(ID,.VPRITM),XML(.VPRITM) Q
 ;
 ; get all surgeries
 Q:'$L($T(LIST^SROESTV))
 N SHOWADD S SHOWADD=1 ;to omit leading '+' with note titles
 D LIST^SROESTV(.VPRY,DFN,BEG,END,MAX,1)
 S VPRN=0 F  S VPRN=$O(@VPRY@(VPRN)) Q:VPRN<1  D
 . K VPRITM D ONE(VPRN,.VPRITM)
 . I $D(VPRITM) D XML(.VPRITM)
 K @VPRY
 Q
 ;
ONE(NUM,SURG) ; -- return a surgery in SURG("attribute")=value
 ;  Expects DFN, @VPRY@(NUM) from LIST^SROESTV
 N IEN,VPRX,X,Y,I,VPRMOD,VPROTH
 S VPRX=$G(@VPRY@(NUM))
 S IEN=+$P(VPRX,U) Q:IEN<1  K SURG
 S SURG("id")=IEN,X=$P(VPRX,U,2),SURG("status")="COMPLETED"
 I X?1"* Aborted * ".E S X=$E(X,13,999),SURG("status")="ABORTED"
 S SURG("name")=X,SURG("dateTime")=$P(VPRX,U,3)
 S X=$P(VPRX,U,4) S:X SURG("provider")=$TR(X,";","^")
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
 . N LT,NT S LT=$P(X,U,2) Q:$P(LT," ")="Addendum"
 . S NT=$$GET1^DIQ(8925,+X_",",".01:1501")
 . S SURG("document",I)=+X_U_LT_U_NT
 . S:$G(VPRTEXT) SURG("document",I,"content")=$$TEXT^VPRDTIU(+X)
 . I LT["OPERATION REPORT"!(LT["PROCEDURE REPORT") S SURG("opReport")=+X_U_LT_U_NT
 S SURG("category")="SR"
 Q
 ;
EN1(IEN,SURG) ; -- return a surgery in SURG("attribute")=value
 N VPRX,VPRY,X,Y,I,VPRMOD,VPROTH,SHOWADD
 S SHOWADD=1 ;to omit leading '+' with note titles
 D ONE^SROESTV("VPRY",IEN) S VPRX=$G(VPRY(IEN)) Q:VPRX=""
 S SURG("id")=IEN,X=$P(VPRX,U,2),SURG("status")="COMPLETED"
 I X?1"* Aborted * ".E S X=$E(X,13,999),SURG("status")="ABORTED"
 S SURG("name")=X,SURG("dateTime")=$P(VPRX,U,3)
 S X=$P(VPRX,U,4) S:X SURG("provider")=$TR(X,";","^")
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
 . N LT,NT S LT=$P(X,U,2) Q:$P(LT," ")="Addendum"
 . S NT=$$GET1^DIQ(8925,+X_",",".01:1501")
 . S SURG("document",I)=+X_U_LT_U_NT
 . S:$G(VPRTEXT) SURG("document",I,"content")=$$TEXT^VPRDTIU(+X)
 . I LT["OPERATION REPORT"!(LT["PROCEDURE REPORT") S SURG("opReport")=+X_U_LT_U_NT
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
 N ATT,X,Y,NAMES
 D ADD("<surgery>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(SURG(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(SURG(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(SURG(ATT,I)) Q:I<1  D
 ... S X=$G(SURG(ATT,I)),NAMES=""
 ... S NAMES=$S(ATT="document":"id^localTitle^nationalTitle^Z",1:"code^name^Z")
 ... S Y="<"_ATT_" "_$$LOOP ;_"/>" D ADD(Y)
 ... S X=$G(SURG(ATT,I,"content")) I '$L(X) S Y=Y_"/>" D ADD(Y) Q
 ... S Y=Y_">" D ADD(Y)
 ... S Y="<content xml:space='preserve'>"_$$ESC^VPRD(X)_"</content>"
 ... D ADD(Y),ADD("</"_ATT_">")
 .. D ADD("</"_ATT_"s>")
 . S X=$G(SURG(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . S NAMES=$S(ATT="opReport":"id^localTitle^nationalTitle^Z",1:"code^name^Z")
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
 ;
RPT(VPRY,ID) ; -- Return report in VPRY(n)
 S ID=+$G(ID) Q:ID<1
 D TGET^TIUSRVR1(.VPRY,ID)
 Q
