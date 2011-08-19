RAMAIN ;HISC/FPT,GJC,CAH AISC/MJK,RMO;VMP/PW-Utility File Maintenance ;7/24/02  14:45
 ;;5.0;Radiology/Nuclear Medicine;**31,43,50,54,87**;Mar 16, 1998;Build 2
 ;
 ; 11/15/07 BAY/KAM RA*5*87 Rem Call 205080 Option File Access
3 ;;Major AMIS Code Enter/Edit
 N RAI F RAI=1:1:5 W !?9,$P($T(REMIND+RAI),";;",2)
 S DIR(0)="Y",DIR("B")="No"
 S DIR("A")="          add/change any AMIS codes and weight"
 S DIR("A",1)="          Do you have approval from Radiology Service VACO to"
 D ^DIR K DIR Q:$D(DIRUT)  Q:'Y
L3 S DIC="^RAMIS(71.1,",DIC(0)="AEMQ" W ! D ^DIC K DIC I Y<0 K D,X,Y,DDH,I,POP,DISYS Q
 S DA=+Y,DIE="^RAMIS(71.1,",DR=".01;2" D ^DIE K %,%W,%Y,D0,DA,DE,DQ,DIE,DR,DI,I,POP G L3
REMIND ;;
 ;;+----------------------------------------------------------+
 ;;| New entries and modifications to existing entries are    |
 ;;| prohibited without approval from Radiology Service VACO. |
 ;;+----------------------------------------------------------+
 ;
