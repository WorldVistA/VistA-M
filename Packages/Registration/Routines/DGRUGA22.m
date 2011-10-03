DGRUGA22 ;ALB/GRR - HL7 ADT A22 MESSAGE BUILDER ; 11/7/07 3:45pm
 ;;5.3;Registration;**190,762**;Aug 13, 1993;Build 3
 ;
 ;This routine will build a ADT A22 (From Leave of Absence) HL7 message for an inpatient.
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
 K @DGARRAY ;Kill output array to insure erroneous data does not exist
 Q:DGMIEN=""
 S DGMDT=$$GET1^DIQ(405,DGMIEN,".01","I")
 D NOW^%DTC S DGCDT=$$HLDATE^HLFNC(%) ;Get current date/time and convert to HL7 format
 S DGCNT=DGCNT+1 ;Increment node counter by one for first segment
 S @DGARRAY@(DGCNT)=$$EVN^VAFHLEVN("A22","05",DGMDT) ;Create Event segment and store in output array
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFCPID(DFN,",2,5,7,8,10,11,13,16,17,19,23,29",1) ;Create PID segment using segment sequence numbers passed and store in output array
 S DGMDT=$$GET1^DIQ(405,DGMIEN,".01","I") ;Retrieve Movement Date/Time
 S DGCNT=DGCNT+1 ;Increment node counter by one to store next segment
 S DGPV1=$$IN^VAFHLPV1(DFN,DGMDT,",2,3,6,7,10,17,44,",$G(DGMIEN),"","") ;Create the PV1 segment based on sequence numbers passed
 S DGOADT=$$CKADMIT^DGRUUTL1(DFN) ;check if integrated site get original admit date/time
 I DGOADT]"" S $P(DGPV1,HL("FS"),45)=$$HLDATE^HLFNC(DGOADT)
 S DGPV1=$$DOCID^DGRUUTL(DGPV1)
 N VAIP,DGW,DGRM D IN5^VADPT S DGW=$P(VAIP(5),"^",2),DGRM=$P(VAIP(6),"^",2),$P(DGPV1,HL("FS"),4)=DGW_$E(HLECH)_DGRM K VAIP ; P-762
 S @DGARRAY@(DGCNT)=$$LOCTRAN^DGRUUTL1(DGPV1) ;Translate Ward and Room-Bed name, store into array
 S DGMTYP=$$GET1^DIQ(405,DGMIEN,.18,"I") ;Get Movement Type
 I DGMTYP=14!(DGMTYP=41) S $P(@DGARRAY@(DGCNT),HL("FS"),41)="H" ;If From ASIH flag bed status field as 'H'
 Q
