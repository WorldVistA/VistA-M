RORX024A ;ALB/TK,MAF - HEP A/B VACCINE/IMMUNITY REPORTS (QUERY & STORE) ; 27 Jul 2016  3:04 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**29,30,31,33,34,37,38,39**;Feb 17, 2006;Build 4
 ;
 ; This routine uses the following IAs:
 ;
 ; #10103 FMADD^XLFDT (supported)
 ; #2051  FIND1^DIC
 ;   
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*29   APR 2016    T KOPP       Added for Hep A/B vaccine/immunity reports
 ;ROR*1.5*30   MAR 2017    M FERRARESE  LOINC CODES result values changed to uppercase
 ;ROR*1.5*31   MAY 2017    M FERRARESE  Adding PACT, PCP, and AGE/DOB as additional
 ;                                      identifiers.
 ;ROR*1.5*33   MAY 2017    M FERRARESE  Adding Future Appointment
 ;ROR*1.5*34   SEP 2018    M FERRARESE  Adding Future Appointment clinic name ; Fix LOINC code table for HEP A/B
 ;ROR*1.5*37   NOV 2020    F TRAXLER    Adding UNDET check in POS subroutine
 ;ROR*1.5*38   APR 2021    F TRAXLER    Fix bug introduced by ROR*1.5*37 change.
 ;ROR*1.5*39   JUN 2021    F TRAXLER    Replace real SSN with zeroes.
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** QUERIES THE REGISTRY
 ;
 ; FLAGS         Flags for the $$SKIP^RORXU005
 ; .NSPT         Number of selected patients is returned here
 ; RORRTN        Routine name for Hep A (RORX024) or Hep B (RORX025) report
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
QUERY(FLAGS,NSPT,RORRTN) ;
 N RORPTN        ; Number of patients in the registry
 N RORVSDT       ; Vaccination search start date
 N RORVEDT       ; Vaccination search end date
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 N RORICN        ; National ICN
 N RORPACT       ;Patient Care Team
 N RORPCP        ;Priamary Care Provider
 N AGE,AGETYPE
 N RORDAYS       ;Number of Days       PATCH 33
 N RORFUT        ;Future appointments  PATCH 33
 N RORCLIN       ;Future appointments clinic PATCH 34
 ;
 S:$G(RORRTN)="" RORRTN="RORX024"
 N CNT,IEN,IENS,LTEDT,LTSDT,RORHEPB,PATIEN,RC,SKIP,SKIPEDT,SKIPSDT,TMP,UTEDT,UTIL,UTSDT,VA,VADM,XREFNODE
 N RCC,FLAG
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S (CNT,NSPT,RC,SKIPEDT,SKIPSDT)=0
 ;--- Utilization date range
 D:$$PARAM^RORTSK01("PATIENTS","CAREONLY")
 . S UTSDT=$$PARAM^RORTSK01("DATE_RANGE_3","START")\1
 . S UTEDT=$$PARAM^RORTSK01("DATE_RANGE_3","END")\1
 . ;--- Combined date range
 . S SKIPSDT=$$DTMIN^RORUTL18(SKIPSDT,UTSDT)
 . S SKIPEDT=$$DTMAX^RORUTL18(SKIPEDT,UTEDT)
 ;--- Number of patients in the registry
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 ;
 ;--- Setup the immunity and vaccination parameters
 I RORIMM  D
 . ;--- Lab/LOINC codes date range
 . S LTSDT=$$PARAM^RORTSK01("DATE_RANGE_7","START")\1
 . S LTEDT=$$PARAM^RORTSK01("DATE_RANGE_7","END")\1
 . ;--- Combined date range
 . S SKIPSDT=$$DTMIN^RORUTL18(SKIPSDT,LTSDT)
 . S SKIPEDT=$$DTMAX^RORUTL18(SKIPEDT,LTEDT)
 . ;--- Shift the Labs end date
 . S LTEDT=$$FMADD^XLFDT(LTEDT,1)
 I RORVAC  D
 . S RORVSDT=$$PARAM^RORTSK01("DATE_RANGE_6","START")\1
 . S RORVEDT=$$PARAM^RORTSK01("DATE_RANGE_6","END")\1
 . ;--- Combined date range
 . S SKIPSDT=$$DTMIN^RORUTL18(SKIPSDT,RORVSDT)
 . S SKIPEDT=$$DTMAX^RORUTL18(SKIPEDT,RORVEDT)
 . ;--- Shift the vaccine end date
 . S RORVEDT=$$FMADD^XLFDT(RORVEDT\1,1)
 Q:'(RORIMM!RORVAC) 0
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT,1)
 ;
 S RORHEPB=$S(RORRTN'="RORX024":"",1:$$FIND1^DIC(798.1,,"BQX","VA HEPB"))
 ;--- Browse through the registry records
 S IEN=0
 S FLAG=$G(RORTSK("PARAMS","ICDFILT","A","FILTER"))
 F  S IEN=$O(@XREFNODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S IENS=IEN_",",CNT=CNT+1
 . ; Ignore patients in Hep B registry if Hep B report
 . I RORHEPB'="" Q:$D(^RORDATA(798,"AC",+RORHEPB,+IEN))
 . ;--- Get patient DFN
 . S PATIEN=$$PTIEN^RORUTL01(IEN)  Q:PATIEN'>0
 . ;check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",PATIEN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(IEN,FLAGS,SKIPSDT,SKIPEDT)
 . S SKIP=1,UTIL=0
 . ;--- Check if patient should be filtered because of ICD codes
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(PATIEN)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,PATIEN,RORCDSTDT,RORCDENDT) Q
 . ;
 . S RCC=0,SKIP=1
 . D
 . . ;--- Search for vaccination data in IMMUNIZATIONS file
 . . I RORVAC D  Q:RCC<0
 . . . N VAC,ROR8PAT,ROR8LST,RORVRES
 . . . S ROR8PAT=$NA(^TMP(RORRTN,$J,"VAC"))
 . . . S RORVRES=$NA(^TMP(RORRTN,$J,"VAC_RES")) K @RORVRES
 . . . S VAC=$$QUERY^RORUTL21(PATIEN,ROR8PAT,RORVRES,RORVSDT,RORVEDT)
 . . . I VAC<0 S RCC=-1 Q
 . . . I RORVAC<0,'VAC S ^TMP(RORRTN,$J,"PAT",PATIEN,"VAC")=0 Q     ; No vaccination requested and none found 
 . . . I RORVAC>0,VAC D  Q   ; Vaccination requested, at least one found
 . . . . S ROR8LST=$NA(^TMP(RORRTN,$J,"PAT",PATIEN,"VAC"))
 . . . . S RCC=$$PROCESS^RORUTL21(RORVRES,PATIEN,ROR8LST)
 . . . . K @RORVRES
 . . . . Q:RCC<0
 . . . S RCC=-1  ;does not pass vaccination selection criteria validation
 . . ;
 . . ;--- Search for lab data positive results for selected LOINC codes
 . . I RORIMM D  Q:RCC<0
 . . . N IMM,ROR8LST,RORLOINC,RORLRES
 . . . S RORLOINC=$NA(^TMP(RORRTN,$J,"IMM"))
 . . . ; Extract positive lab test results for selected LOINC codes
 . . . S IMM=$$LAB^RORX024(PATIEN,RORLOINC,.RORLRES,LTSDT,LTEDT)
 . . . I IMM<0 S RCC=-1 Q
 . . . I RORIMM<0,'IMM D  Q     ; No immunity requested and no positive test found
 . . . . S ^TMP(RORRTN,$J,"PAT",PATIEN,"IMM")=""
 . . . I RORIMM>0,IMM D  Q   ; Immunity requested, at least one positive lab test found
 . . . . S ^TMP(RORRTN,$J,"PAT",PATIEN,"IMM")=RORLRES
 . . . S RCC=-1  ;does not pass immunity selection criteria validation
 . . S SKIP=0
 . ;
 . ;--- Check for any utilization in the corresponding date range
 . I 'SKIP  D:$$PARAM^RORTSK01("PATIENTS","CAREONLY")
 . . K TMP  S TMP("ALL")=1
 . . S UTIL=+$$UTIL^RORXU003(UTSDT,UTEDT,PATIEN,.TMP)
 . . S:'UTIL SKIP=1
 . ;
 . ;--- Skip the patient if not all search criteria have been met
 . I SKIP K ^TMP(RORRTN,$J,"PAT",PATIEN) Q
 . ;
 . ;--- Get and store the patient's data
 . D VADEM^RORUTL05(PATIEN,1) S VA("BID")="0000"
 . S RORICN=$S($$PARAM^RORTSK01("PATIENTS","ICN"):$$ICN^RORUTL02(PATIEN),1:"")
 . S RORPACT=$S($$PARAM^RORTSK01("PATIENTS","PACT"):$$PACT^RORUTL02(PATIEN),1:"")
 . S RORPCP=$S($$PARAM^RORTSK01("PATIENTS","PCP"):$$PCP^RORUTL02(PATIEN),1:"")
 . S TMP=$$DATE^RORXU002(VADM(6)\1)
 . ;
 . ;--- Patient age/DOB
 . S AGETYPE=$$PARAM^RORTSK01("AGE_RANGE","TYPE") D
 . . S AGE=$S(AGETYPE="AGE":$P(VADM(4),U),AGETYPE="DOB":$$DATE^RORXU002($P(VADM(3),U)\1),1:"")
 . ;
 . ; IF Future Appointment only  Patch 33
 . I $$PARAM^RORTSK01("OPTIONS","FUT_APPT") D 
 . . S RORDAYS=$$PARAM^RORTSK01("OPTIONS","FUT_APPT")
 . . S RORFUT=$P($$FUTAPPT^RORUTL02(PATIEN,RORDAYS),U)
 . . S RORCLIN=$P($$FUTAPPT^RORUTL02(PATIEN,RORDAYS),U,2)
 . S ^TMP(RORRTN,$J,"PAT",PATIEN)=VA("BID")_U_VADM(1)_U_TMP_U_RORICN_U_RORPACT_U_RORPCP_U_AGE
 . I $$PARAM^RORTSK01("OPTIONS","FUT_APPT") D
 . . S $P(^TMP(RORRTN,$J,"PAT",PATIEN),U,8)=RORFUT
 . . S $P(^TMP(RORRTN,$J,"PAT",PATIEN),U,9)=RORCLIN
 . S NSPT=NSPT+1
 ;
 ;---
 Q $S(RC<0:RC,1:0)
 ;
POS(VAL) ; Returns 1 if lab test returns positive result (VAL)
 ;Positive results are results that are equal to "P" or contain "POS", "DETEC" or "REA"
 ;         -- AND -- do not contain "NEG", "NO" or "IND" or "UNDET" or "CANC" or "PEND"
 N POS,X
 S POS=0
 S X=VAL
 S VAL=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I VAL["UNDET" Q POS
 I VAL="P"!(VAL["POS")!(VAL["DETEC")!(VAL["REA") D
 . I '(VAL["NEG"!(VAL["NO")!(VAL["IND")) S POS=1
 Q POS
 ;
 ;***** STORES THE REPORT DATA
 ;
 ; REPORT        IEN of the REPORT element
 ; [.]NSPT       # of patients in registry
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
 ;
STORE(REPORT,NSPT,RORRTN) ;
 N CNT,DFN,DOD,ICN,ITEM,LAST4,NAME,NODE,PACT,PCP,PTCNT,PTLST,PTNAME,RC,VDATE,TMP,VAL,LTIMM,IMMLST,VACLST,VLST,AGETYPE,AGE,RORFUT,RORCLIN,RORDAYS
 S RC=0,PTLST=-1
 ;--- Force the "patient data" note in the output
 D ADDVAL^RORTSK11(RORTSK,"PATIENT",,REPORT)
 ;--- Create patient list
 S PTLST=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,REPORT)
 D ADDATTR^RORTSK11(RORTSK,PTLST,"TABLE","PATIENTS")
 ;---
 S (CNT,DFN,PTCNT)=0
 F  S DFN=$O(^TMP(RORRTN,$J,"PAT",DFN))  Q:DFN'>0  D  Q:RC<0
 . S TMP=$S(NSPT>0:CNT/NSPT,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S CNT=CNT+1,NODE=$NA(^TMP(RORRTN,$J,"PAT",DFN))
 . ;--- Patient's data
 . S TMP=$G(@NODE)
 . S LAST4=$P(TMP,U),PTNAME=$P(TMP,U,2),DOD=$P(TMP,U,3),ICN=$P(TMP,U,4),PACT=$P(TMP,U,5),PCP=$P(TMP,U,6),AGE=$P(TMP,U,7)
 . I $$PARAM^RORTSK01("OPTIONS","FUT_APPT") S RORFUT=$P(TMP,U,8),RORCLIN=$P(TMP,U,9)
 . ;--- Patient list
 . S TMP=$S('RORIMM:1,RORIMM<0:$G(@NODE@("IMM"))="",1:$G(@NODE@("IMM"))'="")
 . I TMP,$S('RORVAC:1,RORVAC<0:'$G(@NODE@("VAC")),1:$G(@NODE@("VAC"))) D
 . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,PTLST,,DFN)
 . . D ADDVAL^RORTSK11(RORTSK,"NAME",PTNAME,ITEM,1)
 . . D ADDVAL^RORTSK11(RORTSK,"LAST4",LAST4,ITEM,2)
 . . ;--- Age/DOB
 . . S AGETYPE=$$PARAM^RORTSK01("AGE_RANGE","TYPE") I AGETYPE'="ALL" D
 . . . D ADDVAL^RORTSK11(RORTSK,AGETYPE,AGE,ITEM,1)
 . . ;
 . . D ADDVAL^RORTSK11(RORTSK,"DOD",DOD,ITEM,1)
 . . S PTCNT=PTCNT+1
 . ;--- List of vaccines
 . S VACLST=-1
 . I $O(@NODE@("VAC",""))'="" S VACLST=$$ADDVAL^RORTSK11(RORTSK,"VACCINES",,ITEM) Q:VACLST<0
 . I RORVAC=1,VACLST'<0 S NAME="" F  S NAME=$O(@NODE@("VAC",NAME)) Q:NAME=""  D
 . . S VLST=$$ADDVAL^RORTSK11(RORTSK,"VACCINE",,VACLST)
 . . Q:VLST<0
 . . S VDATE=0
 . . F  S VDATE=$O(@NODE@("VAC",NAME,VDATE))  Q:'VDATE  D
 . . . D ADDVAL^RORTSK11(RORTSK,"VAC_NAME",NAME,VLST,1)
 . . . D ADDVAL^RORTSK11(RORTSK,"VAC_DATE",VDATE\1,VLST,1)
 . ;--- Immunity
 . I RORIMM=1,$G(@NODE@("IMM"))'="" D
 . . S IMMLST=$$ADDVAL^RORTSK11(RORTSK,"LABTESTS",,ITEM) Q:IMMLST<0
 . . S LTIMM=$G(@NODE@("IMM"))
 . . Q:LTIMM=""
 . . D ADDVAL^RORTSK11(RORTSK,"LTNAME",$P(LTIMM,U),IMMLST,1)
 . . D ADDVAL^RORTSK11(RORTSK,"DATE",$P(LTIMM,U,2)\1,IMMLST,1)
 . . S VAL=$P(LTIMM,U,3)
 . . S TMP=$S($$NUMERIC^RORUTL05(VAL):3,1:1)
 . . D ADDVAL^RORTSK11(RORTSK,"RESULT",VAL,IMMLST,TMP)
 . I $$PARAM^RORTSK01("PATIENTS","ICN") D ADDVAL^RORTSK11(RORTSK,"ICN",ICN,ITEM,1)
 . I $$PARAM^RORTSK01("PATIENTS","PACT") D ADDVAL^RORTSK11(RORTSK,"PACT",PACT,ITEM,1)
 . I $$PARAM^RORTSK01("PATIENTS","PCP") D ADDVAL^RORTSK11(RORTSK,"PCP",PCP,ITEM,1)
 . I $$PARAM^RORTSK01("OPTIONS","FUT_APPT") D
 . . D ADDVAL^RORTSK11(RORTSK,"FUT_APPT",RORFUT,ITEM,1)
 . . D ADDVAL^RORTSK11(RORTSK,"FUT_CLIN",RORCLIN,ITEM,1)
 ;--- Inactivate the patient list tag if the list is empty
 D:PTCNT'>0 UPDVAL^RORTSK11(RORTSK,PTLST,,,1)
 ;---
 Q 0
 ;
