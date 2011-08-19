NURCROP2 ;HIRMFO/RM-CARE PLAN RANK ORDER PRINT ;12/23/93
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
PRINT ; ENTRY FROM NURCROP0 TO PRINT THIS REPORT
 ;
 ;  RANK=0
 ;  Loop through ^TMP($J,"NURSPR",FREQ,PROBLEM) increasing RANK with
 ;  each new FREQ
 ;    BEGIN
 S (NURCOUT,NURCRANK)=0
 F NURCFREQ=0:0 S NURCFREQ=$O(^TMP($J,"NURSPR",NURCFREQ)),NURCRANK=NURCRANK+1 Q:NURCFREQ'>0!NURCOUT  F NURCPTRM=0:0 S NURCPTRM=$O(^TMP($J,"NURSPR",NURCFREQ,NURCPTRM)) Q:NURCPTRM'>0!NURCOUT  D
 .;      WRTPROB(RANK,PROBLEM,FREQ)
 .;      RANK1=0
 .;      Loop through ^TMP($J,"NURSPROB",PROBLEM,BS5)
 .;        WRTPPT(BS5)
 .;      Loop through ^TMP($J,"NURSIR",PR,FREQ1,ORD) increasing RANK1 by
 .;      one for each new FREQ
 .;        BEGIN
 .S NURCRNK1=0,NURCOUT=$$WRTPROB^NURCROP1(NURCRANK,NURCPTRM,9999999-NURCFREQ) Q:NURCOUT
 .W !?15 S NURCBS5="" F  S NURCBS5=$O(^TMP($J,"NURSPROB",NURCPTRM,NURCBS5)) Q:NURCBS5=""  S NURCOUT=$$WRTPPT^NURCROP1(NURCBS5) Q:NURCOUT
 .S NURCOUT=$$HDRINT^NURCROP1 Q:NURCOUT
 .F NURCFRQ1=0:0 S NURCFRQ1=$O(^TMP($J,"NURSIR",NURCPTRM,NURCFRQ1)),NURCRNK1=NURCRNK1+1 Q:NURCFRQ1'>0!NURCOUT  F NURCOTRM=0:0 S NURCOTRM=$O(^TMP($J,"NURSIR",NURCPTRM,NURCFRQ1,NURCOTRM)) Q:NURCOTRM'>0!NURCOUT  D
 ..;          WRTORD(RANK1,ORD,FREQ1)
 ..;          Loop through ^TMP($J,"NURSORD",PROBLEM,ORD,BS5)
 ..;            WRTOPT(BS5)
 ..S NURCOUT=$$WRTORD^NURCROP1(NURCRNK1,NURCOTRM,9999999-NURCFRQ1) Q:NURCOUT
 ..W !?20 S NURCBS5="" F  S NURCBS5=$O(^TMP($J,"NURSORD",NURCPTRM,NURCOTRM,NURCBS5)) Q:NURCBS5=""  S NURCOUT=$$WRTOPT^NURCROP1(NURCBS5) Q:NURCOUT
 .;        END
 ;    END
 ;
 ;  If terminal don't let last page scroll off of screen
 S NURCPAGE=$$HEADER^NURCROP1(-1)
 Q
SORTYP() ; Function that returns:
 ;    1 = sort by admitting location
 ;    2 = sort by all locations during patient stay
 ;    0 = user did not select location
 ;   -1 = user abnormally exited.
 N DTOUT,DUOUT
 K DIR S DIR("A",1)="Would you like statistics by:",DIR("A",2)="   1. Admitting Location for a particular admission",DIR("A",3)="   2. All Locations the Patient was on during a particular admission.",DIR("A")="Choose 1 or 2: "
 S DIR("?")="ENTER A CHOICE FROM LIST, EITHER 1 OR 2",DIR(0)="NOA^1:2" D ^DIR
 Q $S(Y=1!(Y=2):Y,$D(DTOUT)!$D(DUOUT):-1,1:0)
 ;
RPRTID() ;  Select the Ward/Group Report ID for the header
 N NURCLID
 S NURCLID=$O(NURSNLOC(""))
 I $O(NURSNLOC(NURCLID))'="" W ! K DIR S NURCLID="",DIR(0)="FA^2:30",DIR("A")="REPORT IDENTIFIER: ",DIR("?")="This is a free text prompt printed in the header to identify this report" D ^DIR I '$D(DIRUT) S NURCLID=Y K DIR
 E  I $O(NURSNLOC(NURCLID))="" D
 .   S NURCLID=$O(NURSNLOC("")) W ! K DIR S DIR(0)="FA^2:30",DIR("A")="REPORT IDENTIFIER: ",DIR("B")=NURCLID,DIR("?")="This is a free text prompt printed in the header to identify this report",NURCLID=""
 .   D ^DIR I '$D(DIRUT) S NURCLID=Y K DIR
 .   Q
 Q NURCLID
 ;
