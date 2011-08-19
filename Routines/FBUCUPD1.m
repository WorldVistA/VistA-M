FBUCUPD1 ;ALBISC/TET - UPDATE AFTER EVENT (CONTINUED) ;4/21/93  20:41
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;called from fbucupd
AUTH(FBUCP,FBUCA,FBDA,FBACT) ;update authorization in authorization file
 ;INPUT:  ;function call to determine action,
 ;         0 to kill/1 to set/2 to change/null for no change
 ;        FBUCP  - data prior to edit
 ;        FBUCA  - data after edit
 ;        FBDA   - ien of unauthorized claim, file 162.7
 ;        FBACT - action type
 ;OUTPUT:  -- update patient's authorization
 ;        will add if entry not already there,
 ;        delete or change if entry already there,
 ;        otherwise will quit (based on variables FBAUTH and FBIEN)
 ;        FBOUT = 1 if timed out, otherwise 0
 N FBAUTH S FBAUTH=$$AUTH^FBUCUTL6(FBUCP,FBUCA) G:FBAUTH']"" AUTHQ
 N FBAUTHF,FBDCHG,FBIEN,FBLOCK,FBV,FBVET,FBY,DA,DIC,DIE,DIK,DIR,DR,DTOUT,DUOUT,X,Y S FBDCHG=0 S:'$D(FBOUT) FBOUT=0
 S FBV=FBDA_";FB583(" S:'$D(FBVET) FBVET=+$P(FBUCA,U,4),FBIEN=+$O(^FBAAA("AG",FBV,FBVET,0))
 I FBAUTH'=1,FBIEN D  ;delete or edit & entry exists
 .I FBAUTH=0,'$$PAY^FBUCUTL(FBDA,"^FB583(") D
 ..N FBAIEN W !,"Deleting authorization...",!
 ..S DA(1)=FBVET,DA=FBIEN,DIK="^FBAAA("_DA(1)_",1," D ^DIK K DIK
 ..S FBAIEN=+$P(FBUCA,U,27) I FBAIEN D UPDATE1("@",FBDA)
 .I FBAUTH=2 D UPDATE
 I FBAUTH=1,FBIEN,FBACT="REO" D UPDATE
 I FBAUTH=1,'FBIEN D  ;add & entry not already in file
 .;check if vet in file, if not add
 .S Y=0 N FBAIEN,FBVAR I '$D(^FBAAA(FBVET,0)) S Y=$$FILE^FBUCUTL("^FBAAA(",FBVET,1) Q:+Y'>0  S FBVET=+Y,^FBAAA(FBVET,1,0)="^161.01D^^"
 .I +Y'>0 S:'$D(^FBAAA(FBVET,1,0)) ^FBAAA(FBVET,1,0)="^161.01D^^"
 .I "^6^7^"[$P(FBUCA,U,2) D
 ..S DIR(0)="161.01,.06",DIR("B")="DISCHARGE" D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 ..I FBOUT&($P(FBUCA,U,2)=6) W !,*7,"Discharge type is missing!  Enter using the Re-open Unauthorized Claim option.",! H 3
 ..S:'FBOUT FBDCHG=Y
 .S DIE="^FBAAA("_FBVET_",1,",FBAUTHF=+$P(FBUCA,U,13) I FBAUTHF S Y=$$FILE^FBUCUTL(DIE,FBAUTHF,0,FBVET) Q:+Y'>0  S (FBAIEN,FBIEN)=+Y,DA=FBVET,DR="[FB UNAUTHORIZED UPDATE]",DIE="^FBAAA("
 .I FBAUTHF D LOCK^FBUCUTL(DIE,FBVET,1) I FBLOCK D ^DIE L -^FBAAA(FBVET) K DA,DIE,DQ,DR,FBLOCK D UPDATE1(FBAIEN,FBDA) ;S:$D(DTOUT) FBOUT=1 I 'FBOUT D UPDATE1(FBAIEN,FBDA)
AUTHQ K DA,DIC,DIE,DQ,DR,DTOUT,DUOUT,FBDCHG,X,Y Q
UPDATE ;update if there is a change - keeps 583 and authorization in sync
 N DA,DIE,DR,FBLOCK
 S DA=FBVET,DR="[FB UNAUTHORIZED UPDATE1]",DIE="^FBAAA("
 D LOCK^FBUCUTL(DIE,FBVET,1) I FBLOCK D ^DIE L -^FBAAA(FBVET)
 Q
UPDATE1(FBAIEN,FBIEN) ;update authorization field (# 30) for unauthorized claim
 ;INPUT:  FBAIEN = internal entry number of authorization (could be '@' for deletion
 ;        FBIEN  = internal entry number of u/c (may be fbda)
 ;        FBALL  = flag to update all other claims (1=update all)
 ;OUTPUT: update field 30 (AUTHORIZAITION) to value of fbaien
 N DA,DIE,DR,FBLOCK I $S(+$G(FBAIEN)'>0&(FBAIEN'="@"):1,'+$G(FBIEN):1,FBAIEN'?1N.N&(FBAIEN'="@"):1,1:0) Q
 S DA=FBIEN,DIE="^FB583(",DR="S:FBAIEN=""@"" Y=""@1"";30////^S X=FBAIEN;S Y=""@99"";@1;30///@;@99" D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FB583(FBIEN)
 Q
