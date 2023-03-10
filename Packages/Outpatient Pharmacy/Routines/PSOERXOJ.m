PSOERXOJ ;ALB/BWF - eRx parsing Utilities ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**581,635**;DEC 1997;Build 19
 ;
 Q
 ; Medication Instructions
MEDINST(GL,CNT,ERXIEN,MIEN) ;
 N INSIEN,IENS,INSDAT,F,IIND,MIM,AIND,DDMC,DDM,DDMT,DQ1,DQ2,DRMOD,DUOMC1,DUOMQ1,DUOMT1
 N DUOMC2,DUOMQ2,DUOMT2,DBNV,DBRM,DBNV2,DBUOMC,DBUOMQ,DBUOMT,BMQ,BMV,CDN,CDUOMC,CDUOMQ
 N CDUOMT,DCLRFTXT,DUOMCC,DUOMCQ,DUOMCT,DAMTC,DAMTQ,DAMTT,DCFTXT,VPC,VPQ,VPT,VQ1,VMVM,VQ2
 N VUOMC,VUOMQ,VUOME,VCODE,VQUAL,VTEXT,VCTEXT,ROAC,ROAQ,ROAT,ROAFT,SOAC,SOAQ,SOAT,SOATXT
 N ICTXT,MDRTXT,DDMMC,DDMMQ,DDMMT,DDMQ,VUOMT
 S F=52.4931112
 I '$O(^PS(52.49,ERXIEN,311,MIEN,12,0)) Q
 S INSIEN=0 F  S INSIEN=$O(^PS(52.49,ERXIEN,311,MIEN,12,INSIEN)) Q:'INSIEN  D
 .S IENS=INSIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,IENS,"**","E","INSDAT")
 .S IIND=$$GET1^DIQ(F,IENS,.02,"I"),MIM=$G(INSDAT(F,IENS,.03,"E")),AIND=$G(INSDAT(F,IENS,4.1,"E"))
 .I MIM]"" D BL(GL,.CNT,"MultipleInstructionModifier",MIM)
 .D C S @GL@(CNT,0)="<Instruction>"
 .D BL(GL,.CNT,"InstructionIndicator",IIND)
 .S DDMC=$G(INSDAT(F,IENS,7,"E")),DDMQ=$G(INSDAT(F,IENS,8,"E")),DDMT=$G(INSDAT(F,IENS,9,"E"))
 .S DQ1=$G(INSDAT(F,IENS,10.1,"E")),DQ2=$G(INSDAT(F,IENS,15.1,"E"))
 .S DRMOD=$G(INSDAT(F,IENS,14,"E"))
 .S DUOMC1=$G(INSDAT(F,IENS,11,"E")),DUOMQ1=$G(INSDAT(F,IENS,12,"E")),DUOMT1=$G(INSDAT(F,IENS,13,"E"))
 .S DUOMC2=$G(INSDAT(F,IENS,16,"E")),DUOMQ2=$G(INSDAT(F,IENS,17,"E")),DUOMT2=$G(INSDAT(F,IENS,18,"E"))
 .S DBNV=$G(INSDAT(F,IENS,21.1,"E")),DBRM=$G(INSDAT(F,IENS,21.2,"E")),DBNV2=$G(INSDAT(F,IENS,21.3,"E"))
 .S DBUOMC=$G(INSDAT(F,IENS,22,"E")),DBUOMQ=$G(INSDAT(F,IENS,23,"E")),DBUOMT=$G(INSDAT(F,IENS,24,"E"))
 .S BMQ=$G(INSDAT(F,IENS,25.1,"E")),BMV=$G(INSDAT(F,IENS,25.2,"E"))
 .S CDN=$G(INSDAT(F,IENS,26,"E"))
 .S CDUOMC=$G(INSDAT(F,IENS,27,"E")),CDUOMQ=$G(INSDAT(F,IENS,28,"E")),CDUOMT=$G(INSDAT(F,IENS,29,"E"))
 .; dose calculaton clarifying free text
 .S DCLRFTXT=$G(INSDAT(F,IENS,31,"E"))
 .S DUOMCC=$G(INSDAT(F,IENS,32,"E")),DUOMCQ=$G(INSDAT(F,IENS,33,"E")),DUOMCT=$G(INSDAT(F,IENS,34,"E"))
 .S DAMTC=$G(INSDAT(F,IENS,35,"E")),DAMTQ=$G(INSDAT(F,IENS,36,"E")),DAMTT=$G(INSDAT(F,IENS,37,"E"))
 .; dose clarifying free text
 .S DCFTXT=$G(INSDAT(F,IENS,38,"E"))
 .S VPC=$G(INSDAT(F,IENS,41,"E")),VPQ=$G(INSDAT(F,IENS,42,"E")),VPT=$G(INSDAT(F,IENS,43,"E"))
 .S VQ1=$G(INSDAT(F,IENS,44.1,"E")),VMVM=$G(INSDAT(F,IENS,44.2,"E")),VQ2=$G(INSDAT(F,IENS,44.3,"E"))
 .S VUOMC=$G(INSDAT(F,IENS,45,"E")),VUOMQ=$G(INSDAT(F,IENS,46,"E")),VUOMT=$G(INSDAT(F,IENS,47,"E"))
 .S VCODE=$G(INSDAT(F,IENS,51,"E")),VQUAL=$G(INSDAT(F,IENS,52,"E")),VTEXT=$G(INSDAT(F,IENS,53,"E"))
 .; vehicle clarifying text
 .S VCTEXT=$G(INSDAT(F,IENS,54,"E"))
 .S ROAC=$G(INSDAT(F,IENS,55,"E")),ROAQ=$G(INSDAT(F,IENS,56,"E")),ROAT=$G(INSDAT(F,IENS,57,"E"))
 .; route of admin free text
 .S ROAFT=$G(INSDAT(F,IENS,58,"E"))
 .S SOAC=$G(INSDAT(F,IENS,61,"E")),SOAQ=$G(INSDAT(F,IENS,62,"E")),SOAT=$G(INSDAT(F,IENS,63,"E"))
 .; site of admin
 .S SOATXT=$G(INSDAT(F,IENS,64,"E"))
 .; indication clarifying text
 .S ICTXT=$G(INSDAT(F,IENS,70,"E"))
 .; mdr clarifying free text
 .S MDRTXT=$G(INSDAT(F,IENS,71,"E"))
 .S DDMMC=$G(INSDAT(F,IENS,72,"E")),DDMMQ=$G(INSDAT(F,IENS,73,"E")),DDMMT=$G(INSDAT(F,IENS,74,"E"))
 .; timing and duration
 .D BL(.GL,.CNT,"AdministrationIndicator",AIND)
 .; DoseAdministration
 .I $L(DQ1_DQ2_DDMT_DDMQ_DDMC_DDMMT_DDMMQ_DDMMC) D
 ..D C S @GL@(CNT,0)="<DoseAdministration>"
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"DoseDeliveryMethod",DDMT,DDMQ,DDMC)
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"DoseDeliveryMethodModifier",DDMMT,DDMMQ,DDMMC)
 ..I $L(DQ1) D
 ...D C S @GL@(CNT,0)="<Dosage>"
 ...D BL(.GL,.CNT,"DoseQuantity",DQ1)
 ...D SIGTYPE^PSOERXOU(.GL,.CNT,"DoseUnitOfMeasure",DUOMT1,DUOMQ1,DUOMC1)
 ...I $L(DRMOD) D BL(.GL,.CNT,"DoseRangeModifier",DRMOD)
 ...I $L(DQ2) D BL(.GL,.CNT,"DoseQuantity",DQ2)
 ...D SIGTYPE^PSOERXOU(.GL,.CNT,"DoseUnitOfMeasure",DUOMT2,DUOMQ2,DUOMC2)
 ...D C S @GL@(CNT,0)="</Dosage>"
 ..; dose calculation (inside dose administration)
 ..I $L(DBNV) D
 ...D C S @GL@(CNT,0)="<DoseCalculation>"
 ...D BL(.GL,.CNT,"DosingBasisNumeric",DBNV)
 ...I $L(DBRM) D BL(.GL,.CNT,"DosingBasisRangeModifier",DBRM)
 ...I $L(DBNV2) D BL(.GL,.CNT,"DosingBasisNumeric",DBNV2)
 ...D SIGTYPE^PSOERXOU(.GL,.CNT,"DosingBasisUnitOfMeasure",DBUOMT,DBUOMQ,DBUOMC)
 ...I $D(BMQ) D BL(.GL,.CNT,"BodyMetricQualifier",BMQ)
 ...I $D(BMV) D BL(.GL,.CNT,"BodyMetricValue",BMV)
 ...I $L(CDN) D BL(.GL,.CNT,"CalculatedDoseNumeric",CDN)
 ...D SIGTYPE^PSOERXOU(.GL,.CNT,"CalculatedDoseUnitOfMeasure",DDMT,DDMQ,DDMC)
 ...I $L(DCLRFTXT) D BL(.GL,.CNT,"DoseCalculationClarifyingFreeText",DCLRFTXT)
 ...D SIGTYPE^PSOERXOU(.GL,.CNT,"DoseUnitOfMeasure",DUOMCT,DUOMCQ,DUOMCC)
 ...D C S @GL@(CNT,0)="</DoseCalculation>"
 ..; end dose calculation - return to doseAdministration
 ..D SIGTYPE^PSOERXOU(.GL,.CNT,"DoseAmount",DAMTT,DAMTQ,DAMTC)
 ..I $L(DCFTXT) D BL(.GL,.CNT,"DoseClarifyingFreeText",DCFTXT)
 ..; vehicle
 ..I VQ1]"" D
 ...D C S @GL@(CNT,0)="<Vehicle>"
 ...D SIGTYPE^PSOERXOU(.GL,.CNT,"VehiclePreposition",VPT,VPQ,VPC)
 ...D BL(GL,.CNT,"VehicleQuantity",VQ1)
 ...I VMVM]"" D BL(GL,.CNT,"MultipleVehicleModifier",VMVM)
 ...I VQ2]"" D BL(GL,.CNT,"VehicleQuantity",VQ2)
 ...D SIGTYPE^PSOERXOU(.GL,.CNT,"VehicleUnitOfMeasure",VUOMT,VUOMQ,VUOMC)
 ...D SIGTYPE^PSOERXOU(.GL,.CNT,"Vehicle",VTEXT,VQUAL,VCODE)
 ...I $L(VCTEXT) D BL(GL,.CNT,"VehicleClarifyingFreeText",VCTEXT)
 ...D C S @GL@(CNT,0)="</Vehicle>"
 ..; end vehicle
 ..D SIGTYPE^PSOERXOU(GL,.CNT,"RouteOfAdministration",ROAT,ROAQ,ROAC)
 ..I $L(ROAFT) D BL(GL,.CNT,"RouteOfAdministrationClarifyingFreeText",ROAFT)
 ..D SIGTYPE^PSOERXOU(GL,.CNT,"SiteOfAdministration",SOAT,SOAQ,SOAC)
 ..I $L(SOATXT) D BL(GL,.CNT,"SiteOfAdministrationClarifyingFreeText",SOATXT)
 ..D C S @GL@(CNT,0)="</DoseAdministration>"
 ..; end dose Administration
 .; timing and duration
 .D TIMDUR^PSOERXOK(GL,.CNT,ERXIEN,MIEN,INSIEN)
 .;PSO*7*635 - include indication for use at the instruction level
 .D INSI4USE^PSOERXOK(GL,.CNT,ERXIEN,MIEN,INSIEN)
 .;PSO*7*635 - end updated indication for use
 .I $L(ICTXT) D BL(GL,.CNT,"IndicationClarifyingFreeText",ICTXT)
 .; Maximum dose restriction at the instructions level
 .D INSMDR^PSOERXOK(GL,.CNT,ERXIEN,MIEN,INSIEN)
 .D C S @GL@(CNT,0)="</Instruction>"
 Q
BL(GBL,CNT,TAG,VAR) ;
 Q:VAR=""
 D C S @GBL@(CNT,0)="<"_TAG_">"_$$SYMENC^MXMLUTL(VAR)_"</"_TAG_">"
 Q
C ;
 S CNT=$G(CNT)+1
 Q
