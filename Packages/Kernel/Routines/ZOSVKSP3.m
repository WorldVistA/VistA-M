ZOSVKSP3 ;SP/JML - VSM 3 Post install routine ;10/16/2020
 ;;8.0;KERNEL;**740**;3/1/2018;Build 6
 ;
EN ;-- entry point for post-install
 ;
 D MES^XPDUTL(" Begin Post-Install...")
 D STOPMON^KMPVCBG("VBEM",1)
 D MES^XPDUTL(" VBEM Monitor Stopped...")
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
 D STARTMON^KMPVCBG("VBEM",1)
 D MES^XPDUTL(" VBEM Monitor Restarted...")
 D MES^XPDUTL(" Post-Install complete!")
 ;
 Q
