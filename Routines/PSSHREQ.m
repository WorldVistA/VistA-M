PSSHREQ ;WOIFO/AV,TS - Creates PSSXML to send to PEPS using input global ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136,163**;9/30/97;Build 8
 ;
 ; @authors - Alex Vazquez, Tim Sabat, Steve Gordon
 ; @date    - September 19, 2007
 ; @version - 1.0
 ;
 QUIT
 ;;
BLDPREQ(PSSBASE) ;
 ; @DRIVER
 ;
 ; @DESC Builds the PEPSRequest PSSXML element
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS An xml string representing an entire order check.
 ;
 NEW PSS,PSSXML
 ;
 SET PSS("PSSXMLHeader")=$$XMLHDR^MXMLUTL
 SET PSS("xmlns")=$$ATRIBUTE^PSSHRCOM("xmlns","gov/va/med/pharmacy/peps/external/common/preencapsulation/vo/drug/check/request")
 SET PSS("xsi")=$$ATRIBUTE^PSSHRCOM("xmlns:xsi","http://www.w3.org/2001/XMLSchema-instance")
 ;
 SET PSSXML=PSS("PSSXMLHeader")
 SET PSSXML=PSSXML_"<PEPSRequest"
 SET PSSXML=PSSXML_" "_PSS("xmlns")
 SET PSSXML=PSSXML_" "_PSS("xsi")
 SET PSSXML=PSSXML_" >"
 SET PSSXML=PSSXML_$$HEADER(PSSBASE)
 I '$D(^TMP($JOB,PSSBASE,"IN","PING")) SET PSSXML=PSSXML_$$BODY(PSSBASE)
 SET PSSXML=PSSXML_"</PEPSRequest>"
 ;
 QUIT PSSXML
 ;;
HEADER(PSSBASE) ;
 ; @DESC Builds the Header PSSXML element. A header is the section of the PSSXML
 ; that includes time, server, and user.  This item holds no business logic, it
 ; only records debugging information.
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS A the PSSXML string representing the header element.
 ;
 NEW PSSXML,PSS
 ;
 ; pingOnly is OPTIONAL. If data in global, set pingOnly to true
 IF $DATA(^TMP($JOB,PSSBASE,"IN","PING")) DO
 . SET PSS("pingOnly")=$$ATRIBUTE^PSSHRCOM("pingOnly","true")
 . QUIT
 ;
 SET PSSXML="<Header "_$GET(PSS("pingOnly"))_">"
  SET PSSXML=PSSXML_$$HDRTIME
  SET PSSXML=PSSXML_$$HDRSERVR
  SET PSSXML=PSSXML_$$HDRMUSER
 SET PSSXML=PSSXML_"</Header>"
 ;
 ; Return composed header
 QUIT PSSXML
 ;;
HDRTIME() ;
 ; @DESC Builds the Time PSSXML element which resides in the header
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS An xml string containing the time element.
 ;
 NEW PSS,PSSXML
 ;
 SET PSS("value")=$$ATRIBUTE^PSSHRCOM("value",$GET(DT))
 ;
 SET PSSXML="<Time"
 SET PSSXML=PSSXML_" "_PSS("value")
 SET PSSXML=PSSXML_" />"
 ;
 QUIT PSSXML
 ;;
