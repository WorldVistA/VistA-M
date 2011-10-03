ORY178 ; SLC/KCM/JLI ;2/19/03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**178**;Dec 17, 1997
POST ;
 N RPC
 N MENU
 S RPC="XUS GET TOKEN"
 S MENU="OR CPRS GUI CHART"
 D INSERT(MENU,RPC)
 Q
 ;
INSERT(OPTION,RPC) ; Call FM Updater with each RPC
 ; Input  -- OPTION   Option file (#19) Name field (#.01)
 ;           RPC      RPC sub-file (#19.05) RPC field (#.01)
 ; Output -- None
 N FDA,FDAIEN,ERR,DIERR
 S FDA(19,"?1,",.01)=OPTION
 S FDA(19.05,"?+2,?1,",.01)=RPC
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q
 ;
