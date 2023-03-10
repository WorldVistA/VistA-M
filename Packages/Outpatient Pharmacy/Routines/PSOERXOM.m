PSOERXOM ;ALB/BWF - eRx parsing Utilities ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**581**;DEC 1997;Build 126
 ;
 Q
 ;
OOTHMEDT(GL,CNT,ERXIEN,MIEN) ; OtherMedicationDate
 N DATE,F,OMDDAT,OMDIEN,OMDIENS,QUAL
 S F=52.4931162
 S OMDIEN=0 F  S OMDIEN=$O(^PS(52.49,ERXIEN,311,MIEN,62,OMDIEN)) Q:'OMDIEN  D
 .K OMDDAT
 .S OMDIENS=OMDIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,OMDIENS,"**","I","OMDDAT")
 .S DATE=$G(OMDDAT(F,OMDIENS,.02,"I")) S:DATE]"" DATE=$$EXTIME^PSOERXO1(DATE)
 .S QUAL=$G(OMDDAT(F,OMDIENS,.03,"I"))
 .I DATE'="",QUAL'="" D
 ..D C S @GL@(CNT,0)="<OtherMedicationDate>"
 ..D C S @GL@(CNT,0)="<OtherMedicationDate>"
 ..D C S @GL@(CNT,0)="<DateTime>"_DATE_"</DateTime>"
 ..D C S @GL@(CNT,0)="</OtherMedicationDate>"
 ..D C S @GL@(CNT,0)="<OtherMedicationDateQualifier>"_QUAL_"</OtherMedicationDateQualifier>"
 ..D C S @GL@(CNT,0)="</OtherMedicationDate>"
 Q
 ;
OFACSPE(GL,CNT,ERXIEN,MIEN) ; FacilitySpecificHoursOfAdministrationTiming
 N CODE,F,FIELD,I,OFSDAT,OFSIEN,OFSIENS,QUAL,TEXT,VALUE,VAR
 S F=52.4931161
 S OFSIEN=0 F  S OFSIEN=$O(^PS(52.49,ERXIEN,311,MIEN,61,OFSIEN)) Q:'OFSIEN  D
 .K OFSDAT
 .S OFSIENS=OFSIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,OFSIENS,"**","E","OFSDAT")
 .F I=".02,VALUE","1,TEXT","2.1,QUAL","2.2,CODE" D
 ..S FIELD=$P(I,","),VAR=$P(I,",",2)
 ..S @VAR=$G(OFSDAT(F,OFSIENS,FIELD,"E"))
 .I VALUE'="",TEXT'="",QUAL'="",CODE'="" D
 ..D C S @GL@(CNT,0)="<FacilitySpecificHoursOfAdministrationTiming>"
 ..D C S @GL@(CNT,0)="<HoursOfAdministrationValue>"_VALUE_"</HoursOfAdministrationValue>"
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"HoursOfAdministration",TEXT,QUAL,CODE)
 ..D C S @GL@(CNT,0)="</FacilitySpecificHoursOfAdministrationTiming>"
 Q
 ; 
OPTCODNT(GL,CNT,ERXIEN,MIEN) ; PatientCodifiedNote
 N F,PCNDAT,PCNIEN,PCNIENS,QUAL,VALUE
 S F=52.4931159
 S PCNIEN=0 F  S PCNIEN=$O(^PS(52.49,ERXIEN,311,MIEN,59,PCNIEN)) Q:'PCNIEN  D
 .K PCNDAT
 .S PCNIENS=PCNIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,PCNIENS,"**","E","PCNDAT")
 .S QUAL=$G(PCNDAT(F,PCNIENS,.02,"E"))
 .S VALUE=$G(PCNDAT(F,PCNIENS,.03,"E"))
 .I QUAL'="" D
 ..D C S @GL@(CNT,0)="<PatientCodifiedNote>"
 ..D C S @GL@(CNT,0)="<Qualifier>"_QUAL_"</Qualifier>"
 ..D BL(GL,.CNT,"Value",VALUE)
 ..D C S @GL@(CNT,0)="</PatientCodifiedNote>"
 Q
 ; 
