ECTPLNK ; B'ham ISC/DMA -Link File 49 Entries to National File ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 ;SELECT ENTER/EDIT CHOICE
CHS W !!,"At this time, you may:",!!,"1.  List the Entries in File 49",!,"2.  Link an Entry from File 49 to an Entry in the National Service File",!,"3.  Print Error Checking Reports",!!,"Select a number (1 -3): "
 R CHS:DTIME G:'$T!("^"[CHS) END I CHS'?1N!(CHS<1)!(CHS>3) W !!,*7,"You MUST answer with a number between 1 and 3." G CHS
 ;BRANCH BASED ON ENTER/EDIT CHOICE
 I CHS=1 D 49 G END
 I CHS=3 D REPORTS Q
 ;
LOC W ! S DIC=49,DIC(0)="QEAMZ",DIC("A")="Select File 49 Entry: " D ^DIC K DIC G END:Y<0 S DA=+Y
 I $P(Y(0),"^",4),$P(Y(0),"^",4)'=DA W !,$P(Y,"^",2)," has been identified as a section of ",$P(^DIC(49,$P(Y(0),"^",4),0),"^")," Service",!,"And should not be linked to a National Service" G LOC
 S DIE=49,DR=730 D ^DIE K DR,DIE,DA G LOC
 ;
END K %,%Y,BY,C,CHS,D0,DHD,DI,DISYS,DQ,FLDS,FR,L,P,POP,TO,X,Y Q
 ;
REPORTS ; reports of problems with file 730, file 49 and links
 ;1.  National service active but no local service
 ;2.  Local service with no national service
 ;3.  Local service or section set for DMMS with no national service
 ;
 W !,"This report will generate three lists of potential problems",!,"found with entries in the National Service File and",!,"connections between that file and the local Service/Section File.",!
DEV S %ZIS="Q",%ZIS("B")="",%ZIS("A")="Select printer for report :  " D ^%ZIS K %ZIS G END:POP I $E(IOST)'="P" W !,"Please select a printer." D ^%ZISC G DEV
 I $D(IO("Q")) S ZTRTN="DEQ^ECTPLNK" D ^%ZTLOAD K ZTRTN G END
 ;
DEQ ;entry to print reports
 U IO W:$Y @IOF W !!,"POTENTIAL PROBLEMS WITH NATIONAL SERVICE FILE",!
 W !!,"REPORT ONE OF THREE",!,"These entries in the National Service File have been identified",!,"as active at your station, but are not associated with a",!,"Service/Section File entry.",!!
 W !,"Use the 'Link File 49 Entries to National File' option",!,"to associate a service/section with these national services."
 W !,"OR",!,"Use the 'Identify Local Services from National File' option",!,"to edit/mark these services as not locally active.",!!
 S OK=1,SER="" F J=0:0 S SER=$O(^ECC(730,"B",SER)) Q:SER=""  F J=0:0 S J=$O(^ECC(730,"B",SER,J)) Q:'J  S SERP=^ECC(730,J,0) I $P(^(0),"^",3),'$D(^DIC(49,"A1",J)) S OK=0 W !,?5,$P(SERP,"^") W:$Y+4>IOSL @IOF,!!
 I OK W !!,"NO PROBLEMS FOUND"
 W @IOF,!!,"REPORT TWO OF THREE",!!,"These entries in your Service/Section File appear to be services",!,"but are not associated with a National Service.",!
 W !,"Use the 'Link File 49 Entries to National File' option",!,"to associate them with a National Service.",!!
 S OK=1,SER="" F J=0:0 S SER=$O(^DIC(49,"B",SER)) Q:SER=""  F J=0:0 S J=$O(^DIC(49,"B",SER,J)) Q:'J  S SERP=^DIC(49,J,0) I '$P(SERP,"^",4),'$D(^DIC(49,"A2",J)) S OK=0 W !,?5,$P(SERP,"^") W:$Y+4>IOSL @IOF,!!
 I OK W !,"NO PROBLEMS FOUND"
 W @IOF,!!,"REPORT THREE OF THREE",!!,"These services or sections in your Service/Section File",!,"have been flagged for use with Event Capture but have not been",!,"associated with a National Service."
 W !!,"Use the 'Identify Local Services from National File' option",!,"to link these services with a National Service.",!!
 S OK=1,SER="" F J=0:0 S SER=$O(^DIC(49,"B",SER)) Q:SER=""  F J=0:0 S J=$O(^DIC(49,"B",SER,J)) Q:'J  S SERP=^DIC(49,J,0),SERV=$P(SERP,"^",4) S:'SERV SERV=J I $D(^DIC(49,J,"EC")),^("EC")]"",'$D(^DIC(49,"A2",J)) S OK=0 W !,?5,$P(SERP,"^") D SERSEC
 I OK W !,"NO PROBLEMS FOUND"
 W @IOF K J,OK,SER,SERP,SERV D ^%ZISC G END
 ;
SERSEC W ?40," ",$S(SERV=J:"(section)",1:"(service)") W:$Y+4>IOSL @IOF,!! Q
 ;
49 ;List entries in 49
 W !,"This report will print a list of local services and sections",!,"found in the 'Service/Section' file #49.",!
 S L=0,DIC=49,FLDS=".01;""FILE ENTRIES""",BY=.01,FR="",TO="zz",DHD="FILE 49 - SERVICE/SECTION REPORT" D EN1^DIP
 Q
