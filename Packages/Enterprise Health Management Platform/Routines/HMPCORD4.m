HMPCORD4 ;SLC/AGP,ASMR/RRB -Retrieved Orderable Items;Nov 04, 2015 12:13:23
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
ADDODG ; called by HMPEF
 N CNT,IEN,NUM,NODE,PTR,RESULT,TEMP
 N ERRMSG S ERRMSG="A mumps error occurred while extracting display groups"
 S IEN=0 F  S IEN=$O(^ORD(100.98,IEN)) Q:IEN'>0  D
 .N $ES,$ET
 .S $ET="D ERRHDLR^HMPDERRH"
 .I '$D(^ORD(100.98,IEN,1)) D  Q
 ..S NODE=$G(^ORD(100.98,IEN,0)) D SODGNODE(.RESULT,NODE)
 ..S RESULT("uid")=$$SETUID^HMPUTILS("displayGroup","",IEN),RESULT("internal")=IEN
 ..D ADD^HMPEF("RESULT") S HMPCNT=+$G(HMPCNT)+1,HMPLAST=IEN
 .D ADDODG1(IEN,.TEMP)
 .M RESULT=TEMP
 .D ADD^HMPEF("RESULT") S HMPCNT=+$G(HMPCNT)+1,HMPLAST=IEN
 I IEN'>0 S HMPFINI=1
 Q
 ;
ADDODG1(IEN,TEMP) ;
 N CNT,NODE,NUM,PTR
 S NODE=$G(^ORD(100.98,IEN,0)) D SODGNODE(.TEMP,NODE)
 S TEMP("uid")=$$SETUID^HMPUTILS("displayGroup","",IEN),TEMP("internal")=IEN
 I '$D(^ORD(100.98,IEN,1)) Q
 S NUM=0,CNT=0 F  S NUM=$O(^ORD(100.98,IEN,1,NUM)) Q:NUM'>0  D
 .N ARRAY
 .S PTR=$G(^ORD(100.98,IEN,1,NUM,0)) Q:PTR'>0
 .D ADDODG1(PTR,.ARRAY) I '$D(ARRAY) Q
 .S CNT=CNT+1 M TEMP("children",CNT,"item")=ARRAY
 Q
 ;
SODGNODE(RESULT,NODE) ;
 N NAME,TEMP,X
 F X=1:1:4 D
 .S TEMP=$P(NODE,U,X) I X<4,$L(TEMP)>1 S RESULT($S(X=1:"name",X=2:"displayName",X=3:"abbreviation"))=TEMP
 .I X=4,+TEMP>0 S NAME=$P($G(^ORD(101.41,TEMP,0)),U) S RESULT("defaultDialogUid")=$$SETUID^HMPUTILS("orderDialog","",TEMP),RESULT("defaultDialogName")=NAME
 Q
 ;
ADDROUTE ;
 N CNT,IEN,NAME,RESULT,ROUTES,X,UID,VALUE
 N ERRMSG
 S ERRMSG="A mumps error occurred while extracting routes."
 S CNT=1,IEN=0
 I +$G(HMPLAST)>0 S IEN=HMPLAST
 F  S IEN=$O(^PS(51.2,IEN)) Q:IEN'>0  D
 .N $ES,$ET
 .S $ET="D ERRHDLR^HMPDERRH"
 .S NODE=$P($G(^PS(51.2,IEN,0)),U,1,6)
 .I $P(NODE,U,5)>0 Q
 .S UID=$$SETUID^HMPUTILS("route","",IEN)
 .S RESULT("uid")=UID,RESULT("internal")=IEN
 .F X=1,2,3,6 D
 ..S VALUE=$P(NODE,U,X) Q:VALUE=""
 ..S NAME=$S(X=1:"name",X=2:"externalName",X=3:"abbreviation",X=6:"useInIV",1:"")
 ..I NAME="" Q
 ..I X=6 S VALUE=$S(VALUE=1:"true",1:"false")
 ..S RESULT(NAME)=VALUE
 .D ADD^HMPEF("RESULT") S HMPCNT=+$G(HMPCNT)+1,HMPLAST=IEN
 .;S CNT=CNT+1
 .K RESULT
 I IEN'>0 S HMPFINI=1
 Q
 ;
