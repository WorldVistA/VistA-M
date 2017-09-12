DG53432P ;BP-CIOFO/MM -Post-init routine for DG*5.3*432 ;12/20/2001
 ;;5.3;Registration;**432**;Aug 13, 1993
 ;
EN ;This patch will update the closeout date for the 12/31/2001 census
 ;if an entry exists in the PTF Census Date (#45.86) file for that
 ;census.
 ;
 ;Look up 12/31/2001 census record in PTF Census Date (#45.86) file
 N DIC,X,Y
 S DIC="^DG(45.86,"
 S DIC(0)="MZ"
 S X=3011231
 D ^DIC
 I +Y'>0 D  Q
 .D BMES^XPDUTL("   12/31/2001 census record does not exist in PTF Census Date (#45.86) file.  No update needed.")
 ;Check closeout date and update to 1/19/2002 if necessary.
 I $P(Y(0),U,2)=3020119 D  Q
 .D BMES^XPDUTL("   Closeout date for 12/31/2001 currently set for")
 .D MES^XPDUTL("   1/19/2002.  No updating necessary.")
 N DIE,DA,DR
 S DIE="^DG(45.86,"
 S DA=+Y
 S DR=".02////3020119"
 D ^DIE
 D BMES^XPDUTL("   Closeout date for the 12/31/2001 census changed to 1/19/2002.")
 Q
