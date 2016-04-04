DIARR1 ;SFISC/DCM-ARCHIVING FUNCTION, PROMPT FOR ARCHIVED RECORD ;7/1/93  8:43 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
PROC D N Q:$D(DTOUT)!($D(DUOUT)&(DIARREQ'>0))!('$D(DIARR))
 D PRINTDEV Q:POP
 I '$D(IO("Q")) U IO(0) W !,"Searching archived file..."
 Q
 ;
N U IO(0) I '$D(DIARIDX) W !!,"Type ?? at any prompt to display sampled entries.",!
 W !!,"Multiple requests may be made.",!,"One set of all prompts makes one request.",!
 I $D(DIARIDX) D ASKIX Q:$D(DIRUT)
N1 W !
 K DIR S DIR("?",1)="Enter the "_DIAR01_" (.01) field.",DIR("?",2)="Answer to this prompt will retrieve all entries that match the ",DIR("?")=DIAR01_" field.",DIR("??")="^D HELP^DIARR1"
 S DIR(0)="FO",DIR("A")="Enter "_DIAR01 D ^DIR
 S:((X]"")&(X'="^")) DIARR(DIARREQ+1,".01")=X
 Q:$D(DTOUT)!(DIAROUT&(X=""))!($D(DUOUT))!('$D(DIARID)&$D(DIRUT))
 I $D(DIARID) D IDS Q:$D(DTOUT)
 S:$D(DIARR(DIARREQ+1)) DIARREQ=DIARREQ+1 G N1
 ;
IDS S DIAROUT=0
 K DIR S DIR(0)="FO",DIR("?",1)="Enter identifier information.  Answer to this prompt, along with all",DIR("?",2)="previously answered prompts for this request, will be used in the matching",DIR("?")="process."
 S DIR("??")="^D HELP^DIARR1"
 F DIARZ=.019:0 S DIARZ=$O(DIARID(DIARZ)) Q:DIARZ'>0  S DIR("A")="Enter "_$P(DIARID(DIARZ),U)_" (id) " D ^DIR Q:$D(DTOUT)!$D(DUOUT)  S:((X]"")&(X'="^")) DIARR(DIARREQ+1,"ID",+$P(DIARID(DIARZ),U,2))=X
 I '$D(DIARR(DIARREQ+1)) S DIAROUT=1 Q
 Q
 ;
HELP S DIARZHP="" W @DIOF
 F DIARHLP=0:0 S DIARHLP=$O(^TMP("DIARHLP",$J,DIARHLP)) Q:DIARHLP'>0!$D(DTOUT)!$D(DIRUT)  W ! F  S DIARZHP=$O(^TMP("DIARHLP",$J,DIARHLP,DIARZHP)) Q:DIARZHP=""  W !,^(DIARZHP) I $Y>(DIOSL-3) D E Q:$D(DTOUT)!$D(DIRUT)
 Q
 ;
E ;
 N DIR S DIR(0)="E" D ^DIR Q:$D(DTOUT)!$D(DIRUT)
 W @DIOF
 Q
 ;
PRINTDEV Q:'$D(DIARR)
 S %ZIS="QN",%ZIS("B")="",%ZIS("A")="PRINT FOUND ENTRIES TO DEVICE: " D ^%ZIS Q:POP
 S DIARPDEV=$S($D(ION)#2:ION,1:IO)
 I $D(IOST)#2,IOST]"" S DIARPDEV=DIARPDEV_";"_IOST
 F DIARZ="IOM","IOSL" S:($D(@DIARZ)#2&DIARZ) DIARPDEV=DIARPDEV_";"_@DIARZ
 I $D(IO("Q")) U IO(0) W !,"THE PRINTING OF REPORT WILL BE QUEUED.  PROCESSING CONTINUES..." S DIARQUED=""
 Q
 ;
ASKIX W !,"This archived file contains an index of all archived entries."
 K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to see the index now" D ^DIR Q:'Y!($D(DIRUT))
 W @DIOF,! S DIARTAB=0 F DIARXX=1:1:DIARCNT S DIARFLD=$P(DIARPC(DIARXX),U,2),DIARTAB=DIARTAB+25 W $E(DIARFLD,1,23),?DIARTAB
 S DIARYY=""
 W ! F DIARXX=1:1:DIARCTR W ! S DIARTAB=0 D  I $Y>(DIOSL-2) D E Q:$D(DTOUT)!$D(DIRUT)
 . F  S DIARYY=$O(DIARPC(DIARYY)) Q:DIARYY'>0  S DIARFLD=+$G(DIARPC(DIARYY)),DIARTAB=DIARTAB+25 W $E($P($G(^TMP("DIARHLP",$J,DIARXX,DIARFLD)),"= ",2),1,23),?DIARTAB
 . Q
 K DTOUT,DIRUT
 Q
