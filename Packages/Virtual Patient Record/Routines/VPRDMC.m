VPRDMC ;SLC/MKB -- Clinical Procedures (Medicine) ;3/14/12  09:03
 ;;1.0;VIRTUAL PATIENT RECORD;**1,2,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; %DT                          10003
 ; DILFD                         2055
 ; DIQ                           2056
 ; GMRCGUIB                      2980
 ; ICPTCOD                       1995
 ; MCARUTL2                      3279
 ; MCARUTL3                      3280
 ; MDPS1,^TMP("MDHSP"/"MDPTXT"   4230
 ; TIULQ                         2693
 ; TIUSRVLO                      2834
 ; XUAF4                         2171
 ;
 ; ------------ Get procedures from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's procedures
 N VPRITM,RES,VPRN,VPRX,RTN,DATE,CONS,TIUN,X0,DA,GBL,X,Y,%DT,VPRT,LOC
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S DFN=+$G(DFN) Q:DFN<1
 ;
 ; get one procedure
 I $G(ID) D  ;reset dates for MDPS1
 . N VPRMC,IEN,FILE
 . S IEN=+ID,FILE=+$P(ID,"(",2) Q:FILE=702
 . D MEDLKUP^MCARUTL3(.VPRMC,FILE,IEN)
 . S X=$P(VPRMC,U,6) S:X (BEG,END)=X
 ;
 ; get all procedures
 K ^TMP("MDHSP",$J) S RES=""
 D EN1^MDPS1(RES,DFN,BEG,END,MAX,"",0)
 S VPRN=0 F  S VPRN=$O(^TMP("MDHSP",$J,VPRN)) Q:VPRN<1  S VPRX=$G(^(VPRN)) D
 . I $G(ID),ID'=+$P(VPRX,U,2) Q              ;update one procedure
 . S RTN=$P(VPRX,U,3,4) Q:RTN="PRPRO^MDPS4"  ;skip non-CP items
 . S X=$P(VPRX,U,6),%DT="STX" D ^%DT S:Y>0 DATE=Y
 . S GBL=+$P(VPRX,U,2)_";"_$S(RTN="PR702^MDPS1":"MDD(702,",1:$$ROOT(DFN,$P(VPRX,U,11),DATE))
 . Q:'GBL  I $G(ID),ID'=GBL Q                ;unknown, or not requested
 . ;
 . S CONS=+$P(VPRX,U,13) D:CONS DOCLIST^GMRCGUIB(.VPRD,CONS) S X0=$G(VPRD(0)) ;=^GMR(123,ID,0)
 . S TIUN=+$P(VPRX,U,14) S:TIUN TIUN=TIUN_U_$$RESOLVE^TIUSRVLO(TIUN)
A . ;
 . K VPRITM S VPRITM("id")=GBL,VPRITM("name")=$P(VPRX,U)
 . S VPRITM("dateTime")=DATE,VPRITM("category")="CP"
 . S X=$P(VPRX,U,7) S:$L(X) VPRITM("interpretation")=X
 . I CONS,X0 D
 .. N VPRJ S VPRITM("consult")=CONS
 .. S VPRITM("requested")=+X0,VPRITM("order")=+$P(X0,U,3)
 .. S VPRITM("status")=$$EXTERNAL^DILFD(123,8,,$P(X0,U,12))
 .. S VPRJ=0 F  S VPRJ=$O(VPRD(50,VPRJ)) Q:VPRJ<1  S X=+$G(VPRD(50,VPRJ)) D
 ... N Y S Y=$$INFO^VPRDTIU(+X) Q:Y<1  ;draft or retracted
 ... S VPRITM("document",X)=Y  ;ien^local^national title^VUID
 ... S:$G(VPRTEXT) VPRITM("document",X,"content")=$$TEXT^VPRDTIU(X)
 ... S:'TIUN TIUN=X ;get supporting fields
B . ;
 . I TIUN D
 .. S X=$P(TIUN,U,5) S:X VPRITM("provider")=+X_U_$P(X,";",3)_U_$$PROVSPC^VPRD(+X)
 .. S:$P(TIUN,U,11) VPRITM("hasImages")=1
 .. K VPRT D EXTRACT^TIULQ(+TIUN,"VPRT",,".03;.05;1211",,,"I")
 .. S VPRITM("encounter")=+$G(VPRT(+TIUN,.03,"I"))
 .. S LOC=+$G(VPRT(+TIUN,1211,"I")) I LOC S LOC=LOC_U_$P($G(^SC(LOC,0)),U)
 .. E  S X=$P(TIUN,U,6) S:$L(X) LOC=+$O(^SC("B",X,0))_U_X
 .. S:LOC VPRITM("location")=LOC,VPRITM("facility")=$$FAC^VPRD(+LOC)
 .. I '$D(VPRITM("status")) S X=+$G(VPRT(+TIUN,.05,"I")),VPRITM("status")=$S(X<6:"PARTIAL RESULTS",1:"COMPLETE")
 .. I '$G(VPRITM("document",+TIUN)) D
 ... N Y S Y=$$INFO^VPRDTIU(+TIUN) Q:Y<1  ;draft or retracted
 ... S VPRITM("document",+TIUN)=Y  ;ien^local^national title^VUID
 ... S:$G(VPRTEXT) VPRITM("document",+TIUN,"content")=$$TEXT^VPRDTIU(+TIUN)
C . ;
 . ; if no consult or note/visit ...
 . I TIUN<1 D
 .. S VPRITM("document",1)=GBL_U_$P(VPRX,U)_"^PROCEDURE REPORT^4696566"
 .. S:$G(VPRTEXT) VPRITM("document",1,"content")=$$TEXT(DFN,GBL,$P(VPRX,U,11))
 . I '$D(VPRITM("facility")) S X=$P(X0,U,21),VPRITM("facility")=$S(X:$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U),1:$$FAC^VPRD)
 . I '$D(VPRITM("status")) S VPRITM("status")="COMPLETE"
 . ;I DA D  ;get CPT code from #697.2
 . ;. K VPRT D GETS^DIQ(697.2,DA_",","1000*",,"VPRT")
 . ;. N IENS S IENS=$O(VPRT(697.21,"")) Q:IENS=""
 . ;. S X=VPRT(697.21,IENS,.01),VPRITM("type")=$$CPT(X)
 . ;
 . D XML(.VPRITM)
ENQ ;
 K ^TMP("MDHSP",$J),^TMP("VPRTEXT",$J)
 Q
 ;
ROOT(DFN,NAME,DATE) ; -- return vptr ID for procedure instance
 N VPRMC,Y
 D SUB^MCARUTL2(.VPRMC,DFN,NAME,DATE,DATE)
 S Y=$S(+$G(VPRMC):$P($G(VPRMC(VPRMC)),U,4)_",",1:"")
 Q Y
 ;
CPT(IEN) ; -- return code^description for CPT code, or "^" if error
 N X0,VPRX,N,I,X,Y S IEN=+$G(IEN)
 S X0=$$CPT^ICPTCOD(IEN) I X0<0 Q "^"
 S Y=$P(X0,U,2,3)                   ;CPT Code^Short Name
 S N=$$CPTD^ICPTCOD($P(Y,U),"VPRX") ;CPT Description
 I N>0,$L($G(VPRX(1))) D
 . S X=$G(VPRX(1)),I=1
 . F  S I=$O(VPRX(I)) Q:I<1  Q:VPRX(I)=" "  S X=X_" "_VPRX(I)
 . S $P(Y,U,2)=X
 Q Y
 ;
 ; ------------ Get report(s) [via VPRDTIU] ------------
 ;
RPTS(DFN,BEG,END,MAX) ; -- find patient's medicine reports
 N VPRITM,VPRN,VPRX,RTN,TIUN,CONS,VPRD,I,DA,X,Y,%DT,DATE,GBL,RES
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999),RES=""
 K ^TMP("MDHSP",$J) D EN1^MDPS1(RES,DFN,BEG,END,MAX,"",0)
 S VPRN=0 F  S VPRN=$O(^TMP("MDHSP",$J,VPRN)) Q:VPRN<1  S VPRX=$G(^(VPRN)) D
 . S RTN=$P(VPRX,U,3,4) ;Q:RTN="PRPRO^MDPS4"  ;skip non-CP items
 . S TIUN=+$P(VPRX,U,14) K VPRITM
 . I TIUN,$$INFO^VPRDTIU(TIUN)>0 D EN1^VPRDTIU(TIUN,.VPRITM),XML^VPRDTIU(.VPRITM):$D(VPRITM)
 . S CONS=+$P(VPRX,U,13) D:CONS DOCLIST^GMRCGUIB(.VPRD,CONS)
 . S I=0 F  S I=$O(VPRD(50,I)) Q:I<1  D
 .. K VPRITM S DA=+VPRD(50,I) Q:DA=TIUN  Q:$$INFO^VPRDTIU(DA)<1
 .. D EN1^VPRDTIU(DA,.VPRITM),XML^VPRDTIU(.VPRITM):$D(VPRITM)
 . Q:TIUN!$G(DA)                             ;done [got TIU note(s)]
 . Q:RTN="PR702^MDPS1"                       ;CP, but no TIU note yet
 . Q:RTN="PRPRO^MDPS4"                       ;non-CP procedure
 . ; find ID for pre-TIU report
 . S X=$P(VPRX,U,6),%DT="TX" D ^%DT S:Y>0 DATE=Y
 . S GBL=+$P(VPRX,U,2)_";"_$$ROOT(DFN,$P(VPRX,U,11),DATE)
 . I GBL D RPT1(DFN,GBL,.VPRITM),XML^VPRDTIU(.VPRITM):$D(VPRITM)
 K ^TMP("MDHSP",$J),^TMP("VPRTEXT",$J)
 Q
 ;