HDRSERVR() ;
 ; @DESC Builds the MServer PSSXML element
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS An PSSXML string representing the server element.
 ;
 NEW PSS,PSSXML,PSSNTDS1,PSSNTDS2,PSSNTDS3,PSSNTDS4,PSSNTDS5
 ;
 SET PSS("IP")=$$ATRIBUTE^PSSHRCOM("ip",$GET(IO("IP")))
 ;
 ; Namespace will remain empty because the method call used to get it
 ; is considered non-standard mumps.
 SET PSS("nameSpace")=$$ATRIBUTE^PSSHRCOM("namespace","")
 ;
 SET PSS("serverName")=$$ATRIBUTE^PSSHRCOM("serverName",$PIECE($GET(XMV("NETNAME")),"@",2))
 ;
 ;SET PSS("stationNumberOnly")=$$IEN^XUAF4($PIECE($$SITE^VASITE(),"^",1))
 ;IF PSS("stationNumberOnly")="" SET PSS("stationNumberOnly")=1
 S PSSNTDS1=$P($$SITE^VASITE(),"^",3)
 I PSSNTDS1'?1N.N S PSSNTDS2=$L(PSSNTDS1) S PSSNTDS5="" D:PSSNTDS2>0  S PSSNTDS1=PSSNTDS5 I PSSNTDS1'?1N.N S PSSNTDS1=0
 .F PSSNTDS3=1:1:PSSNTDS2 S PSSNTDS4=$E(PSSNTDS1,PSSNTDS3) Q:PSSNTDS4'?1N  S PSSNTDS5=PSSNTDS5_PSSNTDS4
 SET PSS("stationNumber")=$$ATRIBUTE^PSSHRCOM("stationNumber",PSSNTDS1)
 ;
 ; Namespace will remain empty because the method call used to get it
 ; is considered non-standard mumps.
 SET PSS("UCI")=$$ATRIBUTE^PSSHRCOM("uci","")
 ;
 SET PSSXML="<MServer"
 SET PSSXML=PSSXML_" "_PSS("IP")
 SET PSSXML=PSSXML_" "_PSS("nameSpace")
 SET PSSXML=PSSXML_" "_PSS("serverName")
 SET PSSXML=PSSXML_" "_PSS("stationNumber")
 SET PSSXML=PSSXML_" "_PSS("UCI")
 SET PSSXML=PSSXML_" />"
 ;
 QUIT PSSXML
 ;;
HDRMUSER() ;
 ; @DESC Builds the user element of the PSSXML
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS An PSSXML string representing the M user.
 ;
 NEW PSS,PSSXML,PSSNTDZ,PSSNTDJB
 ;
 S PSSNTDZ=$G(DUZ) I PSSNTDZ'?1N.N S PSSNTDZ=0
 ;
 SET PSS("DUZ")=$$ATRIBUTE^PSSHRCOM("duz",PSSNTDZ)
 ;
 S PSSNTDJB=$J S:PSSNTDJB'?1N.N PSSNTDJB=0 SET PSS("jobNumber")=$$ATRIBUTE^PSSHRCOM("jobNumber",PSSNTDJB)
 ;
 ; FIXME need to get username
 SET PSS("userName")=$$ATRIBUTE^PSSHRCOM("userName",$$GET1^DIQ(200,DUZ_",",.01))
 ;
 SET PSSXML="<MUser"
 SET PSSXML=PSSXML_" "_PSS("DUZ")
 SET PSSXML=PSSXML_" "_PSS("jobNumber")
 SET PSSXML=PSSXML_" "_PSS("userName")
 SET PSSXML=PSSXML_" />"
 ;
 QUIT PSSXML
 ;;
BODY(PSSBASE) ;
 ; @DESC Builds the Body PSSXML element
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS An PSSXML string representing the body element.
 ;
 NEW PSSXML
 ;
 SET PSSXML="<Body>"
  SET PSSXML=PSSXML_$$DRGCHEK(PSSBASE)
 SET PSSXML=PSSXML_"</Body>"
 ;
 QUIT PSSXML
 ;;
DRGCHEK(PSSBASE) ;
 ; @DESC Builds the DrugCheck PSSXML element
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS an PSSXML string representing the drugCheck element
 ;
 NEW PSSXML
 ;
 SET PSSXML="<drugCheck>"
  SET PSSXML=PSSXML_$$CHECKS(PSSBASE)
  SET PSSXML=PSSXML_$$DRUGPROS(PSSBASE)
  SET PSSXML=PSSXML_$$MEDPROF(PSSBASE)
 SET PSSXML=PSSXML_"</drugCheck>"
 ;
 ; Return the full drugCheck element
 QUIT PSSXML
 ;;
