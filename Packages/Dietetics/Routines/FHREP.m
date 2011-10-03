FHREP ; HISC/NCA - Inventory Worksheet and Report ;10/1/93  09:24
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit the Current Inventory QOH
 S OKAY=0,ANS="",CK=1 W ! K DIR S DIR(0)="YAO",DIR("A")="Want to enter Cost along with QOH (Y/N)? " D ^DIR G:$D(DIRUT)!($D(DIROUT)) KIL S:Y OKAY=1
 W ! K DIR S DIR(0)="YAO",DIR("A")="Enter Current QOH by INDIVIDUAL Ingredient (Y/N)? " D ^DIR G:$D(DIRUT)!($D(DIROUT)) KIL K DIR,DIROUT,DIRUT
 I Y=0 K Y S FHR="E" D F1 G:FHXX["^"!("^"[X) KIL D Q1^FHREP1 G REC:CK,KIL
EDIT ; Enter/Edit the Current Inventory
 K DIC,DIE S (DIC,DIE)="^FHING(",DIC(0)="AEQM",DIC("DR")=".01" W ! D ^DIC
 K DIC G KIL:$D(DTOUT),REC:U[X,EDIT:Y<1
 S Z=$P($G(^FHING(+Y,0)),"^",19) I Z'="Y" W *7,"   Inventory NOT specify." G EDIT
 S ZZ=$G(^FHING(+Y,0)),FHD=$P(ZZ,"^",24) S DTP=FHD D:DTP'="" DTP^FH S FHD=DTP
 S Z1=$P(ZZ,"^",9),Z2=$P(ZZ,"^",11)
 W:FHD'="" !?27,"QOH LAST UPDATED ON ",FHD,!
 S DA=+Y S:OKAY DR="8;S:X=Z1 Y=""@1"";29////"_DT_";@1;10;S:X=Z2 Y="""";30////"_DT S:'OKAY DR="10;S:X=Z2 Y="""";30////"_DT
 D ^DIE K FHD,DA,DIC,DIE,DR G EDIT
F1 ; Ask For Food Group or Storage
 R !!,"Select by F=FOOD GROUPS or S=STORAGE: F// ",FHXX:DTIME I '$T!(FHXX["^") S FHXX="^" Q
 S:FHXX="" FHXX="F" I "fs"[FHXX S X=FHXX D TR^FH S FHXX=X
 I FHXX'?1U!("FS"'[FHXX) W *7," Enter return F or S" G F1
 I FHXX="S" S SRT=$O(^FH(113.1,0)) I SRT'<1,$O(^FH(113.1,SRT))<1 S SRT=0  Q
 I FHXX="S" G D2
D1 ; Get a Food Group
 R !!,"Select Food Group (or ALL): ",X:DTIME Q:'$T!("^"[X)  D:X="all" TR^FH I X="ALL" S SRT=0 Q
 I X'?1N!(X<1)!(X>6) W *7,!?5,"Answer with a number 1 to 6 or ALL for all." G D1
 S SRT=+X
 Q
D2 ; Get a Storage
 R !!,"Select Storage Location (or ALL): ",X:DTIME Q:'$T!("^"[X)  D:X="all" TR^FH I X="ALL" S SRT=0 Q
 I X'="ALL" K DIC S DIC="^FH(113.1,",DIC(0)="EMQ" D ^DIC G:Y<1 D2 S SRT=+Y
 Q
REC ; Re-Cost Recipes
 D:OKAY ^FHREC3
KIL K ^TMP($J) G KILL^XUSCLEAN
