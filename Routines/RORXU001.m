RORXU001 ;HOIFO/BH,SG,VAC - REPORT UTILITIES ;4/23/09 1:21pm
 ;;1.5;CLINICAL CASE REGISTRIES;**8,13**;Feb 17, 2006;Build 27
 ;
 ; This routine uses the following IAs:
 ;
 ; #325          ADM^VADPT2 (controlled)
 ; #2056         GET1^DIQ, GETS^DIQ (supported)
 ; #10103        DT^XLFDT, FMADD^XLFDT
 ; #2548         APIs in routine SDQ: ACRP Interface Toolkit (supported)
 ; #417          .01 field and "C" x-ref of file #40.8 (controlled)
 ; #3545         ^DGPT("AAD" (private)
 ; #10061        IN5^VADPT (supported) 
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   Added tags CDUTIL and CDSCAN to check
 ;                                      for encounters in selected Divisions or
 ;                                      Clinics.  Added tag CDPARMS to set
 ;                                      Clnic and Division list parameters.
 ;
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** DOUBLE CHECKS THE ADMISSION
 ;
 ; DFN           Patient IEN
 ; VAINDT        Admission date
 ; .DISDT        Discharge date
 ;
 ; Return Values:
 ;        0  Ok
 ;        1  Invalid admission date
 ;
