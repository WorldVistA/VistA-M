PSOERXIE ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**581,617**;DEC 1997;Build 110
 ;
 Q
MEDS(ERXIEN,MTYPE,MEDTYPE) ; medication prescribed/dispensed/requested segment
 N GL,I,SEQUENCE,DRUGDESC,DCPC,DCPQ,STRVAL,STRFORM,STRUOM,DEA,DCDBC,DCDBQ,CODELQ,QUOM,QVAL,DAYS,WDATE,LASTFD,SUBS,NUMREF,PHARMREF
 N PAUTH,NOTE,PASTAT,DNF,TZDQ,TZI,OCM,SUBREA,SPSCRIPT,RXI,OPAFFAIR,DELLOC,DELREQ,HASDEV,INSDEP,SUPPIND,RESTFREQ,FREQNOTE,INJREL,TREATIND,POE
 N CTC,NUMCYCLE,PRESREMS,REMSNUM,REMSCAT,FLAVREQ,NUMPDISP,PSP,PROVAUTH,NOLATER,NOLAREAS,PLOSAD,PROVAUTH,NMIEN,MIEN,SF,INMTYPE,F,TESTFREQ,RESPNOTE
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE))
 S I=-1,F=52.49,SF=52.49311,SEQUENCE=0
 S INMTYPE=$S(MEDTYPE="MedicationPrescribed":"P",MEDTYPE="MedicationDispensed":"D",MEDTYPE="MedicationRequested":"R",MEDTYPE="MedicationResponse":"MR",1:"")
 Q:INMTYPE=""
 F  S I=$O(@GL@(I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S DRUGDESC=$G(@GL@(I,"DrugDescription",0))
 .S DCPC=$G(@GL@(I,"DrugCoded",0,"ProductCode",0,"Code",0))
 .S DCPQ=$G(@GL@(I,"DrugCoded",0,"ProductCode",0,"Qualifier",0))
 .S STRVAL=$G(@GL@(I,"DrugCoded",0,"Strength",0,"StrengthValue",0))
 .S STRFORM=$G(@GL@(I,"DrugCoded",0,"Strength",0,"StrengthForm",0,"Code",0))
 .S STRUOM=$G(@GL@(I,"DrugCoded",0,"Strength",0,"StrengthUnitOfMeasure",0,"Code",0))
 .S DEA=$G(@GL@(I,"DrugCoded",0,"DEASchedule",0,"Code",0))
 .S DCDBC=$G(@GL@(I,"DrugCoded",0,"DrugDBCode",0,"Code",0))
 .S DCDBQ=$G(@GL@(I,"DrugCoded",0,"DrugDBCode",0,"Qualifier",0))
 .S CODELQ=$G(@GL@(I,"Quantity",0,"CodeListQualifier",0))
 .S QUOM=$G(@GL@(I,"Quantity",0,"QuantityUnitOfMeasure",0,"Code",0))
 .S QVAL=$G(@GL@(I,"Quantity",0,"Value",0))
 .S DAYS=$G(@GL@(I,"DaysSupply",0))
 .S WDATE=$G(@GL@(I,"WrittenDate",0,"Date",0))
 .I '$L(WDATE) S WDATE=$G(@GL@(I,"WrittenDate",0,"DateTime",0))
 .S WDATE=$$CONVDTTM^PSOERXA1(WDATE)
 .S LASTFD=$G(@GL@(I,"LastFillDate",0,"Date",0))
 .I '$L(LASTFD) S LASTFD=$G(@GL@(I,"LastFillDate",0,"DateTime",0))
 .S LASTFD=$$CONVDTTM^PSOERXA1(LASTFD)
 .S SUBS=$G(@GL@(I,"Substitutions",0))
 .S NUMREF=$G(@GL@(I,"NumberOfRefills",0))
 .S PAUTH=$G(@GL@(I,"PriorAuthorization",0))
 .S NOTE=$G(@GL@(I,"Note",0))
 .S PASTAT=$G(@GL@(I,"PriorAuthorizationStatus",0))
 .; next 2 fields are for a renewal request/medication dispensed, 
 .S PHARMREF=$G(@GL@(I,"PharmacyRequestedRefills",0))
 .S RESPNOTE=$G(@GL@(I,"Replace",0,"Note",0)) ; filing replace response note
 .S DNF=$G(@GL@(I,"DoNotFill",0))
 .S TZDQ=$G(@GL@(I,"TimeZone",0,"TimeZoneDifferenceQuantity",0))
 .S TZI=$G(@GL@(I,"TimeZone",0,"TimeZoneIdentifier",0))
 .S OCM=$G(@GL@(I,"OrderCaptureMethod",0))
 .S SUBREA=$G(@GL@(I,"ReasonForSubstitutionCodeUsed",0))
 .S SPSCRIPT=$G(@GL@(I,"SplitScript",0))
 .S RXI=$G(@GL@(I,"RxFillIndicator",0))
 .S OPAFFAIR=$G(@GL@(I,"OfficeOfPharmacyAffairsID",0)) ;***BUILD FUNCTION
 .S DELLOC=$G(@GL@(I,"DeliveryLocation",0))
 .S DELREQ=$G(@GL@(I,"DeliveryRequest",0))
 .S HASDEV=$G(@GL@(I,"DiabeticSupply",0,"HasAutomatedInsulinDevice",0))
 .S INSDEP=$G(@GL@(I,"DiabeticSupply",0,"InsulinDependent",0))
 .S SUPPIND=$G(@GL@(I,"DiabeticSupply",0,"SupplyIndicator",0))
 .S TESTFREQ=$G(@GL@(I,"DiabeticSupply",0,"TestingFrequency",0))
 .S FREQNOTE=$G(@GL@(I,"DiabeticSupply",0,"TestingFrequencyNotes",0))
 .S INJREL=$G(@GL@(I,"InjuryRelated",0))
 .S TREATIND=$G(@GL@(I,"TreatmentIndicator",0))
 .S POE=$G(@GL@(I,"ProphylacticOrEpisodic",0))
 .S CTC=$G(@GL@(I,"CurrentTreatmentCycle",0))
 .S NUMCYCLE=$G(@GL@(I,"NumberOfCyclesPlanned",0))
 .S PRESREMS=$G(@GL@(I,"PrescriberCheckedREMS",0))
 .S REMSNUM=$G(@GL@(I,"REMSAuthorizationNumber",0))
 .S REMSCAT=$G(@GL@(I,"REMSPatientRiskCategory",0))
 .;S PHARMTIT=$G(@GL@; dont see in XSD
 .S FLAVREQ=$G(@GL@(I,"FlavoringRequested",0))
 .S NUMPDISP=$G(@GL@(I,"NumberOfPackagesToBeDispensed",0))
 .S PSP=$G(@GL@(I,"PlaceOfServiceNonSelfAdministeredProduct",0))
 .S PROVAUTH=$G(@GL@(I,"ProviderExplicitAuthorizationToAdminister",0))
 .S NOLATER=$G(@GL@(I,"NeedNoLaterThan",0,"NeededNoLaterThanDate",0))
 .S NOLATER=$$CONVDTTM^PSOERXA1(NOLATER)
 .S NOLAREAS=$G(@GL@(I,"NeedNoLaterThan",0,"NeededNoLaterThanReason",0)) ; ***this appears to be a multiple in the XSD....talk to Brad about this one***
 .S PLOSAD=$G(@GL@(I,"PlaceOfServiceNonSelfAdministeredProduct",0))
 .S PROVAUTH=$G(@GL@(I,"ProviderExplicitAuthorizationToAdminister",0))
 .S IENS="+"_SEQUENCE_","_ERXIEN_","
 .; sequence, medication type, drug description
 .S FDA(SF,IENS,.01)=SEQUENCE,FDA(SF,IENS,.02)=INMTYPE,FDA(SF,IENS,.03)=DRUGDESC
 .; dc product code, product code qualifier
 .S DCPQ=$$PRESOLV^PSOERXA1(DCPQ,"PQC")
 .S FDA(SF,IENS,1.1)=DCPC,FDA(SF,IENS,1.2)=DCPQ
 .; strength value, strength form, strength unit of measure
 .S STRFORM=$$PRESOLV^PSOERXA1(STRFORM,"NCI") ; resolving pointer
 .S STRUOM=$$PRESOLV^PSOERXA1(STRUOM,"NCI") ; resolving pointer
 .S FDA(SF,IENS,1.3)=STRVAL,FDA(SF,IENS,1.4)=STRFORM,FDA(SF,IENS,1.5)=STRUOM
 .; dc drug db code, dc drug db qual, dc dea
 .S DCDBQ=$$PRESOLV^PSOERXA1(DCDBQ,"DDB")
 .S DEA=$$PRESOLV^PSOERXA1(DEA,"NCI")
 .S FDA(SF,IENS,1.6)=DCDBC,FDA(SF,IENS,1.7)=DCDBQ,FDA(SF,IENS,1.8)=DEA
 .; quantity value quantity codelist qual, quantity unit of measure
 .S CODELQ=$$PRESOLV^PSOERXA1(CODELQ,"QCQ")
 .S QUOM=$$PRESOLV^PSOERXA1(QUOM,"NCI")
 .S FDA(SF,IENS,2.1)=QVAL,FDA(SF,IENS,2.2)=CODELQ,FDA(SF,IENS,2.3)=QUOM
 .; days supply, written date, last fill date
 .S FDA(SF,IENS,2.4)=DAYS,FDA(SF,IENS,2.5)=WDATE,FDA(SF,IENS,2.6)=LASTFD
 .; susbstitutions, number of refills
 .S FDA(SF,IENS,2.7)=SUBS,FDA(SF,IENS,2.8)=NUMREF
 .; prior authroization, prior authorization status, note, pharmacy requested refills, reason for substitution
 .S FDA(SF,IENS,4.1)=PAUTH,FDA(SF,IENS,4.2)=PASTAT,FDA(SF,IENS,5)=NOTE
 .S FDA(SF,IENS,4.3)=PHARMREF
 .; do not fill, time zone identifier, time zone diff qty
 .S FDA(SF,IENS,16.1)=DNF,FDA(SF,IENS,16.2)=TZI,FDA(SF,IENS,16.3)=TZDQ
 .; order capture method, reason for substitutions, split script, rx fill indicator
 .S FDA(SF,IENS,16.4)=OCM,FDA(SF,IENS,16.5)=SUBREA,FDA(SF,IENS,16.6)=SPSCRIPT,FDA(SF,IENS,16.7)=RXI
 .; delivery request, delivery location
 .S FDA(SF,IENS,18.1)=DELREQ,FDA(SF,IENS,18.2)=DELLOC
 .;diab supply test freq, diav supply indicator, diab insulin dependent, diab has auto device , diab supply freq notes
 .S FDA(SF,IENS,19.1)=TESTFREQ,FDA(SF,IENS,19.2)=SUPPIND,FDA(SF,IENS,19.3)=INSDEP,FDA(SF,IENS,19.4)=HASDEV,FDA(SF,IENS,19.5)=FREQNOTE
 .; injury related, treatment indicator, prophylactiv or episodic, current treatment ccle, number of cycles planned
 .S FDA(SF,IENS,20.1)=INJREL,FDA(SF,IENS,45.1)=TREATIND,FDA(SF,IENS,45.2)=POE,FDA(SF,IENS,45.3)=CTC,FDA(SF,IENS,45.4)=NUMCYCLE
 .; prescriber checked rems, rems patient risk, rems authorization
 .S FDA(SF,IENS,47)=PRESREMS,FDA(SF,IENS,48.1)=REMSCAT,FDA(SF,IENS,48.2)=REMSNUM
 .; flavoring requested, num packages dispensed, need no later than date, need no later than reason
 .S FDA(SF,IENS,55.1)=FLAVREQ,FDA(SF,IENS,58.1)=NUMPDISP,FDA(SF,IENS,63.1)=NOLATER,FDA(SF,IENS,63.2)=NOLAREAS
 .; place of service admin, provider authorization
 .S FDA(SF,IENS,63.3)=PLOSAD,FDA(SF,IENS,63.4)=PROVAUTH
 .D CFDA^PSOERXIU(.FDA)
 .D UPDATE^DIE(,"FDA","NMIEN") K FDA
 .; ALSO filing for old drug fields - only for Medication Prescribed
 .I INMTYPE="P"!(INMTYPE="MR") D
 ..S FDA(52.49,ERXIEN_",",5.1)=QVAL,FDA(52.49,ERXIEN_",",20.1)=QVAL,FDA(52.49,ERXIEN_",",42)=$$GET1^DIQ(52.45,QUOM,.02,"E")
 ..;S FDA(52.49,ERXIEN_",",5.2)=CODELQ
 ..S FDA(52.49,ERXIEN_",",5.4)=$$GET1^DIQ(52.45,QUOM,.02,"E")
 ..S FDA(52.49,ERXIEN_",",3.1)=DRUGDESC,FDA(52.49,ERXIEN_",",8)=NOTE
 ..S FDA(52.49,ERXIEN_",",43)=$$GET1^DIQ(52.45,STRUOM,.02,"E")
 ..I $G(DEA) S FDA(52.49,ERXIEN_",",4.9)=$$GET1^DIQ(52.45,DEA,.01)
 ..I $G(DNF)'="" S FDA(52.49,ERXIEN_",",10.5)=$S(DNF="Y":1,DNF="E":2,DNF="H":3,1:"")
 ..S FDA(52.49,ERXIEN_",",41)=$$GET1^DIQ(52.45,STRFORM,.02,"E")
 ..S FDA(52.49,ERXIEN_",",5.5)=DAYS,FDA(52.49,ERXIEN_",",20.2)=DAYS,FDA(52.49,ERXIEN_",",5.9)=WDATE,FDA(52.49,ERXIEN_",",6.1)=LASTFD
 ..S FDA(52.49,ERXIEN_",",5.8)=SUBS,FDA(52.49,ERXIEN_",",5.6)=NUMREF,FDA(52.49,ERXIEN_",",20.5)=NUMREF,FDA(52.49,ERXIEN_",",52.2)=RESPNOTE
 ..D CFDA^PSOERXIU(.FDA)
 ..D FILE^DIE(,"FDA") K FDA
 .; also file 52.1 with the refills requested value when this is a medication dispensed, and a renewal request
 .I INMTYPE="D",MTYPE="RxRenewalRequest" D
 ..S FDA(52.49,ERXIEN_",",51.2)=PHARMREF
 ..D CFDA^PSOERXIU(.FDA)
 ..D FILE^DIE(,"FDA") K FDA
 .S NMIEN=$O(NMIEN(0)),MIEN=$G(NMIEN(NMIEN))
 .D PHARMID(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parses and files pharmacy affairs data
 .D DIAG(ERXIEN,MIEN,MTYPE,MEDTYPE) ;parses and files diagnosis
 .D DRUGEVAL(ERXIEN,MIEN,MTYPE,MEDTYPE) ;parses and files drug use evaluation segment
 .D DRUGCS(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parses and files drug coverage status data
 .;parse and file the Sig segment
 .D SIG^PSOERXIF(ERXIEN,MIEN,MTYPE,MEDTYPE,I)
 .D AGENCY^PSOERXIG(ERXIEN,MIEN,MTYPE,MEDTYPE) ;parse and file agency data (top level of 311)
 .D IVADMIN^PSOERXIG(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file IV administration data (top level of 311)
 .D WOUND^PSOERXIG(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file wound data
 .D TITRATE^PSOERXIG(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file titration data
 .D COMPOUND^PSOERXIH(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file compound ingredient information
 .D PATNOTES^PSOERXIH(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file patient codified notes
 .D FACTIME^PSOERXIH(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file facility specific hours of administration timing data
 .D OMEDDATE^PSOERXIH(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file other medication date data ; ***ask Brad about date/time, not sure if we need that field
 .K NMIEN,MIEN
 Q
PHARMID(ERXIEN,MIEN,MTYPE,MEDTYPE) ;
 N PGL,I,SF,SEQUENCE,OPAFFAIR,IENS
 S PGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0))
 S I=-1,SEQUENCE=0,SF=52.4931117
 F  S I=$O(@PGL@("OfficeOfPharmacyAffairsID",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S OPAFFAIR=$G(@PGL@("OfficeOfPharmacyAffairsID",I))
 .S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 .; sequence, affair ID
 .S FDA(SF,IENS,.01)=SEQUENCE
 .S FDA(SF,IENS,.02)=OPAFFAIR
 D UPDATE^DIE(,"FDA") K FDA
 Q
DIAG(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file diagnosis data
 N DGL,I,SF,IENS,SEQUENCE,CLIQ,PDC,PDLV,PDD,PDQ,SDC,SDLV,SDD,SDQ,FDA
 S DGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0))
 S I=-1,SF=52.493113,SEQUENCE=0
 F  S I=$O(@DGL@("Diagnosis",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S CLIQ=$G(@DGL@("Diagnosis",I,"ClinicalInformationQualifier",0))
 .S PDC=$G(@DGL@("Diagnosis",I,"Primary",0,"Code",0))
 .S PDLV=$G(@DGL@("Diagnosis",I,"Primary",0,"DateOfLastOfficeVisit",0,"Date",0))
 .I '$L(PDLV) S PDLV=$G(@DGL@("Diagnosis",I,"Primary",0,"DateOfLastOfficeVisit",0,"DateTime",0))
 .S PDLV=$$CONVDTTM^PSOERXA1(PDLV)
 .S PDD=$G(@DGL@("Diagnosis",I,"Primary",0,"Description",0))
 .S PDQ=$G(@DGL@("Diagnosis",I,"Primary",0,"Qualifier",0))
 .S SDC=$G(@DGL@("Diagnosis",I,"Secondary",0,"Code",0))
 .S SDLV=$G(@DGL@("Diagnosis",I,"Secondary",0,"DateOfLastOfficeVisit",0,"Date",0))
 .I '$L(SDLV) S SDLV=$G(@DGL@("Diagnosis",I,"Secondary",0,"DateOfLastOfficeVisit",0,"DateTime",0))
 .S SDLV=$$CONVDTTM^PSOERXA1(SDLV)
 .S SDD=$G(@DGL@("Diagnosis",I,"Secondary",0,"Description",0))
 .S SDQ=$G(@DGL@("Diagnosis",I,"Secondary",0,"Qualifier",0))
 .S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 .; sequence, clinical information qualifier
 .S FDA(SF,IENS,.01)=SEQUENCE,FDA(SF,IENS,.02)=CLIQ
 .; primary diagnosis code, primary diagnosis qualifier, primary office visit date, primary diagnosis description
 .S FDA(SF,IENS,1.1)=PDC,FDA(SF,IENS,1.2)=PDQ,FDA(SF,IENS,1.3)=PDLV,FDA(SF,IENS,2)=PDD
 .; secondary diagnosis code, secondary diagnosis qualifier, secondary office visit date, secondary diagnosis description
 .S FDA(SF,IENS,3.1)=SDC,FDA(SF,IENS,3.2)=SDQ,FDA(SF,IENS,3.3)=SDLV,FDA(SF,IENS,4)=SDD
 D CFDA^PSOERXIU(.FDA)
 D UPDATE^DIE(,"FDA") K FDA
 Q
DRUGEVAL(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file drug use evaluation data
 N DGL,I,SF,IENS,SEQUENCE,ACKR,CSCODE,COAC,COAD,COAQ,PSC,REACODE,RESCODE,FDA
 S DGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0))
 S I=-1,SF=52.493116,SEQUENCE=0
 F  S I=$O(@DGL@("DrugUseEvaluation",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S ACKR=$G(@DGL@("DrugUseEvaluation",I,"AcknowledgementReason",0))
 .S CSCODE=$G(@DGL@("DrugUseEvaluation",I,"ClinicalSignificanceCode",0))
 .S COAC=$G(@DGL@("DrugUseEvaluation",I,"CoAgent",0,"CoAgentCode",0,"Code",0))
 .S COAD=$G(@DGL@("DrugUseEvaluation",I,"CoAgent",0,"CoAgentCode",0,"Description",0))
 .S COAQ=$G(@DGL@("DrugUseEvaluation",I,"CoAgent",0,"CoAgentCode",0,"Qualifier",0))
 .S PSC=$G(@DGL@("DrugUseEvaluation",I,"ProfessionalServiceCode",0))
 .S REACODE=$G(@DGL@("DrugUseEvaluation",I,"ServiceReasonCode",0))
 .S RESCODE=$G(@DGL@("DrugUseEvaluation",I,"ServiceResultCode",0))
 .S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 .; sequence
 .S FDA(SF,IENS,.01)=SEQUENCE
 .; drug use evaluation service reason code, professional service reason code, result code
 .S REACODE=$$PRESOLV^PSOERXA1(REACODE,"REA") ; resolving pointer
 .S PSC=$$PRESOLV^PSOERXA1(PSC,"PSC") ; resolving pointer
 .S RESCODE=$$PRESOLV^PSOERXA1(RESCODE,"RES") ; resolving pointer
 .S FDA(SF,IENS,.02)=REACODE,FDA(SF,IENS,.03)=PSC,FDA(SF,IENS,.04)=RESCODE
 .; drue use evaluation co agent code, co agent qualifier, clinical significance code
 .S COAQ=$$PRESOLV^PSOERXA1(COAQ,"CAQ") ; resolving pointer
 .S FDA(SF,IENS,.05)=COAC,FDA(SF,IENS,.06)=COAQ,FDA(SF,IENS,.07)=CSCODE
 .; drug use evaluation co agent description, acknowledgement reason
 .S FDA(SF,IENS,1)=COAD,FDA(SF,IENS,2)=ACKR
 .D CFDA^PSOERXIU(.FDA)
 .D UPDATE^DIE(,"FDA") K FDA
 Q
DRUGCS(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parsing and filing drug coverage status data
 N CSGL,I,SF,IENS,SEQUENCE,DRUGCSC,FDA
 S CSGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0))
 S I=-1,SF=52.493117,SEQUENCE=0
 F  S I=$O(@CSGL@("DrugCoverageStatusCode",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S DRUGCSC=$G(@CSGL@("DrugCoverageStatusCode",I))
 .S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 .; sequence, drug coverage status code
 .S FDA(SF,IENS,.01)=SEQUENCE
 .S DRUGCSC=$$PRESOLV^PSOERXA1(DRUGCSC,"DCS") ;resolving pointer
 .S FDA(SF,IENS,.02)=DRUGCSC
 .D CFDA^PSOERXIU(.FDA)
 .D UPDATE^DIE(,"FDA") K FDA
 Q