RPT1(DFN,ID,RPT) ; -- return report as a TIU document
 S DFN=+$G(DFN),ID=$G(ID) Q:DFN<1  Q:'$L(ID)
 N VPRY,VPRFN,X
 S VPRFN=+$P(ID,"(",2)
 D MEDLKUP^MCARUTL3(.VPRY,VPRFN,+ID)
 S RPT("id")=ID,RPT("referenceDateTime")=$P(VPRY,U,6)
 S RPT("localTitle")=$P(VPRY,U,9),RPT("category")="CP"
 S RPT("documentClass")="CLINICAL PROCEDURES"
 S RPT("nationalTitle")="4696566^PROCEDURE REPORT"
 S RPT("nationalTitleService")="4696471^PROCEDURE"
 S RPT("nationalTitleType")="4696123^REPORT"
 S:$G(FILTER("loinc")) RPT("loinc")=$P(FILTER("loinc"),U)
 S X=$$GET1^DIQ(VPRFN,+ID_",",1506)
 S RPT("status")=$S($L(X):X,1:"COMPLETED")
 S X=+$$GET1^DIQ(VPRFN,+ID_",",701,"I")
 S:X RPT("clinician",1)=X_U_$P($G(^VA(200,X,0)),U)_"^A^^^"_$$PROVSPC^VPRD(X)
 S X=+$$GET1^DIQ(VPRFN,+ID_",",1503,"I")
 S:X RPT("clinician",2)=X_U_$P($G(^VA(200,X,0)),U)_"^S^"_$$GET1^DIQ(VPRFN,+ID_",",1505,"I")_U_$$SIG^VPRDTIU(X)_U_$$PROVSPC^VPRD(X)
 ; RPT("encounter")=$$GET1^DIQ(VPRFN,+ID_",",900,"I")
 S RPT("facility")=$$FAC^VPRD
 S:$G(VPRTEXT) RPT("content")=$$TEXT(DFN,ID,$P(VPRY,U,9))
 Q
 ;
TEXT(DFN,ID,NAME) ; -- Get report text, return temp array name
 N MCARGDA,MCPRO,MDALL,I,X,Y
 S MCARGDA=+$G(ID),MCPRO=NAME,MDALL=1 D PR690^MDPS1
 K ^TMP("VPRTEXT",$J,ID)
 S I=0 F  S I=$O(^TMP("MDPTXT",$J,MCARGDA,MCPRO,I)) Q:I<1  S X=$G(^(I,0)),^TMP("VPRTEXT",$J,ID,I)=X
 S Y=$NA(^TMP("VPRTEXT",$J,ID))
 K ^TMP("MDPTXT",$J)
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(PROC) ; -- Return patient procedure as XML
 ;  as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,J,NAMES
 D ADD("<procedure>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(PROC(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S NAMES=$S(ATT="document":"id^localTitle^nationalTitle^vuid",ATT="provider":"code^name^"_$$PROVTAGS^VPRD,1:"code^name")_"^Z"
 . I $O(PROC(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(PROC(ATT,I)) Q:I<1  D
 ... S X=$G(PROC(ATT,I)),Y="<"_ATT_" "_$$LOOP
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
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
