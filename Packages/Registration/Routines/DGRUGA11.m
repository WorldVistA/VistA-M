DGRUGA11 ;ALB/GRR - HL7 ADT A11 MESSAGE BUILDER ;8/5/99  15:33
 ;;5.3;Registration;**190**;Aug 13, 1993
 ;
 ;This routine will build a ADT A11 (Cancel Admit) HL7 message for an inpatient.
 ;
EN(DFN,DGMIEN,DGARRAY,DGWARD,DGDT) ;Entry point of routine
 ;DFN - Patient Internal Entry Number
 ;DGMIEN - Patient Movement Internal Entry Number
 ;DGARRAY - Name of output array by reference where built message will be contained.
 ;DGWARD - IEN of Ward Location (OPTIONAL)
 ;
 ;The HL7 variables must be initialized before calling this routine!
 ;HL("FS"),HL("ECH"),HLFS,HLECH, and HLQ are used by segment builders called by this routine
 ;
 N DGCNT,DGMDT,DGCDT,DGOADT,DGPV1,DGICD,DGICDCNT,DGIN,DGINCNT,DGWARDNM,DGCTRAN,DGHMDT S DGCNT=0,DGWARDNM=""
 Q:DGARRAY=""  ;Required output variable name was not passed
 K @DGARRAY ;Kill output array to insure erronuous data does not exist
 S DGMDT=$S($G(DGCTRAN)=1:+DGPMP,1:$$GET1^DIQ(405,DGMIEN,.01,"I")),DGHMDT=$$HLDATE^HLFNC(DGMDT)
 D NOW^%DTC S DGCDT=$$HLDATE^HLFNC(%) ;Get current date/time and convert to HL7 format
 S DGCNT=DGCNT+1 ;Increment node counter by one for first segment
 S @DGARRAY@(DGCNT)=$$EVN^VAFHLEVN("A11","05",DGMDT) ;Create Event segment and store in output array (Use current date/time for cancel)
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFCPID(DFN,",2,5,7,8,10,11,13,16,17,19,23,29",1) ;Create PID segment using segment sequence numbers passed and store in output array
 I DGWARD]"" S DGWARDNM=$$GET1^DIQ(42,+DGWARD,.01)
 S DGCNT=DGCNT+1 ;Increment node counter by one to store next segment
 S DGPV1="PV1"_HL("FS")_1_HL("FS")_"I" ;Create the PV1 segment with no visit data and store in output array
 S $P(DGPV1,HL("FS"),45)=$$HLDATE^HLFNC(DGDT) ;GRR 1/26/00
 S DGOADT=$$CKADMIT^DGRUUTL1(DFN) ;check if integrated site get original admit date/time
 I DGOADT]"" S $P(DGPV1,HL("FS"),45)=$$HLDATE^HLFNC(DGOADT)
 S DGPV1=$$DOCID^DGRUUTL(DGPV1)
 I DGWARDNM]"" S $P(DGPV1,HL("FS"),7)=DGWARDNM
 S @DGARRAY@(DGCNT)=DGPV1
 S DGCNT=DGCNT+1
 S @DGARRAY@(DGCNT)="PV2"
 Q
