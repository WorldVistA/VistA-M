TIUPS100 ; SLC/JER - Patch 100 Post-init ;29-NOV-2000 09:45:54
 ;;1.0;TEXT INTEGRATION UTILITIES;**100**;Jun 20, 1997
 ;
 ; With special gratitude to "Elvis" for his inspired use of
 ; UPDATE^DIE and the letter "I"...
 ;
RPCS ; Register TIU RPCs that support ID Notes
 ; TIU patch 100 registers these in its post-init
 N MENU,I
 S MENU="OR CPRS GUI CHART"
 F I="TIU ID ATTACH ENTRY","TIU ID CAN ATTACH","TIU ID CAN RECEIVE","TIU ID DETACH ENTRY" D INSERT(MENU,I)
 Q
 ;
INSERT(OPTION,RPC) ; Call FM Updater with each RPC
 N FDA,FDAIEN,ERR,DIERR
 S FDA(19,"?1,",.01)=OPTION
 S FDA(19.05,"?+2,?1,",.01)=RPC
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q
