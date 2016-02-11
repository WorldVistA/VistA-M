RORUPDUT ;HCIOFO/SG - REGISTRY UPDATE UTILITIES ;15 Jun 2015  12:30 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**18,19,26**;Feb 17, 2006;Build 53
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*18   APR 2012    C RAY        Add logic to define REGIEN for
 ;                                      ROR SELECTION RULE EXPRESSION
 ;ROR*1.5*19   FEB  2012   K GUPTA      Support for ICD-10 Coding System
 ;ROR*1.5*26   APR  2015   T KOPP       Add check for coding system for procedures
 ;                                      Add logic for storing inpatient proc codes
 ;*****************************************************************************
 ;****************************************************************************
 ; This routine uses the following IAs:
 ;
 ; #2051  FIND^DIC  (supported)
 ; #2056  GETS^DIQ (supported)
 ; #5679  IMPDATE^LEXU (Supported)
 ;****************************************************************************          
 ;
 ; RORVALS ------------- CALCULATED VALUES
 ;
 ; RORVALS("DV",         VALUES OF THE DATA ELEMENTS
 ;   File#,DataCode,"E") External value
 ;   File#,DataCode,"I") Internal value
 ;
 ; RORVALS("LS",         LIST OF TRIGGERED LAB SEARCHES
 ;   LabSearch#)         Observation descriptor
 ;                         ^01: Date/time of the observation
 ;                         ^02: Institution IEN
 ; RORVALS("PPTF",       List of inpatient procedure codes for patient
 ;   Datatype,           Datatype="C" for CPT, 'I' for ICD procedure
 ;   n,                  n = seq # unique to each multiple file entry found
 ;   "I")                Internal value
 ;
 ; RORVALS("SV",         VALUES OF THE SELECTION RULES
 ;   Rule Name,          Current value
 ;     "AVG")            Average value
 ;     "CNT")            Counter
 ;     "DTF")            Used by the {SDF} and {SDL} macros to store
 ;     "DTL")            the earliest and the latest trigger dates
 ;     "MAX")            Maximum value
 ;     "MIN")            Minimum value
 ;     "SUM")            Total value
 ;
 ; PREDEFINED NAME ----- VALUE AND DESCRIPTION
 ;
 ; "ROR DFN"             IEN of the patient being processed
 ; "ROR SRDT"            Date when the current selection rule was
 ;                       triggered (it is set by APLRULES^RORUPDUT
 ;                       but could be changed by selection rules).
 ;                       The {GDF} and {GDL} macros modify this
 ;                       value as well.
 ; "ROR SRLOC"           Institution IEN where the selection rule
 ;                       was triggered
 ;
 Q
 ;
 ;***** APPLIES SELECTION RULES TO THE RECORD
 ;
 ; FILE          File/Subfile number
 ; IENS          IENS of the current record
 ; MODE          "B" (process before subfiles) or
 ;               "A" (process after subfiles)
 ; [DATE]        Trigger date (TODAY by default)
 ; [LOCATION]    Institution IEN (empty by default)
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Continue processing of the current patient
 ;        1  Stop looping
 ;
