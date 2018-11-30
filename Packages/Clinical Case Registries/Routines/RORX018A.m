RORX018A ;BPOIFO/SJA - BMI BY RANGE REPORT (CONT.) ;07/26/17
 ;;1.5;CLINICAL CASE REGISTRIES;**31**;Feb 17, 2006;Build 62
 ;
 ;
 ;OUTPUT THE REPORT 'RANGE' PARAMETERS
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;*****************************************************************************
PARAMS(PARTAG,RORDATA) ;
 N PARAMS,TMP,RC S RC=0
 S RORDATA("RANGE")=0 ;initialize to 'no range passed in'
 ;--- Lab test ranges
 I $D(RORTSK("PARAMS","LRGRANGES","C"))>1  D  Q:RC<0 RC
 . N GRC,ELEMENT,NODE,RTAG,RANGE
 . S NODE=$NA(RORTSK("PARAMS","LRGRANGES","C"))
 . S RTAG=$$ADDVAL^RORTSK11(RORTSK,"LRGRANGES",,PARTAG)
 . S (GRC,RC)=0
 . F  S GRC=$O(@NODE@(GRC))  Q:GRC'>0  D  Q:RC<0
 . . S RANGE=0,TMP=$$RTEXT^RORX018(GRC)
 . . S ELEMENT=$$ADDVAL^RORTSK11(RORTSK,"LRGRANGE",TMP,RTAG)
 . . I ELEMENT<0  S RC=ELEMENT  Q
 . . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"ID",GRC)
 . . ;--- Process the range values
 . . S TMP=$G(@NODE@(GRC,"L"))
 . . I TMP'=""  D  S RANGE=1
 . . . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"LOW",TMP)
 . . S TMP=$G(@NODE@(GRC,"H"))
 . . I TMP'=""  D  S RANGE=1
 . . . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"HIGH",TMP)
 . . I RANGE D
 . . . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"RANGE",1)
 . . . S RORDATA("RANGE")=1 ;range exists
 ;--- Success
 Q RC
 ;
