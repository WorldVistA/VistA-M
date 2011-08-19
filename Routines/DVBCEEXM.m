DVBCEEXM ;ALB/GTS-557/THM-COMPILE EXISTING 2507 EXAMS ; 5/24/91  7:07 AM
 ;;2.7;AMIE;**22**;Apr 10, 1995
 ;
EN ;only need DFN to return data
 I '$D(^DVB(396.4,"APE",DFN)) W !!,"No Requests are currently on file." Q
 ;;;I '$D(^DVB(396.4,"APE",DFN)) W !!,"Press [RETURN] to continue"
 ;;;I '$D(^DVB(396.4,"APE",DFN)) R DVBCIN:DTIME K DVBCIN Q
 W "Requested exams currently on file:",!!
 D SORT
 F JX=1:1:80 W "-"
 K DVBAEXM,DVBAEXST,DVBADA,DVBADONE,DVBAPDT,DVBAST,DVBARO,JX,DVBCX
 Q
 ;
STAT S DVBAST=$P(^DVB(396.4,DVBADA,0),U,4)
 S:$D(^DVB(396.4,DVBADA,"TRAN")) DVBCX=$P(^("TRAN"),U,3)
 S DVBAST=$S(DVBAST="C":"Completed",DVBAST="RX":"Cancelled by RO",DVBAST="X":"Cancelled by MAS",DVBAST="F":"Cancelled, failed to report",DVBAST="O":"Open",DVBAST="T":"Transferred",1:"Unknown status")
 Q
 ;
CON I $Y>12,IOST?1"C-".E W !!,"Press [RETURN] to continue or ""^"" to end display of existing exams" R ANS:DTIME W ! I '$T!(ANS=U) S DVBADONE=1
 I $Y>12,IOST?1"C-".E W:(DVBADONE'=1) @IOF,"Exams currently on file, continued --",!!!
 I ($Y>45),(IOST?1"P-".E) D HDR
 Q
 ;
HDR S PG=PG+1
 W @IOF,!,"Date: ",FDT(0),?(80-$L(PGHD)\2),PGHD,?71,"Page: ",PG,!,?(80-$L($$SITE^DVBCUTL4)\2),$$SITE^DVBCUTL4 I PG>1 W !!,"Name: ",PNAM,?44,"SSN: ",SSN,?63,"C-NUM: ",CNUM
 W ! F XLINE=1:1:80 W "="
 W !!,"Requested exams currently on file:",!
 W ! Q
 ;
SORT ;  ** Explore 396.4 file; display exams already requested **
 N DVBAEXM,DVBADA,DVBADONE,DVBAPDT,DVBAST,DVBARO,DVBARQDT
 S (DVBAEXM,DVBADA,DVBADONE,DVBAPDT,DVBAST,DVBARO,DVBARQDT)=""
 F  S DVBAEXM=$O(^DVB(396.4,"APE",DFN,DVBAEXM)) Q:DVBAEXM=""!(DVBADONE=1)  F  S DVBARQDT=$O(^DVB(396.4,"APE",DFN,DVBAEXM,DVBARQDT)) Q:DVBARQDT=""  D FLOOP Q:DVBADONE=1
 Q
 ;
FLOOP ;  **  Final loop of "APE" index **
 F  S DVBADA=$O(^DVB(396.4,"APE",DFN,DVBAEXM,DVBARQDT,DVBADA)) Q:DVBADA=""  D BLD,CON Q:DVBADONE=1  D PRINT
 Q
 ;
BLD ;  ** Set variables to be printed to screen **
 N DA,DIK,DATA,DVBAREQ,DVBASTAT,DVBATYPE
 ;don't continue if record doesn't exist in file #396.4
 I '$D(^DVB(396.4,DVBADA,0)) D  Q
 .;kill xref if record doesn't exist
 .K ^DVB(396.4,"APE",DFN,DVBAEXM,DVBARQDT,DVBADA)
 ;don't continue if record doesn't exist in file #396.3
 S DVBAREQ=$P(^DVB(396.4,DVBADA,0),U,2) D  Q:'DVBAREQ
 .I '$D(^DVB(396.3,DVBAREQ)) D
 ..;delete record in file #396.4 if its 'parent' in file #396.3 doesn't exist
 ..;remove reference to file #396.3 so call to ^dik won't error out
 ..S DATA=^DVB(396.4,DVBADA,0),$P(^(0),U,2)=""
 ..;delete "c" xref and mumps xrefs manually because reference to file #396.3 was removed
 ..S DVBATYPE=$P(DATA,U,3),DVBASTAT=$P(DATA,U,4)
 ..K ^DVB(396.4,"C",DVBAREQ,DVBADA)
 ..K ^DVB(396.4,"APE",DFN,DVBAEXM,DVBARQDT,DVBADA)
 ..K ^DVB(396.4,"APS",DFN,DVBATYPE,DVBASTAT,DVBADA)
 ..K ^DVB(396.4,"ARQ"_DVBAREQ,DVBATYPE,DVBADA)
 ..;proceed with fm delete
 ..S DIK="^DVB(396.4,",DA=DVBADA D ^DIK
 ..S DVBAREQ=0
 S Y=DVBARQDT X ^DD("DD") S DVBAPDT=Y
 S DVBARO=$P(^DVB(396.3,DVBAREQ,0),U,3)
 S DVBARO=$S($D(^DIC(4,+DVBARO,0)):$P(^(0),U,1),1:"Unknown RO")
 D STAT
 Q
 ;
PRINT ;  **  Print an entry from list of requested exams **
 W DVBAEXM,!,"Requested on ",DVBAPDT," by ",DVBARO," - ",DVBAST,!!
 Q
