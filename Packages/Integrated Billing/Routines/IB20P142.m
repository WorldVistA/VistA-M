IB20P142 ;ALB/BGA - IB V2.0 POST INIT,ADD/EDIT ENTRIES #351.51 ; 3-8-2001
 ;;2.0;INTEGRATED BILLING;**142**;21-MAR-94
 ;
 ; Post Init Description: This init will UPDATE two existing entries
 ;  in file #351.51 and also add one new entry to the same file.
 ;  file 399.1. This post init is associated with path *142*.
 ;
 ; Control Logic
 D NEWAT   ; Added new entry to #351.51
 D EDIT    ; Edit entries in #351.51
 D LAST    ; End Task
 Q
 ;
 ;
NEWAT ; Add new IB CHAMPUS Error Codes into file #351.51
 D BMES^XPDUTL(">>>Adding new IB CHAMPUS error codes into file #351.51")
 F IBI=1:1 S IBCR=$P($T(NEW+IBI),";;",2) Q:IBCR="QUIT"  D
 .S (X,IBSYS)=$P(IBCR,"^"),IBCODE=$P(IBCR,"^",2)
 .I $D(^IBE(351.51,"AD",IBSYS,IBCODE)) D  Q
 . . D BMES^XPDUTL(" >>Error Code '"_IBCODE_"' is already on file for the "_IBSYS_" system.")
 .K DD,DO S DIC="^IBE(351.51,",DIC(0)="" D FILE^DICN Q:Y<0
 .S ^(0)=^IBE(351.51,+Y,0)_"^"_$P(IBCR,U,2,3) S DIK=DIC,DA=+Y D IX1^DIK
 .D BMES^XPDUTL(" >>Error Code '"_IBCODE_"' for the '"_IBSYS_"' System has been filed.")
 K DA,DIC,DIE,DIK,DR,IBI,IBCR,IBCODE,IBSYS,X,Y,Z
 Q
 ;
NEW ; Action Types to add into file #351.51
 ;;UNIVERSAL^M6^Out of Region
 ;;QUIT
 ;
EDIT ; Edit entries in IB CHAMPUS Error Codes
 N I,IBC51,IBIT,IBROW,IBSYSE,IBUP
 D BMES^XPDUTL(">>>Searching for IB CHAMPUS ERROR Codes to UPDATE")
 F IBIT=1:1 S IBROW=$P($T(MOD+IBIT),";;",2) Q:IBROW="QUIT"  D
 . S IBC51=$P(IBROW,U,2),IBSYSE=$P(IBROW,U)
 . I (IBC51="O5")!(IBC51="O6") D
 . . I $D(^IBE(351.51,"AD",IBSYSE,IBC51)) D
 . . . S DA=$O(^IBE(351.51,"AD",IBSYSE,IBC51,0)) Q:'DA
 . . . S IBUP="0"_$E(IBC51,2),DIE="^IBE(351.51,",DR=".02////"_IBUP
 . . . D ^DIE K DIE,DA,DR
 . . . D BMES^XPDUTL(" >> "_IBSYSE_" Error Code '"_IBC51_"' has been UPDATED to '"_IBUP_"'")
 ;
 I '$D(IBUP) D BMES^XPDUTL(" >>Codes are CORRECT no MODIFICATIONS required.")
 Q
 ;
MOD ; Edit entries that are currently incorrect in file #351.51
 ;;MLINK^O5^Bad Invalid Data bits Setting
 ;;UNIVERSAL^O6^Out of Region
 ;;QUIT
 ;
LAST ;
 D BMES^XPDUTL(">>>ALL POST-INIT Activities have been completed. <<<")
 Q
