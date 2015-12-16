VPRDSDAM ;SLC/MKB -- Appointment extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DGS(41.1                     3796
 ; ^DIC(42                      10039
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIQ                           2056
 ; SDAMA301                      4433
 ;
 ; ------------ Get appointment(s) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's [future] appointments
 N VPRX,VPRNUM,VPRDT,VPRCNT,VPRITM,VPRA,X
 S DFN=+$G(DFN) Q:DFN<1
 I $G(BEG)<2000000 S BEG=DT
 S END=$G(END,4141015),MAX=$G(MAX,9999)
 S VPRX(1)=BEG_";"_END,VPRX(4)=DFN,VPRX("FLDS")="1;2;3;10;13",VPRX("SORT")="P"
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
 ;
 ; get scheduled admissions
 S VPRA=0 F  S VPRA=$O(^DGS(41.1,"B",DFN,VPRA)) Q:VPRA<1  D  Q:VPRCNT'<MAX
 . S VPRX=$G(^DGS(41.1,VPRA,0))
 . Q:$P(VPRX,U,13)  Q:$P(VPRX,U,17)  ;cancelled or admitted
 . S X=$P(VPRX,U,2) Q:X<BEG!(X>END)  ;out of date range
 . K VPRITM D DGS(VPRA,.VPRITM) Q:'$D(VPRITM)
 . D XML(.VPRITM) S VPRCNT=VPRCNT+1
 Q
 ;
EN1(DATE,APPT) ; -- return an appointment in APPT("attribute")=value
 ;  Expects ^TMP($J,"SDAMA301",DFN,DATE)
 N X,HLOC,STS,CLS,SV,PRV K APPT
 S X=$G(^TMP($J,"SDAMA301",DFN,DATE))
 S DATE=+$G(DATE),HLOC=$P(X,U,2),APPT("type")=$TR($P(X,U,10),";","^")
 S STS=$P(X,U,3),CLS=$S($E(STS)="I":"I",1:"O")
 S APPT("id")="A;"_DATE_";"_+HLOC,APPT("dateTime")=DATE I HLOC D
 . S APPT("location")=$P(HLOC,";",2)
 . S APPT("clinicStop")=$$AMIS^VPRDVSIT(+$P(X,U,13))
 . S SV=$$GET1^DIQ(44,+HLOC_",",9.5,"I")
 . I SV S APPT("service")=$$SERV(SV)
 . I 'SV S APPT("service")=$$GET1^DIQ(44,+HLOC_",",9)
 . ;find default provider
 . S PRV=+$$GET1^DIQ(44,+HLOC_",",16,"I") I 'PRV D
 .. N VPRP,I,FIRST
 .. D GETS^DIQ(44,+HLOC_",","2600*","I","VPRP")
 .. S FIRST=$O(VPRP(44.1,"")),I=""
 .. F  S I=$O(VPRP(44.1,I)) Q:I=""  I $G(VPRP(44.1,I,.02,"I")) S PRV=$G(VPRP(44.1,I,.01,"I")) Q
 .. I 'PRV,FIRST S PRV=$G(VPRP(44.1,FIRST,.01,"I"))
 . I PRV S APPT("provider")=PRV_U_$P($G(^VA(200,PRV,0)),U) Q
 S APPT("facility")=$$FAC^VPRD(+HLOC)
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
DGS(IFN,ADM) ; -- return a scheduled admission in ADM("attribute")=value
 N X0,DATE,HLOC,SV,X K ADM
 S X0=$G(^DGS(41.1,+$G(IFN),0)) Q:X0=""  ;deleted
 S DATE=+$P(X0,U,2),HLOC=+$G(^DIC(42,+$P(X0,U,8),44))
 S ADM("id")="H;"_DATE,ADM("dateTime")=DATE I HLOC D
 . S ADM("id")=ADM("id")_";"_HLOC,ADM("visitString")=HLOC_";"_DATE_";H"
 . S ADM("location")=HLOC_U_$P($G(^SC(HLOC,0)),U)
 . S X=$$GET1^DIQ(44,HLOC_",",8,"I"),ADM("clinicStop")=$$AMIS^VPRDVSIT(X)
 . S SV=$$GET1^DIQ(44,HLOC_",",9.5,"I")
 . I SV S ADM("service")=$$SERV(SV)
 . I 'SV S ADM("service")=$$GET1^DIQ(44,+HLOC_",",9)
 S ADM("facility")=$$FAC^VPRD(HLOC)
 S X=$P(X0,U,5) I X S ADM("provider")=X_U_$P($G(^VA(200,X,0)),U)
 S ADM("patientClass")="IMP",ADM("serviceCategory")="H^HOSPITALIZATION"
 S ADM("apptStatus")=$S($P(X0,U,17):"ADMITTED",$P(X0,U,13):"CANCELLED",1:"SCHEDULED")
 Q
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
