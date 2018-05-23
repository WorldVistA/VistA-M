ZOSVKSP2 ;BP/RAK/JML - Post install routine ;7/26/2004
 ;;8.0;KERNEL;**670**;3/1/2018;Build 45
 ;
EN ;-- entry point for post-install
 ;
 D BMES^XPDUTL(" Begin Post-Install...")
 D SAVE
 D MES^XPDUTL(" Post-Install complete!")
 ;
 Q
 ;
SAVE ;-save correct files as '%' routines 
 ;
 N %D,%S,SCR,ZTOS
 S ZTOS=$$OSNUM^ZTMGRSET
 ; if not supported
 I ZTOS'=3 D  Q
 .D MES^XPDUTL(" "_$P($T(@ZTOS^ZTMGRSET),";",3)_" is not supported.  No routine saved!")
 ; supported
 S %D="%ZOSVKSD^%ZOSVKR",%S="ZOSVKSD^ZOSVKRO",SCR="I 1"
 D MOVE^ZTMGRSET
 D MES^XPDUTL("          for "_$P($T(@ZTOS^ZTMGRSET),";",3)_".")
 ;
 Q
 ;
PRE ; Stop RUM handler prior to installing anything.
 N DA,DIE,DR
 S DIE=8989.3,DA=1,DR="300///NO" D ^DIE
 Q
 ;
