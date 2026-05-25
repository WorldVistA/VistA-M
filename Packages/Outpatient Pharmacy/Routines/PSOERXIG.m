PSOERXIG ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**581,770**;DEC 1997;Build 145
 ;
 Q
IVADMIN(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file IV administration data
 N IVGL,SF,IENS,IVCLQ,IVQUOM,IVVAL,IVCATDES,IVCATCOD,IVCATTEX,IVDCODE,IVDTEXT,IVDDESC,IVCODE,IVTEXT,IVIDESC,IVICODE
 N IVITEXT,IVNOL,IVADBR,IVADGA,IVADLEN,IVAPUMP,FDA,SF
 S IVGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0))
 S SF=52.49311
 S IVCLQ=$G(@IVGL@("IVAdministration",0,"DiluentAmount",0,"CodeListQualifier",0))
 S IVQUOM=$G(@IVGL@("IVAdministration",0,"DiluentAmount",0,"QuantityUnitOfMeasure",0,"Code",0))
 S IVVAL=$G(@IVGL@("IVAdministration",0,"DiluentAmount",0,"Value",0))
 S IVCATDES=$G(@IVGL@("IVAdministration",0,"IVAccessCatheterTip",0,"IVAccessCatheterTipDescription",0))
 S IVCATCOD=$G(@IVGL@("IVAdministration",0,"IVAccessCatheterTip",0,"IVAccessCatheterTipType",0,"Code",0))
 S IVCATTEX=$G(@IVGL@("IVAdministration",0,"IVAccessCatheterTip",0,"IVAccessCatheterTipType",0,"Text",0))
 S IVDCODE=$G(@IVGL@("IVAdministration",0,"IVAccessDeviceType",0,"IVAccessDeviceType",0,"Code",0))
 S IVDTEXT=$G(@IVGL@("IVAdministration",0,"IVAccessDeviceType",0,"IVAccessDeviceType",0,"Text",0))
 S IVDDESC=$G(@IVGL@("IVAdministration",0,"IVAccessDeviceType",0,"IVAccessDeviceTypeDescription",0))
 S IVCODE=$G(@IVGL@("IVAdministration",0,"IVAccessType",0,"Code",0))
 S IVTEXT=$G(@IVGL@("IVAdministration",0,"IVAccessType",0,"Text",0))
 S IVIDESC=$G(@IVGL@("IVAdministration",0,"IVInfusion",0,"IVInfusionDescription",0))
 S IVICODE=$G(@IVGL@("IVAdministration",0,"IVInfusion",0,"IVInfusionType",0,"Code",0))
 S IVITEXT=$G(@IVGL@("IVAdministration",0,"IVInfusion",0,"IVInfusionType",0,"Text",0))
 S IVNOL=$G(@IVGL@("IVAdministration",0,"NumberOfLumens",0))
 S IVADBR=$G(@IVGL@("IVAdministration",0,"SpecificAdministrationBrand",0))
 S IVADGA=$G(@IVGL@("IVAdministration",0,"SpecificAdministrationGauge",0))
 S IVADLEN=$G(@IVGL@("IVAdministration",0,"SpecificAdministrationLength",0))
 S IVAPUMP=$G(@IVGL@("IVAdministration",0,"SpecificAdministrationPump",0))
 S IENS=MIEN_","_ERXIEN_","
 ; iv admin # of lumens, iv admin diluent qty, iv admin diluent quom
 S IVCLQ=$$PRESOLV^PSOERXA1(IVCLQ,"QCQ")
 S IVQUOM=$$PRESOLV^PSOERXA1(IVQUOM,"NCI")
 S FDA(SF,IENS,28)=IVNOL,FDA(SF,IENS,29.1)=IVVAL,FDA(SF,IENS,29.2)=IVCLQ,FDA(SF,IENS,29.3)=IVQUOM
 ; spec admin guage, brand, length, pump
 S FDA(SF,IENS,30)=IVADGA,FDA(SF,IENS,31)=IVADBR,FDA(SF,IENS,32)=IVADLEN,FDA(SF,IENS,33.1)=IVAPUMP
 ; iva type code, iva type text, iva device desc, iva device type code, iva device type text
 S FDA(SF,IENS,34.1)=IVCODE,FDA(SF,IENS,35)=IVTEXT,FDA(SF,IENS,36)=IVDDESC,FDA(SF,IENS,37.1)=IVDCODE,FDA(SF,IENS,38)=IVDTEXT
 ; iva catheter tip code, iva vatherter tip text, iva catheter tip desc
 S FDA(SF,IENS,39.1)=IVCATCOD,FDA(SF,IENS,40)=IVCATTEX,FDA(SF,IENS,41)=IVCATDES
 ; iv infusion code, iv infusion text, iv infusion desc
 S FDA(SF,IENS,42.1)=IVICODE,FDA(SF,IENS,43)=IVITEXT,FDA(SF,IENS,44)=IVIDESC
 D CFDA^PSOERXIU(.FDA)
 I $D(FDA) D FILE^DIE(,"FDA","IVERR") K FDA
 Q