CHECKS(PSSBASE) ;
 ; @DESC Builds the checks PSSXML element
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS An PSSXML string representing the checks element.
 ;
 NEW PSS,PSSXML
 ;
 ; If data in global, set prospective only to false
 IF $DATA(^TMP($JOB,PSSBASE,"IN","PROFILEVPROFILE")) DO
 . SET PSS("prospectiveOnly")=$$ATRIBUTE^PSSHRCOM("prospectiveOnly","false")
 . QUIT
 ;
 ; If no data in global, set prospective only to true
 IF '$DATA(^TMP($JOB,PSSBASE,"IN","PROFILEVPROFILE")) DO
 . SET PSS("prospectiveOnly")=$$ATRIBUTE^PSSHRCOM("prospectiveOnly","true")
 . QUIT
 ;
 ; OPTIONAL. TBA Right now set to false, will be used in future
 SET PSS("useCustomTables")=$$ATRIBUTE^PSSHRCOM("useCustomTables","true")
 ;
 SET PSSXML="<checks"
 SET PSSXML=PSSXML_" "_$GET(PSS("prospectiveOnly"))
 SET PSSXML=PSSXML_" "_$GET(PSS("useCustomTables"))
 SET PSSXML=PSSXML_" >"
  SET PSSXML=PSSXML_$$CHEKDOSE(PSSBASE)
  SET PSSXML=PSSXML_$$CHEKDRUG(PSSBASE)
  SET PSSXML=PSSXML_$$CHEKTHER(PSSBASE)
 SET PSSXML=PSSXML_"</checks>"
 ;
 ; Return the full drugCheck element
 QUIT PSSXML
 ;;
CHEKDOSE(PSSBASE) ;
 ; @DESC Sets the drugDoseCheck element
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS An PSSXML string representing the doseCheck element
 ;
 NEW PSSXML
 ;
 SET PSSXML=""
 ;
 IF $DATA(^TMP($JOB,PSSBASE,"IN","DOSE")) DO
 . SET PSSXML="<drugDoseCheck>"
 . ; Get the demographics PSSXML section
 . SET PSSXML=PSSXML_$$DEMOGRAF(PSSBASE)
 . SET PSSXML=PSSXML_"</drugDoseCheck>"
 . QUIT
 ;
 QUIT PSSXML
 ;;
DEMOGRAF(PSSBASE) ;
 ; @DESC Builds the demographic element
 ;
 ; @PSSBASE Input global base
 ;
 ; @RETURNS An PSSXML string representation of the demographics element
 ;
 NEW PSSXML,PSS
 ;
 SET PSS("bsa")=$GET(^TMP($JOB,PSSBASE,"IN","DOSE","BSA"))
 SET PSS("bodySurfaceAreaInSqM")=$$ATRIBUTE^PSSHRCOM("bodySurfaceAreaInSqM",PSS("bsa"))
 ;
 SET PSS("wt")=$GET(^TMP($JOB,PSSBASE,"IN","DOSE","WT"))
 SET PSS("weightInKG")=$$ATRIBUTE^PSSHRCOM("weightInKG",PSS("wt"))
 ;
 SET PSS("age")=$GET(^TMP($JOB,PSSBASE,"IN","DOSE","AGE"))
 SET PSS("ageInDays")=$$ATRIBUTE^PSSHRCOM("ageInDays",PSS("age"))
 ;
 SET PSSXML="<demographics "_PSS("bodySurfaceAreaInSqM")_" "_PSS("weightInKG")_" "_PSS("ageInDays")_"/>"
 QUIT PSSXML
 ;;
CHEKDRUG(PSSBASE) ;
 ; @DESC Sets the drugDrugCheck element
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS An PSSXML String representing drugDoseCheck element
 ;
 NEW PSSXML
 ;
 SET PSSXML=""
 ; If drug drug global set, add drug drug check
 IF $DATA(^TMP($JOB,PSSBASE,"IN","DRUGDRUG"))=1 DO
 . SET PSSXML="<drugDrugCheck />"
 . QUIT
 ;
 QUIT PSSXML
 ;;
