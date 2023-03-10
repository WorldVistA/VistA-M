MAGDSTV2 ;WOIFO/PMK - Process a Q/R Client RPC; Mar 31, 2020@13:00:30
 ;;3.0;IMAGING;**231**;Mar 19, 2002;Build 9;Sep 03, 2013
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
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ;
 Q
 ; M2MB server
 ;
 ; This routine is invoked by the M2M Broker RPC to handle a Q/R client.
 ;
ENTRY(RESULT,REQUEST) ; RPC = MAG DICOM Q/R CLIENT
 N ARGS ; ---- argument string of the REQUEST item
 N DATETIME ;- fileman date/time of the study
 N DCMPID ;--- DICOM patient id
 N DFN ;------ VistA's internal patient identifier
 N ERRCODE ;-- code for an error, if encountered
 N IREQUEST ;- pointer to item in REQUEST array
 N MSG ; ----- error message array
 N OPCODE ;--- operation code of the REQUEST item
 N RETURN ;--- intermediate return code
 N J ;-------- scratch variable
 ;
 ; pass the request list and determine what has to be done
 F IREQUEST=2:1:$G(REQUEST(1)) D
 . S OPCODE=$P(REQUEST(IREQUEST),"|")
 . S ARGS=$P(REQUEST(IREQUEST),"|",2,999)
 . ;
 . I OPCODE="NEXT" D  Q
 . . S NEXTIEN=$G(^MAGDSTT(2006.541,"ACOUNT"))+1
 . . I '$D(^MAGDSTT(2006.541,NEXTIEN)) D RESULT("QR-REQUEST","NONE") Q
 . . ; if another RPC is already processing this request, skip it
 . . L +^MAGDSTT(2006.541,"ACOUNT"):0 E  D RESULT("QR-REQUEST","NONE") Q
 . . S VALUE=^MAGDSTT(2006.541,NEXTIEN,0)_"^"_NEXTIEN
 . . D RESULT("QR-REQUEST",VALUE)
 . . S J=0
 . . F  S J=$O(^MAGDSTT(2006.541,NEXTIEN,1,J)) Q:'J  D
 . . . S VALUE=^MAGDSTT(2006.541,NEXTIEN,1,J,0)
 . . . D RESULT("KEY",VALUE)
 . . . Q
 . . S ^MAGDSTT(2006.541,"ACOUNT")=NEXTIEN
 . . L -^MAGDSTT(2006.541,"ACOUNT")
 . . Q
 . ;
 . I OPCODE="QUERY RESULT" D  Q  ; save query results in ^XTMP
 . . N V,VARS,VAR
 . . S VARS="MAGXTMP^HOSTNAME^VISTAJOB^QRSTACK^IEN2006541^LEVEL^I^J^K^L^VARIABLE^VALUE"
 . . F V=1:1:$L(VARS,"^") S VAR=$P(VARS,"^",V) N @VAR S @VAR=$P(ARGS,"|",V)
 . . I LEVEL="PATIENT" D
 . . . I I="" S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"PATIENT")=VALUE
 . . . E  S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"PATIENT",I,VARIABLE)=VALUE
 . . . Q
 . . E  I LEVEL="STUDY" D
 . . . I J="" S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"STUDY",I)=VALUE
 . . . E  S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"STUDY",I,J,VARIABLE)=VALUE
 . . . Q
 . . E  I LEVEL="SERIES" D
 . . . I K="" S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"SERIES",I,J)=VALUE
 . . . E  S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"SERIES",I,J,K,VARIABLE)=VALUE
 . . . Q
 . . E  I LEVEL="IMAGE" D
 . . . I L="" S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"IMAGE",I,J,K)=VALUE
 . . . E  S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"IMAGE",I,J,K,L,VARIABLE)=VALUE
 . . . Q
 . . E  I LEVEL="DONE" D
 . . . ; "DONE" uses the request IEN for proper synchronization
 . . . S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"DONE",IEN2006541)=$$NOW^XLFDT_"^"_VARIABLE_"^"_VALUE
 . . . Q
 . . E  I LEVEL="WORKING..." D
 . . . S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"WORKING...",IEN2006541)=$$NOW^XLFDT_"^"_VARIABLE_"^"_VALUE
 . . . Q
 . . E  I LEVEL="MESSAGE" D
 . . . S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"MESSAGE",VARIABLE,I)=VALUE
 . . . Q
 . . E  S PI=CIRCUMFERENCE/DIAMETER ; throw an error (line of code written on 3/14)
 . . Q
 . I OPCODE="RETRIEVE RESULT" D  Q  ; save retrieve results in ^XTMP
 . . S MAGXTMP=$P(ARGS,"|",1),HOSTNAME=$P(ARGS,"|",2),VISTAJOB=$P(ARGS,"|",3)
 . . S QRSTACK=$P(ARGS,"|",4)
 . . S IEN2006541=$P(ARGS,"|",5) ; IEN2006541 is not used here
 . . S ACNUMB=$P(ARGS,"|",6),X=$P(ARGS,"|",7,999)
 . . S ^XTMP(MAGXTMP,HOSTNAME,VISTAJOB,QRSTACK,"Q/R RETRIEVE STATUS",ACNUMB)=X
 . . Q
 . I OPCODE="CRASH" D  Q
 . . S I=1/0 ; generate an error on the server to test error trapping
 . . Q
 . Q
 Q
 ;
RESULT(OPCODE,ARGS) ; add an item to the RESULT list
 S RESULT(1)=$G(RESULT(1),1)+1 ; first element in array is counter
 S RESULT(RESULT(1))=OPCODE_"|"_ARGS
 Q
