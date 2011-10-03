MAGDHLE ;WOIFO/SRR - PACS INTERFACE PID TRIGGERS ; 05/18/2007 11:23
 ;;3.0;IMAGING;**54**;03-July-2009;;Build 1424
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
SET ;Set Logic from MUMPS x-ref on fields .01,.03,.09 of ^DD(2 (^DPT)
 ;Kill logic: S MAGKPID=X for all 3 fields
 ;IN - MAGKPID = old value
 ;   - MAGKTYP = Message type (from field)
 N MAGDPTCL
 Q:'$G(^MAG(2006.1,"APACS"))
 Q
 G EX:'$D(MAGKPID),EX:MAGKPID=X
 S DFN=DA,MAGKTYP=8,MAGDPTCL="Pt. Demo."
 G TSK
 ;
KIL ;Kill logic "AKn" cross references
 Q:'$G(^MAG(2006.1,"APACS"))
 Q
 S MAGKPID=X
 Q
 ;
ADT ;ADT EVENTS ;From EVENT driver
 ;Protocol = MAGK DHCP-PACS ADT EVENTS
 ;IN ;DFN
 ;DGPMDA = IFN Primary Movement
 ;DGPMA = 0th node Primary Movement AFTER movement
 ;DGPMP = 0th node PRIOR to movement
 ;^UTILITY("DGPM",$J,TRANSACTION (1,2,3,6),MOVEMENT (IFN),"P"/"A")
 ;
 K MAGKTYP F I=1,2,3 I $D(^UTILITY("DGPM",$J,I,DGPMDA)) S MAGKTYP=I
 Q:'$D(MAGKTYP)  I MAGKTYP=2,$P(^UTILITY("DGPM",$J,2,DGPMDA,"A"),U,6)=$P(^("P"),U,6) G EX
TSK ;CREATE TASK to make HL7 messages
 S ZTSAVE("MAGKTYP")="",ZTSAVE("MAGDPTCL")=""
 S ZTSAVE("DFN")="",ZTDTH=$H,ZTIO=""
 S ZTRTN="HL7^MAGDHLE",ZTDESC=$S(MAGKTYP=8:"PID",1:"ADT")_" HL7 PACS MESSAGE"
 W !?5,"*** HL7 TASK FOR PACS ***" D ^%ZTLOAD G EX
 ;
HL7 ;Create HL7 message
 Q:'$D(^DPT(DFN,0))
 S N0=^DPT(DFN,0),HLNDAP="PACS GATEWAY",HLMTN="ADT"
 D INIT^HLTRANS
 D EVN,PID,NK1,PV1 K N0,N1 D EN^MAGDHL7T,KILL^HLTRANS
 ;D EN^HLTRANS,KILL^HLTRANS
EX ;EXIT
 K ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE
 K MAGKPID,MAGKTYP
 Q
 ;
EVN ;EVENT SEGMENT
 S HLSDATA(2)="EVN^"_$P($T(ETYP+MAGKTYP),";",3)_"^"_$$HLDATE^HLFNC(DT)
 Q
PID ;PID SEGMENT
 I '$P(N0,U,9) S N0=^DPT(DFN,0)
 S $P(N1,U,1,7)="PID^^^"_$$M11^HLFNC(DFN)_"^^"_$$HLNAME^HLFNC($P(N0,U))_"^^"_$$HLDATE^HLFNC($P(N0,U,3))_"^"_$P(N0,U,2)
 S $P(N1,U,20)=$P(N0,U,9),HLSDATA(3)=N1
 Q
 ;
NK1 ;NEXT OF KIN
 S HLSDATA(4)="NK1^"
 Q
PV1 ;PV1 SEGMENT
 S HLSDATA(5)="PV1^^"_$S($D(^DPT(DFN,.1)):"I",1:"O")_"^"_$G(^DPT(DFN,.1))
 Q
 ;
ETYP ;EVENT TYPE; for later possible use
 ;;A01;ADMIT
 ;;A02;TRANSFER
 ;;A03;DISCHARGE
 ;;A04;REGISTER
 ;;A05;PRE-ADMIT
 ;;A06;TRANSFER OUT/IN
 ;;A07;TRANSFER IN/OUT
 ;;A08;UPDATE PATIENT INFORMATION
 Q
HLDT1 ;TEMP FIX FOR HLTRANS UNDEF
 Q
FIX ;
 Q
