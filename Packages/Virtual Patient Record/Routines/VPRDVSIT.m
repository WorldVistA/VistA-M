VPRDVSIT ;SLC/MKB -- Visit/Encounter extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,2,4,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^DIC(40.7                      557
 ; ^DIC(42                      10039
 ; ^DIC(45.7                     1154
 ; ^DPT(                        10035
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DGPTFAPI                      3157
 ; DIC                           2051
 ; DILFD                         2055
 ; DIQ                           2056
 ; ICDEX                         5747
 ; ICPTCOD                       1995
 ; PXAPI,^TMP("PXKENC",$J        1894
 ; SDOE                          2546
 ; VADPT                        10061
 ; VADPT2                         325
 ; XUAF4                         2171
 ;
 ; ------------ Get encounter(s) from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's visits and appointments
 N VPRCNT,VPRITM,VPRDT,VPRLOC,VPRDA
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 ;
 ; get one visit
 I $G(ID) D EN1(ID,.VPRITM),XML(.VPRITM) G ENQ
 ;
 ; -- get all visits
 I END,END'["." S END=END_".24" ;assume end of day
 S VPRCNT=0
 ;F  S IDX=$Q(@IDX,-1) Q:DFN'=$P(IDX,",",2)  Q:$P(IDX,",",3)<BEG  I $P(IDX,",",5)["P" D
 S VPRDT=END F  S VPRDT=$O(^AUPNVSIT("AET",DFN,VPRDT),-1)  Q:VPRDT<BEG  D  Q:VPRCNT'<MAX
 . S VPRLOC=0 F  S VPRLOC=$O(^AUPNVSIT("AET",DFN,VPRDT,VPRLOC)) Q:VPRLOC<1  D
 .. S VPRDA=0 F  S VPRDA=$O(^AUPNVSIT("AET",DFN,VPRDT,VPRLOC,"P",VPRDA)) Q:VPRDA<1  D
 ... K VPRITM D EN1(VPRDA,.VPRITM) Q:'$D(VPRITM)
 ... D XML(.VPRITM) S VPRCNT=VPRCNT+1
ENQ ; end
 K ^TMP("VPRTEXT",$J)
 Q
 ;
ENAA(DFN,BEG,END,MAX,ID) ; -- find patient's visits and appointments [AA]
 N IDT,DA,VPRCNT,VPRITM
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 I $G(ID) D EN1(ID,.VPRITM),XML(.VPRITM) Q  ;one visit
 D IDT S VPRCNT=0
 S IDT=BEG F  S IDT=$O(^AUPNVSIT("AA",DFN,IDT)) Q:IDT<1!(IDT>END)  D  Q:VPRCNT'<MAX
 . S DA=0 F  S DA=$O(^AUPNVSIT("AA",DFN,IDT,DA)) Q:DA<1  D
 .. K VPRITM D EN1(DA,.VPRITM) Q:'$D(VPRITM)
 .. D XML(.VPRITM) S VPRCNT=VPRCNT+1
 Q
IDT ; -- invert BEG and END dates for visit format:
 ;  IDT=(9999999-$P(VDT,"."))_"."_$P(VDT,".",2)
 N X S X=BEG
 S BEG=(9999999-$P(END,"."))
 S END=(9999999-$P(X,"."))_".2359"
 Q
 ;
EN1(IEN,VST) ; -- return a visit in VST("attribute")=value
 N X0,X15,X,DATE,FAC,LOC,CATG,INPT,DA
 K VST,^TMP("VPRTEXT",$J)
 S IEN=+$G(IEN) Q:IEN<1  ;invalid
 D ENCEVENT^PXAPI(IEN)
 S X0=$G(^TMP("PXKENC",$J,IEN,"VST",IEN,0)),X15=$G(^(150))
 Q:$P(X15,U,3)'="P"  Q:$P(X0,U,7)="E"  ;want primary, not historical
 I $P(X0,U,7)="H" D ADM(IEN,+X0,.VST) Q
 S VST("id")=IEN,VST("dateTime")=+X0,DATE=+X0
 S FAC=+$P(X0,U,6),CATG=$P(X0,U,7),LOC=+$P(X0,U,22)
 S:FAC VST("facility")=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 S:'FAC VST("facility")=$$FAC^VPRD(LOC)
 S VST("serviceCategory")=CATG_U_$$CATG(CATG)
 S VST("visitString")=LOC_";"_DATE_";"_CATG
 S INPT=$P(X15,U,2) S:INPT="" INPT=$S("H^I^R^D"[CATG:1,1:0)
 S X=$$CPT(IEN) S:X VST("type")=$P($$CPT^ICPTCOD(X),U,2,3)
 I 'X S VST("type")=U_$S('INPT&LOC:$P($G(^SC(LOC,0)),U)_" VISIT",1:$$CATG(CATG))
 S VST("patientClass")=$S(INPT:"IMP",1:"AMB")
 S:INPT VST("admission")=$$ADMVT(DATE) ;get related mvt# if inpt visit/data
 S X=$P(X0,U,8) S:X VST("stopCode")=$$AMIS(X) I LOC D
 . N L0 S L0=$G(^SC(LOC,0))
 . I 'X S VST("stopCode")=$$AMIS($P(L0,U,7))
 . S VST("location")=$P(L0,U),VST("service")=$$SERV($P(L0,U,20))
 . S X=$P(L0,U,18) S:X VST("creditStopCode")=$$AMIS(X)
 S VST("reason")=$$POV(IEN,DATE)
 ; provider(s), including taxonomy/specialty info
 S DA=0 F  S DA=$O(^TMP("PXKENC",$J,IEN,"PRV",DA)) Q:DA<1  S X0=$G(^(DA,0)) D
 . S VST("provider",DA)=+X0_U_$P($G(^VA(200,+X0,0)),U)_$S($P(X0,U,4)="P":"^P^1",1:"^S^")_U_$$PROVSPC^VPRD(+X0)
 ; cpt(s)
 S DA=0 F  S DA=$O(^TMP("PXKENC",$J,IEN,"CPT",DA)) Q:DA<1  S X0=$G(^(DA,0)) D
 . S VST("cpt",DA)=$P($$CPT^ICPTCOD(+X0),U,2,3)
 ; icd(s)
 S DA=0 F  S DA=$O(^TMP("PXKENC",$J,IEN,"POV",DA)) Q:DA<1  S X0=$G(^(DA,0)) D
 . S VST("icd",DA)=$$ICD(+X0,DATE)_U_$$EXTERNAL^DILFD(9000010.07,.04,,$P(X0,U,4))_U_$S($L($P(X0,U,12)):$P(X0,U,12),1:"U")
 ; note(s)
 D TIU(IEN)
 K ^TMP("PXKENC",$J,IEN)
 Q
 ;
TIU(VISIT) ; -- add notes to VST("document")
 N X,Y,I,VPRX,LT,NT,DA,CNT,VPRY
 D FIND^DIC(8925,,.01,"QX",+$G(VISIT),,"V",,,"VPRX")
 S Y="",(I,CNT)=0
 F  S I=$O(VPRX("DILIST",1,I)) Q:I<1  D
 . S DA=$G(VPRX("DILIST",2,I))
 . S Y=$$INFO^VPRDTIU(+DA) Q:Y<1  ;draft or retracted
 . S CNT=CNT+1,VST("document",CNT)=Y
 . S:$G(VPRTEXT) VST("document",CNT,"content")=$$TEXT^VPRDTIU(DA)
 Q
 ;
POV(VISIT,VDT) ; -- return the primary Purpose of Visit as ICD^ProviderNarrative
 N DA,Y,X,X0,ICD S Y=""
 S DA=0 F  S DA=$O(^TMP("PXKENC",$J,VISIT,"POV",DA)) Q:DA<1  S X0=$G(^(DA,0)) I $P(X0,U,12)="P" D  Q:$L(Y)
 . S X=+$P(X0,U,4),ICD=$$ICD(+X0,$G(VDT))
 . S Y=ICD_U_$$EXTERNAL^DILFD(9000010.07,.04,,X)
 Q Y
 ;
ICD(IEN,DATE) ; -- return code^description^system for ICD code, or "^^" if error
 N X0,VPRX,N,I,X,Y
 S IEN=+$G(IEN),DATE=+$G(DATE,DT)
 S Y=$$CODEC^ICDEX(80,IEN),X=$$VLTD^ICDEX(IEN,DATE)
 I $L(X) S Y=Y_U_X
 E  S Y=Y_U_$$VSTD^ICDEX(IEN,DATE)
 S X=$$CSI^ICDEX(80,IEN),$P(Y,U,3)=$$SAB^ICDEX(X)
 Q Y
 ;
CPT(VISIT) ; -- Return CPT code of encounter type
 N DA,Y,X,X0 S Y=""
 S DA=0 F  S DA=$O(^TMP("PXKENC",$J,VISIT,"CPT",DA)) Q:DA<1  S X0=$G(^(DA,0)) D  Q:$L(Y)
 . S X=$P(X0,U) I X?1"992"2N S Y=X Q
 Q Y
 ;
AMIS(X) ; -- return the AMIS code^name of Credit Stop X
 N Y,X0 S Y=""
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
ADMVT(VAINDT) ; -- return movement# for related admission
 N VADMVT,VAERR
 D ADM^VADPT2
 Q VADMVT
 ;
ADM(IEN,DATE,ADM) ; -- return an admission in ADM("attribute")=value
 N VAINDT,VADMVT,VAIP,VAIN,VAERR,HLOC,ICD,I K ADM
 S IEN=+$G(IEN),DATE=+$G(DATE) Q:IEN<1  Q:DATE<1
 S VAINDT=DATE D ADM^VADPT2 Q:VADMVT<1
 I VADMVT=$G(^DPT(DFN,.105)) D INPT Q  ;current inpatient
 S VAIP("E")=VADMVT D IN5^VADPT Q:'$G(VAIP(1))  ;deleted
 S ADM("id")=IEN,ADM("patientClass")="IMP",ADM("admission")=$G(VAIP(13))
 ; ADM("admitType")=$P($G(VAIP(4)),U,2)
 S DATE=+$G(VAIP(13,1)),(ADM("dateTime"),ADM("arrivalDateTime"))=DATE,I=0
 S X=$G(VAIP(7)) S:X I=I+1,ADM("provider",I)=X_"^P^1"_U_$$PROVSPC^VPRD(+X) ;primary
 S X=$G(VAIP(18)) S:X I=I+1,ADM("provider",I)=X_"^A^"_U_$$PROVSPC^VPRD(+X) ;attending
 S ADM("specialty")=$P($G(VAIP(8)),U,2)
 S X=$$SERV(+$G(VAIP(8))),ADM("service")=X,ADM("ptf")=VAIP(12)
 S ICD=$$POV(IEN,DATE) S:'ICD ICD=$$PTF(DFN,VAIP(12),DATE) ;PTF>ICD
 S ADM("reason")=ICD_U_$G(VAIP(9)) ;ICD code^description^system^Dx text
 S HLOC=+$G(^DIC(42,+$G(VAIP(5)),44))
 S:HLOC ADM("location")=$P($G(^SC(HLOC,0)),U)
 S ADM("facility")=$$FAC^VPRD(+HLOC),ADM("roomBed")=$P(VAIP(6),U,2)
 S ADM("serviceCategory")="H^HOSPITALIZATION"
 S X=$$CPT(IEN),ADM("type")=$S(X:$P($$CPT^ICPTCOD(X),U,2,3),1:U_$$CATG("H"))
 I $G(VAIP(17)) D
 . S ADM("departureDateTime")=+$G(VAIP(17,1))
 . ; ADM("disposition")=$G(VAIP(17,3)) ;Discharge Mvt Type
 S ADM("visitString")=HLOC_";"_DATE_";H"
 D TIU(IEN) ;notes/summary
 Q
 ;
INPT ; -- return current admission in ADM("attribute")=value [from ADM]
 K VAINDT D INP^VADPT Q:$G(VAIN(1))<1
 S ADM("id")=IEN,ADM("patientClass")="IMP",ADM("admission")=VAIN(1)
 ; ADM("admitType")=$P($G(VAIN(8)),U,2)
 S DATE=+$G(VAIN(7)),(ADM("dateTime"),ADM("arrivalDateTime"))=DATE,I=0
 S X=$G(VAIN(2)) S:X I=I+1,ADM("provider",I)=X_"^P^1"_U_$$PROVSPC^VPRD(+X) ;primary
 S X=$G(VAIN(11)) S:X I=I+1,ADM("provider",I)=X_"^A^"_U_$$PROVSPC^VPRD(+X) ;attending
 S ADM("specialty")=$P($G(VAIN(3)),U,2)
 S X=$$SERV(+$G(VAIN(3))),ADM("service")=X,ADM("ptf")=VAIN(10)
 S ICD=$$POV(IEN,DATE) S:'ICD ICD=$$PTF(DFN,VAIN(10),DATE) ;PTF>ICD
 S ADM("reason")=ICD_U_$G(VAIN(9)) ;ICD code^description^system^Dx text
 S HLOC=+$G(^DIC(42,+$G(VAIN(4)),44))
 S:HLOC ADM("location")=$P($G(^SC(HLOC,0)),U)
 S ADM("facility")=$$FAC^VPRD(+HLOC),ADM("roomBed")=VAIN(5)
 S ADM("serviceCategory")="H^HOSPITALIZATION"
 S X=$$CPT(IEN),ADM("type")=$S(X:$P($$CPT^ICPTCOD(X),U,2,3),1:U_$$CATG("H"))
 ; ADM("visitString")=HLOC_";"_DATE_";H"
 D TIU(IEN) ;notes/summary
 Q
 ;
PTF(DFN,PTF,DATE) ; -- return ICD code^description^system for a PTF record
 N VPRPTF,X0,Y
 D:$G(PTF) RPC^DGPTFAPI(.VPRPTF,+PTF) I $G(VPRPTF(0))<0 Q "^^"
 S Y=$P($G(VPRPTF(1)),U,3),DATE=+$G(DATE,DT)
 S X0=$$ICDDX^ICDEX(Y,DATE,,"E") I X0<0 Q "^^"
 S Y=$P(X0,U,2)_U_$P(X0,U,4)          ;ICD Code^Dx name
 S $P(Y,U,3)=$$SAB^ICDEX($P(X0,U,20)) ;coding system
 Q Y
 ;
ENC(IEN,ENC) ; -- return an encounter in ENC("attribute")=value
 N X0,DATE,HLOC,TYPE,STS,X,Y K ENC
 S IEN=+$G(IEN) Q:IEN<1  ;invalid ien
 S ENC("id")="E"_IEN,X0=$$GETOE^SDOE(IEN) ;^SCE(IEN,0) node
 S DATE=+X0,ENC("dateTime")=DATE
 S HLOC=+$P(X0,U,4) I HLOC D
 . S HLOC=HLOC_U_$P($G(^SC(HLOC,0)),U)
 . S ENC("location")=$P(HLOC,U,2)
 . S X=$$GET1^DIQ(44,+HLOC_",",9.5,"I")
 . I X S ENC("service")=$$SERV(X)
 S ENC("facility")=$$FAC^VPRD(+HLOC)
 S STS=$$EXTERNAL^DILFD(409.68,.12,,$P(X0,U,12))
 S X=$S(STS?1"INP".E:"IMP",1:"AMB"),ENC("patientClass")=X,TYPE=$E(X)
 S ENC("type")=U_$S(HLOC:$P(HLOC,U,2)_" VISIT",1:$$CATG(TYPE))
 S ENC("serviceCategory")=TYPE_U_$$CATG(TYPE)
 S ENC("visitString")=+HLOC_";"_DATE_";"_TYPE
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(VISIT) ; -- Return patient visit as XML
 N ATT,X,Y,NAMES,I,J
 D ADD("<visit>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(VISIT(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(VISIT(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(VISIT(ATT,I)) Q:I<1  D
 ... S X=$G(VISIT(ATT,I)),NAMES=""
 ... I ATT="document" S NAMES="id^localTitle^nationalTitle^vuid^Z"
 ... I ATT="provider" S NAMES="code^name^role^primary^"_$$PROVTAGS^VPRD_"^Z"
 ... I ATT="cpt" S NAMES="code^name^Z"
 ... I ATT="icd" S NAMES="code^name^system^narrative^ranking^Z"
 ... S Y="<"_ATT_" "_$$LOOP ;_"/>" D ADD(Y)
 ... S X=$G(VISIT(ATT,I,"content")) I '$L(X) S Y=Y_"/>" D ADD(Y) Q
 ... S Y=Y_">" D ADD(Y)
 ... S Y="<content xml:space='preserve'>" D ADD(Y)
 ... S J=0 F  S J=$O(@X@(J)) Q:J<1  S Y=$$ESC^VPRD(@X@(J)) D ADD(Y)
 ... D ADD("</content>"),ADD("</"_ATT_">")
 .. D ADD("</"_ATT_"s>")
 . S X=$G(VISIT(ATT)),Y="" Q:'$L(X)
 . S NAMES="code^name^"_$S(ATT="reason":"system^narrative^",1:"")_"Z"
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</visit>")
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
