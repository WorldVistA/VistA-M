RORXU005 ;HCIOFO/SG - REPORT BUILDER UTILITIES ;5/25/11 11:48am
 ;;1.5;CLINICAL CASE REGISTRIES;**1,15,21,22,26,30**;Feb 17, 2006;Build 37
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*22   FEB  2014   T KOPP       Added tag SKIPOEF to return the result
 ;                                      if the period of service of patient
 ;                                      matches OEF/OIF selection criteria.
 ;ROR*1.5*26   JAN  2015   T KOPP       Added check for SVR match in report
 ;
 ;ROR*1.5*30   OCT 2016   M FERRARESE   Changing the dispay for "Sex" to "Birth Sex"                                      screen logic, flags S and V
 ;****************************************************************************** 
 ; This routine uses the following IAs:
 ;
 ; #10035        Direct read of the DOD field of the file #2
 ; #10061        DEM^VADPT (supported)
 ;
 Q
 ;
 ;***** CALLBACK FUNCTION FOR DRUG SEARCH API
REIMBCB(RORDST,ORDER,FLAGS,DRUG,DATE) ;
 S RORDST=1
 Q 2
 ;
 ;***** RETURNS THE REIMBURSEMENT LEVEL FOR THE PATIENT
 ;
 ; RORIEN        IEN of the patient's record in the registry
 ;
 ; ROR8DRGS      Either closed root of the ARV drug list prepared by
 ;               the $$DRUGLIST^RORUTL16 or the Registry IEN. In the
 ;               latter case, the list will be compiled automatically.
 ;
 ; STDT          Start date
 ; ENDT          End date
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Neither Clinical AIDS nor ARV drugs
 ;       10  ARV drugs
 ;       20  Clinical AIDS
 ;       30  Both Clinical AIDS and ARV drugs
 ;
REIMBLVL(RORIEN,ROR8DRGS,STDT,ENDT) ;
 N PATIEN,RC,RLVL,RORDST
 S RLVL=0
 ;--- Clinical AIDS
 S:$$CLINAIDS^RORHIVUT(+RORIEN,ENDT) RLVL=RLVL+20
 ;--- ARV Drugs
 S PATIEN=$$PTIEN^RORUTL01(RORIEN)
 S RORDST("RORCB")="$$REIMBCB^RORXU005"
 S RC=$$RXSEARCH^RORUTL14(PATIEN,ROR8DRGS,.RORDST,"IOV",STDT,ENDT)
 S:$G(RORDST)>0 RLVL=RLVL+10
 ;--- Reimbursement level
 Q $S(RC<0:RC,1:RLVL)
 ;
 ;***** RETURNS THE PATIENT'S LIST OF RISK FACTORS
 ;
 ; RORIEN        IEN of the patient's record in the registry
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  No risk factors have been found
 ;  " ... "  A string containing the risk factor numbers
 ;           separated by commas and spaces
 ;