CHKADM(DFN,VAINDT,DISDT) ;
 N IEN,RORMSG,VADMVT,VAHOW,VAROOT
 D ADM^VADPT2  Q:'VADMVT 1
 S IEN=+$$GET1^DIQ(405,VADMVT,.17,"I",,"RORMSG")
 S:IEN>0 DISDT=$$GET1^DIQ(405,IEN_",",.01,"I",,"RORMSG")
 Q 0
 ;
 ;***** DATE OF THE MOST RECENT VISIT TO ANY OF THE SELECTED CLINICS
 ;
 ; PATIEN        Patient IEN (file #2)
 ;
 ; .RORCLIN      Reference to a local array of Clinics, the subscripts
 ;               are IEN's from file #44 or will be a single element
 ;               array with a subscript of "ALL", which will denote
 ;               all clinics (i.e. CLIN("ALL")="").
 ;
 ; Return Values:
 ;        0  The patient has never been seen at any of the given
 ;           clinics
 ;       >0  Date of the most recent visit to one of the selected
 ;           clinics
 ;
LASTVSIT(PATIEN,RORCLIN) ;
 N QUERY,RORDT,RORLAST
 S RORDT=$$FMADD^XLFDT($$DT^XLFDT,1),RORLAST=0
 ;---
 D OPEN^SDQ(.QUERY)
 D INDEX^SDQ(.QUERY,"PATIENT","SET")
 D PAT^SDQ(.QUERY,PATIEN,"SET")
 D SCANCB^SDQ(.QUERY,"D SDQSCAN2^RORXU001(Y,Y0)","SET")
 D ACTIVE^SDQ(.QUERY,"TRUE","SET")
 D SCAN^SDQ(.QUERY,"FORWARD")
 D CLOSE^SDQ(.QUERY)
 ;---
 Q RORLAST
 ;
 ;***** LOADS PTF DATA AND CHECKS IF THE RECORD SHOULD BE SKIPPED
 ;
 ; PTFIEN        IEN of the PTF record
 ;
 ; [FLAGS]       Flags to control processing
 ;                 F  Skip fee-basis records - This flag commented
 ;                         out April 2009
 ;                 P  Skip non-PTF records
 ;
 ; [.ADMDT]      Admission date is returned via this parameter
 ; [.DISDT]      Discharge date is returned via this parameter
 ; [.SUFFIX]     Suffix is returned via this parameter
 ; [.STATUS]     Status is returned via this parameter
 ; [.FACILITY]   Facility number is returned via this parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;        1  Skip this record
 ;
PTF(PTFIEN,FLAGS,ADMDT,DISDT,SUFFIX,STATUS,FACILITY) ;
 N FLDLST,IENS,RORBUF,RORMSG
 S FLAGS=$G(FLAGS),IENS=(+PTFIEN)_","
 S FLDLST="2;3;5;6;70"
 ;S:FLAGS["F" FLDLST=FLDLST_";4"        ; FEE BASIS- commented out
 S:FLAGS["P" FLDLST=FLDLST_";11"       ; TYPE OF RECORD
 ;--- Load the data
 K RORMSG D GETS^DIQ(45,IENS,FLDLST,"I","RORBUF","RORMSG")
 ;Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,45,IENS)
 Q:$G(RORMSG("DIERR")) $$DBS^RORERR("RORMSG",-9,,,45,IENS)
 ;---
 S ADMDT=$G(RORBUF(45,IENS,2,"I"))     ; ADMISSION DATE
 S FACILITY=$G(RORBUF(45,IENS,3,"I"))  ; FACILITY
 S SUFFIX=$G(RORBUF(45,IENS,5,"I"))    ; SUFFIX
 S STATUS=$G(RORBUF(45,IENS,6,"I"))    ; STATUS
 S DISDT=$G(RORBUF(45,IENS,70,"I"))    ; DISCHARGE DATE
 Q:ADMDT'>0 1
 ;--- Skip a non-PTF record
 I FLAGS["P"  Q:$G(RORBUF(45,IENS,11,"I"))'=1 1
 ;--- Skip a fee basis record
 I FLAGS["F"  Q:$G(RORBUF(45,IENS,4,"I")) 1
 ;--- Success
 Q 0
 ;
 ;**** CALL-BACK ENTRY POINTS FOR THE SDQ API
SDQSCAN1(Y,Y0) ;
 N TMP
 ;--- Check the clinic
 I '$$PARAM^RORTSK01("CLINICS","ALL")  D  Q:'TMP
 . S TMP=$D(RORTSK("PARAMS","CLINICS","C",+$P(Y0,U,4)))
 ;--- Count the encounters
 S RORENCNT=RORENCNT+1
 Q
 ;
SDQSCAN2(Y,Y0) ;
 N DTX,TMP
 ;--- Check the clinic
 I '$$PARAM^RORTSK01("CLINICS","ALL")  D  Q:'TMP
 . S TMP=$D(RORTSK("PARAMS","CLINICS","C",+$P(Y0,U,4)))
 ;--- Date of the visit
 S DTX=+$P(Y0,U)  S:(DTX>RORLAST)&(DTX<RORDT) RORLAST=DTX
 Q
 ;
 ;***** CHECKS IF THE PATIENT WAS SEEN AT SELECTED CLINICS
 ;
 ; RORSDT        Start Date for search (FileMan).
 ;               Time is ignored and the beginning of the day is
 ;               considered as the boundary (ST\1).
 ;
 ; ROREDT        End Date for search (FileMan).
 ;               Time is ignored and the end of the day is
 ;               considered as the boundary (ED\1+1).
 ;
 ; PATIEN        Patient IEN (file #2)
 ;
 ; Return Values:
 ;        0  The patient was not seen at any of the given clinics
 ;           during the provided time frame
 ;        1  The patient was seen
 ; 
SEEN(RORSDT,ROREDT,PATIEN) ;
 N QUERY,RORENCNT
 S RORENCNT=0
 ;---
 D OPEN^SDQ(.QUERY)
 D INDEX^SDQ(.QUERY,"PATIENT/DATE","SET")
 D PAT^SDQ(.QUERY,PATIEN,"SET")
 D DATE^SDQ(.QUERY,RORSDT\1,$$FMADD^XLFDT(ROREDT\1,1),"SET")
 D SCANCB^SDQ(.QUERY,"D SDQSCAN1^RORXU001(Y,Y0)","SET")
 D ACTIVE^SDQ(.QUERY,"TRUE","SET")
 D SCAN^SDQ(.QUERY,"FORWARD")
 D CLOSE^SDQ(.QUERY)
 ;---
 Q (RORENCNT>0)
 ;
 ;***** SET UP CLINIC/DIVISION LIST PARAMETERS
 ;
 ;Input
 ; RORTSK    Report parameters
 ; OVERRIDE  Optional. If '1', send back dates in DATE_RANGE_3 instead of
 ;           dates in DATE_RANGE.
 ;
 ;Output
 ; 1 if clinic or division list exists, else 0
 ; START - Date in RORTSK("PARAMS","DATE_RANGE","A","START")
 ; END   - Date in RORTSK("PARAMS","DATE_RANGE","A","END")
 ;
CDPARMS(RORTSK,START,END,OVERRIDE) ;
 N FLAG S FLAG=0
 I $D(RORTSK("PARAMS","CLINICS","C")) S FLAG=1
 I $D(RORTSK("PARAMS","DIVISIONS","C")) S FLAG=1
 I FLAG D
 . I $G(OVERRIDE)=1 D
 .. S START=$G(RORTSK("PARAMS","DATE_RANGE_3","A","START"))
 .. S END=$G(RORTSK("PARAMS","DATE_RANGE_3","A","END"))
 . E  D
 .. S START=$G(RORTSK("PARAMS","DATE_RANGE","A","START"))
 .. S END=$G(RORTSK("PARAMS","DATE_RANGE","A","END"))
 Q FLAG
 ;
 ;***** EVALUATE CLINIC OR DIVISION UTILIZATION
 ;Will determine if the patient had any utilization in any of the
 ;clinics or division in the list.
 ;
 ;Input
 ; RORTSK   Report parameters with clinic or division list
 ; DFN      Patient DFN from file #2
 ; RORSDT   Start date for search
 ; ROREDT   End date for search
 ;
 ;Return Values:
 ; MATCH  Flag to indicate whether the patient should be on the report:
 ; 
 ;        1  The patient should appear on the report because at least 1 of
 ;           the following is true:
 ;           -- all clinics or divisions are selected
 ;           -- the patient has an outpatient encounter in at least 1 of the
 ;              clinics on the clinic list
 ;           -- the patient has an outpatient encounter in at least 1 of the
 ;              divisions on the division list
 ;           -- the patient has an inpatient 'movement' in at least 1 of the
 ;              divisions on the division list
 ;           
 ;        0  Parameter error or the patient should not appear on the report
 ; 
CDUTIL(RORTSK,DFN,RORSDT,ROREDT) ;
 Q:'DFN 0
 Q:'RORSDT 0
 Q:'ROREDT 0
 N TYPE  ;type of list = CLINICS or DIVISIONS
 N MATCH ;flag to indicate whether to keep or skip the patient
 N PIECE ;clinic or division piece number on the encounter node
 S (TYPE,MATCH,PIECE)=0
 ;
 ;---Set Clinic and Division variables
 I $D(RORTSK("PARAMS","CLINICS","C")) S TYPE="CLINICS",PIECE=4 ;clinic
 I $D(RORTSK("PARAMS","DIVISIONS","C")) S TYPE="DIVISIONS",PIECE=11 ;division
 ;
 Q:(TYPE=0) 1  ;quit if ALL divisions and clinics are requested
 ;
 ;if division list, check for inpatient utilization
 I TYPE="DIVISIONS" D INPAT(DFN,RORSDT,ROREDT,.MATCH)
 ;
 ;if no utilization found yet, check outpatient encounters
 I 'MATCH D OUTPAT(DFN,RORSDT,ROREDT,TYPE,PIECE,.MATCH)
 ;
 Q MATCH
 ;
 ;***** CHECK FOR INPATIENT UTILIZATION IN DIVISION(S).
 ;
 ;Input
 ; DFN      Patient DFN from file #2
 ; RORSDT   Start date for search
 ; ROREDT   End date for search
 ; MATCH    Flag for output
 ;
 ;Output
 ; MATCH=1  Inpatient utilization found in selected division(s)
 ; MATCH=0  No inpatient utilization found in selected division(s)
 ;
INPAT(DFN,RORSDT,ROREDT,MATCH) ; get inpatient data
 N ADMDATE,STOP,MVDATE,RC,PTFIEN,TMP,DIVIEN,RC
 S STOP=0,RC=0
 S ADMDATE=RORSDT
 S ROREDT=ROREDT_".235959"
 ;beginning with the 'start' date, first see if the patient was already an
 ;inpatient at that time.  Then loop through admission dates in ^DGPT.
 F  Q:STOP  D  S ADMDATE=$O(^DGPT("AAD",DFN,ADMDATE)) Q:ADMDATE'>0
 . I ADMDATE>ROREDT S STOP=1 Q
 . K MVDATE,VAIP  S VAIP(16,1)=ADMDATE
 . F  Q:STOP  D  Q:RC
 .. S VAIP("D")=+$G(VAIP(16,1))
 .. I VAIP("D")'>0 S RC=1 Q
 .. D IN5^VADPT
 .. S MVDATE=+$G(VAIP(3)) ;movement date (internal format)
 .. Q:+$G(VAIP(4))=3  ;quit if type of movement is OPT-SC
 .. ;--- Check if movement date is after end date
 .. I $G(MVDATE)>ROREDT Q
 .. ;--- Check the PTF record
 .. S PTFIEN=+$G(VAIP(12))  Q:PTFIEN'>0
 .. ;skip non-ptf records and fee-basis records
 .. N SUFFIX,FACILITY
 .. Q:$$PTF^RORXU001(PTFIEN,"FP",,,.SUFFIX,,.FACILITY)
 .. ;--- Check the division
 .. S TMP=$$PARAM^RORTSK01("DIVISIONS","ALL")
 .. I 'TMP  D
 ... S TMP=FACILITY_SUFFIX
 ... S DIVIEN=$S(TMP'="":+$O(^DG(40.8,"C",TMP,"")),1:0)
 ... I $D(RORTSK("PARAMS","DIVISIONS","C",DIVIEN)) S MATCH=1,STOP=1
 Q
 ;
 ;***** CHECK FOR OUTPATIENT UTILIZATION IN CLINIC/DIVISION(S).
 ;
 ;Input
 ; DFN      Patient DFN from file #2
 ; RORSDT   Start date for search
 ; ROREDT   End date for search
 ; MATCH    Flag for output
 ;
 ;Output
 ; MATCH=1  Outpatient utilization found
 ; MATCH=0  No outpatient utilization found
 ;
OUTPAT(DFN,RORSDT,ROREDT,TYPE,PIECE,MATCH) ; get outpatient encounter data
 K SDQDATA,SDQUERY N QUERY
 D OPEN^SDQ(.QUERY)
 I '$$ERRCHK^SDQUT() D INDEX^SDQ(.QUERY,"PATIENT/DATE","SET")
 I '$$ERRCHK^SDQUT() D PAT^SDQ(.QUERY,DFN,"SET")
 I '$$ERRCHK^SDQUT() D DATE^SDQ(.QUERY,RORSDT,$$FMADD^XLFDT(ROREDT,1),"SET")
 I '$$ERRCHK^SDQUT() D SCANCB^SDQ(.QUERY,"I 'MATCH D CDSCAN^RORXU001(Y0,.MATCH,.TYPE,.PIECE,.RORTSK)","SET")
 I '$$ERRCHK^SDQUT() D ACTIVE^SDQ(.QUERY,"TRUE","SET")
 I '$$ERRCHK^SDQUT() D SCAN^SDQ(.QUERY,"FORWARD")
 D CLOSE^SDQ(.QUERY)
 ;---
 K SDQDATA,SDQUERY,SDCNT
 Q
 ;
 ;***** SDQ CALLBACK - EXECUTED FOR EACH ENCOUNTER RETURNED IN CDLIST.
 ;                     LOOKING FOR MATCH ON CLINIC OR DIVISION.
 ;Input
 ; Y0       Encounter information returned from SCAN^SDQ
 ;                     4th piece = clinic IEN
 ;                    11th piece = division IEN
 ;
 ; MATCH    Comes in set to 0
 ; TYPE     CLINICS or DIVISIONS
 ; PIECE    Piece# of encounter data of interest (clinic or division)
 ; RORTSK   Report parameters
 ;
 ;Output
 ; MATCH=1  Encounter meets utilization requirement
 ; MATCH=0  Encounter does not meet utilization requirement
 ;        
CDSCAN(Y0,MATCH,TYPE,PIECE,RORTSK) ; get clinic/division from encounter
 ;--- Check the list
 I $D(RORTSK("PARAMS",TYPE,"C",+$P(Y0,U,PIECE))) S MATCH=1
 Q
