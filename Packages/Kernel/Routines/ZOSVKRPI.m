ZOSVKRPI ;BP/RAK - Post install routine ;8/3/10  10:49
 ;;8.0;KERNEL;**550**;;Build 23
 ;
EN ;-- entry point for post-install
 ;
 D BMES^XPDUTL(" Begin Post-Install...")
 D SAVE
 D MES^XPDUTL(" Post-Install complete!")
 ;
 Q
 ;
SAVE ;-save correct file as %ZOSVKR
 ;
 N %D,%S,SCR,ZTOS
 S ZTOS=$$OSNUM^ZTMGRSET
 ; if not supported
 I ZTOS'=3 D  Q
 .D MES^XPDUTL(" "_$P($T(@ZTOS^ZTMGRSET),";",3)_" is not supported.  No routine saved!")
 ; supported
 S %D="%ZOSVKR",%S="ZOSVKRO",SCR="I 1"
 D MOVE^ZTMGRSET
 D MES^XPDUTL("        for "_$P($T(@ZTOS^ZTMGRSET),";",3)_".")
 ;
 Q
