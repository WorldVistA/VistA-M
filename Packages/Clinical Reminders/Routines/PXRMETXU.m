PXRMETXU ; SLC/PJH - Extract utilities ;09/06/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
HELP(CALL) ;General help text routine
 N HTEXT
 I CALL=1 D
 .S HTEXT(1)="Enter 'Y' to overwrite this existing list. Enter 'N' to"
 .S HTEXT(2)="use a different patient list name."
 ;
 I CALL=3 D
 .S HTEXT(1)="Enter 'Y' to transmit extract. Otherwise enter 'N'."
 ;
 I CALL=4 D
 .S HTEXT(1)="The selected period is the same as next scheduled extract."
 .S HTEXT(2)="Enter 'Y' if this extract will replace the scheduled"
 .S HTEXT(3)="extract. Enter 'N' if you still want the scheduled extract"
 .S HTEXT(4)="to run."
 ;
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
DELETE(IEN) ;Delete an extract summary.
 I IEN="" Q
 N DA,DELOK,DIK,NAME
 S DELOK=1
 S NAME=$P(^PXRMXT(810.3,IEN,0),U,1)
 ;Must have PXRM MANAGER key in order to delete national extracts.
 I $P($G(^PXRMXT(810.3,IEN,100)),U,1)="N" D
 . S DELOK=$S($D(^XUSEC("PXRM MANAGER",DUZ)):1,1:0)
 . I 'DELOK D
 .. W !!,NAME," is national."
 .. W !,"You cannot delete a national extract summary."
 .. H 2
 I 'DELOK Q
 ;Double check the user really wants to delete.
 S TEXT="Are you sure you want to delete "_NAME
 S DELOK=$$ASKYN^PXRMEUT("N","Are you sure you want to delete "_NAME)
 I 'DELOK Q
 S DA=IEN
 S DIK="^PXRMXT(810.3,"
 D ^DIK
 W !,"Deleting ",NAME
 H 2
 Q
 ;
PRGES ;Delete any Extract Summaries over 5 years old
 N DIFF,EDATE,OLD
 S OLD=0
 F  S OLD=$O(^PXRMXT(810.3,OLD)) Q:'OLD  D
 .I +$G(^PXRMXT(810.3,OLD,50))'=1 Q
 .;Extract Date
 .S EDATE=$P($G(^PXRMXT(810.3,OLD,0)),U,6)
 .;Ignore if < 5 years (1826 days) since creation
 .I $$FMDIFF^XLFDT(DT,EDATE,1)<1826 Q
 .;Otherwise delete
 .N DIK,DA
 .S DIK="^PXRMXT(810.3,",DA=OLD D ^DIK
 Q
 ;
PRGPL ;Delete any Patient Lists over 5 years old
 N LDATE,OLD
 S OLD=0
 F  S OLD=$O(^PXRMXP(810.5,OLD)) Q:'OLD  D
 .I +$G(^PXRMXP(810.5,OLD,50))'=1 Q
 .;Patient List Date
 .S LDATE=$P($G(^PXRMXP(810.5,OLD,0)),U,4)
 .;Ignore if < 5 years (1826 days) since creation
 .I $$FMDIFF^XLFDT(DT,LDATE,1)<1826 Q
 .;Otherwise delete
 .N DIK,DA
 .S DIK="^PXRMXP(810.5,",DA=OLD D ^DIK
 Q
 ;
