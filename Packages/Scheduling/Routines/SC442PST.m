SC442PST ;ALB/RLC - POST INIT ROUTINE FOR PATCH 442; [Feb 19, 2004 10:30 am]
 ;;5.3;Scheduling;**442**;Aug 13, 1993
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This post-init routine modifies the narrative description
 ; for error codes D00 and D000 in file 409.76
 ;
FILE N DA,DR,DIE
 S SCDESC="Provider Type Code is missing, invalid or inactive."
 S DA="" F I="D00","D000" S DA=$O(^SD(409.76,"B",I,"")) Q:'DA  D
 .L +^SD(409.76,DA)
 .S DIE="^SD(409.76,",DR="11///^S X=SCDESC" D ^DIE
 .L -^SD(409.76,DA)
 K DA,DR,DIE,SCDESC,I
 ;
FILE1 N DA,DR,DIE,SCLOGIC,I
 S SCLOGIC="S RES=$$PROVCLS^SCMSVUT1(DATA)",I="D000"
 S DA="",DA=$O(^SD(409.76,"B",I,"")) Q:DA=""
 L +^SD(409.76,I)
 S DIE="^SD(409.76,",DR="31///^S X=SCLOGIC" D ^DIE
 L -^SD(409.76,DA)
 K DA,DR,DIE,SCLOGIC,I
 Q
