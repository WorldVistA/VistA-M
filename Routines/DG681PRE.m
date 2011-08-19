DG681PRE ;BAY/ALS;Deleting field ; 10/05/05
 ;;5.3;Registration;**681**;Aug 13, 1993
 ;
 ;This is a pre-install routine for DG*5.3*681
 ;The purpose is to delete the PIVOT FILE DAYS TO RETAIN (391.702)
 ;field in the MAS PARAMETERS (43) file.  The install will then
 ;add the field with corrections.
EN ;
 S DIK="^DD(43,",DA=391.702,DA(1)=43
 D ^DIK K DIK,DA,DA(1)
 Q
