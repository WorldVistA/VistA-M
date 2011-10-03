IBY374PR ;PRXM/CMW - Pre install routine for  patch 374 ; 10 May 2007  9:41 AM
 ;;2.0;INTEGRATED BILLING;**374**;21-MAR-94;Build 16
 ;
 ; Call at tags only
 Q
 ; This routine will clean up entries in the file with NPIs delete status (2)
 ;
EN ; PRE Install Routine primary entry point
 ; Delete NPI EFFECTIVE DATE; STATUS codes fields
 ; Status codes will be reloaded during install of patch 374
 S DIK="^DD(355.9301,",DA(1)=355.9301,DA=.02 D ^DIK
 ;
 Q
