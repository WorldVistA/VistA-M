DVBACRMS ;ALB/GTS-557/THM-PRINT 21-DAY CERT FOR RO ;21 JUL 89
 ;;2.7;AMIE;;Apr 10, 1995
 D DUZ2^DVBAUTIL G:$D(DVBAQUIT) KILL
 I '$D(^DVB(396,"AC",DVBAD2,"R")) W !!,*7,"There are no new 21-DAY CERTIFICATES to print.",! H 2 Q
 I $D(DUZ)#2=0 W !!,*7,"Your USER NUMBER is missing.  Call the site manager.",!! H 3 G KILL
 S HD="REGIONAL OFFICE 21-DAY CERTIFICATE PRINTING" D HOME^%ZIS D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) KILL^DVBAUTIL S DTAR=^DVB(396.1,1,0),HD1=$P(DTAR,U,1)
 S OPER=$S($D(^VA(200,+DUZ,0)):$P(^(0),U,1),1:"Unknown")
 I '$D(DT) S X="T" D ^%DT S DT=Y
 S Y=DT X ^DD("DD") S FDT(0)=Y
 W @IOF,!?(IOM-$L(HD)\2),HD,!!!,"This program generates ORIGINAL Regional Office 21-day certificates.",!!
 W !! S %ZIS="AEQ" D ^%ZIS K %ZIS G:POP KILL
 I $D(IO("Q")) S ZTIO=ION,ZTDESC="Original RO 21-day Cert Printing",ZTRTN="DATA^DVBACRMS" F I="DVBAD2","HD","HD1","OPER","FDT(0)" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",!! K ZTSK,ZTIO,ZTRTN,ZTDESC G KILL
 G DATA
 ;
DATA U IO F XDA=0:0 S XDA=$O(^DVB(396,"AC",DVBAD2,"R",XDA)) Q:XDA=""  S DFN=$P(^DVB(396,XDA,0),U,1) D CREATE
 ;
KILL K DVBAON2 D:$D(ZTQUEUED) KILL^%ZTLOAD G KILL^DVBAUTIL
 ;
CREATE ;CERTIFICATE CREATE
 ;Note:  DCHGDT becomes a pseudo-discharge date, that is the date the
 ;       report was run and he became eligible for a 21-day cert.
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
 S DIE="^DVB(396,",DA=XDA,DR="6.82///P;6.85///"_DT_";6.89///"_OPER D ^DIE
 S DVBAON2=""
 Q