CHEKTHER(PSSBASE) ;
 ; @DESC Sets the drugTherapyCheck element
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS An PSSXML string representing the drugTherapyCheck element
 ;
 NEW PSSXML
 SET PSSXML=""
 ; If drug therapy set, add therapy check
 IF $DATA(^TMP($JOB,PSSBASE,"IN","THERAPY"))=1 DO
 . SET PSSXML="<drugTherapyCheck />"
 . QUIT
 ;
 QUIT PSSXML
 ;;
MEDPROF(PSSBASE) ;
 ; @DESC Builds a medicationProfile element
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS PSSXML string element of the medicationProfile
 ;
 NEW PSS,PSSXML
 ;
 SET PSSXML="<medicationProfile>"
  SET PSSXML=PSSXML_$$DRUGPROF(PSSBASE)
 SET PSSXML=PSSXML_"</medicationProfile>"
 ;
 QUIT PSSXML
 ;;
DRUGPROS(PSSBASE) ;
 ; @DESC Builds prospectiveDrugs element
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS An PSSXML string representing prospectiveDrugs
 ;
 NEW PSSXML,PSSDRUGS
 ;
 ; Read drug info from input global, store in PSSDRUGS hash
 DO READRUGS(PSSBASE,"PROSPECTIVE",.PSSDRUGS)
 D
 .I '$D(PSSDRUGS("DRUG")) S PSSXML="" Q  ;if no prospective drug just return null
 .; Write the drugs as PSSXML
 .SET PSSXML="<prospectiveDrugs>"_$$RITEDRGS(.PSSDRUGS)_"</prospectiveDrugs>"
 ;
 QUIT PSSXML
 ;;
DRUGPROF(PSSBASE) ;
 ; @DESC Builds a prospective drug element
 ;
 ; @PSSBASE Base of input global
 ;
 ; @RETURNS An PSSXML string representing profile drugs
 ;
 NEW PSSXML,PSSDRUGS
 ;
 ; Read from the input global and put in PSSDRUGS hash
 DO READRUGS(PSSBASE,"PROFILE",.PSSDRUGS)
 ; Write the profile drugs as PSSXML
 SET PSSXML=$$RITEDRGS(.PSSDRUGS)
 ;
 QUIT PSSXML
 ;;
READRUGS(PSSBASE,DRUGTYPE,PSSDRUGS) ;
 ; @DESC Builds either a prospective or a profile drug element.
 ; Note the "DRUGTYPE" parameter.  This param allows for re-use, so either
 ; a profile or a prospective drug can be created.
 ;
 ; @PSSBASE Base of input global
 ; @DRUGTYPE A drug type, either Prospective or Profile
 ; @PSSDRUGS ByRef, variable to store drug attributes in
 ;
 ; @RETURNS Nothing, values stored in drugs variable
 ;
 NEW PSS
 ;
 SET PSS("ien")=""
 SET PSS("count")=0
 ;
 ; Loop through the unique order numbers
 SET PSS("orderNumber")=""
 FOR  SET PSS("orderNumber")=$ORDER(^TMP($JOB,PSSBASE,"IN",DRUGTYPE,PSS("orderNumber"))) QUIT:PSS("orderNumber")=""  DO
 . SET PSS("count")=PSS("count")+1
 . SET PSS("value")=$GET(^TMP($JOB,PSSBASE,"IN",DRUGTYPE,PSS("orderNumber")))
 . ; Set the drug order number
 . SET PSSDRUGS("DRUG",PSS("count"),"orderNumber")=PSS("orderNumber")
 . ; Set the drug gcn sequence number
 . SET PSSDRUGS("DRUG",PSS("count"),"gcn")=+$PIECE(PSS("value"),"^",1)
 . ; Set the drug vuid
 . SET PSSDRUGS("DRUG",PSS("count"),"vuid")=+$PIECE(PSS("value"),"^",2)
 . ; Set the drug ien
 . SET PSSDRUGS("DRUG",PSS("count"),"ien")=+$PIECE(PSS("value"),"^",3)
 . ; Set the drug name
 . SET PSSDRUGS("DRUG",PSS("count"),"drugName")=$PIECE(PSS("value"),"^",4)
 . ; Set the cprs order number
 . SET PSSDRUGS("DRUG",PSS("count"),"cprsOrderNumber")=$PIECE(PSS("value"),"^",5)
 . ; Set the package
 . SET PSSDRUGS("DRUG",PSS("count"),"package")=$PIECE(PSS("value"),"^",6)
 . ;
 . ; Get the possible dose information for the drug
 . DO READDOSE(PSSBASE,.PSSDRUGS,PSS("count"),PSS("orderNumber"))
 . QUIT
 ;
 QUIT
 ;;
