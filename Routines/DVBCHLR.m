DVBCHLR ;ALB/JLU-Processes the results from the ORU ;1/28/93
 ;;2.7;AMIE;**9**;Apr 10, 1995
 ;
BEG D INIT
 F  D @$S(DVBCX="PID"&'$D(HLERR):"PID",DVBCX="OBR"&'$D(HLERR):"OBR",DVBCX="OBX"&'$D(HLERR):"OBX",1:"ACK") Q:DVBCX="QUIT"
 D EXIT
 Q
 ;
EXIT K %,DA,DFN,DIE,DR,DVBC,HLERR,DVBCNT2,DVBCOBR,DVBCOBX,DVBCOBXV,DVBCPAT,DVBCPDFN,DVBCPID,DVBCRPDT,DVBCSAV,DVBCSSN,DVBCUEX,DVBCUEXT,DVBCUNIV,DVBCURQ,DVBCX,DVBCX1,DVBX,VADM,VAERR,DVBCEXAM,DVBCST,DVBCELCT,DVBCUEX1
 Q
 ;
INIT ;initializes and checks variables
 S DVBCX="PID",DVBC=1
 I '$D(HLESIG) S HLERR="No Electronic Signature code present, updating cannot be allowed."
 I $S('$D(HLDUZ):1,HLDUZ']"":1,1:0) S HLERR="Not a valid DHCP user number."
 Q
 ;
PID ;Brake apart the PID section
 K HLERR,DVBCPID,DVBCSSN,DVBCPDFN,DVBCPAT,DFN,VAERR,VADM
 S DVBC=$O(^HL(772,HLDA,"IN",DVBC))
 I 'DVBC S HLERR="Missing PID Segment" Q
 S DVBCPID=^(DVBC,0) ;NAKE FROM ^HL(772,HLDA,IN  PID+2
 I $P(DVBCPID,HLFS,1)'="PID" S HLERR="Incorrect PID Segment indicator" Q
 I $P(DVBCPID,HLFS,4)']"" S HLERR="Internal Patient ID Missing" Q
 I $P(DVBCPID,HLFS,6)']"" S HLERR="Patient Name Invalid" Q
 I $P(DVBCPID,HLFS,20)']"" S HLERR="Patient SSN Invalid" Q
 S DVBCSSN=$P(DVBCPID,HLFS,20)
 S DVBCPDFN=+$P(DVBCPID,HLFS,4)
 S DVBCPAT=$$FMNAME^HLFNC($P(DVBCPID,HLFS,6))
 S DFN=DVBCPDFN
 D DEM^VADPT
 I VAERR S HLERR="Incorrect Patient Identifier" Q
 I DVBCSSN'=$P(VADM(2),U,1) S HLERR="Invalid SSN" Q
 S DVBCX="OBR"
 Q
 ;
OBR ;Parsing the OBR segment.
 K DVBCOBR,DVBCUNIV
 F  S DVBC=$O(^HL(772,HLDA,"IN",DVBC)) Q:DVBC=""  S DVBCOBR=^(DVBC,0) Q:$P(DVBCOBR,HLFS,1)="OBR"
 I DVBC="" S HLERR="Missing OBR Segment" Q
 I $P(DVBCOBR,HLFS,5)']"" S HLERR="Missing Universal Identifier" Q
 I $P(DVBCOBR,HLFS,21)']"" S HLERR="Missing Exam Type" Q
 I $P(DVBCOBR,HLFS,23)']"" S HLERR="Missing Report Date" Q
 S DVBCUNIV=$P(DVBCOBR,HLFS,5)
 S DVBCUEXT=$P(DVBCOBR,HLFS,21)
 S DVBCRPDT=$$FMDATE^HLFNC($P(DVBCOBR,HLFS,23))
 S DVBCURQ=$P(DVBCUNIV,$E(HLECH),1)
 S DVBCUEX=$P(DVBCUNIV,$E(HLECH),2)
 I '$D(^DVB(396.3,DVBCURQ,0)) S HLERR="Request No longer Exists" Q
 I "PS"'[$P(^(0),U,18) S HLERR="Status of Request will not allow for down loading" Q  ;NAKED FROM LINE BEFORE
 I '$D(^DVB(396.4,DVBCUEX,0)) S HLERR="Exam No longer Exists" Q
 S DVBCUEX1=^DVB(396.4,DVBCUEX,0)
 I "RXT"[$P(DVBCUEX1,U,4) S HLERR="Exam status not open, no down loading allow* ed" Q
 D HASH^DVBCHLUT
 I '$D(DVBCELCT) S HLERR="Bad electronic signature code." Q
 I $P(DVBCUEX1,U,4)="C",$P(DVBCUEX1,U,10)'=DVBCELCT S HLERR="Electronic signature codes do not match, no down loading allowed" Q
 S DVBCX="OBX"
 Q
 ;
OBX ;looping through the OBX segment
 K DVBCSAV
 S DVBCNT2=0,DVBCSAV=DVBC
 I '$$LOCK^DVBCHLUT(DVBCURQ,DVBCUEX) Q
 D DEL
 F  S DVBC=$O(^HL(772,HLDA,"IN",DVBC)) S:DVBC="" DVBCX="ACK" Q:DVBC=""  S DVBCOBX=^(DVBC,0) D OBX1 Q:DVBCX'="OBX"  S DVBCSAV=DVBC
 S DVBC=DVBCSAV
 I 'DVBCNT2 S HLERR="Invalid OBX Segment" D UNLOCK^DVBCHLUT(DVBCURQ,DVBCUEX) Q
 I DVBCNT2 D CLOSE
 D UNLOCK^DVBCHLUT(DVBCURQ,DVBCUEX)
 Q
 ;
OBX1 ;
 S DVBCOBXV=$P(DVBCOBX,HLFS,1)
 I DVBCOBXV="NTE" Q
 I $S(DVBCOBXV="PID":1,DVBCOBXV="OBR":1,1:0) S DVBCX=DVBCOBXV Q
 I DVBCOBXV'="OBX" S DVBCX="ACK" Q
 S DVBCNT2=DVBCNT2+1
 S ^DVB(396.4,DVBCUEX,"RES",DVBCNT2,0)=$P(DVBCOBX,HLFS,6)
 Q
 ;
CLOSE ;sets exam fields and quits
 D NOW^%DTC
 S ^DVB(396.4,DVBCUEX,"RES",0)="^^"_DVBCNT2_"^"_DVBCNT2_"^"_%
 S DIE="^DVB(396.4,",DA=DVBCUEX
 S DR=".04///C;.06///^S X=DVBCRPDT;.07///^S X=$P(^VA(200,HLDUZ,0),U,1);.1///^S X=DVBCELCT"
 D ^DIE
 S DVBCEXAM=^DVB(396.4,DVBCUEX,0)
 I $P(DVBCEXAM,U,4)'="C"!($P(DVBCEXAM,U,6)']"")!$P(DVBCEXAM,U,7)']"" S HLERR="Results added but request and exam status not updated." Q
 D COMPL
 Q
 ;
