DGRUGA21 ;ALB/GRR - HL7 ADT A21 MESSAGE BUILDER ;8/5/99  15:35
 ;;5.3;Registration;**190**;Aug 13, 1993
 ;
 ;This routine will build a ADT A21 (To Leave of Absence) HL7 message for an inpatient.
 ;
EN(DFN,DGMIEN,DGARRAY) ;Entry point of routine
 ;DFN - Patient Internal Entry Number
 ;DGMIEN - Patient Movement Internal Entry Number
 ;DGARRAY - Name of output array by reference where built message will be contained.
 ;
 ;The HL7 variables must be initialized before calling this routine!
 ;HL("FS"),HL("ECH"),HLFS,HLECH, and HLQ are used by segment builders called by this routine
 ;
 N DGPV1,DGCNT,DGMDT,DGCDT,DGOADT,DGICD,DGICDCNT,DGIN,DGINCNT S DGCNT=0
 Q:DGARRAY=""  ;Required output variable name was not passed
 K @DGARRAY ;Kill output array to insure erronuous data does not exist
 Q:DGMIEN=""
 S DGMDT=$$GET1^DIQ(405,DGMIEN,".01","I")
 D NOW^%DTC S DGCDT=$$HLDATE^HLFNC(%) ;Get current date/time and convert to HL7 format
 S DGCNT=DGCNT+1 ;Increment node counter by one for first segment
 S @DGARRAY@(DGCNT)=$$EVN^VAFHLEVN("A21","05",DGMDT) ;Create Event segment and store in output array
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFCPID(DFN,",2,5,7,8,10,11,13,16,17,19,23,29",1) ;Create PID segment using segment sequence numbers passed and store in output array
 S DGMDT=$$GET1^DIQ(405,DGMIEN,".01","I") ;Retrieve Movement Date/Time
 S DGCNT=DGCNT+1 ;Increment node counter by one to store next segment
 S DGPV1=$$IN^VAFHLPV1(DFN,DGMDT,",2,3,6,7,10,17,44,",$G(DGMIEN),"","") ;Create the PV1 segment based on sequence numbers passed
 S DGOADT=$$CKADMIT^DGRUUTL1(DFN) ;check if integrated site get original admit date/time
 I DGOADT]"" S $P(DGPV1,HL("FS"),45)=$$HLDATE^HLFNC(DGOADT)
 S DGPV1=$$DOCID^DGRUUTL(DGPV1)
 S @DGARRAY@(DGCNT)=$$LOCTRAN^DGRUUTL1(DGPV1) ;Translate Ward and Room-Bed name if needed, store in array
 S DGMTYP=$$GET1^DIQ(405,DGMIEN,.18,"I") ;Get Movement Type
 I DGMTYP=13!(DGMTYP=40)!(DGMTYP=43) S $P(@DGARRAY@(DGCNT),HL("FS"),41)="H" ;If to ASIH flag bed status field as 'H'
 Q
