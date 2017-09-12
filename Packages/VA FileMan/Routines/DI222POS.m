DI222POS ;HPE/MSC/STAFF- Post Installation Routine for FileMan v22.2;05/10/2016
 ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 Q
 ;
POST ;Post Installation Things
 N SCR S SCR="I 1" ;From:OS+2^ZTMGRSET
 N ZTOS S ZTOS=$$OSNUM^ZTMGRSET ;From: B+1^ZTMGRSET DBIA:
 D MES^XPDUTL("Saving Routine: DIDT, As: %DT")
 D MES^XPDUTL("Saving Routine: DIDTC, As: %DTC")
 D MES^XPDUTL("Saving Routine: DIRCR, As: %RCR")
 D MES^XPDUTL(" ")
 N %S,%D
 S %S="DIDT^DIDTC^DIRCR",%D="%DT^%DTC^%RCR"
 D MOVE^ZTMGRSET ;DBIA:
 D MES^XPDUTL(" ")
 ;
 N RTN
 S RTN="%DT" D DISP
 S RTN="%DTC" D DISP
 S RTN="%RCR" D DISP
 ;
 ;
 ;D MES^XPDUTL("Initializing Meta Data Dictionary(#.9)")
 ;D ^DDD
 ;
 ; Hard code ^DD("STRING_LIMIT") to 4094
 ;  - ref VA SME RdM & Release Notes 2.3.4
 ;
 S ^DD("STRING_LIMIT")=4094
 ;
 ; Initiate DI SCREENMAN NO MOUSE - disabled
 ; - ref Release Note 1.1.1
 ;
 K ERR D ADD^XPAR("SYS","DI SCREENMAN NO MOUSE",,1,.ERR) I ERR'=0 D CHG^XPAR("SYS","DI SCREENMAN NO MOUSE",,1,.ERR)
 ;
 ;
 ; Initiate ^DD("DD")
 ;  - Ensure that default is 5U
 ;
 S ^DD("DD")="S Y=$$FMTE^DILIBF(Y,""5U"")"
 ;
 ;
 D CLEAN^DILF
 Q
DISP ;DISPLAY ROUTINE TEXT
 D MES^XPDUTL($T(@("+1^"_RTN)))
 D MES^XPDUTL($T(@("+2^"_RTN)))
 D MES^XPDUTL(" ")
 Q
