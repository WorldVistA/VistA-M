RORX003 ;HOIFO/SG,VAC - GENERAL UTILIZATION AND DEMOGRAPHICS ;4/7/09 2:06pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,8,13**;Feb 17, 2006;Build 27
 ;
 ; This routine uses the following IAs:
 ;
 ; #10103  FMADD^XLFDT, FMDIFF^XLFDT, FMTE^XLFDT (supported)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*8    MAR  2010   V CARR       Modified to handle ICD9 filter for
 ;                                      'include' or 'exclude'.
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   User can select specific patients,
 ;                                      clinics, or divisions for the report.
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** OUTPUTS THE REPORT HEADER
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the HEADER element
 ;
HEADER(PARTAG) ;
 N COLUMNS,HEADER,NAME,NOTES,TMP
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S NOTES=$$ADDVAL^RORTSK11(RORTSK,"NOTES",,HEADER)
 D ADDVAL^RORTSK11(RORTSK,"AGE_BASE_DATE",RORAGEDT,NOTES)
 ;---
 S COLUMNS=$$ADDVAL^RORTSK11(RORTSK,"TBLDEF",,HEADER)
 Q:COLUMNS<0 COLUMNS
 D ADDATTR^RORTSK11(RORTSK,COLUMNS,"HEADER","1")
 D ADDATTR^RORTSK11(RORTSK,COLUMNS,"FOOTER","1")
 D ADDATTR^RORTSK11(RORTSK,COLUMNS,"NAME","PATIENTS")
 S RORFL798=".01",RORFLICR=""
 ;--- Required columns
 F NAME="#","NAME"  D
 . S TMP=$$ADDVAL^RORTSK11(RORTSK,"COLUMN",,COLUMNS)
 . D ADDATTR^RORTSK11(RORTSK,TMP,"NAME",NAME)
 ;--- SSN or LAST4
 S NAME=$S($$OPTCOL^RORXU006("SSN"):"SSN",1:"LAST4")
 S TMP=$$ADDVAL^RORTSK11(RORTSK,"COLUMN",,COLUMNS)  Q:TMP<0 TMP
 D ADDATTR^RORTSK11(RORTSK,TMP,"NAME",NAME)
 ;--- Optional columns
 F NAME="DOB","AGE","SEX","RACE","ETHN","RISK","SELDT","CONFDT","UTIL","DOD"  D
 . Q:'$$OPTCOL^RORXU006(NAME)
 . S TMP=$$ADDVAL^RORTSK11(RORTSK,"COLUMN",,COLUMNS)
 . D ADDATTR^RORTSK11(RORTSK,TMP,"NAME",NAME)
 ;---
 S:$$OPTCOL^RORXU006("CONFDT") RORFL798=RORFL798_";2"
 S:$$OPTCOL^RORXU006("SELDT") RORFL798=RORFL798_";3.2"
 Q HEADER
 ;
 ;***** COMPILES THE "GENERAL UTLIZATION AND DEMOGRAPHICS" REPORT
 ; REPORT CODE: 003
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
UTLDMG(RORTSK) ;
 N RORAGEDT      ; Base date for age calculations
 N RORDTE0       ; Beginning of the Date Entered "sliding window"
 N ROREDT        ; End date
 N RORFL798      ; Fields to load from the file #798
 N RORFLICR      ; Fields to load from the file #799.4
 N RORREG        ; Registry IEN
 N RORRISK       ; Risk factor counters
 N RORSDT        ; Start date
 N RORSUM        ; Summary data
 N RORUTIL       ; Requested utilization types
 N RORUCNT       ; Utilization counters
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 N CNT,ECNT,IEN,IENS,PARAMS,PATIENTS,RC,REPORT,RORPTN,SFLAGS,TMP,XREFNODE
 N RCC,FLAG,DFN
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 ;=== Get and prepare the report parameters
 S RORREG=$$PARAM^RORTSK01("REGIEN")
 S PARAMS=$$PARAMS^RORXU002(.RORTSK,REPORT,.RORSDT,.ROREDT,.SFLAGS)
 Q:PARAMS<0 PARAMS
 ;--- Default set of columns for the summary-only report
 S XREFNODE=$NA(RORTSK("PARAMS","OPTIONAL_COLUMNS","C"))
 I $$PARAM^RORTSK01("OPTIONS","SUMMARY")  D
 . F TMP="RACE","RISK","AGE","SEX","UTIL"  D
 . . S @XREFNODE@(TMP)=""
 S:$$OPTCOL^RORXU006("RACE") @XREFNODE@("ETHN")=""
 ;--- Construct the description of utilization types
 I '$$PARAM^RORTSK01("UTIL_TYPES","ALL")  D
 . M RORUTIL=RORTSK("PARAMS","UTIL_TYPES","C")
 E  S RORUTIL("ALL")=1
 S TMP=$$OPTXT^RORXU002(.RORUTIL,7980000.019)
 D ADDVAL^RORTSK11(RORTSK,"UTIL_TYPES",TMP,PARAMS)
 ;
 ;=== Initialize constants and variables
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 S XREFNODE=$NA(^RORDATA(798,"AC",RORREG)),ECNT=0
 S TMP=$$FMDIFF^XLFDT(ROREDT,RORSDT)
 S RORAGEDT=$$FMADD^XLFDT(RORSDT,TMP\2)
 S RORDTE0=$P($$FMTE^XLFDT(DT,7),"/")-10  ; 10 year "sliding window"
 ;
 S FLAG=$G(RORTSK("PARAMS","ICD9FILT","A","FILTER"))
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT)
 ;
 D
 . ;=== Report header
 . S RC=$$HEADER(REPORT)  Q:RC<0
 . ;---
 . S PATIENTS=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,REPORT)
 . I PATIENTS<0  S RC=+PATIENTS  Q
 . D ADDATTR^RORTSK11(RORTSK,PATIENTS,"TABLE","PATIENTS")
 . ;=== Browse through the registry records
 . D TPPSETUP^RORTSK01(95)
 . S (CNT,IEN,RC)=0
 . F  S IEN=$O(@XREFNODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . . ;--- Calculate 'progress' for the GUI display
 . . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . . S IENS=IEN_",",CNT=CNT+1
 . . ;-- Get patient DFN
 . . S DFN=$$PTIEN^RORUTL01(IEN) Q:DFN'>0
 . . ;--- Check for patient list and quit if not in list
 . . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",DFN)) Q
 . . ;--- Check if the patient should be skipped
 . . Q:$$SKIP^RORXU005(IEN,SFLAGS,RORSDT,ROREDT)
 . . ;--- Check if the ICD9 Filter includes or excludes the patient
 . . S RCC=0
 . . I FLAG'="ALL" D
 . . . S RCC=$$ICD^RORXU010(DFN,RORREG)
 . . I (FLAG="INCLUDE")&(RCC=0) Q
 . . I (FLAG="EXCLUDE")&(RCC=1) Q
 . . ;--- End of ICD9 check.
 . . ;--- Check for Clinic or Division list and quit if not in list
 . . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,DFN,RORCDSTDT,RORCDENDT) Q
 . . ;--- Process the registry record
 . . S TMP=$$PATIENT^RORX003A(IENS,PATIENTS)
 . . I TMP<0  S ECNT=ECNT+1  Q
 . Q:RC<0
 . ;
 . ;=== Report summary
 . D TPPSETUP^RORTSK01(5)
 . S RC=$$SUMMARY^RORX003A(REPORT,PATIENTS)  Q:RC<0
 . ;
 . ;=== Summary only
 . S TMP=$$PARAM^RORTSK01("OPTIONS","COMPLETE")
 . D:'TMP UPDVAL^RORTSK11(RORTSK,PATIENTS,,,1)
 ;
 ;=== Cleanup
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
