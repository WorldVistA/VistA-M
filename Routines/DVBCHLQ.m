DVBCHLQ ;ALB/JLU-Processing HL7 Query message 1 of 2 routines ;1/28/93
 ;;2.7;AMIE;;Apr 10, 1995
BEG ;Main entry point for this routine.
 D START
 D CHKIND:'$D(DVBCERR)
 D QRD:'$D(DVBCERR)
 D ACK
 D EXIT
 Q
 ;
EXIT K DFN,DVBC,DVBC1,DVBCARY,DVBCERR,DVBCEXAM,DVBCEXTY,DVBCNT,DVBCNT1,DVBCPDFN,DVBCQRD,DVBCRDFN,DVBCRQDT,DVBCSRX,DVBCSSN,VADM,VAERR,DVBCSEG
 Q
 ;
START ;This subroutine will check the segment type for QRD
 K DVBCERR
 S DVBCSEG=4,DVBCNT=0
 S DVBCARY=^HL(772,HLDA,"IN",2,0)
 S DVBCQRD=DVBCARY ;using naked from start+3
 I $P(DVBCQRD,HLFS,1)'="QRD" S DVBCERR="Invalid Segment Type" Q
 Q
 ;
CHKIND ;Checking for the requestor's DUZ
 I $S('$D(HLDUZ):1,HLDUZ']"":1,1:0) S DVBCERR="Not a valid DHCP user number."
 Q
 ;
QRD ;This subroutine is to break apart the QRD segment of a query
 S DVBCNT1=$P($P(DVBCQRD,HLFS,8),$E(HLECH),1) ;gets the max number to return
 S:$P(DVBCQRD,HLFS,11)="PATIENT" DVBCSSN=$P(DVBCQRD,HLFS,9)
 DO
 .I '$D(DVBCSSN) S DVBCERR="Invalid Patient ID, No SSN" Q  ;undefined ssn
 .I (DVBCSSN'?9N),(DVBCSSN'?9N1A),(DVBCSSN'?1A4N) S DVBCERR="Invalid Patient ID, Wrong SSN Format" Q  ;ssn format
 .D SSN
 .Q
 Q
 ;
SSN ;Checking the existence of the patient with ssn
 S:$E(DVBCSSN)?1L DVBCSSN=$C($A($E(DVBCSSN))-32)_$E(DVBCSSN,2,5) ;lower to uppercase letter
 S DVBCSRX=$S(DVBCSSN?1U4N:"BS5",1:"SSN") ;getting correct x-ref
 I $L(DVBCSSN)=10 S:$E(DVBCSSN,10,10)?1L DVBCSSN=$E(DVBCSSN,1,9)_$C($A($E(DVBCSSN,10,10))-32) ;lowercase to uppercase
 S DVBCPDFN=$O(^DPT(DVBCSRX,DVBCSSN,0))
 DO
 .I 'DVBCPDFN S DVBCERR="Invalid Patient Identifier" Q
 .I $O(^DPT(DVBCSRX,DVBCSSN,DVBCPDFN)) S DVBCERR="Ambiguous Patient identifier" Q
 .S DVBCRDFN=$O(^DVB(396.3,"B",DVBCPDFN,0))
 .I 'DVBCRDFN S DVBCERR="No 2507 request on file for this Patient" Q
 .K VADM,VAERR S DFN=DVBCPDFN D DEM^VADPT I VAERR S DVBCERR="Invalid Patient Identifier" Q
 .I VADM(1)']"" S DVBCERR="Invalid Patient identifier" Q
 .D CHKREQ
 .Q
 Q
 ;
CHKREQ ;Checks for an open exam
 N ENTRY1,DVBCEXN,DVBCSTAT
 F DVBCEXN=0:0 S DVBCEXN=$O(^DVB(396.4,"APS",DVBCPDFN,DVBCEXN)) Q:'DVBCEXN!(DVBCNT=DVBCNT1)  D
 .S (DVBCEXAM,DVBCSTAT)=""
 .F  S DVBCSTAT=$O(^DVB(396.4,"APS",DVBCPDFN,DVBCEXN,DVBCSTAT)) Q:DVBCSTAT=""  D
 ..I DVBCSTAT="O" S DVBCEXAM=$O(^DVB(396.4,"APS",DVBCPDFN,DVBCEXN,DVBCSTAT,DVBCEXAM)) D
 ...S ENTRY1=$P(^DVB(396.4,DVBCEXAM,0),"^",2)
 ...I "PS"]$P(^DVB(396.3,ENTRY1,0),"^",18) D SET
 I 'DVBCNT S DVBCERR="No Exams or Open Exams on file for this Patient"
 Q
 ;
ACK ;builds new QRD and MSA to send back to requestor
 S:'$D(DVBCERR) $P(HLSDATA(1),HLFS,9)="ORF"
 I $D(DVBCERR) S DVBC=HLSDATA(1) K HLSDATA S HLSDATA(1)=DVBC
 S HLSDATA(2)="MSA"_HLFS_$S($D(DVBCERR):"AE",1:"AA")_HLFS_HLMID_$S($D(DVBCERR):HLFS_DVBCERR,1:"")
 S HLSDATA(3)=DVBCQRD
 S $P(HLSDATA(3),HLFS,8)=DVBCNT_$E(HLECH)_"RD"
 I $D(HLTRANS) D EN1^HLTRANS
 Q
 ;
SET ;calls the subroutines to set PID and OBR
 S DVBCRDFN=$P(^DVB(396.4,DVBCEXAM,0),U,2)
 S DVBCRQDT=$P(^DVB(396.3,DVBCRDFN,0),U,2)
 S DVBCEXTY=$P(^DVB(396.6,DVBCEXN,0),U,1) ;gets exam type
 D PID^DVBCHLUT
 K DVBCPLCR ; this is an OBR filler for the next line
 D OBR^DVBCHLUT
 S DVBCNT=DVBCNT+1
 Q
