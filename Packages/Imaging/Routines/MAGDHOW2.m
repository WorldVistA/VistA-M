MAGDHOW2 ;WOIFO/PMK/DAC - Capture Consult/GMRC data ;15 May 2017 3:02 PM
 ;;3.0;IMAGING;**138,156,183**;Mar 19, 2002;Build 11;Nov 16, 2014
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
 ; Supported IA #5886 reference ^HLOPBLD1 function calls
 ; Supported IA #6103 reference for reading ^HLA
 ;
 ;
MESSAGE(SERVICE) ; invoked from ^MAGDHOW1
 N CONSULT,ERROR,HL7IEN,HLMSTATE,I,MESSAGES,MSG,NEXT,OBXSEGNO
 N PRIORITY,SAVEORCSEG,SUCCESS,TIUDOC,X,Y
 ;
 ; P156 DAC - Support for HL7 result messages
 I MSGTYPE="ORM" D  ; order entry message
 . D INIT(MSGTYPE,"O01") ; start building a new HL7 order entry message
 . Q
 E  D  ; result message
 . D INIT(MSGTYPE,"R01") ; start building a new HL7 result message
 . Q
 ;
 D PIDPV1^MAGDHOW2(.HLMSTATE,DFN)
 D ORC^MAGDHOW3(.HLMSTATE,GMRCIEN,.SAVEORCSEG)
 D OBR^MAGDHOW4(.HLMSTATE,GMRCIEN,.SAVEORCSEG,SERVICE)
 D ZDS^MAGDHOW5(.HLMSTATE,GMRCIEN)
 D OBX^MAGDHOW5(.HLMSTATE,GMRCIEN)
 ;
 ; send the message via subscription list
 S PARMS("SENDING APPLICATION")="MAGD SENDER"
 S PARMS("SUBSCRIPTION IEN")=HL7SUBLIST
 ; the HLO private queue name is the name of the subscription list
 S PARMS("QUEUE")=$$GET1^DIQ(779.4,HL7SUBLIST,.01) ; private queue
 S SUCCESS=$$SENDSUB^HLOAPI1(.HLMSTATE,.PARMS,.MESSAGES)
 I 'SUCCESS D
 . N MSG,SUBJECT,VARIABLES
 . S SUBJECT="VistA Imaging Clinical Specialty (CPRS) HL7 Generation"
 . S MSG(1)="An error occurred in "_$T(+0)_" where the SENDSUB^HLOAPI1"
 . S MSG(2)="invocation failed.  The error message is as follows:"
 . S MSG(3)=""""_SUCCESS_""""
 . S VARIABLES("HLMSTATE")=""
 . S VARIABLES("PARMS")=""
 . S VARIABLES("MESSAGES")=""
 . D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 . Q
 D OUTPUT ; send to DICOM Gateway
 ;
 Q
 ;
INIT(MSGTYPE,EVENT) ; start building a new HL7 message
 N ERROR,PARMS,SUCCESS
 S PARMS("COUNTRY")="USA"
 S PARMS("CONTINUATION POINTER")=0
 S PARMS("EVENT")=EVENT
 S PARMS("FIELD SEPARATOR")="|"
 S PARMS("ENCODING CHARACTERS")="^~\&"
 S PARMS("MESSAGE STRUCTURE")=MSGTYPE_"_"_EVENT
 S PARMS("MESSAGE TYPE")=MSGTYPE
 S PARMS("PROCESSING MODE")="T"
 S PARMS("VERSION")=2.4
 S SUCCESS=$$NEWMSG^HLOAPI(.PARMS,.HLMSTATE,.ERROR)
 I 'SUCCESS D
 . N MSG,SUBJECT,VARIABLES
 . S SUBJECT="VistA Imaging Clinical Specialty (CPRS) HL7 Generation"
 . S MSG(1)="An error occurred in INIT^"_$T(+0)_" where the NEWMSG^HLOAPI"
 . S MSG(2)="invocation failed.  The error message is as follows:"
 . S MSG(3)=""""_SUCCESS_""""
 . S VARIABLES("PARMS")=""
 . S VARIABLES("HLMSTATE")=""
 . S VARIABLES("ERROR")=""
 . D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 . Q
 Q
 ;
PIDPV1(HLMSTATE,DFN) ; build the PID and PV1 segments
 ; Also invoked by ^MAGT7S to build these segments for Anatomic Pathology - P183 PMK 3/7/17
 N HL,HL7ARRAY,HL7SEG,HLECH,HLFS,HLQ,NUL,PID,PV1,SUCCESS
 S HLECH=HLMSTATE("HDR","ENCODING CHARACTERS")
 S HLFS=HLMSTATE("HDR","FIELD SEPARATOR")
 S HLQ="""""" ; null fields are set as "", as opposed to being empty
 S HL7ARRAY(1,9,1,1,1)=""
 S HL7ARRAY(1,0)="MSH"
 S HL7ARRAY(1,1,1,1,1)=HLFS
 S HL7ARRAY(1,2,1,1,1)=HLECH
 D PID^MAGDHLS(DFN,"HL7ARRAY")
 D PV1^MAGDHLS(DFN,"",DT,"HL7ARRAY")
 ;
 S NUL=$$MAKE^MAG7UM("HL7ARRAY","HL7SEG")
 S PID=HL7SEG(2)
 S PV1=HL7SEG(3)
 S SUCCESS=$$MOVESEG^HLOAPI(.HLMSTATE,PID,.ERROR)
 I 'SUCCESS D
 . N MSG,SUBJECT,VARIABLES
 . S SUBJECT="VistA Imaging Clinical Specialty (CPRS) HL7 Generation"
 . S MSG(1)="An error occurred in PIDPV1^"_$T(+0)_" where the MOVESEG^HLOAPI invocation"
 . S MSG(2)="for the PID segment failed.  The error message is as follows:"
 . S MSG(3)=""""_SUCCESS_""""
 . S VARIABLES("HLMSTATE")=""
 . S VARIABLES("PID")=""
 . S VARIABLES("ERROR")=""
 . D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 . Q
 S SUCCESS=$$MOVESEG^HLOAPI(.HLMSTATE,PV1,.ERROR)
 I 'SUCCESS D
 . N MSG,SUBJECT,VARIABLES
 . S SUBJECT="VistA Imaging Clinical Specialty (CPRS) HL7 Generation"
 . S MSG(1)="An error occurred in PIDPV1^"_$T(+0)_" where the MOVESEG^HLOAPI invocation"
 . S MSG(2)="for the PV1 segment failed.  The error message is as follows:"
 . S MSG(3)=""""_SUCCESS_""""
 . S VARIABLES("HLMSTATE")=""
 . S VARIABLES("PID")=""
 . S VARIABLES("ERROR")=""
 . D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 . Q
 Q
 ;
