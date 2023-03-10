PSOERXIF ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**581,635**;DEC 1997;Build 19
 ;
 Q
 ; ERXIEN - ERX IEN
 ; MIEN - MEDICATION IEN
SIG(ERXIEN,MIEN,MTYPE,MEDTYPE,I) ;
 N MSF,INSF,GL,GLIFU,GLINS,CFT,SIGTEXT,FMT,SNOV,INS,INSCNT,MIM,INSI,MTM
 N DDMC,DDMQ,DDMT,DDMMC,DDMMT,DDMMQ,DADDQ,DADUOMC,DADUOMQ,DADUOMT,DADDDRM,DADDQ2,DADUOMC2
 N DADUOMQ2,DADUOMT2,DADCDBN,DADCDBRM,DADCDBN2,DADCDBC,DADCDBT,DADCDBQ,DADCBMQ,DADCBMV
 N DADCCDN,DADCCDC,DADCCDT,DADCCDQ,DADCCF,DADDCC,DADDCT,DADDCQ,DADCFT,DADAC,DADAT,DADAQ,DAV,DAROAC
 N DAROAQ,DAROAT,DAROACFT,DASOAC,DASOAQ,DASOAT,DASOACFT,INS2,INS2CNT,TADFFNV,TADFVFM,TADFFNV2,TADFFUC
 N TADFFUQ,TADFFUT,TADIINV,TADIVIM,TADIINV2,TADIIUC,TADIIUQ,TADIIUT,TADATATN,TADATVAT,TADAATUC,TADAATUQ,TADAATUT
 N TADAATMC,TADAATMQ,TADAATMT,TADAATEC,TADAATEQ,TADAATET,TADAATFT,TADROA,TADRUOMC,TADRUOMT,TADRUOMQ,TADTPBC
 N TADTPBT,TADTPBQ,TADDNV,TADDTC,TADDTQ,TADDTT,TADDTTC,TADDTTQ,TADDTTT,TADDTFT,TADSCC,TADSCT,TADSQ,MDR,MDRCNT
 N FDA,GLINSTAD,INS2IENS,SCNT,SIGARY,ICFT,TIMCFT,ADMINI,DAVVC,DAVVCFT,DAVVMVM,DAVVPC,DAVVPQ
 N DAVVPT,DAVVQ,DAVVQ2,DAVVT,DAVVUOMC,DAVVUOMQ,DAVVUOMT,GLINSDA,IFUSF,INSFTAD,INSIENS,TADATAT2,TADSCQ
 S MSF=52.49311
 S INSF=52.4931112
 S IFUSF=52.4931113
 S INSFTAD=52.49311123
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,I,"Sig",0))
 S GLINS=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,I,"Sig",0,"Instruction"))
 S CFT=$G(@GL@("ClarifyingFreeText",0)),FDA(MSF,MIEN_","_ERXIEN_",",15)=CFT
 S SIGTEXT=$G(@GL@("SigText",0))
 D SIG^PSOERXII(ERXIEN,MIEN,SIGTEXT)
 S SNOV=$G(@GL@("CodeSystem",0,"SNOMEDVersion",0)),FDA(MSF,MIEN_","_ERXIEN_",",9.1)=SNOV
 S FMT=$G(@GL@("CodeSystem",0,"FMTVersion",0)),FDA(MSF,MIEN_","_ERXIEN_",",9.2)=FMT
 D CFDA^PSOERXIU(.FDA)
 D FILE^DIE(,"FDA") K FDA
 D IFU^PSOERXII(ERXIEN,MIEN,MTYPE,MEDTYPE)
 S INS=-1 F  S INS=$O(@GLINS@(INS)) Q:INS=""  D
 .; The multiple instruction modifier will be at the INS-1 subscript, since the modifier comes _after_ the instruction and
 .; is optional.
 .S GLINSDA=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"MedicationPrescribed",I,"Sig",0,"Instruction",INS,"DoseAdministration",0))
 .S INSCNT=$G(INSCNT)+1
 .S INSIENS="+"_INSCNT_","_MIEN_","_ERXIEN_","
 .S FDA(INSF,INSIENS,.01)=INSCNT
 .S MIM=$G(@GL@("MultipleInstructionModifier",INS-1)),FDA(INSF,INSIENS,.03)=MIM
 .; dose delivery method
 .S INSI=$G(@GLINS@(INS,"InstructionIndicator",0)),FDA(INSF,INSIENS,.02)=INSI
 .S ADMINI=$G(@GLINS@(INS,"AdministrationIndicator",0)),FDA(INSF,INSIENS,4.1)=ADMINI
 .S DDMC=$G(@GLINSDA@("DoseDeliveryMethod",0,"Code",0)),FDA(INSF,INSIENS,7)=DDMC
 .S DDMQ=$G(@GLINSDA@("DoseDeliveryMethod",0,"Qualifier",0)),FDA(INSF,INSIENS,8)=DDMQ
 .S DDMT=$G(@GLINSDA@("DoseDeliveryMethod",0,"Text",0)),FDA(INSF,INSIENS,9)=DDMT
 .S DDMMC=$G(@GLINSDA@("DoseDeliveryMethodModifier",0,"Code",0)),FDA(INSF,INSIENS,72)=DDMMC
 .S DDMMQ=$G(@GLINSDA@("DoseDeliveryMethodModifier",0,"Qualifier",0)),FDA(INSF,INSIENS,73)=DDMMQ
 .S DDMMT=$G(@GLINSDA@("DoseDeliveryMethodModifier",0,"Text",0)),FDA(INSF,INSIENS,74)=DDMMT
 .; dosage
 .S DADDQ=$G(@GLINSDA@("Dosage",0,"DoseQuantity",0)),FDA(INSF,INSIENS,10.1)=DADDQ
 .S DADUOMC=$G(@GLINSDA@("Dosage",0,"DoseUnitOfMeasure",0,"Code",0)),FDA(INSF,INSIENS,11)=DADUOMC
 .S DADUOMQ=$G(@GLINSDA@("Dosage",0,"DoseUnitOfMeasure",0,"Qualifier",0)),FDA(INSF,INSIENS,12)=DADUOMQ
 .S DADUOMT=$G(@GLINSDA@("Dosage",0,"DoseUnitOfMeasure",0,"Text",0)),FDA(INSF,INSIENS,13)=DADUOMT
 .S DADDDRM=$G(@GLINSDA@("Dosage",0,"DoseRangeModifier",0)),FDA(INSF,INSIENS,14)=DADDDRM
 .; 2 instances of these elements... check the global/xml structure - not sure where this increments or how it is stored
 .S DADDQ2=$G(@GLINSDA@("Dosage",0,"DoseQuantity",1)),FDA(INSF,INSIENS,15.1)=DADDQ2
 .S DADUOMC2=$G(@GLINSDA@("Dosage",0,"DoseUnitOfMeasure",1,"Code",0)),FDA(INSF,INSIENS,16)=DADUOMC2
 .S DADUOMQ2=$G(@GLINSDA@("Dosage",0,"DoseUnitOfMeasure",1,"Qualifier",0)),FDA(INSF,INSIENS,17)=DADUOMQ2
 .S DADUOMT2=$G(@GLINSDA@("Dosage",0,"DoseUnitOfMeasure",1,"Text",0)),FDA(INSF,INSIENS,18)=DADUOMT2
 .; Dose calculation - 2 INSTANCES OF DOSINGBASISNUMERIC.. CHECK STRUCTURES
 .S DADCDBN=$G(@GLINSDA@("DoseCalculation",0,"DosingBasisNumeric",0)),FDA(INSF,INSIENS,21.1)=DADCDBN
 .S DADCDBRM=$G(@GLINSDA@("DoseCalculation",0,"DosingBasisRangeModifier",0)),FDA(INSF,INSIENS,21.2)=DADCDBRM
 .S DADCDBN2=$G(@GLINSDA@("DoseCalculation",0,"DosingBasisNumeric",1)),FDA(INSF,INSIENS,21.3)=DADCDBN2
 .S DADCDBC=$G(@GLINSDA@("DoseCalculation",0,"DosingBasisUnitOfMeasure",0,"Code",0)),FDA(INSF,INSIENS,22)=DADCDBC
 .S DADCDBQ=$G(@GLINSDA@("DoseCalculation",0,"DosingBasisUnitOfMeasure",0,"Qualifier",0)),FDA(INSF,INSIENS,23)=DADCDBQ
 .S DADCDBT=$G(@GLINSDA@("DoseCalculation",0,"DosingBasisUnitOfMeasure",0,"Text",0)),FDA(INSF,INSIENS,24)=DADCDBT
 .S DADCBMQ=$G(@GLINSDA@("DoseCalculation",0,"BodyMetricQualifier",0)),FDA(INSF,INSIENS,25.1)=DADCBMQ
 .S DADCBMV=$G(@GLINSDA@("DoseCalculation",0,"BodyMetricValue",0)),FDA(INSF,INSIENS,25.2)=DADCBMV
 .S DADCCDN=$G(@GLINSDA@("DoseCalculation",0,"CalculatedDoseNumeric",0)),FDA(INSF,INSIENS,26)=DADCCDN
 .S DADCCDC=$G(@GLINSDA@("DoseCalculation",0,"CalculatedDoseUnitOfMeasure",0,"Code",0)),FDA(INSF,INSIENS,27)=DADCCDC
 .S DADCCDQ=$G(@GLINSDA@("DoseCalculation",0,"CalculatedDoseUnitOfMeasure",0,"Qualifier",0)),FDA(INSF,INSIENS,28)=DADCCDQ
 .S DADCCDT=$G(@GLINSDA@("DoseCalculation",0,"CalculatedDoseUnitOfMeasure",0,"Text",0)),FDA(INSF,INSIENS,29)=DADCCDT
 .S DADCCF=$G(@GLINSDA@("DoseCalculation",0,"DoseCalculationClarifyingFreeText",0)),FDA(INSF,INSIENS,31)=DADCCF
 .S DADDCC=$G(@GLINSDA@("DoseCalculation",0,"DoseUnitOfMeasureCode",0,"Code",0)),FDA(INSF,INSIENS,32)=DADDCC
 .S DADDCQ=$G(@GLINSDA@("DoseCalculation",0,"DoseUnitOfMeasureCode",0,"Qualifier",0)),FDA(INSF,INSIENS,33)=DADDCQ
 .S DADDCT=$G(@GLINSDA@("DoseCalculation",0,"DoseUnitOfMeasureCode",0,"Text",0)),FDA(INSF,INSIENS,34)=DADDCT
 .; dose amount
 .S DADCFT=$G(@GLINSDA@("DoseClarifyingFreeText",0)),FDA(INSF,INSIENS,38)=DADCFT
 .S DADAC=$G(@GLINSDA@("DoseAmount",0,"Code",0)),FDA(INSF,INSIENS,35)=DADAC
 .S DADAQ=$G(@GLINSDA@("DoseAmount",0,"Qualifier",0)),FDA(INSF,INSIENS,36)=DADAQ
 .S DADAT=$G(@GLINSDA@("DoseAmount",0,"Text",0)),FDA(INSF,INSIENS,37)=DADAT
 .; Vehicle
 .S DAVVPC=$G(@GLINSDA@("Vehicle",0,"VehiclePreposition",0,"Code")),FDA(INSF,INSIENS,41)=DAVVPC
 .S DAVVPQ=$G(@GLINSDA@("Vehicle",0,"VehiclePreposition",0,"Qualifier")),FDA(INSF,INSIENS,42)=DAVVPQ
 .S DAVVPT=$G(@GLINSDA@("Vehicle",0,"VehiclePreposition",0,"Text")),FDA(INSF,INSIENS,43)=DAVVPT
 .S DAVVQ=$G(@GLINSDA@("Vehicle",0,"VehicleQuantity",0)),FDA(INSF,INSIENS,44.1)=DAVVQ
 .S DAVVMVM=$G(@GLINSDA@("Vehicle",0,"MultipleVehicleModifier",0)),FDA(INSF,INSIENS,44.2)=DAVVMVM
 .S DAVVQ2=$G(@GLINSDA@("Vehicle",0,"VehicleQuantity",1)),FDA(INSF,INSIENS,44.3)=DAVVQ2
 .S DAVVUOMC=$G(@GLINSDA@("Vehicle",0,"VehicleUnitOfMeasure",0,"Code")),FDA(INSF,INSIENS,45)=DAVVUOMC
 .S DAVVUOMQ=$G(@GLINSDA@("Vehicle",0,"VehicleUnitOfMeasure",0,"Qualifier")),FDA(INSF,INSIENS,46)=DAVVUOMQ
 .S DAVVUOMT=$G(@GLINSDA@("Vehicle",0,"VehicleUnitOfMeasure",0,"Text")),FDA(INSF,INSIENS,47)=DAVVUOMT
 .S DAVVC=$G(@GLINSDA@("Vehicle",0,"Vehicle",0,"Code",0)),FDA(INSF,INSIENS,51)=DAVVC
 .S DAVVQ=$G(@GLINSDA@("Vehicle",0,"Vehicle",0,"Qualifier",0)),FDA(INSF,INSIENS,52)=DAVVQ
 .S DAVVT=$G(@GLINSDA@("Vehicle",0,"Vehicle",0,"Text",0)),FDA(INSF,INSIENS,53)=DAVVT
 .S DAVVCFT=$G(@GLINSDA@("Vehicle",0,"VehicleClarifyingFreeText",0)),FDA(INSF,INSIENS,54)=DAVVCFT
 .; route of administration
 .S DAROAC=$G(@GLINSDA@("RouteOfAdministration",0,"Code",0)),FDA(INSF,INSIENS,55)=DAROAC
 .S DAROAQ=$G(@GLINSDA@("RouteOfAdministration",0,"Qualifier",0)),FDA(INSF,INSIENS,56)=DAROAQ
 .S DAROAT=$G(@GLINSDA@("RouteOfAdministration",0,"Text",0)),FDA(INSF,INSIENS,57)=DAROAT
 .S DAROACFT=$G(@GLINS@("RouteOfAdministrationClarifyingFreeText",0)),FDA(INSF,INSIENS,58)=DAROACFT
 .; site of administration
 .S DASOAC=$G(@GLINSDA@("SiteOfAdministration",0,"Code",0)),FDA(INSF,INSIENS,61)=DASOAC
 .S DASOAQ=$G(@GLINSDA@("SiteOfAdministration",0,"Qualifier",0)),FDA(INSF,INSIENS,62)=DASOAQ
 .S DASOAT=$G(@GLINSDA@("SiteOfAdministration",0,"Text",0)),FDA(INSF,INSIENS,63)=DASOAT
 .S DASOACFT=$G(@GLINSDA@("SiteOfAdministrationClarifyingFreeText",0)),FDA(INSF,INSIENS,64)=DASOACFT
 .S ICFT=$G(@GLINS@(INS,"IndicationClarifyingFreeText",0)),FDA(INSF,INSIENS,70)=ICFT
 .N NINSIEN,NEWIEN
 .D CFDA^PSOERXIU(.FDA)
 .D UPDATE^DIE(,"FDA","NEWIEN") K FDA S NEWIEN=$O(NEWIEN(0)),NINSIEN=$G(NEWIEN(NEWIEN))
 .;PSO*7*635 - add handling of 'IndicationForUse' when it appears under the 'Instruction' segment
 .D INSIFU^PSOERXII(ERXIEN,MIEN,MTYPE,MEDTYPE,INS,NINSIEN)
 .;PSO*7*635 - end change
 .S INS2=-1 F  S INS2=$O(@GLINS@(INS,"TimingAndDuration",INS2)) Q:INS2=""  D
 ..; frequency - note dual FrequencyNumericValue components. need to see how that gets stored. incrementor?
 ..S INS2CNT=$G(INS2CNT)+1
 ..S INS2IENS="+"_INS2CNT_","_NINSIEN_","_MIEN_","_ERXIEN_","
 ..S FDA(INSFTAD,INS2IENS,.01)=INS2CNT
 ..S MTM=$G(@GLINS@(INS,"MultipleTimingModifier",0)),FDA(INSFTAD,INS2IENS,.02)=MTM
 ..S GLINSTAD=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"MedicationPrescribed",0,"Sig",0,"Instruction",INS,"TimingAndDuration",INS2))
 ..S TADFFNV=$G(@GLINSTAD@("Frequency",0,"FrequencyNumericValue",0)),FDA(INSFTAD,INS2IENS,11.1)=TADFFNV
 ..S TADFVFM=$G(@GLINSTAD@("Frequency",0,"VariableFrequencyModifier",0)),FDA(INSFTAD,INS2IENS,11.2)=TADFVFM
 ..S TADFFNV2=$G(@GLINSTAD@("Frequency",0,"FrequencyNumericValue",1)),FDA(INSFTAD,INS2IENS,11.3)=TADFFNV2
 ..S TADFFUC=$G(@GLINSTAD@("Frequency",0,"FrequencyUnits",0,"Code",0)),FDA(INSFTAD,INS2IENS,12)=TADFFUC
 ..S TADFFUQ=$G(@GLINSTAD@("Frequency",0,"FrequencyUnits",0,"Qualifier",0)),FDA(INSFTAD,INS2IENS,13)=TADFFUQ
 ..S TADFFUT=$G(@GLINSTAD@("Frequency",0,"FrequencyUnits",0,"Text",0)),FDA(INSFTAD,INS2IENS,14)=TADFFUT
 ..; interval - same issue as frequency
 ..S TADIINV=$G(@GLINSTAD@("Interval",0,"IntervalNumericValue",0)),FDA(INSFTAD,INS2IENS,15.1)=TADIINV
 ..S TADIVIM=$G(@GLINSTAD@("Interval",0,"VariableIntervalModifier",0)),FDA(INSFTAD,INS2IENS,15.2)=TADIVIM
 ..S TADIINV2=$G(@GLINSTAD@("Interval",0,"IntervalNumericValue",1)),FDA(INSFTAD,INS2IENS,15.3)=TADIINV2
 ..S TADIIUC=$G(@GLINSTAD@("Interval",0,"IntervalUnits",0,"Code",0)),FDA(INSFTAD,INS2IENS,16)=TADIIUC
 ..S TADIIUQ=$G(@GLINSTAD@("Interval",0,"IntervalUnits",0,"Qualifier",0)),FDA(INSFTAD,INS2IENS,17)=TADIIUQ
 ..S TADIIUT=$G(@GLINSTAD@("Interval",0,"IntervalUnits",0,"Text",0)),FDA(INSFTAD,INS2IENS,18)=TADIIUT
 ..;admin timing
 ..S TADATATN=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingNumericValue",0)),FDA(INSFTAD,INS2IENS,.03)=TADATATN
 ..S TADATAT2=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingNumericValue",1)),FDA(INSFTAD,INS2IENS,.05)=TADATAT2
 ..S TADATVAT=$G(@GLINSTAD@("AdministrationTiming",0,"VariableAdministrationTimingModifier",0,"Code",0)),FDA(INSFTAD,INS2IENS,.04)=TADATVAT
 ..S TADAATUC=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingUnits",0,"Code",0)),FDA(INSFTAD,INS2IENS,1)=TADAATUC
 ..S TADAATUQ=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingUnits",0,"Qualifier",0)),FDA(INSFTAD,INS2IENS,2)=TADAATUQ
 ..S TADAATUT=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingUnits",0,"Text",0)),FDA(INSFTAD,INS2IENS,3)=TADAATUT
 ..S TADAATMC=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingModifier",0,"Code",0)),FDA(INSFTAD,INS2IENS,4)=TADAATMC
 ..S TADAATMQ=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingModifier",0,"Qualifier",0)),FDA(INSFTAD,INS2IENS,5)=TADAATMQ
 ..S TADAATMT=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingModifier",0,"Text",0)),FDA(INSFTAD,INS2IENS,6)=TADAATMT
 ..S TADAATEC=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingEvent",0,"Code",0)),FDA(INSFTAD,INS2IENS,7)=TADAATEC
 ..S TADAATEQ=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingEvent",0,"Qualifier",0)),FDA(INSFTAD,INS2IENS,8)=TADAATEQ
 ..S TADAATET=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingEvent",0,"Text",0)),FDA(INSFTAD,INS2IENS,9)=TADAATET
 ..S TADAATFT=$G(@GLINSTAD@("AdministrationTiming",0,"AdministrationTimingClarifyingFreeText",0)),FDA(INSFTAD,INS2IENS,10)=TADAATFT
 ..; rate of administration
 ..S TADROA=$G(@GLINSTAD@("RateOfAdministration",0,"RateOfAdministration",0)),FDA(INSFTAD,INS2IENS,21.1)=TADROA
 ..S TADRUOMC=$G(@GLINSTAD@("RateOfAdministration",0,"RateUnitOfMeasure",0,"Code")),FDA(INSFTAD,INS2IENS,22)=TADRUOMC
 ..S TADRUOMT=$G(@GLINSTAD@("RateOfAdministration",0,"RateUnitOfMeasure",0,"Text")),FDA(INSFTAD,INS2IENS,24)=TADRUOMT
 ..S TADRUOMQ=$G(@GLINSTAD@("RateOfAdministration",0,"RateUnitOfMeasure",0,"Qualifier")),FDA(INSFTAD,INS2IENS,23)=TADRUOMQ
 ..S TADTPBC=$G(@GLINSTAD@("RateOfAdministration",0,"TimePeriodBasis",0,"Code")),FDA(INSFTAD,INS2IENS,25)=TADTPBC
 ..S TADTPBT=$G(@GLINSTAD@("RateOfAdministration",0,"TimePeriodBasis",0,"Text")),FDA(INSFTAD,INS2IENS,27)=TADTPBT
 ..S TADTPBQ=$G(@GLINSTAD@("RateOfAdministration",0,"TimePeriodBasis",0,"Qualifier")),FDA(INSFTAD,INS2IENS,26)=TADTPBQ
 ..S TIMCFT=$G(@GLINSTAD@("TimeClarifyingFreeText",0)),FDA(INSFTAD,INS2IENS,28)=TIMCFT
 ..; duration
 ..S TADDNV=$G(@GLINSTAD@("Duration",0,"DurationNumericValue",0)),FDA(INSFTAD,INS2IENS,31)=TADDNV
 ..S TADDTC=$G(@GLINSTAD@("Duration",0,"DurationText",0,"Code",0)),FDA(INSFTAD,INS2IENS,32)=TADDTC
 ..S TADDTQ=$G(@GLINSTAD@("Duration",0,"DurationText",0,"Qualifier",0)),FDA(INSFTAD,INS2IENS,33)=TADDTQ
 ..S TADDTT=$G(@GLINSTAD@("Duration",0,"DurationText",0,"Text",0)),FDA(INSFTAD,INS2IENS,34)=TADDTT
 ..; duration trigger
 ..S TADDTTC=$G(@GLINSTAD@("DurationTrigger",0,"Trigger",0,"Code",0)),FDA(INSFTAD,INS2IENS,35)=TADDTTC
 ..S TADDTTQ=$G(@GLINSTAD@("DurationTrigger",0,"Trigger",0,"Qualifier",0)),FDA(INSFTAD,INS2IENS,36)=TADDTTQ
 ..S TADDTTT=$G(@GLINSTAD@("DurationTrigger",0,"Trigger",0,"Text",0)),FDA(INSFTAD,INS2IENS,37)=TADDTTT
 ..S TADDTFT=$G(@GLINSTAD@("DurationTrigger",0,"DurationClarifyingFreeText",0)),FDA(INSFTAD,INS2IENS,38)=TADDTFT
 ..; stop code
 ..S TADSCC=$G(@GLINSTAD@("StopCode",0,"Code",0)),FDA(INSFTAD,INS2IENS,41)=TADSCC
 ..S TADSCT=$G(@GLINSTAD@("StopCode",0,"Text",0)),FDA(INSFTAD,INS2IENS,43)=TADSCT
 ..S TADSCQ=$G(@GLINSTAD@("StopCode",0,"Qualifier",0)),FDA(INSFTAD,INS2IENS,42)=TADSCQ
 ..D CFDA^PSOERXIU(.FDA)
 ..D UPDATE^DIE(,"FDA") K FDA
 ..;D MDRSF^PSOERXII(GLINS,ERXIEN,MIEN,NINSIEN)
 D MDR^PSOERXII(ERXIEN,MIEN,MTYPE,MEDTYPE)
 Q
