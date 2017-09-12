ICD1882P ;ALB/JDG - YEARLY DRG UPDATE;8/9/2010
 ;;18.0;DRG Grouper;**82**;Oct 20, 2000;Build 21
 ;
 ;This routine will kick off Routines needed for 
 ;FY 2016 updates to the DRG Grouper.
 ;
 Q
 ;
EN ; start update
 D PRE^ICD1882A ;
 Q
EN2 ; continue update
 D INACTDRG^ICD1882O ;inactivate DRGs
 D DRG^ICD1882X ;changes for DRGS
 ; ********************************************************************************
 ; *****routines ICD1872F-K contain the DRG info needed for the Grouper update*****
 ; ********************************************************************************
 D POST^ICD1882A ;
 Q
