SDWLE7() ;;IOFO BAY PINES/OG - WAITING LIST-ENTER/EDIT - MOVE EWL ENTRY  ; Compiled August 14, 2007 11:18:43
 ;;5.3;scheduling;**446**;AUG 13 1993;Build 77
 ;
 ;  ******************************************************************
 ;  CHANGE LOG
 ;       
 ;   DATE         PATCH    DESCRIPTION
 ;   ----         -----    -----------
 ;   
EN() ;
 N SDWLERR,SDWLCM,SDWLIN1,SDWLOPT,SDWLSC1,SDWLSC1X
 S (SDWLERR,SDWLOPT)=1,SDWLCM=""
 F  D @("P"_SDWLOPT) Q:'SDWLOPT
 Q SDWLERR
 ;
P1 ; Institution
 S DIR(0)="PAO^DIC(4,:EMNZ"
 S DIR("A")="Select Institution: "
 S DIR("B")=$$GET1^DIQ(4,SDWLIN,.01)
 S DIR("S")="I $E(+Y,1,3)=$E(SDWLIN,1,3)"
 D ^DIR
 I Y<1 S SDWLOPT=0 Q
 S SDWLIN1=+Y,SDWLOPT=2
 Q
P2 ; Clinic
 N DIR,Y,SDWLI,SDWLSTOP,SDWLSTP1,TMP
 S DIR(0)="PAO^SDWL(409.32,:EMNZ",DIR("A")="Select Clinic: "
 S DIR("S")="I +Y'=SDWLSC,$P(^SC($$GET1^DIQ(409.32,+Y,.01,""I""),0),U,4)=SDWLIN1"
 D ^DIR
 I Y="^" S SDWLOPT=0 Q
 I Y<1 S SDWLOPT=1 Q
 S SDWLSCL=+Y,SDWLSC1X=$$GET1^DIQ(409.32,SDWLSCL,.01)
 S SDWLSTOP=$$GET1^DIQ(44,$$GET1^DIQ(409.32,SDWLSC,.01,"I"),8,"I")
 S SDWLSTP1=$$GET1^DIQ(44,$$GET1^DIQ(409.32,SDWLSCL,.01,"I"),8,"I")
 I SDWLSTOP=SDWLSTP1 S SDWLOPT=3 Q
 K DIR
 S DIR(0)="Y"
 S TMP(0)=1,TMP(1,0)=$$GET1^DIQ(409.32,SDWLSC,.01)_" and "_SDWLSC1X_" have different stop codes."
 D COL80^SDWLIFT(.TMP) F SDWLI=1:1:TMP(0) S DIR("A",SDWLI)=TMP(SDWLI,0)
 S DIR("A")="Do you want to proceed?"
 S DIR("B")="NO" D ^DIR
 S SDWLOPT=Y*3  ; +Y=0: SDWLOPT=0; Y=1: SDWLOPT=3
 Q
 ;
P3 ; Comment
 D P4^SDWLE6
 Q
 ;
P4 ; Display data and confirm.
 N DIR,SDWLTMP,SDWLORDT,SDWLSCPG,SDWLSCPR,SDWLDDT,SDWLEEST,Y
 D GETS^DIQ(409.3,SDWLDA_",","1;14;15;22;27","I","SDWLTMP")
 S SDWLORDT=SDWLTMP(409.3,SDWLDA_",",1,"I")
 S SDWLSCPG=SDWLTMP(409.3,SDWLDA_",",14,"I")
 S SDWLSCPR=SDWLTMP(409.3,SDWLDA_",",15,"I")
 S SDWLDDT=SDWLTMP(409.3,SDWLDA_",",22,"I")
 S SDWLEEST=SDWLTMP(409.3,SDWLDA_",",27,"I")
 S DIR(0)="Y"
 S DIR("A",1)="The following EWL entry will be created"
 S Y=SDWLORDT D DD^%DT
 S DIR("A",2)="Originating Date: "_Y
 S DIR("A",3)="Institution: "_$$GET1^DIQ(4,SDWLIN1,.01)
 S DIR("A",4)="Wait List Type: SPECIFIC CLINIC"
 S DIR("A",5)="Clinic: "_SDWLSC1X
 S Y=SDWLDDT D DD^%DT
 S DIR("A",6)="Desired Date of Appointment: "_Y
 S DIR("A",7)="Comments: "_SDWLCM
 S DIR("A")="Continue?"
 S DIR("B")="YES"
 D ^DIR
 S SDWLOPT=0
 Q:'Y
 I '$$UPDATE(SDWLDFN,SDWLORDT,SDWLIN,SDWLSCL,SDWLSCPG,SDWLSCPR,SDWLDDT,SDWLCM,SDWLEEST,SDWLDA) S SDWLOPT=3
 Q
UPDATE(SDWLDFN,SDWLORDT,SDWLIN,SDWLSCL,SDWLSCPG,SDWLSCPR,SDWLDDT,SDWLCM,SDWLEEST,SDWLDA) ; Create new EWL entry
 N DA,DIC,DIE,DR,X
 S DIC(0)="LX",X=SDWLDFN,DIC="^SDWL(409.3," D FILE^DICN
 L +^SDWL(409.3,DA):1  ; This file has just been created. Is it neurotic to code for the possibility of a lock from elsewhere?
 I '$T W !,"Unable to acquire a lock on the Wait List file" Q 0
 S DIE=DIC
 S DR="1////^S X=SDWLORDT"
 S DR=DR_";2////^S X=SDWLIN"
 S DR=DR_";4////^S X=4"
 S DR=DR_";8////^S X=SDWLSCL"
 S DR=DR_";9////^S X=DUZ"
 S DR=DR_";14////^S X=SDWLSCPG"
 S DR=DR_";15////^S X=SDWLSCPR"
 S DR=DR_";22////^S X=SDWLDDT"
 S DR=DR_";23////^S X=""O"""
 S DR=DR_";25////^S X=SDWLCM"
 S DR=DR_";27////^S X=SDWLEEST"
 S DR=DR_";37////^S X=SDWLDA"
 D ^DIE
 L -^SDWL(409.3,DA)
 S SDWLERR=0
 Q 1
