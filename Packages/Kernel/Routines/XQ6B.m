XQ6B ;SFISC/KLD-KEY DISTRIBUTION MUTUALLY EXCLUSION KEYS;4/05/00
 ;;8.0;KERNEL;**147**;Jul 10, 1995
 ;
 Q
UNABLE(XQIEN,XQPRSN,XQSTP) ;
 D KEYAVAL Q:XQSTP=1
 D UNABEXC Q:XQSTP=1
 D UNABBLK Q:XQSTP=1
 Q
KEYAVAL ;Check if key available to users - Self Exclusive
 I $D(^DIC(19.1,XQIEN,5,"B",XQIEN)) D
 .  W !!,"Key '"_$$GET1^DIQ(19.1,XQIEN,.01)_"' may not be given to any user at this time"
 .  W !,"no action taken",!
 .  S XQSTP=1
 Q
UNABEXC ;Key cannot be given Exclusive with Primary
 N XQCLUDE,XQNUM,XQMKEY,XQTKEY
 S (XQCLUDE,XQNUM,XQMKEY,XQTKEY)=""
 F  S XQCLUDE=$O(^DIC(19.1,XQIEN,5,"B",XQCLUDE)) Q:XQCLUDE=""  D
 .  F  S XQNUM=$O(^DIC(19.1,XQIEN,5,"B",XQCLUDE,XQNUM)) Q:XQNUM=""  D
 .  .  I $D(^VA(200,XQPRSN,51,XQCLUDE)) D
 .  .  .  S XQMKEY=$$GET1^DIQ(19.1,XQIEN,.01)
 .  .  .  S XQTKEY=$$GET1^DIQ(19.1,XQCLUDE,.01)
 .  .  .  W !!,"You are not AUTHORIZED key '"_XQMKEY_"' with EXCLUSIVE key '"_XQTKEY_"'"
 .  .  .  W !,"no action taken",!
 .  .  .  S XQSTP=1
 Q
UNABBLK ;No Exclusive(s) - Verify primary not exclusive with another key(s)
 N XQKEY,XQNBR,XQMKEY,XQTKEY
 S (XQKEY,XQNBR,XQMKEY,XQTKEY)=""
 I $D(^DIC(19.1,XQIEN,0)) D
 .  F  S XQKEY=$O(^DIC(19.1,"B",XQKEY)) Q:XQKEY=""  D
 .  .  F  S XQNBR=$O(^DIC(19.1,"B",XQKEY,XQNBR)) Q:XQNBR=""  D
 .  .  .  I $D(^DIC(19.1,XQNBR,5,"B",XQIEN)) D
 .  .  .  .  I $D(^VA(200,XQPRSN,51,XQNBR)) D
 .  .  .  .  .  S XQMKEY=$$GET1^DIQ(19.1,XQIEN,.01)
 .  .  .  .  .  S XQTKEY=$$GET1^DIQ(19.1,XQNBR,.01)
 .  .  .  .  .  W !!,"You are not AUTHORIZED key '"_XQMKEY_"' with EXCLUSIVE key '"_XQTKEY_"'"
 .  .  .  .  .  W !,"no action taken",!
 .  .  .  .  .  S XQSTP=1
 Q
EXCLUSE ;Set primary exclusive with another key(s)
 N DIC,DIE,DA,DR,Y
 W !!
 S DIC="19.1",DIC(0)="AEQZ",DIC("A")="Select Primary Allocated Key(s): "
 D ^DIC Q:Y=-1  D
 .  W !
 .  S DIE="^DIC(19.1,",DR="5",DA=+Y
 .  D ^DIE
 Q
