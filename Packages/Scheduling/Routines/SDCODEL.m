SDCODEL ;ALB/RMO,ESW - Delete - Check Out; 27 APR 1993 3:00 pm ; 10/10/02 5:38pm
 ;;5.3;Scheduling;**20,27,44,97,105,110,132,257**;Aug 13, 1993
 ;
EN(SDOE,SDMOD,SDELHDL,SDELSRC) ;Delete Check Out
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ;           SDMOD    1=Interactive and 0=Non-interactive
 ;           SDELHDL  Check Out Deletion Handle  [Optional]
 ;           SDELSRC  Source of delete
 ; Output -- Delete Check Out
 N DA,DFN,DE,DIE,DR,SDCL,SDDA,SDEVTF,SDOE0,SDOEP,SDORG,SDT,SDVSAV,SDVFLG
 D SET(SDOE,.SDOE0,.SDT,.DFN,.SDCL,.SDORG,.SDDA)
 S SDVSAV=$P(SDOE0,U,5)
 ;
 ; -- ok to delete?
 IF '$$EDITOK^SDCO3(SDOE,SDMOD) G ENQ
 ;
 IF $G(SDELSRC)'="PCE" S X=$$DELVFILE^PXAPI("ALL",$P($G(^SCE(SDOE,0)),U,5),"","","",1)
 S SDVFLG=1
 ;
 ; -- get handle if not passed and do 'before'
 I '$G(SDELHDL) N SDATA,SDELHDL S SDEVTF=1 D EVT^SDCOU1(SDOE,"BEFORE",.SDELHDL,.SDATA)
 ;
 I $G(SDMOD) W !!,">>> Deleting check out information..."
 ;
 ; -- delete child data for appts, dispos and stop code addition
 I "^1^2^3^"[("^"_SDORG_"^") D CHLD(SDOE,SDMOD) ;SD/257
 ;
 ; -- delete SDOE pointers and co d/t
 I SDORG=1 D
 .S DA(1)=DFN,DA=SDT,DIE="^DPT("_DFN_",""S"",",DR="21///@" D ^DIE
 .I $G(SDMOD) W !?3,"...deleting check out date/time"
 .S DR="303///@" D DIE^SDCO1(SDCL,SDT,+SDDA,DR)
 I SDORG=3 D
 .S DA(1)=DFN,DA=+SDDA,DIE="^DPT("_DFN_",""DIS"",",DR="18///@" D ^DIE
 ;
 ; -- do final deletes for sdoe
 D CO(SDOE,SDMOD)
 D OE(SDOE,SDMOD)
 ;
 I $G(SDMOD) W !,">>> done."
 ;
 ; -- if handle not passed, then 'after' and event
 I $G(SDEVTF) D EVT^SDCOU1(SDOE,"AFTER",SDELHDL,.SDATA,SDOE0)
 ;
 ; -- call pce to make sure its data is gone
 I $G(SDVFLG) D DEAD^PXUTLSTP(SDVSAV)
ENQ Q
 ;
CHLD(SDOEP,SDMOD) ;Delete Children
 N DFN,SDCL,SDDA,SDOE0,SDOEC,SDORG,SDT
 S SDOEC=0
 F  S SDOEC=$O(^SCE("APAR",SDOEP,SDOEC)) Q:'SDOEC  D
 .D SET(SDOEC,.SDOE0,.SDT,.DFN,.SDCL,.SDORG,.SDDA)
 .D OE(SDOEC,SDMOD)
 Q
 ;
SET(SDOE,SDOE0,SDT,DFN,SDCL,SDORG,SDDA) ;Set Variables
 S SDOE0=$G(^SCE(+SDOE,0)),SDT=+SDOE0,DFN=+$P(SDOE0,"^",2),SDCL=+$P(SDOE0,"^",4),SDORG=+$P(SDOE0,"^",8),SDDA=$P(SDOE0,"^",9)
 Q
 ;
CO(SDOE,SDMOD) ;Delete Classification
 N DA,DIK,SDFL,SDI
 I $P($G(^SCE(SDOE,0)),"^",6) G COQ
 I $O(^SDD(409.42,"AO",SDOE,0))>0 D
 .I $G(SDMOD) W !?3,"...deleting classifications"
 .D DEL(SDOE,409.42)
COQ Q
 ;
DEL(SDOE,SDFL) ;Delete Classification
 N DA,DIK,SDI
 S DIK="^SDD("_SDFL_",",SDI=0
 F  S SDI=$O(^SDD(SDFL,"AO",SDOE,SDI)) Q:'SDI  S DA=+$O(^(SDI,0)) D ^DIK
 Q
 ;
OE(SDOE,SDMOD) ;Delete Outpatient Encounter
 N DA,DIK,SDVSIT,SDORG,SDAT
 IF '$$EDITOK^SDCO3(SDOE,SDMOD) G OEQ
 S SDAT=$P($G(^SCE(+SDOE,0)),U,1)
 S SDVSIT=$P($G(^SCE(SDOE,0)),U,5),SDORG=$P($G(^SCE(SDOE,0)),U,8)
 S DA=SDOE,DIK="^SCE(" D ^DIK
 S X=$$KILL^VSITKIL(SDVSIT)
OEQ Q
 ;
COMDT(SDOE,SDMOD) ;Delete Check Out Process Completion Date
 N DA,DE,DIE,DQ,DR
 I $G(SDMOD) W !?3,"...deleting check out process completion date"
 S DA=SDOE,DIE="^SCE(",DR=".07///@" D ^DIE
 Q
