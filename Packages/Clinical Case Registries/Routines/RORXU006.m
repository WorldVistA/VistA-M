RORXU006 ;HCIOFO/SG - REPORT PARAMETERS ;6/21/06 1:41pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,13,21**;Feb 17, 2006;Build 45
 ;
 ; This routine uses the following IAs:
 ;
 ; #91           Read access to the file #60 (controlled)
 ; #417          The .01 field of file #40.8 (controlled)
 ; #2947         ATESTS^ORWLRR (controlled)
 ; #10035        Direct read of DOD field of file #2 (supported)
 ; #10040        Read access to HOSPITAL LOCATION file (supported)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   Moved code in tags CLINLST and DIVLST to
 ;                                      PARMS^RORXU002 so the clinic or
 ;                                      division XML will be returned for all
 ;                                      reports. 
 ;                                      NOTE: Patch 11 became patch 13.
 ;                                      Any references to patch 11 in the code
 ;                                      below is referring to path 13.
 ;ROR*1.5*21   SEP 2013    T KOPP       Add ICN column if Additional Identifier
 ;                                       requested.
 ;
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** PROCESSES THE LIST OF CLINICS
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the CLINICS element
 ;
CLINLST(RORTSK,PARTAG) ;
 Q 0  ;code removed for patch 11
 N IEN,LTAG,RORMSG,TMP
 I $D(RORTSK("PARAMS","CLINICS","C"))>1  D
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"CLINICS",,PARTAG)  Q:LTAG'>0
 . S IEN=0
 . F  S IEN=$O(RORTSK("PARAMS","CLINICS","C",IEN))  Q:IEN'>0  D
 . . S TMP=$$GET1^DIQ(44,IEN_",",.01,,,"RORMSG")
 . . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,44,IEN_",")
 . . Q:TMP=""
 . . D ADDVAL^RORTSK11(RORTSK,"CLINIC",TMP,LTAG,,IEN)
 E  D:$$PARAM^RORTSK01("CLINICS","ALL")
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"CLINICS","ALL",PARTAG)
 Q +$G(LTAG)
 ;
 ;***** PROCESSES THE LIST OF CPT CODES
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the CPTLST element
 ;
CPTLST(RORTSK,PARTAG) ;
 N CPT,IEN,LTAG,TMP
 I $D(RORTSK("PARAMS","CPTLST","C"))>1  D
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"CPTLST",,PARTAG)  Q:LTAG'>0
 . S IEN=0
 . F  S IEN=$O(RORTSK("PARAMS","CPTLST","C",IEN))  Q:IEN'>0  D
 . . S CPT=$P(RORTSK("PARAMS","CPTLST","C",IEN),U)  Q:CPT=""
 . . D ADDVAL^RORTSK11(RORTSK,"CPT",CPT,LTAG,,IEN)
 E  D:$$PARAM^RORTSK01("CPTLST","ALL")
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"CPTLST","ALL",PARTAG)
 Q +$G(LTAG)
 ;
 ;***** PROCESSES THE LIST OF DIVISIONS
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the DIVISIONS element
 ;
