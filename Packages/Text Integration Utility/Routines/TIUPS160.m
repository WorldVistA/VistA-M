TIUPS160 ;SLC/AJB - Post install to Register New RPCs ; 05/29/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**160**;Jun 20, 1997
 ;
 Q
REG ; Register RPCs
 N TIUMENU,TIURPC
 S TIUMENU="OR CPRS GUI CHART"
 F TIURPC="TIU HAS AUTHOR SIGNED?","TIU ONE VISIT NOTE?","TIU USER INACTIVE?" D INSERT(TIUMENU,TIURPC)
 Q
INSERT(OPTION,RPC) ; Call FM Updater with each RPC
 ; Input  -- OPTION   Option file (#19) Name field (#.01)
 ;           RPC      RPC sub-file (#19.05) RPC field (#.01)
 ; Output -- None
 N FDA,FDAIEN,ERR,DIERR
 S FDA(19,"?1,",.01)=OPTION
 S FDA(19.05,"?+2,?1,",.01)=RPC
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q
