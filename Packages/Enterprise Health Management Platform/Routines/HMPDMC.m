HMPDMC ;SLC/MKB,ASMR/RRB,BL,CPC - Clinical Procedures (Medicine);Aug 29, 2016 20:06:27
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;Sep 01, 2011;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; DE2818, ^SC and ^VA(200) references supprted
 ; External Reference ~ DBIA#
 ; ^SC ~ 10040
 ; ^TIU(8925.1 ~ 5677
 ; ^VA(200 ~ 10060
 ; %DT ~ 10003
 ; DILFD ~ 2055
 ; DIQ ~ 2056
 ; GMRCGUIB ~ 2980
 ; ICPTCOD ~ 1995
 ; MCARUTL2 ~ 3279
 ; MCARUTL3 ~ 3280
 ; MDPS1,^TMP("MDHSP"/"MDPTXT" ~ 4230
 ; TIULQ ~ 2693
 ; TIUSRVLO ~ 2834
 ; XUAF4 ~ 2171
 Q
 ; ------------ Get procedures from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's procedures
 N HMPITM,RES,HMPN,HMPX,RTN,DATE,CONS,TIUN,X0,DA,GBL,X,Y,%DT,HMPT,LT,NT,LOC
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S DFN=+$G(DFN) I '(DFN>0) D LOGDPT^HMPLOG(DFN) Q  ;DE4496 19 August 2016
 ;
 ; get one procedure
 I $G(ID) D  ;reset dates for MDPS1
 . N HMPMC,IEN,FILE
 . S IEN=+ID,FILE=+$P(ID,"(",2) Q:FILE=702
 . D MEDLKUP^MCARUTL3(.HMPMC,FILE,IEN)
 . S X=$P(HMPMC,U,6) S:X (BEG,END)=X
 ;
 ; get all procedures
 K ^TMP("MDHSP",$J) S RES=""
 D EN1^MDPS1(RES,DFN,BEG,END,MAX,"",0)
 S HMPN=0 F  S HMPN=$O(^TMP("MDHSP",$J,HMPN)) Q:HMPN<1  S HMPX=$G(^(HMPN)) D
 . I $G(ID),ID'=+$P(HMPX,U,2) Q              ;update one procedure
 . S RTN=$P(HMPX,U,3,4) Q:RTN="PRPRO^MDPS4"  ;skip non-CP items
 . S X=$P(HMPX,U,6),%DT="TX" D ^%DT S:Y>0 DATE=Y
 . S GBL=+$P(HMPX,U,2)_";"_$S(RTN="PR702^MDPS1":"MDD(702,",1:$$ROOT(DFN,$P(HMPX,U,11),DATE))
 . Q:'GBL  I $G(ID),ID'=GBL Q                ;unknown, or not requested
 . ;
 . S CONS=+$P(HMPX,U,13) D:CONS DOCLIST^GMRCGUIB(.HMPD,CONS) S X0=$G(HMPD(0)) ;=^GMR(123,ID,0)
 . S TIUN=+$P(HMPX,U,14) S:TIUN TIUN=TIUN_U_$$RESOLVE^TIUSRVLO(TIUN)
A . ;
 . K HMPITM S HMPITM("id")=GBL,HMPITM("name")=$P(HMPX,U)
 . S HMPITM("dateTime")=DATE,HMPITM("category")="CP"
 . S X=$P(HMPX,U,7) S:$L(X) HMPITM("interpretation")=X
 . I CONS,X0 D
 .. N HMPJ S HMPITM("consult")=CONS
 .. S HMPITM("requested")=+X0,HMPITM("order")=+$P(X0,U,3)
 .. S HMPITM("status")=$$EXTERNAL^DILFD(123,8,,$P(X0,U,12))
 .. S HMPJ=0 F  S HMPJ=$O(HMPD(50,HMPJ)) Q:HMPJ<1  S X=+$G(HMPD(50,HMPJ)) D
 ... K HMPT D EXTRACT^TIULQ(X,"HMPT",,.01) S LT=$G(HMPT(X,.01,"E"))
 ... S NT=$$GET1^DIQ(8925.1,+$G(HMPT(X,.01,"I"))_",",1501)
 ... S HMPITM("document",X)=X_U_LT_U_NT  ;ien^local^national title
 ... S:$G(HMPTEXT) HMPITM("document",X,"content")=$$TEXT^HMPDTIU(X)
 ... S:'TIUN TIUN=X ;get supporting fields
B . ;
 . I TIUN D
 .. S X=$P(TIUN,U,5) S:X HMPITM("provider")=+X_U_$P(X,";",3)
 .. S:$P(TIUN,U,11) HMPITM("hasImages")=1
 .. K HMPT D EXTRACT^TIULQ(+TIUN,"HMPT",,".03;.05;1211",,,"I")
 .. S HMPITM("encounter")=+$G(HMPT(+TIUN,.03,"I"))
 .. S LOC=+$G(HMPT(+TIUN,1211,"I")) I LOC S LOC=LOC_U_$P($G(^SC(LOC,0)),U)
 .. E  S X=$P(TIUN,U,6) S:$L(X) LOC=+$O(^SC("B",X,0))_U_X
 .. S:LOC HMPITM("location")=LOC,HMPITM("facility")=$$FAC^HMPD(+LOC)
 .. I '$D(HMPITM("status")) S X=+$G(HMPT(+TIUN,.05,"I")),HMPITM("status")=$S(X<6:"PARTIAL RESULTS",1:"COMPLETE")
 .. I '$G(HMPITM("document",+TIUN)) D
 ... K HMPT D EXTRACT^TIULQ(+TIUN,"HMPT",,.01,,,"I")
 ... S NT=$$GET1^DIQ(8925.1,+$G(HMPT(+TIUN,.01,"I"))_",",1501)
 ... S HMPITM("document",+TIUN)=$P(TIUN,U,1,2)_U_NT  ;ien^local^national title
 ... S:$G(HMPTEXT) HMPITM("document",+TIUN,"content")=$$TEXT^HMPDTIU(+TIUN)
C . ;
 . ; if no consult or note/visit ...
 . I '$D(HMPITM("facility")) S X=$P(X0,U,21),HMPITM("facility")=$S(X:$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U),1:$$FAC^HMPD)
 . I '$D(HMPITM("status")) S HMPITM("status")="COMPLETE"
 . ;I DA D  ;get CPT code from #697.2
 . ;. K HMPT D GETS^DIQ(697.2,DA_",","1000*",,"HMPT")
 . ;. N IENS S IENS=$O(HMPT(697.21,"")) Q:IENS=""
 . ;. S X=HMPT(697.21,IENS,.01),HMPITM("type")=$$CPT(X)
 . ;
 . D XML(.HMPITM)
ENQ ;
 K ^TMP("MDHSP",$J),^TMP("HMPTEXT",$J)
 Q
 ;
ROOT(DFN,NAME,DATE) ; -- return vptr ID for procedure instance
 N HMPMC,Y
 D SUB^MCARUTL2(.HMPMC,DFN,NAME,DATE,DATE)
 S Y=$S(+$G(HMPMC):$P($G(HMPMC(HMPMC)),U,4)_",",1:"")
 Q Y
 ;
CPT(IEN) ; -- return code^description for CPT code, or "^" if error
 N X0,HMPX,N,I,X,Y S IEN=+$G(IEN)
 S X0=$$CPT^ICPTCOD(IEN) I X0<0 Q "^"
 S Y=$P(X0,U,2,3)                   ;CPT Code^Short Name
 S N=$$CPTD^ICPTCOD($P(Y,U),"HMPX") ;CPT Description
 I N>0,$L($G(HMPX(1))) D
 . S X=$G(HMPX(1)),I=1
 . F  S I=$O(HMPX(I)) Q:I<1  Q:HMPX(I)=" "  S X=X_" "_HMPX(I)
 . S $P(Y,U,2)=X
 Q Y
 ;
 ; ------------ Get report(s) [via HMPDTIU] ------------
 ;
RPTS(DFN,BEG,END,MAX) ; -- find patient's medicine reports
 N HMPITM,HMPN,HMPX,RTN,TIUN,CONS,HMPD,I,DA,X,Y,%DT,DATE,GBL,RES
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999),RES=""
 K ^TMP("MDHSP",$J) D EN1^MDPS1(RES,DFN,BEG,END,MAX,"",0)
 S HMPN=0 F  S HMPN=$O(^TMP("MDHSP",$J,HMPN)) Q:HMPN<1  S HMPX=$G(^(HMPN)) D
 . S RTN=$P(HMPX,U,3,4) ;Q:RTN="PRPRO^MDPS4"  ;skip non-CP items
 . S TIUN=+$P(HMPX,U,14) K HMPITM
 . I TIUN D EN1^HMPDTIU(TIUN,.HMPITM),XML^HMPDTIU(.HMPITM):$D(HMPITM)
 . S CONS=+$P(HMPX,U,13) D:CONS DOCLIST^GMRCGUIB(.HMPD,CONS)
 . S I=0 F  S I=$O(HMPD(50,I)) Q:I<1  D
 .. K HMPITM S DA=+HMPD(50,I) Q:DA=TIUN
 .. D EN1^HMPDTIU(DA,.HMPITM),XML^HMPDTIU(.HMPITM):$D(HMPITM)
 . Q:TIUN!$G(DA)                             ;done [got TIU note(s)]
 . Q:RTN="PR702^MDPS1"                       ;CP, but no TIU note yet
 . Q:RTN="PRPRO^MDPS4"                       ;non-CP procedure
 . ; find ID for pre-TIU report
 . S X=$P(HMPX,U,6),%DT="TX" D ^%DT S:Y>0 DATE=Y
 . S GBL=+$P(HMPX,U,2)_";"_$$ROOT(DFN,$P(HMPX,U,11),DATE)
 . I GBL D RPT1(DFN,GBL,.HMPITM),XML^HMPDTIU(.HMPITM):$D(HMPITM)
 K ^TMP("MDHSP",$J),^TMP("HMPTEXT",$J)
 Q
 ;
RPT1(DFN,ID,RPT) ; -- return report as a TIU document
 S DFN=+$G(DFN),ID=$G(ID) I '(DFN>0) D LOGDPT^HMPLOG(DFN) Q  ;DE4496 19 August 2016
 Q:'$L(ID)
 N HMPY,HMPFN,X
 S HMPFN=+$P(ID,"(",2)
 D MEDLKUP^MCARUTL3(.HMPY,HMPFN,+ID)
 S RPT("id")=ID,RPT("referenceDateTime")=$P(HMPY,U,6)
 S RPT("localTitle")=$P(HMPY,U,9),RPT("category")="CP"
 S RPT("documentClass")="CLINICAL PROCEDURES"
 S RPT("nationalTitle")="4696566^PROCEDURE REPORT"
 S RPT("nationalTitleService")="4696471^PROCEDURE"
 S RPT("nationalTitleType")="4696123^REPORT"
 S:$G(FILTER("loinc")) RPT("loinc")=$P(FILTER("loinc"),U)
 S X=$$GET1^DIQ(HMPFN,+ID_",",1506)
 S RPT("status")=$S($L(X):X,1:"COMPLETED")
 S X=+$$GET1^DIQ(HMPFN,+ID_",",701,"I")
 S:X RPT("clinician",1)=X_U_$P($G(^VA(200,X,0)),U)_"^A"
 S X=+$$GET1^DIQ(HMPFN,+ID_",",1503,"I")
 S:X RPT("clinician",2)=X_U_$P($G(^VA(200,X,0)),U)_"^S^"_$$GET1^DIQ(HMPFN,+ID_",",1505,"I")_U_$$SIG^HMPDTIU(X)
 ; RPT("encounter")=$$GET1^DIQ(HMPFN,+ID_",",900,"I")
 S RPT("facility")=$$FAC^HMPD
 S:$G(HMPTEXT) RPT("content")=$$TEXT(DFN,ID,$P(HMPY,U,9))
 Q
 ;
TEXT(DFN,ID,NAME) ; -- Get report text, return temp array name
 N MCARGDA,MCPRO,MDALL,I,X,Y ;de3944
 S MCARGDA=+$G(ID),MCPRO=NAME,MDALL=1 D PR690^MDPS1
 K ^TMP("HMPTEXT",$J,ID)
 S I=0 F  S I=$O(^TMP("MDPTXT",$J,MCARGDA,MCPRO,I)) Q:I<1  S X=$G(^(I,0)),^TMP("HMPTEXT",$J,ID,I)=X
 S Y=$NA(^TMP("HMPTEXT",$J,ID))
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(PROC) ; -- Return patient procedure as XML
 ;  as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,J,NAMES
 D ADD("<procedure>") S HMPTOTL=$G(HMPTOTL)+1
 S ATT="" F  S ATT=$O(PROC(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S NAMES=$S(ATT="document":"id^localTitle^nationalTitle^Z",1:"code^name^Z")
 . I $O(PROC(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(PROC(ATT,I)) Q:I<1  D
 ... S X=$G(PROC(ATT,I)),Y="<"_ATT_" "_$$LOOP
 ... S X=$G(PROC(ATT,I,"content")) I '$L(X) S Y=Y_"/>" D ADD(Y) Q
 ... S Y=Y_">" D ADD(Y)
 ... S Y="<content xml:space='preserve'>" D ADD(Y)
 ... S J=0 F  S J=$O(@X@(J)) Q:J<1  S Y=$$ESC^HMPD(@X@(J)) D ADD(Y)
 ... D ADD("</content>"),ADD("</"_ATT_">")
 .. D ADD("</"_ATT_"s>")
 . S X=$G(PROC(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^HMPD(X)_"' />" Q
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</procedure>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; Add a line @HMP@(n)=X
 S HMPI=$G(HMPI)+1
 S @HMP@(HMPI)=X
 Q
