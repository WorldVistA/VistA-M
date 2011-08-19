RAORDC ;HISC/CAH,FPT,GJC,DAD AISC/RMO-Check Request Status against Exam Status ;4/9/97  12:06
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
 ;The variables RADFN, RADTI and RACNI must be defined. The variable
 ;RADELFLG is set when the exam is being deleted.  This routine is
 ;called after an exam status is updated, to update the order status.
 ;Called from RAEDCN after exam cancel or delete, from RAESO after
 ;override single exam to complete, from RASTED after exam status is
 ;updated successfully, and from RAUTL1 after exam status update.
 G Q:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S RAEXM0=^(0),RAEXOR=$S($D(RADELFLG):0,$D(^RA(72,+$P(RAEXM0,"^",3),0)):$P(^(0),"^",3),1:""),RAOIFN=+$P(RAEXM0,"^",11) G Q:'$D(^RAO(75.1,RAOIFN,0)) S (RAORD0,RAORDB4)=^(0)
 S RAOSTS=$S(RAEXOR=0:0,RAEXOR>0&(RAEXOR<9):6,RAEXOR=9:2,1:"") D EXMCAN:RAOSTS=0,EXMCOM:RAOSTS=2,^RAORDU:RAOSTS=6&(RAOSTS'=$P(RAORD0,"^",5))
 I $P($G(RAORDB4),"^",5)=2,(RAOSTS'=2) D
 . ; Prior request status complete ($P(RAORDB4,"^",5)=2), new request
 . ; status (RAOSTS) not complete & OE/RR version not less than 3 issue
 . ; roll back message
 . D:$$ORVR^RAORDU()'<3 EN2^RAO7CH(RAOIFN)
 . ; Delete 'V' file pointers if PCE installed & outpatient
 . I $P(RAEXM0,"^",6)]"",($P(^DIC(42,$P(RAEXM0,"^",6),0),"^",3)'="D") Q
 . D:$$PCE^RAWORK() UNCOMPL^RAPCE1(RADFN,RADTI,RACNI)
 . Q
Q K RABLNK,RACAT,RAEXM0,RAEXOR,RAILP,RAMIFN,RAMOD,RAMODA,RAMODD,RAOIFN,RAORD0,RAORDB4,RAOSTS,RAPRC,RARSH,RASHA,X
 I '$D(N)!($D(RAOREA)<10) K RAOREA Q
 I $D(RAOREA)>1,$G(N) K RAOREA(N) I $D(RAOREA)<10 K RAOREA
 Q
 ;
EXMCAN ; Update request status to cancel or hold.
 N RAXIT S RAXIT=0
 S RAOREA=$S($D(RAOREA):RAOREA,1:$O(^RA(75.2,"B",$S($D(RADELFLG):"EXAM DELETED",1:"EXAM CANCELLED"),0)))
 ;
ASKCAN S RA=$O(^RADPT("AO",RAOIFN,RADFN,RADTI,0))
 I RA,$O(^RADPT("AO",RAOIFN,RADFN,RADTI,RA)) D  Q:RAXIT
 . ; If # descendents > 1 do not allow order to be deleted or canceled
 . N RAESTAT S RAESTAT=$$EN1^RASETU(RAOIFN,RADFN)
 . Q:+$P(RAESTAT,"^",3)  ; all other exams have been cancelled
 . S RAXIT=1 ; if ramaining xams complete -or- at least one of the other
 . ;           xams not cancelled, take appropriate action, quit EXMCAN
 . I +RAESTAT=9 S RAOSTS=2 D ^RAORDU S RAOSTS=0 Q  ; all xams complete
 . W !!?5,"Please note, however, that more than one procedure is associated"
 . W !?5,"with the procedure's Parent request.  The Parent request will not"
 . W !?5,"be canceled or put or hold unless all the registered descendent"
 . W !?5,"procedures are canceled or deleted.",!,$C(7)
 . Q
 W !!,"Do you want to cancel the request associated with this exam" S %=2 D YN^DICN S RAOSTS=$S(%=1:1,%=2:3,1:0) I 'RAOSTS W !!,"Required, enter 'YES' if the request should be cancelled or 'NO' to put",!,"it on hold." G ASKCAN
 I RAOSTS=1,$D(RADELFLG) D
 . ; Remove EXAM SET flag if parent order deleted
 . N DA,DIE,DR
 . S DIE="^RADPT("_RADFN_",""DT"",",DA(1)=RADFN,DA=RADTI,DR="5///@"
 . D ^DIE
 . Q
 I RAOSTS=3 S (DIE,DIC)="^RAO(75.1,",DIC(0)="AEQM",DA=RAOIFN,DR="25" W ! D ^DIE K DIE,DIC,DA,DR
 D ^RAORDU W !?10,"...request status updated to ",$S(RAOSTS=1:"discontinued",1:"hold"),"."
 Q
 ;
EXMCOM ; Code moved to EXMCOM^RAORDC1 to save on space.  To update request
 ; statuses for complete exams.
 D EXMCOM^RAORDC1 Q
 ;
DELMOD S DA(1)=RAOIFN,DA=RAMIFN,DIK="^RAO(75.1,"_DA(1)_",""M""," D ^DIK K DA,DIK S RAMODD=""
 Q
 ;
ADDMOD S X=$S($D(^RAMIS(71.2,RAILP,0)):$P(^(0),"^"),1:"") I X'="" S:'$D(^RAO(75.1,RAOIFN,"M",0)) ^(0)="^75.1125PA^^" S DIC(0)="L",DLAYGO=75.1,DA(1)=RAOIFN,DIC="^RAO(75.1,RAOIFN,""M""," D ^DIC K DA,DIC S RAMODA=""
 Q
