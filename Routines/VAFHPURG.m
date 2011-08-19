VAFHPURG ;ALB/JLU;Purging routine. ; 8/9/04 11:00am
 ;;5.3;Registration;**91,219,530,604**;Jun 06, 1996
 ;
 ;This routine will delete all entries from the ADT/HL7 PIVOT
 ;(#391.71) file that are older than number of days specified
 ;in field #391.702 of file #43.
 ;
EN ;entry point
 N DA,DIC,DIQ,DR,VAR1,VARA,DAYS,X1,X2
 ;find number of days worth of file entries to be retained
 S VAR1=$O(^DG(43,0))
 S DIC="^DG(43,",DA=VAR1,DIQ="VARA",DIQ(0)="I",DR="391.702;"
 D EN^DIQ1
 ;use 547 days (18 months) unless otherwise specified
 S DAYS=VARA(43,VAR1,391.702,"I") S:+DAYS=0 DAYS=547
 D DT^DICRW
 S X1=DT
 S X2=-DAYS
 D C^%DTC
 S (Y,VAFHEDT)=X
 D DD^%DT
 W:'$D(ZTQUEUED) !!,"All ADT/HL7 PIVOT entries older than ",Y," will be deleted!",!
 D KIL1
 ;iofo-bay pines;vmp;teh; modification to quit logical to prevent null subscript.
 F VAFHX=0:0 S VAFHX=$O(^VAT(391.71,"B",VAFHX)) Q:VAFHX>VAFHEDT!(VAFHX="")  D DELETE
 D EXIT
 ;D CLEAN
 ;D EXIT
 Q
 ;
DELETE ;this will do that actual deletion.
 ;
 N DA,DIK,EVENT,MOVE,OUT
 S DA=0
 F  S DA=+$O(^VAT(391.71,"B",VAFHX,DA)) Q:('DA)  D
 .;DG*604 - skip if no zero node
 .I '$D(^VAT(391.71,DA,0)) Q
 .;don't delete inpatient event records before discharge
 .S EVENT=+$P(^VAT(391.71,DA,0),U,4)
 .I EVENT=1 D  Q:OUT
 ..S OUT=0
 ..S MOVE=$P(^VAT(391.71,DA,0),U,5)
 ..Q:MOVE'["DGPM"
 ..I $P($G(^DGPM(+MOVE,0)),U,17)="" S OUT=1
 .;don't delete if requires transmission
 .Q:$D(^VAT(391.71,"AXMIT",EVENT,DA))
 .;delete
 .S DIK="^VAT(391.71,"
 .D ^DIK
 .W:'$D(ZTQUEUED) "."
 Q
 ;
EXIT ;kills variables
 K VAFHX,VAFHEDT,X,Y
 Q
 ;
KIL1 K X,Y,%DT
 Q
 ;
CLEAN ; delete entries with invalid event pointer, ie doesn't exist 
 ; CLEAN^VAFHPURG may be run directly from programmer mode
 ;
 I '$D(ZTQUEUED) W !!,"All ADT/HL7 PIVOT entries with invalid EVENT POINTERS will be deleted",!
 D DT^DICRW
 N EVENTVP,GLOBAL,GLOBALR,NODE
 S VAFHX=0
 F  S VAFHX=$O(^VAT(391.71,VAFHX)) Q:'VAFHX  S NODE=$G(^(VAFHX,0)) DO
 .;  if no .01 date/time 
 . I 'NODE D REMOVE Q
 . S EVENTVP=$P(NODE,"^",5)
 .;  if event pointer has no pointer
 . I 'EVENTVP D REMOVE Q
 . S GLOBAL=$P(EVENTVP,";",2)
 .;  if event pointer has no variable
 . I GLOBAL="" D REMOVE Q
 .;  if variable not distributed
 . I "DPT(DGPM(SCE("'[GLOBAL D REMOVE Q
 . S GLOBALR="^"_GLOBAL_+EVENTVP_")"
 .;
 . I $D(@GLOBALR) Q
 .;  if no pointed to eentr delete this oney 
 . D REMOVE Q
 Q
 ;
 ;either the pointed to entry doesn't exist or the VP entry is invalid
 ;so delete it
REMOVE S DA=VAFHX
 S DIK="^VAT(391.71,"
 D ^DIK
 I '$D(ZTQUEUED) W ","
 K DIK,DA
 Q
