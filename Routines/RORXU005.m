RORXU005 ;HCIOFO/SG - REPORT BUILDER UTILITIES ; 5/17/06 1:45pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #10035        Direct read of the DOD field of the file #2
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
 N FLD,FLDLST,I,RISKLST,RORBUF,RORMSG
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
 ;                 O  Process LOCAL_FIELDS
 ;                 R  Process OTHER_REGISTRIES
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
 N DOD,IEN,MODE,NODE,PTIEN,REGIEN,SKIP,STATUS,TMP
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
