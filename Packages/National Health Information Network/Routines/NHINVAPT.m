NHINVAPT ;SLC/MKB -- Appointment extract
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DIQ                           2056
 ; SDAMA201                      3859
 ; VADPT                        10061
 ;
 ; ------------ Get appointment(s) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's appointments
 N NHICNT,NHITOT,NHI,X1,X2,X3,X12,NHITM
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,DT),END=$G(END,9999998),MAX=$G(MAX,999999)
 ;
 ; get one appt
 I $L($G(ID)) D  Q
 . S (BEG,END)=$P(ID,";",2)
 . D GETAPPT^SDAMA201(DFN,"1;2;3;12","",BEG,END,.NHITOT)
 . I NHITOT>0 F NHI=1:1:NHITOT D
 .. S X1=+$G(^TMP($J,"SDAMA201","GETAPPT",NHI,1)),X2=$G(^(2)),X3=$G(^(3)),X12=$G(^(12))
 .. Q:+X2'=$P(ID,";",3)  ;not same location
 .. D EN1(X1,X2,X3,X12,.NHITM),XML(.NHITM)
 . K ^TMP($J,"SDAMA201","GETAPPT")
 ;
 ; get all [future] appointments
 D GETAPPT^SDAMA201(DFN,"1;2;3;12","",BEG,END,.NHITOT)
 I NHITOT>0 S NHICNT=0 F NHI=1:1:NHITOT D  Q:NHICNT'<MAX
 . S X1=+$G(^TMP($J,"SDAMA201","GETAPPT",NHI,1)),X2=+$G(^(2)),X3=$G(^(3))
 . ;no cancelled, or prior kept appointments [ORWCV]
 . Q:X3="C"  I X1<DT,(X3="R"!(X3="NT")) Q
 . K NHITM D EN1(X1,X2,X3,X12,.NHITM) Q:'$D(NHITM)
 . D XML(.NHITM) S NHICNT=NHICNT+1
 K ^TMP($J,"SDAMA201","GETAPPT")
 Q
 ;
EN1(DATE,HLOC,STS,CLS,APPT) ; -- return an appointment in APPT("attribute")=value
 N X,VIEN K APPT
 S DATE=+$G(DATE),HLOC=$G(HLOC),STS=$G(STS),CLS=$G(CLS)
 S APPT("id")="A;"_DATE_";"_+HLOC,APPT("dateTime")=DATE I HLOC D
 . S APPT("location")=$P(HLOC,U,2)
 . S APPT("type")=U_$P(HLOC,U,2)_" APPOINTMENT"
 . S X=$$GET1^DIQ(44,+HLOC_",",9.5,"I")
 . I X S APPT("service")=$$SERV(X)
 S APPT("facility")=$$FAC^NHINV(+HLOC)
 S APPT("patientClass")=$S(CLS="I":"IMP",1:"AMB")
 S APPT("serviceCategory")=$S(CLS="I":"I^INPATIENT VISIT",1:"A^AMBULATORY")
 S X=$S(STS="N":"NO-SHOW",STS="C":"CANCELLED",STS="R":"SCHEDULED/KEPT",STS="NT":"NO ACTION TAKEN",1:"")
 S:$L(X) APPT("apptStatus")=X
 S APPT("visitString")=+HLOC_";"_DATE_";A"
 Q
 ;
SERV(FTS) ; -- Return #42.4 Service for a Facility Treating Specialty
 N Y S Y="",FTS=+$G(FTS)
 S Y=$$GET1^DIQ(45.7,FTS_",","1:3","E")
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(APPT) ; -- Return appointment as XML
 N ATT,X,Y,NAMES
 D ADD("<appointment>") S NHINTOTL=$G(NHINTOTL)+1
 S ATT="" F  S ATT=$O(APPT(ATT)) Q:ATT=""  D
 . S X=$G(APPT(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^NHINV(X)_"' />"
 . I $L(X)>1 S NAMES="code^name^Z",Y="<"_ATT_" "_$$LOOP_"/>"
 . D:$L(Y) ADD(Y)
 D ADD("</appointment>")
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
