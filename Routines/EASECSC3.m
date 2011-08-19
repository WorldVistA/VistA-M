EASECSC3 ;ALB/PHH - LTC Co-Pay Test Screen Marital Status/Dependents ;13 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5**;Mar 15, 2001
 ;
 ;NOTE: This routine was modified from DGMTSC1 for LTC Co-Pay
 ; Input  -- DFN      Patient IEN
 ;           DGMTACT  LTC Co-Pay Test Action
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVPRI   Veteran Patient Relation IEN
 ; Output -- None
 ;
EN ;Entry point for marital status/dependent screen
 D DIS
 S X="^4" G EN1^EASECSCR
 ;
DIS ;Display marital status/dependent information
 N DGDEP,DGINR,DGREL,DGVIR0,X
 D ALL^EASECU21(DFN,"CS",DGMTDT,"PR",$S($G(DGMTI):DGMTI,1:""))
 D EN^EASECDEP,DEP
DISQ Q
 ;
SPOUSE ;Add/Edit spouse demographic data
 N DGFL,DGIPI,DGPRI,DGREL,DGPRTY
 D GETREL^DGMTU11(DFN,"S",$E($S($G(DGMTDT):DGMTDT,1:DT),1,3)_"0000",$S($G(DGMTI):DGMTI,1:""))
SPOUSE1 S DGPRTY="S",DGPRI=$G(DGREL("S"))
 D:DGPRI EDIT^EASECED(DGPRI,DGPRTY)
 D ADD^EASECED(DFN,DGPRTY):'DGPRI
 I DGFL<0 S DGMTOUT=1
SPOUSEQ Q
 ;
DEP ;Update number of dependent children
 N DA,DGDEP,DGREL,DIE,DR
 D GETREL^DGMTU11(DFN,"C",$E(DGMTDT,1,3)_"0000",$S($G(DGMTI):DGMTI,1:""))
 S DA=DGVIRI,DIE="^DGMT(408.22,",DR=".08////^S X="_$S(DGDEP:1,1:0)_";.13///"_$S(DGDEP:DGDEP,1:"@") D ^DIE
 Q
