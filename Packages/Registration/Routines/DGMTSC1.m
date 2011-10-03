DGMTSC1 ;ALB/RMO/CAW - Means Test Screen Marital Status/Dependents ;24 JAN 1992 7:40 am
 ;;5.3;Registration;**45,624**;Aug 13, 1993
 ;
 ; Input  -- DFN      Patient IEN
 ;           DGMTACT  Means Test Action
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVPRI   Veteran Patient Relation IEN
 ; Output -- None
 ;
EN ;Entry point for marital status/dependent screen
 D DIS
 S X="^2" G EN1^DGMTSCR
 ;
DIS ;Display marital status/dependent information
 N DGDEP,DGINR,DGREL,DGVIR0,X
 D ALL^DGMTU21(DFN,"CS",DGMTDT,"PR",$S($G(DGMTI):DGMTI,1:""))
 D GROSS^DGMTSCU4(DGVINI,DFN,DGMTDT,DGVIRI)
 D EN^DGDEP,DEP
DISQ Q
 ;
SPOUSE ;Add/Edit spouse demographic data
 N DGFL,DGIPI,DGPRI,DGREL,DGPRTY
 D GETREL^DGMTU11(DFN,"S",$$LYR^DGMTSCU1($S($G(DGMTDT):DGMTDT,1:DT)),$S($G(DGMTI):DGMTI,1:""))
SPOUSE1 S DGPRTY="S",DGPRI=$G(DGREL("S"))
 D:DGPRI EDIT^DGRPEIS(DGPRI,DGPRTY)
 D ADD^DGRPEIS(DFN,DGPRTY):'DGPRI
 I DGFL<0 S DGMTOUT=1
SPOUSEQ Q
 ;
DEP ;Update number of dependent children
 N DA,DGDEP,DGREL,DIE,DR
 D GETREL^DGMTU11(DFN,"C",$$LYR^DGMTSCU1(DGMTDT),$S($G(DGMTI):DGMTI,1:""))
 S DA=DGVIRI,DIE="^DGMT(408.22,",DR=".08////^S X="_$S(DGDEP:1,1:0)_";.13///"_$S(DGDEP:DGDEP,1:"@") D ^DIE
 D:+$G(DGMTDPCH)  S DGMTDPCH=0
 .S DGMTDPCH=$$ADJUST^DGMTSCU4(DGVINI,DFN,DGMTDT,DGVIRI)
 .Q
 Q