4 ;;Film Type Enter/Edit
 K DD,DIC,DLAYGO,DO
 S DIC="^RA(78.4,",DIC(0)="AEMQL",DLAYGO=78.4 W ! D ^DIC
 K DD,DIC,DLAYGO,DO
 I +Y<0 D  D Q4 Q
 . D DSPLNKS^RAMAIN1
 . K D,DI,X,Y
 . Q
 S DA=+Y,DIE="^RA(78.4,",DR=".01;2;3;4;5;S:+X'=1 Y=""@1"";6;@1"
 D ^DIE S RA784=$G(^RA(78.4,DA,0)),RA784(1)=$P(RA784,U)
 S RA784(5)=+$P(RA784,U,4),RA784(6)=$P(RA784,U,5)
 I RA784(5),(RA784(6)']"") D
 . N DIE,DR
 . W !!?5,$C(7),"'"_RA784(1)_"' has been defined as a wasted film size."
 . W !?5,"If a particular film size is deemed as a wasted piece of"
 . W !?5,"film, the wasted piece of film must be associated with an"
 . W !?5,"unwasted piece of film."
 . W !!?5,"Redefining '"_RA784(1)_"' as an unwasted film size."
 . S DIE="^RA(78.4,",DR="5///@" D ^DIE W "   Done!"
 . Q
 K %,D0,DA,DE,DQ,DIE,DR,RA784,X,Y G 4
Q4 K I,POP,DISYS,DDH
 Q
 ;
5 ;;Diagnostic Code Enter/Edit
 S DIC="^RA(78.3,",DIC(0)="AEMQL",DLAYGO=78.3 W ! D ^DIC K DIC,DLAYGO I Y<0 K D,X,Y,POP,I Q
 S DA=+Y,DIE="^RA(78.3,",DR="2:5" D ^DIE K %,D0,DA,DE,DQ,DIE,DR,I,DI G 5
 ;
6 ;;Flash Card/Label Formatter
 W:'$D(RAFLH) !!?5,">>> Exam Label/Report Header/Report Footer/Flash Card Formatter <<<"
 S DIC="^RA(78.2,",DIC(0)="AEMQL",DLAYGO=78.2 W ! D ^DIC K DIC,DLAYGO G Q6:Y<0 S (RAFLH,DA)=+Y,DIE="^RA(78.2,",DR="[RA FLASH CARD EDIT]" D ^DIE K DE,DQ,DIE,DR I '$D(^RA(78.2,RAFLH,0)) G Q6
 S RAFMT=RAFLH,RAK=0
 F  S RAK=$O(^RA(78.7,RAK)) Q:RAK'>0  D SETFLH^RAFLH2(RAK)
 D CMP^RAFLH1
 W !!,"<<<<<<----------------------------Column No.------------------------------>>>>>>"
 W !!,"0--------1---------2---------3---------4---------5---------6---------7---------8"
 W !,"1        0         0         0         0         0         0         0         0",! S RATEST="",RANUM=1,RAFFLF="!" D PRT^RAFLH K RAFFLF W !! G 6
Q6 S RAK=0 F  S RAK=$O(^RA(78.7,RAK)) Q:RAK'>0  D KILFLH^RAFLH2(RAK)
 K %,%W,%X,%Y,D,D0,D1,DA,FL,RA787,RATEST,RAII,RAK,RAFLH,RAFMT,RANUM,X,Y
 K POP,I,DDH,DUOUT,DI,DISYS
 Q
 ;
7 ;;Complication Type Enter/Edit
 S DIC="^RA(78.1,",DIC(0)="AEMQL",DLAYGO=78.1 W ! D ^DIC K DIC,DLAYGO I Y<0 K D,X,Y G Q7
 S DA=+Y,DIE="^RA(78.1,",DR=".01;2" D ^DIE K %,D,D0,DA,DE,DQ,DIE,DR D Q7 G 7
Q7 K DI,DISYS,I,POP Q
 ;
8 ;;Sharing/Contract Agreement Entry/Edit
 S DIC="^DIC(34,",DIC(0)="AELMQ",DIC("A")="Select Agreement/Contract: ",DLAYGO=34 W ! D ^DIC K DIC,DLAYGO I Y<0 K D,X,Y,I,POP Q
 S DA=+Y,DIE="^DIC(34,",DR=".01:3" D ^DIE K %,%W,%X,%Y,D,D0,DA,DE,DQ,DIE,DR,X,Y,DI,DISYS G 8
 ;
9 ;;Standard Reports
 S DIC="^RA(74.1,",DIC(0)="AEMQL",DLAYGO=74.1 W ! D ^DIC K DIC,DLAYGO I Y<0 K D,X,Y D Q9 Q
 S DA=+Y,DIE="^RA(74.1,",DR="[RA STANDARD REPORT ENTRY]" D ^DIE K %,%W,%X,%Y,C,D,D0,DA,DE,DQ,DIE,DR,X,Y D Q9 G 9
Q9 K DDH,DI,DISYS,I,J,POP
 Q
 ;
10 ;;Procedure Modifiers Entry
 K DD,DO,DLAYGO,DIC,DA,DINUM,X,Y
 ;S (DIC,DLAYGO)="^RAMIS(71.2,",DIC(0)="AEMQL"
 ; 11/15/07 BAY/KAM RA*5*87 Rem Call 205080 Changed next line to set DLAYGO equal to the file number instead of the file root
 S DIC="^RAMIS(71.2,",DLAYGO=71.2,DIC(0)="AEMQL"
 S DIC("A")="Select Procedure Modifier: ",DIC("W")="D PROHLP^RAMAIN"
 W ! D ^DIC K DIC,DLAYGO I +Y'>0 K D,X,Y,POP,I,DDH,DG,DISYS,DUOUT Q
 S DIE="^RAMIS(71.2,",DA=+Y,DR="3;4" D ^DIE
 K %W,%X,%Y,D,DIE,DO,DD,DLAYGO,DA,DR,X,Y,POP,I,D0,DI,DISYS,DQ,C G 10
 ;
11 ;;Reports Distribution Edit
 S DIC="^RABTCH(74.3,",DIC(0)="AEMQ" W ! D ^DIC K DIC I Y<0 K D,X,Y,I,POP Q
 S DA=+Y,DIE="^RABTCH(74.3,",DR="[RA DISTRIBUTION EDIT]" D ^DIE K %,%W,%X,%Y,D,D0,DA,DE,DQ,DIE,DR,X,Y,DI,DISYS,I,POP G 11
 ;
12 ;;Rad/Nuc Med Procedure Message Enter/Edit
 S DIC="^RAMIS(71.4,",DIC(0)="AELMQ",DLAYGO=71.4
 W ! D ^DIC K DIC,DLAYGO I Y<0 K D,DTOUT,DUOUT,X,Y Q
 S DA=+Y
 L +^RAMIS(71.4,DA):3 I '$T D  G 12 ;*54
 . K DIR S DIR(0)="EA",DIR("A")="Sorry, someone else is editing that entry. <cr> - continue " D ^DIR K DIR
 K RAMLNA,RAMLNB S RAMSGDA=DA ;*50
 S RAMLNA=$G(^RAMIS(71.4,DA,0)) ;*50
 S DIE="^RAMIS(71.4,",DR=.01 D ^DIE
 S RAMLNB=$G(^RAMIS(71.4,+$G(DA),0)) ;*50
 I RAMLNB'=RAMLNA S DA=RAMSGDA D ORDITMS^RAMAIN3 ;*50
 L -^RAMIS(71.4,RAMSGDA) ;*54
 K %,%W,%X,%Y,D0,DA,DE,DQ,DR,DIE,X,Y,RAMLNA,RAMLNB,RAMSGDA
 G 12
 ;
13 ;;Cost of Procedure Enter/Edit
 I '$D(RACCESS(DUZ)) D SET^RAPSET1 I $D(XQUIT) K RACCESS,XQUIT Q
 ; ask img type
 K ^TMP($J,"RA I-TYPE") D SELIMG^RAUTL7 G:$G(RAQUIT) 139
 N RA0,RA1,RA2 S RA0="",RA2=""
131 S RA0=$O(^TMP($J,"RA I-TYPE",RA0)) G:RA0="" 133
132 S RA1=$O(^TMP($J,"RA I-TYPE",RA0,0)) G:'RA1 131
 S RA2=RA1_U_RA2 G 131
133 G:RA2="" 139 S DIC="^RAMIS(71,",DIC(0)="AEMQ"
 ; restrict choice of procedure by img type selected
 S DIC("S")="I RA2[$P(^(0),U,12)"
 W ! D ^DIC K DIC I Y<0 K %,DTOUT,DUOUT,DIC,X,Y G 139
 S DA=+Y,DIE="^RAMIS(71,",DR=10 D ^DIE
 K D,D0,DA,DDH,DI,DIC,DIE,DQ,DR,X
 G 133
139 K ^TMP($J,"RA I-TYPE"),RAQUIT
 Q
 ;
PROHLP ; Help displays the modifiers and all associated imaging types.
 D:'$D(IOM) HOME^%ZIS
 N RAIT,RAIT1,RAIT2,RAIT3 Q:'+$O(^RAMIS(71.2,+Y,1,0))  ; Quit, no data
 S (RAIT,RAIT3)=0
 F  S RAIT=+$O(^RAMIS(71.2,+Y,1,RAIT)) W:'RAIT ")" Q:'RAIT  D
 . S RAIT1=+$G(^RAMIS(71.2,+Y,1,RAIT,0))
 . S RAIT2=$P($G(^RA(79.2,RAIT1,0)),"^",3)
 . W:($X+5)>IOM !?2 W ?$X+1 W:'RAIT3 "(" W RAIT2 S RAIT3=1
 . Q
 Q
