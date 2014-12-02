MAGDHOW5 ;WOIFO/PMK - Capture Consult/GMRC data ; 12 Mar 2013 7:09 PM
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
 ;
 ;
ZDS(HLMSTATE,GMRCIEN) ; build the ZDS segment
 N STUDYUID,SUCCESS,ZDSSEG
 S STUDYUID=^MAGD(2006.15,1,"UID ROOT")_".1.4."_$$STATNUMB^MAGDFCNV()_".1."_GMRCIEN
 D SET^HLOAPI(.ZDSSEG,"ZDS",0)
 D SET^HLOAPI(.ZDSSEG,STUDYUID,1,1)
 D SET^HLOAPI(.ZDSSEG,"VISTA",1,2)
 D SET^HLOAPI(.ZDSSEG,"Application",1,3)
 D SET^HLOAPI(.ZDSSEG,"DICOM",1,4)
 S SUCCESS=$$ADDSEG^HLOAPI(.HLMSTATE,.ZDSSEG,.ERROR)
 I 'SUCCESS D
 . N MSG,SUBJECT,VARIABLES
 . S SUBJECT="VistA Imaging Clinical Specialty (CPRS) HL7 Generation"
 . S MSG(1)="An error occurred in "_$T(+0)_" where the ADDSEG^HLOAPI invocation"
 . S MSG(2)="for the ZDS segment failed.  The error message is as follows:"
 . S MSG(3)=""""_SUCCESS_""""
 . S VARIABLES("HLMSTATE")=""
 . S VARIABLES("ZDSSEG")=""
 . S VARIABLES("ERROR")=""
 . D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 . Q
 Q
 ;
OBX(HLMSTATE,GMRCIEN) ; build one or more OBX segments (see OBX^GMRCHL72)
 N CODE,I,MEANING,OBXSEG,OBXSEGNO,VALUE,VALUETYPE
 S OBXSEGNO=0
 ;
 ; output reason for request
 S I=0 F  S I=$O(^GMR(123,GMRCIEN,20,I)) Q:'I  S VALUE=$G(^(I,0)) D
 . D OUTPUT("TX","RFR","REASON FOR REQUEST",VALUE,"F",.ERROR)
 . Q
 ;
 ; output provisional diagnosis
 S VALUE=$$GET1^DIQ(123,GMRCIEN,30)
 S CODE=$$GET1^DIQ(123,GMRCIEN,30.1)
 I VALUE'="" D
 . I CODE'="" D  ; send using the coded element format
 . . S VALUETYPE="CE"
 . . S VALUE("Identifier")=CODE
 . . S VALUE("Text")=$P(VALUE,(" ("_CODE))
 . . S VALUE("Name of Coding System")="I9" ; ICD-9
 . . Q
 . E  S VALUETYPE="TX" ; send using the free text format
 . D OUTPUT(VALUETYPE,"PDX","PROVISIONAL DIAGNOSIS",.VALUE,"F",.ERROR)
 . K VALUE
 . Q
 ;
 ; output tech comment - ORCOM is defined by CPRS Consult Request Tracking
 S I=0 F  S I=$O(ORCOM(I)) Q:'I  S VALUE=ORCOM(I) D
 . D OUTPUT("TX","TCM","TECH COMMENT",VALUE,"F",.ERROR)
 . Q
 ;
 ; output significant finding flag
 S VALUE=$$GET1^DIQ(123,GMRCIEN,15)
 I VALUE'="" D
 . D OUTPUT("TX","SF","SIGNIFICANT FINDINGS",VALUE,"F",.ERROR)
 . Q
 ;
 ; output allergies, if any
 D ALLERGY
 ; 
 ; output posting, if any
 D POSTINGS
 ;
 ; output results
 I MSGTYPE="ORU" D RESULTS
 ;
 Q
 ;