RITEDRGS(PSSDRUGS) ;
 ; @DESC Loop through the drugs and return PSSXML
 ;
 ; @PSSDRUGS Array containing the list of drugs
 ;
 ; @RETURNS PSSXML representing the drugs in array
 ;
 NEW PSSCOUNT,PSSXML
 ;
 SET PSSXML=""
 SET PSSCOUNT=""
 FOR  SET PSSCOUNT=$ORDER(PSSDRUGS("DRUG",PSSCOUNT)) QUIT:PSSCOUNT=""  DO
 . ; loop through drugs and append to PSSXML
 . SET PSSXML=PSSXML_$$RITEDRUG(.PSSDRUGS,PSSCOUNT)
 . QUIT
 ;
 QUIT PSSXML
 ;;
RITEDRUG(PSSDRUGS,PSSCOUNT) ;
 ; @DESC Builds a single drug xml element
 ;
 ; @PSSDRUGS A handle to the drug object
 ; @PSSCOUNT The counter where the information should be taken from
 ;
 ; @RETURNS An PSSXML string representing a single drug
 ;
 NEW PSS,PSSXML,PSSORDR
 ;
 IF $DATA(PSSDRUGS("DRUG",PSSCOUNT,"drugName")) DO
 . SET PSS("drugName")=$$ATRIBUTE^PSSHRCOM("drugName",PSSDRUGS("DRUG",PSSCOUNT,"drugName"))
 ;
 SET PSS("gcnSeqNo")=$$ATRIBUTE^PSSHRCOM("gcnSeqNo",PSSDRUGS("DRUG",PSSCOUNT,"gcn"))
 ;
 SET PSS("ien")=$$ATRIBUTE^PSSHRCOM("ien",PSSDRUGS("DRUG",PSSCOUNT,"ien"))
 ;
 ; Concatenate the orderNumber, cprs order number, and package
 ; ex. orderNumber|cprsOrderNumber|package
 SET PSSORDR=PSSDRUGS("DRUG",PSSCOUNT,"orderNumber")_"|"_$GET(PSSDRUGS("DRUG",PSSCOUNT,"cprsOrderNumber"))_"|"_$GET(PSSDRUGS("DRUG",PSSCOUNT,"package"))
 ;
 SET PSS("orderNumber")=$$ATRIBUTE^PSSHRCOM("orderNumber",PSSORDR)
 ;
 ; vuid is optional
 IF $DATA(PSSDRUGS("DRUG",PSSCOUNT,"vuid")) DO
 . SET PSS("vuid")=$$ATRIBUTE^PSSHRCOM("vuid",PSSDRUGS("DRUG",PSSCOUNT,"vuid"))
 ;
 SET PSSXML="<drug "_PSS("drugName")_" "_PSS("gcnSeqNo")_" "_PSS("ien")_" "_PSS("orderNumber")_" "_PSS("vuid")_" >"
 SET PSSXML=PSSXML_$$RITEDOSE(.PSSDRUGS,PSSCOUNT)
 SET PSSXML=PSSXML_"</drug>"
 ;
 QUIT PSSXML
 ;;
