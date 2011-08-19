DVBCHLOR ;ALB/JLU-Routine to build an order message ;1/28/93
 ;;2.7;AMIE;;Apr 10, 1995
 ;
BEG(DVBCPDFN,DVBCRDFN,DVBCEXAM,DVBCOC,HLDAP) ;
 ;when entering this routine the following variables must be set.
 ;DVBCPDFN - Patient DFN
 ;DVBCRDFN - Request DFN
 ;DVBCEXAM - Exam DFN
 ;DVBCOC   - Order Control "NEW" for a new order or "CANCEL" to cancel
 ;           an order.
 ;HLDAP    - name or IFN of entry in file #771 (the DHCP application)
 ;
 N DVBCERR
 S DVBCERR=1
 D INITIAL
 I '$D(HLERR) D
 .D PID^DVBCHLUT
 .D ORC^DVBCHLUT
 .D OBR^DVBCHLUT
 .Q
 D FILE
 D EXIT
 Q DVBCERR
 ;
INITIAL ;sets up necessary variables
 ;will need HLDAP equal to name or internal entry number in file #771
 D INIT^HLTRANS Q:$D(HLERR)
 S DFN=DVBCPDFN
 D DEM^VADPT
 I VAERR!VADM(1)']"" S HLERR="Invalid Patient name or DFN"
 S DVBCSEG=1,DVBCPLCR=1
 S DVBCRQDT=$P(^DVB(396.3,DVBCRDFN,0),U,2)
 S DVBCEXTY=$P(^DVB(396.4,DVBCEXAM,0),U,3)
 S DVBCEXTY=$P(^DVB(396.6,DVBCEXTY,0),U,1)
 S DVBCOC=$S(DVBCOC="NEW":"NW",DVBCOC="CANCEL":"CA",1:"")
 Q
 ;
FILE ;builds and send the HL7 message
 I '$D(HLERR) S HLMTN="ORM" D EN^HLTRANS
 I $D(HLERR) S DVBCERR=HLERR
 Q
 ;
EXIT ;
 D KILL^HLTRANS
 K HLDA,HLDT,HLDT1,DFN,DVBC1,DVBCOC,DVBCEXTY,DVBCPDFN,DVBCPLCR,DVBCRQDT,DVBCSEG,VA,VADM,VAERR
 Q
