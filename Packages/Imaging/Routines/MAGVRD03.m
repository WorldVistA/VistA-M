MAGVRD03 ;WOIFO/DAC - Radiation Dosage - Attach Instance ; 25 April 2013 10:41 AM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
INPUTSEP() ; Name value separator for input data  ie. NAME`TESTPATIENT
 Q "`"
OUTSEP() ; Name value separator for output data ie. NAME|TESTPATIENT
 Q "|"
STATSEP() ; Status and Result separator ie. -3``No record IEN
 Q "`"
 ;
 ;***** Get irradiation dosage information
 ;
 ; RPC: MAGV GET IRRADIATION DOSE
 ;
 ; Input Variables:
 ;                 PATIENT   - Patient DFN
 ;                 PROC      - Accession Number
 ;                 PROCTYPE  - "CT" or "FLUORO" optional
 ; Output Variable:
 ;                 OUT       - Array of name value pairs separated by an input separator 
 ;
REFRESH(OUT,PATIENT,PROC,PROCTYPE) ; RPC [MAGV GET IRRADIATION DOSE]
 N OSEP,ISEP,SSEP,NAM,VAL,I,J,ATTNAMS,FILE,IIUIDIEN,DOSEIEN,PROCIEN,STUDIEN,SERIEN,TYPE
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP
 ; Quit with error if any input variable not defined
 I $G(PATIENT)="" S OUT(1)="-10"_SSEP_"Patient not defined" Q
 I $G(PROC)="" S OUT(1)="-11"_SSEP_"Procedure not defined" Q
 ; Site Specific Accession Number look up
 S PROCXREF=$$SSAN(PROC)
 I PROCXREF="" S OUT(1)="-13"_SSEP_"Procedure not found" Q
 S I=2,IEN="",J=0
 S PROCIEN=$O(^MAGV(2005.61,"B",PROCXREF,""))
 S STUDIEN=""
 F  S STUDIEN=$O(^MAGV(2005.62,"C",PROCIEN,STUDIEN)) Q:STUDIEN=""  D
 . S SERIEN=""
 . F  S SERIEN=$O(^MAGV(2005.63,"C",STUDIEN,SERIEN)) Q:SERIEN=""  D
 . . F TYPE="CT","FLUORO" D
 . . . I TYPE="CT",$G(PROCTYPE)'="FLUORO" S FILE=2005.632
 . . . I TYPE="FLUORO",$G(PROCTYPE)'="CT" S FILE=2005.633
 . . . Q:$G(FILE)=""
 . . . S DOSEIEN=""
 . . . F  S DOSEIEN=$O(^MAGV(FILE,"C",SERIEN,DOSEIEN)) Q:DOSEIEN=""  D
 . . . . D REFRESH2(.OUT,.I,.J,TYPE,DOSEIEN,FILE)
 . . . . Q
 . . . S FILE=""
 . . . Q
 . . Q
 . Q
 S OUT(1)="0"_SSEP_SSEP_J ; Look up successful
 Q
 ;
 ; ***** Get irradiation dosage information for an irradiation instance
 ;  
 ; Input variables:
 ;                I       - Output array element number
 ;                J       - Number of records returned
 ;                DOSEIEN - IEN of dosage instance
 ;                FILE    - File number to extract dosage information from (2005.632 or 2005.633) 
 ; Output variable:
 ;                OUT       - Array of name value pairs separated by an input separator  
 ;                 
REFRESH2(OUT,I,J,TYPE,DOSEIEN,FILE) ; Retrieve data from dosage instance
 N FNUM,FORMAT,VALUE,TRANIEN,FIELD,IEN,DD
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP
 S FNUM=.01,J=J+1
 S OUT(I)="TYPE"_OSEP_TYPE,I=I+1
 ; Get dosage instance data
 D GETS^DIQ(FILE,DOSEIEN_",","**","I","DD")
 F  D  Q:FNUM=""
 . S FNUM=$O(DD(FILE,DOSEIEN_",",FNUM)) Q:FNUM=""
 . S FIELD=$$GET1^DID(FILE,FNUM,,"LABEL")
 . Q:FIELD="SERIES INSTANCE"  ; Don't return Series Instance field
 . S FORMAT="E"
 . S VALUE=$$GET1^DIQ(FILE,DOSEIEN,FIELD,$G(FORMAT))
 . I FIELD="TARGET REGION",VALUE'="" D
 . . S IEN=$$GET1^DIQ(FILE,DOSEIEN,FIELD,"I")
 . . I '$D(^MAGV(2005.63611,"B",IEN)) Q
 . . S TRANIEN=$O(^MAGV(2005.63611,"B",IEN,""))
 . . I $G(TRANIEN)'="" S VALUE=$P($G(^MAGV(2005.63611,TRANIEN,0)),U,2)
 . . Q
 . I FIELD="PHANTOM TYPE",VALUE'="" D
 . . S IEN=$$GET1^DIQ(FILE,DOSEIEN,FIELD,"I")
 . . I '$D(^MAGV(2005.63621,"B",VALUE)) Q
 . . S TRANIEN=$O(^MAGV(2005.63621,"B",IEN,""))
 . . I $G(TRANIEN)'="" S VALUE=$P($G(^MAGV(2005.63621,TRANIEN,0)),U,2)
 . . Q
 . S OUT(I)=FIELD_OSEP_VALUE
 . S I=I+1
 . Q
 Q
 ;
 ; ***** Compare accession number for site specific and non-site specific accession numbers
 ; 
 ;  Input Variable: 
 ;                 PROC - Accession number in either site specific or non site specific form
 ;  
 ;  Output: 
 ;                 Returns accession number stored in PROCEDURE REFRENCE (#2005.61) file
 ; 
SSAN(PROC) ; Site specific accession number function
 N PROCXREF
 ; Scenario 1 - match
 S PROCXREF=""
 I $D(^MAGV(2005.61,"B",PROC)) Q PROC
 ; Scenario 2 - long (in) / short (DB x-ref)
 S PROCXREF=""
 I $L(PROC,"-")=3 S PROCXREF=$P(PROC,"-",2)_"-"_$P(PROC,"-",3) Q:$D(^MAGV(2005.61,"B",PROCXREF)) PROCXREF
 ; Scenario 3 - short (in) / long (DB x-ref)
 S PROCXREF=""
 I $L(PROC,"-")=2 D
 . F  S PROCXREF=$O(^MAGV(2005.61,"B",PROCXREF)) D  Q:(PROCXREF[PROC)!(PROCXREF="")
 . Q
 Q PROCXREF