ACK ;setting up the acknowledgment segment.
 I $D(HLERR) S DVBCX1=HLSDATA(1) K HLSDATA S HLSDATA(1)=DVBCX1
 S HLSDATA(2)="MSA"_HLFS_$S($D(HLERR):"AE",1:"AA")_HLFS_HLMID_HLFS_$S($D(HLERR):HLERR,1:"")
 S DVBCX="QUIT"
 I $D(HLTRANS) D EN1^HLTRANS
 Q
 ;
COMPL ;This subroutine will search the other exams and set the request's
 ;status to transcribed if able.
 ;This should become a callable subroutine because ^dvbcedit does the same
 ;
 K DVBCOPN
 F DVBC=0:0 S DVBC=$O(^DVB(396.4,"C",DVBCURQ,DVBC)) Q:'DVBC  S DVBCST=$P(^DVB(396.4,DVBC,0),U,4) I DVBCST="O"!(DVBCST="T") S DVBCOPN=1 Q
 Q:$D(DVBCOPN)
 S XMDUZ="Kurzweil"
 S XMB="DVBA C 2507 EXAM READY"
 S XMB(1)=DVBCPAT,XMB(2)=DVBCSSN
 S Y=$P(^DVB(396.3,DVBCURQ,0),U,2)
 X ^DD("DD")
 S XMB(3)=Y
 D ^XMB
 K XMDUZ,XMB,Y
 S DIE="^DVB(396.3,",DA=DVBCURQ
 S DR="11///NOW;17////T"
 D ^DIE
 I $P(^DVB(396.3,DVBCURQ,0),U,12)']""!($P(^(0),U,18)'="T") S HLERR="Results added and exam status updated but request status not updated."
 Q
 ;
DEL ;to delete the results from an exam if it is being resent.
 I $P(DVBCUEX1,U,10)]"" K ^DVB(396.4,DVBCUEX,"RES")
 Q
