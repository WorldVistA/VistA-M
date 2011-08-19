DGRUGA12 ;ALB/GRR - HL7 ADT A12 MESSAGE BUILDER ;8/5/99  15:33
 ;;5.3;Registration;**190**;Aug 13, 1993
 ;
 ;This routine will build a ADT A12 (Cancel Transfer) HL7 message for an inpatient.
 ;
EN(DFN,DGMIEN,DGARRAY) ;Entry point of routine
 ;DFN - Patient Internal Entry Number
 ;DGMIEN - Patient Movement Internal Entry Number
 ;DGARRAY - Name of output array by reference where built message will be contained.
 ;
 ;The HL7 variables must be initialized before calling this routine!
 ;HL("FS"),HL("ECH"),HLFS,HLECH, and HLQ are used by segment builders called by this routine
 ;
 N DGPV1,DGHMDT,DGCNT,DGMDT,DGCDT,DGOADT,DGICD,DGICDCNT,DGIN,DGINCNT,DGCTRAN,DGHMDT S DGCNT=0
 Q:DGARRAY=""  ;Required output variable name was not passed
 K @DGARRAY ;Kill output array to insure erronuous data does not exist
 Q:DGMIEN=""
 S DGMDT=$S($G(DGCTRAN)=1:+DGPMP,1:$$GET1^DIQ(405,DGMIEN,".01","I")),DGHMDT=$$HLDATE^HLFNC(DGMDT)
 D NOW^%DTC S DGCDT=$$HLDATE^HLFNC(%) ;Get current date/time and convert to HL7 format
 S DGCNT=DGCNT+1 ;Increment node counter by one for first segment
 S @DGARRAY@(DGCNT)=$$EVN^VAFHLEVN("A12","05",DGMDT) ;Create Event segment and store in output array (Use current date/time for cancel)
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFCPID(DFN,",2,5,7,8,10,11,13,16,17,19,23,29",1) ;Create PID segment using segment sequence numbers passed and store in output array
 S DGCNT=DGCNT+1 ;Increment node counter by one to store next segment
 S DGPV1=$$IN^VAFHLPV1(DFN,DGMDT,",2,3,6,7,10,17,44,",$G(DGMIEN),"","") ;Create the PV1 segment based on sequence numbers passed, and store in output array
 S DGOADT=$$CKADMIT^DGRUUTL1(DFN) ;check if integrated site get original admit date/time
 I DGOADT]"" S $P(DGPV1,HL("FS"),45)=$$HLDATE^HLFNC(DGOADT)
 I $G(DGCTRAN)=1 S $P(DGPV1,HL("FS"),4)=$P(DGPV1,HL("FS"),7)
 S DGPV1=$$DOCID^DGRUUTL(DGPV1)
 S @DGARRAY@(DGCNT)=$$LOCTRAN^DGRUUTL1(DGPV1) ;Translate Ward and Room-Bed name if needed, store into array
 D IN^VAFHLDG1(DFN,DGMIEN,",2,3,5,","DGICD",DGMDT) ;Create DG1 segments if data exist and store in temporary array
 I $O(DGICD(0))>0 D  ;DG1 segments were built
 .S DGICDCNT=0 F  S DGICDCNT=$O(DGICD(DGICDCNT)) Q:DGICDCNT=""  S DGCNT=DGCNT+1,@DGARRAY@(DGCNT)=DGICD(DGICDCNT,0) ;Loop through temporary array and store in output array
 Q