AGENCY(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file agency of service data
 N AGGL,ABUSNAME,AGADDGL,AAL1,AAL2,ACITY,APOST,ASTATE,ACC,AGNTNMGL,AGNM,ALN,AFN,AMN,ASUFF,APREF,AGCOMMGL,EFFDATE,EXPDATE,GROUPSET,MTMFTEXT,MTMTEXT,MTMQUAL
 N TTFREE,TTTEXT,TTQUAL,TTCODE,TOSFTEXT,TOSTEXT,TOSQUAL,TOSCODE,SF,IENS,AGNCGL,AGNTADD,MTMCODE
 S AGGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0,"Service",0,"ServiceType",0))
 S SF=52.49311,IENS=MIEN_","_ERXIEN_","
 S AGNCGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0,"Service",0,"AgencyOfService",0))
 S ABUSNAME=$G(@AGNCGL@("BusinessName",0))
 S AGADDGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0,"Service",0,"AgencyOfService",0,"Address",0))
 S AGNTADD=$$ADDRESS^PSOERXIU(AGADDGL)
 S AAL1=$P(AGNTADD,U,1),AAL2=$P(AGNTADD,U,2),ACITY=$P(AGNTADD,U,3),APOST=$P(AGNTADD,U,5)
 S ASTATE=$P(AGNTADD,U,4),ACC=$P(AGNTADD,U,6)
 S ASTATE=$$STRES^PSOERXA2(APOST,ASTATE)
 S AGNTNMGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0,"Service",0,"AgencyOfService",0,"AgencyContactName",0))
 S AGNM=$$NAME^PSOERXIU(AGNTNMGL)
 S ALN=$P(AGNM,U,1),AFN=$P(AGNM,U,2),AMN=$P(AGNM,U,3),ASUFF=$P(AGNM,U,4),APREF=$P(AGNM,U,5)
 S AGCOMMGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0,"Service",0,"AgencyOfService",0))
 S EFFDATE=$G(@AGGL@("EffectiveDate",0,"Date",0))
 I '$L(EFFDATE) S EFFDATE=$G(@AGGL@("EffectiveDate",0,"DateTime",0))
 S EFFDATE=$$CONVDTTM^PSOERXA1(EFFDATE)
 S EXPDATE=$G(@AGGL@("ExpirationDate",0,"Date",0))
 I '$L(EXPDATE) S EXPDATE=$G(@AGGL@("ExpirationDate",0,"DateTime",0))
 S EXPDATE=$$CONVDTTM^PSOERXA1(EXPDATE)
 S GROUPSET=$G(@AGGL@("TypeOfServiceGroupSetting",0))
 S MTMFTEXT=$G(@AGGL@("ReasonForMTMServiceFreeText",0))
 S MTMTEXT=$G(@AGGL@("ReasonForMTMServiceText",0))
 S MTMQUAL=$G(@AGGL@("ReasonForMTMServiceQualifier",0))
 S MTMCODE=$G(@AGGL@("ReasonForMTMServiceCode",0))
 S TTFREE=$G(@AGGL@("TargetedTypeOfServiceFreeText",0))
 S TTTEXT=$G(@AGGL@("TargetedTypeOfServiceText",0))
 S TTQUAL=$G(@AGGL@("TargetedTypeOfServiceQualifier",0))
 S TTCODE=$G(@AGGL@("TargetedTypeOfServiceCode",0))
 S TOSFTEXT=$G(@AGGL@("TypeOfServiceFreeText",0))
 S TOSTEXT=$G(@AGGL@("TypeOfServiceText",0))
 S TOSQUAL=$G(@AGGL@("TypeOfServiceQualifier",0))
 S TOSCODE=$G(@AGGL@("TypeOfServiceCode",0))
 S IENS=MIEN_","_ERXIEN_","
 ; business name, agent address
 S FDA(SF,IENS,21.1)=ABUSNAME,FDA(SF,IENS,21.2)=AAL1,FDA(SF,IENS,21.3)=AAL2,FDA(SF,IENS,21.4)=ACITY,FDA(SF,IENS,21.5)=ASTATE
 S FDA(SF,IENS,21.6)=APOST,FDA(SF,IENS,21.7)=ACC
 ; agent name
 S FDA(SF,IENS,27.1)=ALN,FDA(SF,IENS,27.2)=AFN,FDA(SF,IENS,27.3)=AMN,FDA(SF,IENS,27.4)=ASUFF,FDA(SF,IENS,27.5)=APREF
 ; type of effective date, type of expiration date, type of group setting
 S FDA(SF,IENS,77)=EXPDATE,FDA(SF,IENS,78)=EFFDATE,FDA(SF,IENS,79)=GROUPSET
 ; type of service free text, type of service text, type of service qualifier, type of service code
 S FDA(SF,IENS,64)=TOSFTEXT,FDA(SF,IENS,65)=TOSTEXT,FDA(SF,IENS,66)=TOSQUAL,FDA(SF,IENS,67)=TOSCODE
 ; targeted service free text, targeted service text, targeted service qualifier, targetd service code
 S FDA(SF,IENS,68)=TTFREE,FDA(SF,IENS,69)=TTTEXT,FDA(SF,IENS,71)=TTQUAL,FDA(SF,IENS,72)=TTCODE
 ; reason for MTM service free text, text, code, qualifier
 S FDA(SF,IENS,73)=MTMFTEXT,FDA(SF,IENS,74)=MTMTEXT,FDA(SF,IENS,75)=MTMQUAL,FDA(SF,IENS,76)=MTMCODE
 D CFDA^PSOERXIU(.FDA)
 I $D(FDA) D FILE^DIE(,"FDA","AGERR") K FDA
 D COMM^PSOERXIU(AGCOMMGL,52.4931125,MIEN_","_ERXIEN,52.49311,26)
 Q
