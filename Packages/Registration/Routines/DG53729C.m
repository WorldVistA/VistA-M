DG53729C ;ALB/MRY -Post-init routine for DG*5.3*729 Census ;7/19/2007
 ;;5.3;Registration;**729**;Aug 13, 1993;Build 59
 ;
EN ;This patch will update the closeout date for the 9/30/2007 census
 ;if an entry exists in the PTF Census Date (#45.86) file for that
 ;census.
 ;
 ;Look up 9/30/2007 census record in PTF Census Date (#45.86) file
 D BMES^XPDUTL("***** Updating PTF Census *****")
 N DIC,X,Y
 S DIC="^DG(45.86,"
 S DIC(0)="MZ"
 S X=3070930
 D ^DIC
 I +Y'>0 D  Q
 .D BMES^XPDUTL("   9/30/2007 census record does not exist in PTF Census Date (#45.86) file.  No update needed.")
 ;Check closeout date and update to 10/14/2007 if necessary.
 I $P(Y(0),U,2)=3071014 D  Q
 .D BMES^XPDUTL("   Closeout date for 9/30/2007 currently set for")
 .D MES^XPDUTL("   10/14/2007.  No updating necessary.")
 N DIE,DA,DR
 S DIE="^DG(45.86,"
 S DA=+Y
 S DR=".02////3071014"
 D ^DIE
 D BMES^XPDUTL("   Closeout date for the 9/30/2007 census changed to 10/14/2007.")
 Q
