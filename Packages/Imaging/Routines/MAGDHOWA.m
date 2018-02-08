MAGDHOWA ;WOIFO/PMK - Route traditional 1.6 HL7 ADT messages via HLO ;17 Nov 2017 9:36 AM
 ;;3.0;IMAGING;**138,183**;Mar 19, 2002;Build 11;Sep 03, 2013
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
 ; Supported IA #4716 reference ^HLOAPI function calls
 ; Supported IA #4717 reference ^HLOAPI1 function calls
 ;
 ; The ADT A01, A02, A03, A11, A12, and A13 messages for commercial
 ; PACS were created by patch MAG*3.0*49.
 ; The ADT A08 and A47 messages were created by patch MAG*3.0*183.
 ; They are transmitted using the traditional 1.6 HL7 package.
 ; 
 ; The HL7 for clinical specialties uses the new HL7 Optimized package.
 ; 
 ; This routine is referenced by subscriber protocols to the original
 ; six HL7 event drivers and the two new ones for A08 and A47.
 ; It enables the HL7 1.6 messages to be routed using the new HL7
 ; Optimized package.  In this way, all of the clinical specialty
 ; systems deal with just the HL7 Optimized package.
 ; 
 ; 
 ; There are eight MAG CPACS ADT event drivers:
 ;   MAG CPACS A01 - Inpatient admission
 ;   MAG CPACS A02 - Patient transfer
 ;   MAG CPACS A03 - Patient discharge
 ;   MAG CPACS A08 - Update patient information 
 ;   MAG CPACS A11 - Cancel inpatient admission
 ;   MAG CPACS A12 - Cancel patient transfer
 ;   MAG CPACS A13 - Cancel patient discharge
 ;   MAG CPACS A47 - Change patient identifier list
 ;   
 ; There are eight MAG CPACS ADT HL7 1.6 subscribers:
 ;   MAG CPACS A01 SUBS - Routes inpatient admissions
 ;   MAG CPACS A02 SUBS - Routes patient transfers
 ;   MAG CPACS A03 SUBS - Routes patient discharges
 ;   MAG CPACS A08 SUBS - Update patient information
 ;   MAG CPACS A11 SUBS - Routes admission cancellations
 ;   MAG CPACS A12 SUBS - Routes transfer cancellations
 ;   MAG CPACS A13 SUBS - Routes discharge cancellations
 ;   MAG CPACS A47 SUBS - Routes change patient identifier list
 ; All of these use the HL7 logical link MAG CPACS 
 ; 
 ; There are eight MAG CPACS ADT HLO subscribers that call this routine:
 ;   MAG CPACS A01 SUBS-HLO - Routes inpatient admissions
 ;   MAG CPACS A02 SUBS-HLO - Routes patient transfers
 ;   MAG CPACS A03 SUBS-HLO - Routes patient discharges
 ;   MAG CPACS A08 SUBS-HLO - Update patient information
 ;   MAG CPACS A11 SUBS-HLO - Routes admission cancellations
 ;   MAG CPACS A12 SUBS-HLO - Routes transfer cancellations
 ;   MAG CPACS A13 SUBS-HLO - Routes discharge cancellations
 ;   MAG CPACS A47 SUBS-HLO - Routes change patient identifier list
 ;   
 ; All eight new MAG CPACS ADT HLO subscribers call this routine - each
 ; protocol file (#101) entry has PROCESSING ROUTINE: D ENTRY^MAGDHOWA
 ; 
 ; 
ENTRY ; subscriber entry point
 N HLMSTATE,MSGTYPE
 ;
 S MSGTYPE="ADT"
 ;
 D INPUT
 ;
 D OUTPUT
 Q
 ;
INPUT ; get the generated HL7 message and save it in HLO's HLMSTATE
 N A,B,C,ERROR,EVENT,S1,S2,S3,S4,S5
 I $E($G(HLARYTYP),1)="G" M A=^TMP("HLS",$J)
 E  I $E($G(HLARYTYP),1)="L" M A=HLA("HLS")
 E  Q  ; no input data <-----------------------------
 ;
 S A(1)=HLREC("HDR")
 ;
 ; $$PARSE converts HL7 message "A" to HL7 tree ("B") 
 ;
 S X=$$PARSE^MAG7UP("A","B")
 ;
 ; "C" will contain the HL7 HLO tree, just the fifth subscript level
 ; 
 S S1="" F  S S1=$O(B(S1)) Q:S1=""  D
 . S S2="" F  S S2=$O(B(S1,S2)) Q:S2=""  D
 . . ;
 . . ; store segment name at (S1,0,1,1,1) node
 . . I S2=0 S C(S1,0,1,1,1)=B(S1,0) Q
 . . ;
 . . S S3="" F  S S3=$O(B(S1,S2,S3)) Q:S3=""  D
  . . . S S4="" F  S S4=$O(B(S1,S2,S3,S4)) Q:S4=""  D
  . . . . S S5="" F  S S5=$O(B(S1,S2,S3,S4,S5)) Q:S5=""  D
 . . . . . S C(S1,S2,S3,S4,S5)=B(S1,S2,S3,S4,S5)
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
 I C(2,0,1,1,1)="EVN" D
 . S EVENT=C(2,1,1,1,1) ; ADT event type from the EVN message
 . Q
 E  S EVENT="O01" ; unknown event? <-------------------------------
 ;
 ; build the HLO structure with all the segments, after the MSH
 D INIT^MAGDHOW2(MSGTYPE,EVENT)
 S S1=1 F  S S1=$O(C(S1)) Q:S1=""  D
 . N SEGMENT,SUCCESS
 . M SEGMENT=C(S1)
 . S SUCCESS=$$ADDSEG^HLOAPI(.HLMSTATE,.SEGMENT,.ERROR)
 . I 'SUCCESS D
 . . N MSG,SUBJECT,VARIABLES
 . . S SUBJECT="Clinical Specialty HL7 Generation"
 . . S MSG(1)="An error occurred in INPUT^"_$T(+0)_" where the ADDSEG^HLOAPI"
 . . S MSG(2)="invocation failed.  The error message is as follows:"
 . . S MSG(3)=""""_SUCCESS_""""
 . . S VARIABLES("HLMSTATE")=""
 . . S VARIABLES("SEGMENT")=""
 . . S VARIABLES("ERROR")=""
 . . S VARIABLES("C")=""
 . . D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 . . Q
 . Q
 Q
 ;
OUTPUT ; send the HL7 message using HLO's subscription list
 N DIC,DO,HL7SUBLIST,MESSAGES,PARMS,SUCCESS,X,Y
 ;
 ; send the message via subscription list
 S DIC=779.4,DIC(0)="BX",X="MAGD ADT" D ^DIC
 S HL7SUBLIST=$P(Y,"^",1) ; Y should equal "<ien>^MAGD ADT"
 S PARMS("SENDING APPLICATION")="MAGD SENDER"
 S PARMS("SUBSCRIPTION IEN")=HL7SUBLIST
 ; the HLO private queue name is the name of the subscription list
 S PARMS("QUEUE")=$E($$GET1^DIQ(779.4,HL7SUBLIST,.01),1,20) ; private queue, 20 char max.
 S SUCCESS=$$SENDSUB^HLOAPI1(.HLMSTATE,.PARMS,.MESSAGES)
 I 'SUCCESS D
 . N MSG,SUBJECT,VARIABLES
 . S SUBJECT="Clinical Specialty HL7 Generation"
 . S MSG(1)="An error occurred in OUTPUT^"_$T(+0)_" where the SENDSUB^HLOAPI1"
 . S MSG(2)="invocation failed.  The error message is as follows:"
 . S MSG(3)=""""_SUCCESS_""""
 . S VARIABLES("HLMSTATE")=""
 . S VARIABLES("PARMS")=""
 . D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 . Q
 Q
 ;
ERROR(SUBJECT,MSG,VARIABLES) ; error logging subroutine
 N APP,I,PLACE,VAR
 ;
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S APP="CPRS_DICOM_and_HL7"
 ;
 K ^TMP($J,"MAGQ",PLACE,APP)
 D ADD("Message:"),ADD("")
 F I=1:1 Q:'$D(MSG(I))  D ADD(MSG(I))
 D ADD(""),ADD("Variables:"),ADD("")
 S VAR="" F  S VAR=$O(VARIABLES(VAR)) Q:VAR=""  D
 . I '$D(@VAR) D ADD(VAR_" (undefined)") ; undefined
 . E  I $D(@VAR)=1 D ADD(VAR_"="_@VAR) ; scalar
 . E  D  ; array
 . . N A
 . . S A=VAR F  D  Q:A=""  ; traverse the array
 . . . I $D(@A)#2 D ADD(A_"="_@A)
 . . . S A=$Q(@A)
 . . . Q
 . . Q
 . Q
 D ADD("End of Message")
 D MAILSHR^MAGQBUT1(PLACE,APP,SUBJECT) ; sent the mail message
 Q
 ;
ADD(X) ; add a line to the email message
 N LASTIEN
 S LASTIEN=$O(^TMP($J,"MAGQ",PLACE,APP,""),-1)
 S ^TMP($J,"MAGQ",PLACE,APP,LASTIEN+1)=X
 Q
 ;
TEST ; this tests the email error trap
 ; S DUZ=126,DUZ(2)=660 - set these appropriately before calling TEST
 N ARRAY,SCALAR,SUBJECT,UNDEFINED
 S ARRAY="This is test"
 S ARRAY(1)="Still testing"
 S ARRAY("B")="More testing"
 S ARRAY("C",1,2,3,4,5)="Additional testing"
 S SCALAR="This is a very bad error"
 ; S UNDEFINED=
 S VARIABLES("ARRAY")=""
 S VARIABLES("SCALAR")=""
 S VARIABLES("UNDEFINED")=""
 S SUBJECT="Testing Clinical Specialty HL7 Generation Error Handling"
 S MSG(1)="This simulated error occurred in TEST^"_$T(+0)_"."
 S MSG(2)="This error tests the email messages that are used"
 S MSG(3)="to report the error."
 D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 Q
