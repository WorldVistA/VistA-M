DGRUGA03 ;ALB/GRR - HL7 ADT A03 MESSAGE BUILDER ;8/5/99  15:31
 ;;5.3;Registration;**190,312,328,430**;Aug 13, 1993
 ;
 ;This routine will build a ADT A03 (Discharge) HL7 message for an inpatient.
 ;
EN(DFN,DGMIEN,DGARRAY) ;Entry point of routine
 ;DFN - Patient Internal Entry Number
 ;DGMIEN - Patient Movement Internal Entry Number
 ;DGARRAY - Name of output array by reference where built message will be contained.
 ;
 ;The HL7 variables must be initialized before calling this routine!
 ;HL("FS"),HL("ECH"),HLFS,HLECH, and HLQ are used by segment builders called by this routine
 ;
 N DGDT,DGHDT,DGPV1,DGCNT,DGMDT,DGCDT,DGOADT,DGICD,DGICDCNT,DGIN,DGINCNT,DGEDT,DGDEDT S DGCNT=0
 Q:DGARRAY=""  ;Required output variable name was not passed
 K @DGARRAY ;Kill output array to insure erronuous data does not exist
 Q:DGMIEN=""
 N DGADAT ;p-430
 S DGADAT=$P($G(VAIP(13,1)),"^") ;p-430
 I DGADAT]"",$D(^DGRU(46.14,DFN,1,"B",DGADAT)) N DGIEN S DGIEN=$O(^DGRU(46.14,DFN,1,"B",DGADAT,0)) Q:$D(^DGRU(46.14,"AC",DFN,"I",DGIEN))  K DGIEN ;p-430
 K DGADAT ;p-430
 S DGMDT=$$GET1^DIQ(405,DGMIEN,".01","I")
 D NOW^%DTC S DGCDT=$$HLDATE^HLFNC(%) ;Get current date/time and convert to HL7 format
 S DGEDT=$S($G(DGASIH)=1:+$G(DGPMA),1:DGMDT) ;If discharged while ASIH, use discharge date/time (312)
 S DGCNT=DGCNT+1 ;Increment node counter by one for first segment
 S @DGARRAY@(DGCNT)=$$EVN^VAFHLEVN("A03","05",DGEDT) ;Create Event segment and store in output array
 S DGDEDT=$P(@DGARRAY@(1),HL("FS"),7) ;Capture Event Date/Time
 S DGCNT=DGCNT+1 ;Increment node counter by one for next segment
 S @DGARRAY@(DGCNT)=$$EN^VAFCPID(DFN,",2,5,7,8,10,11,13,16,17,19,23,29",1) ;Create PID segment using segment sequence numbers passed and store in output array
 S DGMDT=$S($G(DGASIH)=2:DGMDT,1:$$GET1^DIQ(405,DGMIEN,".01","I")\1) ;Retrieve Movement Date/Time and truncate time
 S DGCNT=DGCNT+1 ;Increment node counter by one to store next segment
 S DGPV1=$$IN^VAFHLPV1(DFN,DGMDT,",2,3,6,7,10,17,36,44,45,",$G(DGMIEN),"","") ;Create the PV1 segment based on sequence numbers passed, and store in output array
 S DGOADT=$$CKADMIT^DGRUUTL1(DFN) ;Check if integrated site and get original admit date/time
 I DGOADT]"" S $P(DGPV1,HL("FS"),45)=$$HLDATE^HLFNC(DGOADT)
 S DGPV1=$$DOCID^DGRUUTL(DGPV1)
 I $P(DGPV1,HL("FS"),46)="""""" D
 .S $P(DGPV1,HL("FS"),4)=$P(DGPV1,HL("FS"),7),$P(DGPV1,HL("FS"),37)=16,$P(DGPV1,HL("FS"),46)=$P(@DGARRAY@(1),HL("FS"),7) ;set discharge type to regular and date to event date
 I $G(DGASIH)=2 D
 .N VAIP,DGPCPNM,DGPCPPTR,DGWPTR,DGWTRAN,DGRBTRAN
 .S VAIP("D")=DGPMDT D IN5^VADPT
 .S DGPCPPTR=+$G(VAIP(18))
 .S DGPCPNM=$$HLNAME^HLFNC($P($G(VAIP(18)),"^",2))
 .S:DGPCPNM="" DGPCPNM=HL("Q")
 .S $P(DGPV1,HL("FS"),8)=DGPCPPTR_$E(HL("ECH"))_DGPCPNM
 .;GET WARD,ROOM,BED
 .S DGW=$P($G(VAIP(5)),"^",2),DGWPTR=$P($G(VAIP(5)),"^")
 .S DGRB=$P($G(VAIP(6)),"^",2),DGRBPTR=$P($G(VAIP(6)),"^")
 .;TRANSLATE WARD AND ROOM-BED
 .S DGWTRAN=$$WARDTRAN^DGRUUTL1(DGWPTR,DGW)
 .S DGRBTRAN=$$RBTRAN^DGRUUTL1(DGRBPTR,DGRB)
 .;PUT INTO PV1 SEGMENT
 .S $P(DGPV1,HL("FS"),4)=DGWTRAN_$E(HL("ECH"))_$P(DGRBTRAN,"-")_$E(HL("ECH"))_$P(DGRBTRAN,"-",2)
 .S $P(DGPV1,HL("FS"),7)=$P(DGPV1,HL("FS"),4)
 .S $P(DGPV1,HL("FS"),46)=$$HLDATE^HLFNC($G(DGEVDT))
 .S @DGARRAY@(DGCNT)=DGPV1
 I $G(DGASIH)=1 S $P(DGPV1,HL("FS"),7)=$P(DGPV1,HL("FS"),4)
 I $G(DGASIH)'=2 S @DGARRAY@(DGCNT)=$$LOCTRAN^DGRUUTL1(DGPV1) ;Translate Ward or Room-Bed name if needed, store into array
 D IN^VAFHLDG1(DFN,DGMIEN,",2,3,5,","DGICD") ;Create DG1 segments if data exist and store in temporary array
 I $O(DGICD(0))>0 D  ;DG1 segments were built
 .S DGICDCNT=0 F  S DGICDCNT=$O(DGICD(DGICDCNT)) Q:DGICDCNT=""  S DGCNT=DGCNT+1,@DGARRAY@(DGCNT)=DGICD(DGICDCNT,0) ;Loop through temporary array and store in output array
 Q
