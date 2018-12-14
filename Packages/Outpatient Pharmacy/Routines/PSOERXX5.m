PSOERXX5 ;ALB/BWF - eRx xml utilities ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,508**;DEC 1997;Build 295
 ;
 Q
STRUCSIG(GBL,IENS) ;
 N SSPN,MSM,SV,FMTV,SFTSI,SFT,DCI,DDM,DDMCQ,DDMC,DDMMT,DDMMCQ,DDMMC,MDRFLG,MDVAR
 N DQ,DFT,DFCQ,DFC,DRM,DBMV,DBUM,DBUMCQ,DBUC,BMQ,BMV,CDM,CDUMT,CDUMCQ,CDUMC,DBRM
 N VN,VNCQ,VUMT,VUMCQ,VUMC,MVM,RAT,RACQ,RAC,MRAM,SAT,SACQ,SAC,MATM,RM,RUMT,INDFLG,INDVAR
 N RUMCQ,RUMC,TPBT,TPBCQ,TPBC,FNV,FUT,FUCQ,FUC,VFM,INV,IUT,IUCQ,IUC,OR,DNV,DTEXT,DTCQ
 N DTC,MDRNV,MDRUT,MDRCQ,MDRUC,MDRVN,MDRVUT,MDRVUCQ,MDRVUC,MDRVDM,IPT,IPCQ,IPC,IT
 N F,ITCQ,ITC,IVT,IVU,IVUMT,IVUMCQ,IVUMC,IVM,STOPI,PDAT,ATC,ATCQ,ATT,TMATM,VIM,VNC,VQ
 N DOSEVAR,DOSEFLG,DCALFLG,DCALVAR,VFLG,VVAR,ROAFLG,ROAVAR,SOAFLG,SOAVAR,TIMFLG,TIMVAR,DURFLG,DURVAR
 S F=52.4911
 D GETS^DIQ(F,IENS,"**","IE","PDAT")
 D CONVXML^PSOERXX1("PDAT")
 S SSPN=$G(PDAT(F,IENS,.01,"E")),MSM=$G(PDAT(F,IENS,.02,"I")),SV=$G(PDAT(F,IENS,.03,"E"))
 S FMTV=$G(PDAT(F,IENS,.04,"E")),SFTSI=$G(PDAT(F,IENS,.05,"E")),SFT=$G(PDAT(F,IENS,1,"E"))
 S DCI=$G(PDAT(F,IENS,2.1,"E")),DDM=$G(PDAT(F,IENS,2.2,"E")),DDMCQ=$G(PDAT(F,IENS,2.3,"I"))
 S DDMC=$G(PDAT(F,IENS,2.4,"E")),DDMMT=$G(PDAT(F,IENS,2.5,"E")),DDMMCQ=$G(PDAT(F,IENS,2.7,"I")),DDMMC=$G(PDAT(F,IENS,2.6,"E"))
 S DQ=$G(PDAT(F,IENS,3.1,"E")),DFT=$G(PDAT(F,IENS,3.2,"E")),DFCQ=$G(PDAT(F,IENS,3.4,"I")),DFC=$G(PDAT(F,IENS,3.3,"E"))
 S DRM=$G(PDAT(F,IENS,3.5,"I")),DBMV=$G(PDAT(F,IENS,4.1,"E")),DBUM=$G(PDAT(F,IENS,4.2,"E")),DBUMCQ=$G(PDAT(F,IENS,4.4,"I"))
 S DBUC=$G(PDAT(F,IENS,4.3,"E")),BMQ=$G(PDAT(F,IENS,4.5,"I")),BMV=$G(PDAT(F,IENS,4.6,"E")),CDM=$G(PDAT(F,IENS,4.7,"E"))
 S CDUMT=$G(PDAT(F,IENS,4.8,"E")),CDUMCQ=$G(PDAT(F,IENS,4.11,"I")),CDUMC=$G(PDAT(F,IENS,4.9,"E")),DBRM=$G(PDAT(F,IENS,4.12,"I"))
 S VN=$G(PDAT(F,IENS,5.1,"E")),VNC=$G(PDAT(F,IENS,5.2,"E")),VNCQ=$G(PDAT(F,IENS,5.3,"I")),VQ=$G(PDAT(F,IENS,5.4,"E"))
 S VUMT=$G(PDAT(F,IENS,5.5,"E")),VUMCQ=$G(PDAT(F,IENS,5.7,"I")),VUMC=$G(PDAT(F,IENS,5.6,"E")),MVM=$G(PDAT(F,IENS,5.8,"I"))
 S RAT=$G(PDAT(F,IENS,6.1,"E")),RACQ=$G(PDAT(F,IENS,6.3,"I")),RAC=$G(PDAT(F,IENS,6.2,"E")),MRAM=$G(PDAT(F,IENS,6.4,"I"))
 S SAT=$G(PDAT(F,IENS,6.5,"E")),SACQ=$G(PDAT(F,IENS,6.7,"I")),SAC=$G(PDAT(F,IENS,6.7,"I")),MATM=$G(PDAT(F,IENS,6.8,"I"))
 S ATT=$G(PDAT(F,IENS,7.1,"E")),ATCQ=$G(PDAT(F,IENS,7.3,"I")),ATC=$G(PDAT(F,IENS,7.2,"E")),TMATM=$G(PDAT(F,IENS,7.4,"I"))
 S RM=$G(PDAT(F,IENS,7.5,"E")),RUMT=$G(PDAT(F,IENS,7.6,"E")),RUMCQ=$G(PDAT(F,IENS,7.8,"I")),RUMC=$G(PDAT(F,IENS,7.7,"E"))
 S TPBT=$G(PDAT(F,IENS,8.1,"E")),TPBCQ=$G(PDAT(F,IENS,8.3,"I")),TPBC=$G(PDAT(F,IENS,8.2,"E")),FNV=$G(PDAT(F,IENS,8.4,"E"))
 S FUT=$G(PDAT(F,IENS,8.5,"E")),FUCQ=$G(PDAT(F,IENS,8.7,"I")),FUC=$G(PDAT(F,IENS,8.6,"E")),VFM=$G(PDAT(F,IENS,8.8,"I")),INV=$G(PDAT(F,IENS,9.1,"E"))
 S IUT=$G(PDAT(F,IENS,9.2,"E")),IUCQ=$G(PDAT(F,IENS,9.4,"I")),IUC=$G(PDAT(F,IENS,9.3,"E")),VIM=$G(PDAT(F,IENS,9.5,"I"))
 S DNV=$G(PDAT(F,IENS,9.6,"E")),DTEXT=$G(PDAT(F,IENS,9.7,"E")),DTCQ=$G(PDAT(F,IENS,9.9,"I")),DTC=$G(PDAT(F,IENS,9.8,"E"))
 S MDRNV=$G(PDAT(F,IENS,10.1,"E")),MDRUT=$G(PDAT(F,IENS,10.2,"E")),MDRCQ=$G(PDAT(F,IENS,10.3,"I")),MDRUC=$G(PDAT(F,IENS,10.4,"E"))
 S MDRVN=$G(PDAT(F,IENS,10.5,"E")),MDRVUT=$G(PDAT(F,IENS,10.6,"E")),MDRVUCQ=$G(PDAT(F,IENS,10.8,"I")),MDRVUC=$G(PDAT(F,IENS,10.7,"E"))
 S MDRVDM=$G(PDAT(F,IENS,10.9,"I")),IPT=$G(PDAT(F,IENS,11.1,"E")),IPCQ=$G(PDAT(F,IENS,11.3,"I")),IPC=$G(PDAT(F,IENS,11.2,"E"))
 S IT=$G(PDAT(F,IENS,11.4,"E")),ITCQ=$G(PDAT(F,IENS,11.6,"I")),ITC=$G(PDAT(F,IENS,11.5,"E")),IVT=$G(PDAT(F,IENS,12.1,"E"))
 S IVU=$G(PDAT(F,IENS,12.2,"E")),IVUMT=$G(PDAT(F,IENS,12.3,"E")),IVUMCQ=$G(PDAT(F,IENS,12.5,"I"))
 S IVUMC=$G(PDAT(F,IENS,12.4,"E")),IVM=$G(PDAT(F,IENS,12.6,"I")),STOPI=$G(PDAT(F,IENS,12.7,"I"))
 D C S @GBL@(CNT,0)="<StructuredSIG>"
 D C S @GBL@(CNT,0)="<RepeatingSIG>"
 D C S @GBL@(CNT,0)="<SigSequencePositionNumber>"_SSPN_"</SigSequencePositionNumber>"
 I $L(MSM) D C S @GBL@(CNT,0)="<MultipleSigModifier>"_MSM_"</MultipleSigModifier>"
 D C S @GBL@(CNT,0)="</RepeatingSIG>"
 D C S @GBL@(CNT,0)="<CodeSystem>"
 I $L(SV) D C S @GBL@(CNT,0)="<SNOMEDVersion>"_SV_"</SNOMEDVersion>"
 I $L(FMTV) D C S @GBL@(CNT,0)="<FMTVersion>"_FMTV_"</FMTVersion>"
 D C S @GBL@(CNT,0)="</CodeSystem>"
 D C S @GBL@(CNT,0)="<FreeText>"
 I $L(SFTSI) D C S @GBL@(CNT,0)="<SigFreeTextStringIndicator>"_SFTSI_"</SigFreeTextStringIndicator>"
 I $L(SFT) D C S @GBL@(CNT,0)="<SigFreeText>"_SFT_"</SigFreeText>"
 D C S @GBL@(CNT,0)="</FreeText>"
 S DOSEFLG=0
 F DOSEVAR="DCI","DDM","DDMCQ","DDMC","DDMMT","DDMMCQ","DDMMC","DQ","DFT","DFCQ","DFC","DRM" D
 .I $L(@DOSEVAR) S DOSEFLG=1
 I DOSEFLG D C S @GBL@(CNT,0)="<Dose>"
 I $L(DCI) D C S @GBL@(CNT,0)="<DoseCompositeIndicator>"_DCI_"</DoseCompositeIndicator>"
 I $L(DDM) D C S @GBL@(CNT,0)="<DoseDeliveryMethodText>"_DDM_"</DoseDeliveryMethodText>"
 I $L(DDMCQ) D C S @GBL@(CNT,0)="<DoseDeliveryMethodCodeQualifier>"_DDMCQ_"</DoseDeliveryMethodCodeQualifier>"
 I $L(DDMC) D C S @GBL@(CNT,0)="<DoseDeliveryMethodCode>"_DDMC_"</DoseDeliveryMethodCode>"
 I $L(DDMMT) D C S @GBL@(CNT,0)="<DoseDeliveryMethodModifierText>"_DDMMT_"</DoseDeliveryMethodModifierText>"
 I $L(DDMMCQ) D C S @GBL@(CNT,0)="<DoseDeliveryMethodModifierCodeQualifier>"_DDMMCQ_"</DoseDeliveryMethodModifierCodeQualifier>"
 I $L(DDMMC) D C S @GBL@(CNT,0)="<DoseDeliveryMethodModifierCode>"_DDMMC_"</DoseDeliveryMethodModifierCode>"
 I $L(DQ) D C S @GBL@(CNT,0)="<DoseQuantity>"_DQ_"</DoseQuantity>"
 I $L(DFT) D C S @GBL@(CNT,0)="<DoseFormText>"_DFT_"</DoseFormText>"
 I $L(DFCQ) D C S @GBL@(CNT,0)="<DoseFormCodeQualifier>"_DFCQ_"</DoseFormCodeQualifier>"
 I $L(DFC) D C S @GBL@(CNT,0)="<DoseFormCode>"_DFC_"</DoseFormCode>"
 I $L(DRM) D C S @GBL@(CNT,0)="<DoseRangeModifier>"_DRM_"</DoseRangeModifier>"
 I DOSEFLG D C S @GBL@(CNT,0)="</Dose>"
 S DCALFLG=0
 F DCALVAR="DBMV","DBUM","DBUMCQ","DBUC","BMQ","BMV","CDM","CDUMT","CDUMCQ","CDUMC","DBRM" D
 .I $L(@DCALVAR) S DCALFLG=1
 I DCALFLG D C S @GBL@(CNT,0)="<DoseCalculation>"
 I $L(DBMV) D C S @GBL@(CNT,0)="<DosingBasisNumericValue>"_DBMV_"</DosingBasisNumericValue>"
 I $L(DBUM) D C S @GBL@(CNT,0)="<DosingBasisUnitofMeasureText>"_DBUM_"</DosingBasisUnitofMeasureText>"
 I $L(DBUMCQ) D C S @GBL@(CNT,0)="<DosingBasisUnitofMeasureCodeQualifier>"_DBUMCQ_"</DosingBasisUnitofMeasureCodeQualifier>"
 I $L(DBUC) D C S @GBL@(CNT,0)="<DosingBasisUnitofMeasureCode>"_DBUC_"</DosingBasisUnitofMeasureCode>"
 I $L(BMQ) D C S @GBL@(CNT,0)="<BodyMetricQualifier>"_BMQ_"</BodyMetricQualifier>"
 I $L(BMV) D C S @GBL@(CNT,0)="<BodyMetricValue>"_BMV_"</BodyMetricValue>"
 I $L(CDM) D C S @GBL@(CNT,0)="<CalculatedDoseNumeric>"_CDM_"</CalculatedDoseNumeric>"
 I $L(CDUMT) D C S @GBL@(CNT,0)="<CalculatedDoseUnitofMeasureText>"_CDUMT_"</CalculatedDoseUnitofMeasureText>"
 I $L(CDUMCQ) D C S @GBL@(CNT,0)="<CalculatedDoseUnitofMeasureCodeQualifier>"_CDUMCQ_"</CalculatedDoseUnitofMeasureCodeQualifier>"
 I $L(CDUMC) D C S @GBL@(CNT,0)="<CalculatedDoseUnitofMeasureCode>"_CDUMC_"</CalculatedDoseUnitofMeasureCode>"
 I $L(DBRM) D C S @GBL@(CNT,0)="<DosingBasisRangeModifier>"_DBRM_"</DosingBasisRangeModifier>"
 I DCALFLG D C S @GBL@(CNT,0)="</DoseCalculation>"
 S VFLG=0
 F VVAR="VN","VNCQ","VNC","VQ","VUMT","VUMCQ","VUMC","MVM" D
 .I $L(@VVAR) S VFLG=1
 I VFLG D C S @GBL@(CNT,0)="<Vehicle>"
 I $L(VN) D C S @GBL@(CNT,0)="<VehicleName>"_VN_"</VehicleName>"
 I $L(VNCQ) D C S @GBL@(CNT,0)="<VehicleNameCodeQualifier>"_VNCQ_"</VehicleNameCodeQualifier>"
 I $L(VNC) D C S @GBL@(CNT,0)="<VehicleNameCode>"_VNC_"</VehicleNameCode>"
 I $L(VQ) D C S @GBL@(CNT,0)="<VehicleQuantity>"_VQ_"</VehicleQuantity>"
 I $L(VUMT) D C S @GBL@(CNT,0)="<VehicleUnitOfMeasureText>"_VUMT_"</VehicleUnitOfMeasureText>"
 I $L(VUMCQ) D C S @GBL@(CNT,0)="<VehicleUnitOfMeasureCodeQualifier>"_VUMCQ_"</VehicleUnitOfMeasureCodeQualifier>"
 I $L(VUMC) D C S @GBL@(CNT,0)="<VehicleUnitOfMeasureCode>"_VUMC_"</VehicleUnitOfMeasureCode>"
 I $L(MVM) D C S @GBL@(CNT,0)="<MultipleVehicleModifier>"_MVM_"</MultipleVehicleModifier>"
 I VFLG D C S @GBL@(CNT,0)="</Vehicle>"
 S ROAFLG=0
 F ROAVAR="RAT","RACQ","RAC","MRAM" D
 .I $L(@ROAVAR) S ROAFLG=1
 I ROAFLG D C S @GBL@(CNT,0)="<RouteofAdministration>"
 I $L(RAT) D C S @GBL@(CNT,0)="<RouteofAdministrationText>"_RAT_"</RouteofAdministrationText>"
 I $L(RACQ) D C S @GBL@(CNT,0)="<RouteofAdministrationCodeQualifier>"_RACQ_"</RouteofAdministrationCodeQualifier>"
 I $L(RAC) D C S @GBL@(CNT,0)="<RouteofAdministrationCode>"_RAC_"</RouteofAdministrationCode>"
 I $L(MRAM) D C S @GBL@(CNT,0)="<MultipleRouteofAdministrationModifier>"_MRAM_"</MultipleRouteofAdministrationModifier>"
 I ROAFLG D C S @GBL@(CNT,0)="</RouteofAdministration>"
 S SOAFLG=0
 F SOAVAR="SAT","SACQ","SAC","MATM" D
 .I $L(@SOAVAR) S SOAFLG=1
 I SOAFLG D C S @GBL@(CNT,0)="<SiteofAdministration>"
 I $L(SAT) D C S @GBL@(CNT,0)="<SiteofAdministrationText>"_SAT_"</SiteofAdministrationText>"
 I $L(SACQ) D C S @GBL@(CNT,0)="<SiteofAdministrationCodeQualifier>"_SACQ_"</SiteofAdministrationCodeQualifier>"
 I $L(SAC) D C S @GBL@(CNT,0)="<SiteofAdministrationCode>"_SAC_"</SiteofAdministrationCode>"
 I $L(MATM) D C S @GBL@(CNT,0)="<MultipleAdministrationTimingModifier>"_MATM_"</MultipleAdministrationTimingModifier>"
 I SOAFLG D C S @GBL@(CNT,0)="</SiteofAdministration>"
 S TIMFLG=0
 F TIMVAR="ATT","ATCQ","ATC","TMATM","RM","RUMT","RUMCQ","RUMC","TPBT","TPBCQ","TPBC","FNV","FUT","FUCQ","FUC","VFM","INV","IUT","IUCQ","IUC","VIM" D
 .I $L(@TIMVAR) S TIMFLG=1
 I TIMFLG D C S @GBL@(CNT,0)="<Timing>"
 I $L(ATT) D C S @GBL@(CNT,0)="<AdministrationTimingText>"_ATT_"</AdministrationTimingText>"
 I $L(ATCQ) D C S @GBL@(CNT,0)="<AdministrationTimingCodeQualifier>"_ATCQ_"</AdministrationTimingCodeQualifier>"
 I $L(ATC) D C S @GBL@(CNT,0)="<AdministrationTimingCode>"_ATC_"</AdministrationTimingCode>"
 I $L(TMATM) D C S @GBL@(CNT,0)="<MultipleAdministrationTimingModifier>"_TMATM_"</MultipleAdministrationTimingModifier>"
 I $L(RM) D C S @GBL@(CNT,0)="<RateofAdministration>"_RM_"</RateofAdministration>"
 I $L(RUMT) D C S @GBL@(CNT,0)="<RateUnitofMeasureText>"_RUMT_"</RateUnitofMeasureText>"
 I $L(RUMCQ) D C S @GBL@(CNT,0)="<RateUnitofMeasureCodeQualifier>"_RUMCQ_"</RateUnitofMeasureCodeQualifier>"
 I $L(RUMC) D C S @GBL@(CNT,0)="<RateUnitofMeasureCode>"_RUMC_"</RateUnitofMeasureCode>"
 I $L(TPBT) D C S @GBL@(CNT,0)="<TimePeriodBasisText>"_TPBT_"</TimePeriodBasisText>"
 I $L(TPBCQ) D C S @GBL@(CNT,0)="<TimePeriodBasisCodeQualifier>"_TPBCQ_"</TimePeriodBasisCodeQualifier>"
 I $L(TPBC) D C S @GBL@(CNT,0)="<TimePeriodBasisCode>"_TPBC_"</TimePeriodBasisCode>"
 I $L(FNV) D C S @GBL@(CNT,0)="<FrequencyNumericValue>"_FNV_"</FrequencyNumericValue>"
 I $L(FUT) D C S @GBL@(CNT,0)="<FrequencyUnitsText>"_FUT_"</FrequencyUnitsText>"
 I $L(FUCQ) D C S @GBL@(CNT,0)="<FrequencyUnitsCodeQualifier>"_FUCQ_"</FrequencyUnitsCodeQualifier>"
 I $L(FUC) D C S @GBL@(CNT,0)="<FrequencyUnitsCode>"_FUC_"</FrequencyUnitsCode>"
 I $L(VFM) D C S @GBL@(CNT,0)="<VariableFrequencyModifier>"_VFM_"</VariableFrequencyModifier>"
 I $L(INV) D C S @GBL@(CNT,0)="<IntervalNumericValue>"_INV_"</IntervalNumericValue>"
 I $L(IUT) D C S @GBL@(CNT,0)="<IntervalUnitsText>"_IUT_"</IntervalUnitsText>"
 I $L(IUCQ) D C S @GBL@(CNT,0)="<IntervalUnitsCodeQualifier>"_IUCQ_"</IntervalUnitsCodeQualifier>"
 I $L(IUC) D C S @GBL@(CNT,0)="<IntervalUnitsCode>"_IUC_"</IntervalUnitsCode>"
 I $L(VIM) D C S @GBL@(CNT,0)="<VariableIntervalModifier>"_VIM_"</VariableIntervalModifier>"
 I TIMFLG D C S @GBL@(CNT,0)="</Timing>"
 S DURFLG=0
 F DURVAR="DNV","MVM","DTCQ","DTC" D
 .I $L(@DURVAR) S DURFLG=1
 I DURFLG D C S @GBL@(CNT,0)="<Duration>"
 I $L(DNV) D C S @GBL@(CNT,0)="<DurationNumericValue>"_DNV_"</DurationNumericValue>"
 I $L(MVM) D C S @GBL@(CNT,0)="<DurationText>"_DTEXT_"</DurationText>"
 I $L(DTCQ) D C S @GBL@(CNT,0)="<DurationTextCodeQualifier>"_DTCQ_"</DurationTextCodeQualifier>"
 I $L(DTC) D C S @GBL@(CNT,0)="<DurationTextCode>"_DTC_"</DurationTextCode>"
 I DURFLG D C S @GBL@(CNT,0)="</Duration>"
 S MDRFLG=0
 F MDVAR="MDRNV","MDRUT","MDRCQ","MDRUC","MDRVN","MDRVUT","MDRVUCQ","MDRVUC","MDRVDM" D
 .I $L(@MDVAR) S MDRFLG=1
 I MDRFLG D C S @GBL@(CNT,0)="<MaximumDoseRestriction>"
 I $L(MDRNV) D C S @GBL@(CNT,0)="<MaximumDoseRestrictionNumericValue>"_MDRNV_"</MaximumDoseRestrictionNumericValue>"
 I $L(MDRUT) D C S @GBL@(CNT,0)="<MaximumDoseRestrictionUnitsText>"_MDRUT_"</MaximumDoseRestrictionUnitsText>"
 I $L(MDRCQ) D C S @GBL@(CNT,0)="<MaximumDoseRestrictionCodeQualifier>"_MDRCQ_"</MaximumDoseRestrictionCodeQualifier>"
 I $L(MDRUC) D C S @GBL@(CNT,0)="<MaximumDoseRestrictionUnitsCode>"_MDRUC_"</MaximumDoseRestrictionUnitsCode>"
 I $L(MDRVN) D C S @GBL@(CNT,0)="<MaximumDoseRestrictionVariableNumericValue>"_MDRVN_"</MaximumDoseRestrictionVariableNumericValue>"
 I $L(MDRVUT) D C S @GBL@(CNT,0)="<MaximumDoseRestrictionVariableUnitsText>"_MDRVUT_"</MaximumDoseRestrictionVariableUnitsText>"
 I $L(MDRVUCQ) D C S @GBL@(CNT,0)="<MaximumDoseRestrictionVariableUnitsCodeQualifier>"_MDRVUCQ_"</MaximumDoseRestrictionVariableUnitsCodeQualifier>"
 I $L(MDRVUC) D C S @GBL@(CNT,0)="<MaximumDoseRestrictionVariableUnitsCode>"_MDRVUC_"</MaximumDoseRestrictionVariableUnitsCode>"
 I $L(MDRVDM) D C S @GBL@(CNT,0)="<MaximumDoseRestrictionVariableDurationModifier>"_MDRVDM_"</MaximumDoseRestrictionVariableDurationModifier>"
 I MDRFLG D C S @GBL@(CNT,0)="</MaximumDoseRestriction>"
 S INDFLG=0
 F INDVAR="IPT","IPCQ","IPC","IT","ITCQ","ITC","IVT","IVU","IVUMT","IVUMCQ","IVM" D
 .I $L(@INDVAR) S INDFLG=1
 I INDFLG D C S @GBL@(CNT,0)="<Indication>"
 I $L(IPT) D C S @GBL@(CNT,0)="<IndicationPrecursorText>"_IPT_"</IndicationPrecursorText>"
 I $L(IPCQ) D C S @GBL@(CNT,0)="<IndicationPrecursorCodeQualifier>"_IPCQ_"</IndicationPrecursorCodeQualifier>"
 I $L(IPC) D C S @GBL@(CNT,0)="<IndicationPrecursorCode>"_IPC_"</IndicationPrecursorCode>"
 I $L(IT) D C S @GBL@(CNT,0)="<IndicationText>"_IT_"</IndicationText>"
 I $L(ITCQ) D C S @GBL@(CNT,0)="<IndicationTextCodeQualifier>"_ITCQ_"</IndicationTextCodeQualifier>"
 I $L(ITC) D C S @GBL@(CNT,0)="<IndicationTextCode>"_ITC_"</IndicationTextCode>"
 I $L(IVT) D C S @GBL@(CNT,0)="<IndicationValueText>"_IVT_"</IndicationValueText>"
 I $L(IVU) D C S @GBL@(CNT,0)="<IndicationValueUnit>"_IVU_"</IndicationValueUnit>"
 I $L(IVUMT) D C S @GBL@(CNT,0)="<IndicationValueUnitofMeasureText>"_IVUMT_"</IndicationValueUnitofMeasureText>"
 I $L(IVUMCQ) D C S @GBL@(CNT,0)="<IndicationValueUnitofMeasureCodeQualifier>"_IVUMCQ_"</IndicationValueUnitofMeasureCodeQualifier>"
 I $L(IVUMC) D C S @GBL@(CNT,0)="<IndicationValueUnitofMeasureCode>"_IVUMC_"</IndicationValueUnitofMeasureCode>"
 I $L(IVM) D C S @GBL@(CNT,0)="<IndicationVariableModifier>"_IVM_"</IndicationVariableModifier>"
 I INDFLG D C S @GBL@(CNT,0)="</Indication>"
 I $L(STOPI) D
 .D C S @GBL@(CNT,0)="<Stop>"
 .D C S @GBL@(CNT,0)="<StopIndicator>"_STOPI_"</StopIndicator>"
 .D C S @GBL@(CNT,0)="</Stop>"
 D C S @GBL@(CNT,0)="</StructuredSIG>"
 Q
C ;
 S CNT=$G(CNT)+1
 Q
