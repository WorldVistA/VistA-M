ORRDI1 ;SLC/JMH - RDI routines for API supporting CDS data; 3/24/05 2:31 [8/11/05 6:25am] ;11/02/10  05:11
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**232,294**;Dec 17, 1997;Build 27
 ;
GET(DFN,DOMAIN) ;API for packages to call in order to get data from HDR for
 I '$L($G(DOMAIN)) S DOMAIN="ART"
 ; check if in OUTAGE state and quit if so
 I $$DOWNXVAL^ORRDI2 D  Q -1
 .K ^XTMP("ORRDI",DOMAIN,DFN)
 .S ^XTMP("ORRDI",DOMAIN,DFN,0)="^^-1"
 ;  order checking purposes
 N I,ORCACHE,ORRET,ORRECDT
 ;check if data was just retrieved a short time ago and if so return
 S ORRECDT=$P($G(^XTMP("ORRDI",DOMAIN,DFN,0)),U) I 'ORRECDT S ORRECDT=3000101
 S ORCACHE=$$GET^XPAR("SYS","OR RDI CACHE TIME")
 I $$FMDIFF^XLFDT($$NOW^XLFDT,ORRECDT,2)<(60*ORCACHE),$P(^XTMP("ORRDI",DOMAIN,DFN,0),U,3)>-1 S ORRET=$P(^XTMP("ORRDI",DOMAIN,DFN,0),U,3)
 ;check if there has been an HDR down condition within last minute
 I $$FMDIFF^XLFDT($$NOW^XLFDT,$P($G(^XTMP("ORRDI","PSOO",DFN,0)),U),2)<60,$P($G(^XTMP("ORRDI","PSOO",DFN,0)),U,3)<0 S ORRET=$P($G(^XTMP("ORRDI","PSOO",DFN,0)),U,3)
 I $$FMDIFF^XLFDT($$NOW^XLFDT,$P($G(^XTMP("ORRDI","ART",DFN,0)),U),2)<60,$P($G(^XTMP("ORRDI","ART",DFN,0)),U,3)<0 S ORRET=$P($G(^XTMP("ORRDI","ART",DFN,0)),U,3)
 ;if data is not "fresh" then go get it
 I '$L($G(ORRET)) D
 .S ORRET=$$RETRIEVE(DFN,DOMAIN)
 .I ORRET>-1 S ^XTMP("ORRDI","OUTAGE INFO","FAILURES")=0
 .I ORRET'>-1 D
 ..Q:$P(ORRET,U,2)="PATIENT ICN NOT FOUND"
 ..I ORRET=-9 S ORRET="-1^PROCESSING ERROR" Q
 ..S ^XTMP("ORRDI","OUTAGE INFO","FAILURES")=$$FAILXVAL^ORRDI2+1
 ..I $$FAILXVAL^ORRDI2'<$$FAILPVAL^ORRDI2 D
 ...S ^XTMP("ORRDI","OUTAGE INFO","DOWN")=1
 ...D SPAWN^ORRDI2
 S $P(^XTMP("ORRDI",DOMAIN,DFN,0),U,3,4)=ORRET
 I ORRET<1 D
 .N TEMP S TEMP=^XTMP("ORRDI",DOMAIN,DFN,0)
 .K ^XTMP("ORRDI",DOMAIN,DFN)
 .S ^XTMP("ORRDI",DOMAIN,DFN,0)=TEMP
 Q ORRET
 ;
