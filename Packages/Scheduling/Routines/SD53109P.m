SD53109P ;ALB/ABR - ADD NPCDB ERROR CODE; 3/20/97
 ;;5.3;Scheduling;**109**;Aug 13, 1993
 ;
 ;
 ;
EN ;
 N DESC,ERR,DA,DD,DIC,DIE,DO,DR,X,Y
 ;
 ;
 D BMES^XPDUTL(">>> Adding NPCDB error code 303 to file #409.76")
 ;
 S DESC="For DSS Identifier '108' date of death cannot be more than 14 days before admit date."
 S (DIC,DIE)="^SD(409.76,",X=303,DIC(0)="L" K DD,DO D ^DIC K DIC
 I Y'>0 S ERR=1 D ERR Q  ;checks to see if record is created
 S DA=+Y,DR="11////^S X=DESC"
 D ^DIE K DIE,DR,DA
 ;
 D MES^XPDUTL("Done.")
 Q
 ;
ERR ;
 I +ERR D BMES^XPDUTL("Problem with TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE (#409.76) file update.  Call your IRMFO CS.")
 Q
