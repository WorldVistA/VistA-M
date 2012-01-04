MAGDHLTA ;WOIFO/MLH - IHE-based ADT interface for PACS - trigger events - A01, A02, A03 ; 23 Apr 2009 3:40 PM
 ;;3.0;IMAGING;**49**;Mar 19, 2002;Build 2033;Apr 07, 2011
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
 ;
A01 ; GOTO entry point from MAGDHLT - patient admission 
 ; INPUT:  XDFN       patient's internal entry number on PATIENT File (#2)
 ;         XOCCURRED  date/time of the admission in FileMan format
 ; function return:   result of message generation from call to GENERATE^HLMA
 ;
 N HL ; -------- HL7 initialization function status return
 N HLA ; ------- array of HL7 message segments
 N MSGA01A ; --- A01 message array
 N MSG ; ------- message status
 N RESULT ; ---- status message returned by message generator
 ;
 D INIT^HLFNC2("MAG CPACS A01",.HL)
 I $G(HL) Q -1_U_$P(HL,"^",2) ; error
 S HLCS=$E(HLECH,1),HLRS=$E(HLECH,2),HLSS=$E(HLECH,4)
 ;
 ; build a dummy MSH segment for the $$MAKE^MAG7UM function
 S MSGA01A(1,0)="MSH"
 S MSGA01A(1,1,1,1,1)=HLFS
 S MSGA01A(1,2,1,1,1)=HLECH
 S MSGA01A(1,9,1,1,1)="ADT"
 S MSGA01A(1,9,1,2,1)="A01"
 ;
 S MSG=$$EVN^MAGDHLS("A01",$$NOW^XLFDT,XOCCURRED,"MSGA01A")
 S MSG=$$PID^MAGDHLS(XDFN,"MSGA01A")
 S MSG=$$PV1^MAGDHLS(XDFN,"A01",XOCCURRED,"MSGA01A")
 S MSG=$$ROL^MAGDHLS(XDFN,"MSGA01A")
 S MSG=$$OBXADT^MAGDHLS(XDFN,"MSGA01A")
 S MSG=$$AL1^MAGDHLS(XDFN,"MSGA01A")
 S MSG=$$DG1^MAGDHLS(XDFN,"MSGA01A")
 ;
 ; assemble message into segments
 S MSG=$$MAKE^MAG7UM("MSGA01A",$NA(HLA("HLS")))
 K HLA("HLS",1) ; remove dummy MSH segment
 ;
 ; send message to receiver and gateway
 D GENERATE^HLMA("MAG CPACS A01","LM",1,.RESULT) ; generate & send message
 D LOGGW^MAGDHLL("ADT") ; log message to gateway
 Q $S($P($G(RESULT),U,2,$L(RESULT,U))="":0,1:-1_U_RESULT)
 ;
A02 ; GOTO entry point from MAGDHLT - patient transfer
 ; INPUT:  XDFN       patient's internal entry number on PATIENT File (#2)
 ;         XOCCURRED  date/time of the admission in FileMan format
 ; function return:   result of message generation from call to GENERATE^HLMA
 ;
 N HL ; -------- HL7 initialization function status return
 N HLA ; ------- array of HL7 message segments
 N MSGA02A ; --- A02 message array
 N MSG ; ------- message status
 N RESULT ; ---- status message returned by message generator
 ;
 D INIT^HLFNC2("MAG CPACS A02",.HL)
 I $G(HL) Q -1_U_$P(HL,"^",2) ; error
 S HLCS=$E(HLECH,1),HLRS=$E(HLECH,2),HLSS=$E(HLECH,4)
 ;
 ; build a dummy MSH segment for the $$MAKE^MAG7UM function
 S MSGA02A(1,0)="MSH"
 S MSGA02A(1,1,1,1,1)=HLFS
 S MSGA02A(1,2,1,1,1)=HLECH
 S MSGA02A(1,9,1,1,1)="ADT"
 S MSGA02A(1,9,1,2,1)="A02"
 ;
 ; get patient movement event information and build EVN segment
 S MSG=$$EVN^MAGDHLS("A02",$$NOW^XLFDT,XOCCURRED,"MSGA02A")
 S MSG=$$PID^MAGDHLS(XDFN,"MSGA02A")
 S MSG=$$PV1^MAGDHLS(XDFN,"A02",XOCCURRED,"MSGA02A")
 S MSG=$$ROL^MAGDHLS(XDFN,"MSGA02A")
 ;
 ; assemble message into segments
 S MSG=$$MAKE^MAG7UM("MSGA02A",$NA(HLA("HLS")))
 K HLA("HLS",1) ; remove dummy MSH segment
 ;
 ; send message to receiver and gateway
 D GENERATE^HLMA("MAG CPACS A02","LM",1,.RESULT) ; generate & send message
 D LOGGW^MAGDHLL("ADT") ; log message to gateway
 Q $S($P($G(RESULT),U,2,$L(RESULT,U))="":0,1:-1_U_RESULT)
 ;
A03 ; GOTO entry point from MAGDHLT - patient discharge
 ; INPUT:  XDFN       patient's internal entry number on PATIENT File (#2)
 ;         XOCCURRED  date/time of the admission in FileMan format
 ; function return:   result of message generation from call to GENERATE^HLMA
 ;
 N HL ; -------- HL7 initialization function status return
 N HLA ; ------- array of HL7 message segments
 N MSGA03A ; --- A03 message array
 N MSG ; ------- message status
 N RESULT ; ---- status message returned by message generator
 ;
 D INIT^HLFNC2("MAG CPACS A03",.HL)
 I $G(HL) Q -1_U_$P(HL,"^",2) ; error
 S HLCS=$E(HLECH,1),HLRS=$E(HLECH,2),HLSS=$E(HLECH,4)
 ;
 ; build a dummy MSH segment for the $$MAKE^MAG7UM function
 S MSGA03A(1,0)="MSH"
 S MSGA03A(1,1,1,1,1)=HLFS
 S MSGA03A(1,2,1,1,1)=HLECH
 S MSGA03A(1,9,1,1,1)="ADT"
 S MSGA03A(1,9,1,2,1)="A03"
 ;
 ; get patient movement event information and build EVN segment
 S MSG=$$EVN^MAGDHLS("A03",$$NOW^XLFDT,XOCCURRED,"MSGA03A")
 S MSG=$$PID^MAGDHLS(XDFN,"MSGA03A")
 S MSG=$$PV1^MAGDHLS(XDFN,"A03",XOCCURRED,"MSGA03A")
 S MSG=$$ROL^MAGDHLS(XDFN,"MSGA03A")
 S MSG=$$DG1^MAGDHLS(XDFN,"MSGA03A")
 ;
 ; assemble message into segments
 S MSG=$$MAKE^MAG7UM("MSGA03A",$NA(HLA("HLS")))
 K HLA("HLS",1) ; remove dummy MSH segment
 ;
 ; send message to receiver and gateway
 D GENERATE^HLMA("MAG CPACS A03","LM",1,.RESULT) ; generate & send message
 D LOGGW^MAGDHLL("ADT") ; log message to gateway
 Q $S($P($G(RESULT),U,2,$L(RESULT,U))="":0,1:-1_U_RESULT)