RESULTS ; output results
 N DASH,I,J,VALUE,STATUS,TITLE,TIUIEN,TIUTEXT,X,Y
 S $E(DASH,80)=" ",DASH=$TR(DASH," ","-") ; 80 dashes
 S STATUS=$S(ORSTATUS="CM":"F",1:"R")
 S I=0 F  S I=$O(@TIUDOC@(I))  Q:'I  S X=@TIUDOC@(I) D
 . N I
 . S TIUIEN=$P(X,"^",1),TITLE=$P(X,"^",2)
 . I TITLE?1"Addendum".E Q
 . D RESULT1(DASH,STATUS)
 . D TGET^TIUSRVR1(.TIUTEXT,TIUIEN)
 . S J=0 F  S J=$O(@TIUTEXT@(J))  Q:'J  D
 . . S VALUE=@TIUTEXT@(J)
 . . D RESULT1(VALUE,STATUS)
 . . Q
 . Q
 D RESULT1(DASH,STATUS)
 Q
 ;
RESULT1(VALUE,STATUS) ; output one line of text
 D OUTPUT("TX","R","REPORT",VALUE,STATUS,.ERROR)
 Q
 ;
ALLERGY ; check to see if patient has any allergies
 N GMRAL,I,VALUE
 D EN1^GMRADPT
 S I=0 F  S I=$O(GMRAL(I)) Q:'I  D  ; include each allergy string as an HL7 OBX segment
 . S VALUE=$P(GMRAL(I),"^",2)
 . D OUTPUT("TX","A","ALLERGIES",VALUE,"F",.ERROR)
 . Q
 Q
 ;
POSTINGS ; check if the patient has any other postings
 N I,HIT,MSG
 D ENCOVER^TIUPP3(DFN) I MSG Q  ; MSG="0^Patient posting found"
 S (I,HIT)=0
 F  S I=$O(^TMP("TIUPPCV",$J,I)) Q:'I  I $P(^(I),"^",2)'="A" S HIT=1 Q
 I HIT D
 . S VALUE="Please see CPRS for additional information about Postings."
 . D OUTPUT("TX","PO","POSTINGS",VALUE,"F",.ERROR)
 . Q
 Q
 ;
 ;
 ;
OUTPUT(VALUETYPE,ID,MEANING,VALUE,STATUS,ERROR) ; output an OBX segment with one line of text
 N SUCCESS
 S OBXSEGNO=OBXSEGNO+1
 D SET^HLOAPI(.OBXSEG,"OBX",0)
 D SET^HLOAPI(.OBXSEG,OBXSEGNO,1)
 D SET^HLOAPI(.OBXSEG,VALUETYPE,2)
 D SET^HLOAPI(.OBXSEG,ID,3,1)
 D SET^HLOAPI(.OBXSEG,MEANING,3,2)
 D SET^HLOAPI(.OBXSEG,"L",3,3)
 I VALUETYPE="CE",$D(VALUE)>=10 D  ; coded element
 . D SET^HLOAPI(.OBXSEG,VALUE("Identifier"),5,1)
 . D SET^HLOAPI(.OBXSEG,VALUE("Text"),5,2)
 . D SET^HLOAPI(.OBXSEG,VALUE("Name of Coding System"),5,3)
 . Q
 E  D SET^HLOAPI(.OBXSEG,VALUE,5)
 D SET^HLOAPI(.OBXSEG,STATUS,11)
 S SUCCESS=$$ADDSEG^HLOAPI(.HLMSTATE,.OBXSEG,.ERROR)
 I 'SUCCESS D
 . N MSG,SUBJECT,VARIABLES
 . S SUBJECT="VistA Imaging Clinical Specialty (CPRS) HL7 Generation"
 . S MSG(1)="An error occurred in OUTPUT^"_$T(+0)_" where the ADDSEG^HLOAPI invocation"
 . S MSG(2)="for the OBX segment for "_MEANING_" failed."
 . S MSG(3)="The error message is as follows:"
 . S MSG(4)=""""_SUCCESS_""""
 . S VARIABLES("VALUETYPE")=""
 . S VARIABLES("ID")=""
 . S VARIABLES("MEANING")=""
 . S VARIABLES("VALUE")=""
 . S VARIABLES("STATUS")=""
 . S VARIABLES("HLMSTATE")=""
 . S VARIABLES("OBXSEG")=""
 . S VARIABLES("ERROR")=""
 . D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 . Q
 Q
