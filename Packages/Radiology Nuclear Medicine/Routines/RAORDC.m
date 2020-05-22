RAORDC ;HISC/CAH,FPT,GJC,DAD AISC/RMO-Check Request Status against Exam Status ;07 Aug 2019 12:26 PM
 ;;5.0;Radiology/Nuclear Medicine;**113,124,162**;Mar 16, 1998;Build 2
 ;
 ;The variables RADFN, RADTI and RACNI must be defined. The variable
 ;RADELFLG is set when the exam is being deleted.  This routine is
 ;called after an exam status is updated, to update the order status.
 ;Called from RAEDCN after exam cancel or delete, from RAESO after
 ;override single exam to complete, from RASTED after exam status is
 ;updated successfully, and from RAUTL1 after exam status update.
 G Q:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S RAEXM0=^(0),RAEXOR=$S($D(RADELFLG):0,$D(^RA(72,+$P(RAEXM0,"^",3),0)):$P(^(0),"^",3),1:""),RAOIFN=+$P(RAEXM0,"^",11) G Q:'$D(^RAO(75.1,RAOIFN,0)) S (RAORD0,RAORDB4)=^(0)
 S RAOSTS=$S(RAEXOR=0:0,RAEXOR>0&(RAEXOR<9):6,RAEXOR=9:2,1:"") D EXMCAN:RAOSTS=0,EXMCOM:RAOSTS=2,^RAORDU:RAOSTS=6&(RAOSTS'=$P(RAORD0,"^",5))
 ;
 ;Check for studies that are COMPLETE (w/order=9). May be single studies,
 ;multiple studies per patient event: examsets, printsets, add exams to 
 ;last visit get radiation dose data if the proper conditions are met.
 I RAOSTS=2!(RAOSTS=6) D  ; ACTIVE (6) or COMPLETE (2)
 .N RAIT,RAY2,RAY3 S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0))
 .S RAIT=$P($G(^RA(79.2,+$P(RAY2,U,2),0)),U,3)
 .I RAIT'="RAD",(RAIT'="CT") Q
 .S RAIT=$S(RAIT="RAD":"FLUORO",1:"CT") ;MAG requires "FLUORO"
 .S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 .Q:$P($G(^RA(72,+$P(RAY3,U,3),0)),U,3)'=9  ;must be COMPLETE
 .D GETDOSE^RADUTL ;RA*5.0*113 w/MAG*3.0*137
 .Q
 ;
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
 ;This logic is called based on changes for RA5P124.
 ;RA5P124 comments will be added where necessary.
 N RAXIT S RAXIT=0
 S RAOREA=$S($D(RAOREA):RAOREA,1:$O(^RA(75.2,"B",$S($D(RADELFLG):"EXAM DELETED",1:"EXAM CANCELLED"),0)))
 ;
ASKCAN ;logic to determine whether studies tied to the order meet the criteria
 ;to discontinue or hold the order. At this point RAOIFN, RADFN, RADTI, RACNI
 ;RAY2 (70.02 node), RAY3 (70.03) node and RACAN124 are set.
 ;
 ;check for descendents
 S RA=$O(^RADPT("AO",RAOIFN,RADFN,RADTI,0))
 I RA,$O(^RADPT("AO",RAOIFN,RADFN,RADTI,RA)) D  Q:RAXIT
 . ; If # descendents > 1 do not assume the order is to be deleted or canceled
 . N RAESTAT S RAESTAT=$$EN1^RASETU(RAOIFN,RADFN)
 . ;RAESTAT = min ORDER number value for all descendents_"^"_max ORDER number value for all descendents
 . ;          _"^"_$S(All_desc ORDER number values=0:1,1:0)
 . Q:+$P(RAESTAT,"^",3)  ; all other exams have been canceled
 . S RAXIT=1 ; if ramaining xams complete -or- at least one of the other
 . ;           xams not cancelled, take appropriate action, quit EXMCAN
 . I +RAESTAT=9 S RAOSTS=2 D ^RAORDU S RAOSTS=0 Q  ; all xams complete
 . W !!?5,"Please note, however, that more than one procedure is associated"
 . W !?5,"with the procedure's Parent request.  The Parent request will not"
 . W !?5,"be canceled or put or hold unless all the registered descendent"
 . W !?5,"procedures are canceled or deleted.",!,$C(7)
 . Q
 ;
 W ! S RAOSTS=$$YNCAN() Q:RAOSTS=-1
 I RAOSTS=1,$D(RADELFLG) D
 . ; Remove EXAM SET flag if parent order deleted
 . N DA,DIE,DR
 . S DIE="^RADPT("_RADFN_",""DT"",",DA(1)=RADFN,DA=RADTI,DR="5///@"
 . D ^DIE
 . Q
 ;// new w/P162 keep the default reason (order) //
 ;// unless the user selects another reason    //
 I RAOSTS=1 D
 .N RAS S RAS=$$REASON(RAOSTS) S:+RAS>0 RAOREA=+RAS
 .Q
 I RAOSTS=3 D
 .N RAS S RAS=$$REASON(RAOSTS) S:+RAS>0 RAOREA=+RAS
 .S (DIE,DIC)="^RAO(75.1,",DIC(0)="AEQM",DA=RAOIFN,DR="25" W ! D ^DIE K DIE,DIC,DA,DR
 .Q
 ;// end P162 mods //
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
 ;
YNCAN() ;ask if the order is to be canceled
 ;DIR returns:
 ; X - Unprocessed user response
 ; Y - Processed user response.
 N %,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y",DIR("B")="No"
 S DIR("?",1)="Required, enter 'YES' If the request should be cancelled or 'NO' to put"
 S DIR("?")="it on hold."
 S DIR("A")="Do you want to cancel the request associated with this exam"
 D ^DIR
 ;Yes/No: Y=1 for yes/cancel; else Y=0 for no/hold
 ;
 Q $S(Y=1:1,Y=0:3,1:-1)
 ;
REASON(RAOSTS) ;cancel/hold reason using DIR
 ; RAOSTS - the request status selected by the user.
 ; 1 = discontinued/cancel; 3 = hold
 ; return: IEN^.01 of IEN
 ;         -1^ (if nothing selected, timeout or up arrow)
 N %,DIR,DIRUT,DTOUT,DUOUT,RAREAY,X,Y
 S DIR(0)="POA^75.2:EZ"
 S DIR("A")="Select the '"_$S(RAOSTS=1:"cancel",1:"hold")_"' reason for this order: "
 S DIR("S")="I $P(^(0),U,2)=RAOSTS" W ! D ^DIR
 I $D(DIRUT)#2 D  Q RAREAY
 .S RAREAY="-1^"
 .Q
 E  S RAREAY=Y
 Q RAREAY
 ;
