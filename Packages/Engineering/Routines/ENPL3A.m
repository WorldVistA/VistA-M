ENPL3A ;(WASH ISC)/LKG-PRINT MINOR DESIGN/MISC PRIORITY SHEET ;4/29/94
 ;;7.0;ENGINEERING;**11**;Aug 17, 1993
A ;Entry point for printing Sheet
 S DIC="^ENG(""PROJ"",",DIC("S")="I "",MI,MM,""[("",""_$P(^(0),U,6)_"",""),$P($G(^(52)),U,6)=""VHA"""
 S DIC(0)="AEQZ",DIC("A")="Select PROJECT NUMBER: " D ^DIC K DIC
 I Y<1!$D(DTOUT)!$D(DUOUT) G EX^ENPL3B
 S ENDA=+Y,ENN=Y(0),%ZIS="PQ" K Y D ^%ZIS G:POP EX^ENPL3B
 I $D(IO("Q")) S ZTRTN="C^ENPL3A",ZTDESC="Printing Minor Design/Misc Prioritization Sheet",ZTSAVE("ENDA")="",ZTSAVE("ENN")="" D ^%ZTLOAD,HOME^%ZIS K IO("Q"),ZTRTN,ZTDESC,ZTSAVE,ZTSK G A
 D C
 G A
C U IO W:$E(IOST,1,2)="C-" @IOF D J^ENPL3 W !,?80-$L(X)\2,X
 K ENM S U="^",DA=$P(ENN,U,4) G:DA'?1.N C1 S DIC="^DIC(4,",DIQ="ENM",DIQ(0)="E"
 S DR=".01" D EN^DIQ1 K DIC,DIQ,DR
 W !!,"Medical Center: ",ENM(4,DA,.01,"E")
C1 I $D(^ENG("PROJ",ENDA,15))#10,$P(^(15),U)]"" W "  (",$P(^(15),U),")"
 W !,"Project Title:",?60,"Project #",!,$P(ENN,U,3),?60,$P(ENN,U)
 S ENN=$P(ENN,U,6)
 K ENM S ENM=$P($G(^ENG("PROJ",ENDA,52)),U) S:ENM?1.N ENM=$P($G(^OFM(7336.8,ENM,0)),U)
 W !!,"Category: ",ENM K ENM
 S DIC="^ENG(""PROJ"",",DA=ENDA,DIQ="ENM",DIQ(0)="E",DR="221;218.1;219;220.1"
 D EN^DIQ1 K DIC,DIQ,DR
 S ENM=ENM(6925,DA,221,"E")+ENM(6925,DA,218.1,"E")+ENM(6925,DA,219,"E")
 W !!,"TOTAL ESTIMATED:  Construction Cost: ",$FN(ENM,",")
 W ?55,"Design Cost: ",$FN(ENM(6925,DA,220.1,"E"),",") K ENM
 S ENM=$G(^ENG("PROJ",ENDA,24)) W !!,"Activations FY: ",$P(ENM,U)
 W !,?2,"Additional FTEE Required:",?32,$J($FN($P(ENM,U,3)+0,",",2),11)
 W ?45,"Recurring PS $:",?68,$J($FN($P(ENM,U,4)+0,",",0),11)
 W !,?2,"Non-Recurring All Other $:",?29,$J($FN($P(ENM,U,6)+0,",",0),11)
 W ?45,"Equipment $:",?68,$J($FN($P(ENM,U,5)+0,",",0),11)
 W !,?2,"Travel .007 $:",?29,$J($FN($P(ENM,U,7)+0,",",0),11)
 W ?45,"Recurring all other $:",?68,$J($FN($P(ENM,U,2)+0,",",0),11) K ENM
 W !!,"Major/Minor Funded Projects to which Domino",!,?2,"#",?15,"Title",?70,"Type"
 D H^ENPL3 S X="" F  S X=$O(ENL(X)) Q:X=""  W !,?2,X,?15,$P(ENL(X),U),?70,$P(ENL(X),U,2)
 I '$D(ZTQUEUED),$E(IOST,1,2)="C-" R X:DTIME G:X["^" EX0^ENPL3B W @IOF
 K ENL W !!,"Equipment Over $250K:"
 W:'$O(^ENG("PROJ",ENDA,25,0)) !,?2,"Name:",?40,"A/R:",?50,"Qty:",?62,"$" S X=0
 F  S X=$O(^ENG("PROJ",ENDA,25,X)) Q:X'?1.N  S ENM=$G(^(X,0)) W !,?2,"Name: ",$P(ENM,U),?40,"A/R: ",$P(ENM,U,4),?50,"Qty: ",$P(ENM,U,2),?62,"$",$FN($P(ENM,U,2)*$P(ENM,U,3),",",0)
 K ENM W !!,"Brief Project Description: " K ^UTILITY($J,"W")
 S DIWL=10,DIWR=70,DIWF="W",ENM=0
 F ENA=0:1 S ENM=$O(^ENG("PROJ",ENDA,17,ENM)) Q:ENM'?1.N  S X=$G(^(ENM,0)) D ^DIWP
 D:ENA ^DIWW K ^UTILITY($J,"W"),DIWL,DIWR,DIWF
 I '$D(ZTQUEUED),$E(IOST,1,2)="C-" R X:DTIME G:X["^" EX0^ENPL3B W @IOF
 W !!,?70,"POINTS" D IN^ENPL3
 W !,"1. Cited JCAHO/AALAC/CAP Accreditation Deficiency."
 W !,?6,"Date",?19,"Page",?29,"Name/Title" S ENA=""
 F  S ENA=$O(ENF(1,ENA)) Q:ENA=""  W !,?2,"(",ENA,")",?6,$P(ENF(1,ENA),U),?19,$P(ENF(1,ENA),U,2),?29,$P(ENF(1,ENA),U,3)
 W !,?70,$J($P($G(ENF),U)+0,2) K ENF(1)
 G D^ENPL3B
