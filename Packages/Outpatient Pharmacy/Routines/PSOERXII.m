PSOERXII ;ALB/BWF - eRx Utilities/RPC's ; 12/6/2019 1:14pm
 ;;7.0;OUTPATIENT PHARMACY;**581,635**;DEC 1997;Build 19
 ;
 Q
SIG(ERXIEN,MIEN,SIGTEXT) ;
 N SCNT,SIGARY
 K ^TMP($J,"SIG")
 D TXT2ARY^PSOERXD1(.SIGARY,SIGTEXT,,80)
 S SCNT=0 F  S SCNT=$O(SIGARY(SCNT)) Q:SCNT=""  D
 .S ^TMP($J,"SIG",SCNT)=$G(SIGARY(SCNT))
 D WP^DIE(52.49311,MIEN_","_ERXIEN_",",8,"KA","^TMP($J,""SIG"")")
 K ^TMP($J,"SIG")
 Q
IFU(ERXIEN,MIEN,MTYPE,MEDTYPE) ;
 N GLIFU,IFU1,IFU1CNT,IFUIENS,IFUIPC,IFUIPQ,IFUIPT,IFUIC,IFUIQ,IFUIT,IFUIVC,IFUIVQ,IFU1IVC
 N IVM,IVU1IVQ,IVUIVT,IVUC,IVUQ,IVUT,IVUOMC,IVUOMQ,IVUOMT,FDA,IFU1IVQ,IFU1IVT,IFUIVT,IFUSF
 S GLIFU=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0,"Sig",0,"IndicationForUse",0))
 S IFUSF=52.4931113
 S IFU1=-1 F  S IFU1=$O(@GLIFU@(IFU1)) Q:IFU1=""  D
 .S IFU1CNT=$G(IFU1CNT)+1
 .S IFUIENS="+"_IFU1CNT_","_MIEN_","_ERXIEN_","
 .S FDA(IFUSF,IFUIENS,.01)=IFU1CNT
 .S IFUIPC=$G(@GLIFU@("IndicationPrecursor",0,"Code",0)),FDA(IFUSF,IFUIENS,1)=IFUIPC
 .S IFUIPQ=$G(@GLIFU@("IndicationPrecursor",0,"Qualifier",0)),FDA(IFUSF,IFUIENS,2)=IFUIPQ
 .S IFUIPT=$G(@GLIFU@("IndicationPrecursor",0,"Text",0)),FDA(IFUSF,IFUIENS,3)=IFUIPT
 .S IFUIC=$G(@GLIFU@("Indication",0,"Code",0)),FDA(IFUSF,IFUIENS,4)=IFUIC
 .S IFUIQ=$G(@GLIFU@("Indication",0,"Qualifier",0)),FDA(IFUSF,IFUIENS,5)=IFUIQ
 .S IFUIT=$G(@GLIFU@("Indication",0,"Text",0)),FDA(IFUSF,IFUIENS,6)=IFUIT
 .S IFUIVC=$G(@GLIFU@("IndicationValue",0,"Code",0)),FDA(IFUSF,IFUIENS,7)=IFUIVC
 .S IFUIVQ=$G(@GLIFU@("IndicationValue",0,"Qualifier",0)),FDA(IFUSF,IFUIENS,8)=IFUIVQ
 .S IFUIVT=$G(@GLIFU@("IndicationValue",0,"Text",0)),FDA(IFUSF,IFUIENS,9)=IFUIVT
 .S IFU1IVC=$G(@GLIFU@("IndicationValue",1,"Code",0)),FDA(IFUSF,IFUIENS,11)=IFU1IVC
 .S IVM=$G(@GLIFU@("IndicationVariableModifier",0)),FDA(IFUSF,IFUIENS,10)=IVM
 .S IFU1IVQ=$G(@GLIFU@("IndicationValue",1,"Qualifier",0)),FDA(IFUSF,IFUIENS,12)=IFU1IVQ
 .S IFU1IVT=$G(@GLIFU@("IndicationValue",1,"Text",0)),FDA(IFUSF,IFUIENS,13)=IFU1IVT
 .S IVUC=$G(@GLIFU@("IndicationValueUnit",0,"Code",0)),FDA(IFUSF,IFUIENS,14)=IVUC
 .S IVUQ=$G(@GLIFU@("IndicationValueUnit",0,"Qualifier",0)),FDA(IFUSF,IFUIENS,15)=IVUQ
 .S IVUT=$G(@GLIFU@("IndicationValueUnit",0,"Text",0)),FDA(IFUSF,IFUIENS,16)=IVUT
 .S IVUOMC=$G(@GLIFU@("IndicationValueUnitOfMeasure",0,"Code",0)),FDA(IFUSF,IFUIENS,17)=IVUOMC
 .S IVUOMQ=$G(@GLIFU@("IndicationValueUnitOfMeasure",0,"Qualifier",0)),FDA(IFUSF,IFUIENS,18)=IVUOMQ
 .S IVUOMT=$G(@GLIFU@("IndicationValueUnitOfMeasure",0,"Text",0)),FDA(IFUSF,IFUIENS,19)=IVUOMT
 .D CFDA^PSOERXIU(.FDA)
 .D UPDATE^DIE(,"FDA") K FDA
 Q
