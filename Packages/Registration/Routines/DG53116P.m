DG53116P ;ALB/ABR - QUARTERLY PATIENT CENSUS CLOSEOUT OF PTF; 7/18/96
 ;;5.3;Registration;**116**;Aug 13, 1993
 ;
 ;
CENSUS ;--- add new census date
 ;    These dates should be updated each quarter, per MAS VACO.
 ;
 ; **Note - the input transform for the .01 field of file 45.86
 ;   needs to be updated annually to the last date of the current FY
 ;   for this routine to run successfully.
 ;
 ;   Patch will include routine to update dates, and Data Dictionary
 ;   for .01 field               -abr
 ;
EN ;
 N CENDATE,CLOSDATE,OKTOXM,ACTIVE,CPSTART,ERR
 N DA,DD,DIC,DIE,DO,DR,X,Y
 ;
 S ERR=0
 ;
 ;-- ALL DATES ARE FOR FY97, Q1 AND Q2 CENSUS
 ;
 ;-- Census Date 3-31-97
 S CENDATE=2970331
 ;-- Close-out Date 4-18-97
 S CLOSDATE=2970418
 ;
 ;-- ok to x-mit PTF date 3-31-97
 ; **not needed per Austin
 S OKTOXM=2970331
 ;-- currently active
 S ACTIVE=1
 ;-- Census Period Start Date 10-1-96
 S CPSTART=2961001
 ;
 D BMES^XPDUTL(">>> Updating PTF Census Date File (#45.86) for 1st half, FY 1997.")
 ;
 S X=$O(^DG(45.86,"AC",0)) I X S X=$O(^DG(45.86,"AC",X,0)),DIE="^DG(45.86,",DA=X,DR=".04////0" D ^DIE K DIE,DR,DA
 S DIC="^DG(45.86,",X=CENDATE,DIC(0)="L" K DD,DO D ^DIC K DIC
 I Y'>0 S ERR=1 D ERR Q  ;checks to see if record is created
 S DIE="^DG(45.86,",DA=+Y,DR=".02////"_CLOSDATE_";.03////"_OKTOXM_";.04////"_ACTIVE_";.05////"_CPSTART
 D ^DIE K DIE,DR,DA
 ;
 D MES^XPDUTL("Done.")
 Q
 ;
 ; This will update the PTF CENSUS DATE File (#45.86).  The EN tag may be re-run
ERR ;
 I +ERR D BMES^XPDUTL("Problem with PTF CENSUS DATE File (#45.86) Update.  Call your IRMFO CS.")
 Q
