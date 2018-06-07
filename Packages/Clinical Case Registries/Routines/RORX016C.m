RORX016C ;HCIOFO/BH,SG - OUTPATIENT UTILIZATION (STORE) ;9/14/05 9:43am
 ;;1.5;CLINICAL CASE REGISTRIES;**21,31**;Feb 17, 2006;Build 62
 ;
 Q
 ;
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*21   SEP 2013    T KOPP       Added ICN as last report column if
 ;                                      additional identifier option selected
 ;ROR*1.5*31   MAY 2017  M FERRARESE    Adding PACT, PCP, and AGE/DOB as additional
 ;                                      identifiers.
 ;******************************************************************************
 ;
 ;***** HIGHEST UTILIZATION
 ;
 ; PRNTELMT      IEN of the parent element
 ;
 ; RORNODE       Closed root of the section in the temporary global
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
HIGHUTIL(PRNTELMT,RORNODE) ;
 N BUF,COUNT,DFN,I,ITEM,NAME,NUM,RC,RORMAXUT,RORTCNT,SECTION,TABLE,TMP,AGETYPE
 S RORMAXUT=$$PARAM^RORTSK01("MAXUTNUM")
 Q:RORMAXUT'>0 0
 S SECTION=$$ADDVAL^RORTSK11(RORTSK,"HIGHUTIL",,PRNTELMT)
 Q:SECTION<0 SECTION
 S (RC,RORTCNT)=0
 S AGETYPE=$$PARAM^RORTSK01("AGE_RANGE","TYPE")
 ;--- Stops
 I $D(@RORNODE@("OPS1"))>1  D  Q:RC<0 RC
 . S TABLE=$$ADDVAL^RORTSK11(RORTSK,"HU_STOPS",,SECTION)
 . I TABLE<0  S RC=TABLE  Q
 . D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","HU_STOPS")
 . S RORTCNT=RORTCNT+1
 . ;---
 . S NUM="",(COUNT,RC)=0
 . F  S NUM=$O(@RORNODE@("OPS1",NUM),-1)  Q:NUM=""  D  Q:RC
 . . S NAME=""
 . . F  S NAME=$O(@RORNODE@("OPS1",NUM,NAME))  Q:NAME=""  D  Q:RC
 . . . S DFN=""
 . . . F  S DFN=$O(@RORNODE@("OPS1",NUM,NAME,DFN))  Q:DFN=""  D  Q:RC
 . . . . S COUNT=COUNT+1  I COUNT>RORMAXUT  S RC=1  Q
 . . . . S BUF=$G(@RORNODE@("OP",DFN))
 . . . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,TABLE)
 . . . . D ADDVAL^RORTSK11(RORTSK,"NAME",NAME,ITEM,1)
 . . . . D ADDVAL^RORTSK11(RORTSK,"LAST4",$P(BUF,U,3),ITEM,2)
 . . . . I AGETYPE'="ALL" D ADDVAL^RORTSK11(RORTSK,AGETYPE,$P(BUF,U,8),ITEM,1)
 . . . . D ADDVAL^RORTSK11(RORTSK,"NV",+$P(BUF,U,4),ITEM,3)
 . . . . D ADDVAL^RORTSK11(RORTSK,"NSC",NUM,ITEM,3)
 . . . . D ADDVAL^RORTSK11(RORTSK,"NDS",+$P(BUF,U,2),ITEM,3)
 . . . . I $$PARAM^RORTSK01("PATIENTS","ICN") D
 . . . . . D ADDVAL^RORTSK11(RORTSK,"ICN",$P(BUF,U,5),ITEM,1)
 . . . . I $$PARAM^RORTSK01("PATIENTS","PACT") D
 . . . . . D ADDVAL^RORTSK11(RORTSK,"PACT",$P(BUF,U,6),ITEM,1)
 . . . . I $$PARAM^RORTSK01("PATIENTS","PCP") D
 . . . . . D ADDVAL^RORTSK11(RORTSK,"PCP",$P(BUF,U,7),ITEM,1)
 ;--- Disable the empty section
 D:RORTCNT'>0 UPDVAL^RORTSK11(RORTSK,SECTION,"",,1)
 Q 0
 ;
 ;***** STORES THE REPORT DATA
 ;
 ; REPORT        IEN of the REPORT element
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
STORE(REPORT) ;
 N RORSONLY      ; Output summary only
 ;
 N ECNT,NODE,RC,TMP
 S NODE=$NA(^TMP("RORX016",$J))
 Q:$D(@NODE)<10 0
 S RORSONLY=$$SMRYONLY^RORXU006(),(ECNT,RC)=0
 ;--- Outpatients
 S RC=$$LOOP^RORTSK01(0)    Q:RC<0 RC
 S RC=$$STOREOP(REPORT,NODE)
 I RC  Q:RC<0 RC  S ECNT=ECNT+1
 ;--- Highest utilization
 S RC=$$LOOP^RORTSK01(0.5)  Q:RC<0 RC
 S RC=$$HIGHUTIL(REPORT,NODE)
 I RC  Q:RC<0 RC  S ECNT=ECNT+1
 ;---
 Q ECNT
 ;
 ;***** OUTPATIENT DATA
 ;
 ; PRNTELMT      IEN of the parent element
 ;
 ; NODE          Closed root of the category section
 ;               in the temporary global
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
STOREOP(PRNTELMT,NODE) ;
 Q:$D(@NODE@("OP"))<10 0
 N ITEM,NSC,NV,RC,SECTION,STOP,TABLE,TMP
 S SECTION=$$ADDVAL^RORTSK11(RORTSK,"OUTPATIENTS",,PRNTELMT)
 Q:SECTION<0 SECTION
 S RC=0
 ;--- Stop codes
 I $D(@NODE@("OPS1"))>1  D  Q:RC<0 RC
 . S TABLE=$$ADDVAL^RORTSK11(RORTSK,"STOPS",,SECTION)
 . I TABLE<0  S RC=TABLE  Q
 . D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","STOPS")
 . S NSC=""
 . F  S NSC=$O(@NODE@("OPS1",NSC),-1)  Q:NSC=""  D
 . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"ITEM",,TABLE)
 . . D ADDVAL^RORTSK11(RORTSK,"NP",$P(@NODE@("OPS1",NSC),U),ITEM,3)
 . . D ADDVAL^RORTSK11(RORTSK,"NSC",NSC,ITEM,3)
 ;--- Clinics
 I $D(@NODE@("OPS"))>1  D  Q:RC<0 RC
 . S TABLE=$$ADDVAL^RORTSK11(RORTSK,"CLINICS",,SECTION)
 . I TABLE<0  S RC=TABLE  Q
 . D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","CLINICS")
 . S STOP=""
 . F  S STOP=$O(@NODE@("OPS",STOP))  Q:STOP=""  D
 . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"CLINIC",,TABLE)
 . . D ADDVAL^RORTSK11(RORTSK,"STOP",STOP,ITEM,3)
 . . D ADDVAL^RORTSK11(RORTSK,"NAME",$P(@NODE@("OPS",STOP),U),ITEM,1)
 . . D ADDVAL^RORTSK11(RORTSK,"NP",+$G(@NODE@("OPS",STOP,"P")),ITEM,3)
 . . S TMP=+$G(@NODE@("OPS",STOP,"V"))
 . . D ADDVAL^RORTSK11(RORTSK,"NV",$J(TMP,0,2),ITEM,3)
 . . D ADDVAL^RORTSK11(RORTSK,"NSC",+$G(@NODE@("OPS",STOP,"S")),ITEM,3)
 ;--- Summary
 D ADDVAL^RORTSK11(RORTSK,"NP",+$G(@NODE@("OP")),SECTION)
 D ADDVAL^RORTSK11(RORTSK,"NV",+$G(@NODE@("OPV")),SECTION)
 D ADDVAL^RORTSK11(RORTSK,"NSC",+$G(@NODE@("OPS")),SECTION)
 Q 0
