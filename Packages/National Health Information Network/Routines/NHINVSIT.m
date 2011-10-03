NHINVSIT ;SLC/MKB -- Visit/Encounter extract
 ;;1.0;NHIN;**1**;Oct 25, 2010;Build 11
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^DIC(40.7                      557
 ; ^DIC(42                      10039
 ; ^SC                          10040
 ; ^SCE                          2065
 ; ^VA(200                      10060
 ; DIC                           2051
 ; DIQ                           2056
 ; ICDCODE                       3990
 ; ICPTCOD                       1995
 ; PXAPI,^TMP("PXKENC",$J   1894,1895
 ; VADPT                        10061
 ; XUAF4                         2171
 ;
 ; ------------ Get encounter(s) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's visits and appointments
 N NHICNT,NHITM,NHDT,NHLOC,NHDA
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 ;
 ; get one visit
 I $G(ID) D EN1(ID,.NHITM),XML(.NHITM) Q
 ;
 ; -- get all visits
 I END,END'["." S END=END_".24" ;assume end of day
 S NHICNT=0
 ;F  S IDX=$Q(@IDX,-1) Q:DFN'=$P(IDX,",",2)  Q:$P(IDX,",",3)<BEG  I $P(IDX,",",5)["P" D
 S NHDT=END F  S NHDT=$O(^AUPNVSIT("AET",DFN,NHDT),-1)  Q:NHDT<BEG  D  Q:NHICNT'<MAX
 . S NHLOC=0 F  S NHLOC=$O(^AUPNVSIT("AET",DFN,NHDT,NHLOC)) Q:NHLOC<1  D
 .. S NHDA=0 F  S NHDA=$O(^AUPNVSIT("AET",DFN,NHDT,NHLOC,"P",NHDA)) Q:NHDA<1  D
 ... K NHITM D EN1(NHDA,.NHITM) Q:'$D(NHITM)
 ... D XML(.NHITM) S NHICNT=NHICNT+1
 Q
 ;
ENAA(DFN,BEG,END,MAX,ID) ; -- find patient's visits and appointments [AA]
 N IDT,DA,NHICNT,NHITM
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,9999998),MAX=$G(MAX,999999)
 I $G(ID) D EN1(ID,.NHITM),XML(.NHITM) Q  ;one visit
 D IDT S NHICNT=0
 S IDT=BEG F  S IDT=$O(^AUPNVSIT("AA",DFN,IDT)) Q:IDT<1!(IDT>END)  D  Q:NHICNT'<MAX
 . S DA=0 F  S DA=$O(^AUPNVSIT("AA",DFN,IDT,DA)) Q:DA<1  D
 .. K NHITM D EN1(DA,.NHITM) Q:'$D(NHITM)
 .. D XML(.NHITM) S NHICNT=NHICNT+1
 Q
IDT ; -- invert BEG and END dates for visit format:
 ;  IDT=(9999999-$P(VDT,"."))_"."_$P(VDT,".",2)
 N X S X=BEG
 S BEG=(9999999-$P(END,"."))
 S END=(9999999-$P(X,"."))_".2359"
 Q
 ;
EN1(IEN,VST) ; -- return a visit in VST("attribute")=value
 N X0,X15,X,FAC,LOC,CATG,INPT,DA
 S IEN=+$G(IEN) Q:IEN<1  ;invalid ien
 D ENCEVENT^PXAPI(IEN)
 S X0=$G(^TMP("PXKENC",$J,IEN,"VST",IEN,0)),X15=$G(^(150))
 Q:$P(X15,U,3)'="P"  Q:$P(X0,U,7)="E"  ;want primary, not historical
 I $P(X0,U,7)="H" D ADM(IEN,+X0,.VST) Q
 S VST("id")=IEN,VST("dateTime")=+X0
 S FAC=+$P(X0,U,6),CATG=$P(X0,U,7),LOC=+$P(X0,U,22)
 S:FAC VST("facility")=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 S VST("serviceCategory")=CATG_U_$$CATG(CATG)
 S VST("visitString")=LOC_";"_+X0_";"_CATG
 S INPT=$P(X15,U,2) S:INPT="" INPT=$S("H^I^R^D"[CATG:1,1:0)
 S X=$$CPT(IEN) S:X VST("type")=$P($$CPT^ICPTCOD(X),U,2,3)
 I 'X S VST("type")=U_$S('INPT&LOC:$P($G(^SC(LOC,0)),U)_" VISIT",1:$$CATG(CATG))
 S VST("patientClass")=$S(INPT:"IMP",1:"AMB")
 S X=$P(X0,U,8) S:X VST("stopCode")=$$AMIS(X) I LOC D
 . N L0 S L0=$G(^SC(LOC,0))
 . I 'X S VST("stopCode")=$$AMIS($P(L0,U,7))
 . S VST("location")=$P(L0,U),VST("service")=$$SERV($P(L0,U,20))
 . S X=$P(L0,U,18) S:X VST("creditStopCode")=$$AMIS(X)
 . S:'FAC VST("facility")=$$FAC^NHINV(LOC)
 S VST("reason")=$$POV(IEN)
 ; provider(s)
 S DA=0 F  S DA=$O(^TMP("PXKENC",$J,IEN,"PRV",DA)) Q:DA<1  S X0=$G(^(DA,0)) D
 . S VST("provider",DA)=+X0_U_$P($G(^VA(200,+X0,0)),U)_$S($P(X0,U,4)="P":"^P^1",1:"^S^")
 ; note(s)
 D TIU(IEN)
 K ^TMP("PXKENC",$J,IEN)
 Q
 ;
TIU(VISIT) ; -- add notes to VST("document")
 N X,Y,I,NHIN,LT,NT,DA,CNT
 D FIND^DIC(8925,,.01,"QX",+$G(VISIT),,"V",,,"NHIN")
 S Y="",(I,CNT)=0
 F  S I=$O(NHIN("DILIST",1,I)) Q:I<1  D
 . S LT=$G(NHIN("DILIST","ID",I,.01)) Q:$P(LT," ")="Addendum"
 . S DA=$G(NHIN("DILIST",2,I))
 . S NT=$$GET1^DIQ(8925,+DA_",",".01:1501")
 . S CNT=CNT+1,VST("document",CNT)=DA_U_LT_U_NT
 Q
 ;
POV(VISIT) ; -- return the primary Purpose of Visit as ICD^ProviderNarrative
 N DA,Y,X,X0,ICD S Y=""
 S DA=0 F  S DA=$O(^TMP("PXKENC",$J,VISIT,"POV",DA)) Q:DA<1  S X0=$G(^(DA,0)) I $P(X0,U,12)="P" D  Q:$L(Y)
 . S X=+$P(X0,U,4),ICD=$$ICD(+X0)
 . S Y=ICD_U_$$GET1^DIQ(9999999.27,X_",",.01)
 Q Y
 ;
ICD(IEN) ; -- return code^description for ICD code, or "^" if error
 N X0,NHX,N,I,X,Y S IEN=+$G(IEN)
 S X0=$$ICDDX^ICDCODE(IEN) I X0<0 Q "^"
 S Y=$P(X0,U,2)_U_$P(X0,U,4)       ;ICD Code^Dx name
 S N=$$ICDD^ICDCODE($P(Y,U),"NHX") ;ICD Description
 I N>0,$L($G(NHX(1))) S $P(Y,U,2)=NHX(1)
 Q Y
 ;
CPT(VISIT) ; -- Return CPT code of encounter type
 N DA,Y,X,X0 S Y=""
 S DA=0 F  S DA=$O(^TMP("PXKENC",$J,VISIT,"CPT",DA)) Q:DA<1  S X0=$G(^(DA,0)) D  Q:$L(Y)
 . S X=$P(X0,U) I X?1"992"2N S Y=X Q
 Q Y
 ;
AMIS(X) ; -- return the AMIS code^name of Credit Stop X
 N Y S Y=""
 S X0=$G(^DIC(40.7,+$G(X),0)) S:$L(X0) Y=$P(X0,U,2)_U_$P(X0,U)
 Q Y
 ;
CATG(X) ; -- Return name of visit Service Category code X
 N Y S Y=""
 I X="A" S Y="AMBULATORY"
 I X="H" S Y="HOSPITALIZATION"
 I X="I" S Y="IN HOSPITAL"
 I X="C" S Y="CHART REVIEW"
 I X="T" S Y="TELECOMMUNICATIONS"
 I X="N" S Y="NOT FOUND"
 I X="S" S Y="DAY SURGERY"
 I X="O" S Y="OBSERVATION"
 I X="E" S Y="EVENT (HISTORICAL)"
 I X="R" S Y="NURSING HOME"
 I X="D" S Y="DAILY HOSPITALIZATION DATA"
 I X="X" S Y="ANCILLARY PACKAGE DAILY DATA"
 Q Y
 ;
SERV(FTS) ; -- Return #42.4 Service for a Facility Treating Specialty
 N Y S Y="",FTS=+$G(FTS)
 S Y=$$GET1^DIQ(45.7,FTS_",","1:3","E")
 Q Y
 ;
ADM(IEN,DATE,ADM) ; -- return an admission in ADM("attribute")=value
 N VAIP,VAERR,HLOC,ICD,I K ADM
 S IEN=+$G(IEN),DATE=+$G(DATE) Q:IEN<1  Q:DATE<1  ;invalid
 S VAIP("D")=DATE D IN5^VADPT Q:'$G(VAIP(1))  ;deleted
 S ADM("id")=IEN,ADM("patientClass")="IMP"
 ; ADM("admitType")=$P($G(VAIP(4)),U,2)
 S DATE=+$G(VAIP(3)),(ADM("dateTime"),ADM("arrivalDateTime"))=DATE,I=0
 S:$G(VAIP(7)) I=I+1,ADM("provider",I)=VAIP(7)_"^P^1" ;primary
 S:$G(VAIP(18)) I=I+1,ADM("provider",I)=VAIP(18)_"^A" ;attending
 S ADM("specialty")=$P($G(VAIP(8)),U,2)
 S X=$$SERV(+$G(VAIP(8))),ADM("service")=X
 S X=$$POV(IEN) S:X ADM("reason")=X_U_$G(VAIP(9)) I 'X D
 . S X=$$GET1^DIQ(405,+VAIP(1)_",",".16:79","I") ;Mvt>PTF>ICD ien
 . I 'X S ADM("reason")=U_U_$G(VAIP(9)) Q  ;Dx text
 . S ICD=$$ICD(X),ADM("reason")=ICD_U_$G(VAIP(9))
 S HLOC=+$G(^DIC(42,+$G(VAIP(5)),44))
 S:HLOC ADM("location")=$P($G(^SC(HLOC,0)),U)
 S ADM("facility")=$$FAC^NHINV(+HLOC),ADM("roomBed")=$P(VAIP(6),U,2)
 S ADM("serviceCategory")="H^HOSPITALIZATION"
 S X=$$CPT(IEN),ADM("type")=$S(X:$P($$CPT^ICPTCOD(X),U,2,3),1:U_$$CATG("H"))
 I $G(VAIP(17)) D
 . S ADM("departureDateTime")=+$G(VAIP(17,1))
 . ; ADM("disposition")=$G(VAIP(17,3)) ;Discharge Mvt Type
 S ADM("visitString")=HLOC_";"_DATE_";H"
 Q
 ;
ENC(IEN,ENC) ; -- return an encounter in ENC("attribute")=value
 N X0,DATE,HLOC,TYPE,STS,X,Y K ENC
 S IEN=+$G(IEN) Q:IEN<1  ;invalid ien
 S ENC("id")="E"_IEN,X0=$G(^SCE(IEN,0))
 S DATE=+X0,ENC("dateTime")=DATE
 S HLOC=+$P(X0,U,4) I HLOC D
 . S HLOC=HLOC_U_$P($G(^SC(HLOC,0)),U)
 . S ENC("location")=$P(HLOC,U,2)
 . S X=$$GET1^DIQ(44,+HLOC_",",9.5,"I")
 . I X S ENC("service")=$$SERV(X)
 S ENC("facility")=$$FAC^NHINV(+HLOC)
 S STS=$$GET1^DIQ(409.68,IEN_",",.12,"E")
 S X=$S(STS?1"INP".E:"IMP",1:"AMB"),ENC("patientClass")=X,TYPE=$E(X)
 S ENC("type")=U_$S(HLOC:$P(HLOC,U,2)_" VISIT",1:$$CATG(TYPE))
 S ENC("serviceCategory")=TYPE_U_$$CATG(TYPE)
 S ENC("visitString")=+HLOC_";"_DATE_";"_TYPE
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(VISIT) ; -- Return patient visit as XML
 N ATT,X,Y,NAMES
 D ADD("<visit>") S NHINTOTL=$G(NHINTOTL)+1
 S ATT="" F  S ATT=$O(VISIT(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(VISIT(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(VISIT(ATT,I)) Q:I<1  D
 ... S X=$G(VISIT(ATT,I)),NAMES=""
 ... I ATT="document" S NAMES="id^localTitle^nationalTitle^Z"
 ... I ATT="provider" S NAMES="code^name^role^primary^Z"
 ... S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(VISIT(ATT)),Y="" Q:'$L(X)
 . S NAMES="code^name^"_$S(ATT="reason":"narrative^",1:"")_"Z"
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^NHINV(X)_"' />" Q
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</visit>")
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
