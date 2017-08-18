VIAAPTR ;ALB/WW - Patient RPCs for RTLS ;4/20/16 10:11 pm
 ;;1.0;RTLS;**4**;April 22, 2013;Build 21
 ;;
 ;; RTLS Patient RPC calls
 Q
 ;
 ; Reference to ^DPT supported by IA #10035
 ;
 ;----------------------------------------------------------------------------
RTLSPT(RETSTA,REQDATA,DATAID,DATAID2) ; Retrieve Patient Information.
 ;
 ; This RPC allows retrieval of the following fields from 
 ; the Patient File (#2):
 ;   IEN
 ;   SOCIAL SECURITY NUMBER (#.09)
 ;   INTEGRATION CONTROL NUMBER (#991.01)
 ;   NAME ( #.01)
 ;   SEX (#.02)
 ;   DATE OF BIRTH (#.03)
 ;   ROOM-BED (#.101)
 ;   WARD LOCATION(#.1)
 ;
 ; Input:
 ;   RETSTA - name of the return array
 ;   REQDATA - identifies the DATAID/DATAID2 parameter value:
 ;     "SSN" defines DATAID as a Social Security Number
 ;     "ICN" defines DATAID as an Internal Control Number
 ;   DATAID - actual value as defined by REQDATA:
 ;     SSN if REQDATA="SSN"
 ;     ICN if REQDATA="ICN"
 ; Output:
 ;   Global ^TMP("VIAA"_REQDATA,$J)
 ;     Contains data elements when REQDATA and DATAID are passed in as
 ;     input parameters and are defined as follows:
 ;       "IEN^SSN^ICN^NAME^SEX^DOB^ROOM-BED^WARD LOCATION"
 ;     or an error condition:
 ;       "-###^" concatenated with reason for failure is returned,
 ;     where '###' is a 3-digit code
 ;
 N VIAA,VIAATMP,VIAAIEN
 ;
 S VIAA="VIAA"_REQDATA
 ;
 K ^TMP(VIAA,$J)
 ;
 I $G(REQDATA)="" S ^TMP(VIAA,$J,0)="-400^REQDATA must be the keyword 'SSN' or 'ICN'" D OUTPUT Q
 ;I $G(DATAID)="" S ^TMP(VIAA,$J,0)="-400^DATA ID not specified" D OUTPUT Q
 I $G(DATAID)="" D  D OUTPUT Q
 .I $G(REQDATA)="SSN" S ^TMP(VIAA,$J,0)="-400^SSN cannot be null"
 .I $G(REQDATA)="ICN" S ^TMP(VIAA,$J,0)="-400^ICN cannot be null"
 ;
 I "^SSN^ICN^"'[(U_REQDATA_U) D  D OUTPUT Q
 .S ^TMP(VIAA,$J,0)="-400^REQDATA must be the keyword 'SSN' or 'ICN'"
 ;
 S VIAAIEN=$$FIND1^DIC(2,,,DATAID,$S(REQDATA="ICN":"AICN",1:REQDATA))
 ;
 I 'VIAAIEN D  D OUTPUT Q
 .S ^TMP(VIAA,$J,0)="-404^("_DATAID_") not a recognized "_REQDATA
 ;
 S VIAATMP=VIAAIEN_U_$$GET1^DIQ(2,VIAAIEN_",","SSN")
 S VIAATMP=VIAATMP_U_$$GET1^DIQ(2,VIAAIEN_",","INTEGRATION CONTROL NUMBER")
 S VIAATMP=VIAATMP_U_$$GET1^DIQ(2,VIAAIEN_",","NAME")
 S VIAATMP=VIAATMP_U_$$GET1^DIQ(2,VIAAIEN_",","SEX","I")
 S VIAATMP=VIAATMP_U_$$GET1^DIQ(2,VIAAIEN_",","DOB")
 S VIAATMP=VIAATMP_U_$$GET1^DIQ(2,VIAAIEN_",","ROOM-BED")
 S VIAATMP=VIAATMP_U_$$GET1^DIQ(2,VIAAIEN_",","WARD LOCATION")
 S ^TMP(VIAA,$J,0)=VIAATMP
 ;
 ;----------------------------------------------------------------------------
OUTPUT ; Move the ^TMP data to the output array RETSTA
 ;
 S RETSTA=$NA(^TMP(VIAA,$J))
 ;
 Q
