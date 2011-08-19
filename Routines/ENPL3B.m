ENPL3B ;(WASH ISC)/LKG-PRINT MINOR DESIGN/MISC PRIORITY SHEET ;7/8/94
 ;;7.0;ENGINEERING;**11**;Aug 17, 1993
D W !!,"2. Safety: Handicapped (UFAS), EPA/NRC, Fire/Safety (RSFPE), OSHA."
 W !,?6,"Date",?19,"Page",?29,"Name/Title" S ENA=""
 F  S ENA=$O(ENF(2,ENA)) Q:ENA=""  W !,?2,"(",ENA,")",?6,$P(ENF(2,ENA),U),?19,$P(ENF(2,ENA),U,2),?29,$P(ENF(2,ENA),U,3)
 W !,?70,$J($P($G(ENF),U,2)+0,2) K ENF(2)
 W !!,"3. Space:",!,?5,$S(+ENK>0:$P($G(ENG),U,2),1:"Not Applicable"),?70,$J($G(ENK)+0,2)
 I $Y+5>IOSL D HD G:X["^" EX0
 W !!,"4. Energy Conservation:",!,?5,$S($P(ENK,U,2)>0:$P($G(ENH),U,2),1:"Not Applicable")
 W ?70,$J($P($G(ENK),U,2)+0,2)
 I $Y+7>IOSL D HD G:X["^" EX0
 W !!,"5. Category Bonus (Scope Dependent):"
 W !,?5,$S($P(ENK,U,3)>0:$P($G(ENI),U,2),1:"Not Applicable"),?70,$J($P($G(ENK),U,3)+0,2)
 W !!,?53,"FACTOR SUBTOTAL",?70,$J($G(ENF)+$P($G(ENF),U,2)+$G(ENK)+$P($G(ENK),U,2)+$P($G(ENK),U,3),2)
 I $Y+5>IOSL D HD G:X["^" EX0
 W !!,"6. VAMC Priority: [Rank and Submit ",$S(ENN="MI":"2 Minor Design projects",1:"no more than 4 Minor Misc"),"]"
 W !,?5,$P($G(ENJ),U,2),?70,"UNK" ; $J($G(ENJ)+0,2)
 ; W !!,?46,"VAMC & FACTOR SUBTOTAL",?70,$J($G(ENX)+0,2)
 I '$D(ZTQUEUED),$E(IOST,1,2)="C-" R X:DTIME G EX0
 ;S ENM="",$P(ENM,"*",78)="" W !!!,ENM,!!! K ENM
 ;W !,"Region to Complete:"
 ;W !!,"7. Priority Equipment: High Technology/High Cost [Must be one of Region's"
 ;W !,"top 5 priorities on Over $250K nat'l priority list; equipment name/cost should"
 ;W !,"be listed above]",!,?15,"YES = 10",?35,"NO = 0",!,?70,"_____"
 ;W !!,"8. Region Priority: [Rank and Submit ",$S(ENN="MI":"12 Minor Design",1:"35 Minor Miscellaneous"),"]"
 ;W !,?15,"Priority:",?25,$S(ENN="MI":"1-------12",1:"1-------35"),!,?15,"Points",?25,$S(ENN="MI":"36-------3",1:"70-------2"),?45,"[increment=",$S(ENN="MI":3,1:2),"]"
 ;W ?70,"_____",!!!!!,?58,"TOTAL SCORE",?70,"_____"
 ;F ENM=1:1:(IOSL-3-$Y) W !
 ;W !,?29,"Minor Attachment ",$S(ENN="MI":"B.1-2",1:"B.2-2"),!,?35,"Rev 1/5/93"
EX0 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
EX K DIC,DIQ,DR,DTOUT,DUOUT,DA,ENDA,ENA,ENB,ENC,END,ENE,ENF,ENG,ENH,ENI,ENJ,ENK,ENL,ENM,ENN,ENX,X,Y
 Q
HD ; Subsequent Page Header
 I '$D(ZTQUEUED),$E(IOST,1,2)="C-" R X:DTIME Q:X["^"
 W @IOF
 W !,?55,"Project #: ",$P($G(^ENG("PROJ",ENDA,0)),U)
 Q
