DVBAREQ1 ;ALB/GTS-557/THM-AMIE NEW REQUESTS; 21 JUL 89@0128
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 D INIT
 S DVBSEL=$$SELECT^DVBAUTL5("Date Range","7131 Request")
 I DVBSEL="D" D BYDATE
 I DVBSEL="N" D BYNAME
 D KILL^DVBAREQS
 Q
 ;
BYDATE ;Selection by the date like old way
 F  DO  Q:DVBOUT
 .S DVBSTOP=0,DVBOUT=0
 .D KILL1^DVBAREQS
 .D LINE
 .D REMOTE
 .I DVBOUT Q
 .D DATE
 .I DVBOUT Q
 .S DVBVER=$$VERSION^DVBAREQS()
 .I DVBVER=0 S DVBOUT=1 Q
 .I DVBVER="S" D ^DVBAREQS Q
 .D DEVICE
 .I DVBOUT!(DVBSTOP) Q
 .I DVBVER="L" DO
 ..D GO
 ..D EXIT
 ..Q
 .Q
 Q
 ;
BYNAME ;Selection by patient name
 F  DO  Q:DVBOUT
 .S DVBSTOP=0,DVBOUT=0
 .D KILL1^DVBAREQS
 .D LINE
 .S DVBDA=$$PAT^DVBAUTL5(7131)
 .S XDIV="ALL"
 .I DVBDA<0!('DVBDA) S DVBOUT=1 Q
 .S DVBVER=$$VERSION^DVBAREQS()
 .I DVBVER=0 S DVBOUT=1 Q
 .I DVBVER="S" DO
 ..S DA=DVBDA
 ..D NAME^DVBAREQS
 ..Q
 .I DVBVER="L" DO
 ..S DVBDA=+DVBDA
 ..S (BDT,EDT)=""
 ..D DEVICE
 ..I DVBOUT!(DVBSTOP) Q
 ..S QQ=1,NODTA=0,DA=+DVBDA U IO
 ..D PRINT^DVBAREQ3
 ..D EXIT
 ..Q
 .Q
 Q
 ;
LINE ;LINE FEED
 S VAR(1,0)="0,0,0,3,0^"
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
 ;
REMOTE ;Get remote site name from user
 S XDIV=""
 S VAR(1,0)="0,0,0,2,0^"
 D WR^DVBAUTL4("VAR")
 K VAR
 S DIC("A")="For REMOTE SITE (Press RETURN for all sites) : ",DIC(0)="AEQM",DIC="^DG(40.8,"
 D ^DIC
 I $D(DTOUT)!(X=U) S DVBOUT=1 Q
 I +Y>0 S XDIV=+Y
ASK I +Y<0 DO
 .S DIR(0)="YA"
 .S DIR("A")="Are you sure you want ALL REMOTE SITES: "
 .S DIR("B")="NO"
 .S DIR("?")="Enter Y to get all remote sites N for just one"
 .D ^DIR
 .I $D(DTOUT)!($D(DUOUT)) S DVBOUT=1 Q
 .I Y=1 S XDIV="ALL"
 .I Y=0 S VAR=1
 .Q
 I $D(VAR) G REMOTE
 K VAR,DIR
 Q
 ;
DATE ;Gets beginning and ending dates from user
 S VAR(1,0)="0,0,0,1,0^"
 D WR^DVBAUTL4("VAR")
 K VAR
 S %DT(0)=-DT,%DT("A")="BEGINNING date: ",%DT="AE"
 D ^%DT
 I X="^"!(Y=-1) S DVBOUT=1 Q
 S BDT=Y
 S %DT("A")="   ENDING date: "
 D ^%DT
 I X="^"!(Y=-1) S DVBOUT=1 Q
 S EDT=Y_".2359"
 I EDT<BDT DO  G DATE
 .S VAR(1,0)="1,0,0,2:2,0^Invalid dates!  Ending must not be before beginning."
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .D PAUSE^DVBCUTL4
 .Q
 K %DT
 Q
 ;
GO D STM^DVBCUTL4
 S QQ=1,NODTA=0 U IO
 ;
DATA S MA=BDT-.5 F J=0:0 S MA=$O(^DVB(396,"AE",MA)) Q:MA>EDT!(MA="")  S:XDIV'="ALL" LPDIV=+XDIV-1 S:XDIV="ALL" LPDIV="" DO LOOPDIV
 D EXIT
 Q
 ;
LOOPDIV ;** Loop through Division - 'AE' X-ref
 F LPVAR=0:0 S LPDIV=$O(^DVB(396,"AE",MA,LPDIV)) Q:(LPDIV=""!(XDIV'="ALL"&(XDIV'=LPDIV)))  D LOOPDA
 K LPVAR
 Q
 ;
