SCMSVUT2 ;ALB/JLU;Utility routine for AMBCARE;06/28/99
 ;;5.3;Scheduling;**66,180,254,293,325,466,521**;AUG 13,1993;Build 1
 ;06/28/99 ACS Added CPT modifier validation
 ;
COUNT(VALER) ;counts the number of errored encounters found.
 ;INPUT VALER - The array containing the errors.
 ;OUTPUT the number of errors
 ;
 N VAR,CNT
 S VAR="",CNT=0
 F  S VAR=$O(@VALER@(VAR)) Q:VAR']""  S CNT=CNT+1
 Q CNT
 ;
IPERR(VALER) ;counts the number of inpatient errored encounters found.
 ;INPUT VALER - The array containing the errors.
 ;OUTPUT the number of errors
 ;
 N VAR,CNT
 S VAR="",CNT=0
 F  S VAR=$O(@VALER@(VAR)) Q:VAR']""  D
 .I $$INPATENC^SCDXUTL(VAR) S CNT=CNT+1
 Q CNT
 ;
FILEVERR(PTR,VALERR) ;files the errors found for an encounter
 ;INPUT  PTR - The pointer to the entry in the transmission file 409.73
 ;      VALERR - The array holding the errors for the encounter.
 ;OUTPUT  0 - did not file
 ;        1 - did file
 N SEG,FILE
 I '$D(VALERR) Q 0
 S SEG="",FILE=-1
 F  S SEG=$O(@VALERR@(SEG)) Q:SEG']""  D FILE(VALERR,SEG,PTR,.FILE)
 Q $S(FILE=1:1,1:0)
 ;
FILE(VALERR,SEG,PTR,FILE) ;
 N NBR
 S NBR=0
 F  S NBR=$O(@VALERR@(SEG,NBR)) Q:'NBR  DO
 .N CODPTR,CODE
 .S CODE=$G(@VALERR@(SEG,NBR))
 .I CODE']"" Q
 .S CODPTR=$O(^SD(409.76,"B",CODE,""))
 .I 'CODPTR Q
 .I $D(^SD(409.75,"AER",PTR,CODPTR)) S FILE=1 Q
 .S FILE=$$CRTERR^SCDXFU02(PTR,CODE)
 .Q
 Q
 ;
VALWL(CLIN) ;WORKLOAD VALIDATION AT CHECK OUT
 ;INPUT CLIN - IEN OF CLINIC
 ;OUTPUT 0 - DO NOT VALIDATE WORKLOAD
 ;       1 - VALIDATE CLINIC WORKLOAD
 N A1
 I '$D(CLIN) S CLIN=0
 S A1=$P($G(^SC(+CLIN,0)),U,30)
 Q $S(A1=1:1,1:0)
 ;
VALIDATE(XMITPTR) ;validates data that has a entry in the transmit file.
 ;
 ;INPUT    XMITPTR - This is the point to an entry in file 409.73.
 ;
 ;OUTPUT    -1 - the was a problem with the inputs
 ;           0 - no errors were found
 ;           1 - errors were found
 ;
 N VALERR,ERR,HL,HLEID,DFN
 S ANS=-1
 S XMITPTR=+$G(XMITPTR)
 I $G(^SD(409.73,XMITPTR,0))']"" G VALQ
 D PATDFN^SCDXUTL2(XMITPTR)
 ;
 S HL7XMIT="^TMP(""HLS"","_$J_")",VALERR="^TMP(""SCDXVALID"","_$J_","_XMITPTR_")"
 ;Initialze HL7 variables
 S HLEID=+$O(^ORD(101,"B","SCDX AMBCARE SEND SERVER FOR ADT-Z00",0))
 I ('HLEID) G VALQ
 D INIT^HLFNC2(HLEID,.HL)
 I ($O(HL(""))="") G VALQ
 ;
 S ERR=$$BUILDHL7^SCDXMSG0(XMITPTR,.HL,1,HL7XMIT,1,VALERR)
 ;
 I ERR<0,$O(@VALERR@(0))']"" D VALIDATE^SCMSVUT0("INTERNAL","","V900",VALERR,0)
 S ANS=0
 D DELAERR^SCDXFU02(XMITPTR,0)
 D DEMUPDT(DFN,VALERR,"DEMO")
 I $O(@VALERR@(0))]"" DO
 .N FILE
 .S ANS=1
 .S FILE=$$FILEVERR(XMITPTR,VALERR)
 .Q
 ;
 K @VALERR,@HL7XMIT
 ;
VALQ Q ANS
 ;
DEMUPDT(DFN,VALERR,TYP) ;
 ;This entry point updates all the other encoutners for this patient
 ;that HAVE errors with a new set or demographic errors or deletes all
 ;the demographic errors if none were found.
 ;INPUT DFN - The patient's DFN
 ;   VALERR - errors to log
 ;      TYP - The type of errors to delete and log.
 ;            Right now demographic errors are the only kind "DEMO"
 ;
 S DFN=$G(DFN),TYP=$G(TYP),VALERR=$G(VALERR)
 I DFN=""!(TYP="")!(VALERR="") Q
 N PTRS,RNG,LP,PTR
 S RNG=$P($T(@(TYP)),";;",2),PTRS=""
 D CLEAN(DFN,RNG,.PTRS)
 I '$D(@VALERR@("PID")) Q
 I PTRS']"" Q
 F LP=1:1 S PTR=$P(PTRS,U,LP) Q:PTR']""  DO
 .I '$D(^SD(409.73,PTR,0)) Q
 .N FILE
 .D FILE(VALERR,"PID",PTR,.FILE)
 .Q
 Q
 ;
