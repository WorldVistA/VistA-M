ICD1872P ;ALB/JDG - YEARLY DRG UPDATE;8/9/2010
 ;;18.0;DRG Grouper;**72**;Oct 20, 2000;Build 4
 ;
 ;This routine will kick off Routines needed for 
 ;FY 2014 updates to the DRG Grouper.
 ;Depending on the year and type of updates needed, not
 ;all of the routines will be needed.
 ;
 Q
 ;
EN ; start update
 D DRG^ICD1872A ;changes for DRGS
 ; ********************************************************************************
 ; *****routines ICD1872F-K contain the DRG info needed for the Grouper update*****
 ; ********************************************************************************
 ;D DIAG^ICD1872B ; UPDATES FOR NEW DIAGNOSIS CODES (no updates for FY2014)
 ;D PRO^ICD1872C ; UPDATES FOR NEW PROCEDURE CODES
 ; ************************************************************************************************ 
 ; *****for FY2014 four new procedure codes are being added via patch's ICD*18.0*73/LEX*2.0*93*****
 ; ************************************************************************************************
 ;D DIAG^ICD1872D ; UPDATES TO EXISTING DIAGNOSIS CODES IF ANY (no updates for FY2014)
 ;D PRO^ICD1872E ;  UPDATES TO EXISTING PROCEDURE CODES IF ANY (no updates for FY2014)
 D INACTDRG^ICD1872O ; INACTIVATE DRGs (no updates for FY2014; inactivated DRG119 since it was missed in FY2007)
 Q