OCOMPINF(GL,CNT,ERXIEN,MIEN) ; CompoundInformation
 N ACKRSN,CIDAT,CIIEN,CIIENS,CLSIGCD,COAGCODE,COAGDESC,COAGQUAL,COPHDOFM,CQCODQL,CQUOM,CQVAL
 N DEACODE,DESC,F,FIELD,I,J,NRCODE,NRQUAL,PRSVCD,STRFORM,STRUOM,STRVAL,SVRSLTCD,SVRSNCD,VAR
 S F=52.49311
 S CIIENS=MIEN_","_ERXIEN_","
 D GETS^DIQ(F,CIIENS,56.1,"E","CIDAT")
 S COPHDOFM=$G(CIDAT(F,CIIENS,56.1,"E"))
 K CIDAT S F=52.4931157
 S CIIEN=0 F  S CIIEN=$O(^PS(52.49,ERXIEN,311,MIEN,57,CIIEN)) Q:'CIIEN  D
 .K CIDAT
 .S CIIENS=CIIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,CIIENS,"**","E","CIDAT")
 .F I=1:1 S TXT=$P($T(COMPINFD+I),";;",2) Q:TXT="DONE"  D
 ..F J=1:1:$L(TXT,";") D
 ...S FIELD=$P(TXT,";",J),VAR=$P(FIELD,",",2),FIELD=$P(FIELD,",")
 ...S @VAR=$G(CIDAT(F,CIIENS,FIELD,"E"))
 .I COPHDOFM'="",CQVAL'="",CQCODQL'="",CQUOM'="" D
 ..D C S @GL@(CNT,0)="<CompoundInformation>"
 ..D C S @GL@(CNT,0)="<FinalCompoundPharmaceuticalDosageForm>"_COPHDOFM_"</FinalCompoundPharmaceuticalDosageForm>"
 ..D C S @GL@(CNT,0)="<CompoundIngredientsLotNotUsed>"
 ..I DESC'="" D
 ...D C S @GL@(CNT,0)="<CompoundIngredient>"
 ...D C S @GL@(CNT,0)="<CompoundIngredientItemDescription>"_DESC_"</CompoundIngredientItemDescription>"
 ...I NRCODE'="",NRQUAL'="" D
 ....D C S @GL@(CNT,0)="<ItemNumber>"
 ....D C S @GL@(CNT,0)="<Code>"_NRCODE_"</Code>"
 ....D C S @GL@(CNT,0)="<Qualifier>"_NRQUAL_"</Qualifier>"
 ....D C S @GL@(CNT,0)="</ItemNumber>"
 ...I $L(STRVAL_STRFORM_STRUOM) D
 ....D C S @GL@(CNT,0)="<Strength>"
 ....D BL(GL,.CNT,"StrengthValue",STRVAL)
 ....D BL(GL,.CNT,"StrengthForm",STRFORM)
 ....D BL(GL,.CNT,"StrengthUnitOfMeasure",STRUOM)
 ....D C S @GL@(CNT,0)="</Strength>"
 ...I DEACODE'="" D
 ....D C S @GL@(CNT,0)="<DEASchedule>"
 ....D C S @GL@(CNT,0)="<Code>"_DEACODE_"</Code>"
 ....D C S @GL@(CNT,0)="</DEASchedule>"
 ...D C S @GL@(CNT,0)="</CompoundIngredient>"
 ..D
 ...D C S @GL@(CNT,0)="<Quantity>"
 ...D C S @GL@(CNT,0)="<Value>"_CQVAL_"</Value>"
 ...D C S @GL@(CNT,0)="<CodeListQualifier>"_CQCODQL_"</CodeListQualifier>"
 ...D C S @GL@(CNT,0)="<QuantityUnitOfMeasure>"
 ...D C S @GL@(CNT,0)="<Code>"_CQUOM_"</Code>"
 ...D C S @GL@(CNT,0)="</QuantityUnitOfMeasure>"
 ...D C S @GL@(CNT,0)="</Quantity>"
 ..I SVRSNCD'="" D
 ...D C S @GL@(CNT,0)="<DrugUseEvaluation>"
 ...D C S @GL@(CNT,0)="<ServiceReasonCode>"_SVRSNCD_"</ServiceReasonCode>"
 ...D BL(GL,.CNT,"ProfessionalServiceCode",PRSVCD)
 ...D BL(GL,.CNT,"ServiceResultCode",SVRSLTCD)
 ...I COAGCODE'="",COAGQUAL'="",COAGDESC'="" D
 ....D C S @GL@(CNT,0)="<CoAgent>"
 ....D C S @GL@(CNT,0)="<CoAgentCode>"
 ....D C S @GL@(CNT,0)="<Code>"_COAGCODE_"</Code>"
 ....D C S @GL@(CNT,0)="<Qualifier>"_COAGQUAL_"</Qualifier>"
 ....D C S @GL@(CNT,0)="<Description>"_COAGDESC_"</Description>"
 ....D C S @GL@(CNT,0)="</CoAgentCode>"
 ....D C S @GL@(CNT,0)="</CoAgent>"
 ...D BL(GL,.CNT,"ClinicalSignificanceCode",CLSIGCD)
 ...D BL(GL,.CNT,"AcknowledgementReason",ACKRSN)
 ...D C S @GL@(CNT,0)="</DrugUseEvaluation>"
 ..D C S @GL@(CNT,0)="</CompoundIngredientsLotNotUsed>"
 ..D C S @GL@(CNT,0)="<CompoundInformation>"
 ..D FIX(.GL,.CNT)
 Q
 ;
