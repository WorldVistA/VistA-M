DG53P839 ;ALB/MJB -Post-init routine for DG*5.3*839 Census ; 2/10/11
 ;;5.3;Registration;**839**;Aug 13, 1993;Build 3
 ;
 Q
EN ;This patch will update the closeout date for the 3/31/2011 census
 ;if an entry exists in the PTF Census Date (#45.86) file for that
 ;census.
 ;
 ;Look up 3/31/2011 census record in PTF Census Date (#45.86) file
 D BMES^XPDUTL("***** Updating PTF Census *****")
 N DIC,X,Y
 S DIC="^DG(45.86,"
 S DIC(0)="MZ"
 S X=3110331
 D ^DIC
 I +Y'>0 D  Q
 .D BMES^XPDUTL("   3/31/2011 census record does not exist in PTF Census Date (#45.86) file.  No update needed.")
 ;Check closeout date and update to 4/07/2011 if necessary.
 I $P(Y(0),U,2)=3110407 D  Q
 .D BMES^XPDUTL("   Closeout date for 3/31/2011 currently set for")
 .D MES^XPDUTL("   4/07/2011.  No updating necessary.")
 N DIE,DA,DR
 S DIE="^DG(45.86,"
 S DA=+Y
 S DR=".02////3110407"
 D ^DIE
 D BMES^XPDUTL("   Closeout date for the 3/31/2011 census changed to 4/07/2011.")
 Q
