SCCVCST2 ; ALB/TMP - SCHED VSTS RE-CONVERSION - DELETE ENCOUNTER; 25-NOV-97
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
DELE(SDOE) ;Delete Encounter on re-convert
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ;
 N DA,DFN,DE,DIE,DR,SDCL,SDDA,SDOE0,SDOEP,SDORG,SDT,SDVSAV,SDCNV
 ;
 D SET(SDOE,.SDOE0,.SDT,.DFN,.SDCL,.SDORG,.SDDA,.SDCNV)
 ;
 ; Only delete encounter if created originally from conversion
 G:'SDCNV DELEQ
 ;
 D DELPTR(DFN,SDT,SDDA,SDORG,SDOE)
 ;
 ; -- delete child data for appts and dispos
 I "^1^3^"[("^"_SDORG_"^") D CHLD(SDOE)
 ;
 D OE(SDOE)
 ;
DELEQ Q
 ;
CHLD(SDOEP) ;Delete child encounters
 ;  SDOEP  := Parent encounter ien
 ;
 N DFN,SDCL,SDDA,SDOE0,SDOEC,SDORG,SDT,SDCNV
 S SDOEC=0
 F  S SDOEC=$O(^SCE("APAR",SDOEP,SDOEC)) Q:'SDOEC  D
 . D SET(SDOEC,.SDOE0,.SDT,.DFN,.SDCL,.SDORG,.SDDA,.SDCNV)
 . Q:'SDCNV  ;Only delete encounter if created by the conversion
 . D DELPTR(DFN,SDT,SDDA,SDORG,SDOEC)
 . D OE(SDOEC)
 Q
 ;
SET(SDOE,SDOE0,SDT,DFN,SDCL,SDORG,SDDA,SDCNV) ;Set Variables
 ;
 S SDOE0=$G(^SCE(+SDOE,0)),SDT=+SDOE0,DFN=+$P(SDOE0,"^",2),SDCL=+$P(SDOE0,"^",4),SDORG=+$P(SDOE0,"^",8),SDDA=$P(SDOE0,"^",9)
 S SDCNV=$G(^SCE(+SDOE,"CNV"))
 Q
 ;
DELPTR(DFN,SDT,SDDA,SDORG,SDOE) ; -- delete pointers to encounters in scheduling files
 ; DFN   == patient ien
 ; SDT   == encounter date/time
 ; SDDA  == extended reference from encounter 9th piece
 ; SDORG == flag for origin of encounter
 ; SDOE  == encounter ien
 ;
 N DA,DIE,DR,SDI,SDCS,SDVIEN
 IF SDORG=1,$P($G(^DPT(DFN,"S",SDT,0)),U,20)=SDOE D  Q
 .S DA(1)=DFN,DA=SDT,DIE="^DPT("_DFN_",""S"",",DR="21///@" D ^DIE
 ;
 S SDVIEN=$$SDVIEN^SCCVU(DFN,SDT)
 IF SDORG=2 F SDI=1:1:$L(SDDA,":") D  Q
 . S SDCS=+$P(SDDA,":",SDI)
 . IF SDCS,$P($G(^SDV(SDVIEN,"CS",SDCS,0)),U,8)=SDOE D
 . . S DA(1)=SDT,DA=SDCS,DIE="^SDV("_SDVIEN_",""CS"",",DR="8///@" D ^DIE
 ;
 IF SDORG=3,$P($G(^DPT(DFN,"DIS",+SDDA,0)),U,18)=SDOE D  Q
 .S DA(1)=DFN,DA=+SDDA,DIE="^DPT("_DFN_",""DIS"",",DR="18///@" D ^DIE
 ;
 Q
 ;
OE(SDOE) ;Delete Outpatient Encounter
 ;  SDOE  := Encounter ien
 ; 
 N DA,DIK
 S DA=SDOE,DIK="^SCE(" D ^DIK
 Q
 ;
DEL(SDOE,SDFL) ;Delete Classification - NOT NEEDED - no data existed for the
 ;  periods allowed to be converted
 ;   SDOE  := Encounter ien
 ;   SDFL  := Internal file # of entry to delete
 ; 
 Q
 N DA,DIK,SDI
 S DIK="^SDD("_SDFL_",",SDI=0
 F  S SDI=$O(^SDD(SDFL,"AO",SDOE,SDI)) Q:'SDI  S DA=+$O(^(SDI,0)) D ^DIK
 Q
 ;
CO(SDOE) ;Delete Classification - NOT NEEDED - no data existed for the
 ;  periods allowed to be converted
 ;  SDOE  := Encounter ien
 ; 
 G COQ
 N DA,DIK,SDFL,SDI
 I $P($G(^SCE(SDOE,0)),"^",6) G COQ
 I $O(^SDD(409.42,"AO",SDOE,0))>0 D DEL(SDOE,409.42)
COQ Q
 ;