OUTPUT ; output the messages to ^MAGDHL7
 N D0,DEL,FMDATE,FMDATETIME,HLAIEN,HDR,HL7,HL7MSH,I,I1,I2,J,K,MSG,N,X,Y,Z
 S HLAIEN=HLMSTATE("BODY")
 ;
 ; build the MSH segment
 D BUILDHDR^HLOPBLD1(.HLMSTATE,"MSH",.HL7MSH)
 ;
 ; copy the two lines of the MSH segment to the HL7 array
 S HL7MSH=HL7MSH(1)_HL7MSH(2) ; MSH segment
 S DEL=HLMSTATE("HDR","FIELD SEPARATOR")
 S $P(HL7MSH,DEL,5)="MAGD-CONSULT" ; receiving application
 S $P(HL7MSH,DEL,6)="" ; receiving facility
 S J=1,HL7(J)=HL7MSH
 ;
 ; copy the body of the message to the HL7 array
 ; some of the message may be in ^HLA(HLAIEN) - if so, get it first
 ;
 I HLAIEN D  ; get the segments that are saved in ^HLA(HLAIEN)
 . ; note: segments are separated by a blank line
 . S I=0 F  S I=$O(^HLA(HLAIEN,1,I)) Q:I=""  D
 . . S X=$G(^HLA(HLAIEN,1,I,0))
 . . I X'="" S J=J+1,HL7(J)=X
 . . Q
 . Q
 ;
 ; get the remainder of the messages from memory
 ; note: segments are separated by a blank line
 S I1=0 F  S I1=$O(HLMSTATE("UNSTORED LINES",1,I1)) Q:I1=""  D
 . S I2=0 F  S I2=$O(HLMSTATE("UNSTORED LINES",1,I1,I2)) Q:I2=""  D
 . . S X=HLMSTATE("UNSTORED LINES",1,I1,I2)
 . . I X'="" S J=J+1,HL7(J)=X
 . . Q
 . Q
 ;
 S N=J ; number of HL7 record lines
 S DEL=$E(HL7(1),4) ; field separator
 S $P(HL7(1),DEL,5,6)="MAGD-CONSULT"_DEL ; receiving application
 ;
 ; get the next node in the ^MAGDHL7 global
 S FMDATETIME=$$NOW^XLFDT,FMDATE=$$DT^XLFDT
 L +^MAGDHL7(2006.5,0):1E9 ; Background process MUST wait
 S D0=$O(^MAGDHL7(2006.5," "),-1)+1
 S ^MAGDHL7(2006.5,D0,0)=FMDATE
 S:FMDATE'="" ^MAGDHL7(2006.5,"B",FMDATE,D0)=""
 S HDR=$G(^MAGDHL7(2006.5,0))
 S ^MAGDHL7(2006.5,0)="PACS MESSAGE^2006.5D^"_D0_"^"_($P(HDR,"^",4)+1)
 L -^MAGDHL7(2006.5,0)
 ;
 ; copy the message to the ^MAGDHL7 global, field by field
 S ^MAGDHL7(2006.5,D0,0)=FMDATE_"^"_MSGTYPE_"^"_FMDATETIME
 S (I,J)=0  F I=1:1:N S X=HL7(I) D
 . S Y=$P(X,DEL)
 . F K=2:1:$L(X,DEL) D  ; copy the lines to the ^MAGDHL7 global
 . . S Z=$P(X,DEL,K)
 . . I ($L(Y)+$L(Z))>200 D  ; keep lines short for the global
 . . . ; output one line of a spanned record
 . . . S J=J+1,^MAGDHL7(2006.5,D0,1,J,0)=Y,Y=""
 . . . Q
 . . S Y=Y_DEL_$P(X,DEL,K)
 . . Q
 . S J=J+1,^MAGDHL7(2006.5,D0,1,J,0)=Y
 . Q
 S:FMDATETIME'="" ^MAGDHL7(2006.5,"C",FMDATETIME,D0)="" ; P183 PMK 3/6/17
 ; The next line must be last, since WAIT^MAGDHRS1
 ; uses this node to determine that the entry is complete.
 S ^MAGDHL7(2006.5,D0,1,0)="^^"_J_"^"_J_"^"_FMDATETIME
 Q
