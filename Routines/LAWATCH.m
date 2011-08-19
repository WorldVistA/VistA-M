LAWATCH ;SLC/RWF/FHS - WATCH DATA IN ^LA GLOBAL ;8/8/89  11:36 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
IN ;DALISC/TNN - Query user for ^LA or ^LAH - 02/02/93
 K DIR S DIR(0)="SO^1:RAW DATA IN LA GLOBAL;2:VERIFIABLE DATA IN LAH GLOBAL",DIR("A")="Select a File to watch"
 D ^DIR K DIR Q:$D(DIRUT) 
 I X=2 D  G IN
 . D ^LAHWATCH
 . QUIT 
 ;DALISC/TNN - End of query
START S U="^" W !,"THIS ROUTINE WILL ALLOW YOU TO WATCH THE ACCUMULATION",!," OF DATA IN THE ^LA GLOBAL"
 K DIC S DIC="^LAB(62.4,",DIC(0)="AEMQ",DIC("S")="I Y<100" D ^DIC G QUIT:Y<1 S LRTSK=+Y,LRINST=$P(Y,"^",2)
DOWN W !?7,"Do you wish to See 'Download data' " S %=1 D YN^DICN G QUIT:%<1 I %=1 D LA0
DATA W !!?7,"Do you wish to look at 'Upload' data nodes " S %=1 D YN^DICN G QUIT:%<1!(%=2) S LANODE="I"
LA1 G LA2:$D(^LA(LRTSK,"I",0)),NOTSYS:LRTSK#10=1,NOSYS:$D(^LA(+(LRTSK-1\10_1),"I",0))[0
 W !?3,"There isn't any data there! Should I start saving the data" S %=2 D YN^DICN G QUIT:%=2!(%=-1) W !,"This will prevent the automatic processing of the data." G LA1:%=0
 I '$D(^LA(LRTSK,"I",0))#2 S ^LA(LRTSK,"I")=0,^("I",0)=0 W !!?10,$C(7),"YOU MUST MANUALLY START THE ( "_$P(^LAB(62.4,LRTSK,0),U,3)_") PROGRAM " G QUIT
LA2 R !?5,"Begin with what number ? ",I7:DTIME Q:'$T!(I7="^")  S I7=+I7 I '$D(^LA(LRTSK,LANODE,I7)) W $C(7),!?10,I7," DOES NOT EXIST ",! G LA2
LA3 W !!!,LRINST,!," Number of Records: ",$S($D(^LA(LRTSK,LANODE))#2:^(LANODE),1:"??"),?$X+5,"Processed Records: ",$S($D(^LA(LRTSK,LANODE,0))#2:^(0),1:"??") W:$D(^LA("LOCK",LRTSK)) " Active flag SET."
 R !!?7,"To stop data display enter '^'  ENTER RETURN TO CONTINUE ",X:DTIME G QUIT:X="^"
 S I=I7-.1 F I=I7-.1:0 S I=$O(^LA(LRTSK,LANODE,I)) Q:I=""  Q:('$D(^LA(LRTSK,LANODE,I)))  W !,"^LA(",LRTSK,",",LANODE,",",I,")=",^(I) S I7=I R X:.01 I X="^" Q
 R !!,"PRESS RETURN TO CONTINUE, ENTER '^' TO STOP. ",X:DTIME G END:'$T,LA2:X=""
 Q:LANODE="O"
END G QUIT:LRTSK#10=1 W !,"CLEAR INSTRUMENT ",LRINST," DATE IN ^LA(",LRTSK,") FIRST" S %=2 D YN^DICN I %=1 K ^LA(LRTSK)
 I %<1 S XQH="LRHC LRWATCH" D EN^XQH G END
 W:%'=1 !,"Be sure to startup the instrument routine from the menu.",!?10,"It will NOT start on its own now."
QUIT K DIC,T,LANODE,%,ER,I7 Q 
NOTSYS W !!,"You can't start saving data for a interface routine." G QUIT
NOSYS W !!,"The LAB routine for the instrument isn't running so there",!,"is no need to continue as data will never arrive." G QUIT
LA0 ;View down load data for instrument
 I '$D(^LA(LRTSK,"O")) W !?7,"There is no down load data " R !," PRESS RETURN TO CONTINUE ",X:DTIME Q
 S LANODE="O" D LA2
DONE Q 
