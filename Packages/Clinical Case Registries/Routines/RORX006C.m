RORX006C ;HCIOFO/BH,SG - LAB UTILIZATION (STORE) ;9/19/05 9:39am
 ;;1.5;CLINICAL CASE REGISTRIES;**21,31**;Feb 17, 2006;Build 62
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*21   SEP 2013    T KOPP       Add ICN column if Additional Identifier
 ;                                       requested.
 ;ROR*1.5*31   MAY 2017    M FERRARESE  Adding PACT, PCP, AGE/DOB as additional
 ;                                       identifiers.
 ;******************************************************************************
 Q
 ;
 ;***** PATIENTS WITH HIGHEST UTILIZATION
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
PATIENTS(PRNTELMT,NODE) ;
 Q:$D(@NODE@("PAT"))<10 0
 N COUNT,DFN,ITEM,MAXUTNUM,NAME,NUM,RC,TMP,AGETYPE
 S MAXUTNUM=$$PARAM^RORTSK01("MAXUTNUM")
 Q:MAXUTNUM'>0 0
 S TABLE=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,PRNTELMT)
 Q:TABLE<0 TABLE
 D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","PATIENTS")
 ;---
 S NUM="",(COUNT,RC)=0
 S AGETYPE=$$PARAM^RORTSK01("AGE_RANGE","TYPE")
 F  S NUM=$O(@NODE@("RES1",NUM),-1)  Q:NUM=""  D  Q:RC
 . S NAME=""
 . F  S NAME=$O(@NODE@("RES1",NUM,NAME))  Q:NAME=""  D  Q:RC
 . . S DFN=""
 . . F  S DFN=$O(@NODE@("RES1",NUM,NAME,DFN))  Q:DFN=""  D  Q:RC
 . . . S COUNT=COUNT+1  I COUNT>MAXUTNUM  S RC=1  Q
 . . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,TABLE)
 . . . D ADDVAL^RORTSK11(RORTSK,"NAME",NAME,ITEM,1)
 . . . S TMP=$G(@NODE@("PAT",DFN))
 . . . D ADDVAL^RORTSK11(RORTSK,"LAST4",$P(TMP,U),ITEM,2)
 . . . I AGETYPE'="ALL" D ADDVAL^RORTSK11(RORTSK,AGETYPE,$P(TMP,U,6),ITEM,1)
 . . . D ADDVAL^RORTSK11(RORTSK,"DOD",$P(TMP,U,2),ITEM,1)
 . . . S TMP=+$G(@NODE@("PAT",DFN,"O"))
 . . . D ADDVAL^RORTSK11(RORTSK,"NO",TMP,ITEM,3)
 . . . D ADDVAL^RORTSK11(RORTSK,"NR",NUM,ITEM,3)
 . . . S TMP=+$P($G(@NODE@("PAT",DFN,"R")),U,2)
 . . . D ADDVAL^RORTSK11(RORTSK,"NDT",TMP,ITEM,3)
 . . . S TMP=$G(@NODE@("PAT",DFN))
 . . . I $$PARAM^RORTSK01("PATIENTS","ICN") D
 . . . . D ADDVAL^RORTSK11(RORTSK,"ICN",$P(TMP,U,3),ITEM,1)
 . . . I $$PARAM^RORTSK01("PATIENTS","PACT") D
 . . . . D ADDVAL^RORTSK11(RORTSK,"PACT",$P(TMP,U,4),ITEM,1)
 . . . I $$PARAM^RORTSK01("PATIENTS","PCP") D
 . . . . D ADDVAL^RORTSK11(RORTSK,"PCP",$P(TMP,U,5),ITEM,1)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** NUMBERS OF PATIENTS AND RESULTS
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
RESULTS(PRNTELMT,NODE) ;
 Q:$D(@NODE@("RES1"))<10 0
 N ITEM,NUM,RC,TABLE
 S TABLE=$$ADDVAL^RORTSK11(RORTSK,"RESULTS",,PRNTELMT)
 Q:TABLE<0 TABLE
 D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","RESULTS")
 S NUM="",RC=0
 F  S NUM=$O(@NODE@("RES1",NUM),-1)  Q:NUM=""  D  Q:RC
 . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"ITEM",,TABLE)
 . S TMP=+$G(@NODE@("RES1",NUM))
 . D ADDVAL^RORTSK11(RORTSK,"NP",TMP,ITEM,3)
 . D ADDVAL^RORTSK11(RORTSK,"NR",NUM,ITEM,3)
 Q $S(RC<0:RC,1:0)
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
 N ECNT,NODE,RC,RORI,SUBLST,TMP
 S RORSONLY=$$SMRYONLY^RORXU006()
 S (ECNT,RC)=0
 ;---
 S NODE=$NA(^TMP("RORX006",$J))
 Q:$D(@NODE)<10 0
 ;--- Tables
 S RC=$$LOOP^RORTSK01(0)  Q:RC<0 RC
 S RC=$$RESULTS(REPORT,NODE)
 I RC  Q:RC<0 RC  S ECNT=ECNT+RC
 ;---
 S RC=$$LOOP^RORTSK01(1/3)  Q:RC<0 RC
 S RC=$$TESTS(REPORT,NODE)
 I RC  Q:RC<0 RC  S ECNT=ECNT+RC
 ;---
 S RC=$$LOOP^RORTSK01(2/3)  Q:RC<0 RC
 S RC=$$PATIENTS(REPORT,NODE)
 I RC  Q:RC<0 RC  S ECNT=ECNT+RC
 ;--- Summary
 D ADDVAL^RORTSK11(RORTSK,"NO",+$G(@NODE@("ORD")),REPORT)
 S TMP=$G(@NODE@("RES"))
 D ADDVAL^RORTSK11(RORTSK,"NR",+$P(TMP,U),REPORT)
 D ADDVAL^RORTSK11(RORTSK,"NDT",+$P(TMP,U,2),REPORT)
 D ADDVAL^RORTSK11(RORTSK,"NP",+$G(@NODE@("PAT")),REPORT)
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** LAB TESTS
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
TESTS(PRNTELMT,NODE) ;
 Q:$D(@NODE@("RES"))<10 0
 N IEN,ITEM,MINRPNUM,NAME,NUM,RC,TMP
 S MINRPNUM=$$PARAM^RORTSK01("MINRPNUM")
 Q:MINRPNUM'>0 0
 S TABLE=$$ADDVAL^RORTSK11(RORTSK,"LABTESTS",,PRNTELMT)
 Q:TABLE<0 TABLE
 D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","LABTESTS")
 ;---
 S NUM="",RC=0
 F  S NUM=$O(@NODE@("RES","B",NUM),-1)  Q:NUM<MINRPNUM  D  Q:RC
 . S NAME=""
 . F  S NAME=$O(@NODE@("RES","B",NUM,NAME))  Q:NAME=""  D  Q:RC
 . . S IEN=""
 . . F  S IEN=$O(@NODE@("RES","B",NUM,NAME,IEN))  Q:IEN=""  D  Q:RC
 . . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"LT",,TABLE)
 . . . D ADDVAL^RORTSK11(RORTSK,"NAME",NAME,ITEM,1)
 . . . S TMP=+$G(@NODE@("RES",IEN,"P"))
 . . . D ADDVAL^RORTSK11(RORTSK,"NP",TMP,ITEM,3)
 . . . D ADDVAL^RORTSK11(RORTSK,"NR",NUM,ITEM,3)
 . . . S TMP=$G(@NODE@("RES",IEN,"M"))
 . . . D ADDVAL^RORTSK11(RORTSK,"MAXNRPP",+$P(TMP,U),ITEM,3)
 . . . D ADDVAL^RORTSK11(RORTSK,"MAXNP",+$P(TMP,U,2),ITEM,3)
 Q $S(RC<0:RC,1:0)