RISKS(RORIEN) ;
 Q:'$D(^RORDATA(799.4,+RORIEN,0)) ""
 N FLD,FLDLST,I,IENS,RISKLST,RORBUF,RORMSG,DIERR
 S FLDLST="14.01;14.02;14.03;14.04;14.08;14.07;14.09;14.1;14.11;14.12;14.13;14.16;14.17"
 ;--- Load the risk fields
 S IENS=(+RORIEN)_","
 D GETS^DIQ(799.4,IENS,FLDLST,"I","RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR(799.4,-9,,,799.4,IENS)
 ;--- Process the data
 S RISKLST=""
 F I=1:1  S FLD=$P(FLDLST,";",I)  Q:FLD=""  D:FLD>0
 . S:$G(RORBUF(799.4,IENS,FLD,"I"))=1 RISKLST=RISKLST_", "_I
 Q $P(RISKLST,", ",2,999)
 ;
 ;***** DETERMINES IF THE PATIENT SHOULD NOT BE INCLUDED IN THE REPORT
 ;
 ; RORIEN        IEN of the patient's record in the registry
 ;
 ; FLAGS         Flags that control the execution (can be combined)
 ;
 ;                 C  Skip confirmed patients
 ;                 G  Skip pending patients
 ;
 ;                 D  Skip deceased patients
 ;                 L  Skip alive patients
 ;
 ;                 P  Skip patients confirmed before the start date
 ;                 N  Skip patients confirmed during the report
 ;                    time frame
 ;                 F  Skip patients added after the end date
 ;
 ;                 H  Skip patients without local HIV diagnosis
 ;
 ;                 M  Skip male patients
 ;                 W  Skip female patients
 ;
 ;                 O  Process LOCAL_FIELDS
 ;                 R  Process OTHER_REGISTRIES
 ;
 ;                 E  Exclude patients with OEF/OIF period of service
 ;                 I  Include only patients with OEF/OIF period of service
 ;
 ;                 S  Include only patients with SVR
 ;                 V  Include only patients with No SVR
 ;
 ; [STDT]        Start date of the report (FileMan).
 ;               Time is ignored and the beginning of the day is
 ;               considered as the boundary (STDT\1).
 ;
 ;               If not defined or not greater than 0 then 0 is used.
 ;
 ; [ENDT]        End date of the report (FileMan).
 ;               Time is ignored and the end of the day is
 ;               considered as the boundary (ENDT\1+1).
 ;
 ;               If not defined or not greater than 0 then 9999999
 ;               is used.
 ;
 ; Return Values:
 ;        0  Include the patient's data in the report
 ;        1  Skip the patient
 ;
SKIP(RORIEN,FLAGS,STDT,ENDT) ;
 N DOD,IEN,MODE,NODE,PTIEN,REGIEN,BIRTHSEX,SKIP,STATUS,TMP
 S SKIP=0
 ;--- Always skip patients marked for deletion
 Q:$$SKIPNA(RORIEN,FLAGS,.STATUS) 1
 ;---Include all registry patients if flags are not provided
 Q:FLAGS="" 0
 ;
 ;--- Confirmed
 I FLAGS["C"  Q:STATUS'=4 1
 ;
 ;--- Alive/Deceased patients
 S STDT=$S($G(STDT)>0:STDT\1,1:0)
 I $TR(FLAGS,"LD")'=FLAGS  D  Q:$S(TMP:FLAGS["L",1:FLAGS["D") 1
 . S:'$D(PTIEN) PTIEN=+$$PTIEN^RORUTL01(RORIEN)
 . S DOD=+$P($G(^DPT(PTIEN,.35)),U)
 . S TMP=$S(DOD>0:DOD'<STDT,1:1)
 ;
 ;--- Male/Female patients screen
 I FLAGS["M"!(FLAGS["W") D  Q:SKIP 1
 . S:'$D(PTIEN) PTIEN=+$$PTIEN^RORUTL01(RORIEN)  ;get dfn
 . S SKIP=$$SKIPSEX(PTIEN,FLAGS)
 ;
 ;--- OEF/OIF period of service patients screen
 I FLAGS["E"!(FLAGS["I") D  Q:SKIP 1
 . S:'$D(PTIEN) PTIEN=+$$PTIEN^RORUTL01(RORIEN)  ;get dfn
 . S SKIP=$$SKIPOEF(PTIEN,FLAGS)
 ;
 ;--- SVR patients screen
 I FLAGS["V"!(FLAGS["S") D  Q:SKIP 1
 . N REGIEN,RC,RORXL,RORLDST,RORXDST
 . S:'$D(PTIEN) PTIEN=+$$PTIEN^RORUTL01(RORIEN)  ;get dfn
 . S REGIEN=$$GET1^DIQ(798,RORIEN_",",.02,"I")
 . ;== Lab parameters
 . S RORLDST("RORCB")="$$LTSCB^RORX023A"
 . ;== Pharm parameters
 . S RORXDST("GENERIC")=1  ;only meds with generic name
 . S RORXDST("RORCB")="$$RXOCB^RORX023A"   ;call back routine
 . ;--- RX list of HepC registry drugs
 . S RORXL=$$ALLOC^RORTMP()
 . S RC=$$DRUGLIST^RORUTL16(RORXL,REGIEN)
 . S RC=$$SVR^RORX023A(PTIEN,2000101,DT,REGIEN,RORXL,"",$$FMADD^XLFDT(DT,1),.RORLDST,.RORXDST)
 . D POP^RORTMP(RORXL)
 . I FLAGS["V" S SKIP=$S(RC=0:0,1:1) Q  ; skip if SVR and not SVR requested
 . I FLAGS["S" S SKIP=$S(RC=1:0,1:1)    ; skip if not SVR and SVR requested
 ;
 ;--- Confirmed before/during/after the date range
 S ENDT=$S($G(ENDT)>0:ENDT\1,1:9999999)+1
 I $TR(FLAGS,"PNF")'=FLAGS  D  Q:TMP 1
 . S TMP=+$$CONFDT^RORUTL18(RORIEN)  ; Date Confirmed
 . S TMP=$S(TMP<STDT:FLAGS["P",TMP>ENDT:FLAGS["F",1:FLAGS["N")
 ;
 ;--- Other registries
 I FLAGS["R"  D  Q:SKIP 1
 . S NODE=$NA(RORTSK("PARAMS","OTHER_REGISTRIES","C"))
 . Q:$D(@NODE)<10
 . S:'$D(PTIEN) PTIEN=+$$PTIEN^RORUTL01(RORIEN)
 . S REGIEN=0
 . F  S REGIEN=$O(@NODE@(REGIEN))  Q:REGIEN'>0  D  Q:SKIP
 . . S MODE=+$G(@NODE@(REGIEN))  Q:'MODE
 . . S IEN=$$PRRIEN^RORUTL01(PTIEN,REGIEN)
 . . I IEN'>0  S SKIP=1
 . . E  S:$$SKIPNA(IEN,FLAGS) SKIP=1
 . . S:MODE<0 SKIP='SKIP  ; Exclude
 ;
 ;--- Local Fields
 I FLAGS["O"  D  Q:SKIP 1
 . S NODE=$NA(RORTSK("PARAMS","LOCAL_FIELDS","C"))
 . Q:$D(@NODE)<10
 . S IEN=0
 . F  S IEN=$O(@NODE@(IEN))  Q:IEN'>0  D  Q:SKIP
 . . S MODE=+$G(@NODE@(IEN))  Q:'MODE
 . . S:'$D(^RORDATA(798,RORIEN,20,"B",IEN)) SKIP=1
 . . S:MODE<0 SKIP='SKIP  ; Exclude
 ;
 ;--- Local HIV Diagnosis
 I FLAGS["H" D  Q:SKIP 1
 . N RORV
 . S MODE=+RORTSK("PARAMS","HIV_DX") Q:'MODE
 . S RORV=+$P($G(^RORDATA(799.4,RORIEN,12)),U,8)
 . S:RORV'=1 SKIP=1
 . S:MODE<0 SKIP='SKIP
 ;
 ;
 ;--- Include in the report
 Q 0
 ;
 ;***** CHECKS STATUS OF THE PATIENT'S REGISTRY RECORD (internal)
 ;
 ; IEN798        IEN of the patient's record in the registry
 ;
 ; FLAGS         Flags that control the execution
 ;
 ; [.STATUS]     Status code is returned via this parameter.
 ;
 ; Return Values:
 ;        0  Continue processing of the patient's data
 ;        1  Skip the patient
 ;
SKIPNA(IEN798,FLAGS,STATUS) ;
 Q:$$ACTIVE^RORDD(IEN798,,.STATUS) 0  ; Active patient
 Q:(STATUS=5)!(STATUS="") 1           ; Deleted patient
 Q:(STATUS=4)&(FLAGS["G") 1           ; Pending patient
 Q 0
 ;
 ;***** CHECKS IF BIRTHSEX OF PATIENT MATCHES BIRTHSEX SELECTED FOR REPORT
 ;
 ; DFN           IEN of the patient's record in the patient file (#2)
 ;
 ; FLAGS         Flags that control the execution
 ;
 ; Return Values:
 ;        0  Continue processing of the patient's data
 ;        1  Skip the patient
 ;
SKIPSEX(DFN,FLAGS) ;
 N VADM,VAPTYP,VAHOW,BIRTHSEX
 D DEM^VADPT
 S BIRTHSEX=$P($G(VADM(5)),U)
 Q $S(FLAGS["M":BIRTHSEX'="F",FLAGS["W":BIRTHSEX'="M",1:0)
 ;
 ;***** CHECKS IF PERIOD OF SERVICE OF PATIENT MATCHES OEF/OIF SELECTION FOR
 ;      REPORT
 ;
 ; DFN           IEN of the patient's record in the patient file (#2)
 ;
 ; FLAGS         Flags that control the execution
 ;
 ; Return Values:
 ;        0  Continue processing of the patient's data
 ;        1  Skip the patient
 ;
SKIPOEF(DFN,FLAGS) ;
 N VASV,QUIT
 D SVC^VADPT
 S QUIT=0
 ; Ignore if Only OEF/OIF selected and patient has no such POS
 I FLAGS["I" S QUIT=$S($G(VASV(11))!($G(VASV(12)))!($G(VASV(13))):0,1:1)
 ; Ignore if Exclude OEF/OIF selected and patient has such POS
 I 'QUIT,FLAGS["E" S QUIT=$S($G(VASV(11))!($G(VASV(12)))!($G(VASV(13))):1,1:0)
 Q QUIT
 ; 
