GMRAPEL0 ;HIRMFO/YMP,WAA-EDIT LIKELIHOOD ; 8/25/92
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
EN1 ;ENTRY FROM MAIN TO EDIT THE LIKELIHOOD OF REACTION FIELD USING THE FDA
 ;ALGORITHM
 Q:$G(GMRASUS)<1
 Q:GMRAPA1'>0
 W !!,"DETERMINATION OF LIKELIHOOD OF ALLERGY/ADVERSE REACTION:"
 S GMRAPA("LIKE")=$P($G(^GMR(120.85,GMRAPA1,3,GMRASUS,"LIKE")),"^",7)
 I GMRAPA("LIKE")>0 W !?2,"The likelihood of this reaction was previously determined as ",$S(GMRAPA("LIKE")=1:"REMOTE",GMRAPA("LIKE")=2:"POSSIBLE",GMRAPA("LIKE")=3:"PROBABLE",GMRAPA("LIKE")=4:"HIGHLY PROBABLE",1:""),"."
YNED W !,?2,"Would you like to enter/edit Likelihood" S %=2 D YN^DICN S:%=-1 GMRAOUT=1 G:%=2!GMRAOUT EXIT
 I '% W !?5,$C(7),"ANSWER YES IF YOU WISH TO CHANGE THIS LIKELIHOOD, ELSE ANSWER NO." G YNED
QUEST1 S GMRALIKB=$S($D(^GMR(120.85,GMRAPA1,3,GMRASUS,"LIKE")):$P(^("LIKE"),"^",1,6),1:""),GMRALIKA=""
 W !?2,"Does the event have a reasonable temporal association with use of drug"
 S %=$F("yn",$P(GMRALIKB,"^"))-1 D YN^DICN D:%=0 HELP G:%=0 QUEST1 S:%=-1 GMRAOUT=1 G:GMRAOUT EXIT
 I %=2 S GMRAFDA=1,$P(GMRALIKA,"^")="n" G SETTING
 E  S $P(GMRALIKA,"^")="y"
QUEST2 W !?2,"Was there a dechallenge from the drug"
 S %=$F("yn",$P(GMRALIKB,"^",2))-1 D YN^DICN D:%=0 HELP G:%=0 QUEST2 S:%=-1 GMRAOUT=1 G:GMRAOUT EXIT
 I %=2 S GMRAFDA=2,$P(GMRALIKA,"^",2)="n" G SETTING
 E  S $P(GMRALIKA,"^",2)="y"
QUEST3 W !?2,"Did the observed event abate upon dechallenge"
 S %=$F("yn",$P(GMRALIKB,"^",3))-1 D YN^DICN D:%=0 HELP G:%=0 QUEST3 S:%=-1 GMRAOUT=1 G:GMRAOUT EXIT
 I %=2 S GMRAFDA=2,$P(GMRALIKA,"^",3)="n" G SETTING
 E  S $P(GMRALIKA,"^",3)="y"
QUEST4 W !?2,"Was there a rechallenge"
 S %=$F("yn",$P(GMRALIKB,"^",4))-1 D YN^DICN D:%=0 HELP G:%=0 QUEST4 S:%=-1 GMRAOUT=1 G:GMRAOUT EXIT
 I %=2 S $P(GMRALIKA,"^",4)="n" G LAST
 E  S $P(GMRALIKA,"^",4)="y"
QUEST5 W !?2,"Did the reaction or event reappear upon rechallenge"
 S %=$F("yn",$P(GMRALIKB,"^",6))-1 D YN^DICN D:%=0 HELP G:%=0 QUEST5 S:%=-1 GMRAOUT=1 G:GMRAOUT EXIT
 I %=2 S GMRAFDA=2,$P(GMRALIKA,"^",6)="n" G SETTING
 S GMRAFDA=4,$P(GMRALIKA,"^",6)="y" G SETTING
LAST W !?2,"Could the event be due to an existing clinical condition"
 S %=$F("yn",$P(GMRALIKB,"^",5))-1 D YN^DICN D:%=0 HELP G:%=0 LAST S:%=-1 GMRAOUT=1 G:GMRAOUT EXIT
 I %=2 S GMRAFDA=3,$P(GMRALIKA,"^",5)="n"
 S:%'=2 GMRAFDA=2,$P(GMRALIKA,"^",5)="y"
SETTING ;
 W !,"THE LIKELIHOOD IS DETERMINED AS ",$S(GMRAFDA=1:"REMOTE",GMRAFDA=2:"POSSIBLE",GMRAFDA=3:"PROBABLE",GMRAFDA=4:"HIGHLY PROBABLE",1:""),":"
 W !,"IS THAT OK" S %=1 D YN^DICN G:%=2 QUEST1
 I '% W !?4,$C(7),"Answer Yes if this is correct, else answer No." G SETTING
 S DIE="^GMR(120.85,"_GMRAPA1_",3,",DA(1)=GMRAPA1,DA=GMRASUS,DR="" F X=11:1:16 S DR=DR_$S($P(GMRALIKB,"^",X-10)'="":$S(DR'="":";",1:"")_X_"///@",1:"")
 D ^DIE
 F X=11:1:16 S DR=DR_$S($P(GMRALIKA,"^",X-10)'="":$S(DR'="":";",1:"")_X_"///"_$P(GMRALIKA,"^",X-10),1:"")
 D ^DIE
 S DIE="^GMR(120.85,"_GMRAPA1_",3,",DA(1)=GMRAPA1,DA=GMRASUS,DR="17///"_GMRAFDA D ^DIE
 G EXIT
HELP ;
 W !?5,$C(7),"ENTER YES IF THIS QUESTION IS TRUE, ELSE ANSWER NO."
 Q
EXIT K %,DA,DIE,DR,GMRAFDA,GMRALIKA,GMRALIKB,X
 Q
