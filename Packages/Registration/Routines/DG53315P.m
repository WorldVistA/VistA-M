DG53315P ;ALB-CIOFO/MRY - Add PTF Quarterly Census date;8/10/00
 ;;5.3;Scheduling/Registration;**315**;Aug 13, 1993
 ;
 ;
CENSUS ;--- add new census date
 ;    These dates should be updated each quarter, per MAS VACO.
 ;
 ; **NOTE - the input transform for the .01 field of file 45.86
 ;   needs to be updated quarterly to the last date of the quarter
 ;   for this routine to run successfully.
 ;
 ;   Patch will include routine to update dates, and Data Dictionary
 ;   for .01 field             
 ;
EN ;
 N CENDATE,CLOSDATE,OKTOXM,ACTIVE,CPSTART,ERR
 N DA,DD,DIC,DIE,DLAYGO,DO,DR,X,Y
 ;
 S ERR=0
 ;
 ;-- ALL DATES ARE FOR FY2000, Q4 CENSUS
 ;
 ;-- Census Date 9-30-2000
 S CENDATE=3000930
 ;-- Close-out Date 10-13-2000
 S CLOSDATE=3001013
 ;
 ;-- ok to x-mit PTF date 3-31-1997
 ; **no need to change, per Austin
 S OKTOXM=2970331
 ;-- currently active
 S ACTIVE=1
 ;-- Census Period Start Date 7-1-2000
 S CPSTART=3000701
 ;
 D BMES^XPDUTL(">>> Updating PTF Census Date File (#45.86) for 4th Quarter, FY 2000.")
 S X=$O(^DG(45.86,"AC",0)) I X S X=$O(^DG(45.86,"AC",X,0)),DIE="^DG(45.86,",DA=X,DR=".04////0" D ^DIE K DIE,DR,DA
 S DIC="^DG(45.86,",X=CENDATE,DIC(0)="L",DLAYGO=45.86 K DD,DO D ^DIC K DIC
 I Y'>0 S ERR=1 D ERR Q  ;checks to see if record is created
 S DIE="^DG(45.86,",DA=+Y,DR=".02////"_CLOSDATE_";.03////"_OKTOXM_";.04////"_ACTIVE_";.05////"_CPSTART
 D ^DIE K DIE,DR,DA
 ;
 D MES^XPDUTL("Done.")
 Q
 ;
 ; This will update the PTF CENSUS DATE File (#45.86).  The EN tag may be re-run
ERR ;
 D BMES^XPDUTL("Problem with PTF CENSUS DATE File (#45.86) Update.  Please")
 D MES^XPDUTL("contact the National VISTA Support Team for assistance.")
 Q
