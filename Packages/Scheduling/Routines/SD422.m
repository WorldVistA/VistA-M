SD422 ;BP/JML; 1/13/05 2:50pm
 ;;5.3;Scheduling;**422**;Jan 13, 2005
 ;
 ;
 N DIC,X,Y,DA,DR,DIE
 Q:$D(^SD(409.45,"B",643))
 S DIC="^SD(409.45,",DIC(0)=""
 S X=643 D FILE^DICN
 S DA(1)=$P(Y,"^")
 S DIC="^SD(409.45,"_DA(1)_",""E"","
 S X=3050101 D FILE^DICN
 S DR=".02////1",DA=1,DIE="^SD(409.45,"_DA(1)_",""E"","
 D ^DIE
 Q
