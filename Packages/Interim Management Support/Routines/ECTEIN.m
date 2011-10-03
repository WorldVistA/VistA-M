ECTEIN ;B'ham ISC/PTD-Enter/Edit Planned Equipment Data ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 ;SELECT ENTER/EDIT CHOICE
CHS W !!,"At this time, you may:",!!,"1.  Enter/Edit Planned Equipment",!,"2.  Edit Priority of an Item",!,"3.  Edit Status of an Item",!!,"Select a number (1 or 2 or 3): "
 R CHS:DTIME G:'$T!("^"[CHS) EXIT I CHS'?1N!(CHS<1)!(CHS>3) W !!,*7,"You MUST answer ""1"", ""2"", or ""3""." G CHS
DIC W !! S DIC="^ECT(731.5,",DIC("A")="Select ITEM: " S DIC(0)=$S(CHS=1:"QEALM",1:"QEAM") S:CHS=1 DLAYGO=731.5 D ^DIC K DIC G:Y<0 EXIT S DA=+Y
 ;BRANCH BASED ON ENTER/EDIT CHOICE
 S DIE="^ECT(731.5," G:CHS=1 DIE1 G:CHS=2 DIE2 G:CHS=3 DIE3
DIE1 S DR="[ECT EQUIPMENT INPUT]" D ^DIE K DA,DIE,DR G DIC
 ;
DIE2 I $P(^ECT(731.5,DA,0),"^",3)=1 W !,"HIGH TECHNOLOGY EQUIPMENT LIST ITEM"
 I $P(^ECT(731.5,DA,0),"^",4)=1 W !,"IRM/ADP EQUIPMENT ITEM"
 W "          ",$S($P(^ECT(731.5,DA,0),"^",5)="A":"ADDITIONAL",1:"REPLACEMENT")
 S DR="5" D ^DIE K DA,DIE,DR G DIC
 ;
DIE3 S DR="[ECT STATUS EDIT]" D ^DIE K DA,DIE,DR G DIC
 ;
EXIT K %,%X,%Y,C,CHS,DA,DIC,DIE,DLAYGO,DR,J,X,Y
 Q
 ;
