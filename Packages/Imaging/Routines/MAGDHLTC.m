MAGDHLTC ;WOIFO/MLH/PMK - IHE-based ADT interface for PACS - trigger events - A11, A12, A13 ;20 Mar 2017 12:15 PM
 ;;3.0;IMAGING;**49,183**;Mar 19, 2002;Build 11;Apr 07, 2011
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
A11 ; GOTO entry point from MAGDHLT - patient admission cancel
 ; INPUT:  XDFN      IEN of pt whose admission is being cancelled
 ;         XDT       date/time of cancellation
 ; function return:   result of message generation from call to GENERATE^HLMA
 ;
 N HL ; -------- HL7 initialization function status return
 N HLA ; ------- array of HL7 message segments
 N MSGA11A ; --- A11 message array
 N MSG ; ------- message status
 ;
 D INIT^HLFNC2("MAG CPACS A11",.HL)
 I $G(HL) Q -1_U_$P(HL,"^",2) ; error
 ;
 ; build a dummy MSH segment for the $$MAKE^MAG7UM function
 S MSGA11A(1,0)="MSH"
 S MSGA11A(1,1,1,1,1)=HLFS
 S MSGA11A(1,2,1,1,1)=HLECH
 S MSGA11A(1,9,1,1,1)="ADT"
 S MSGA11A(1,9,1,2,1)="A11"
 ;
 ; gather patient information and populate segment array elements
 S MSG=$$EVN^MAGDHLS("A11",XDT,XDT,"MSGA11A")
 S MSG=$$PID^MAGDHLS(XDFN,"MSGA11A")
 S MSG=$$PV1^MAGDHLS(XDFN,"A11",XDT,"MSGA11A")
 ;
 ; assemble message into segments
 S MSG=$$MAKE^MAG7UM("MSGA11A",$NA(HLA("HLS")))
 K HLA("HLS",1) ; remove dummy MSH segment
 ;
 ; send message to receiver and gateway
 D GENERATE^HLMA("MAG CPACS A11","LM",1,.RESULT) ; generate & send message
 D LOGGW^MAGDHLL("ADT") ; log message to gateway
 Q $S($P($G(RESULT),U,2,$L(RESULT,U))="":0,1:-1_U_RESULT)
 ;
A12 ; GOTO entry point from MAGDHLT - cancel patient transfer
 ; INPUT:  XDFN      IEN of pt whose admission is being cancelled
 ;         XDT       date/time of cancellation
 ; function return:   result of message generation from call to GENERATE^HLMA
 ;
 N HL ; -------- HL7 initialization function status return
 N HLA ; ------- array of HL7 message segments
 N MSGA12A ; --- A02 message array
 N MSG ; ------- message status
 ;
 D INIT^HLFNC2("MAG CPACS A12",.HL)
 I $G(HL) Q -1_U_$P(HL,"^",2) ; error
 ;
 ; build a dummy MSH segment for the $$MAKE^MAG7UM function
 S MSGA12A(1,0)="MSH"
 S MSGA12A(1,1,1,1,1)=HLFS
 S MSGA12A(1,2,1,1,1)=HLECH
 S MSGA12A(1,9,1,1,1)="ADT"
 S MSGA12A(1,9,1,2,1)="A12"
 ;
 ; gather patient information and populate segment array elements
 S MSG=$$EVN^MAGDHLS("A12",XDT,XDT,"MSGA12A")
 S MSG=$$PID^MAGDHLS(XDFN,"MSGA12A")
 S MSG=$$PV1^MAGDHLS(XDFN,"A12",XDT,"MSGA12A")
 S MSG=$$ROL^MAGDHLS(XDFN,"MSGA12A")
 S MSG=$$OBXADT^MAGDHLS(XDFN,"MSGA12A")
 ;
 ; assemble message into segments
 S MSG=$$MAKE^MAG7UM("MSGA12A",$NA(HLA("HLS")))
 K HLA("HLS",1) ; remove dummy MSH segment
 ;
 ; send message to receiver and gateway
 D GENERATE^HLMA("MAG CPACS A12","LM",1,.RESULT) ; generate & send message
 D LOGGW^MAGDHLL("ADT") ; log message to gateway
 Q $S($P($G(RESULT),U,2,$L(RESULT,U))="":0,1:-1_U_RESULT)
 ;
A13 ; GOTO entry point from MAGDHLT - cancel patient discharge
 ; INPUT:  XDFN      IEN of pt whose admission is being cancelled
 ;         XDT       date/time of cancellation
 ; function return:   result of message generation from call to GENERATE^HLMA
 ;
 N HL ; -------- HL7 initialization function status return
 N HLA ; ------- array of HL7 message segments
 N MSGA13A ; --- A13 message array
 N MSG ; ------- message status
 ;
 D INIT^HLFNC2("MAG CPACS A13",.HL)
 I $G(HL) Q -1_U_$P(HL,"^",2) ; error
 ;
 ; build a dummy MSH segment for the $$MAKE^MAG7UM function
 S MSGA13A(1,0)="MSH"
 S MSGA13A(1,1,1,1,1)=HLFS
 S MSGA13A(1,2,1,1,1)=HLECH
 S MSGA13A(1,9,1,1,1)="ADT"
 S MSGA13A(1,9,1,2,1)="A13"
 ;
 ; gather patient information and populate segment array elements
 S MSG=$$EVN^MAGDHLS("A13",XDT,XDT,"MSGA13A")
 S MSG=$$PID^MAGDHLS(XDFN,"MSGA13A")
 S MSG=$$PV1^MAGDHLS(XDFN,"A13",XDT,"MSGA13A")
 S MSG=$$ROL^MAGDHLS(XDFN,"MSGA13A")
 ;
 ; assemble message into segments
 S MSG=$$MAKE^MAG7UM("MSGA13A",$NA(HLA("HLS")))
 K HLA("HLS",1) ; remove dummy MSH segment
 ;
 ; send message to receiver and gateway
 D GENERATE^HLMA("MAG CPACS A13","LM",1,.RESULT) ; generate & send message
 D LOGGW^MAGDHLL("ADT") ; log message to gateway
 Q $S($P($G(RESULT),U,2,$L(RESULT,U))="":0,1:-1_U_RESULT)