READDOSE(PSSBASE,PSSHASH,PSSCOUNT,ORDRNM) ;
 ; @DESC Sets the individual drugDose elements, including all dosing amounts,
 ; frequency, etc for an individual drug.
 ;
 ; @DOSE A handle to the drug dose you want to turn into PSSXML
 ;
 ; @RETURNS Nothing, values stored in hash
 ;
 NEW PSS
 ;
 ; If no drug dose information exist for the drug quit
 IF $DATA(^TMP($JOB,PSSBASE,"IN","DOSE",ORDRNM))=0 SET PSSHASH("DRUG",PSSCOUNT,"hasDose")=0
 IF $DATA(^TMP($JOB,PSSBASE,"IN","DOSE",ORDRNM))=0 QUIT
 IF $DATA(^TMP($JOB,PSSBASE,"IN","DOSE",ORDRNM))>0 SET PSSHASH("DRUG",PSSCOUNT,"hasDose")=1
 ;
 SET PSS("value")=$GET(^TMP($JOB,PSSBASE,"IN","DOSE",ORDRNM))
 ; If specific get values (doseAmount,doseUnit,doseRate,frequency,
 ; duration,durationRate,medicalRoute,doseType)
 SET PSSHASH("DRUG",PSSCOUNT,"doseAmount")=$PIECE(PSS("value"),"^",5)
 SET PSSHASH("DRUG",PSSCOUNT,"doseUnit")=$PIECE(PSS("value"),"^",6)
 SET PSSHASH("DRUG",PSSCOUNT,"doseRate")=$PIECE(PSS("value"),"^",7)
 SET PSSHASH("DRUG",PSSCOUNT,"frequency")=$PIECE(PSS("value"),"^",8)
 SET PSSHASH("DRUG",PSSCOUNT,"duration")=$PIECE(PSS("value"),"^",9)
 SET PSSHASH("DRUG",PSSCOUNT,"durationRate")=$PIECE(PSS("value"),"^",10)
 SET PSSHASH("DRUG",PSSCOUNT,"route")=$PIECE(PSS("value"),"^",11)
 SET PSSHASH("DRUG",PSSCOUNT,"doseType")=$PIECE(PSS("value"),"^",12)
 QUIT
 ;;
RITEDOSE(PSSHASH,I) ;
 ; @DESC Writes the doseInformation PSSXML element
 ;
 ; @PSSHASH Hash value with variables used to create element
 ;
 ; @RETURNS A valid drugDose XML element
 ;
 NEW PSSXML
 ;
 SET PSSXML=""
 IF +$GET(PSSHASH("DRUG",I,"hasDose"))=0 QUIT PSSXML
 ;
 ; Create dose information
 SET PSSXML="<doseInformation>"
 SET PSSXML=PSSXML_"<doseType>"_PSSHASH("DRUG",I,"doseType")_"</doseType>"
 SET PSSXML=PSSXML_"<doseAmount>"_PSSHASH("DRUG",I,"doseAmount")_"</doseAmount>"
 SET PSSXML=PSSXML_"<doseUnit>"_PSSHASH("DRUG",I,"doseUnit")_"</doseUnit>"
 SET PSSXML=PSSXML_"<doseRate>"_PSSHASH("DRUG",I,"doseRate")_"</doseRate>"
 I $L(PSSHASH("DRUG",I,"frequency")) SET PSSXML=PSSXML_"<frequency>"_PSSHASH("DRUG",I,"frequency")_"</frequency>"
 I $L(PSSHASH("DRUG",I,"duration")) SET PSSXML=PSSXML_"<duration>"_PSSHASH("DRUG",I,"duration")_"</duration>"
 I $L(PSSHASH("DRUG",I,"durationRate")) SET PSSXML=PSSXML_"<durationRate>"_PSSHASH("DRUG",I,"durationRate")_"</durationRate>"
 SET PSSXML=PSSXML_"<route>"_PSSHASH("DRUG",I,"route")_"</route>"
 ;
 ; Close off dose information
 SET PSSXML=PSSXML_"</doseInformation>"
 ;
 QUIT PSSXML
 ;;