APLRULES(FILE,IENS,MODE,DATE,LOCATION) ;
 N EXPR,HDR,LM,PATIEN,RC,REGIEN,RI,RULENAME,RULENODE,TMP,RORCSYS
 S:'$G(DATE) DATE=$$DT^XLFDT
 S:$G(RORUPD("IMPDATE","ICD10"))="" RORUPD("IMPDATE","ICD10")=$$IMPDATE^LEXU("10D")  ;ICD-10 implementation date
 ;--- Loop through the selection rules
 S RI="",RC=0
 F  S RI=$O(RORUPD("SR",FILE,MODE,RI))  Q:RI=""  D  Q:RC<0
 . S RULENODE=$NA(RORUPD("SR",FILE,MODE,RI))
 . ;Check if rule is applicable or not based on coding system
 . S RORCSYS=@RULENODE@(3)
 . Q:(DATE<RORUPD("IMPDATE","ICD10")&(RORCSYS=30!(RORCSYS=31)))  ;quit if date is before ICD-10 implementation date and selection rule is applicable for ICD-10 coding system
 . Q:(DATE'<RORUPD("IMPDATE","ICD10")&(RORCSYS=1!(RORCSYS=2)))  ;quit if date is on or after ICD-10 implementation date and selection rule is applicable for ICD-9 coding system 
 . S RORVALS("SV","ROR SRDT")=$P(DATE,".")
 . S RORVALS("SV","ROR SRLOC")=$G(LOCATION)
 . S HDR=$G(@RULENODE),RULENAME=$P(HDR,U)
 . ;--- If a top level rule does not exist in the control list, this
 . ;    rule has been already triggered for the patient. So, there is
 . ;    no need to check it again.
 . I $P(HDR,U,3)  Q:'$D(RORUPD("LM",1,RULENAME))
 . ;--- Get value of registry for selection rule
 . S REGIEN=$O(@RULENODE@(2,""))
 . Q:REGIEN=""
 . ;--- Compute the expression of the selection rule
 . X "S RC="_@RULENODE@(1)
 . I $P(HDR,U,3)  Q:'RC  D               ; TOP LEVEL RULE
 . . S PATIEN=$$GETVAL("ROR DFN"),REGIEN=""
 . . F  S REGIEN=$O(@RULENODE@(2,REGIEN))  Q:REGIEN=""  D
 . . . ;--- Check if the patient is already in the registry
 . . . Q:'$G(RORUPD("LM2",REGIEN))
 . . . ;--- Save the rule reference for the registry and new patient
 . . . S TMP=$$GETVAL("ROR SRDT")_U_$$GETVAL("ROR SRLOC")
 . . . S @RORUPDPI@("U",PATIEN,2,REGIEN,+$P(HDR,U,2))=TMP
 . . . ;--- Remove the registry from the control list
 . . . K RORUPD("LM",2,REGIEN)
 . . ;--- Remove the rule from the control list
 . . K RORUPD("LM",1,RULENAME)
 . E  D SETVAL(RULENAME,RC)              ; LOWER LEVEL RULE
 . S RC=0
 S LM=+$G(RORUPD("LM")) ; Loop mode
 ;--- If the loop mode equals 0, continue processing of the patient
 ;    in any case. Otherwise, stop processing if the corresponding
 ;    control list is empty.
 Q $S(RC<0:RC,LM:$D(RORUPD("LM",LM))<10,1:0)
 ;
 ;***** CLEARS DATA ELEMENT VALUES
 ;
 ; FILE          File/Subfile number
 ;
CLRDES(FILE) ;
 K RORVALS("DV",FILE)
 K RORVALS("PPTF",FILE)
 Q
 ;
 ;***** CLEARS VALUE OF THE ERROR COUNTER
CLREC ;
 K RORUPD("ERRCNT")
 Q
 ;
 ;***** CLEARS VALUES OF THE SELECTION RULES ASSOCIATED WITH THE FILE
 ;
 ; FILE          File/Subfile number
 ;
CLRVALS(FILE) ;
 N MODE,RI,RULENAME
 F MODE="B","A"  D
 . S RI=""
 . F  S RI=$O(RORUPD("SR",FILE,MODE,RI))  Q:RI=""  D
 . . S RULENAME=$P($G(RORUPD("SR",FILE,MODE,RI)),U)
 . . K:RULENAME'="" RORVALS("SV",RULENAME)
 Q
 ;
 ;***** RETURNS A CODE OF THE DATA ELEMENT
 ;
 ; FILE          File number
 ; NAME          Name of the data element
 ;
 ; Return values:
 ;       <0  Error code
 ;       >0  Code of the data element
 ;
DATACODE(FILE,NAME) ;
 N DIERR,IENS,RC,RORBUF,RORMSG
 S IENS=","_FILE_","
 D FIND^DIC(799.22,IENS,"@;.02I","X",NAME,,"B",,,"RORBUF","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,,799.22,IENS)
 S RC=+$G(RORBUF("DILIST",0))
 Q:RC<1 $$ERROR^RORERR(-69,,NAME)
 Q:RC>1 $$ERROR^RORERR(-70,,NAME)
 Q +$G(RORBUF("DILIST","ID",1,.02))
 ;
 ;***** PRINTS SOME DEBUG INFORMATION
DEBUG ;
 N I
 D ZW^RORUTL01($NA(RORUPD("FLAGS")),"Control Flags")
 D ZW^RORUTL01($NA(RORUPD("SR")),"Selection Rules")
 D ZW^RORUTL01($NA(RORUPD("UPD")),"Call-back Entry Points")
 W !,"Control Lists",!!
 F I="LM1","LM2"  D ZW^RORUTL01($NA(RORUPD(I)))
 D ZW^RORUTL01("RORLRC","Lab Results to check")
 W !,"Job number: ",$J,!
 Q
 ;
 ;***** GETS A VALUE OF THE DATA ELEMENT
 ;
 ; FILE          File number
 ; DATELMT       Code of the data element
 ; [TYPE]        Type of the value
 ;                 "E"  External
 ;                 "I"  Internal (default)
 ;
GETDE(FILE,DATELMT,TYPE) ;
 Q $G(RORVALS("DV",FILE,DATELMT,$G(TYPE,"I")))
 ;
 ;***** RETURNS VALUE OF THE ERROR COUNTER
GETEC() ;
 Q +$G(RORUPD("ERRCNT"))
 ;
 ;***** GETS VALUE OF THE SELECTION RULE
 ;
 ; RULENAME      Name of the rule
 ; [PFX]         Prefix of the value
 ;                 ""     Value itself (default)
 ;                 "AVG"  Average value
 ;                 "CNT"  Counter
 ;                 "MAX"  Maximum value
 ;                 "MIN"  Minimum value
 ;                 "SUM"  Total sum
 ;
GETVAL(RULENAME,PFX) ;
 Q $S($G(PFX)="":$G(RORVALS("SV",RULENAME)),1:$G(RORVALS("SV",RULENAME,PFX)))
 ;
 ;***** INCREMENTS VALUE OF THE ERROR COUNTER
 ;
 ; [RC]          Reference to a variable containing the error code
 ;
INCEC(RC) ;
 S:$G(RC,-1)<0 RORUPD("ERRCNT")=$G(RORUPD("ERRCNT"))+1,RC=0
 Q
 ;
 ;***** LOADS DATA ELEMENT VALUES FROM CORRESPONDING FIELDS
 ;
 ; FILE          File/Subfile number
 ; IENS          IENS of the current record
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOADFLDS(FILE,IENS) ;
 N DE,FLD,RC,RORFDA,RORMSG,VT  K RORVALS("DV",FILE) K:FILE=45 RORVALS("PPTF",45)
 S FLD=$G(RORUPD("SR",FILE,"F",1))  Q:FLD="" 0
 ;--- Load the field values
 D GETS^DIQ(FILE,IENS,FLD,"EIN","RORFDA","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,,FILE,IENS)
 ;--- Copy the field values from the FDA
 S DE=""
 F  S DE=$O(RORUPD("SR",FILE,"F",1,DE))  Q:DE=""  D
 . S FLD=+$G(RORUPD("SR",FILE,"F",1,DE))  Q:'FLD
 . S VT=""
 . F  S VT=$O(RORUPD("SR",FILE,"F",1,DE,VT))  Q:VT=""  D
 . . S RORVALS("DV",FILE,DE,VT)=$G(RORFDA(FILE,IENS,FLD,VT))
 S DE=""
 F  S DE=$O(RORUPD("SR",FILE,"F",3,DE))  Q:DE=""  D
 . S VT=""
 . F  S VT=$O(RORUPD("SR",FILE,"F",3,DE,VT))  Q:VT=""  D
 . . N ADMDT,VT,FILE,IEN ; protect some variables
 . . ; Call the API to return the CPT codes and ICD procedures for surgery and 'other'
 . . ; Returns array RORVALS("PPTF","C",n,"I") for CPT codes
 . . ;               RORVALS("PPTF","I",n,"I") for ICD procedure codes
 . . D SETPROC^RORUTL20(DE,IENS,.RORUPD,.RORVALS)
 Q 0
 ;
 ;***** SETS THE EARLIEST DATE FOR THE RULE
 ;
 ; NAME          Name of the selection rule
 ; COND          Result value of the logical condition
 ;
 ; Return values:
 ;        0  COND equals to zero
 ;        1  COND is not zero
 ;
SDF(NAME,COND) ;
 Q:'$G(COND) 0
 N DATE
 S DATE=$G(RORVALS("SV","ROR SRDT"))
 D:DATE>0
 . I $G(RORVALS("SV",NAME,"DTF"))'>0  D  Q
 . . S RORVALS("SV",NAME,"DTF")=DATE
 . S:DATE<RORVALS("SV",NAME,"DTF") RORVALS("SV",NAME,"DTF")=DATE
 Q 1
 ;
 ;***** SETS THE LATEST DATE FOR THE RULE
 ;
 ; NAME          Name of the selection rule
 ; COND          Result value of the logical condition
 ;
 ; Return values:
 ;        0  COND equals to zero
 ;        1  COND is not zero
 ;
SDL(NAME,COND) ;
 Q:'$G(COND) 0
 N DATE
 S DATE=$G(RORVALS("SV","ROR SRDT"))
 D:DATE>0
 . S:DATE>$G(RORVALS("SV",NAME,"DTL")) RORVALS("SV",NAME,"DTL")=DATE
 Q 1
 ;
 ;***** SETS VALUE OF THE SELECTION RULE
 ;
 ; RULENAME      Name of the rule
 ; VALUE         New value
 ;
SETVAL(RULENAME,VALUE) ;
 S RORVALS("SV",RULENAME)=VALUE
 S RORVALS("SV",RULENAME,"CNT")=$G(RORVALS("SV",RULENAME,"CNT"))+1
 S RORVALS("SV",RULENAME,"SUM")=$G(RORVALS("SV",RULENAME,"SUM"))+VALUE
 S RORVALS("SV",RULENAME,"AVG")=RORVALS("SV",RULENAME,"SUM")/RORVALS("SV",RULENAME,"CNT")
 ;
 I $G(RORVALS("SV",RULENAME,"MIN"))=""  S RORVALS("SV",RULENAME,"MIN")=VALUE
 E   S:VALUE<RORVALS("SV",RULENAME,"MIN") RORVALS("SV",RULENAME,"MIN")=VALUE
 ;
 I $G(RORVALS("SV",RULENAME,"MAX"))=""  S RORVALS("SV",RULENAME,"MAX")=VALUE
 E   S:VALUE>RORVALS("SV",RULENAME,"MAX") RORVALS("SV",RULENAME,"MAX")=VALUE
 Q
 ;
 ;***** GETS THE TRIGGER DATE OF THE RULE
 ;
 ; NAME          Name of the selection rule
 ; PFX           Prefix of the value ("GDF" or "GDL")
 ; COND          Result value of the logical condition
 ;
 ; Return values:
 ;        0  COND equals to zero
 ;        1  COND is not zero
 ;
SRDT(NAME,PFX,COND) ;
 Q:'$G(COND) 0
 N DATE
 S DATE=$G(RORVALS("SV",NAME,$S(PFX="GDL":"DTL",1:"DTF")))
 I DATE  S:DATE<$G(RORVALS("SV","ROR SRDT")) RORVALS("SV","ROR SRDT")=DATE
 Q 1
