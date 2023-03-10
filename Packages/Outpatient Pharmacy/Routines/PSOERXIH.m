PSOERXIH ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**581**;DEC 1997;Build 126
 ;
 Q
OMEDDATE(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file other medication date data ; ***ask Brad about date/time, not sure if we need that field
 N OGL,I,SEQUENCE,SF,DATE,QUAL,IENS,FDA,SF,EFFDT,FDA,EXDT
 S OGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0))
 S I=-1,SEQUENCE=0,SF=52.4931162
 F  S I=$O(@OGL@("OtherMedicationDate",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S DATE=$G(@OGL@("OtherMedicationDate",I,"OtherMedicationDate",0,"Date",0))
 .I '$L(DATE) S DATE=$G(@OGL@("OtherMedicationDate",I,"OtherMedicationDate",0,"DateTime",0))
 .S DATE=$$CONVDTTM^PSOERXA1(DATE)
 .S QUAL=$G(@OGL@("OtherMedicationDate",I,"OtherMedicationDateQualifier",0))
 .I QUAL="EffectiveDate" S EFFDT=DATE
 .I QUAL="ExpirationDate" S EXDT=DATE
 .S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 .; sequence, other medicaiton date, other medication date qualifier
 .S FDA(SF,IENS,.01)=SEQUENCE,FDA(SF,IENS,.02)=DATE,FDA(SF,IENS,.03)=QUAL
 D CFDA^PSOERXIU(.FDA)
 D UPDATE^DIE(,"FDA") K FDA
 ; file the effective and expiration dates in the old fields as well.
 I $D(EFFDT) S FDA(52.49,ERXIEN_",",6.3)=EFFDT
 I $D(EXDT) S FDA(52.49,ERXIEN_",",6.2)=EXDT
 I $D(FDA) D FILE^DIE(,"FDA") K FDA
 Q
FACTIME(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file facility specific hours of administration timing data
 N FGL,I,SEQUENCE,SF,ADCODE,ADQUAL,ADTEXT,ADVAL,IENS,FDA,SF
 S FGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0))
 S I=-1,SEQUENCE=0,SF=52.4931161
 F  S I=$O(@FGL@("FacilitySpecificHoursOfAdministrationTiming",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S ADCODE=$G(@FGL@("FacilitySpecificHoursOfAdministrationTiming",I,"HoursOfAdministration",0,"Code",0))
 .S ADQUAL=$G(@FGL@("FacilitySpecificHoursOfAdministrationTiming",I,"HoursOfAdministration",0,"Qualifier",0))
 .S ADTEXT=$G(@FGL@("FacilitySpecificHoursOfAdministrationTiming",I,"HoursOfAdministration",0,"Text",0))
 .S ADVAL=$G(@FGL@("FacilitySpecificHoursOfAdministrationTiming",I,"HoursOfAdministrationValue",0))
 .S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 .; sequence, hours of administration code, hours of adminstraiton qualifier, hours of adminstration text, hours of adminstration value
 .S FDA(SF,IENS,.01)=SEQUENCE,FDA(SF,IENS,.02)=ADVAL,FDA(SF,IENS,1)=ADTEXT,FDA(SF,IENS,2.1)=ADQUAL,FDA(SF,IENS,2.2)=ADCODE
 D CFDA^PSOERXIU(.FDA)
 D UPDATE^DIE(,"FDA") K FDA
 Q
PATNOTES(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file patient codified notes
 N PGL,I,SEQUENCE,SF,QUAL,VALUE,IENS,FDA,SF
 S PGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0))
 S I=-1,SEQUENCE=0,SF=52.4931159
 F  S I=$O(@PGL@("PatientCodifiedNote",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S QUAL=$G(@PGL@("PatientCodifiedNote",I,"Qualifier",0))
 .S VALUE=$G(@PGL@("PatientCodifiedNote",I,"Value",0))
 .S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 .; sequence, qualifier, value
 .S QUAL=$$PRESOLV^PSOERXA1(QUAL,"PCQ") ; resolving pointer
 .S FDA(SF,IENS,.01)=SEQUENCE,FDA(SF,IENS,.02)=QUAL,FDA(SF,IENS,.03)=VALUE
 D UPDATE^DIE(,"FDA") K FDA
 Q
COMPOUND(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file compound ingredient information
 ; create field in 52.49311 after the compound ingredients multiple. field will live outside of the loop (1 instance) - final compound pharamceutical dosage form
 N CGL,I,SF,SEQUENCE,COMPID,DEA,INCODE,INQUAL,STRFORM,STRUOMCD,STRVAL,ACKREA,CLINSC,COAGCODE,COAGQUAL,PROFSC,REACODE,RESCODE,CLQUAL,QUOMCODE,QUANTITY,IENS,FDA
 N SF,COAGDESC,FNLCMPDF
 S CGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0,"CompoundInformation",0))
 S I=-1,SEQUENCE=0,SF=52.4931157
 F  S I=$O(@CGL@("CompoundIngredientsLotNotUsed",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S COMPID=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"CompoundIngredient",0,"CompoundIngredientItemDescription",0))
 .S DEA=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"CompoundIngredient",0,"DEASchedule",0,"Code",0))
 .S INCODE=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"CompoundIngredient",0,"ItemNumber",0,"Code",0))
 .S INQUAL=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"CompoundIngredient",0,"ItemNumber",0,"Qualifier",0))
 .S STRFORM=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"CompoundIngredient",0,"Strength",0,"StrengthForm",0,"Code",0))
 .S STRUOMCD=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"CompoundIngredient",0,"Strength",0,"StrengthUnitOfMeasure",0,"Code",0))
 .S STRVAL=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"CompoundIngredient",0,"Strength",0,"StrengthValue",0))
 .S ACKREA=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"DrugUseEvaluation",0,"AcknowledgementReason",0))
 .S CLINSC=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"DrugUseEvaluation",0,"ClinicalSignificanceCode",0))
 .S COAGCODE=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"DrugUseEvaluation",0,"CoAgent",0,"CoAgentCode",0,"Code",0))
 .S COAGDESC=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"DrugUseEvaluation",0,"CoAgent",0,"CoAgentCode",0,"Description",0))
 .S COAGQUAL=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"DrugUseEvaluation",0,"CoAgent",0,"CoAgentCode",0,"Qualifier",0))
 .S PROFSC=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"DrugUseEvaluation",0,"ProfessionalServiceCode",0))
 .S REACODE=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"DrugUseEvaluation",0,"ServiceReasonCode",0))
 .S RESCODE=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"DrugUseEvaluation",0,"ServiceResultCode",0))
 .S CLQUAL=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"Quantity",0,"CodeListQualifier",0))
 .S QUOMCODE=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"Quantity",0,"QuantityUnitOfMeasure",0,"Code",0))
 .S QUANTITY=$G(@CGL@("CompoundIngredientsLotNotUsed",I,"Quantity",0,"Value",0))
 .S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 .; sequence, comp ingredient, comp ingredient item desc, item number code, item number qualifier
 .S INQUAL=$$PRESOLV^PSOERXA1(INQUAL,"ICQ") ; resolving pointer
 .S FDA(SF,IENS,.01)=SEQUENCE,FDA(SF,IENS,.02)=COMPID,FDA(SF,IENS,.03)=INCODE,FDA(SF,IENS,.04)=INQUAL
 .; strength value, strength form, strength unit of measure, dea schedule code
 .S STRFORM=$$PRESOLV^PSOERXA1(STRFORM,"NCI") ; resolving pointer
 .S STRUOMCD=$$PRESOLV^PSOERXA1(STRUOMCD,"NCI") ; resolving pointer
 .S DEA=$$PRESOLV^PSOERXA1(DEA,"NCI") ; resolving pointer
 .S FDA(SF,IENS,1.1)=STRVAL,FDA(SF,IENS,1.2)=STRFORM,FDA(SF,IENS,1.3)=STRUOMCD,FDA(SF,IENS,1.4)=DEA
 .; compound quantity , compound qual, compound quantity unit of measure
 .S CLQUAL=$$PRESOLV^PSOERXA1(CLQUAL,"QCQ") ; resolving pointer
 .S QUOMCODE=$$PRESOLV^PSOERXA1(QUOMCODE,"NCI") ; resolving pointer
 .S FDA(SF,IENS,2.1)=QUANTITY,FDA(SF,IENS,2.2)=CLQUAL,FDA(SF,IENS,2.3)=QUOMCODE
 .; service reason code, professional service code, service result code
 .S REACODE=$$PRESOLV^PSOERXA1(REACODE,"REA") ; resolving pointer
 .S PROFSC=$$PRESOLV^PSOERXA1(PROFSC,"PSC") ; resolving pointer
 .S RESCODE=$$PRESOLV^PSOERXA1(RESCODE,"RES") ; resolving pointer
 .S FDA(SF,IENS,3.1)=REACODE,FDA(SF,IENS,3.2)=PROFSC,FDA(SF,IENS,3.3)=RESCODE
 .; co-agent code, co-agent qualifier, clinical significance code, acknowledgement reason, co-agent description
 .S COAGQUAL=$$PRESOLV^PSOERXA1(COAGQUAL,"CAQ") ; resolving pointer
 .S FDA(SF,IENS,3.4)=COAGCODE,FDA(SF,IENS,3.5)=COAGQUAL,FDA(SF,IENS,3.6)=CLINSC,FDA(SF,IENS,3.7)=ACKREA,FDA(SF,IENS,4)=COAGDESC
 D CFDA^PSOERXIU(.FDA)
 D UPDATE^DIE(,"FDA") K FDA
 S FNLCMPDF=$G(@CGL@("FinalCompoundPharmaceuticalDosageForm",0))
 S FNLCMPDF=$$PRESOLV^PSOERXA1(FNLCMPDF,"NCI")
 S FDA(52.49311,MIEN_","_ERXIEN_",",81)=FNLCMPDF D FILE^DIE(,"FDA") K FDA
 Q