DIVLST(RORTSK,PARTAG) ;
 Q 0  ;code removed for patch 11
 N IEN,LTAG,RORMSG,TMP
 I $D(RORTSK("PARAMS","DIVISIONS","C"))>1  D
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"DIVISIONS",,PARTAG)  Q:LTAG'>0
 . S IEN=0
 . F  S IEN=$O(RORTSK("PARAMS","DIVISIONS","C",IEN))  Q:IEN'>0  D
 . . S TMP=$$GET1^DIQ(40.8,IEN_",",.01,,,"RORMSG")
 . . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,40.8,IEN_",")
 . . Q:TMP=""
 . . D ADDVAL^RORTSK11(RORTSK,"DIVISION",TMP,LTAG,,IEN)
 E  D:$$PARAM^RORTSK01("DIVISIONS","ALL")
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"DIVISIONS","ALL",PARTAG)
 Q +$G(LTAG)
 ;
 ;***** PROCESSES THE LIST OF LAB TESTS
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ;
 ; .ROR8LST      Reference to a local variable, which contains a
 ;               closed root of an array. Descriptors of selected
 ;               lab tests will be returned into this array.
 ;
 ;                 @ROR8LTST@(ResultNode,TestIEN)
 ;                   ^01: Test IEN (in file #60)
 ;                   ^02: Test name
 ;                   ^03: 99
 ;                   ^04: "Other"
 ;                   ^05: Location subscript
 ;                   ^06: Result node
 ;
 ;               If this parameter is undefined or empty, then a
 ;               temporary buffer is allocated by the $$ALLOC^RORTMP
 ;               function and its root is returned via this parameter.
 ;
 ;               If all drugs are requested (the "ALL" attribute of
 ;               the "DRUGS" tag), then "*" is returned.
 ;
 ; [ROR8LRG]     Closed root of a node where the lab tests with
 ;               defined range values will be returned. By default
 ;               ($G(ROR8LRG)=""), this list is not compiled.
 ;
 ;                  @ROR8LRG@(TestIEN,
 ;                    "H") = Low
 ;                    "L") = High
 ;
 ;               "H", "L", or both will be defined.
 ;
 ; If the source list contains lab test panels, all corresponding
 ; lab tests are added to the @ROR8LST array but only a single tag
 ; is added to the XML list.
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the LABTESTS element
 ;
LTLST(RORTSK,PARTAG,ROR8LST,ROR8LRG) ;
 N ALL,BUF,I,LTAG,LTIEN,LTOPTS,TMP
 S ALL=+$$PARAM^RORTSK01("LABTESTS","ALL")
 S (LTAG,RC)=0
 ;
 ;=== Validate parameters
 I 'ALL  D  K @ROR8LST
 . S:$G(ROR8LST)="" ROR8LST=$$ALLOC^RORTMP()
 E  S ROR8LST="*"
 ;
 ;=== Process the drug options (if present)
 M LTOPTS=RORTSK("PARAMS","LABTESTS","A")
 I $D(LTOPTS)>1  D  Q:LTAG'>0 LTAG
 . N ATTR,REGIEN
 . S ATTR=$S(ALL:"ALL",1:"")
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"LABTESTS",ATTR,PARTAG)
 . Q:LTAG'>0
 . ;--- Output option attributes
 . S ATTR="",RC=0
 . F  S ATTR=$O(LTOPTS(ATTR))  Q:ATTR=""  D  Q:RC<0
 . . S RC=$$ADDATTR^RORTSK11(RORTSK,LTAG,ATTR,"1")
 . I RC<0  S LTAG=RC  Q
 . S ATTR=$$OPTXT^RORXU002(.LTOPTS)
 . D:ATTR'="" ADDATTR^RORTSK11(RORTSK,LTAG,"DESCR",ATTR)
 ;
 ;=== Process the list of tests (if present)
 I 'ALL,$D(RORTSK("PARAMS","LABTESTS","C"))>1  D
 . I LTAG'>0  D  Q:LTAG'>0
 . . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"LABTESTS",,PARTAG)
 . S LTIEN=0
 . F  S LTIEN=$O(RORTSK("PARAMS","LABTESTS","C",LTIEN))  Q:LTIEN'>0  D
 . . D LTLSTI(LTIEN,LTAG)
 ;
 Q $S(RC<0:RC,1:LTAG)
 ;
 ;***** CREATES THE LAB TEST ITEM(S)
 ;
 ; LTIEN         IEN of the lab test in the file #60
 ; [LTAG]        IEN of the parent tag
 ;
 ; This is an internal entry point. Do NOT call it directly.
 ;
