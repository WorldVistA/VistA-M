DGYMODS ;ALB/MLI - Turn off ODS software ; 3/28/95
 ;;5.3;Registration;**55**;Aug 13, 1993
 ;
 ; This routine will turn off the ODS software and unschedule
 ; the ODS Background Job option.
 ;
EN ; entry point (or call from top)
 I '$D(^A1B2(11500.5,1,0)) D  Q  ; ods software not set-up
 . W !,"The ODS PARAMETER file was not set up on your system.  No changes made."
 S DA=1,DR=".02////0",DIE="^A1B2(11500.5," D ^DIE
 S DGVER=$$VERSION^XPDUTL("XU")
 S DIC="^DIC(19,",DIC(0)="QMZ",X="A1B2 BACKGROUND JOB" D ^DIC S (DGIEN,DA)=+Y
 I DA'>0 G ENQ ; background job not in option file
 I DGVER<8 S DR="200///@;201///@;202///@;203///@",DIE=DIC D ^DIE
 I DGVER'<8 S DIK="^DIC(19.2," F DA=0:0 S DA=$O(^DIC(19.2,"B",DGIEN,DA)) Q:'DA  D ^DIK
ENQ W !,"The ODS software has now been turned off at your facility"
 K DA,DGIEN,DGVER,DIC,DIE,DIK,DR,X,Y
 Q
