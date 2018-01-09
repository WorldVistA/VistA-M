PSOERXA4 ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467**;DEC 1997;Build 153
 ;
 Q
SS(EIENS) ;Structured Sig
 N SSGL,STSIG,SIGSEQ,MSIGMOD,FTSIG,FTSIGSI,SNOMEDV,FMTV,DCIND,DDMC,DDMCQ,DDMMC,DDMMCQ,DDMTEXT,DFC,DFCQ,DFTEXT,DQTY,DRNGMOD
 N DCBMQ,DCBMV,DCCDN,DCCDUMC,DCCDUMCQ,DCCDUMT,DCDBNV,DCDBRM,DCDBUMC,DCDBUMCQ,DCDBUMT,DURNV,DURTXT,DURTXTC,DURTXTCQ
 N IIPC,IIPCQ,IIPCT,IIT,IITC,IITCQ,IIVT,IIVU,IIVUMC,IIVUMCQ,IIVUMT,IIVM,MDRNV,MDRNCQ,MDRUC,MDRUT,MDRVDM,MDRVNV,MDRVUC
 N MDRVUCQ,MDRVUT,ROAMRAM,ROAMC,ROAMCQ,ROAMT,SAMATM,SASAC,SASACQ,TATC,TATCQ,TATT,TFNV,TFUC,TFUCQ,TFUT,TINV,TIUC,TIUCQ
 N TIUT,TMATM,TRUMC,TRUMCQ,TRUMT,TRA,TTPBC,TTPBCQ,TTPBT,TVFM,TVIM,VMVM,VN,VNC,VNCQ,VQTY,VUMC,VUMCQ,VUMT,STSCNT,SAT
 N STIENS,SF
 S SF=52.4911
 ;S SSGL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,"NewRx",0,"MedicationPrescribed",0,"StructuredSIG"))
 S SSGL=$NA(^TMP($J,"PSOERXO1","SIG",0,"StructuredSIG"))
 S STSCNT=0
 S STSIG=-1 F  S STSIG=$O(@SSGL@(STSIG)) Q:STSIG=""  D
 .S STSCNT=STSCNT+1
 .S STIENS="+"_STSCNT_","_EIENS
 .S SIGSEQ=$G(@SSGL@(STSIG,"RepeatingSIG",0,"SigSequencePositionNumber",0)),SFDA(SF,STIENS,.01)=SIGSEQ
 .S MSIGMOD=$G(@SSGL@(STSIG,"RepeatingSIG",0,"MultipleSigModifier",0)),SFDA(SF,STIENS,.02)=MSIGMOD
 .S FTSIG=$G(@SSGL@(STSIG,"FreeText",0,"SigFreeText",0)),SFDA(SF,STIENS,1)=FTSIG
 .S FTSIGSI=$G(@SSGL@(STSIG,"FreeText",0,"SigFreeTextStringIndicator",0)),SFDA(SF,STIENS,.05)=FTSIGSI
 .S SNOMEDV=$G(@SSGL@(STSIG,"CodeSystem",0,"SNOMEDVersion",0)),SFDA(SF,STIENS,.03)=SNOMEDV
 .S FMTV=$G(@SSGL@(STSIG,"CodeSystem",0,"FMTVersion",0)),SFDA(SF,STIENS,.04)=FMTV
 .; dose section
 .S DCIND=$G(@SSGL@(STSIG,"Dose",0,"DoseCompositeIndicator",0)),SFDA(SF,STIENS,2.1)=DCIND
 .S DDMC=$G(@SSGL@(STSIG,"Dose",0,"DoseDeliveryMethodCode",0)),SFDA(SF,STIENS,2.4)=DDMC
 .S DDMCQ=$G(@SSGL@(STSIG,"Dose",0,"DoseDeliveryMethodCodeQualifier",0)),SFDA(SF,STIENS,2.3)=DDMCQ
 .S DDMMC=$G(@SSGL@(STSIG,"Dose",0,"DoseDeliveryMethodModifierCode",0)),SFDA(SF,STIENS,2.6)=DDMMC
 .S DDMMCQ=$G(@SSGL@(STSIG,"Dose",0,"DoseDeliveryMethodModifierCodeQualifier",0)),SFDA(SF,STIENS,2.7)=DDMMCQ
 .S DDMTEXT=$G(@SSGL@(STSIG,"Dose",0,"DoseDeliveryMethodText",0)),SFDA(SF,STIENS,2.2)=DDMTEXT
 .S DFC=$G(@SSGL@(STSIG,"Dose",0,"DoseFormCode",0)),SFDA(SF,STIENS,3.3)=DFC
 .S DFCQ=$G(@SSGL@(STSIG,"Dose",0,"DoseFormCodeQualifier",0)),SFDA(SF,STIENS,3.4)=DFCQ
 .S DFTEXT=$G(@SSGL@(STSIG,"Dose",0,"DoseFormText",0)),SFDA(SF,STIENS,3.2)=DFTEXT
 .S DQTY=$G(@SSGL@(STSIG,"Dose",0,"DoseQuantity",0)),SFDA(SF,STIENS,3.1)=DQTY
 .S DRNGMOD=$G(@SSGL@(STSIG,"Dose",0,"DoseRangeModifier",0)),SFDA(SF,STIENS,3.5)=DRNGMOD
 .; dose calcuation section
 .S DCBMQ=$G(@SSGL@(STSIG,"DoseCalculation",0,"BodyMetricQualifier",0)),SFDA(SF,STIENS,4.5)=DCBMQ
 .S DCBMV=$G(@SSGL@(STSIG,"DoseCalculation",0,"BodyMetricValue",0)),SFDA(SF,STIENS,4.6)=DCBMV
 .S DCCDN=$G(@SSGL@(STSIG,"DoseCalculation",0,"CalculatedDoseNumeric",0)),SFDA(SF,STIENS,4.7)=DCCDN
 .S DCCDUMC=$G(@SSGL@(STSIG,"DoseCalculation",0,"CalculatedDoseUnitofMeasureCode",0)),SFDA(SF,STIENS,4.9)=DCCDUMC
 .S DCCDUMCQ=$G(@SSGL@(STSIG,"DoseCalculation",0,"CalculatedDoseUnitofMeasureCodeQualifier",0)),SFDA(SF,STIENS,4.11)=DCCDUMCQ
 .S DCCDUMT=$G(@SSGL@(STSIG,"DoseCalculation",0,"CalculatedDoseUnitofMeasureText",0)),SFDA(SF,STIENS,4.8)=DCCDUMT
 .S DCDBNV=$G(@SSGL@(STSIG,"DoseCalculation",0,"DosingBasisNumericValue",0)),SFDA(SF,STIENS,4.1)=DCDBNV
 .S DCDBRM=$G(@SSGL@(STSIG,"DoseCalculation",0,"DosingBasisRangeModifier",0)),SFDA(SF,STIENS,4.12)=DCDBRM
 .S DCDBUMC=$G(@SSGL@(STSIG,"DoseCalculation",0,"DosingBasisUnitofMeasureCode",0)),SFDA(SF,STIENS,4.3)=DCDBUMC
 .S DCDBUMCQ=$G(@SSGL@(STSIG,"DoseCalculation",0,"DosingBasisUnitofMeasureCodeQualifier",0)),SFDA(SF,STIENS,4.4)=DCDBUMCQ
 .S DCDBUMT=$G(@SSGL@(STSIG,"DoseCalculation",0,"DosingBasisUnitofMeasureText",0)),SFDA(SF,STIENS,4.2)=DCDBUMT
 .; duration
 .S DURNV=$G(@SSGL@(STSIG,"Duration",0,"DurationNumericValue",0)),SFDA(SF,STIENS,9.6)=DURNV
 .S DURTXT=$G(@SSGL@(STSIG,"Duration",0,"DurationText",0)),SFDA(SF,STIENS,9.7)=DURTXT
 .S DURTXTC=$G(@SSGL@(STSIG,"Duration",0,"DurationTextCode",0)),SFDA(SF,STIENS,9.8)=DURTXTC
 .S DURTXTCQ=$G(@SSGL@(STSIG,"Duration",0,"DurationTextCodeQualifier",0)),SFDA(SF,STIENS,9.9)=DURTXTCQ
 .; indication
 .S IIPC=$G(@SSGL@(STSIG,"Indication",0,"IndicationPrecursorCode",0)),SFDA(SF,STIENS,11.2)=IIPC
 .S IIPCQ=$G(@SSGL@(STSIG,"Indication",0,"IndicationPrecursorCodeQualifier",0)),SFDA(SF,STIENS,11.3)=IIPCQ
 .S IIPCT=$G(@SSGL@(STSIG,"Indication",0,"IndicationPrecursorText",0)),SFDA(SF,STIENS,11.1)=IIPCT
 .S IIT=$G(@SSGL@(STSIG,"Indication",0,"IndicationText",0)),SFDA(SF,STIENS,11.4)=IIT
 .S IITC=$G(@SSGL@(STSIG,"Indication",0,"IndicationTextCode",0)),SFDA(SF,STIENS,11.5)=IITC
 .S IITCQ=$G(@SSGL@(STSIG,"Indication",0,"IndicationTextCodeQualifier",0)),SFDA(SF,STIENS,11.6)=IITCQ
 .S IIVT=$G(@SSGL@(STSIG,"Indication",0,"IndicationValueText",0)),SFDA(SF,STIENS,12.1)=IIVT
 .S IIVU=$G(@SSGL@(STSIG,"Indication",0,"IndicationValueUnit",0)),SFDA(SF,STIENS,12.2)=IIVU
 .S IIVUMC=$G(@SSGL@(STSIG,"Indication",0,"IndicationValueUnitofMeasureCode",0)),SFDA(SF,STIENS,12.4)=IIVUMC
 .S IIVUMCQ=$G(@SSGL@(STSIG,"Indication",0,"IndicationValueUnitofMeasureCodeQualifier",0)),SFDA(SF,STIENS,12.5)=IIVUMCQ
 .S IIVUMT=$G(@SSGL@(STSIG,"Indication",0,"IndicationValueUnitofMeasureText",0)),SFDA(SF,STIENS,12.3)=IIVUMT
 .S IIVM=$G(@SSGL@(STSIG,"Indication",0,"IndicationVariableModifier",0)),SFDA(SF,STIENS,12.6)=IIVM
 .; Maximum Dose Restriction
 .S MDRNV=$G(@SSGL@(STSIG,"MaximumDoseRestriction",0,"MaximumDoseRestrictionNumericValue",0)),SFDA(SF,STIENS,10.1)=MDRNV
 .S MDRNCQ=$G(@SSGL@(STSIG,"MaximumDoseRestriction",0,"MaximumDoseRestrictionCodeQualifier",0)),SFDA(SF,STIENS,10.3)=MDRNCQ
 .S MDRUC=$G(@SSGL@(STSIG,"MaximumDoseRestriction",0,"MaximumDoseRestrictionUnitsCode",0)),SFDA(SF,STIENS,10.4)=MDRUC
 .S MDRUT=$G(@SSGL@(STSIG,"MaximumDoseRestriction",0,"MaximumDoseRestrictionUnitsText",0)),SFDA(SF,STIENS,10.2)=MDRUT
 .S MDRVDM=$G(@SSGL@(STSIG,"MaximumDoseRestriction",0,"MaximumDoseRestrictionVariableDurationModifier",0)),SFDA(SF,STIENS,10.9)=MDRVDM
 .S MDRVNV=$G(@SSGL@(STSIG,"MaximumDoseRestriction",0,"MaximumDoseRestrictionVariableNumericValue",0)),SFDA(SF,STIENS,10.5)=MDRVNV
 .S MDRVUC=$G(@SSGL@(STSIG,"MaximumDoseRestriction",0,"MaximumDoseRestrictionVariableUnitsCode",0)),SFDA(SF,STIENS,10.7)=MDRVUC
 .S MDRVUCQ=$G(@SSGL@(STSIG,"MaximumDoseRestriction",0,"MaximumDoseRestrictionVariableUnitsCodeQualifier",0)),SFDA(SF,STIENS,10.8)=MDRVUCQ
 .S MDRVUT=$G(@SSGL@(STSIG,"MaximumDoseRestriction",0,"MaximumDoseRestrictionVariableUnitsText",0)),SFDA(SF,STIENS,10.6)=MDRVUT
 .; Route of Administration
 .S ROAMRAM=$G(@SSGL@(STSIG,"RouteOfAdministration",0,"MultipleRouteofAdministrationModifier",0)),SFDA(SF,STIENS,6.4)=ROAMRAM
 .S ROAMC=$G(@SSGL@(STSIG,"RouteOfAdministration",0,"RouteofAdministrationCode",0)),SFDA(SF,STIENS,6.2)=ROAMC
 .S ROAMCQ=$G(@SSGL@(STSIG,"RouteOfAdministration",0,"RouteofAdministrationCodeQualifier",0)),SFDA(SF,STIENS,6.3)=ROAMCQ
 .S ROAMT=$G(@SSGL@(STSIG,"RouteOfAdministration",0,"RouteofAdministrationText",0)),SFDA(SF,STIENS,6.1)=ROAMT
 .; site of Administration
 .S SAMATM=$G(@SSGL@(STSIG,"SiteofAdministration",0,"MultipleAdministrationTimingModifier",0)),SFDA(SF,STIENS,6.8)=SAMATM
 .S SASAC=$G(@SSGL@(STSIG,"SiteofAdministration",0,"SiteofAdministrationCode",0)),SFDA(SF,STIENS,6.6)=SASAC
 .S SASACQ=$G(@SSGL@(STSIG,"SiteofAdministration",0,"SiteofAdministrationCodeQualifier",0)),SFDA(SF,STIENS,6.7)=SASACQ
 .S SAT=$G(@SSGL@(STSIG,"SiteofAdministration",0,"SiteofAdministrationText",0)),SFDA(SF,STIENS,6.5)=SAT
 .; Timing
 .S TATC=$G(@SSGL@(STSIG,"Timing",0,"AdministrationTimingCode",0)),SFDA(SF,STIENS,7.2)=TATC
 .S TATCQ=$G(@SSGL@(STSIG,"Timing",0,"AdministrationTimingCodeQualifier",0)),SFDA(SF,STIENS,7.3)=TATCQ
 .S TATT=$G(@SSGL@(STSIG,"Timing",0,"AdministrationTimingText",0)),SFDA(SF,STIENS,7.1)=TATT
 .S TFNV=$G(@SSGL@(STSIG,"Timing",0,"FrequencyNumericValue",0)),SFDA(SF,STIENS,8.4)=TFNV
 .S TFUC=$G(@SSGL@(STSIG,"Timing",0,"FrequencyUnitsCode",0)),SFDA(SF,STIENS,8.6)=TFUC
 .S TFUCQ=$G(@SSGL@(STSIG,"Timing",0,"FrequencyUnitsCodeQualifier",0)),SFDA(SF,STIENS,8.7)=TFUCQ
 .S TFUT=$G(@SSGL@(STSIG,"Timing",0,"FrequencyUnitsText",0)),SFDA(SF,STIENS,8.5)=TFUT
 .S TINV=$G(@SSGL@(STSIG,"Timing",0,"IntervalNumericValue",0)),SFDA(SF,STIENS,9.1)=TINV
 .S TIUC=$G(@SSGL@(STSIG,"Timing",0,"IntervalUnitsCode",0)),SFDA(SF,STIENS,9.3)=TIUC
 .S TIUCQ=$G(@SSGL@(STSIG,"Timing",0,"IntervalUnitsCodeQualifier",0)),SFDA(SF,STIENS,9.4)=TIUCQ
 .S TIUT=$G(@SSGL@(STSIG,"Timing",0,"IntervalUnitsText",0)),SFDA(SF,STIENS,9.2)=TIUT
 .S TMATM=$G(@SSGL@(STSIG,"Timing",0,"MultipleAdministrationTimingModifier",0)),SFDA(SF,STIENS,7.4)=TMATM
 .S TRUMC=$G(@SSGL@(STSIG,"Timing",0,"RateUnitofMeasureCode",0)),SFDA(SF,STIENS,7.7)=TRUMC
 .S TRUMCQ=$G(@SSGL@(STSIG,"Timing",0,"RateUnitofMeasureCodeQualifier",0)),SFDA(SF,STIENS,7.8)=TRUMCQ
 .S TRUMT=$G(@SSGL@(STSIG,"Timing",0,"RateUnitofMeasureText",0)),SFDA(SF,STIENS,7.6)=TRUMT
 .S TRA=$G(@SSGL@(STSIG,"Timing",0,"RateofAdministration",0)),SFDA(SF,STIENS,7.5)=TRA
 .S TTPBC=$G(@SSGL@(STSIG,"Timing",0,"TimePeriodBasisCode",0)),SFDA(SF,STIENS,8.2)=TTPBC
 .S TTPBCQ=$G(@SSGL@(STSIG,"Timing",0,"TimePeriodBasisCodeQualifier",0)),SFDA(SF,STIENS,8.3)=TTPBCQ
 .S TTPBT=$G(@SSGL@(STSIG,"Timing",0,"TimePeriodBasisText",0)),SFDA(SF,STIENS,8.1)=TTPBT
 .S TVFM=$G(@SSGL@(STSIG,"Timing",0,"VariableFrequencyModifier",0)),SFDA(SF,STIENS,8.8)=TVFM
 .S TVIM=$G(@SSGL@(STSIG,"Timing",0,"VariableIntervalModifier",0)),SFDA(SF,STIENS,9.5)=TVIM
 .; Vehicle
 .S VMVM=$G(@SSGL@(STSIG,"Vehicle",0,"MultipleVehicleModifier",0)),SFDA(SF,STIENS,5.8)=VMVM
 .S VN=$G(@SSGL@(STSIG,"Vehicle",0,"VehicleName",0)),SFDA(SF,STIENS,5.1)=VN
 .S VNC=$G(@SSGL@(STSIG,"Vehicle",0,"VehicleNameCode",0)),SFDA(SF,STIENS,5.2)=VNC
 .S VNCQ=$G(@SSGL@(STSIG,"Vehicle",0,"VehicleNameCodeQualifier",0)),SFDA(SF,STIENS,5.3)=VNCQ
 .S VQTY=$G(@SSGL@(STSIG,"Vehicle",0,"VehicleQuantity",0)),SFDA(SF,STIENS,5.4)=VQTY
 .S VUMC=$G(@SSGL@(STSIG,"Vehicle",0,"VehicleUnitofMeasureCode",0)),SFDA(SF,STIENS,5.6)=VUMC
 .S VUMCQ=$G(@SSGL@(STSIG,"Vehicle",0,"VehicleUnitofMeasureCodeQualifier",0)),SFDA(SF,STIENS,5.7)=VUMCQ
 .S VUMT=$G(@SSGL@(STSIG,"Vehicle",0,"VehicleUnitofMeasureText",0)),SFDA(SF,STIENS,5.5)=VUMT
 .D UPDATE^DIE(,"SFDA") K SFDA
 Q