MDR(ERXIEN,MIEN,MTYPE,MEDTYPE) ;
 N GL,MDRF,MDRIENS,MDR,MDRMEDF,MDRCFT,MDRDUC,MDRDUQ,MDRDUT,MDRDV,MDRFC,MDRFQ,MDRFT,MDRNV,MDRUC,MDRUT,MDRUQ,MDRCNT
 S MDRMEDF=52.4931114
 S MDRCNT=0
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0,"Sig",0))
 S MDR=-1 F  S MDR=$O(@GL@("MaximumDoseRestriction",MDR)) Q:MDR=""  D
 .S MDRCNT=$G(MDRCNT)+1
 .S MDRIENS="+"_MDRCNT_","_MIEN_","_ERXIEN_","
 .S MDRCFT=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionClarifyingFreeText",0))
 .S MDRDUC=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionDurationUnit",0,"Code",0))
 .S MDRDUQ=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionDurationUnit",0,"Qualifier",0))
 .S MDRDUT=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionDurationUnit",0,"Text",0))
 .S MDRDV=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionDurationValue",0))
 .S MDRFC=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionForm",0,"Code",0))
 .S MDRFQ=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionForm",0,"Qualifier",0))
 .S MDRFT=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionForm",0,"Text",0))
 .S MDRNV=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionNumericValue",0))
 .S MDRUC=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionUnits",0,"Code",0))
 .S MDRUT=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionUnits",0,"Text",0))
 .S MDRUQ=$G(@GL@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionUnits",0,"Qualifier",0))
 .S FDA(MDRMEDF,MDRIENS,.01)=MDRCNT
 .S FDA(MDRMEDF,MDRIENS,1)=MDRNV
 .S FDA(MDRMEDF,MDRIENS,2)=MDRUC
 .S FDA(MDRMEDF,MDRIENS,3)=MDRUQ
 .S FDA(MDRMEDF,MDRIENS,4)=MDRUT
 .S FDA(MDRMEDF,MDRIENS,5)=MDRDV
 .S FDA(MDRMEDF,MDRIENS,6)=MDRDUC
 .S FDA(MDRMEDF,MDRIENS,7)=MDRDUQ
 .S FDA(MDRMEDF,MDRIENS,8)=MDRDUT
 .S FDA(MDRMEDF,MDRIENS,9)=MDRFC
 .S FDA(MDRMEDF,MDRIENS,10)=MDRFQ
 .S FDA(MDRMEDF,MDRIENS,11)=MDRFT
 .S FDA(MDRMEDF,MDRIENS,12)=MDRCFT
 D CFDA^PSOERXIU(.FDA)
 D UPDATE^DIE(,"FDA")
 Q
MDRSF(GLINS,ERXIEN,MIEN,NINSIEN) ;
 N MDR,MDRCNT,MDRCFT,MDRDUC,MDRDUQ,MDRDUT,MDRDV,MDRFC,MDRFQ,MDRFT,MDRDV2,MDRCNT,MDRINS
 S MDRCNT=0,MDRINS=52.493111275
 S MDR=-1 F  S MDR=$O(@GLINS@("MaximumDoseRestriction",MDR)) Q:MDR=""  D
 .S MDRCNT=$G(MDRCNT)+1
 .S MDRIENS="+"_MDRCNT_","_NINSIEN_","_MIEN_","_ERXIEN_","
 .S MDRCFT=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionClarifyingFreeText",0))
 .S MDRDUC=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionDurationUnit",0,"Code",0))
 .S MDRDUQ=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionDurationUnit",0,"Qualifier",0))
 .S MDRDUT=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionDurationUnit",0,"Text",0))
 .S MDRDV=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionDurationValue",0))
 .S MDRFC=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionForm",0,"Code",0))
 .S MDRFQ=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionForm",0,"Qualifier",0))
 .S MDRFT=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionForm",0,"Text",0))
 .S MDRNV=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionNumericValue",0))
 .S MDRUC=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionUnits",0,"Code",0))
 .S MDRUT=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionUnits",0,"Text",0))
 .S MDRUQ=$G(@GLINS@("MaximumDoseRestriction",MDR,"MaximumDoseRestrictionUnits",0,"Qualifier",0))
 .S FDA(MDRINS,MDRIENS,.01)=MDRCNT,FDA(MDRINS,MDRIENS,1)=MDRNV,FDA(MDRINS,MDRIENS,2)=MDRUC
 .S FDA(MDRINS,MDRIENS,3)=MDRUQ,FDA(MDRINS,MDRIENS,4)=MDRUT,FDA(MDRINS,MDRIENS,5)=MDRDV
 .S FDA(MDRINS,MDRIENS,6)=MDRDUC,FDA(MDRINS,MDRIENS,7)=MDRDUQ,FDA(MDRINS,MDRIENS,8)=MDRDUT
 .S FDA(MDRINS,MDRIENS,9)=MDRFC,FDA(MDRINS,MDRIENS,10)=MDRFQ,FDA(MDRINS,MDRIENS,11)=MDRFT,FDA(MDRINS,MDRIENS,12)=MDRCFT
 .D CFDA^PSOERXIU(.FDA)
 .D UPDATE^DIE(,"FDA") K FDA
 Q
INSIFU(ERXIEN,MIEN,MTYPE,MEDTYPE,INS,INSIEN) ;
 N GLIFU,GLIFU2,IFU1,IFU1CNT,IFUIENS,IFUIPC,IFUIPQ,IFUIPT,IFUIC,IFUIQ,IFUIT,IFUIVC,IFUIVQ,IFU1IVC
 N IVM,IVU1IVQ,IVUIVT,IVUC,IVUQ,IVUT,IVUOMC,IVUOMQ,IVUOMT,FDA,IFU1IVQ,IFU1IVT,IFUIVT,IFUSF
 S GLIFU=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0,"Sig",0,"Instruction",INS,"IndicationForUse"))
 S IFUSF=52.493111267
 S IFU1=-1 F  S IFU1=$O(@GLIFU@(IFU1)) Q:IFU1=""  D
 .S GLIFU2=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,MEDTYPE,0,"Sig",0,"Instruction",INS,"IndicationForUse",IFU1))
 .S IFU1CNT=$G(IFU1CNT)+1
 .S IFUIENS="+"_IFU1CNT_","_INSIEN_","_MIEN_","_ERXIEN_","
 .S FDA(IFUSF,IFUIENS,.01)=IFU1CNT
 .S IFUIPC=$G(@GLIFU2@("IndicationPrecursor",0,"Code",0)),FDA(IFUSF,IFUIENS,1)=IFUIPC
 .S IFUIPQ=$G(@GLIFU2@("IndicationPrecursor",0,"Qualifier",0)),FDA(IFUSF,IFUIENS,2)=IFUIPQ
 .S IFUIPT=$G(@GLIFU2@("IndicationPrecursor",0,"Text",0)),FDA(IFUSF,IFUIENS,3)=IFUIPT
 .S IFUIC=$G(@GLIFU2@("Indication",0,"Code",0)),FDA(IFUSF,IFUIENS,4)=IFUIC
 .S IFUIQ=$G(@GLIFU2@("Indication",0,"Qualifier",0)),FDA(IFUSF,IFUIENS,5)=IFUIQ
 .S IFUIT=$G(@GLIFU2@("Indication",0,"Text",0)),FDA(IFUSF,IFUIENS,6)=IFUIT
 .S IFUIVC=$G(@GLIFU2@("IndicationValue",0,"Code",0)),FDA(IFUSF,IFUIENS,7)=IFUIVC
 .S IFUIVQ=$G(@GLIFU2@("IndicationValue",0,"Qualifier",0)),FDA(IFUSF,IFUIENS,8)=IFUIVQ
 .S IFUIVT=$G(@GLIFU2@("IndicationValue",0,"Text",0)),FDA(IFUSF,IFUIENS,9)=IFUIVT
 .S IFU1IVC=$G(@GLIFU2@("IndicationValue",1,"Code",0)),FDA(IFUSF,IFUIENS,11)=IFU1IVC
 .S IVM=$G(@GLIFU2@("IndicationVariableModifier",0)),FDA(IFUSF,IFUIENS,10)=IVM
 .S IFU1IVQ=$G(@GLIFU2@("IndicationValue",1,"Qualifier",0)),FDA(IFUSF,IFUIENS,12)=IFU1IVQ
 .S IFU1IVT=$G(@GLIFU2@("IndicationValue",1,"Text",0)),FDA(IFUSF,IFUIENS,13)=IFU1IVT
 .S IVUC=$G(@GLIFU2@("IndicationValueUnit",0,"Code",0)),FDA(IFUSF,IFUIENS,14)=IVUC
 .S IVUQ=$G(@GLIFU2@("IndicationValueUnit",0,"Qualifier",0)),FDA(IFUSF,IFUIENS,15)=IVUQ
 .S IVUT=$G(@GLIFU2@("IndicationValueUnit",0,"Text",0)),FDA(IFUSF,IFUIENS,16)=IVUT
 .S IVUOMC=$G(@GLIFU2@("IndicationValueUnitOfMeasure",0,"Code",0)),FDA(IFUSF,IFUIENS,17)=IVUOMC
 .S IVUOMQ=$G(@GLIFU2@("IndicationValueUnitOfMeasure",0,"Qualifier",0)),FDA(IFUSF,IFUIENS,18)=IVUOMQ
 .S IVUOMT=$G(@GLIFU2@("IndicationValueUnitOfMeasure",0,"Text",0)),FDA(IFUSF,IFUIENS,19)=IVUOMT
 .D CFDA^PSOERXIU(.FDA)
 .D UPDATE^DIE(,"FDA") K FDA
 Q
