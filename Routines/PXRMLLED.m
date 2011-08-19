PXRMLLED ; SLC/PJH - Edit a location list. ;06/09/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,11,12**;Feb 04, 2005;Build 73
 ;
 ;================================================================
 N CS1,CS2,DA,DIC,DLAYGO,DTOUT,DUOUT,FILEA,IENA,NUM,Y
GETNAME ;Get the name of the location list to edit.
 K DA,DIC,DLAYGO,DTOUT,DUOUT,Y
 S DIC="^PXRMD(810.9,"
 S DIC(0)="AEMQL"
 S DIC("A")="Select Location List: "
 S DIC("S")="I $$VEDIT^PXRMUTIL(DIC,Y)"
 S DLAYGO=810.9
 ;Set the starting place for additions.
 D SETSTART^PXRMCOPY(DIC)
 W !
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT)) Q
 I Y=-1 G END
 S DA=$P(Y,U,1)
 S CS1=$$FILE^PXRMEXCS(810.9,DA)
 D EDIT(DIC,DA)
 ;See if any changes have been made, if so do the edit history.
 S CS2=$$FILE^PXRMEXCS(810.9,DA)
 I CS2'=0,CS2'=CS1 D SEHIST^PXRMUTIL(810.9,DIC,DA)
 G GETNAME
END ;
 Q
 ;
 ;================================================================
EDIT(ROOT,DA) ;
 N DIE,DR,DIDEL,RESULT,X,Y
 S DIE=ROOT,DIDEL=810.9
NAME S DR=".01"
 D ^DIE
 I '$D(DA) Q
 I $D(Y) Q
CLASS ;
 ;Class
RETRY W !!
 S DR="100"
 D ^DIE
 I $D(Y) G NAME
 ;Sponsor
 S DR="101"
 D ^DIE
 I $D(Y) G RETRY
 ;Make sure Class and Sponsor Class are in synch.
 S RESULT=$$VSPONSOR^PXRMINTR(X)
 I RESULT=0 S DIE("NO^")="Other value" G RETRY
 I RESULT=1 K DIE("NO^")
 ;Review date
RD W !!
 S DR="102"
 D ^DIE
 I $D(Y) G RETRY
 ;
 ;Description
DES S DR="1"
 D ^DIE
 I $D(Y) G RD
 ;
 ;Clinic Stops
CS S DR="40.7"
 S DR(2,810.9001)=".01;1;2;3"
 S DR(3,810.90011)=".01"
 D ^DIE
 I $D(Y) G RD
 ;
 ;Hospital Locations
HL S DR="44"
 D ^DIE
 I $D(Y) G CS
 Q
 ;
 ;================================================================
KAMIS(X,DA,WHICH) ;Kill the AMIS Reporting Stop Code.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 I WHICH="CREDIT STOP TO EXCLUDE" S $P(^PXRMD(810.9,DA(2),40.7,DA(1),1,DA,0),U,2)=""
 E  S $P(^PXRMD(810.9,DA(1),40.7,DA,0),U,2)=""
 Q
 ;
 ;================================================================
SAMIS(X,DA,WHICH) ;Set the AMIS Reporting Stop Code.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 N AMIS
 ;DBIA #557
 S AMIS=$P(^DIC(40.7,X,0),U,2)
 I WHICH="CREDIT STOP TO EXCLUDE" S $P(^PXRMD(810.9,DA(2),40.7,DA(1),1,DA,0),U,2)=AMIS
 E  S $P(^PXRMD(810.9,DA(1),40.7,DA,0),U,2)=AMIS
 Q
 ;
