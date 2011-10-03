DGRUGA08 ;ALB/GRR - HL7 ADT A08 MESSAGE BUILDER ; 10/11/07 9:24am
 ;;5.3;Registration;**190,312,328,721,762**;Aug 13, 1993;Build 3
 ;
 ;This routine will build a ADT A08 (Patient Update) HL7 message for an inpatient.
 ;
EN(DFN,DGMIEN,DGARRAY,DGDC,DGSSNC) ;Entry point of routine
 ;DFN - Patient Internal Entry Number
 ;DGMIEN - Patient Movement Internal Entry Number
 ;DGARRAY - Name of output array by reference where built message will be contained.
 ;DGDC - date type~prior date (date type is A, T, or D) (Required for date change only) [Optional]
 ;DGSSNC - Prior SSN (Required for SSN Change only) [Optional]
 ;
 ;The HL7 variables must be initialized before calling this routine!
 ;HL("FS"),HL("ECH"),HLFS,HLECH, and HLQ are used by segment builders called by this routine
 ;
 N DGPV1,DGHOLD,DGCNT,DGMDT,DGCDT,DGOADT,DGIN1,DGLMT,DGZEL,DGICD,DGICDCNT,DGIN,DGINCNT S DGCNT=0
 Q:DGARRAY=""  ;Required output variable name was not passed
 K @DGARRAY ;Kill output array to insure erroneous data does not exist
 I DGMIEN="" N VAIP D NOW^%DTC S VAIP("D")=% D IN5^VADPT S DGMIEN=$G(VAIP(1)) K VAIP Q:DGMIEN=""  ;changed p-328
 D NOW^%DTC S DGCDT=$$HLDATE^HLFNC(%) ;Get current date/time and convert to HL7 format
 S DGMDT=$$GET1^DIQ(405,DGMIEN,".01","I")
 S DGCNT=DGCNT+1 ;Increment node counter by one for first segment
 S @DGARRAY@(DGCNT)=$$EVN^VAFHLEVN("A08","05",DGMDT) ;Create Event segment and store in output array
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFCPID(DFN,",2,5,7,8,10,11,13,16,17,19,23,29",1) ;Create PID segment using segment sequence numbers passed and store in output array
 S DGHOLD=$$EN^VAFHLNK1(DFN,DGMIEN,",2,3,4,5,") ;Create the NK1 segment using the segment sequence numbers passed, and store in output array
 I DGHOLD]"" S DGCNT=DGCNT+1,@DGARRAY@(DGCNT)=DGHOLD
 S DGCNT=DGCNT+1 ;Increment node counter by one to store next segment
 S DGPV1=$$IN^VAFHLPV1(DFN,DGMDT,",2,3,6,7,10,17,44,45,",DGMIEN,"","") ;Create the PV1 segment based on sequence numbers passed
 S DGOADT=$$CKADMIT^DGRUUTL1(DFN) ;check if integrated site get original admit date/time
 I DGOADT]"" S $P(DGPV1,HL("FS"),45)=$$HLDATE^HLFNC(DGOADT)
 S DGPV1=$$DOCID^DGRUUTL(DGPV1)
 I $G(DGLMT)=1,$E($G(DGDC))="D" S $P(DGPV1,HL("FS"),4)=$P(DGPV1,HL("FS"),7) ;This is a change to a prior HL7, move prior location to current
 N VAIP D IN5^VADPT S $P(DGPV1,HL("FS"),11)=$$GET1^DIQ(45.7,+VAIP(8),1,"I") K VAIP ; p-721
 K ATTDOC S ATTDOC=$$ATTDOC^DGRUUTL(.ATTDOC) S $P(DGPV1,HL("FS"),18)=ATTDOC K ATTDOC ; P-762
 S @DGARRAY@(DGCNT)=$$LOCTRAN^DGRUUTL1(DGPV1)
 S DGCNT=DGCNT+1 ;Increment node counter to store next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFHLPV2(DFN,DGMIEN,",3,") ;Create PV2 segment
 D IN^VAFHLDG1(DFN,DGMIEN,",2,3,5,","DGICD") ;Create the DG1 segment(s) and store in a temporary array
 I $O(DGICD(0))>0 D  ;DG1 segment were built
 .S DGICDCNT=0 F  S DGICDCNT=$O(DGICD(DGICDCNT)) Q:DGICDCNT=""  S DGCNT=DGCNT+1,@DGARRAY@(DGCNT)=DGICD(DGICDCNT,0) ;Loop through temporary array and store DG1 segment(s) in output array
 S DGIN1=$$IN1^DGRUUTL1(DFN)
 S DGCNT=DGCNT+1,@DGARRAY@(DGCNT)=DGIN1
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFHLIN2(DFN,DGMIEN,",2,3,6,8,") ;Create and store IN2 segment in output array
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S DGZEL=$$EN^VAFHLZEL(DFN,",1,8,",1) ;Create ZEL segment (only primary eligibility - param 3 = 1)
 I $P(DGZEL,HL("FS"),9)'=0&($P(DGZEL,HL("FS"),9)'=1) S $P(DGZEL,HL("FS"),9)=1 ;stuff patient as veteran
 S @DGARRAY@(DGCNT)=DGZEL
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFHLZEM(DFN,",1,5,",1,1) ;Create ZEM segment for Patient (param 3 = 1)
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFHLZEN(DFN,",1,9,",1,"",HL("FS")) ;Create ZEN segment and add to message array
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFHLZMH(DFN,DGMIEN,",4,") ;Create the ZMH segment and store in the output array
 S DGDC=$G(DGDC),DGSSNC=$G(DGSSNC)
 I DGDC]""!(DGSSNC]"") D  ;date or ssn change
 .I DGDC]""&'("ADT"[$E(DGDC)) Q
 .S DGCNT=DGCNT+1
 .S @DGARRAY@(DGCNT)=$$EN^DGRUGZDC(DFN,DGDC,DGSSNC,DGMDT)
 Q
