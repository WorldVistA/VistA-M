RORX013C ;HCIOFO/SG - DIAGNOSIS CODES (STORE) ;10/27/05 11:11am
 ;;1.5;CLINICAL CASE REGISTRIES;**19,21,31**;Feb 17, 2006;Build 62
 ;
 ; This routine uses the following IAs:
 ;
 ; #5747         $$ICDDX^ICDEX, $$CSI^ICDEX (controlled)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ; --- ROUTINE MODIFICATION LOG ---
 ; 
 ;PKG/PATCH   DATE       DEVELOPER   MODIFICATION
 ;----------- ---------- ----------- ----------------------------------------
 ;ROR*1.5*19  FEB 2012   J SCOTT     Support for ICD-10 Coding System.
 ;ROR*1.5*21  SEP 2013   T KOPP      Add ICN column if Additional Identifier
 ;                                    requested.
 ;ROR*1.5*31   MAY 2017  M FERRARESE  Adding PACT ,PCP,and AGE/DOB as additional
 ;                                    identifiers.
 ;******************************************************************************
 ;******************************************************************************
 ;
 Q
 ;
 ;***** STORES THE ICD CODE TABLE
 ;
 ; PTAG          IEN of the parent element
 ;
 ; NODE          Closed root of the node of the temporary global
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
CODES(PTAG,NODE) ;
 N ICDIEN,ITEM,TABLE,TMP,RORICDSYS,RORICDCODE
 S TABLE=$$ADDVAL^RORTSK11(RORTSK,"ICDLST",,PTAG)
 Q:TABLE<0 TABLE
 D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","ICDLST")
 S ICDIEN=0
 F  S ICDIEN=$O(@NODE@("ICD",ICDIEN))  Q:ICDIEN'>0  D
 . S RORICDSYS=+$$CSI^ICDEX(80,ICDIEN)
 . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"ICD",,TABLE)
 . S TMP=@NODE@("ICD",ICDIEN)
 . S RORICDCODE="("_$S(RORICDSYS=1:"ICD-9",RORICDSYS=30:"ICD-10",1:"UNKN")_") "_$P(TMP,U,1)
 . D ADDVAL^RORTSK11(RORTSK,"CODE",RORICDCODE,ITEM,2)
 . D ADDVAL^RORTSK11(RORTSK,"DIAG",$P(TMP,U,2),ITEM,2)
 . S TMP=$G(@NODE@("ICD",ICDIEN,"P"))
 . D ADDVAL^RORTSK11(RORTSK,"NP",TMP,ITEM,3)
 . S TMP=$G(@NODE@("ICD",ICDIEN,"C"))
 . D ADDVAL^RORTSK11(RORTSK,"NC",TMP,ITEM,3)
 Q 0
 ;
 ;***** STORES THE PATIENT TABLE
 ;
 ; PTAG          IEN of the parent element
 ;
 ; NODE          Closed root of the node of the temporary global
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
PATIENTS(PTAG,NODE) ;
 N DATE,ICD,ICDIEN,ITEM,PATIEN,PTICDL,SOURCE,TABLE,TMP,RORICDSYS,RORICDCODE,AGETYPE
 S TABLE=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,PTAG)
 Q:TABLE<0 TABLE
 D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","PATIENTS")
 S PATIEN=0
 S AGETYPE=$$PARAM^RORTSK01("AGE_RANGE","TYPE")
 F  S PATIEN=$O(@NODE@("PAT",PATIEN))  Q:PATIEN'>0  D
 . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,TABLE)
 . S TMP=@NODE@("PAT",PATIEN)
 . D ADDVAL^RORTSK11(RORTSK,"NAME",$P(TMP,U,2),ITEM,2)
 . D ADDVAL^RORTSK11(RORTSK,"LAST4",$P(TMP,U,1),ITEM,2)
 . I AGETYPE'="ALL" D ADDVAL^RORTSK11(RORTSK,AGETYPE,$P(TMP,U,7),ITEM,1)
 . D ADDVAL^RORTSK11(RORTSK,"DOD",$P(TMP,U,3),ITEM,1)
 . I $$PARAM^RORTSK01("PATIENTS","ICN") D ADDVAL^RORTSK11(RORTSK,"ICN",$P(TMP,U,4),ITEM,1)
 . I $$PARAM^RORTSK01("PATIENTS","PACT") D ADDVAL^RORTSK11(RORTSK,"PACT",$P(TMP,U,5),ITEM,1)
 . I $$PARAM^RORTSK01("PATIENTS","PCP") D ADDVAL^RORTSK11(RORTSK,"PCP",$P(TMP,U,6),ITEM,1)
 . S PTICDL=$$ADDVAL^RORTSK11(RORTSK,"PTICDL",,ITEM)
 . S ICDIEN=0
 . F  S ICDIEN=$O(@NODE@("PAT",PATIEN,ICDIEN))  Q:ICDIEN'>0  D
 . . S RORICDSYS=+$$CSI^ICDEX(80,ICDIEN)
 . . S ICD=$$ADDVAL^RORTSK11(RORTSK,"ICD",,PTICDL)
 . . S TMP=$G(@NODE@("PAT",PATIEN,ICDIEN))
 . . S DATE=$P(TMP,U),SOURCE=$P(TMP,U,2)
 . . S TMP=$$ICDDX^ICDEX(ICDIEN,DATE,,"I")
 . . S:TMP<0 TMP=""
 . . S RORICDCODE="("_$S(RORICDSYS=1:"ICD-9",RORICDSYS=30:"ICD-10",1:"UNKN")_") "_$P(TMP,U,2)
 . . D ADDVAL^RORTSK11(RORTSK,"CODE",RORICDCODE,ICD,2)
 . . D ADDVAL^RORTSK11(RORTSK,"DIAG",$P(TMP,U,4),ICD,2)
 . . D ADDVAL^RORTSK11(RORTSK,"DATE",DATE\1,ICD,1)
 . . D ADDVAL^RORTSK11(RORTSK,"SOURCE",SOURCE,ICD,2)
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
 N ECNT,ICDIEN,PATIEN,RC,SECTION,TMP
 S (ECNT,RC)=0
 ;--- Diagnosis codes
 S RC=$$CODES(REPORT,RORTMP)
 I RC  Q:RC<0 RC  S ECNT=ECNT+RC
 S RC=$$LOOP^RORTSK01(.4)  Q:RC<0 RC
 ;--- Patients
 S TMP=$$PARAM^RORTSK01("OPTIONS","COMPLETE")
 I TMP  D  I RC  Q:RC<0 RC  S ECNT=ECNT+RC
 . S RC=$$PATIENTS(REPORT,RORTMP)
 S RC=$$LOOP^RORTSK01(.99)  Q:RC<0 RC
 ;--- Totals
 S SECTION=$$ADDVAL^RORTSK11(RORTSK,"SUMMARY",,REPORT)
 Q:SECTION<0 SECTION
 S TMP=$G(@RORTMP@("ICD"))
 D ADDVAL^RORTSK11(RORTSK,"NC",+$P(TMP,U,1),SECTION)
 D ADDVAL^RORTSK11(RORTSK,"NDC",+$P(TMP,U,2),SECTION)
 S TMP=$G(@RORTMP@("PAT"))
 D ADDVAL^RORTSK11(RORTSK,"NP",+TMP,SECTION)
 ;---
 Q ECNT
