QAPPRALL ;557/THM-PRINT ALL RESPONSES [ 06/19/95  12:49 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN K USERPRT W @IOF,! S QAPHDR="Print All Survey Responses" X QAPBAR S QAPHDR="Survey Selection" X QAPBAR
 W !!,"This program will print all responses to the selected survey",!,"individually.  ",BLDON,"You must use your own judgement when printing",!,"long surveys because of the possible length of the printout.",BLDOFF,!!!
 K DIC S DIC("S")="I $P(^(0),U,5)=DUZ!($D(^XUSEC(""QAP MANAGER"",DUZ)))!($D(^QA(748,""AB"",DUZ,+Y)))"
 S DIC="^QA(748,",DIC(0)="AEQMZ",DIC("A")="Select a survey: " D ^DIC K DIC G:X=""!(X[U) EXIT^QAPUTIL
 K DIC S SURVEY=+Y,TITLE=$P(^QA(748,SURVEY,0),U,6)
 S TOTPART=0 F PART=0:0 S PART=$O(^QA(748.3,"B",SURVEY,PART)) Q:PART=""  I $P(^QA(748.3,PART,0),U,3)="c" S TOTPART=TOTPART+1
 W !!,*7,"There ",$S(TOTPART=1:"is ",1:"are "),TOTPART,$S(TOTPART=1:" response",1:" responses")," to this survey.",!
 W ! S %ZIS="AEQ",%ZIS("A")="Output device: " D ^%ZIS G:POP EXIT^QAPUTIL
 I $D(IO("Q")) S ZTREQ="@",ZTIO=ION,ZTRTN="PRINT^QAPPRALL",ZTDESC="Print All Respones for "_TITLE_" Survey" F X="SURVEY","TITLE" S ZTSAVE(X)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Queued as task #",ZTSK,!! H 2 K ZTSK G EXIT^QAPUTIL
 ;
PRINT S QAPOUT=0,QAPDUZ="",USERPRT=1 F  S QAPDUZ=$O(^QA(748.3,"AC",QAPDUZ)) Q:QAPDUZ=""!(QAPOUT=1)  F FILEDA=0:0 S FILEDA=$O(^QA(748.3,"AC",QAPDUZ,SURVEY,FILEDA)) Q:FILEDA=""!(QAPOUT=1)  W:IOST?1"P-".E @IOF,! D USERPRT^QAPPT1
 G EXIT^QAPUTIL
