VSITIPRE ;ISL/dee - Visit Tracking PRE INIT rtn ;8/12/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996
 ;
 N DIC,Y,X,DD,DO,DA,DR,DIE
 S X="VISIT TRACKING"
 S DIC="^DIC(9.4,"
 S DIC(0)="X"
 D ^DIC
 Q:Y>0
 S DIC("DR")="1///VSIT"
 D FILE^DICN
 Q
 ;
