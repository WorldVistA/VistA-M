PSOERXOK ;ALB/BWF - eRx parsing Utilities ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**581,635**;DEC 1997;Build 19
 ;
 Q
TIMDUR(GL,CNT,ERXIEN,MIEN,INSIEN) ;
 N TDIEN,F,TDIENS,MTDAT,MTM,ATV1,VATM,ATV2,ATUC,ATUQ,ATUT,ATMC,ATMQ,ATMT,ATEC,ATEQ,ATET,ATFT
 N FNV,FMOD,FNV2,FUC,FUQ,FUT,INTV,IMOD,INTV2,INTC,INTQ,INTCROA,RUMC,RUMQ,RUMT,RTBC,RTBQ,RTBT
 N TIMFT,DNV,DCODE,DQUAL,DTEXT,DTCTXT,DTCODE,DTQUAL,DTEXT,SIC,SIQ,SIT,DTTEXT,INTT,ROA
 S F=52.49311123
 I '$O(^PS(52.49,ERXIEN,311,MIEN,12,0)) Q
 S TDIEN=0 F  S TDIEN=$O(^PS(52.49,ERXIEN,311,MIEN,12,INSIEN,3,TDIEN)) Q:'TDIEN  D
 .S TDIENS=TDIEN_","_INSIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,TDIENS,"**","E","MTDAT")
 .D C S @GL@(CNT,0)="<TimingAndDuration>"
 .S MTM=$G(MTDAT(F,TDIENS,.02,"E"))
 .; if data is on the .03 field, this is AdministrationTiming, only build this segment
 .I $G(MTDAT(F,TDIENS,.03,"E"))]"" D
 ..S ATV1=$G(MTDAT(F,TDIENS,.03,"E")),VATM=$G(MTDAT(F,TDIENS,.04,"E")),ATV2=$G(MTDAT(F,TDIENS,.05,"E"))
 ..S ATUC=$G(MTDAT(F,TDIENS,1,"E")),ATUQ=$G(MTDAT(F,TDIENS,2,"E")),ATUT=$G(MTDAT(F,TDIENS,3,"E"))
 ..S ATMC=$G(MTDAT(F,TDIENS,4,"E")),ATMQ=$G(MTDAT(F,TDIENS,5,"E")),ATMT=$G(MTDAT(F,TDIENS,6,"E"))
 ..S ATEC=$G(MTDAT(F,TDIENS,7,"E")),ATEQ=$G(MTDAT(F,TDIENS,8,"E")),ATET=$G(MTDAT(F,TDIENS,9,"E"))
 ..S ATFT=$G(MTDAT(F,TDIENS,10,"E"))
 ..D C S @GL@(CNT,0)="<AdministrationTiming>"
 ..D BL(.GL,.CNT,"AdministrationTimingNumericValue",ATV1)
 ..I VATM]"" D
 ...D BL(.GL,.CNT,"VariableAdministrationTimingModifier",VATM)
 ...D BL(.GL,.CNT,"AdministrationTimingNumericValue",ATV2)
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"AdministrationTimingUnits",ATUT,ATUQ,ATUC)
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"AdministrationTimingModifier",ATMT,ATMQ,ATMC)
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"AdministrationTimingEvent",ATET,ATEQ,ATEC)
 ..D BL(.GL,.CNT,"AdministrationTimingClarifyingFreeText",ATFT)
 ..D C S @GL@(CNT,0)="</AdministrationTiming>"
 .; if data is on the 11.1 field, this is Frequency, only build this segment
 .I $G(MTDAT(F,TDIENS,11.1,"E"))]"" D
 ..S FNV=$G(MTDAT(F,TDIENS,11.1,"E")),FMOD=$G(MTDAT(F,TDIENS,11.2,"E")),FNV2=$G(MTDAT(F,TDIENS,11.3,"E"))
 ..S FUC=$G(MTDAT(F,TDIENS,12,"E")),FUQ=$G(MTDAT(F,TDIENS,13,"E")),FUT=$G(MTDAT(F,TDIENS,14,"E"))
 ..D C S @GBL@(CNT,0)="<Frequency>"
 ..D BL(.GL,.CNT,"FrequencyNumericValue",FNV)
 ..D BL(.GL,.CNT,"VariableFrequencyModifier",FMOD)
 ..D BL(.GL,.CNT,"FrequencyNumericValue",FNV2)
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"FrequencyUnits",FUT,FUQ,FUC)
 ..D C S @GBL@(CNT,0)="</Frequency>"
 .; if data is on the 15.1 field, this is Interval, only build this segment
 .I $G(MTDAT(F,TDIENS,15.1,"E"))]"" D
 ..S INTV=$G(MTDAT(F,TDIENS,15.1,"E")),IMOD=$G(MTDAT(F,TDIENS,15.2,"E")),INTV2=$G(MTDAT(F,TDIENS,15.3,"E"))
 ..S INTC=$G(MTDAT(F,TDIENS,16,"E")),INTQ=$G(MTDAT(F,TDIENS,17,"E")),INTT=$G(MTDAT(F,TDIENS,18,"E"))
 ..D C S @GBL@(CNT,0)="<Interval>"
 ..D BL(.GL,.CNT,"IntervalNumericValue",INTV)
 ..I IMOD]"" D
 ...D BL(.GL,.CNT,"VariableIntervalModifier",IMOD)
 ...D BL(.GL,.CNT,"IntervalNumericValue",INTV2)
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"IntervalUnits",INTT,INTQ,INTC)
 ..D C S @GBL@(CNT,0)="</Interval>"
 .; if data is on the 21.1 field, this is RateOfAdministration, only build this segment
 .I $G(MTDAT(F,TDIENS,21.1,"E"))]"" D
 ..S ROA=$G(MTDAT(F,TDIENS,21.1,"E"))
 ..S RUMC=$G(MTDAT(F,TDIENS,22,"E")),RUMQ=$G(MTDAT(F,TDIENS,23,"E")),RUMT=$G(MTDAT(F,TDIENS,24,"E"))
 ..S RTBC=$G(MTDAT(F,TDIENS,25,"E")),RTBQ=$G(MTDAT(F,TDIENS,26,"E")),RTBT=$G(MTDAT(F,TDIENS,27,"E"))
 ..D C S @GBL@(CNT,0)="<RateOfAdministration>"
 ..D BL(.GL,.CNT,"RateOfAdministration",ROA)
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"RateUnitOfMeasure",RUMT,RUMQ,RUMC)
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"TimePeriodBasis",RTBT,RTBQ,RTBC)
 ..D C S @GBL@(CNT,0)="</RateOfAdministration>"
 .; TimingClarifyingFreeText
 .S TIMFT=$G(MTDAT(F,TDIENS,28,"E")) D BL(.GL,.CNT,"TimingClarifyingFreeText",TIMFT)
 .; <Duration>
 .S DNV=$G(MTDAT(F,TDIENS,31,"E")),DCODE=$G(MTDAT(F,TDIENS,32,"E"))
 .S DQUAL=$G(MTDAT(F,TDIENS,33,"E")),DTEXT=$G(MTDAT(F,TDIENS,34,"E"))
 .I $L(DNV_DCODE_DQUAL_DTEXT) D
 ..D C S @GL@(CNT,0)="<Duration>"
 ..D BL(.GL,.CNT,"DurationNumericValue",DNV)
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"DurationText",DTEXT,DQUAL,DCODE)
 ..D C S @GL@(CNT,0)="</Duration>"
 .; <DurationTrigger>
 .S DTCTXT=$G(MTDAT(F,TDIENS,38,"E")),DTCODE=$G(MTDAT(F,TDIENS,35,"E"))
 .S DTQUAL=$G(MTDAT(F,TDIENS,36,"E")),DTTEXT=$G(MTDAT(F,TDIENS,37,"E"))
 .I $L(DTCTXT_DTCODE_DTQUAL_DTTEXT) D
 ..D C S @GL@(CNT,0)="<DurationTrigger>"
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"Trigger",DTTEXT,DTQUAL,DTCODE)
 ..D BL(.GL,.CNT,"DurationClarifyingFreeText",DTCTXT)
 ..D C S @GL@(CNT,0)="</DurationTrigger>"
 .S SIC=$G(MTDAT(F,TDIENS,41,"E")),SIQ=$G(MTDAT(F,TDIENS,42,"E")),SIT=$G(MTDAT(F,TDIENS,43,"E"))
 .D SIGTYPE^PSOERXOU(.GL,.CNT,"StopIndicator",SIT,SIQ,SIC)
 .D C S @GL@(CNT,0)="</TimingAndDuration>"
 Q
 ; maximum dose restriction
