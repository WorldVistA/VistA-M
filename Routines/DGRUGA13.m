DGRUGA13 ;ALB/GRR - HL7 ADT A13 MESSAGE BUILDER ;8/5/99  15:34
 ;;5.3;Registration;**190,312,373**;Aug 13, 1993
 ;
 ;This routine will build a ADT A13 (Cancel Discharge) HL7 message for an inpatient.
 ;
EN(DFN,DGMIEN,DGARRAY) ;Entry point of routine
 ;DFN - Patient Internal Entry Number
 ;DGMIEN - Patient Movement Internal Entry Number
 ;DGARRAY - Name of output array by reference where built message will be contained.
 ;
 ;The HL7 variables must be initialized before calling this routine!
 ;HL("FS"),HL("ECH"),HLFS,HLECH, and HLQ are used by segment builders called by this routine
 ;
 N DGHOLD,DGCNT,DGMDT,DGCDT,DGEDT,DGOADT,DGHMDT,DGCTRAN,DGICD,DGICDCNT,DGIN,DGINCNT,DGPV1 S DGCNT=0
 Q:DGARRAY=""  ;Required output variable name was not passed
 K @DGARRAY ;Kill output array to insure erronuous data does not exist
 Q:DGMIEN=""
 S DGMDT=$$GET1^DIQ(405,DGMIEN,".01","I"),DGHMDT=$$HLDATE^HLFNC(DGMDT)
 D NOW^%DTC S DGCDT=$$HLDATE^HLFNC(%) ;Get current date/time and convert to HL7 format
 S DGEDT=$S($G(DGASIH)=1:+$G(DGPMA),$G(DGASIH)=3:+$G(DGPMP),1:DGMDT) ;If discharge was while ASIH (312), p-373
 S DGCNT=DGCNT+1 ;Increment node counter by one for first segment
 S @DGARRAY@(DGCNT)=$$EVN^VAFHLEVN("A13","05",DGEDT) ;Create Event segment and store in output array (Use current date/time for cancel)
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFCPID(DFN,",2,5,7,8,10,11,13,16,17,19,23,29",1) ;Create PID segment using segment sequence numbers passed and store in output array
 S DGHOLD=$$EN^VAFHLNK1(DFN,DGMIEN,",2,3,4,5,") ;Create the NK1 segment using the segment sequence numbers passed, and store in output array
 I DGHOLD]"" S DGCNT=DGCNT+1,@DGARRAY@(DGCNT)=DGHOLD
 S DGMDT=$$GET1^DIQ(405,DGMIEN,".01","I") ;Retrieve Movement Date/Time
 S DGCNT=DGCNT+1 ;Increment node counter by one to store next segment
 ;; testing SCK
 S DGPV1=$$IN^VAFHLPV1(DFN,DGMDT,",2,3,6,7,10,17,44,45,",$G(DGMIEN),"","")
 S DGOADT=$$CKADMIT^DGRUUTL1(DFN) ;check if integrated site get original admit date/time
 I DGOADT]"" S $P(DGPV1,HL("FS"),45)=$$HLDATE^HLFNC(DGOADT)
 S DGPV1=$$DOCID^DGRUUTL(DGPV1)
 I $G(DGCTRAN)=1 S $P(DGPV1,HL("FS"),4)=$P(DGPV1,HL("FS"),7) ;need to make prior location the current one because changing prior transaction
 S @DGARRAY@(DGCNT)=$$LOCTRAN^DGRUUTL1(DGPV1) ;translate ward, room-bed if needed
 D IN^VAFHLDG1(DFN,DGMIEN,",2,3,5,","DGICD") ;Create the DG1 segment(s) and store in a temporary array
 I $O(DGICD(0))>0 D  ;DG1 segment were built
 .S DGICDCNT=0 F  S DGICDCNT=$O(DGICD(DGICDCNT)) Q:DGICDCNT=""  S DGCNT=DGCNT+1,@DGARRAY@(DGCNT)=DGICD(DGICDCNT,0) ;Loop through temporary array and store DG1 segment(s) in output array
 D EN^VAFHLIN1(DFN,",2,4,12,","",HL("FS"),"DGIN") ;Create IN1 segment(s) and store in temporary array
 I $D(DGIN(1,0)),$P(DGIN(1,0),HL("FS"),5)]"" D  ;IN1 segments were built
 .S DGINCNT=0 F  S DGINCNT=$O(DGIN(DGINCNT)) Q:DGINCNT=""  S DGCNT=DGCNT+1,@DGARRAY@(DGCNT)=DGIN(DGINCNT,0) ;Loop through temporary array and store IN1 segment(s) in output array
 Q
