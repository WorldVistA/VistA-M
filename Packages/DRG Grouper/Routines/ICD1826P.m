ICD1826P ;;ALB/JAT - 2007 FY DRG GROUPER UPDATE; 7/27/05 14:50
 ;;18.0;DRG Grouper;**26**;Oct 13,2000;Build 1
 ;
 ; fix latest tickets
 Q
 ;
REMEDY ;
 D BMES^XPDUTL("...Repairing Remedy ticket...")
 ; HD169542
 ; kill 80.171 record
 N DA,DIK
 S DA(1)=2750
 S DA=1
 S DIK="^ICD0("_DA(1)_",""2"","
 D ^DIK
 Q
                         
