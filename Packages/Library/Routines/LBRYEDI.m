LBRYEDI ;ISC2/DJM-FILE 680 ADDITIONAL EDIT OPTIONS ;[ 05/23/97  12:13 PM ]
 ;;2.5;Library;**2,9**;Mar 11, 1996
 ;
HOL I $G(LBRYPTR)="" D  I $G(LBRYPTR)="" W !!,$C(7),"No Site has been selected" Q
 . D ^LBRYASK
 W @IOF,"VA Library Serials Holdings Edit for "_LBRYNAM
 S Y=DT X ^DD("DD") S YDT=Y W ?60,Y,!
 S DIC="^LBRY(680,",DIC(0)="AEMQZ",DIC("S")="I $P(^(0),U,4)=LBRYPTR&($P(^(0),U,2)="""")"
 D ^DIC
 G:Y<0 EXIT S (DA,LBRYLOC)=$P(Y,U),LBRYCLS=$P(Y,U,2)
 S LA0="TITLE: "_$P(^LBRY(680.5,LBRYCLS,0),U),DA=LBRYLOC
 W @IOF,?5,"VA Library Serials Bibliographic Edit",?60,YDT,!!,LA0,!!
 S DIE="^LBRY(680,",DR=$S($D(LBRYPTR)&($P($G(^LBRY(680.6,LBRYPTR,0)),U,10)):"[LBRY BIBLIOGRAPHIC 2 ENTRY]",1:"[LBRY BIBLIOGRAPHIC ENTRY]"),DIC=DIE
 D LOCK^LBRYEDR G:LBRYL=0 EXIT D ^DIE K DIE,DR L
 G HOL
PIE I $G(LBRYPTR)="" D  I $G(LBRYPTR)="" W !!,$C(7),"No Site has been selected" Q
 . D ^LBRYASK
 W @IOF,"VA Library Serials Purchasing Information for "_LBRYNAM
 S Y=DT X ^DD("DD") S YDT=Y W ?60,Y,!
 S DIC="^LBRY(680,",DIC(0)="AEMQZ",DIC("S")="I $P(^(0),U,4)=LBRYPTR&($P(^(0),U,2)="""")"
 D ^DIC
 G:Y<0 EXIT S (DA,LBRYLOC)=$P(Y,U),LBRYCLS=$P(Y,U,2)
 S LA0="TITLE: "_$P(^LBRY(680.5,LBRYCLS,0),U),DA=LBRYLOC
 W @IOF,?5,"VA Library Serials Purchasing Information",?60,YDT,!!,LA0,!!
 S DIE="^LBRY(680,",DR="[LBRY FINANCIAL ENTRY]",DIC=DIE
 D LOCK^LBRYEDR G:LBRYL=0 EXIT D ^DIE K DIE,DR L
 G PIE
EXIT K DIC,DIE,YDT,LA0,DR,LBRYL,LBRYCLS,LBRYLOC,LBRTDA
 Q
NTIT ;  Special cross-reference for new titles
 I $G(LBRYNEW)=1 S $P(^LBRY(680,DA,5),U)=DT I $D(^LBRY(680.5,LBRYCLS,0)) S $P(^(0),U,2)=1
 Q