COMPINFD ;; For each field in ; fields - Field#,Variable
 ;;.02,DESC;.03,NRCODE;.04,NRQUAL;1.1,STRVAL;1.2,STRFORM;1.3,STRUOM;1.4,DEACODE
 ;;2.1,CQVAL;2.2,CQCODQL;2.3,CQUOM;3.1,SVRSNCD;3.2,PRSVCD;3.3,SVRSLTCD;3.4,COAGCODE;3.5,COAGQUAL
 ;;3.6,CLSIGCD;3.7,ACKRSN;4,COAGDESC
 ;;DONE
 ;
OTITDSMS(GL,CNT,ERXIEN,MIEN) ; Titration
 N ADTIVA,F,FIELD,I,J,LOINVERS,MAMEVA,MEASNOTE,MEDUCLTE,MEDUCO,MEDUQU,MEDUTE,MEDUTRCO
 N MEDUTRQU,MEDUTRTE,MEDUVA,MEFRNUVA,MEFRUNCO,MEFRUNQU,MEFRUNTE,MEINMO,MEINNUV1
 N MEINUNCO,MEINUNQU,MEINUNTE,METICLTE,METIEVCO,METIEVQU,METIEVTE,METIMOCO,METIMOQU
 N METIMOTE,METIUNCO,METIUNQU,METIUNTE,METIVA,MEVAFRMO,MFNV2,MIENS,MIMEVA,MINV2
 N PHTOTRDO,TDIEN,TDIENS,TXT,UCUMVERS,UNOFME,VALUE,VAMETIMO,VAR,VITASIGN
 S F=52.49311
 S MIENS=MIEN_","_ERXIEN_","
 D GETS^DIQ(F,MIENS,49.1,"E","TDDAT")
 S PHTOTRDO=$G(TDDAT(F,MIENS,49.1,"E"))
 S F=52.4931151
 S TDIEN=0 F  S TDIEN=$O(^PS(52.49,ERXIEN,311,MIEN,51,TDIEN)) Q:'TDIEN  D
 .K TDDAT
 .S TDIENS=TDIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,TDIENS,"**","E","TDDAT")
 .F I=1:1 S TXT=$P($T(OTITDSMD+I),";;",2) Q:TXT="DONE"  D
 ..F J=1:1:$L(TXT,";") D
 ...S FIELD=$P(TXT,";",J),VAR=$P(FIELD,",",2),FIELD=$P(FIELD,",")
 ...S @VAR=$G(TDDAT(F,TDIENS,FIELD,"E"))
 .D C S @GL@(CNT,0)="<Titration>"
 .D BL(GL,.CNT,"PharmacyToTitrateDose",PHTOTRDO)
 .D C S @GL@(CNT,0)="<TitrationDose>"
 .I VITASIGN'="",LOINVERS'="",VALUE'="",UNOFME'="",UCUMVERS'="" D
 ..D C S @GL@(CNT,0)="<Measurement>"
 ..D C S @GL@(CNT,0)="<VitalSign>"_VITASIGN_"</VitalSign>"
 ..D C S @GL@(CNT,0)="<LOINCVersion>"_LOINVERS_"</LOINCVersion>"
 ..D C S @GL@(CNT,0)="<Value>"_VALUE_"</Value>"
 ..D C S @GL@(CNT,0)="<UnitOfMeasure>"_UNOFME_"</UnitOfMeasure>"
 ..D C S @GL@(CNT,0)="<UCUMVersion>"_UCUMVERS_"</UCUMVersion>"
 ..D BL(GL,.CNT,"MinimumMeasurementValue",MIMEVA)
 ..D BL(GL,.CNT,"MaximumMeasurementValue",MAMEVA)
 ..D BL(GL,.CNT,"MeasurementNotes",MEASNOTE)
 ..D C S @GL@(CNT,0)="</Measurement>"
 .D C S @GL@(CNT,0)="<MeasurementTimingAndDuration>"
 .D C S @GL@(CNT,0)="<MeasurementAdministrationTiming>"
 .I METIVA'="",VAMETIMO'="",METIUNTE'="",METIUNQU'="",METIUNCO'="" D  ; Sequence
 ..D C S @GL@(CNT,0)="<MeasurementTimingNumericValue>"_METIVA_"</MeasurementTimingNumericValue>"
 ..D C S @GL@(CNT,0)="<VariableMeasurementTimingModifier>"_VAMETIMO_"</VariableMeasurementTimingModifier>"
 ..D BL(GL,.CNT,"AdministrationTimingNumericValue",ADTIVA)
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"MeasurementTimingUnits",METIUNTE,METIUNQU,METIUNCO)
 .I METIMOTE'="",METIMOQU'="",METIMOCO'="" D
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"MeasurementTimingModifier",METIMOTE,METIMOQU,METIMOCO)
 .I METIEVTE'="",METIEVQU'="",METIEVCO'="" D
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"MeasurementTimingEvent",METIEVTE,METIEVQU,METIEVCO)
 .D BL(GL,.CNT,"MeasurementTimingClarifyingFreeText",METICLTE)
 .D C S @GL@(CNT,0)="</MeasurementAdministrationTiming>"
 .I MEFRNUVA'="",MEFRUNTE'="",MEFRUNQU'="",MEFRUNCO'="" D
 ..D C S @GL@(CNT,0)="<MeasurementFrequency>"
 ..D C S @GL@(CNT,0)="<MeasurementFrequencyNumericValue>"_MEFRNUVA_"</MeasurementFrequencyNumericValue>"
 ..I MEVAFRMO'="",MFNV2'="" D  ; Sequence
 ...D BL(GL,.CNT,"MeasurementVariableFrequencyModifier",MEVAFRMO)
 ..D BL(GL,.CNT,"MeasurementFrequencyNumericValue",MFNV2)
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"MeasurementFrequencyUnits",MEFRUNTE,MEFRUNQU,MEFRUNCO)
 ..D C S @GL@(CNT,0)="</MeasurementFrequency>"
 .I MEINNUV1'="",MEINUNTE'="",MEINUNQU'="",MEINUNCO'="" D
 ..D C S @GL@(CNT,0)="<MeasurementInterval>"
 ..D C S @GL@(CNT,0)="<MeasurementIntervalNumericValue>"_MEINNUV1_"</MeasurementIntervalNumericValue>"
 ..I MEINMO'="",MINV2'="" D  ; Sequence
 ...D C S @GL@(CNT,0)="<MeasurementVariableIntervalModifier>"_MEINMO_"</MeasurementVariableIntervalModifier>"
 ...D C S @GL@(CNT,0)="<MeasurementIntervalNumericValue>"_MINV2_"</MeasurementIntervalNumericValue>"
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"MeasurementIntervalUnits",MEINUNTE,MEINUNQU,MEINUNCO)
 ..D C S @GL@(CNT,0)="</MeasurementInterval>"
 .I MEDUVA'="",MEDUTE'="",MEDUQU'="",MEDUCO'="" D
 ..D C S @GL@(CNT,0)="<MeasurementDuration>"
 ..D C S @GL@(CNT,0)="<MeasurementDurationNumericValue>"_MEDUVA_"</MeasurementDurationNumericValue>"
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"MeasurementDurationText",MEDUTE,MEDUQU,MEDUCO)
 ..D C S @GL@(CNT,0)="</MeasurementDuration>"
 .I MEDUTRTE'="",MEDUTRQU'="",MEDUTRCO'="" D
 ..D C S @GL@(CNT,0)="<MeasurementDurationTrigger>"
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"MeasurementTrigger",MEDUTRTE,MEDUTRQU,MEDUTRCO)
 ..D BL(GL,.CNT,"MeasurementDurationClarifyingFreeText",MEDUCLTE)
 ..D C S @GL@(CNT,0)="</MeasurementDurationTrigger>"
 .D C S @GL@(CNT,0)="</MeasurementTimingAndDuration>"
 .D C S @GL@(CNT,0)="</TitrationDose>"
 .D C S @GL@(CNT,0)="</Titration>"
 .D FIX(.GL,.CNT)
 Q
 ;
