HMPDSDAM ;SLC/MKB,ASMR/RRB - Appointment extract;8/2/11  15:29
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DGS(41.1                     3796
 ; ^DIC(42                      10039
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIQ                           2056
 ; SDAMA301                      4433
 Q
 ; ------------ Get appointment(s) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's [future] appointments
 N HMPX,HMPNUM,HMPDT,HMPCNT,HMPITM,HMPA,X
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,DT),END=$G(END,4141015),MAX=$G(MAX,9999)
 S HMPX(1)=BEG_";"_END,HMPX(4)=DFN,HMPX("FLDS")="1;2;3;10;13",HMPX("SORT")="P"
 ;
 ; get one appt
 I $L($G(ID)) D  Q
 . S (BEG,END)=$P(ID,";",2),HMPX(1)=BEG_";"_END,HMPX(2)=$P(ID,";",3)
 . S HMPNUM=$$SDAPI^SDAMA301(.HMPX) Q:HMPNUM<1
 . D EN1(BEG,.HMPITM),XML(.HMPITM)
 . K ^TMP($J,"SDAMA301",DFN)
 ;
 ; get all [future] appointments
 S HMPX(3)="R;I;NS;NSR;NT" ;no cancelled appt's
 S HMPNUM=$$SDAPI^SDAMA301(.HMPX),(HMPDT,HMPCNT)=0
 F  S HMPDT=$O(^TMP($J,"SDAMA301",DFN,HMPDT)) Q:HMPDT<1  D  Q:HMPCNT'<MAX
 . S X=$P($G(^TMP($J,"SDAMA301",DFN,HMPDT)),U,3)
 . I HMPDT<DT,$P(X,";")'["NS" Q   ;no prior kept appt's
 . K HMPITM D EN1(HMPDT,.HMPITM) Q:'$D(HMPITM)
 . D XML(.HMPITM) S HMPCNT=HMPCNT+1
 K ^TMP($J,"SDAMA301",DFN)
 ;
 ; get scheduled admissions
 S HMPA=0 F  S HMPA=$O(^DGS(41.1,"B",DFN,HMPA)) Q:HMPA<1  D  Q:HMPCNT'<MAX  ;ICR 3796 DE2818 ASF 11/20/15
 . S HMPX=$G(^DGS(41.1,HMPA,0))
 . Q:$P(HMPX,U,13)  Q:$P(HMPX,U,17)  ;cancelled or admitted
 . S X=$P(HMPX,U,2) Q:X<BEG!(X>END)  ;out of date range
 . K HMPITM D DGS(HMPA,.HMPITM) Q:'$D(HMPITM)
 . D XML(.HMPITM) S HMPCNT=HMPCNT+1
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
 . S APPT("clinicStop")=$$AMIS^HMPDVSIT(+$P(X,U,13))
 . S SV=$$GET1^DIQ(44,+HLOC_",",9.5,"I")
 . I SV S APPT("service")=$$SERV(SV)
 . ;find default provider
 . S PRV=+$$GET1^DIQ(44,+HLOC_",",16,"I") I 'PRV D
 .. N HMPP,I,FIRST
 .. D GETS^DIQ(44,+HLOC_",","2600*","I","HMPP")
 .. S FIRST=$O(HMPP(44.1,"")),I=""
 .. F  S I=$O(HMPP(44.1,I)) Q:I=""  I $G(HMPP(44.1,I,.02,"I")) S PRV=$G(HMPP(44.1,I,.01,"I")) Q
 .. I 'PRV,FIRST S PRV=$G(HMPP(44.1,FIRST,.01,"I"))
 . I PRV S APPT("provider")=PRV_U_$P($G(^VA(200,PRV,0)),U) Q  ;ICR 10060 DEE2818 ASF 11/20/15
 S APPT("facility")=$$FAC^HMPD(+HLOC)
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
 S X0=$G(^DGS(41.1,+$G(IFN),0)) Q:X0=""  ;deleted ICR 3796 DE2818 ASF 11/20/15
 S DATE=+$P(X0,U,2),HLOC=+$G(^DIC(42,+$P(X0,U,8),44)) ;ICR 10039 DE2818 ASF 11/20/15
 S ADM("id")="H;"_DATE,ADM("dateTime")=DATE I HLOC D
 . S ADM("id")=ADM("id")_";"_HLOC,ADM("visitString")=HLOC_";"_DATE_";H"
 . S ADM("location")=HLOC_U_$P($G(^SC(HLOC,0)),U) ;ICR 10040 DE2818 ASF 11/20/15
 . S X=$$GET1^DIQ(44,HLOC_",",8,"I"),ADM("clinicStop")=$$AMIS^HMPDVSIT(X)
 . S SV=$$GET1^DIQ(44,HLOC_",",9.5,"I")
 . I SV S ADM("service")=$$SERV(SV)
 S ADM("facility")=$$FAC^HMPD(HLOC)
 S X=$P(X0,U,5) I X S ADM("provider")=X_U_$P($G(^VA(200,X,0)),U) ;ICR 10060 DEE2818 ASF 11/20/15
 S ADM("patientClass")="IMP",ADM("serviceCategory")="H^HOSPITALIZATION"
 S ADM("apptStatus")=$S($P(X0,U,17):"ADMITTED",$P(X0,U,13):"CANCELLED",1:"SCHEDULED")
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(APPT) ; -- Return appointment as XML
 N ATT,X,Y,NAMES
 D ADD("<appointment>") S HMPTOTL=$G(HMPTOTL)+1
 S ATT="" F  S ATT=$O(APPT(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S X=$G(APPT(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^HMPD(X)_"' />" Q
 . I $L(X)>1 S NAMES="code^name^Z",Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</appointment>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; -- Add a line @HMP@(n)=X
 S HMPI=$G(HMPI)+1
 S @HMP@(HMPI)=X
 Q