LTLSTI(LTIEN,LTAG) ;
 N BUF,I,IENS,ITEM,LTNAME,LTNODE,PLTCNT,RORBUF,RORMSG,TMP
 ;--- Load the lab test parameters
 S IENS=LTIEN_","
 D GETS^DIQ(60,IENS,".01;5","EI","RORBUF","RORMSG")
 D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,60,IENS)
 S LTNAME=$G(RORBUF(60,IENS,.01,"E"))  Q:LTNAME=""
 ;--- Output the tag and update the list of ranges
 D:$G(LTAG)>0
 . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"LT",LTNAME,LTAG,,LTIEN)
 . S TMP=$$UP^XLFSTR($G(RORTSK("PARAMS","LABTESTS","C",LTIEN,"L")))
 . D:TMP'=""
 . . D ADDATTR^RORTSK11(RORTSK,ITEM,"LOW",TMP)
 . . S:$G(ROR8LRG)'="" @ROR8LRG@(LTIEN,"L")=TMP
 . S TMP=$$UP^XLFSTR($G(RORTSK("PARAMS","LABTESTS","C",LTIEN,"H")))
 . D:TMP'=""
 . . D ADDATTR^RORTSK11(RORTSK,ITEM,"HIGH",TMP)
 . . S:$G(ROR8LRG)'="" @ROR8LRG@(LTIEN,"H")=TMP
 ;--- Process the panel
 D ATESTS^ORWLRR(.BUF,LTIEN)
 I $D(BUF)>1  S I="",PLTCNT=0  D  Q:PLTCNT>1
 . F  S I=$O(BUF(I))  Q:I=""  D
 . . S TMP=+$P(BUF(I),U),PLTCNT=PLTCNT+1
 . . D:TMP'=LTIEN LTLSTI(TMP)
 ;--- Create the reference
 S LTNODE=$P($G(RORBUF(60,IENS,5,"I")),";",2)  Q:LTNODE=""
 S BUF=LTIEN_U_LTNAME_U_"99^Other"
 S $P(BUF,U,5)=$P(RORBUF(60,IENS,5,"I"),";")  ; Subscript
 S $P(BUF,U,6)=LTNODE                         ; Result node
 S @ROR8LST@(LTNODE,LTIEN)=BUF
 Q
 ;
 ;***** CHECKS IF THE OPTIONAL COLUMN IS SELECTED
 ;
 ; NAME          Column name
 ;
 ; Return Values:
 ;        0  Skip the field
 ;       >0  Include in report
 ;
OPTCOL(NAME) ;
 Q $S($G(NAME)'="":$D(RORTSK("PARAMS","OPTIONAL_COLUMNS","C",NAME)),1:0)
 ;
 ;***** CHECK IF ONLY THE SUMMARY SHOULD BE GENERATED
SMRYONLY() ;
 Q:$$PARAM^RORTSK01("MAXUTNUM")'="" 0
 Q:$$PARAM^RORTSK01("MINRPNUM")'="" 0
 Q 1
 ;
 ;***** OUTPUTS ICN DATA IF ICN SHOULD BE THE FINAL COLUMN
 ; TASK          Task number
 ;
 ; VALUE         DFN of patient
 ;
 ; PARENT        IEN of the parent element
 ;
ICNDATA(TASK,VALUE,PARENT) ;
 N TMP
 S TMP=$$ICN^RORUTL02(VALUE)
 I TMP'<0 D ADDVAL^RORTSK11(TASK,"ICN",TMP,PARENT,1)
 Q
 ;
 ;***** OUTPUTS ICN HEADER IF ICN SHOULD BE THE FINAL COLUMN
 ; TASK          Task number
 ;
 ; PARENT        IEN of the parent element
 ;
ICNHDR(TASK,PARENT) ;
 N TMP
 S TMP=$$ADDVAL^RORTSK11(TASK,"COLUMN",,PARENT)
 D ADDATTR^RORTSK11(TASK,TMP,"NAME","ICN")
 Q
 ;
