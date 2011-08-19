QAPPT0 ;557/THM-PRINT DRAFT/FINAL COPY [ 07/12/95  11:53 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN K USERPRT W @IOF,! S QAPHDR="Print a Survey" X QAPBAR S QAPHDR="Survey Selection" X QAPBAR
 K DIC S DIC="^QA(748,",DIC(0)="AEQMZ",DIC("A")="Select a survey: " D ^DIC K DIC G:X=""!(X[U) EXIT^QAPPT1
 S SURVEY=+Y,X=DUZ D HASH^XUSHSHP S USER=X,TITLE=$P(^QA(748,SURVEY,0),U,6)
 H 1 W @IOF,! S QAPHDR="Print a Survey" X QAPBAR S QAPHDR=TITLE X QAPBAR
 X CLEOP K DIR S DIR("A")="Selection",DIR(0)="SO^D:Print a draft copy;F:Print a Final Copy;Q:Quit (also uparrow or <RETURN>)" D ^DIR G:$D(DIRUT) EXIT^QAPPT1 S ACTION=$TR(X,"dfq","DFQ")
 I ACTION="Q" G EXIT^QAPPT1
 W @IOF,! S QAPHDR="Survey Title: "_TITLE X QAPBAR S QAPHDR="Printing a "_$S(ACTION="D":"Draft",1:"Final")_" Copy" X QAPBAR
 S %ZIS="AEQ",%ZIS("A")="Output device: " D ^%ZIS G:POP EXIT^QAPPT1
 I $D(IO("Q")) S ZTREQ="@",ZTIO=ION,ZTRTN="PRINT^QAPPT1",ZTDESC="Print "_TITLE_" Survey" F X="SURVEY","TITLE","USER","ACTION" S ZTSAVE(X)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Queued as task #",ZTSK,!! H 2 K ZTSK G EXIT^QAPPT1
 G ^QAPPT1
