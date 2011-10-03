PXRMPARS ; SLC/PJH - Edit PXRM(800 reminder parameters. ;04/02/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;called by protocol PXRM EDIT SITE DISCLAIMER
 ;
DISC(DA) ;Edit default disclaimer
 Q:'$$LOCK(DA)
 N DIC,DIE,DR,Y
 ;Edit
 S DIC="^PXRM(800,",DIE=800,DR=2
 D ^DIE
 D FORMAT^PXRMDISC
 Q
 ;
MH(DA) ;Edit MH default Question Value
 Q:'$$LOCK(DA)
 N DIC,DIE,DR,Y
 ;Edit
 S DIE="^PXRM(800,",DR=17
 D ^DIE
 Q
 ;
 ;called by protocol PXRM EDIT WEB SITE
 ;
WEB(DA) ;Edit default web site
 Q:'$$LOCK(DA)
 ;Edit
 N DTOUT,DUOUT
 F  D  Q:$D(DUOUT)!$D(DTOUT)
 .D WLIST,WSET,WURL(DA)
 Q
 ;
WLIST ;Display web sites
 N FIRST,SUB,SUB1
 S FIRST=1,SUB=""
 F  S SUB=$O(^PXRM(800,DA,1,"B",SUB)) Q:SUB=""  D
 .S SUB1=0
 .F  S SUB1=$O(^PXRM(800,DA,1,"B",SUB,SUB1)) Q:'SUB1  D
 ..I FIRST S FIRST=0 W !!,"Choose from:",!
 ..W ?8,$P($G(^PXRM(800,DA,1,SUB1,0)),U),!
 I FIRST W !!,"No default web sites defined",!
 Q
 ;
WSET ;Set node if not defined
 S:'$D(^PXRM(800,DA,1,0)) ^PXRM(800,DA,1,0)="^800.04"
 Q
 ;
WURL(IEN) ;Edit individual URL
 N DA,DIC,DIE,DR,Y
 S DA(1)=IEN
 S DIC="^PXRM(800,"_IEN_",1,"
 S DIC(0)="QEAL"
 S DIC("A")="Select URL: "
 S DIC("P")="800.04"
 D ^DIC I Y=-1 S DTOUT=1 Q
 S DIE=DIC K DIC
 S DA=+Y
 ;Finding record fields
 S DR=".01;.02;1"
 ;Edit finding record
 D ^DIE
 I $D(Y) S DTOUT=1 Q
 ;Check if deleted
 I '$D(DA) Q
 Q
 ;
LOCK(DA) ;Lock the record
 L +^PXRM(800,DA):0 I  Q 1
 E  W !!,?5,"Another user is editing this file, try later" H 2 Q 0
 ;
UNLOCK(DA) ;Unlock the record
 L -^PXRM(800,DA)
 Q
