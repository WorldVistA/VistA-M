DGRUPAR ; ALB/SCK - RAI/MDS PARAMETER ENTRY/EDIT ; 13 OCT 99
 ;;5.3;Registration;**190**;Aug 13, 1993
 ;
WR ;
 N DGHEAD,DGMULT,DGX
 ;
 S U="^",DGHEAD="RAI/MDS COTS PARAMETER ENTRY/EDIT",IOP="HOME" D ^%ZIS K IOP
 W @IOF,!?22,DGHEAD,! S X="",$P(X,"=",79)="" W X
 ;
 S DGMULT=$$GET1^DIQ(43,1,11,"I")
 ;
 W !?4,"Send HL7 V2.3 Messages     : ",$$GET1^DIQ(43,1,391.7013),!
 S DGX=$$GET1^DIQ(43,1,391.705)
 W !,"[1] RAI Integrated Site        : ",$S(DGX]"":DGX,1:"NO")
 W !?4,"Create Master File Updates : ",$$GET1^DIQ(43,1,391.7014)
 ;
DIVSN ;
 N DGI
 W !!,"[2]" I DGMULT W ?4,"Divisions: "
 F DGI=0:0 S DGI=$O(^DG(40.8,DGI)) Q:'DGI  S DGX=$P(^(DGI,0),U,1)_$S($P(^(0),U,2)]"":" ("_$P(^(0),U,2)_"), ",1:"") W:$L(DGX)>(65-$X) !?15 W DGX
 ;
EDT ;
 W !
 S DIR(0)="FAO"
 S DIR("A")="Enter "_$S(DGMULT:"'D' to view DIVISIONS, ",1:"")_"1-2 to EDIT, or RETURN to QUIT: "
 D ^DIR K DIR
 Q:$D(DIRUT)
 I "dD"[Y D DIV
 I Y?1N D @Y
 ;D CONT
 G WR
 Q
 ;
DIV ;
 N DGDIV
 D DGHDV
 F DGDIV=0:0 S DGDIV=$O(^DG(40.8,DGDIV)) Q:'DGDIV  D
 . S DGD=$$GET1^DIQ(40.8,DGDIV,.01)
 . W !,DGD,! S X="",$P(X,"-",$L(DGD))="" W X
 . W !?4,"RAI Subscription Registry : ",$$GET1^DIQ(40.8,DGDIV,900.01),!
 . I ($Y+8)>IOSL D
 . . D CONT,DGHDV
 Q
 ;
1 ;
 N DIE,DA
 ;
 S DIE=43,DA=1,DR="[DGRAI]"
 D ^DIE K DIE
 Q
 ;
2 ;
 N DIE,DIC,DR,DA
 ;
 I 'DGMULT D
 . S DGDIV=$$GET1^DIQ(43,1,12,"I")
 . S DIE=40.8,DR="900.01;"
 . D ^DIE K DIE
 ;
 I DGMULT D
 . S DIC=40.8,DIC(0)="AEQM" D ^DIC Q:Y'>0
 . S DIE=DIC,DA=+Y,DR="900.01;" D ^DIE K DIE
 Q
 ;
DGHDV ;
 W @IOF,!,"Division RAI/MDS Parameters",! S X="",$P(X,"=",79)="" W X
 Q
 ;
CONT S DIR(0)="FAO",DIR("A")="Press any key to continue" D ^DIR K DIR
 Q
