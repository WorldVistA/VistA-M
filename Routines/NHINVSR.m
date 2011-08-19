NHINVSR ;SLC/MKB -- Surgical Procedures
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DIQ                           2056
 ; STATUS^GMTSROB                3969
 ; ICPTCOD                       1995
 ; ICPTMOD                       1996
 ; SROESTV                       3533
 ; TIUSRVR1                      2944
 ;
 ; ------------ Get surgery(ies) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's surgeries
 N NHI,NHICNT,NHITM,NHY
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 ;
 ; get one surgery
 I $G(ID) D EN1(ID,.NHITM),XML(.NHITM) Q
 ;
 ; get all surgeries
 Q:'$L($T(LIST^SROESTV))
 N SHOWADD S SHOWADD=1 ;to omit leading '+' with note titles
 D LIST^SROESTV(.NHY,DFN,BEG,END,MAX,1)
 S NHI=0 F  S NHI=$O(@NHY@(NHI)) Q:NHI<1  D
 . K NHITM D ONE(NHI,.NHITM)
 . I $D(NHITM) D XML(.NHITM)
 K @NHY
 Q
 ;
ONE(NUM,SURG) ; -- return a surgery in SURG("attribute")=value
 ;  Expects DFN, @NHY@(NUM) from LIST^SROESTV
 N IEN,NHX,X,Y,I,NHMOD,NHOTH
 S NHX=$G(@NHY@(NUM))
 S IEN=+$P(NHX,U) Q:IEN<1  K SURG
 S SURG("id")=IEN,SURG("name")=$P(NHX,U,2)
 S SURG("dateTime")=$P(NHX,U,3)
 S X=$P(NHX,U,4) S:X SURG("provider")=$TR(X,";","^")
 S SURG("status")=$$STATUS(IEN,$P(NHX,U,3))
 S X=$$GET1^DIQ(130,IEN_",",50,"I"),SURG("facility")=$$FAC^NHINV(X)
 S SURG("encounter")=$$GET1^DIQ(130,IEN_",",.015,"I")
 S X=$$GET1^DIQ(130,IEN_",",27,"I") I X D
 . S SURG("type")=$$CPT(X)
 . D GETS^DIQ(130,IEN_",","28*","I","NHMOD") ;CPT modifiers
 . S I="" F  S I=$O(NHMOD(130.028,I)) Q:I=""  D
 .. S X=+$G(NHMOD(130.028,I,.01,"I")),Y=$$MOD^ICPTMOD(X,"I")
 .. S SURG("modifier",+I)=$P(Y,U,2,3)
 D GETS^DIQ(130,IEN_",",".42*","I","NHOTH") ;other procedures
 S I="" F  S I=$O(NHOTH(130.16,I)) Q:I=""  D
 . S X=+$G(NHOTH(130.16,I,3,"I")) Q:'X
 . S SURG("otherProcedure",+I)=$$CPT(X)
 S I=0 F  S I=$O(@NHY@(NUM,I)) Q:I<1  S X=$G(@NHY@(NUM,I)) I X D
 . N LT,NT S LT=$P(X,U,2) Q:$P(LT," ")="Addendum"
 . S NT=$$GET1^DIQ(8925,+X_",",".01:1501")
 . S SURG("document",I)=+X_U_LT_U_NT
 . I LT["OPERATION REPORT"!(LT["PROCEDURE REPORT") S SURG("opReport")=+X_U_LT_U_NT
 S SURG("category")="SR"
 Q
 ;
EN1(IEN,SURG) ; -- return a surgery in SURG("attribute")=value
 N NHX,NHY,X,Y,I,NHMOD,NHOTH,SHOWADD
 S SHOWADD=1 ;to omit leading '+' with note titles
 D ONE^SROESTV("NHY",IEN) S NHX=$G(NHY(IEN)) Q:NHX=""
 S SURG("id")=IEN,SURG("name")=$P(NHX,U,2),SURG("dateTime")=$P(NHX,U,3)
 S X=$P(NHX,U,4) S:X SURG("provider")=$TR(X,";","^")
 S SURG("status")=$$STATUS(IEN,$P(NHX,U,3))
 S X=$$GET1^DIQ(130,IEN_",",50,"I"),SURG("facility")=$$FAC^NHINV(X)
 S SURG("encounter")=$$GET1^DIQ(130,IEN_",",.015,"I")
 S X=$$GET1^DIQ(130,IEN_",",27,"I") I X D
 . S SURG("type")=$$CPT(X)
 . D GETS^DIQ(130,IEN_",","28*","I","NHMOD") ;CPT modifiers
 . S I="" F  S I=$O(NHMOD(130.028,I)) Q:I=""  D
 .. S X=+$G(NHMOD(130.028,I,.01,"I")),Y=$$MOD^ICPTMOD(X,"I")
 .. S SURG("modifier",+I)=$P(Y,U,2,3)
 D GETS^DIQ(130,"28,",".42*","I","NHOTH") ;other procedures
 S I="" F  S I=$O(NHOTH(130.16,I)) Q:I=""  D
 . S X=+$G(NHOTH(130.16,I,3,"I")) Q:'X
 . S SURG("otherProcedure",+I)=$$CPT(X)
 S I=0 F  S I=$O(NHY(IEN,I)) Q:I<1  S X=$G(NHY(IEN,I)) I X D
 . N LT,NT S LT=$P(X,U,2) Q:$P(LT," ")="Addendum"
 . S NT=$$GET1^DIQ(8925,+X_",",".01:1501")
 . S SURG("document",I)=+X_U_LT_U_NT
 . I LT["OPERATION REPORT"!(LT["PROCEDURE REPORT") S SURG("opReport")=+X_U_LT_U_NT
 S SURG("category")="SR"
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
STATUS(GMN,GMDT) ; -- get current STATUS of request
 N STATUS S STATUS="UNKNOWN"
 I $G(GMN),$G(GMDT) D STATUS^GMTSROB
 I $E(STATUS)="(" S STATUS=$P($P(STATUS,"(",2),")")
 Q STATUS
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(SURG) ; -- Return surgery as XML
 N ATT,X,Y,NAMES
 D ADD("<surgery>") S NHINTOTL=$G(NHINTOTL)+1
 S ATT="" F  S ATT=$O(SURG(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(SURG(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(SURG(ATT,I)) Q:I<1  D
 ... S X=$G(SURG(ATT,I)),NAMES=""
 ... S NAMES=$S(ATT="document":"id^localTitle^nationalTitle^Z",1:"code^name^Z")
 ... S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(SURG(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^NHINV(X)_"' />" Q
 . S NAMES=$S(ATT="opReport":"id^localTitle^nationalTitle^Z",1:"code^name^Z")
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</surgery>")
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
 ;
RPT(NHY,ID) ; -- Return report in NHY(n)
 S ID=+$G(ID) Q:ID<1
 D TGET^TIUSRVR1(.NHY,ID)
 Q