ADDSCH ;
 N CNT,IEN,NAME,NODE,NUM,RESULT,UID,HMPSCH
 ;D SCHALL^ORWDPS1(.HMPSCH,0,0)
 D SCHED^PSS51P1(0,.HMPSCH)
 N ERRMSG
 S ERRMSG="A mumps error occurred while extracting schedules."
 S CNT=0 F  S CNT=$O(HMPSCH(CNT)) Q:CNT'>0  D
 .N $ES,$ET
 .S $ET="D ERRHDLR^HMPDERRH"
 .S NODE=$G(HMPSCH(CNT))
 .S NAME=$P(NODE,U,2)
 .S IEN=$P(NODE,U)
 .;S IEN=$O(^PS(51.1,"B",NAME,"")) I IEN'>0 Q
 .S UID=$$SETUID^HMPUTILS("schedule","",IEN)
 .S RESULT("uid")=UID,RESULT("internal")=IEN
 .S RESULT("name")=NAME
 .I $P(NODE,U,3)'="" S RESULT("externalValue")=$P(NODE,U,3)
 .I $P(NODE,U,4)'="" S RESULT("scheduleType")=$P(NODE,U,4)
 .D ADD^HMPEF("RESULT") S HMPCNT=+$G(HMPCNT)+1,HMPLAST=IEN
 .K RESULT
 I CNT'>0 S HMPFINI=1
 Q
 ;
LAB(RESULT,OI) ;
 N CNT,I,IEN,NODE,SYN,TEMP,HMPLST
 S RESULT("dialogAdditionalInformation","sendPatientTimes",1,"internal")="LT",RESULT("dialogAdditionalInformation","sendPatientTimes",1,"name")="Today"
 S RESULT("dialogAdditionalInformation","sendPatientTimes",2,"internal")="LT+1",RESULT("dialogAdditionalInformation","sendPatientTimes",2,"name")="Tomorrow"
 ;
 D GETLST^XPAR(.HMPLST,"ALL","ORWD COMMON LAB INPT")  ;DBIA 2263
 S I=0 F  S I=$O(HMPLST(I)) Q:'I  D
 . S IEN=$P(HMPLST(I),U,2)
 . K P1
 . S P1="dialogAdditionalInformation"
 . S RESULT("dialogAdditionalInformation","common",I,"uid")=$$SETUID^HMPUTILS("orderable","",IEN)
 . S RESULT("dialogAdditionalInformation","common",I,"internal")=IEN
 . S RESULT("dialogAdditionalInformation","common",I,"name")=$P(^ORD(101.43,IEN,0),U,1)
 ;
 S NODE=$G(^ORD(101.43,OI,"LR"))
 S RESULT("labDetails","speciman")=$P(NODE,U),RESULT("labDetails","labCollect")=$S($P(NODE,U,2)=1:"true",1:"false"),RESULT("labDetails","sequence")=$P(NODE,U,3)
 S RESULT("labDetails","maxOrderFrequency")=$P(NODE,U,4),RESULT("labDetails","dailyOrderMax")=$P(NODE,U,5)
 ;
 S TEMP=$P(NODE,U,6)
 S RESULT("types",1,"abb")=TEMP,RESULT("types",1,"uid")=$$SETUID^HMPUTILS("labType","",TEMP),RESULT("types",1,"internal")=TEMP,RESULT("types",1,"type")=$$LABTYPE(TEMP)
 S TEMP=$P(NODE,U,7)
 I TEMP'="" S RESULT("labDetails","labTypeInternal")=TEMP,RESULT("labDetails","labTypeName")=$S(TEMP="I":"Input",TEMP="O":"Output",TEMP="B":"Both",TEMP="N":"Neither")
 I '$D(^ORD(101.43,OI,2)) Q
 S CNT=0
 S I=0 F  S I=$O(^ORD(101.43,OI,2,I)) Q:I'>0  D
 .S SYN=$G(^ORD(101.43,OI,2,I,0)) Q:SYN=""
 .S CNT=CNT+1,RESULT("synonym",CNT,"name")=SYN
 Q
 ;
LABTYPE(L) ;
 I L="CH" Q "Chemistry"
 I L="MI" Q "MICROBIOLOGY"
 I L="BB" Q "Blood Bank"
 I L="EM" Q "Electron Microscopy"
 I L="SP" Q "Surgical Pathology"
 I L="AU" Q "Autopsy"
 I L="CY" Q "Cytology"
 Q ""
 ;
