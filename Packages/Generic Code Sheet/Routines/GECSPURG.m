GECSPURG ;WISC/RFJ/KLD-purge code sheets (ask prompts)                  ;01 Nov 93
 ;;2.0;GCS;**23**;MAR 14, 1995
 W !,"This routine will delete Code Sheets from the Code Sheet file and"
 W !,"Batch and Transmission records from the Transmission Record file."
 W !,"Deletion is based upon the date a batch and a code sheet is"
 W !,"created.",!
 N %,%H,%I,DIR,DONTASK,GECS,GECSDATE,GECSDT,GECSDTST,X,Y
 D ^GECSSITE Q:'$G(GECS("SITE"))
 ;
 ;  if programmer, ask to purge *all* code sheets
 I '$L($G(GECSSYS)),$G(DUZ(0))="@" N GECSSYS D ALL Q:GECSSYS="^"  I GECSSYS="*" D ASK Q
 ;
 I $L($G(GECSSYS)) S DONTASK=1
 W ! D BATTYPE^GECSUSEL($G(GECSSYS),$G(DONTASK)) Q:'$G(GECS("BATDA"))
 N GECSSYS
 S GECSSYS=GECS("BATCH")
 ;
ASK ;  ask days to retain code sheets
 S DIR(0)="NO^0:999999:0",DIR("A")="Enter the number of days you wish to retain code sheets",DIR("B")=365
 S DIR("?",1)="Enter the number of days you want to retain code sheets.  Code sheet created",DIR("?")="past the retaining days will be deleted."
 W ! D ^DIR I Y'>0 Q
 S GECSDT=Y
 I Y<30 W !!,"NOTICE: I recommend keeping code sheets for at least 30 days."
 ;
 I GECSSYS="*"!($G(GECS("SYSID"))="FMS") D
 .   S X1=DT,X2=-365 D C^%DTC S (Y,GECSDTST)=X D DD^%DT
 .   W !!,"This program will remove all stack file entries which were created before",!,Y,"."
 ;
 ;  calculate cutoff date
 S X1=DT,X2=-GECSDT D C^%DTC S (Y,GECSDT)=X D DD^%DT S GECSDATE=Y
 S XP="I will now delete all code sheets and associated records which were"
 S XP(1)="created before "_GECSDATE_" for station "_GECS("SITE")_GECS("SITE1")_".",XP(2)="OK to continue"
 W ! I $$YN^GECSUTIL(1)'=1 Q
 ;
 S %ZIS="Q" W ! D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^GECSPUR1",ZTDESC="Purge Generic Code Sheets",ZTSAVE("GECS*")="",ZTSAVE("ZTREQ")="@" D ^%ZTLOAD K ZTSK Q
 W !!,">> please wait <<"
 D DQ^GECSPUR1
 Q
 ;
 ;
ALL ;  ask to delete all code sheets
 S XP="DO YOU WANT TO DELETE ALL TYPES OF CODE SHEETS",XH="ENTER 'YES' TO DELETE ALL TYPE OF CODE SHEETS, 'NO' TO SELECT THE BATCH TYPE."
 W ! S %=$$YN^GECSUTIL(2)
 I %=2 S GECSSYS="" Q
 I %=1 S GECSSYS="*" Q
 S GECSSYS="^"
 Q
