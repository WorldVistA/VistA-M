RORXU010 ;HCOIFO/VC - REPORT MODIFICATON UTILITY ;4/16/09 2:54pm
 ;;1.5;CLINICAL CASE REGISTRIES;**8**;Feb 17, 2006;Build 8
 ;
 ;This routine will build a TMP file that includes the ICD9
 ;  codes for the stated patient.
 ;Format is ^TMP($J,"RORFLTR",PATIENT IEN,ICD9 CODE)=1
 ;The inputs will be
 ;   1)  PIEN - The patient's IEN in the registry file
 ;            Specifically ^RORDATA(798.4,PIEN)
 ;       and in the patient file ^DPT(PIEN
 ;   2)  REG - Identifier for which registry is used
 ;The return code will the response to the flag in 2) above
 ;Three types of patient codes must be looked at:
 ;   Inpatient, Outpatient, and the Problem List
 ;   
 ;This routine uses the following IAs:
 ;
 ;#92       ^DGPT(  (controlled)
 ;#928      ACTIVE^GMPLUTL (controlled)
 ;#1554     POV^PXAPIIB (controlled)
 ;#1905     SELECTED^VSIT (controlled)
 ;#2977     GETFLDS^GMPLEDT3 (controlled)
 ;#3545     ^DGPT("AAD" (private)
 ;#5388     ^ICD9(  (supported)
 ;
 Q
 ;
ICD(PIEN,REG) ;
 ;
 K ^TMP($J,"RORFLTR",PIEN)
 ;INPATIENT
 N PATIEN,DATE,REF,PR1,I,VSIEN,TMP,RORVPLST,VAL,RORPLST,GMPVAMC
 N GMPROV,IEN,IS,COUNT,DAT,ICD91,ICD92
 N PR0 ;added 'new' statement
 ;
 S PATIEN=PIEN
 S DATE=0,COUNT=0
 F  S DATE=$O(^DGPT("AAD",PATIEN,DATE)) Q:DATE=""  D
 .S REF=0
 .F  S REF=$O(^DGPT("AAD",PATIEN,DATE,REF)) Q:REF=""  D
 ..S ICD91=$G(^DGPT(REF,70))
 ..S ICD92=$G(^DGPT(REF,71))
 ..I ICD91'="" D
 ...F I=10 D
 .... S PR0=$P(ICD91,U,I)
 .... I PR0'="" D
 ..... S PR1=$P($G(^ICD9(PR0,0)),U,1)
 ..... I PR1'="" S ^TMP($J,"RORFLTR",PATIEN,PR1)=1
 ...F I=16:1:25 D
 .... S PR0=$P(ICD91,U,I)
 .... I PR0'="" D
 ..... S PR1=$P($G(^ICD9(PR0,0)),U,1)
 ..... I PR1'="" S ^TMP($J,"RORFLTR",PATIEN,PR1)=1
 ..I ICD92'="" D
 ...F I=1:1:4 D
 ....S PR0=$P(ICD92,U,I)
 ....I PR0'="" D
 .....S PR1=$P($G(^ICD9(PR0,0)),U,1)
 .....I PR1'="" S ^TMP($J,"RORFLTR",PATIEN,PR1)=1
 ;
 ;OUTPATIENT
 ;Get the visits for the patients
 ;Note: the start date and end date determine which visits are
 ;      returned.  If no day is entered, then all visits are returned.
 D SELECTED^VSIT(PATIEN)
 ;- Browse through the visits
 S VSIEN=0
 F  S VSIEN=$O(^TMP("VSIT",$J,VSIEN)) Q:VSIEN=""  D
 .S TMP=+$O(^TMP("VSIT",$J,VSIEN,"")) Q:TMP'>0
 .; - Get a list of V POV records
 .D POV^PXAPIIB(VSIEN,.RORVPLST)
 .;RORVPLST array holds ICD9 data
 .S REF=""
 .F  S REF=$O(RORVPLST(REF)) Q:REF=""  D
 ..S VAL=$P(RORVPLST(REF),U,1)
 ..S PR1=$P($G(^ICD9(VAL,0)),U,1)
 ..I PR1'="" S ^TMP($J,"RORFLTR",PATIEN,PR1)=1
 K ^TMP("VSIT",$J)
 ;
 ;This will look at the Problem Lists
 D ACTIVE^GMPLUTL(PATIEN,.RORPLST)
 S (GMPVAMC,GMPROV)=0
 S IS=0
 F  S IS=$O(RORPLST(IS)) Q:IS=""  D
 .S IEN=$G(RORPLST(IS,0))
 .Q:IEN'>0
 .K GMPFLD,GMPORIG
 .D GETFLDS^GMPLEDT3(IEN)
 .S PR1=$P($G(GMPFLD(.01)),U,2)
 .I PR1'="" S ^TMP($J,"RORFLTR",PATIEN,PR1)=1
 ;
COMPARE ;NOW DETERMINE IF THE PATIENT SHOULD BE RETAINED OR NOT.
 ;This compares the RORTSK local array with the ^TMP("RORFLTR"
 ;     global array
 N A,B,STOP,X,Y
 S A="PARAMS",B="ICD9FILT",RC=0
 S X="",STOP="GO"
 F  S X=$O(RORTSK(A,B,"G",X)) Q:X=""  Q:STOP="STOP"  D
 .S Y=""
 .F  S Y=$O(RORTSK(A,B,"G",X,"C",Y)) Q:Y=""  Q:STOP="STOP"  D
 ..S DAT=$G(RORTSK(A,B,"G",X,"C",Y))
 ..I $D(^TMP($J,"RORFLTR",PATIEN,DAT))>0 D
 ...S RC=1,STOP="STOP"
 K ^TMP($J,"RORFLTR",PATIEN)
 Q RC
