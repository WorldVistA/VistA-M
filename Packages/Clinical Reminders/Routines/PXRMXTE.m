PXRMXTE ; SLC/PJH - Reminder Reports Template Edit ;07/30/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ; 
 ; Called from PXRMYD,PXRMXD
 ;
 ;Option to Edit
 ;--------------
EDIT ;
 N DIDEL,DIE,DR K DTOUT,DUOUT
 ;Edit report name, title and PXRMSEL (patient sample)
 S DIE=810.1,DA=$P(PXRMTMP,U),DR=".01T;1.9;1.2",DIDEL=810.1
 D ^DIE I $D(Y) S DUOUT=1 Q
 ;Check if template has been deleted
 I '$D(DA) Q
 ;Get updated value of PXRMXSEL
 N PXRMSEL,PXRMFUT S PXRMSEL=X
 ;Needed for 1.6 validation - Prior/Future or Current/Admissions
 ;N PXRMINP
 ;Further fields depend on value in PXRMXSEL
 I PXRMSEL="I" S DR="6T~R",PXRMINP=0
 I PXRMSEL="R" S DR="14T",PXRMINP=0
 I PXRMSEL="L" D  Q:$D(DUOUT)
 .;Get location report type 
 .S DR="3T;1.5R" D ^DIE I $D(Y) S DUOUT=1 Q
 .N PXRMLCSC S PXRMLCSC=X,DR="",PXRMINP=0
 .;All location reports - prompt for prior/future/current/admissions
 .I PXRMLCSC="HAI" S PXRMINP=1,DR="1.6" Q
 .I PXRMLCSC="HA" S PXRMINP=0,DR="1.6"
 .I PXRMLCSC="CA" S PXRMINP=0,DR="1.6"
 .D ^DIE I $D(Y) S DUOUT=1 Q
 .S PXRMFUT=X,DR=""
 .;Selected Location/Stop Code/Clinic Group fields 
 .I PXRMLCSC="HS" D  Q:$D(DUOUT)
 ..S DR="10T~R"
 ..D ^DIE I $D(Y) S DUOUT=1 Q
 ..;Determine if locations input are all wards
 ..S PXRMINP=$$INP^PXRMXAP(PXRMLCSC,.PXRMLOCN)
 ..;Select Prior/Future or Current Inpatient/Admissions
 ..S DR="1.6"
 ..D ^DIE I $D(Y) S DUOUT=1 Q
 ..S PXRMFUT=X,DR=""
 .;Clinic Stop input and prior/future
 .I PXRMLCSC="CS" S PXRMINP=0,DR="11T~R;1.6" D  I $G(DUOUT)=1 Q
 ..D ^DIE I $D(Y) S DUOUT=1 Q
 ..S PXRMFUT=X,DR=""
 .;Clinic Group input and prior/future
 .I PXRMLCSC="GS" S PXRMINP=0,DR="12T~R;1.6" D  I $G(DUOUT)=1 Q
 ..D ^DIE I $D(Y) S DUOUT=1 Q
 ..S PXRMFUT=X,DR=""
 .;Service categories (except for inpatient reports)
 .I PXRMINP=0,PXRMFUT'="F",PXRMFUT'="C" S DR=DR_";9T~R"
 ;OE/RR teams
 I PXRMSEL="O" S DR="7T~R"
 ;PCMM Provider and Primary care/All
 I PXRMSEL="P" S DR="4T~R;1.3"
 ;PCMM teams
 I PXRMSEL="T" S DR="3T~R;8T~R"
 D ^DIE
 ;Report type (detail or summary)
 S DR=DR=DR_";1.4"
 ;Print Locations without patients and print percentages
 S DR=DR_";1.7;1.8"
 ;Reminder Categories
 I $D(^PXRMPT(810.1,DA,12,0))>0 D
 .N IEN,CNT,NODE
 .S CNT=0,IEN=0 F  S IEN=$O(^PXRMPT(810.1,DA,12,IEN)) Q:IEN'>0  D
 ..S CNT=CNT+1,NODE=$G(^PXRMPT(810.1,DA,12,IEN,0))
 ..S PXRMTCAT(DA,CNT)=$P(NODE,U)_U_$P($G(^PXRMD(811.7,$P(NODE,U),0)),U)_U_$P(NODE,U,2)
 S DR=DR_";13T"
 ;Reminders
 I $D(^PXRMPT(810.1,DA,1,0))>0 D
 .N IEN,CNT,NODE,REMNODE
 .S CNT=0,IEN=0 F  S IEN=$O(^PXRMPT(810.1,DA,1,IEN)) Q:IEN'>0  D
 ..S CNT=CNT+1,NODE=$G(^PXRMPT(810.1,DA,1,IEN,0))
 ..S REMNODE=$G(^PXD(811.9,$P(NODE,U),0))
 ..S PXRMTREM(DA,CNT)=$P(NODE,U)_U_$P(REMNODE,U)_U_$P(NODE,U,2)_U_$P($G(REMNODE),U,3)
 S DR=DR_";2T"
 ;
 ;Strip of any leading semi-colons
 I $E(DR)=";" S DR=$P(DR,";",2,99)
 ;
 D ^DIE I $D(Y) S DUOUT=1 Q
 ;
 ;if manager all an owner to be assigned
 I $D(^XUSEC("PXRM MANAGER",DUZ)) S DR="15" D ^DIE
 ;
 ;If all reminders have been deleted from the template disallow save
 I +$P($G(^PXRMPT(810.1,DA,1,0)),U,4)=0 D
 .;Check categories also
 .I +$P($G(^PXRMPT(810.1,DA,12,0)),U,4)>0 D  Q
 .. N CAT,CATIEN
 .. S CAT=0 F  S CAT=$O(^PXRMPT(810.1,DA,12,CAT)) Q:+CAT'>0  D
 ... S CATIEN=$P($G(^PXRMPT(810.1,DA,12,CAT,0)),U)
 ... I +$P($G(^PXRMD(811.7,CATIEN,2,0)),U,4)<1 W !!,"** WARNING **",!,"Reminder Category "_$P($G(^PXRMD(811.7,CATIEN,0)),U)_" does not have any reminders assigned to it"
 .S DUOUT=1
 .W !!,"No reminders defined"
 Q
 ;