INSMDR(GL,CNT,ERXIEN,MIEN,INSIEN) ;
 N MDRIEN,MDRIENS,MDRV,MDRDAT,F,MDRV1,RUC,RUQ,RUT,DVAL,DUC,DUQ,DUT,RFC,RFQ,RFT,CFTEXT
 S F=52.493111275
 I '$O(^PS(52.49,ERXIEN,311,MIEN,12,INSIEN,75,0)) Q
 D C S @GL@(CNT,0)="<MaximumDoseRestriction>"
 S MDRIEN=0 F  S MDRIEN=$O(^PS(52.49,ERXIEN,311,MIEN,12,INSIEN,75,MDRIEN)) Q:'MDRIEN  D
 .K MDRDAT
 .S MDRIENS=MDRIEN_","_INSIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,MDRIENS,"**","E","MDRDAT")
 .S MDRV1=$G(MDRDAT(F,MDRIENS,1,"E")),RUC=$G(MDRDAT(F,MDRIENS,2,"E")),RUQ=$G(MDRDAT(F,MDRIENS,3,"E")),RUT=$G(MDRDAT(F,MDRIENS,4,"E"))
 .S DVAL=$G(MDRDAT(F,MDRIENS,5,"E")),DUC=$G(MDRDAT(F,MDRIENS,6,"E")),DUQ=$G(MDRDAT(F,MDRIENS,7,"E")),DUT=$G(MDRDAT(F,MDRIENS,8,"E"))
 .S RFC=$G(MDRDAT(F,MDRIENS,9,"E")),RFQ=$G(MDRDAT(F,MDRIENS,10,"E")),RFT=$G(MDRDAT(F,MDRIENS,11,"E"))
 .S CFTEXT=$G(MDRDAT(F,MDRIENS,12,"E"))
 .D BL(.GL,.CNT,"MaximumDoseRestrictionNumericValue",MDRV1)
 .D SIGTYPE^PSOERXOU(.GL,.CNT,"MaximumDoseRestrictionForm",RFT,RFQ,RFC)
 .D SIGTYPE^PSOERXOU(.GL,.CNT,"MaximumDoseRestrictionUnits",RUT,RUQ,RUC)
 .D BL(.GL,.CNT,"MaximumDoseRestrictionDurationValue",DVAL)
 .D SIGTYPE^PSOERXOU(.GL,.CNT,"MaximumDoseRestrictionDurationUnit",DUT,DUQ,DUC)
 .D BL(.GL,.CNT,"MaximumDoseRestrictionClarifyingFreeText",CFTEXT)
 D C S @GL@(CNT,0)="<MaximumDoseRestriction>"
 Q
 ; instruction level indication for use