OI(OITYPE) ; called by HMPEF
 N CNT,ERROR,IEN,NAME,LINK,LINKTYPE,NODE,RADDET,RADTYPE,RESULT,TCNT,TYPE,UID,HMPTEMP
 N ERRMSG
 S ERRMSG="A mumps error occurred while extracting orderable items."
 S CNT=1,IEN=0
 ;
 D RADTYPE(.RADTYPE,.RADDET)
 I +$G(HMPLAST)>0 S IEN=HMPLAST
 I +$G(HMPID)>0 S IEN=HMPID
 F  S IEN=$O(^ORD(101.43,IEN)) Q:IEN'>0  D  I HMPMAX>0,HMPI'<HMPMAX Q
 .N $ES,$ET
 .S $ET="D ERRHDLR^HMPDERRH"
 .K RESULT
 .S TYPE=$$VALIDOI(OITYPE,IEN)
 .I TYPE="" Q
 .S NAME=$P(^ORD(101.43,IEN,0),U),LINK=$P($P(^ORD(101.43,IEN,0),U,2),";99",1),LINKTYPE=$P($P(^ORD(101.43,IEN,0),U,2),";99",2)
 .S UID=$$SETUID^HMPUTILS("orderable","",IEN)
 .S RESULT("uid")=UID,RESULT("internal")=IEN
 .S RESULT("name")=NAME
 .S RESULT("link")=LINK
 .S RESULT("linktype")=LINKTYPE
 .I TYPE["PS" D PS(.RESULT,IEN,CNT)
 .I TYPE["RA" D RA(.RESULT,IEN,CNT,.RADTYPE,.RADDET)
 .I TYPE["LR" D LAB(.RESULT,IEN)
 .D ADD^HMPEF("RESULT") S HMPCNT=+$G(HMPCNT)+1,HMPLAST=IEN
 .S CNT=CNT+1
 I IEN'>0 S HMPFINI=1
 Q
 ;
PS(RESULT,IEN,PLACE) ;
 N CNT,COST,DOSE,DOSES,DRUG,MEDS,NAME,NODE,NUM,PSOI,SIZE,TYPE,UID,HMPDOSE
 S CNT=0
 I $D(^ORD(101.43,IEN,9,"B","NV RX")) S CNT=CNT+1 S RESULT("types",CNT,"type")="NON-VA MEDS" S MEDS("NV RX")=""
 I $D(^ORD(101.43,IEN,9,"B","O RX")) S CNT=CNT+1 S RESULT("types",CNT,"type")="OUTPATIENT MEDS" S MEDS("O RX")=""
 I $D(^ORD(101.43,IEN,9,"B","RX")) S CNT=CNT+1 S RESULT("types",CNT,"type")="MEDS" S MEDS("RX")=""
 I $D(^ORD(101.43,IEN,9,"B","UD RX")) S CNT=CNT+1 S RESULT("types",CNT,"type")="INPATIENT MEDS" S MEDS("UD RX")=""
 ;
 K DOSES
 S PSOI=+$P(^ORD(101.43,IEN,0),U,2)
 S TYPE="" F  S TYPE=$O(MEDS(TYPE)) Q:TYPE=""  D
 .D DOSE^PSSOPKI1(.HMPDOSE,PSOI,TYPE,0)
 .S CNT=0 F  S CNT=$O(HMPDOSE(CNT)) Q:CNT'>0  D
 ..S NODE=$G(HMPDOSE(CNT)),SIZE="",UID=0,DRUG="",COST=""
 ..S DOSE=$P(NODE,U,5)
 ..I $D(DOSES(DOSE)) Q
 ..I $P(NODE,U,3)'="",$P(NODE,U,4)'="" S SIZE=$P(NODE,U,3)_" "_$P(NODE,U,4)
 ..S DRUG=$P(NODE,U,6),COST=$P(NODE,U,7)
 ..S DOSES(DOSE)=$G(SIZE)_U_DRUG_U_COST
 ;
 S DOSE="",CNT=1 F  S DOSE=$O(DOSES(DOSE)) Q:DOSE=""  D
 .S NODE=DOSES(DOSE)
 .S RESULT("possibleDosages",CNT,"dose")=DOSE
 .I $P(NODE,U)'="" S RESULT("possibleDosages",CNT,"size")=$P(NODE,U)
 .I $P(NODE,U,2)>0 D
 ..S NAME=$P($G(^PSDRUG($P(NODE,U,2),0)),U)
 ..S RESULT("possibleDosages",CNT,"drugUid")=$$SETUID^HMPUTILS("drug","",$P(NODE,U,2))
 ..S RESULT("possibleDosages",CNT,"drugInternal")=$P(NODE,U,2)
 ..S RESULT("possibleDosages",CNT,"drugName")=NAME
 .;I $P(NODE,U,3)'="" S RESULT("possibleDosages",CNT,"cost")=$P(NODE,U,3) 
 .S CNT=CNT+1
 Q
 ;
RA(RESULT,IEN,PLACE,RADTYPE,RADDET) ;
 N CNT,NODE,TEMP
 S CNT=0
 S NODE=$G(^ORD(101.43,IEN,0))
 Q:$P(NODE,U,3)=""  ;BL;DE801 NULL SUBSCRIPT FOUND AT TEST SITES
 I $P(NODE,U,3)'="",$P(NODE,U,4)'="" S RESULT("code")=$$SETUID^HMPUTILS($$LOW^XLFSTR($P(NODE,U,4)),"",$P(NODE,U,3))
 S NODE=$G(^ORD(101.43,IEN,"RA"))
 S RESULT("imagingDetails","contractMedia")=$P(NODE,U)
 I $P(NODE,U,2)'="" S TEMP=$P(NODE,U,2),RESULT("imagingDetails","procedureType")=$S(TEMP="B":"Board",TEMP="D":"Detailed",TEMP="S":"Series",TEMP="P":"Parent")
 I $P(NODE,U,3)'="",$D(RADTYPE($P(NODE,U,3))) D
 .S TEMP=$G(RADTYPE($P(NODE,U,3))),RESULT("types",1,"type")=$P(TEMP,U,2),RESULT("types",1,"uid")=$$SETUID^HMPUTILS("radType","",$P(TEMP,U)),RESULT("internal")=$P(TEMP,U),RESULT("types",1,"abb")=$P(NODE,U,3)
 .S RESULT("imagingDetails","commonProcedure")=$S($P(NODE,U,4)=1:"true",1:"false")
 .I $D(RADTYPE($P(NODE,U,3))) M RESULT("dialogAdditionalInformation")=RADDET($P(NODE,U,3))
 Q
 ;
RADTYPE(RADTYPE,RADDET) ;
 ;build radiology type array for reused to load imaging types
 N ABB,CNT,IMGTYP,SUBMIT,TCNT,URG,VALUES,HMPTEMP,HMPX
 D IMTYPSEL^ORWDRA32(.HMPTEMP,"")
 D CAT(.VALUES),TRANS(.VALUES),URGENCY(.VALUES)
 S TCNT=""
 F  S TCNT=$O(HMPTEMP(TCNT)) Q:TCNT=""  D
 .S NODE=HMPTEMP(TCNT)
 .S IMGTYP=$P(NODE,U),ABB=$P(NODE,U,3)
 .D SUBMIT(.VALUES,ABB)
 .S RADTYPE(ABB)=IMGTYP_U_$P(NODE,U,2)_U_$P(NODE,U,4)
 .I $D(VALUES) M RADDET(ABB)=VALUES
 .;Radiology Modifier
 .S I=$O(^RA(79.2,"C",ABB,0)) Q:'I
 .S HMPX=0,CNT=0 F  S HMPX=$O(^RAMIS(71.2,"AB",I,HMPX)) Q:'HMPX  D
 ..S CNT=CNT+1
 ..S RADDET(ABB,"modifier",CNT,"uid")=$$SETUID^HMPUTILS("modifier","",HMPX),RADDET(ABB,"modifier",CNT,"internal")=HMPX
 ..S RADDET(ABB,"modifier",CNT,"name")=$P(^RAMIS(71.2,HMPX,0),U)
 Q
 ;
 ;Transport values
TRANS(RADDET) ;
 N CNT,HMPX
 S CNT=0
 F HMPX="A^AMBULATORY","P^PORTABLE","S^STRETCHER","W^WHEELCHAIR" D
 .S CNT=CNT+1,RADDET("transport",CNT,"uid")=$$SETUID^HMPUTILS("transport","",$P(HMPX,U)),RADDET("transport",CNT,"name")=$P(HMPX,U,2),RADDET("transport",CNT,"internal")=$P(HMPX,U)
 Q
 ;
CAT(RADDET) ;category values
 N CNT,HMPX
 S CNT=0
 F HMPX="I^INPATIENT","O^OUTPATIENT","E^EMPLOYEE","C^CONTRACT","S^SHARING","R^RESEARCH" D
 .S CNT=CNT+1,RADDET("category",CNT,"uid")=$$SETUID^HMPUTILS("transport","",$P(HMPX,U)),RADDET("category",CNT,"name")=$P(HMPX,U,2),RADDET("category",CNT,"internal")=$P(HMPX,U)
 Q
 ;
URGENCY(URG) ; Get the allowable urgencies and default
 N CNT,I,HMPX
 S HMPX="",I=0,CNT=0
 F  S ORX=$O(^ORD(101.42,"S.RA",HMPX)) Q:HMPX=""  D
 . S I=$O(^ORD(101.42,"S.RA",HMPX,0))
 . S URG("urgency",CNT,"uid")=$$SETUID^HMPUTILS("urgency","",I),URG("urgency",CNT,"internal")=I
 . S URG("urgency",CNT,"name")=HMPX
 . S URG("urgency",CNT,"default")="false"
 . S CNT=CNT+1
 S I=$O(^ORD(101.42,"B","ROUTINE",0)) I +I=0 Q
 S CNT=CNT+1
 S URG("urgency",CNT,"uid")=$$SETUID^HMPUTILS("urgency","",I),URG("urgency",CNT,"internal")=I
 S URG("urgency",CNT,"name")="Routine"
 S URG("urgency",CNT,"default")="true"
 Q
 ;
SUBMIT(SUBMIT,IMGTYP) ; Get the locations to which the request may be submitted
 N CNT,FIRST,TMPLST,ASK,HMPX
 S CNT=0
 D EN4^RAO7PC1(IMGTYP,"TMPLST")
 S FIRST=1
 S I=0 F  S I=$O(TMPLST(I)) Q:'I  D
 . S CNT=CNT+1,HMPX=$P(TMPLST(I),U,1,2),SUBMIT("submit",CNT,"name")=$P(HMPX,U,2)
 . S SUBMIT("submit",CNT,"default")=$S(FIRST=1:"true",1:"false")
 . S SUBMIT("submit",CNT,"uid")=$$SETUID^HMPUTILS("imagingLocation","",$P(HMPX,U)),SUBMIT("submit",CNT,"internal")=$P(HMPX,U),FIRST=0
 S HMPX=$$GET^XPAR("ALL","RA SUBMIT PROMPT",1,"Q")
 S ASK=$S($L(HMPX):HMPX,1:1)
 S SUBMIT("askSubmit")=$S(ASK=1:"true",ASK=0:"false",1:"true")
 Q
 ;
QO ;
 N IEN,NAME,NODE,RESULT
 N ERRMSG S ERRMSG="A mumps error occurred while extracting orderable items."
 S IEN=0 F  S IEN=$O(^ORD(101.41,IEN)) Q:IEN'>0  D
 .N $ES,$ET
 .S $ET="D ERRHDLR^HMPDERRH"
 .S NODE=$G(^ORD(101.41,IEN,0)) I $P(NODE,U,4)'="Q" Q
 .S NAME=$S($P(NODE,U,2)'="":$P(NODE,U,2),1:$P(NODE,U))
 .S RESULT("name")=NAME
 .S RESULT("uid")=$$SETUID^HMPUTILS("qo","",IEN),RESULT("internal")=IEN
 .S HMPCNT=HMPCNT+1 D ADD^HMPEF("RESULT")
 I IEN'>0 S HMPFINI=1
 Q
 ;
VALIDOI(OITYPE,IEN) ;
 N TEMP,TYPE
 I $G(^ORD(101.43,IEN,0))'=""
 S TEMP=$P(^ORD(101.43,IEN,0),U,2)
 S TYPE=$P(TEMP,";",2)
 S TYPE=$E(TYPE,3,$L(TYPE))
 I OITYPE="" Q TYPE
 I TYPE["PS" Q TYPE
 I OITYPE[TYPE Q TYPE
 Q ""
 ;
