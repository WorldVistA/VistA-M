DGYXCEN ;ALB/LM - ANNUAL PATIENT CENSUS CLOSEOUT OF PTF ; 8/10/95
 ;;5.3;Registration;**66**;Aug 13, 1993
 ;
 ;
CENSUS ;--- add new census date
 ;    These dates should be update each year per MAS VACO.
EN ;
 N CENDATE,CLOSDATE,OKTOXM,ACTIVE,CPSTART,ERR
 S ERR=0
 ;
 ;-- ALL DATES ARE FOR '95 CENSUS
 ;
 ;-- Census Date 9-30-95
 S CENDATE=2950930
 ;-- Close-out Date 10-31-95
 S CLOSDATE=2951031
 ;-- ok to x-mit PTF date 11-1-95
 S OKTOXM=2951101
 ;-- currently active
 S ACTIVE=1
 ;-- Census Period Start Date 10-1-94
 S CPSTART=2941001
 ;
 W !!,">>> Updating PTF Census Date File (#45.86) for FY 1995."
 ;
 S X=$O(^DG(45.86,"AC",0)) I X S X=$O(^DG(45.86,"AC",X,0)),DIE="^DG(45.86,",DA=X,DR=".04////0" D ^DIE K DIE,DR,DA
 S DIC="^DG(45.86,",X=CENDATE,DIC(0)="L" K DD,DO D ^DIC K DIC
 I Y'>0 S ERR=1 D ERR Q  ;checks to see if record is created
 S DIE="^DG(45.86,",DA=+Y,DR=".02////"_CLOSDATE_";.03////"_OKTOXM_";.04////"_ACTIVE_";.05////"_CPSTART
 D ^DIE K DIE,DR,DA
 ;
 W "Done."
 Q
 ;
 ; This will update the PTF CENSUS DATE File (#45.86).  The EN tag may be re-run
ERR N DGPRINT
 S DGPRINT=$S($D(ZTQUEUED):0,1:1)
 I +ERR W:$G(DGPRINT) !,"Problem with PTF CENSUS DATE File (#45.86) Update.  Call your IRMFO CS."
 Q