CLEAN(DFN,RNG,PTRS) ;This subroutine cleans out all errors for a pateint
 ;and returns a string of which entries in 409.73 were cleaned of errors
 ;
 N LP,COD,LP2,IEN
 F LP=1:1 S COD=$P(RNG,U,LP) Q:COD']""  I $D(^SD(409.75,"ACOD",DFN,COD)) S IEN="" F LP2=1:1 S IEN=$O(^SD(409.75,"ACOD",DFN,COD,IEN)) Q:IEN']""  DO
 .N VAR,RES
 .S VAR=$P($G(^SD(409.75,IEN,0)),U,1)_"^"
 .I $P(VAR,U,1)="" S PTR="" Q
 .S RES=$$DELERR^SCDXFU02(IEN)
 .I PTRS[VAR Q
 .S PTRS=PTRS_VAR
 .Q
 Q
 ;
MODCODE(DATA,ENCDT) ;
 ;
 ;---------------------------------------------------------------
 ;    VALIDATE MODIFIER AND CPT+MODIFIER COMBINATION
 ;
 ; INPUT: DATA - The procedure and modifier code to be checked 
 ;               format: CPT~modifier
 ;       ENCDT - The date of the encounter
 ;
 ;OUTPUT:    1 - valid modifier and CPT+modifier combination
 ;           0 - invalid modifier or CPT+modifier combination
 ;
 ;**NOTE**   This call makes the assumption that leading zeros are
 ;           intact in the input.
 ;---------------------------------------------------------------
 ;
 ;- validate modifier only
 N DATAMOD
 S DATAMOD=$P(DATA,"~",2)
 I '$D(DATAMOD) Q 0
 I $$MOD^ICPTMOD(DATAMOD,"E",ENCDT,1)'>0 Q 0
 ;
 ;- validate CPT+modifier pair
 N DATAPROC
 S DATAPROC=$P(DATA,"~",1)
 I '$D(DATAPROC) Q 0
 I $$MODP^ICPTMOD(DATAPROC,DATAMOD,"E",ENCDT,1)'>0 Q 0
 Q 1
 ;
MODMETH(DATA) ;
 ;
 ;---------------------------------------------------------------
 ;    VALIDATE MODIFIER CODING METHOD
 ;
 ; INPUT: DATA - The modifier coding method to be checked 
 ;
 ;OUTPUT:    1 - valid modifier coding method
 ;           0 - invalid modifier coding method
 ;
 ; Valid modifier coding methods: C and H
 ;---------------------------------------------------------------
 ;
 I '$D(DATA) Q 0
 S DATA=","_DATA_","
 I ",C,H,"'[DATA Q 0
 Q 1
 ;
ETHNIC(DATA)    ;
 ;INPUT  DATA - the ethnicity code to be validated (NNNN-C-XXX)
 ;
 N VAL,MTHD
 I '$D(DATA) Q 0
 I DATA="" Q 1
 S VAL=$P(DATA,"-",1,2)
 S MTHD=$P(DATA,"-",3)
 I VAL'?4N1"-"1N Q 0
 I ",SLF,UNK,PRX,OBS,"'[MTHD Q 0
 Q 1
CONFDT(DATA,SUB)    ;CONFIDENTIAL ADDRESS START/STOP DATE
 N X,Y,%DT,DTOUT,STDT,ENDT
 I '$D(DATA) Q 0
 S STDT=$P(DATA,SUB,1)
 S ENDT=$P(DATA,SUB,2)
 I STDT="" Q 0
 S STDT=$$FMDATE^HLFNC(STDT)
 S X=STDT,%DT="X" D ^%DT I Y=-1 Q 0  ;SD/521 added %DT
 I ENDT="" Q 1
 S ENDT=$$FMDATE^HLFNC(ENDT)
 S X=ENDT,%DT="X" D ^%DT I Y=-1 Q 0  ;SD/521 added %DT
 I $$FMDIFF^XLFDT(ENDT,STDT,1)<0 Q 0
 Q 1
 ;
CONFCAT(DATA)             ;CONFIDENTIAL ADDRESS CATEGORY TYPE
 I '$D(DATA) Q 0
 I DATA="" Q 0
 N VAL,GOOD
 S GOOD=0
 F VAL="VACAA","VACAC","VACAE","VACAM","VACAO" I DATA=VAL S GOOD=1 Q
 Q GOOD
 ;
CVEDT(DATA) ;Combat vet end date (ZEL.38)
 ;Input  : DATA - CombatVetIndicator ^ CombatVetEndDate
 ;Output : 1 = Good / 0 = Bad
 ;
 N CVI,CVEDT
 S DATA=$G(DATA)
 S CVI=$P(DATA,"^",1)
 S CVEDT=$P(DATA,"^",2)
 I 'CVI Q $S(CVEDT="":1,1:0)
 Q CVEDT?8N
 ;
CLCV(DATA,SDOE) ;Cross check for combat vet classification question
 ;Input  : DATA - Answer to classification question
 ;         SDOE - Pointer to encounter (file # 409.68)
 ;Output : 1 = Good / 0 = Bad
 ;
 S DATA=$G(DATA)
 Q:(DATA'=1) 1
 N VET,SDDT,SDOE0
 S SDOE=$G(SDOE) Q:'SDOE 0
 S SDOE0=$G(^SCE(SDOE,0))
 S SDDT=+SDOE0 Q:'SDDT 0
 S DFN=+$P(SDOE0,"^",2) Q:'DFN 0
 S VET=$P($$EL^SDCO22(DFN,SDOE),"^",5)
 I VET'="Y" Q 0
 S VET=+$$CVEDT^DGCV(DFN,SDDT)
 Q $S(VET=1:1,1:0)
 ;
DEMO ;;2000^2030^2050^2100^2150^2200^2210^2220^2230^2240^2250^2300^2330^2360
