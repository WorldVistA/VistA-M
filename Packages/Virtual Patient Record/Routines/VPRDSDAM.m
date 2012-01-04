VPRDSDAM ;SLC/MKB -- Appointment extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;;Sep 01, 2011;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DIQ                           2056
 ; SDAMA301                      4433
 ; VADPT                        10061
 ;
 ; ------------ Get appointment(s) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's [future] appointments
 N VPRX,VPRNUM,VPRDT,VPRCNT,VPRITM,X
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,DT),END=$G(END,4141015),MAX=$G(MAX,9999)
 S VPRX(1)=BEG_";"_END,VPRX(4)=DFN,VPRX("FLDS")="1;2;3;10",VPRX("SORT")="P"
 ;
 ; get one appt
 I $L($G(ID)) D  Q
 . S (BEG,END)=$P(ID,";",2),VPRX(1)=BEG_";"_END,VPRX(2)=$P(ID,";",3)
 . S VPRNUM=$$SDAPI^SDAMA301(.VPRX) Q:VPRNUM<1
 . D EN1(BEG,.VPRITM),XML(.VPRITM)
 . K ^TMP($J,"SDAMA301",DFN)
 ;
 ; get all [future] appointments
 S VPRX(3)="R;I;NS;NSR;NT" ;no cancelled appt's
 S VPRNUM=$$SDAPI^SDAMA301(.VPRX),(VPRDT,VPRCNT)=0
 F  S VPRDT=$O(^TMP($J,"SDAMA301",DFN,VPRDT)) Q:VPRDT<1  D  Q:VPRCNT'<MAX
 . S X=$P($G(^TMP($J,"SDAMA301",DFN,VPRDT)),U,3)
 . I VPRDT<DT,$P(X,";")'["NS" Q   ;no prior kept appt's
 . K VPRITM D EN1(VPRDT,.VPRITM) Q:'$D(VPRITM)
 . D XML(.VPRITM) S VPRCNT=VPRCNT+1
 K ^TMP($J,"SDAMA301",DFN)
 Q
 ;
EN1(DATE,APPT) ; -- return an appointment in APPT("attribute")=value
 ;  Expects ^TMP($J,"SDAMA301",DFN,DATE)
 N X,HLOC,STS,CLS,SV,CSC,CSN K APPT
 S X=$G(^TMP($J,"SDAMA301",DFN,DATE))
 S DATE=+$G(DATE),HLOC=$P(X,U,2),STS=$P(X,U,3),CLS=$S($E(STS)="I":"I",1:"O")
 S APPT("id")="A;"_DATE_";"_+HLOC,APPT("dateTime")=DATE I HLOC D
 . S APPT("location")=$P(HLOC,";",2)
 . S CSC=$$GET1^DIQ(44,+HLOC_",",8,"I")
 . S CSN=$$GET1^DIQ(44,+HLOC_",",8,"E")
 . S APPT("clinicStop")=CSC_"^"_CSN
 . ;S APPT("type")=U_$P(HLOC,";",2)_" APPOINTMENT"
 . S SV=$$GET1^DIQ(44,+HLOC_",",9.5,"I")
 . I SV S APPT("service")=$$SERV(SV)
 S APPT("facility")=$$FAC^VPRD(+HLOC)
 S APPT("type")=$TR($P(X,U,10),";","^")
 S APPT("patientClass")=$S(CLS="I":"IMP",1:"AMB")
 S APPT("serviceCategory")=$S(CLS="I":"I^INPATIENT VISIT",1:"A^AMBULATORY")
 S APPT("apptStatus")=$P(STS,";",2)
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
 D ADD("<appointment>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(APPT(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S X=$G(APPT(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 S NAMES="code^name^Z",Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</appointment>")
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
