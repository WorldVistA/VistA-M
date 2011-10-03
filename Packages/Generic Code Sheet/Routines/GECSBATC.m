GECSBATC ;WISC/RFJ/KLD-batch code sheets                                ;01 Nov 93
 ;;2.0;GCS;**13**;MAR 14, 1995
 N %,%H,%I,COUNTER,D,DA,GECS,GECSBATC,GECSCOUN,GECSSYDA,GECSTRAN,X,Y
 D ^GECSSITE Q:'$G(GECS("SITE"))
 D BATNOFMS^GECSUSEL Q:'$G(GECS("BATDA"))
 S XP="READY TO BATCH "_GECS("BATCH")_" CODE SHEETS",XH="'YES' will start batching, 'NO' or '^' will exit."
 W !! I $$YN^GECSUTIL(2)'=1 Q
 W !
 ;  check to see if system is locked
 S GECSSYDA=$$LOCKSYS^GECSULOC(GECS("SITE")_GECS("SITE1")_"-"_GECS("SYSID")_"-BATCH")
 I 'GECSSYDA Q
 S COUNTER=$$COUNTER^GECSUNUM(GECS("SITE")_GECS("SITE1")_"-"_GECS("SYSID")_"-"_GECS("FY")) I 'COUNTER D UNLOCK^GECSULOC(GECSSYDA) Q
 ;
 S GECSBATC=GECS("SITE")_GECS("SITE1")_"-"_GECS("SYSID")_"-"_GECS("FY")_"-"_COUNTER
 ;
 ;  check to see if code sheets are waiting
 S (DA,GECSCOUN)=0 F  S DA=$O(^GECS(2100,"AC","Y",DA)) Q:'DA  S D=$G(^GECS(2100,DA,0)) I D'="" D
 .   I ($P(D,"^",6)_$P(D,"^",7))'=(GECS("SITE")_GECS("SITE1")) Q
 .   I $P(D,"^",2)'=GECS("SYSID")!($P(D,"^",3)'=GECS("BATDA")) Q
 .   S GECSTRAN=$G(^GECS(2100,DA,"TRANS")) I GECSTRAN=""!($P(GECSTRAN,"^",7)>DT) Q
 .   I '$$MARK(DA,GECSBATC) Q
 .   S GECSCOUN=GECSCOUN+1
 .   W $J($P(^GECS(2100,DA,0),"^"),10) I $X>69 W !
 I GECSCOUN=0 W !,"THERE ARE NO CODE SHEETS WAITING TO BE BATCHED." D UNLOCK^GECSULOC(GECSSYDA) Q
 ;
 ;  create batch
 W !!,"Creating BATCH NUMBER: ",GECSBATC
 N %DT,D0,DD,DI,DIC,DIE,DLAYGO,DQ,DR
 S DIC="^GECS(2101.3,",DIC(0)="L",DLAYGO=2101.3,DIC("DR")=".1///"_GECS("SYSID")_";.2///"_GECS("BATDA")_";.5///B;.7///NOW;.8////"_DUZ
 S X=GECSBATC D FILE^DICN
 ;
 W !,"TOTAL code sheets batched: ",GECSCOUN
 D UNLOCK^GECSULOC(GECSSYDA)
 Q
 ;
 ;
MARK(DA,GECSBATC) ;  mark code sheet for transmission in batch gecsbatc
 ;  return 1 for success, 0 for unable to mark code sheet
 I '$D(^GECS(2100,DA,0)) Q 0
 N D0,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^GECS(2100,",DR=$S($P($G(^GECS(2100,DA,"TRANS")),"^",10)="":".9///3;",1:"")_".1///@;.15///Y;.8////"_GECSBATC
 D ^DIE I $D(Y) Q 0
 Q 1
