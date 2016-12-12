GECSPURG ;WISC/RFJ/KLD-purge code sheets (ask prompts)                  ; 5/21/12 5:05am
 ;;2.0;GEC;**23,36,39**;MAR 14, 1995;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;GEC*2*39 Added universal date control query to process
 ;
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
 N GECSSYS,GECSOUT,GECSPGDT,GECSDOUT
 S GECSSYS=GECS("BATCH")
 ;
ASK ;  ask days to retain code sheets
DT ;Ask processing date     GEC*2*39
 S GECSOUT=$$PURGEDT^GECSPURG("",7)
 I GECSPGDT'>0!GECSOUT Q
 S (Y,GECSDT)=GECSPGDT
 ;
 I GECSSYS="*"!($G(GECS("SYSID"))="FMS") D
 .   S X1=DT,X2=-2558 D C^%DTC S (Y,GECSDTST)=X D DD^%DT
 .   W !!,"This program will remove all stack file entries which were created before",!,Y,"."
 ;
 ;  calculate cutoff date
 S Y=GECSDT D DD^%DT S GECSDATE=Y
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
PURGEDT(GECSTHRU,GECSYRS) ;ARCHIVE/PURGE date query     ;GEC*2*39
 N GECSDT,OUT D DTGEC S OUT=0
P1 S GECSDOUT=0,GECSPGDT=0
 S DIR(0)="D^::E",DIR("A")="Select Fiscal Year thru which this option is to run",DIR("?",1)="Enter a valid FileMan date (YYYY is valid), or an up-arrow to quit."
 S DIR("?")="Date is converted to last day of FISCAL YEAR associated with entry"
 S:GECSTHRU>0 DIR("B")=GECSTHRU
 D ^DIR K DIR I X["^"!(X="") S OUT=1 G Q
 I $E(Y,4,5)>9 S Y=($E(Y,1,3)+1)_"0930"
 E  S Y=$E(Y,1,3)_"0930"
 S GECSPGDT=Y
 I GECSPGDT>GECSDT W !,"CANNOT RUN THIS OPTION FOR LESS THAN LAST "_GECSYRS_" FISCAL YEARS + CURRENT FISCAL YEAR" K GECSDOUT,GECSPGDT G P1
 D DD^%DT S GECSDOUT=Y K Y
Q Q OUT
 ;
DTGEC N U,X,MM,DD,YY
 S U="^"
 I '$D(DT) D NOW^%DTC S DT=X
 S MM=$E(DT,4,5),DD=$E(DT,6,7),YY=$E(DT,1,3)
 S YY=YY-GECSYRS    ;MIN = LAST 7 YEARS + CURRENT
 S YY=YY-1,GECSDT=YY_"0930"
 Q