RETRIEVE(DFN,DOMAIN) ;GET DATA
 N $ES,$ET
 S $ET="D ERRHNDL^ORRDI1(DFN) Q -1"
 N Y,ORCSTART,ORPSTART,ORCDIF,ORPDIF,ORALNUM,ORPSNUM,ORREQ,ORXML,ORERR,ORRET,ORY,START,FACIL
 K ^TMP($J,"ORRDI")
 S ORY=-1
 I '$L($G(DOMAIN)) S DOMAIN="ART"
 ;GET ICN
 D SELECT^ORWPT(.Y,DFN)
 N ICN
 S ICN=$P($G(Y),U,14)
 ;S ICN=1012121837; 1011232216; 1012121837 ;1011232216 ;1011226464 ;1011230043 ;1011220270 ;1011218227 ;1003979135 ;1011186582 ;1011117226 ;REMOVE OR COMMENT WHEN DONE
 I 'ICN Q -1_"^PATIENT ICN NOT FOUND"
 S START=$$FMADD^XLFDT($P($$NOW^XLFDT,"."),-30)
 S START=$$FMTHL7^XLFDT(START)
 S START=$E(START,1,4)_"-"_$E(START,5,6)_"-"_$E(START,7,8)
 S FACIL=$P($$SITE^VASITE,U,3)
 ;format request XML
 S ORREQ="/readClinicalData1?&templateId=RDIIntoleranceConditionPharmacyRead40010&"
 S ORREQ=ORREQ_"filterRequest=<?xml version=""1.0"" encoding=""UTF-8""?><filter:filter vhimVersion=""Vhim_4_00"" xmlns:f"
 S ORREQ=ORREQ_"ilter=""Filter"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""><filterId>RDI_IC_RX_SINGLE_PATIENT_FILTER</fil"
 S ORREQ=ORREQ_"terId><patients><NationalId>"_ICN_"</NationalId><excludeIdentifiers><assigningAuthority"
 S ORREQ=ORREQ_">USVHA</assigningAuthority><assigningFacility>"_FACIL_"</assigningFacility></excludeIdentifiers></patien"
 S ORREQ=ORREQ_"ts><entryPointFilter queryName=""IC-Standardized""><domainEntryPoint>IntoleranceCondition</domainEnt"
 S ORREQ=ORREQ_"ryPoint><xpathQuery><xpath>intoleranceConditions[((gmrAllergyAgent[(code!='') and (codingSystem = '99"
 S ORREQ=ORREQ_"VHA_ERT' or contains(.,'99VA'))]) or (drugClass/code[(code!='') and (codingSystem = '99VHA_ERT' or co"
 S ORREQ=ORREQ_"ntains(.,'99VA'))]) or (drugIngredient/code[(code!='') and (codingSystem = '99VHA_ERT' or contain"
 S ORREQ=ORREQ_"s(.,'99VA'))])) and (status = 'F')]</xpath></xpathQuery></entryPointFilter><entryPointFilter queryNa"
 S ORREQ=ORREQ_"me=""OMP-Standardized""><domainEntryPoint>OutpatientMedicationPromise</domainEntryPoint>"
 S ORREQ=ORREQ_"<startDate>"_START_"</startDate><xpathQuery><xpath>outpatientMedicationPromises[pharmacyRe"
 S ORREQ=ORREQ_"quest/orderedMedication/medicationCode[(code!='') and (codingSystem = '99VHA_ERT' or contain"
 S ORREQ=ORREQ_"s(.,'99VA'))]]</xpath></xpathQuery></entryPointFilter></filter:filter>&filterId=RDI_IC_RX_SINGLE_PATIENT_FILTER&re"
 S ORCSTART=$ZH
 S ORREQ=ORREQ_"questId="_FACIL_"RDI"_$$NOW^XLFDT_";"_ORCSTART
 ;make call to HDR
 ;ZW ORREQ
 S ORXML=$$GETREST^XOBWLIB("CDS WEB SERVICE","CDS SERVER")
 S ORRET=$$GET^XOBWLIB(ORXML,ORREQ,.ORERR,0)
 S ORCDIF=$ZH-ORCSTART
 I ORRET D  Q ORY
 .;parse out xml into temp global
 .S ORPSTART=$ZH
 .D PARSE(ORXML.HttpResponse.Data)
 .S ORPDIF=$ZH-ORCSTART-ORCDIF
 .;I $D(^TMP($J,"ORRDI","ClinicalData",0,"errorSection")) S ORY="-1^CDS ERROR" D  Q
 .;.S ^XTMP("ORRDI","METRICS",ORCSTART)=DFN_U_ORCDIF_U_ORPDIF_U
 .;move from temp global into ^XTMP("ORRDI" domain globals
 .S ORALNUM=$$AL(DFN)
 .S ORPSNUM=$$PS(DFN)
 .S ^XTMP("ORRDI","ART",DFN,0)=$$NOW^XLFDT_U_U_ORALNUM
 .S ^XTMP("ORRDI","PSOO",DFN,0)=$$NOW^XLFDT_U_U_ORPSNUM
 .S ^XTMP("ORRDI",0)=$$FMADD^XLFDT($$NOW^XLFDT,2)_U_$$NOW^XLFDT
 .I DOMAIN="ART" S ORY=ORALNUM
 .I DOMAIN="PSOO" S ORY=ORPSNUM
 .I +ORY>-1 S ^XTMP("ORRDI","TESTREQ")=ORREQ
 .;set metrics for data retrieval and parsing
 .S ^XTMP("ORRDI","METRICS",$$NOW^XLFDT,ORCSTART)=DFN_U_ORCDIF_U_ORPDIF_U_ORALNUM_U_ORPSNUM
 .;ZW ^TMP($J,"ORRDI") ;REMOVE OR COMMENT WHEN DONE
 .K ^TMP($J,"ORRDI")
 I 'ORRET!(ORERR) S ^XTMP("ORRDI","METRICS",$$NOW^XLFDT,ORCSTART)=DFN_U_"ERROR" D  Q "-1^"_ORERR
 .S ^XTMP("ORRDI","ART",DFN,0)=U_U_"-1^"_ORERR
 .S ^XTMP("ORRDI","PSOO",DFN,0)=U_U_"-1^"_ORERR
RETQ Q -1
 ;
PS(DFN) ;expects ^TMP($J,"ORRDI")
 K ^XTMP("ORRDI","PSOO",DFN)
 N ORQ S ORQ=$$MSGERR Q:($L(ORQ)>0) -1_U_ORQ
 N I,GL,CNT
 S CNT=0,GL=$NA(^TMP($J,"ORRDI","ClinicalData",0,"patient",0,"outpatientMedicationPromises"))
 S I="" F  S I=$O(@GL@(I)) Q:'$L(I)  D
 .S CNT=CNT+1
 .S ^XTMP("ORRDI","PSOO",DFN,I+1,1,0)=$G(@GL@(I,"pharmacyRequest",0,"orderingInstitutionIdentifier",0,"name",0))
 .S ^XTMP("ORRDI","PSOO",DFN,I+1,2,0)=$G(@GL@(I,"pharmacyRequest",0,"orderedMedication",0,"medicationCode",0,"displayText",0))
 .S ^XTMP("ORRDI","PSOO",DFN,I+1,3,0)=$G(@GL@(I,"pharmacyRequest",0,"orderedMedication",0,"medicationCode",0,"code",0))
 .S ^XTMP("ORRDI","PSOO",DFN,I+1,4,0)=$G(@GL@(I,"prescriptionId",0))
 .S ^XTMP("ORRDI","PSOO",DFN,I+1,5,0)=$G(@GL@(I,"pharmacyRequest",0,"statusModifier",0,"displayText",0))
 .S ^XTMP("ORRDI","PSOO",DFN,I+1,6,0)=$G(@GL@(I,"originalDispense",0,"quantityDispensed",0,"value",0))_";"_$G(@GL@(I,"originalDispense",0,"daysSupply",0))
 .S ^XTMP("ORRDI","PSOO",DFN,I+1,7,0)=$$DTCONV($G(@GL@(I,"expirationDate",0,"literal",0)))
 .S ^XTMP("ORRDI","PSOO",DFN,I+1,8,0)=$$DTCONV($G(@GL@(I,"pharmacyRequest",0,"orderDate",0,"literal",0)))
 .N K S K="" F  S K=$O(@GL@(I,"refillDispense",K)) Q:'$L(K)  D
 ..I $G(@GL@(I,"refillDispense",K,"fillDate",0,"literal",0)) D
 ...S ^XTMP("ORRDI","PSOO",DFN,I+1,9,0)=$$DTCONV($G(@GL@(I,"refillDispense",K,"fillDate",0,"literal",0)))
 .I '$G(^XTMP("ORRDI","PSOO",DFN,I+1,9,0)) S ^XTMP("ORRDI","PSOO",DFN,I+1,9,0)=$$DTCONV($G(@GL@(I,"originalDispense",0,"fillDate",0,"literal",0)))
 .S ^XTMP("ORRDI","PSOO",DFN,I+1,10,0)=$G(@GL@(I,"numberOfRefillsAuthorized",0))
 .S ^XTMP("ORRDI","PSOO",DFN,I+1,11,0)=$G(@GL@(I,"originalDispense",0,"currentProvider",0,"name",0,"family",0))_","_$G(@GL@(I,"originalDispense",0,"currentProvider",0,"name",0,"given",0))
 .S ^XTMP("ORRDI","PSOO",DFN,I+1,12,0)=$G(@GL@(I,"originalDispense",0,"dispensedDrug",0,"drugUnitPrice",0,"value",0))
 .N L S L="" F  S L=$O(@GL@(I,"sig",L)) Q:'$L(L)  S ^XTMP("ORRDI","PSOO",DFN,I+1,14,0)=$G(^XTMP("ORRDI","PSOO",DFN,I+1,14,0))_" "_$G(@GL@(I,"sig",L))
 .I '$D(^XTMP("ORRDI","PSOO",DFN,I+1,14,0)) S ^XTMP("ORRDI","PSOO",DFN,I+1,14,0)=""
 .;S ^XTMP("ORRDI","PSOO",DFN,I+1,14,0)=$G(@GL@(I,"sig",0))
 Q CNT
 ;
AL(DFN) ;expects ^TMP($J,"ORRDI")
 K ^XTMP("ORRDI","ART",DFN)
 N ORQ S ORQ=$$MSGERR Q:($L(ORQ)>0) -1_U_ORQ
 N I,GL,CNT
 S CNT=0,GL=$NA(^TMP($J,"ORRDI","ClinicalData",0,"patient",0,"intoleranceConditions"))
 S I="" F  S I=$O(@GL@(I)) Q:'$L(I)  D
 .S CNT=CNT+1
 .S ^XTMP("ORRDI","ART",DFN,I+1,"FACILITY",0)=$G(@GL@(I,"facilityIdentifier",0,"name",0))
 .I $G(@GL@(I,"gmrAllergyAgent",0,"code",0)),$E($G(@GL@(I,"gmrAllergyAgent",0,"codingSystem",0)),1,4)="99VA" D
 ..S ^XTMP("ORRDI","ART",DFN,I+1,"REACTANT",0)=@GL@(I,"gmrAllergyAgent",0,"code",0)_U_@GL@(I,"gmrAllergyAgent",0,"displayText",0)_U_@GL@(I,"gmrAllergyAgent",0,"codingSystem",0)
 .I $D(@GL@(I,"drugIngredient")) D
 ..N J S J="" F  S J=$O(@GL@(I,"drugIngredient",J))  Q:'$L(J)  D
 ...I $G(@GL@(I,"drugIngredient",J,"code",0,"code",0)),$E($G(@GL@(I,"drugIngredient",J,"code",0,"codingSystem",0)),1,4)="99VA" D
 ....S ^XTMP("ORRDI","ART",DFN,I+1,"DRUG INGREDIENTS",J+1)=@GL@(I,"drugIngredient",J,"code",0,"code",0)_U_@GL@(I,"drugIngredient",J,"code",0,"displayText",0)_U_@GL@(I,"drugIngredient",J,"code",0,"codingSystem",0)
 .I $D(@GL@(I,"drugClass")) D
 ..N J S J="" F  S J=$O(@GL@(I,"drugClass",J))  Q:'$L(J)  D
 ...I $G(@GL@(I,"drugClass",0,"code",0,"code",0)),$E($G(@GL@(I,"drugClass",0,"code",0,"codingSystem",0)),1,10)="99VA50.605" D
 ....S ^XTMP("ORRDI","ART",DFN,I+1,"DRUG CLASSES",J+1)=@GL@(I,"drugClass",J,"code",0,"alternateCode",0)_U_@GL@(I,"drugClass",J,"code",0,"alternateCode",0)
 ....S ^XTMP("ORRDI","ART",DFN,I+1,"DRUG CLASSES",J+1)=^XTMP("ORRDI","ART",DFN,I+1,"DRUG CLASSES",J+1)_U_@GL@(I,"drugClass",J,"code",0,"codingSystem",0)_U_@GL@(I,"drugClass",J,"code",0,"displayText",0)
 Q CNT
 ;
HAVEHDR() ;call to check if this system has an HDR to perform order checks
 ;  against
 ;check parameter to see if there is an HDR and returns positive if so
 I $$GET^XPAR("SYS","OR RDI HAVE HDR") Q 1
 ;returns negative because the parameter indicates there is no HDR
 Q 0
 ;
DTCONV(DATE) ;convert date in hl7 format to mm/dd/yy
 I '$L(DATE) Q ""
 Q $E(DATE,5,6)_"/"_$E(DATE,7,8)_"/"_$E(DATE,3,4)
 ;
REMESC(ORSTR) ;
 ; Remove Escape Characters from HL7 Message Text
 ; Escape Sequence codes:
 ;         F = field separator (ORFS)
 ;         S = component separator (ORCS)
 ;         R = repetition separator (ORRS)
 ;         E = escape character (ORES)
 ;         T = subcomponent separator (ORSS)
 N ORCHR,ORREP,I1,I2,J1,J2,K,VALUE
 F ORCHR="F","S","R","E","T" S ORREP(ORES_ORCHR_ORES)=$S(ORCHR="F":ORFS,ORCHR="S":ORCS,ORCHR="R":ORRS,ORCHR="E":ORES,ORCHR="T":ORSS)
 S ORSTR=$$REPLACE^XLFSTR(ORSTR,.ORREP)
 F  S I1=$P(ORSTR,ORES_"X") Q:$L(I1)=$L(ORSTR)  D
 .S I2=$P(ORSTR,ORES_"X",2,99)
 .S J1=$P(I2,ORES) Q:'$L(J1)
 .S J2=$P(I2,ORES,2,99)
 .S VALUE=$$BASE^XLFUTL($$UP^XLFSTR(J1),16,10)
 .S K=$S(VALUE>255:"?",VALUE<32!(VALUE>127&(VALUE<160)):"",1:$C(VALUE))
 .S ORSTR=I1_K_J2
 Q ORSTR
 ;
PARSE(STREAM) ;
 N %XML,GL
 S GL=$NA(^TMP($J,"ORRDI"))
 K @GL
 N STATUS,READER,XOBERR,S
 ;S STATUS=##class(%XML.TextReader).ParseStream(STREAM,.READER)
 S STATUS=##class(%XML.TextReader).ParseStream(STREAM,.READER,,,,,1)
 I $$STATCHK^XOBWLIB(STATUS,.XOBERR,1) D
 .N BREAK
 .S BREAK=0 F  Q:BREAK||READER.EOF||'READER.Read()  D
 ..N X
 ..I READER.NodeType="element" D SPUSH(.S,READER.LocalName)
 ..I READER.NodeType="endelement" D SPOP(.S,.X)
 ..I READER.NodeType="chars" D SPUT(.S,READER.Value)
 Q
 ;
SPUSH(S,X) ;places X on the stack S and returns the current level of the stack
 N I S I=$O(S(""),-1)+1,S(I)=X
 Q I
 ;
SPOP(S,X) ;removes the top item from the stack S and put it into the variable X and returns the level that X was at
 N I S I=$O(S(""),-1)
 I I S X=S(I) K S(I)
 N J S J=$O(S(I),-1) I J S S(J,X)=$G(S(J,X))+1
 Q I
 ;
SPEEK(S,X) ;same as SPOP except the top item is not removed
 N I S I=$O(S(""),-1)
 I I S X=S(I)
 Q I
 ;
SPUT(S,X) ;implementation specific, uses the stack to form a global node
 N I,STR
 S STR=$P(GL,")")
 S I=0 F  S I=$O(S(I)) Q:'I  D
 .S STR=STR_","_""""_S(I)_""""_","
 .N NUM S NUM=0
 .I $D(S(I-1,S(I))) S NUM=+$G(S(I-1,S(I)))
 .S STR=STR_NUM
 S STR=STR_")"
 I $D(@STR) S @STR=@STR_X
 I '$D(@STR) S @STR=X
 Q STR
 ;
MSGERR() ;check errors from XML return
 ;returns empty string "" if there was no error
 ;returns empty string "" if the only error was "ALL_PATIENT_IDS_EXCLUDED"
 ;otherwise returns the exceptionMessage string from the errorSection
 N ORRET S ORRET=""
 I $D(^TMP($J,"ORRDI","ClinicalData",0,"errorSection")) D
 .N I F I="fatalErrors","errors","warnings" D
 ..N J S J="" F  S J=$O(^TMP($J,"ORRDI","ClinicalData",0,"errorSection",0,I,J)) Q:J=""  D
 ...N ORSTR S ORSTR=$G(^TMP($J,"ORRDI","ClinicalData",0,"errorSection",0,I,J,"errorCode",0))
 ...I ORSTR'="ALL_PATIENT_IDS_EXCLUDED" S ORRET=ORSTR
 Q ORRET
ERRHNDL(DFN) ;handle any errors that may get thrown in call to GET^ORRDI1
 K ^TMP($J,"ORRDI"),^XTMP("ORRDI","PSOO",DFN),^XTMP("ORRDI","ART",DFN)
 D UNWIND^%ZTER
 Q
