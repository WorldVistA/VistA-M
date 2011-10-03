DGRUGA01 ;ALB/GRR - HL7 ADT A01 MESSAGE BUILDER ; 11/27/07 1:43pm
 ;;5.3;Registration;**190,303,762**;Aug 13, 1993;Build 3
 ;
 ;This routine will build a ADT A01 (Admit) HL7 message for an inpatient.
 ;
EN(DFN,DGMIEN,DGARRAY) ;Entry point of routine
 ;DFN - Patient Internal Entry Number
 ;DGMIEN - Patient Movement Internal Entry Number
 ;DGARRAY - Name of output array by reference where built message will be contained.
 ;
 ;The HL7 variables must be initialized before calling this routine!
 ;HL("FS"),HL("ECH"),HLFS,HLECH, and HLQ are used by segment builders called by this routine
 ;
 N DGPV1,DGHOLD,DGCNT,DGMDT,DGCDT,DGOADT,DGZEL,DGICD,DGICDCNT,DGIN,DGIN1,DGRB,DGW,DGINCNT S DGCNT=0
 Q:DGARRAY=""  ;Required output variable name was not passed
 K @DGARRAY ;Kill output array to insure erroneous data does not exist
 Q:DGMIEN=""
 S DGMDT=$$GET1^DIQ(405,DGMIEN,".01","I")
 D NOW^%DTC S DGCDT=$$HLDATE^HLFNC(%) ;Get current date/time and convert to HL7 format
 S DGCNT=DGCNT+1 ;Increment node counter by one for first segment
 S @DGARRAY@(DGCNT)=$$EVN^VAFHLEVN("A01","05",DGMDT) ;Create Event segment and store in output array
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFCPID(DFN,",2,5,7,8,10,11,13,16,17,19,23,29",1) ;Create PID segment using segment sequence numbers passed and store in output array
 S DGHOLD=$$EN^VAFHLNK1(DFN,DGMIEN,",2,3,4,5,") ;Create the NK1 segment using the segment sequence numbers passed, and store in output array
 I DGHOLD]"" S DGCNT=DGCNT+1,@DGARRAY@(DGCNT)=DGHOLD
 S DGCNT=DGCNT+1 ;Increment node counter by one to store next segment
 S DGPV1=$$IN^VAFHLPV1(DFN,DGMDT,",2,3,6,7,10,17,44,",$G(DGMIEN),"","") ;Create the PV1 segment based on sequence numbers passed, and store in output array
 S DGOADT=$$CKADMIT^DGRUUTL1(DFN) ;Check if integrated site and get original admit date
 ;Check if doing data seed of RAI/MDS machine
 I $G(DGSEED)=1 D
 .N VAIP,DGPCPNM,DGPCPPTR,DGWPTR,DGRBPTR,DGWTRAN,DGRBTRAN
 .D IN5^VADPT
 .;Put current Primary Care Physician into PV1 segment
 .S DGPCPPTR=+$G(VAIP(7))
 .S DGPCPNM=$$HLNAME^HLFNC($P($G(VAIP(7)),"^",2))
 .S:DGPCPNM="" DGPCPNM=HL("Q")
 .S $P(DGPV1,HL("FS"),8)=DGPCPPTR_$E(HL("ECH"))_DGPCPNM
 .K ATTDOC S ATTDOC=$$ATTDOC^DGRUUTL(.ATTDOC) S $P(DGPV1,HL("FS"),18)=ATTDOC K ATTDOC ; P-762
 .;Get current ward & room/bed
 .S DGW=$$GET1^DIQ(2,DFN,.1,"I")
 .S DGRB=$$GET1^DIQ(2,DFN,.101,"I")
 .;Convert ward & room/bed to pointers
 .S DGWPTR=$$FIND1^DIC(42,,"XQ",DGW)
 .S DGRBPTR=$$FIND1^DIC(405.4,,"XQ",DGRB)
 .;Translate ward & room/bed
 .S DGWTRAN=$$WARDTRAN^DGRUUTL1(DGWPTR,DGW)
 .S DGRBTRAN=$$RBTRAN^DGRUUTL1(DGRBPTR,DGRB)
 .;Put translated ward & room/bed into PV1 segment
 .S $P(DGPV1,HL("FS"),4)=DGWTRAN_$E(HL("ECH"))_$P(DGRBTRAN,"-")_$E(HL("ECH"))_$P(DGRBTRAN,"-",2)
 I DGOADT]"" S $P(DGPV1,HL("FS"),45)=$$HLDATE^HLFNC(DGOADT) S $P(@DGARRAY@(1),HL("FS"),7)=$$HLDATE^HLFNC(DGOADT)
 S DGPV1=$$DOCID^DGRUUTL(DGPV1)
 K ATTDOC S ATTDOC=$$ATTDOC^DGRUUTL(.ATTDOC) S $P(DGPV1,HL("FS"),18)=ATTDOC K ATTDOC ; P-762
 ;TRANSLATE WARD AND ROOM-BED NAMES IF NEEDED (ALREADY DONE IF SEEDING)
 S:'$G(DGSEED) DGPV1=$$LOCTRAN^DGRUUTL1(DGPV1)
 S @DGARRAY@(DGCNT)=DGPV1
 S DGCNT=DGCNT+1 ;Increment node counter to store next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFHLPV2(DFN,DGMIEN,",3,") ;Create PV2 segment
 D IN^VAFHLDG1(DFN,DGMIEN,",2,3,5,","DGICD",DGMDT) ;Create the DG1 segment(s) and store in a temporary array
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
 Q
