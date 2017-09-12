SC593PST ;HINES/LAI - POST INIT ROUTINE FOR PATCH 593;2/27/2012
 ;;5.3;Scheduling;**593**;Aug 13, 1993;Build 13
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This post-init routine modifies the narrative description
 ; for error codes 500 and 5000 in file 409.76.
 ;
EN N DA,DR,DIE
 S SCDESC="Diagnosis code (ICD) is missing or invalid"
 S DA="" F I="500","5000" S DA=$O(^SD(409.76,"B",I,"")) Q:'DA  D
 .L +^SD(409.76,DA):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 .S DIE="^SD(409.76,",DR="11///^S X=SCDESC" D ^DIE
 .L -^SD(409.76,DA)
 K DA,DR,DIE,SCDESC,I
 Q
 ;
