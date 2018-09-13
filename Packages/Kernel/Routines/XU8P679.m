XU8P679 ; XU/LLB - EPIP XU*8.0*679 Preinstall routine ;Feb 8,2018@17:20
 ;;8.0;KERNEL;**679**;Jul 10, 1995;Build 27
FIX ; Deletes existing entries in EDUCATION file (#20.11) before install
 D BMES^XPDUTL("EDUCATION file (#20.11) is being cleared.")
 N DIK,D1
 S DIK="^DIC(20.11,"
 S D1=0
 F  S D1=$O(^DIC(20.11,D1)) Q:(D1'?.N)!(D1=0)  S DA=D1 D ^DIK
 D BMES^XPDUTL("File clearing is complete.")
 Q
