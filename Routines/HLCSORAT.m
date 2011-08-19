HLCSORAT ;ALB/MFK/jc - HEALTH LEVEL SEVEN ;07/13/99  15:20
 ;;1.6;HEALTH LEVEL SEVEN;**57**;Oct 13, 1995
 ;Report low level communications errors for serial links (HLLP,
 ;X3.28) in file 870. 
START ; Main Entry point
 N DIR,DIC,X,Y,HLZ,LINE,HLERR,HLSORT,HLAAA,HLSTAT,HLLL,HLQUEUE,POP
 N %ZIS,DTOUT,DUOUT,HLDONE,HLTMP,SET,FOO,CODES
 S (HLERR,HLSTAT,LINE)=""
 D PROMPT I (Y=-1)!($D(DUOUT))!($D(DTOUT)) Q
 D OPEN G END:POP
 I $D(IO("Q")) D QUEUED,HOME^%ZIS G END
 U IO
REPORT ;  Output data after gathering
 S HLZ=0
 ;  GATHER AND SORT DATA
 D ^HLCSORA1
 I 'HLZ G NEXT
 I HLDONE G END
 F HLAAA=$Y:1:(IOSL-3) W !
 I ($E(IOST,1,2)="C-") S DIR(0)="E" D ^DIR K DIR I Y=0!(Y="")!($D(DIRUT)) G END
NEXT ;  PRINT THE DATA
 D ^HLCSORA2
 I 'HLZ W !,"No data found for this request"
END ;
 ;  Clean up. Kill the ^TMP and other assorted variables.
 K ^TMP("HLCSORAT",$J)
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K DIRUT,HLZ
 D ^%ZISC
 Q
PROMPT ;  Find out how user wants report done
 S HLLL=""
 S DIR(0)="FAOU"
 S DIR("A")="Select HL7 Logical Link: "
 S DIR("B")="All Links"
 D ^DIR
 Q:$D(DTOUT)!($D(DUOUT))
 I Y="All Links" S Y=0
 I Y'=0 D
 .S X=Y,DIC="^HLCS(870,",DIC(0)="EMQZ" D ^DIC K DIC
 Q:$D(DTOUT)!($D(DUOUT))
 S HLLL=$P(Y,"^",1)
 I Y=-1 Q
 S DIR(0)="S^I:IN QUEUE;O:OUT QUEUE;B:BOTH"
 S DIR("A")="Select queue for report",DIR("B")="B" D ^DIR K DIR
 S HLQUEUE=Y
 I '("IOB"[Y) Q
 S HLQUEUE=$S(HLQUEUE="B":"12",HLQUEUE="I":1,HLQUEUE="O":2)
 S SET="",CODES=$$GET1^DID(870.019,2,"","POINTER")
 F HLTMP=1:1 S FOO=$P(CODES,";",HLTMP) Q:(FOO="")  D
 .S SET=SET_$E(FOO,1,1)
ERR S DIR(0)="SOM^"_CODES_"ALL:ALL ERRORS;F:FINISH SELECTING ERRORS"
 S DIR("A")="Select an error code to sort by"_$S(HLERR'="":" ("_HLERR_")",1:"")
 S DIR("B")=$S((HLERR=""):"ALL",1:"F")
 S DIR("?",1)="Select the list of errors that you would like to sort by.  There are also"
 S DIR("?",2)="two special selections.  ALL means that you would like to sort on all the"
 S DIR("?")="error codes.  F means that you have finished selecting error codes."
 D ^DIR K DIR
 I ((HLERR'[Y)&(Y'="F")) S HLERR=HLERR_Y
 I Y="ALL" S HLERR=SET
 I (HLERR="")!($D(DUOUT))!($D(DTOUT)) S Y=-1 Q
 I (Y'="ALL")&(Y'="F") G ERR
 S SET="",CODES=$$GET1^DID(870.019,1,"","POINTER")
 F HLTMP=1:1 S FOO=$P(CODES,";",HLTMP) Q:(FOO="")  D
 .S SET=SET_$E(FOO,1,1)
STAT S DIR(0)="SOM^"_CODES_"ALL:ALL STATUS;F:FINISH SELECTING STATUS CODES"
 S DIR("A")="Select a status code to sort by"_$S(HLSTAT'="":" ("_HLSTAT_")",1:"")
 S DIR("B")=$S((HLSTAT=""):"ALL",1:"F")
 S DIR("?",1)="Select a status code to sort the report by.  There are two special"
 S DIR("?",2)="selections.  ALL indicates you would like a report on all the statuses.  The"
 S DIR("?")="F means you are finished selecting statuses."
 D ^DIR K DIR
 I ((HLSTAT'[Y)&(Y'="F")) S HLSTAT=HLSTAT_Y
 I Y="ALL" S HLSTAT=SET
 I (HLSTAT="")!($D(DTOUT))!($D(DUOUT)) S Y=-1 Q
 I (Y'="ALL")&(Y'="F") G STAT
 S HLSORT=HLERR_"^"_HLSTAT
 Q
QUEUED ;  If queued, set up and kick in TASKMAN
 S ZTRTN="REPORT^HLCSORAT",ZTDESC="HL7 LOGICAL LINK REPORT",ZTSAVE("HLLL")="",ZTSAVE("HLQUEUE")="",ZTSAVE("HLSORT")="" D ^%ZTLOAD
 W !!,$S($D(ZTSK):"Request Queued",1:"Request Cancelled")
 K ZTSK
 Q
OPEN ;  Open a device
 S %ZIS="QM" D ^%ZIS
 Q
