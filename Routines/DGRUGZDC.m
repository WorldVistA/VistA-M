DGRUGZDC ;ALB/GRR - HL7 ZDC SEGMENT BUILDER ;06/08/99
 ;;5.3;Registration;**190**;Aug 13, 1993
 ;
 ;This routine will build an HL7 ZDC segment for an inpatient.
 ;
EN(DFN,DGDC,DGSSNC,DGMDT) ;Entry point of routine
 ;DFN - Patient Internal Entry Number
 ;DGDC -Type of date Change~Prior Date
 ;DGSSNC - Prior SSN
 ;DGMDT - Movement Date
 ;DGDC - Type of date change^Prior date
 ;
 S DGMDT=$$HLDATE^HLFNC(DGMDT)
 N DGRREC ;Initialize variables
 S $P(DGRREC,HL("FS"))="ZDC" ;Set segment ID to ZDC
 S $P(DGRREC,HL("FS"),2)=1 ;Set Set ID to 1
 I $G(DGDC)]"" S DGCDT=$P(DGDC,"^",2),DGODT=$$HLDATE^HLFNC(DGCDT) D  ;If date change do the following
 .I $E(DGDC)="A" D  ;If Admit date changed
 ..S $P(DGRREC,HL("FS"),3)=1 ;Set type to 1
 ..S $P(DGRREC,HL("FS"),4)=DGODT ;old date
 ..S $P(DGRREC,HL("FS"),5)=DGMDT ;new date
 .I $E(DGDC)="T" D  ;If Transfer date changed
 ..S $P(DGRREC,HL("FS"),3)=2 ;Set type to 2
 ..S $P(DGRREC,HL("FS"),4)=DGODT ;old date
 ..S $P(DGRREC,HL("FS"),5)=DGMDT ;new date
 .I $E(DGDC)="D" D  ;If Discharge date changed
 ..S $P(DGRREC,HL("FS"),3)=3 ;Set type to 3
 ..S $P(DGRREC,HL("FS"),4)=DGODT ;old date
 ..S $P(DGRREC,HL("FS"),5)=DGMDT ;new date
 I $G(DGSSNC)]"" D  ;If SSN change, do the following
 .S $P(DGRREC,HL("FS"),3)=+$P(DGRREC,HL("FS"),3)+10 ;Set type to current value plus 10.  If date change and SSN, type is 11, 12, or 13.  Will be a 10 for SSN change only
 .S $P(DGRREC,HL("FS"),6)=DGSSNC ;old SSN
 .S SSN=$$GET1^DIQ(2,DFN,.09,"I") ;Get new SSN
 .S $P(DGRREC,HL("FS"),7)=SSN ;Set new SSN in message
EXIT ;
 Q DGRREC  ;Quit and return formatted segment
