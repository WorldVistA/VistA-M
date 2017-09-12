DG5393PT ;ALB/CMM PATIENT NAME & E NODE CLEANUP POST-INT ;05/09/96
 ;;5.3;Registration;**93**;Aug 13, 1993
 ;
 ;This routine will changes any patient names containing space comma
 ;to just comma, space space to space, and remove colons and 
 ;semicolons.  Also will delete DAYS FOR CANCEL OF SCH ADM parameter
 ;from MAS PARAMETERS file (#43).
 ;
POST ;entry point for post-init, setting up checkpoints
 N %
 S %=$$NEWCP^XPDUTL("DFN","EN^DG5393PT",0)
 Q
 ;
EN ; begin processing
 D PTFILE
 D PARAM
 Q
 ;
PTFILE ;go through patient file converting patient names containing space 
 ;comma to just comma, space space to space, and remove colons and
 ;semicolons
 N DFN
 ;
 D BMES^XPDUTL("  >> Patient Name & E Node Clean-up")
 ;
 ;get value from checkpoints, previous run
 S DFN=+$$PARCP^XPDUTL("DFN")
 ;
LOOP ;
 N NAME,NEWNAME,%
 F  S DFN=$O(^DPT(DFN)) Q:DFN=""!(DFN'?.N)  D
 .S NAME=$P($G(^DPT(DFN,0)),"^")
 .I NAME[" ,"!(NAME["  ")!(NAME[":")!(NAME[";") D
 ..S NEWNAME=$$CLEAN^DPTLK(NAME),$P(^DPT(DFN,0),"^")=NEWNAME
 ..K ^DPT("B",$E(NAME,1,30),DFN)
 ..S DA=DFN,DIK="^DPT(",DIK(1)=".01^B^IVM01" D EN^DIK K DA,DIK
 ..; ^ reindexes .01 "B" cross reference
 .I $D(^DPT(DFN,"E",0)),($O(^(0))']"") K ^DPT(DFN,"E",0)
 .; ^ cleanup of erroneous "E" nodes
 .S %=$$UPCP^XPDUTL("DFN",DFN)
 .; ^ update checkpoint.
 Q
 ;
PARAM ;delete days for sched admit parameter from MAS PARAMETERS file (#43)
 N DA,DIK
 D BMES^XPDUTL("  >> Deleting DAYS FOR CANCEL OF SCH ADM parameter from MAS PARAMETERS file (#43)")
 S DIK="^DD(43,",DA(1)=43,DA=5
 D ^DIK
 S $P(^DG(43,1,0),"^",6)="" ; delete value if it exists
 Q