WOUND(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file wound data
 N WGL,I,IENS,SEQUENCE,DEPTH,LATCODE,LATTEXT,LENGTH,LOCCODE,LOCTEXT,WIDTH,FDA,SF
 S WGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0))
 S I=-1,SF=52.4931146,SEQUENCE=0
 F  S I=$O(@WGL@("Wound",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S DEPTH=$G(@WGL@("Wound",I,"Depth",0))
 .S LATCODE=$G(@WGL@("Wound",I,"Laterality",0,"Code",0))
 .S LATTEXT=$G(@WGL@("Wound",I,"Laterality",0,"Text",0))
 .S LENGTH=$G(@WGL@("Wound",I,"Length",0))
 .S LOCCODE=$G(@WGL@("Wound",I,"Location",0,"Code",0))
 .S LOCTEXT=$G(@WGL@("Wound",I,"Location",0,"Text",0))
 .S WIDTH=$G(@WGL@("Wound",I,"Width",0))
 .S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 .; sequence
 .S FDA(SF,IENS,.01)=SEQUENCE
 .; location code, location text
 .S FDA(SF,IENS,.02)=LOCCODE,FDA(SF,IENS,1)=LOCTEXT
 .; laterality code, laterality text
 .S FDA(SF,IENS,2.1)=LATCODE,FDA(SF,IENS,3)=LATTEXT
 .; length, width, depth
 .S FDA(SF,IENS,4.1)=LENGTH,FDA(SF,IENS,4.2)=WIDTH,FDA(SF,IENS,4.3)=DEPTH
 D CFDA^PSOERXIU(.FDA)
 I $D(FDA) D UPDATE^DIE(,"FDA") K FDA
 Q
DRUGCS(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parsing and filing drug coverage status data
 N CSGL,I,SF,IENS,SEQUENCE,DRUGCSC,FDA,SF
 S CSGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0))
 S I=-1,SF=52.493117,SEQUENCE=0
 F  S I=$O(@CSGL@("DrugCoverageStatusCode",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S DRUGCSC=$G(@CSGL@("DrugCoverageStatusCode",I))
 .S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 .; sequence, drug coverage status code
 .S FDA(SF,IENS,.01)=SEQUENCE
 .S FDA(SF,IENS,.02)=DRUGCSC
 D UPDATE^DIE(,"FDA") K FDA
 Q
TITRATE(ERXIEN,MIEN,MTYPE,MEDTYPE) ; parse and file titration data
 N TGL,I,SF,IENS,SEQUENCE,PHTIDOSE,LOIN,MAXMEAS,MEASNOTE,MINMEAS,UCUM,VALIE,VITAL,FDA,MTNUMVAL,VARTIMOD,ADMINVAL,MUTEXT,MUQUAL
 N MUCODE,MMTEXT,MMQUAL,MMCODE,METEXT,MEQUAL,MECODE,CLARTEXT,MNUMVAL,MFREMOD,MNUMVAL2,MFREQTEX,MFREQUAL,MFRECODE,MIVAL,MIMOD,MIVAL2
 N MITEXT,MICODE,MIQUAL,MDVAL,MDTEXT,MDCODE,MDQUAL,MTTEXT,MTCODE,MTQUAL,MDCLTEXT,SF,UOM,VALUE
 S TGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0))
 S I=-1,SF=52.4931151,SEQUENCE=0
 F  S I=$O(@TGL@("Titration",I)) Q:I=""  D
 .S SEQUENCE=SEQUENCE+1
 .S PHTIDOSE=$G(@TGL@("Titration",0,"PharmacyToTitrateDose",0))
 .S LOIN=$G(@TGL@("Titration",0,"TitrationDose",0,"Measurement",I,"LOINCVersion",0))
 .S MAXMEAS=$G(@TGL@("Titration",0,"TitrationDose",0,"Measurement",I,"MaximumMeasurementValue",0))
 .S MEASNOTE=$G(@TGL@("Titration",0,"TitrationDose",0,"Measurement",I,"MeasurementNotes",0))
 .S MINMEAS=$G(@TGL@("Titration",0,"TitrationDose",0,"Measurement",I,"MinimumMeasurementValue",0))
 .S UCUM=$G(@TGL@("Titration",0,"TitrationDose",0,"Measurement",I,"UCUMVersion",0))
 .S UOM=$G(@TGL@("Titration",0,"TitrationDose",0,"Measurement",I,"UnitOfMeasure",0))
 .S VALUE=$G(@TGL@("Titration",0,"TitrationDose",0,"Measurement",I,"Value",0))
 .S VITAL=$G(@TGL@("Titration",0,"TitrationDose",0,"Measurement",I,"VitalSign",0))
 .S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 .; sequence, vital sign, loinc version, value, UCUM version
 .S FDA(SF,IENS,.01)=SEQUENCE,FDA(SF,IENS,1)=VITAL,FDA(SF,IENS,2)=LOIN,FDA(SF,IENS,3)=VALUE,FDA(SF,IENS,34)=UCUM
 .; unit of measure, min measurement value, max measurement value, measurement notes
 .S FDA(SF,IENS,4)=UOM,FDA(SF,IENS,5.1)=MINMEAS,FDA(SF,IENS,5.2)=MAXMEAS,FDA(SF,IENS,6)=MEASNOTE
 D CFDA^PSOERXIU(.FDA)
 I $D(FDA) D UPDATE^DIE(,"FDA") K FDA
 S SEQUENCE=SEQUENCE+1
 S TGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0,"Titration",0,"TitrationDose",0,"MeasurementTimingAndDuration",0))
 S MTNUMVAL=$G(@TGL@("MeasurementAdministrationTiming",0,"MeasurementTimingNumericValue",0))
 S VARTIMOD=$G(@TGL@("MeasurementAdministrationTiming",0,"VariableMeasurementTimingModifier",0))
 S ADMINVAL=$G(@TGL@("MeasurementAdministrationTiming",0,"AdministrationTimingNumericValue",0))
 S MUTEXT=$G(@TGL@("MeasurementAdministrationTiming",0,"MeasurementTimingUnits",0,"Text",0))
 S MUQUAL=$G(@TGL@("MeasurementAdministrationTiming",0,"MeasurementTimingUnits",0,"Qualifier",0))
 S MUCODE=$G(@TGL@("MeasurementAdministrationTiming",0,"MeasurementTimingUnits",0,"Code",0))
 S MMTEXT=$G(@TGL@("MeasurementAdministrationTiming",0,"MeasurementTimingModifier",0,"Text",0))
 S MMQUAL=$G(@TGL@("MeasurementAdministrationTiming",0,"MeasurementTimingModifier",0,"Qualifier",0))
 S MMCODE=$G(@TGL@("MeasurementAdministrationTiming",0,"MeasurementTimingModifier",0,"Code",0))
 S METEXT=$G(@TGL@("MeasurementAdministrationTiming",0,"MeasurementTimingEvent",0,"Text",0))
 S MEQUAL=$G(@TGL@("MeasurementAdministrationTiming",0,"MeasurementTimingEvent",0,"Qualifier",0))
 S MECODE=$G(@TGL@("MeasurementAdministrationTiming",0,"MeasurementTimingEvent",0,"Code",0))
 S CLARTEXT=$G(@TGL@("MeasurementAdministrationTiming",0,"MeasurementTimingClarifyingFreeText",0))
 S MNUMVAL=$G(@TGL@("MeasurementFrequency",0,"MeasurementFrequencyNumericValue",0))
 S MFREMOD=$G(@TGL@("MeasurementFrequency",0,"MeasurementVariableFrequencyModifier",0))
 S MNUMVAL2=$G(@TGL@("MeasurementFrequency",1,"MeasurementFrequencyNumericValue",0))
 S MFREQTEX=$G(@TGL@("MeasurementFrequency",0,"MeasurementFrequencyUnits",0,"Text",0))
 S MFREQUAL=$G(@TGL@("MeasurementFrequency",0,"MeasurementFrequencyUnits",0,"Qualifier",0))
 S MFRECODE=$G(@TGL@("MeasurementFrequency",0,"MeasurementFrequencyUnits",0,"Code",0))
 S MIVAL=$G(@TGL@("MeasurementInterval",0,"MeasurementIntervalNumericValue",0))
 S MIMOD=$G(@TGL@("MeasurementInterval",0,"MeasurementVariableIntervalModifier",0))
 S MIVAL2=$G(@TGL@("MeasurementInterval",1,"MeasurementIntervalNumericValue",0))
 S MITEXT=$G(@TGL@("MeasurementInterval",0,"MeasurementIntervalUnits",0,"Text",0))
 S MIQUAL=$G(@TGL@("MeasurementInterval",0,"MeasurementIntervalUnits",0,"Qualifier",0))
 S MICODE=$G(@TGL@("MeasurementInterval",0,"MeasurementIntervalUnits",0,"Code",0))
 S MDVAL=$G(@TGL@("MeasurementDuration",0,"MeasurementDurationNumericValue",0))
 S MDTEXT=$G(@TGL@("MeasurementDuration",0,"MeasurementDurationText",0,"Text",0))
 S MDQUAL=$G(@TGL@("MeasurementDuration",0,"MeasurementDurationText",0,"Qualifier",0))
 S MDCODE=$G(@TGL@("MeasurementDuration",0,"MeasurementDurationText",0,"Code",0))
 S MTTEXT=$G(@TGL@("MeasurementDurationTrigger",0,"MeasurementTrigger",0,"Text",0))
 S MTQUAL=$G(@TGL@("MeasurementDurationTrigger",0,"MeasurementTrigger",0,"Qualifier",0))
 S MTCODE=$G(@TGL@("MeasurementDurationTrigger",0,"MeasurementTrigger",0,"Code",0))
 S MDCLTEXT=$G(@TGL@("MeasurementDurationTrigger",0,"MeasurementDurationClarifyingFreeText",0))
 S IENS="+"_SEQUENCE_","_MIEN_","_ERXIEN_","
 ; sequence, timing numeric valie, variable timing mod, administration value
 S FDA(SF,IENS,.01)=SEQUENCE,FDA(SF,IENS,7.1)=MTNUMVAL,FDA(SF,IENS,7.2)=VARTIMOD,FDA(SF,IENS,7.3)=ADMINVAL
 ; measurement units text, measurement unit qualifier, measurement unit code
 S FDA(SF,IENS,8)=MUTEXT,FDA(SF,IENS,9)=MUQUAL,FDA(SF,IENS,10)=MUCODE
 ; measurement mod text, measurement mod qualifier, measuremend mod code
 S FDA(SF,IENS,11)=MMTEXT,FDA(SF,IENS,12)=MMQUAL,FDA(SF,IENS,13)=MMCODE
 ; measurement event text, measurement event qualifier, measurement event code, measurement clarifying text
 S FDA(SF,IENS,14)=METEXT,FDA(SF,IENS,15)=MEQUAL,FDA(SF,IENS,16)=MECODE,FDA(SF,IENS,17)=CLARTEXT
 ; measurement freq numeric value, measurement freq mod, measurement freq numeric value 2
 S FDA(SF,IENS,18.1)=MNUMVAL,FDA(SF,IENS,18.2)=MFREMOD,FDA(SF,IENS,18.3)=MNUMVAL2
 ; measurement freq text, measurement freq qualifier, measurement freq code
 S FDA(SF,IENS,19)=MFREQTEX,FDA(SF,IENS,20)=MFREQUAL,FDA(SF,IENS,21)=MFRECODE
 ; measurement in numeric value, measurement int modifier, measurement int numeric value 2
 S FDA(SF,IENS,22.1)=MIVAL,FDA(SF,IENS,22.2)=MIMOD,FDA(SF,IENS,22.3)=MIVAL2
 ; measurement int text, measurement int qualifier, measurement int code
 S FDA(SF,IENS,23)=MITEXT,FDA(SF,IENS,24)=MIQUAL,FDA(SF,IENS,25)=MICODE
 ; measurement duration valie, measurement duration text, measurement duration qualifier, measurement duration code
 S FDA(SF,IENS,26)=MDVAL,FDA(SF,IENS,27)=MDTEXT,FDA(SF,IENS,28)=MDQUAL,FDA(SF,IENS,29)=MDCODE
 ; measurement duration trigger text, measurement duration trigger qualifier, measurement duration trigger code, measurement duration clarifying text
 S FDA(SF,IENS,30)=MTTEXT,FDA(SF,IENS,31)=MTQUAL,FDA(SF,IENS,32)=MTCODE,FDA(SF,IENS,33)=MDCLTEXT
 D CFDA^PSOERXIU(.FDA)
 I $D(FDA) D UPDATE^DIE(,"FDA") K FDA
 Q
