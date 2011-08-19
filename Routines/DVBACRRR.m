DVBACRRR ;ALB/GTS-557/THM-REPRINT 21-DAY CERT FOR THE RO ;21 JUL 89 
 ;;2.7;AMIE;**42**;Apr 10, 1995
 ;
 D INIT
 I CONT=0 G KIL
 D HDR
 S DVBSEL=$$SELECT^DVBAUTL5("ORIGINAL PROCESSING DATE","21 Day Certificate")
 I DVBSEL="D" S SDATE=$$DATE^DVBACRRP G:SDATE<0 KIL
 I DVBSEL="N" S XDA=$$PAT^DVBAUTL5("RO") G:XDA<1 KIL
 I DVBSEL=0 G KIL
 I 'CONT G KIL
 D DEVICE
 I 'CONT G KIL
 D DATA
KIL D KILL
 Q
 ;
DEVICE ;
 S VAR(1,0)="0,0,0,2:0,0^"
 D WR^DVBAUTL4("VAR")
 K VAR
 S %ZIS="AEQ"
 D ^%ZIS
 K %ZIS
 I POP S CONT=0 Q
 I $D(IO("Q")) DO
 .S CONT=0
 .S ZTIO=ION,ZTDESC="21-day Cert reprint",ZTRTN="DATA^DVBACRRR"
 .F I="DVBSEL","XDA","DVBAD2","FDT(0)","HD","HD1","SDATE","NODTA" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .D ^%ZISC
 .I $D(ZTSK) DO
 ..S VAR(1,0)="0,0,0,2:2,0^Request queued."
 ..D WR^DVBAUTL4("VAR")
 ..K VAR
 ..Q
 .Q
 Q
 ;
DATA ;
 I DVBSEL="D" DO  ;by date range
 .U IO
 .F XDA=0:0 S XDA=$O(^DVB(396,"AC",DVBAD2,"P",XDA)) Q:XDA=""  S DFN=$P(^DVB(396,XDA,0),U,1) I $P(^(4),U,4)=SDATE D CREATE
 .Q
 I DVBSEL="N" DO  ;by name/ssn
 .S DFN=$P(^DVB(396,XDA,0),U,1)
 .D CREATE
 .Q
 I NODTA=0 DO  ;no data found
 .S VAR(1,0)="0,0,0,2:2,0^No data found to reprint"
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .Q
 ;
KILL K DVBAON2,DVBSEL,VAR,DVBAD2,CONT
 Q:$G(DVBGUI)  D:$D(ZTQUEUED) KILL^%ZTLOAD
 D KILL^DVBAUTIL
 Q
 ;
CREATE ;CERTIFICATE CREATE
 I $D(^DVB(396,XDA,2)) Q:$P(^(2),U,10)="L"
 I '$D(^DPT(DFN,0)) W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 I '$D(^DPT(DFN,0)) W !!,"Patient record missing for DFN ",DFN,!!
 I '$D(^DPT(DFN,0)) S DVBAON2="" Q
 S PNAM=$P(^DPT(DFN,0),U,1),SSN=$P(^(0),U,9),CNUM=$S($D(^DPT(DFN,.31)):$P(^(.31),U,3),1:"Unknown")
 S WARD=$P(^DVB(396,XDA,4),U,6),BED=$P(^(4),U,7),DCHGDT=$P(^(4),U,5),ADMDT=$P(^(0),U,4)
 U IO W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 W !,FDT(0),?32,"REPORT OF CONTACT",!,?31,"21-DAY CERTIFICATE",?(80-11),"PAGE: 1",!,?(80-$L(HD1)\2),HD1,!!!!!!!,"Patient name: ",?16,PNAM,!,?9,"SSN: ",?16,SSN,?33,"Claim #: ",?43,CNUM,!!,?9,"Ward: ",?16,WARD,?30,"Bed: ",?36,BED,!!!
 W "     The patient above has been hospitalized for 21 consecutive days ",!,"from " S Y=ADMDT X ^DD("DD") W Y," to " S Y=DCHGDT X ^DD("DD") W Y,", and the major diagnosis for",!,"this period is:",!!!
 K ^UTILITY($J,"W")
 F LINE=0:0 S LINE=$O(^DVB(396,XDA,3,LINE)) Q:LINE=""  S X=^(LINE,0),DIWL=5,DIWR=75,DIWF="NW" D ^DIWP
 D ^DIWW W !!!,"A signed copy of this document is on file at "_HD1,!
 W !!?5,"R0C  119",!
 S NODTA=1,DVBAON2=""
 Q
 ;
HDR ;Displays the header to this option.
 S VAR(1,0)="0,0,(IOM-$L(HD)\2),1:3,1:0^"_HD
 D WR^DVBAUTL4("VAR")
 K VAR
 S VAR(1,0)="0,0,0,0:2,0^This program REPRINTS 21-day certificates for the RO."
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
 ;
INIT ;sets up and checks various variables
 S CONT=1
 D DUZ2^DVBAUTIL
 I $D(DVBAQUIT) S CONT=0
 I $D(DUZ)#2=0 DO
 .S VAR(1,0)="1,0,0,2:2,0^Your USER NUMBER is missing.  Call the site manager."
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .I '$D(DVBGUI) D PAUSE^DVBCUTL4
 .S CONT=0
 .Q
 I CONT=0 Q
 S NODTA=0,HD="REGIONAL OFFICE 21-DAY CERTIFICATE REPRINTING"
 I '$D(DVBGUI) D HOME^%ZIS
 D NOPARM^DVBAUTL2
 I $D(DVBAQUIT) S CONT=0
 S HD1=$$SITE^DVBCUTL4
 I '$D(DT) S X="T" D ^%DT S DT=Y
 S Y=DT X ^DD("DD") S FDT(0)=Y
 Q
