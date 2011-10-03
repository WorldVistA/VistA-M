SDM2A ; OG - MAKE APPOINTMENT - overflow routine due to SACC 10K limit.  ; Compiled August 28, 2007 16:08:18  ; Compiled June 13, 2008 16:32:51  ; Compiled June 24, 2008 11:57:22
 ;;5.3;Scheduling;**446,528**;Aug 13 1993;Build 4
WL(SC) ;Wait List Hook/teh patch 263 ;SD/327 passed 'SC'
 N DA,DIE,DR,SBEG,SCSR,SDDIV,SDINST,SDPAR,SDWLDA,SDWLDFN,SDWLSCL
 Q:$G(SC)'>0
 I '$D(^SC(SC)) Q
 S SDINST=""
 ;S SDINST=$$GET1^DIQ(44,SC_",",3,"I")  ; get Inst BEFORE
 S SDDIV=$$GET1^DIQ(44,SC_",",3.5,"I") S:SDDIV'="" SDINST=$$GET1^DIQ(40.8,SDDIV_",",.07,"I")
 I SDINST="" D  Q  ; sd/446
 .N DIR
 .D MESS2^SDWL120(SC)
 .W !,"No Institution/Division is associated with this Clinic."
 .W !,"Unable to create a Wait List Entry. Abandoning request."
 .W !!,"A message is being sent to the administrators mail group"
 .W !,"alerting them to the situation."
 .S DIR(0)="E" D ^DIR
 .Q
 S SDPAR=0
 ;create 409.32 entry
 I $D(^SDWL(409.32,"B",SC)) S SDWLSCL=$O(^SDWL(409.32,"B",SC,""))
 E  D
 .N DA,DIC,X,DIE,DR
 .S DIC(0)="LX",X=SC,DIC="^SDWL(409.32," D FILE^DICN
 .S SDWLSCL=DA
 .S DIE="^SDWL(409.32,"
 .S DR=".02////^S X=SDINST" D ^DIE
 .S DR="1////^S X=DT"
 .S DR=DR_";2////^S X=DUZ"
 .D ^DIE S SDPAR=1 ; flag indicating clinic parameter entry
 .; CREATE 409.3 with 120 flag
 S DIC(0)="LX",(X,SDWLDFN)=DFN,DIC="^SDWL(409.3," D FILE^DICN
 ; File just created so lock should never fail.
 F  L +^SDWL(409.3,DA):5 Q:$T  W !,"Unable to acquire a lock on the Wait List file" Q
 ; Update EWL variables.
 S SDWLDA=DA D EN^SDWLE11 ; get enrollee both SDWLDA and SDWLDFN have to be defined
 S DIE="^SDWL(409.3,"
 S DR="1////^S X=DT"
 S DR=DR_";2////^S X=SDINST"
 S DR=DR_";4////^S X=4"
 S DR=DR_";8////^S X=SDWLSCL"
 S DR=DR_";9////^S X=DUZ"
 S DR=DR_";10////^S X=""A"""
 S DR=DR_";11////^S X=2" ; by patient for this entry to avoid asking for provider
 S DR=DR_";14////^S X="""_$S($P($G(^DPT(SDWLDFN,.3)),U,1)="Y":$P(^DPT(SDWLDFN,.3),U,2),1:"")_""""
 S DR=DR_";15////^S X="_$S($P($G(^DPT(SDWLDFN,.3)),U,1)="Y":1,1:0)
 S DR=DR_";22////^S X=SDDATE"
 S DR=DR_";23////^S X=""O"""
 S DR=DR_";25////^S X="" > 120 days"""
 S DR=DR_";36////^S X=1"
 D ^DIE
 L -^SDWL(409.3,DA)
 S SDWLFLG=0 D MESS^SDWL120(SDWLDFN,SDWLDA,SDPAR)
 Q
 ;
WLCL120(SC,DESDT) ; Is there clinic availability within 120 days of desired date ; sd/446
 N SBEG,SD120
 Q:$$GET1^DIQ(44,SC,2502,"I")="Y" 1  ; Non-count clinic. Allow > 120 days.
 S SD120=0,SBEG=DESDT-1
 F  S SBEG=$O(^SC(SC,"ST",SBEG)) Q:SBEG=""  I $$HASAVSL(^SC(SC,"ST",SBEG,1)) D  Q
 .N X,DESDTH
 .S X=SBEG D H^%DTC S SBEG=%H
 .S X=DESDT D H^%DTC S DESDTH=%H
 .S SD120=(SBEG-DESDTH>120)
 .Q
 Q 'SD120
 ;
WLCL120A(SDWLAPDT,SDDATE1,SC) ;
 N %DT,DIR,X,X1,X2,Y
 Q:$$GET1^DIQ(44,SC,2502,"I")="Y" 1  ; Non-count clinic. Allow > 120 days.
 S X=SDWLAPDT,%DT="TXF" D ^%DT
 Q:Y=-1 1
 S X1=Y,X2=SDDATE1 D ^%DTC
 I X'>120 Q 1
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Add to EWL",DIR("A",1)="The date is more than 120 days beyond the Desired Date"
 W ! D ^DIR
 I Y=1 D WL(SC)
 Q 0
 ;
WLCLASK() ; No appointment availability warning. ; sd/446
 N DIR
 S DIR(0)="Y"
 S DIR("A",1)="No appointments are available within 120 days of the Desired Date."
 S DIR("A",2)="Do you want to place this patient on the Electronic Wait List"
 S DIR("A",3)="or change the desired date?"
 S DIR("A",4)=""
 S DIR("A",5)="Enter ""Y"" to place on EWL, ""N"" to go back"
 S DIR("A")="or ""^"" to return to the CLINIC: prompt. "
 W ! D ^DIR
 Q Y
 ;
HASAVSL(SCSR) ; Has available slots ; sd/446
 ; Look at CLINIC PATTERN CURRENT AVAILABILITY string (44.005/1)
 ; If there is 1-9,j-z within the [ ... ], there is availability for that day.
 N DIC,F,SDOK,X,Y
 ; Allow whatever if user has a key to overbook.
 S DIC="^VA(200,"_DUZ_",51,",X="SDOB" D ^DIC Q:Y'=-1 1
 S X="SDMOB" D ^DIC Q:Y'=-1 1
 Q:SCSR'["[" 0  ; No slots.
 S SCSR=$TR($E(SCSR,$F(SCSR,"[")-1,$L(SCSR))," |"),(SDOK,F)=0
 F  S F=$F(SCSR,"[",F) Q:'F  D  Q:SDOK
 .N I,SCSR0,SL
 .S SCSR0=$E(SCSR,F,$F(SCSR,"]",F)-2)
 .F I=1:1:$L(SCSR0) S SL=$E(SCSR0,I) I $A(SL)>105&($A(SL)<123)!SL S SDOK=1 Q  ; If SL=1-9,j-z slots are available
 .Q
 Q SDOK
