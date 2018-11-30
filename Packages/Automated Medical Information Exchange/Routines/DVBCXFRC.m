DVBCXFRC ;ALB/GTS-557/THM-PROCESS TRANSFER-IN MAIL MESSAGE ; 10/4/91  9:26 AM
 ;;2.7;AMIE;**1,6,18,65,149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN1 N XMB K OUT,CNT S (CNTA,OUT)=0 X XMREC I XMRG["TRANSFER OUT" G EN1^DVBCXFRS
 F DVBCI=0:0 X XMREC Q:XMER<0!(XMRG["$END")  S XLN=XMRG,SUB=$E(XLN,2,5),XLN=$E(XLN,7,245) D @SUB
 ;check for existence of primary division
 S DVBCDIV=$$PRIM^VASITE I DVBCDIV=""!(DVBCDIV=-1) D BULL8^DVBCXFRD G EXIT
 ;check for unique regional office station# using variable ronam
 S RO=$$FIND1^DIC(4,,"X",RONAM,"D",,"DVBCERR") I RO=""!(RO=0) S OUT=1 D BULL11^DVBCXFRD G EXIT
 ;if primary division and regional office station# ok, then proceed
 K XLN,CNTA I XMRG["$END" S OUT=0 D PATEDIT G:OUT EXIT D REQEDIT
 I $D(DVBCNEW) S XMB="DVBA C NEW C&P VETERAN",XMB(1)=PNAM,XMB(2)=SSN,XMB(3)=$S($D(^VA(200,+DUZ,0)):$P(^(0),U),1:"Unknown user"),Y=DT X ^DD("DD") S XMB(4)=Y D ^XMB
 ;
EXIT D DELSER^DVBCUTL4 ;deletes the server message
 K DGMSGF,TYPE,REASONS,DVBADMNM,EXMRS,XMORPV,DVBSBRCH,DVBDTYPE
 G KILL^DVBCUTIL
 ;
DEM0 S PNAM=$E($P(XLN,U,1),1,28),DOB=$P(XLN,U,2),SEX=$P(XLN,U,3),SSN=$P(XLN,U,4)
 Q
 ;
USER S USER=$P(XLN,U,1),SITE=$P(XLN,U,2),SITE1=$P(XLN,U,3)
 Q
 ;
DEM1 S ADR1=$P(XLN,U,1),ADR2=$P(XLN,U,2),ADR3=$P(XLN,U,3),CITY=$P(XLN,U,4),STATE=$P(XLN,U,5),CNTY=$P(XLN,U,6),ZIP=$P(XLN,U,7),HOMPHON=$P(XLN,U,8),BUSPHON=$P(XLN,U,9),ZIP4=$P(XLN,U,10)
 I STATE?.E1A.E S STATE=$O(^DIC(5,"B",STATE,0)) DO
 .I CNTY?.E1A.E S CNTY=$O(^DIC(5,+STATE,1,"B",CNTY,0)) Q
 I 'STATE S STATE=""
 I 'CNTY S CNTY=""
 Q
 ;
ELIG S SRVCON=$P(XLN,U,1),SRVPCT=$P(XLN,U,2),CFLOC=$P(XLN,U,3),CNUM=$P(XLN,U,4),PDSRV=$P(XLN,U,5),SRVEDT=$P(XLN,U,6),SRVSDT=$P(XLN,U,7),ELIGCOD=$P(XLN,U,8),ELIGST=$P(XLN,U,9),ELIGSDT=$P(XLN,U,10),POWSTAT=$P(XLN,U,11),VETST=$P(XLN,U,12)
 S TYPE=$P(XLN,U,13),DVBSBRCH=$P(XLN,U,14),DVBDTYPE=$P(XLN,U,15),TYPEPTR=""
 S:TYPE]"" TYPEPTR=$O(^DG(391,"B",TYPE,TYPEPTR))
 S ELIGCOD=$O(^DIC(8,"D",+ELIGCOD,0))
 S ELIGCOD=$S(ELIGCOD="":"",$D(^DIC(8,"D",+ELIGCOD)):$O(^DIC(8,"D",+ELIGCOD,0)),1:"")
 S PDSRV=$S(PDSRV="":"",$D(^DIC(21,"D",PDSRV)):$O(^DIC(21,"D",PDSRV,0)),1:"")
 Q
 ;
REQ0 S OLREQDA=$P(XLN,U,1),RO=$P(XLN,U,2),RONAM=$P(XLN,U,8),PRIO=$P(XLN,U,3),CFLOC=+$P(XLN,U,4),LREXMDT=$P(XLN,U,5),CFREQ=$P(XLN,U,6),LREXMDT=$P(XLN,U,7)
 S CFLOC=$O(^DIC(4,"D",CFLOC,""))
 S:'$D(^DIC(4,+CFLOC,0)) CFLOC=""
 Q
 ;
ODIS S OTHDIS=$P(XLN,U,1),OTHDIS1=$P(XLN,U,2),OTHDIS2=$P(XLN,U,3)
 Q
 ;
EXAM S EXAMS=$P(XLN,"^^",1),REASONS=$P(XLN,"^^",2)
 Q
 ;
REMK S:'$D(CNT) CNT=0 S CNT=CNT+1,REMK(CNT)=XLN
 Q
 ;
REQEDIT ;  ** Add entry to file #396.3 (request)
 K DD,DO,DA,DR,DIC,X,Y S DIC="^DVB(396.3,",DLAYGO=396.3,DIC(0)="L",X=DFN
 S DIC("DR")="1///NOW;2////"_RO_";3////.5;9////"_PRIO_";28///"_SITE1_";30////"_OLREQDA_";33////"_DT
 D FILE^DICN K DLAYGO
 S (DA,REQDA)=+Y I DA<0 S OUT=1 D BULL1^DVBCXFRD Q
 ;Give Med Center Primary Division as routing location (DVBCDIV)
 S DIE="^DVB(396.3,"
 S DR="10////"_OTHDIS_";10.1////"_OTHDIS1_";10.2////"_OTHDIS2_";17////NT" D ^DIE
 S DR="21////"_CFREQ_";23.3////"_LREXMDT_";24////"_DVBCDIV
 D ^DIE K DIC,DIE,DD,DO
 S CNT=0 I '$D(^DVB(396.3,REQDA,2,0)) S ^(0)="^^0^0^"_DT_"^^^^"
 F ZI=0:0 S ZI=$O(REMK(ZI)) Q:ZI=""  S X=REMK(ZI) S CNT=CNT+1,^DVB(396.3,REQDA,2,CNT,0)=X F Y=3,4 S $P(^DVB(396.3,REQDA,2,0),U,Y)=CNT
 S X="",DVBADMNM=$P(SITE1,".",1)
 F I=1:1 S EXM=$P(EXAMS,U,I) Q:EXM=""  D SETVARS Q:OUT
 ;if adding exams failed, then delete request
 I OUT S DA=REQDA,DIK="^DVB(396.3," D ^DIK K DA,DIK
 Q
 ;
PATEDIT ;  ** Lookup and/or Add entry to file #2 (patient)
 N DVBCPT,DVBCARAY,DVBCERR,DVBCIENS,DOB2,NAME1,NAME2,BYEAR,X,Y
 K DVBCNEW S DVBCPT=$$FIND1^DIC(2,,"X",SSN,"SSN",,"DVBCERR")
 ;if error returned, send error msg
 I DVBCPT="" S OUT=1 D BULL9^DVBCXFRD Q
 ;if found matching ssn, make sure the name and dob also match
 I +DVBCPT>0 D  Q
 .S DVBCIENS=DVBCPT_"," K DVBCERR
 .D GETS^DIQ(2,DVBCIENS,".01;.03;.09","I","DVBCARAY","DVBCERR")
 .;if fm returned an error msg and no data, send error msg
 .I '$D(DVBCARAY(2,DVBCIENS)) S OUT=1 D BULL10^DVBCXFRD Q
 .;make sure about that ssn
 .I SSN'=DVBCARAY(2,DVBCIENS,.09,"I") S OUT=1,DVBCERR(1)="Possible 'SSN' index problem.",DVBCERR(2)=""
 .;if name and/or dob don't match, send error msg
 .I (PNAM'=DVBCARAY(2,DVBCIENS,.01,"I"))!(DOB'=DVBCARAY(2,DVBCIENS,.03,"I")) D  Q:OUT
 ..S X=$P(PNAM,",",1),NAME1(1)=$P(X," ",1),X=$P(PNAM,",",2),NAME1(2)=$P(X," ",1)
 ..S X=$P(DVBCARAY(2,DVBCIENS,.01,"I"),",",1),NAME2(1)=$P(X," ",1),X=$P(DVBCARAY(2,DVBCIENS,.01,"I"),",",2),NAME2(2)=$P(X," ",1)
 ..I (NAME1(1)'=NAME2(1))!(NAME1(2)'=NAME2(2)) S OUT=1
 ..S BYEAR(1)=$E(DOB,1,3),BYEAR(2)=$E(DVBCARAY(2,DVBCIENS,.03,"I"),1,3)
 ..I BYEAR(1)'=BYEAR(2) S OUT=1
 ..I OUT D
 ...S DVBCERR(1)="Patient name and/or DOB at target site does not match transfer request."
 ...S DOB2=DVBCARAY(2,DVBCIENS,.03,"I") S Y=DOB2 X ^DD("DD") S DOB2=Y
 ...S DVBCERR(2)="Name: "_DVBCARAY(2,DVBCIENS,.01,"I")_"   DOB: "_DOB2
 ...D BULL10^DVBCXFRD
 .S DFN=+DVBCPT K X,Y,DIC
 ;if no match, then add record
 I +DVBCPT=0 D  Q
 .K DA,DR,DIC,DO,DD,X,Y S DVBCNEW=1
 .S DLAYGO=2,DIC="^DPT(",DIC(0)="L",X=PNAM,DIC("DR")=".02////"_SEX_";.03////"_DOB_";.09////"_SSN
 .D FILE^DICN K DLAYGO S (DFN,DA)=+Y
 .I DA<0 D BULL3^DVBCXFRD S OUT=1 Q
 .S DGMSGF=1 ;why is this variable needed?
 .D ADDEDIT
 .S DIE="^DPT(",DA=DFN
 .S DR(1,2,1)=".301////"_SRVCON_";.302////"_SRVPCT_";.314////"_CFLOC_";.313////"_CNUM_";.323////"_PDSRV_$S('+$$VFILE^DILFD(2.3216):";.326////"_SRVEDT_";.327////"_SRVSDT,1:"")_";.361////"_ELIGCOD
 .S DR(1,2,2)=".3611////"_ELIGST_";.3612////"_ELIGSDT_";.525////"_POWSTAT_";1901////"_VETST
 .S:TYPEPTR]"" DR(1,2,3)="391////"_TYPEPTR
 .D ^DIE
 .;MSE data now to be stored in .3216 subfile in the PATIENT File (2)
 .;after Patch DG*5.3*797 has been installed. Editing of the fields
 .;.326 and .327 above can be removed once DG*5.3*797 has been released.
 .D:((+$$VFILE^DILFD(2.3216))&(SRVEDT]"")) CRTMSE
 Q
 ;
SETVARS ;  ** Add entry to file #396.4 (exam) **
 I REASONS'="" DO
 .S EXMRS=$P(REASONS,U,I) ;**Stuff Insufficient Reason
 .S XMORPV="Transferred from "_DVBADMNM ;**Stuff Original Provider
 S DIC="^DVB(396.4,"
 S DIC(0)="L",DLAYGO=396.4
 S DIC("DR")=".02////"_REQDA_";.03////"_EXM_";.04////O;63////"_DT
 S:REASONS'="" DIC("DR")=DIC("DR")_";.11///"_EXMRS_";.12///"_XMORPV
 S X=$$EXAM^DVBCUTL4 I 'X S OUT=1 D BULL2^DVBCXFRD Q
 K DD,DO D FILE^DICN
 I +Y=-1 S OUT=1 D BULL2^DVBCXFRD
 K DLAYGO,DIC,X,Y
 Q
 ;
ADDEDIT ;  ** Add Patient address **
 S DA=DFN,DIE="^DPT("
 S DR=".111////"_ADR1_";.112////"_ADR2_";.113////"_ADR3_";.114////"_CITY_";.115////"_STATE
 S DR=DR_$S(ZIP4]"":";.1112////"_ZIP4,1:";.116////"_ZIP)_";.117////"_CNTY_";.131////"_HOMPHON_";.132////"_BUSPHON
 D ^DIE K DIE,DA
 Q
 ;
CRTMSE ;create LAST MSE entry for patient in sub-file 2.3216
 N DIC,X,Y,DA,DTOUT,DUOUT,DLAYGO
 S DIC="^DPT("_DFN_",.3216,",DA(1)=DFN
 S DIC(0)="FL",DLAYGO=2
 S X=SRVEDT  ;.01 SERVICE ENTRY DATE
 ;SERVICE SEPARATION DATE ; SERVICE BRANCH ; SERVICE DISCHARGE TYPE
 S DIC("DR")=".02////"_SRVSDT_";.03///"_DVBSBRCH_";.06///"_DVBDTYPE
 K DO D FILE^DICN K DLAYGO
 Q