OTITDSMD ;; For each field in ; fields - Field#,Variable
 ;;1,VITASIGN;2,LOINVERS;3,VALUE;4,UNOFME;5.1,MIMEVA;5.2,MAMEVA;6,MEASNOTE;7.1,METIVA
 ;;7.2,VAMETIMO;7.3,ADTIVA;8,METIUNTE;9,METIUNQU;10,METIUNCO;11,METIMOTE;12,METIMOQU;13,METIMOCO
 ;;14,METIEVTE;15,METIEVQU;16,METIEVCO;17,METICLTE;18.1,MEFRNUVA;18.2,MEVAFRMO;18.3,MFNV2
 ;;19,MEFRUNTE;20,MEFRUNQU;21,MEFRUNCO;22.1,MEINNUV1;22.2,MEINMO;22.3,MINV2;23,MEINUNTE
 ;;24,MEINUNQU;25,MEINUNCO;26,MEDUVA;27,MEDUTE;28,MEDUQU;29,MEDUCO;30,MEDUTRTE;31,MEDUTRQU
 ;;32,MEDUTRCO;33,MEDUCLTE;34,UCUMVERS
 ;;DONE
 ;
BL(GBL,CNT,TAG,VAR) ;
 Q:VAR=""
 D C S @GBL@(CNT,0)="<"_TAG_">"_$$SYMENC^MXMLUTL(VAR)_"</"_TAG_">"
 Q
 ;
C ;
 S CNT=$G(CNT)+1
 Q
 ;
FIX(GL,CNT) ; Remove empty structures
 N FLG,GL2,I,TXT,TXT2
 F  D  Q:'FLG  ; Keep removing empty structures until there are no more
 .S FLG=0
 .F I=1:1:CNT-1 D
 ..S TXT=@GL@(I,0),TXT2=$G(@GL@(I+1,0))
 ..I TXT2=("</"_$E(TXT,2,$L(TXT))) D
 ...K @GL@(I),@GL@(I+1)
 ...S FLG=1,I=I+1
 .I FLG D
 ..S GL2=0,I=""
 ..F  S I=$O(@GL@(I)) Q:I=""  D
 ...;/JSG/ PSO*7.0*581 - BEGIN CHANGE (Remove $I)
 ...S TXT=@GL@(I,0),GL2=GL2+1,GL2(GL2,0)=TXT
 ...;/JSG/ - END CHANGE
 ..S CNT=GL2
 ..K @GL M @GL=GL2 K GL2
 Q
