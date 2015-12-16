RORXU010 ;HCOIFO/VC - REPORT MODIFICATON UTILITY ;4/16/09 2:54pm
 ;;1.5;CLINICAL CASE REGISTRIES;**8,19,25**;Feb 17, 2006;Build 19
 ;
 ;Routine builds the ^TMP($J,"RORFLTR" global array that includes
 ;ICD information from inpatient, outpatient and problem
 ;list data for the identified patient.
 ;
 ;The ICD information that is stored in the ^TMP($J,"RORFLTR"
 ;global array is then compared to ICD information stored in 
 ;the RORTSK local array which is established by the calling
 ;report routine.
 ;
 ;This routine returns a status flag indicating whether the
 ;patient should being included on the calling report.
 ;
 ;Format is:
 ;   ^TMP($J,"RORFLTR",PATIENT IEN,ICD FILE #,ICD IEN)=1
 ;
 ;The inputs are:
 ;   1)  PIEN - Patient's IEN in the registry file (required).
 ;              Specifically ^RORDATA(798.4,PIEN) and in the 
 ;              patient file ^DPT(PIEN).
 ;
 ;The return code is:
 ;       RC   - Flag indicating if patient should be retained.
 ;              1 - Patient should be retained for report.
 ;              0 - Patient should NOT be retained for report.
 ;
 ;ICD information is obtained from 3 different packages:
 ;   Registration package for patient inpatient diagnosis.
 ;   Patient Care Encounter package for patient outpatient diagnosis.
 ;   Problem List package for patient problem list diagnosis.
 ;   
 ;This routine uses the following IAs:
 ;
 ;#92       ^DGPT(  (controlled)
 ;#928      ACTIVE^GMPLUTL (controlled)
 ;#1554     POV^PXAPIIB (controlled)
 ;#1905     SELECTED^VSIT (controlled)
 ;#2977     GETFLDS^GMPLEDT3 (controlled)
 ;#3545     ^DGPT("AAD" (private)
 ;#6130     PTFICD^DGPTFUT
 ;
 ;******************************************************************************
 ;******************************************************************************
 ; --- ROUTINE MODIFICATION LOG ---
 ; 
 ;PKG/PATCH   DATE       DEVELOPER   MODIFICATION
 ;----------- ---------- ----------- ----------------------------------------
 ;ROR*1.5*8   MAR 2010   V CARR      Modified to handle ICD9 filter for
 ;                                   'include' or 'exclude'.
 ;ROR*1.5*13  DEC 2010   A SAUNDERS  User can select specific patients, 
 ;                                   clinics, or divisions for the report.
 ;ROR*1.5*19  FEB 2012   J SCOTT     Support for ICD-10 Coding System.
 ;ROR*1.5*19  FEB 2012   J SCOTT     Removed direct read of ^ICD9( global.
 ;ROR*1.5*19  FEB 2012   J SCOTT     Changed the screening of ICD codes from
 ;                                   external to internal values.
 ;ROR*1.5*19  FEB 2012   J SCOTT     Removed obsolete REG parameter from
 ;                                   ICD entry point.
 ;ROR*1.5*25  OCT 2014   T KOPP      Added PTF ICD-10 support for 25 diagnoses
 ; 
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
ICD(PIEN) ;Determine if patient is retained for report based on ICD information.
 ;
 K ^TMP($J,"RORFLTR",PIEN)
 N PATIEN,RORICDIEN
 S PATIEN=PIEN
 ;
 ;Gather INPATIENT ICD information from Registration package file #45 (PTF).
 N DATE,DGPTREF,ICD1,ICD2,FLDLOC,RORIBUF,FLD
 ;
 ;Browse through each inpatient date.
 S DATE=0
 F  S DATE=$O(^DGPT("AAD",PATIEN,DATE)) Q:DATE=""  D
 .;Browse through each PTF (#45) entry for an inpatient date.
 .S DGPTREF=0
 .F  S DGPTREF=$O(^DGPT("AAD",PATIEN,DATE,DGPTREF)) Q:DGPTREF=""  D
 ..;Extract ICD diagnosis codes.
 ..D PTFICD^DGPTFUT(701,DGPTREF,"",.RORIBUF)
 ..S FLD="" F  S FLD=$O(RORIBUF(FLD)) Q:FLD=""  I $G(RORIBUF(FLD)) D
 ... S ^TMP($J,"RORFLTR",PATIEN,80,+RORIBUF(FLD))=1
 ;
 ;Gather OUTPATIENT ICD information from Patient Care Encounter package.
 N VSIEN,TMP,RORVPLST,VPOVREF
 ;
 ;Get a list of all VISIT (#9000010) entries for the patient.
 D SELECTED^VSIT(PATIEN)
 ;Browse through each returned VISIT entry.
 S VSIEN=0
 F  S VSIEN=$O(^TMP("VSIT",$J,VSIEN)) Q:VSIEN=""  D
 .S TMP=+$O(^TMP("VSIT",$J,VSIEN,"")) Q:TMP'>0
 .;Get V POV (#9000010.07) entries for a specific VISIT entry.
 .D POV^PXAPIIB(VSIEN,.RORVPLST)
 .;Browse through each returned V POV entry.
 .S VPOVREF=""
 .F  S VPOVREF=$O(RORVPLST(VPOVREF)) Q:VPOVREF=""  D
 ..;Extract ICD diagnosis code.
 ..S RORICDIEN=$P(RORVPLST(VPOVREF),U,1)
 ..I RORICDIEN'="" S ^TMP($J,"RORFLTR",PATIEN,80,RORICDIEN)=1
 K ^TMP("VSIT",$J)
 ;
 ;Gather PROBLEM LIST ICD information from Problem List package.
 N RORPLST,PLSTREF,GMPVAMC,GMPROV,PROBNUM
 ;
 ;Get a list of all PROBLEM (#9000011) entries for the patient.
 D ACTIVE^GMPLUTL(PATIEN,.RORPLST)
 S (GMPVAMC,GMPROV)=0
 ;Browse through each returned PROBLEM entry.
 S PROBNUM=0
 F  S PROBNUM=$O(RORPLST(PROBNUM)) Q:PROBNUM=""  D
 .S PLSTREF=$G(RORPLST(PROBNUM,0))
 .Q:PLSTREF'>0
 .;Extract ICD diagnosis code.
 .K GMPFLD,GMPORIG
 .D GETFLDS^GMPLEDT3(PLSTREF)
 .S RORICDIEN=$P($G(GMPFLD(.01)),U,1)
 .I RORICDIEN'="" S ^TMP($J,"RORFLTR",PATIEN,80,RORICDIEN)=1
 .K GMPFLD,GMPORIG
 ;
COMPARE ;Determine if patient should be retained or not.
 ;
 ;Compare ICD data gathered for patient in ^TMP($J,"RORFLTR"
 ;with ICD data in RORTSK local array that was established from
 ;the calling routine.
 ;
 N A,B,STOP,X,Y,RC
 S A="PARAMS",B="ICDFILT",RC=0
 S X="",STOP="GO"
 F  S X=$O(RORTSK(A,B,"G",X)) Q:X=""  Q:STOP="STOP"  D
 .S Y=""
 .F  S Y=$O(RORTSK(A,B,"G",X,"C",Y)) Q:Y=""  Q:STOP="STOP"  D
 ..I $D(^TMP($J,"RORFLTR",PATIEN,80,Y))>0 D
 ...S RC=1,STOP="STOP"
 K ^TMP($J,"RORFLTR",PATIEN)
 Q RC