LOOPDA ;** Loop through DA - 'AE' X-ref
 F DA=0:0 S DA=$O(^DVB(396,"AE",MA,LPDIV,DA)) Q:DA=""  DO
 .I $D(DVBATASK) D:'$D(^TMP($J,LPDIV,DA)) PRINT^DVBAREQ3 S QQ=1
 .I '$D(DVBATASK) D:'$D(^TMP($J,DA)) PRINT^DVBAREQ3 S QQ=1
 Q
 ;
EXIT I NODTA=0 DO
 .U IO
 .I IOST?1"C-".E S VAR(1,0)="0,0,0,0,1^" D WR^DVBAUTL4("VAR") K VAR
 .S VAR(1,0)="0,0,0,3,0^Notice to MAS on "_FDT(0)
 .S VAR(2,0)="0,0,0,1,0^There were no new 7131 requests"
 .S VAR(3,0)="0,0,0,1:3,0^"_$S(XDIV'="ALL":"for "_$P(^DG(40.8,XDIV,0),U,1)_" ",1:"")
 .I BDT]"" DO
 ..S Y=$P(BDT,".",1)
 ..X ^DD("DD")
 ..S VAR(3,0)=VAR(3,0)_"from "_Y_" to "
 ..S Y=$P(EDT,".",1)
 ..X ^DD("DD")
 ..S VAR(3,0)=VAR(3,0)_Y
 ..Q
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .Q
 D ^%ZISC
 Q
 ;
TASK S X="T-1" D ^%DT S BDT=Y
 S X="T-1" D ^%DT S EDT=Y_".2359"
 S Y=DT X ^DD("DD") S FDT(0)=Y
 D NOPARM^DVBAUTL2
 I $D(DVBAQUIT) D KILL^DVBAREQS Q
 S DVBSEL="D",DVBATASK=""
 S HOSP=$$SITE^DVBCUTL4
 F ZI=0:0 S ZI=$O(^DVB(396.1,1,2,"B",ZI)) Q:ZI=""  F ZJ=0:0 S ZJ=$O(^DVB(396.1,1,2,"B",ZI,ZJ)) Q:ZJ=""  D CLIN
 D KILL^DVBAREQS
 Q
 ;
DEQUE Q:'$D(XDIV)
 I DVBSEL="D" D GO
 I DVBSEL="N" DO
 .S DA=DVBDA,QQ=1,NODTA=0
 .D PRINT^DVBAREQ3
 .D EXIT
 .Q
 D KILL^DVBAREQS
 Q
 ;
CLIN ;Logic not changed, it is the original - needs to be
 ;looked at for efficiency
 S XDIV=ZI,ZTRTN="GO^DVBAREQ1",ZTIO=$P(^DVB(396.1,1,2,ZJ,0),U,2),ZTDESC="AMIE New Req for "_$S($D(^DG(40.8,XDIV,0)):$P(^(0),U,1),1:"Unknown")
 F I="DVBATASK","DVBSEL","FDT(0)","XDIV","BDT","EDT","HOSP" S ZTSAVE(I)=""
 S ZTDTH=$H D ^%ZTLOAD
 Q
 ;
INIT ;Initialize variables
 S DVBOUT=0
 D NOPARM^DVBAUTL2
 I $D(DVBAQUIT) S DVBOUT=1
 D HOME^%ZIS
 D HDR
 S DVBAMAN=""
 S HOSP=$$SITE^DVBCUTL4
 S Y=DT X ^DD("DD") S FDT(0)=Y
 K NOASK
 Q
 ;
HDR ;Writes header info
 S VAR(1,0)="0,0,0,1:3,1^AMIE New Request Report"
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
 ;
DEVICE ;Get device to print to
 S VAR(1,0)="0,0,0,1,0^"
 D WR^DVBAUTL4("VAR")
 K VAR
 S %ZIS="Q"
 D ^%ZIS
 K %ZIS
 I POP S DVBOUT=1 Q
 I $D(IO("Q")) DO
 .S NOASK=1,DVBSTOP=1
 .S ZTRTN="DEQUE^DVBAREQ1"
 .S ZTIO=ION,ZTDESC="Amie new request rpt"
 .F I="DVBSEL","DVBDA","FDT(0)","XDIV","BDT","EDT","VER","NOASK","HOSP","DVBAMAN" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .D ^%ZISC
 .I $D(ZTSK) DO
 ..S VAR(1,0)="0,0,0,2:2,0^Request queued."
 ..D WR^DVBAUTL4("VAR")
 ..K VAR
 ..Q
 .Q