INSI4USE(GL,CNT,ERXIEN,MIEN,INSIEN) ;
 N F,IFUIEN,IFUIENS,IFUDAT,IPC,IPQ,IPT,IC,IQ,IT,IVC1,IVQ1,IVT1,IVM,IVC2,IVQ2,IVT2,IVUC,IVUQ,IVUT
 N IUOMC,IUOMQ,IUOMT
 S F=52.493111267
 ; dont build anything if the subscript is missing
 Q:'$O(^PS(52.49,ERXIEN,311,MIEN,12,INSIEN,67,0))
 D C S @GL@(CNT,0)="<IndicationForUse>"
 S IFUIEN=0,IFUIEN=$O(^PS(52.49,ERXIEN,311,MIEN,12,INSIEN,67,IFUIEN)) Q:'IFUIEN  D
 .K IFUDAT
 .S IFUIENS=IFUIEN_","_INSIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,IFUIENS,"**","E","IFUDAT")
 .S IPC=$G(IFUDAT(F,IFUIENS,1,"E")),IPQ=$G(IFUDAT(F,IFUIENS,2,"E")),IPT=$G(IFUDAT(F,IFUIENS,3,"E"))
 .S IC=$G(IFUDAT(F,IFUIENS,4,"E")),IQ=$G(IFUDAT(F,IFUIENS,5,"E")),IT=$G(IFUDAT(F,IFUIENS,6,"E"))
 .S IVC1=$G(IFUDAT(F,IFUIENS,7,"E")),IVQ1=$G(IFUDAT(F,IFUIENS,8,"E")),IVT1=$G(IFUDAT(F,IFUIENS,9,"E"))
 .S IVM=$G(IFUDAT(F,IFUIENS,10,"E"))
 .S IVC2=$G(IFUDAT(F,IFUIENS,11,"E")),IVQ2=$G(IFUDAT(F,IFUIENS,12,"E")),IVT2=$G(IFUDAT(F,IFUIENS,13,"E"))
 .S IVUC=$G(IFUDAT(F,IFUIENS,14,"E")),IVUQ=$G(IFUDAT(F,IFUIENS,15,"E")),IVUT=$G(IFUDAT(F,IFUIENS,16,"E"))
 .S IUOMC=$G(IFUDAT(F,IFUIENS,17,"E")),IUOMQ=$G(IFUDAT(F,IFUIENS,18,"E")),IUOMT=$G(IFUDAT(F,IFUIENS,19,"E"))
 .D SIGTYPE^PSOERXOU(GL,.CNT,"IndicationPrescursor",IPT,IPQ,IPC)
 .D SIGTYPE^PSOERXOU(GL,.CNT,"Indication",IT,IQ,IC)
 .D SIGTYPE^PSOERXOU(GL,.CNT,"IndicationValue",IVT1,IVQ1,IVC1)
 .I $L(IVM) D BL(GL,.CNT,"IndicationVariableModifier",IVM)
 .D SIGTYPE^PSOERXOU(GL,.CNT,"IndicationValue",IVT2,IVQ2,IVC2)
 .D SIGTYPE^PSOERXOU(GL,.CNT,"IndicationValueUnit",IVUT,IVUQ,IVUC)
 .D SIGTYPE^PSOERXOU(GL,.CNT,"IndicationValueUnit",IUOMT,IUOMQ,IUOMC)
 D C S @GL@(CNT,0)="</IndicationForUse>"
 Q
BL(GBL,CNT,TAG,VAR) ;
 Q:VAR=""
 D C S @GBL@(CNT,0)="<"_TAG_">"_$$SYMENC^MXMLUTL(VAR)_"</"_TAG_">"
 Q
C ;
 S CNT=$G(CNT)+1
 Q
