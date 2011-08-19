DGPMGL5 ;ALB/MRL - G&L PARAMETER ENTRY/EDIT; 29 APR 2003
 ;;5.3;Registration;**515**;Aug 13, 1993
EN ;
 D DIS,ASK
 I Y D EDIT G EN
 Q
 ;
DIS ; -- display params
 S DGPM=$S($D(^DG(43,1,"G")):^("G"),1:""),U="^" D DT^DICRW
 S IOP="HOME" D ^%ZIS K IOP
 W @IOF,!?27,"ENTER/EDIT G&L PARAMETERS",! K I S $P(I,"=",80)="" W I
 W !,"G&L Initialization Date",?43,": " S Y=$P(DGPM,"^",1) X:Y ^DD("DD") W $S(Y]"":Y,1:"NOT SPECIFIED")
 W !,"TSR Initialization Date",?43,": " S Y=$P(DGPM,"^",11) X:Y ^DD("DD") W $S(Y]"":Y,1:"NOT SPECIFIED")
 W !,"SSN Format",?43,": DISPLAY ",$S($P(DGPM,"^",2)=6:"LAST FOUR ONLY",$P(DGPM,"^",2)=1:"ENTIRE SSN",1:"FORMAT UNSPECIFIED")
 W !,"Means Test Copay Applicability Display",?43,": ",$S($P(DGPM,"^",3):"YES",1:"NO")
 W !,"Patient's Treating Specialty (Display)",?43,": ",$S($P(DGPM,"^",4):"YES",1:"NO")
 ;W !,"Display Names in Two or Three Columns",?43,": ",$S($P(DGPM,"^",5)=3:"THREE",1:"TWO")
 W !,"Show Non-Movements on G&L",?43,": ",$S($P(DGPM,"^",6):"YES",1:"NO")
 W !,"Recalculate From (Earliest Date to Recalc)",?43,": " S Y=$P(DGPM,"^",7) X:Y ^DD("DD") W $S(Y]"":Y,1:"UNSPECIFIED")
 W !,"Count Vietnam Vets Remaining",?43,": ",$S($P(DGPM,"^",8):"YES",1:"NO")
 W !,"Count Over 65'S Remaining (patients>65 y/o)",?43,": ",$S($P(DGPM,"^",9):"YES",1:"NO")
 ;W !,"Default Treating Specialty",?43,": ",$S($D(^DIC(45.7,+$P(DGPM,"^",10),0)):$P(^(0),"^",1),1:"NOT SPECIFIED")
 W !,"Days to Maintain G&L Corrections",?43,": ",$S($D(^DG(43,1,0)):+$P(^(0),U,29),1:0)
 K I S $P(I,"=",80)="" W !,I
 K I,DGPM Q
 ;
ASK ;
 S DIR(0)="Y",DIR("A")="Do you want to edit these parameters",DIR("B")="YES"
 S DIR("?",1)=" 'Yes' to edit the G&L parameters"
 S DIR("?",2)=" 'No'  to not edit and quit"
 S DIR("?")=" "
 D ^DIR K DIR
 Q
 ;
EDIT ; -- edit params
 W ! S DIE="^DG(43,",DA=1 S DR="1000.01;1000.11;1000.02:1000.04;1000.06:1000.09;5.5" D ^DIE
 K DR,DIE,DA,DQ,DG,DE
 Q
