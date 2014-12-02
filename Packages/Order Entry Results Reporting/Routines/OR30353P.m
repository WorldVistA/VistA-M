OR30353P ; alb/drp - postinit for OR*3*353 ;04/16/04  12:17
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**353**;Dec 17, 1997;Build 8
 ;
 Q
 ;
REG       ; Register new RPCs
 N RTN
 D EN^DDIOL("Registering new RPC's to OR CPRS GUI CHART Option")
 S RTN=$$INSERT("OR CPRS GUI CHART","ORWGN IDTVALID") D MSG(RTN)
 S RTN=$$INSERT("OR CPRS GUI CHART","ORWGN MAXFRQ") D MSG(RTN)
 Q
 ;
INSERT(OPTION,RPC)   ; Call FM Updater with each RPC
 ; Input  -- OPTION   Option file (#19) Name field (#.01)
 ;           RPC      RPC sub-file (#19.05) RPC field (#.01)
 ; Output -- None
 N FDA,FDAIEN,DIERR,ERR
 Q:'$D(^XWB(8994,"B",RPC)) 0_U_RPC ; Don't try to register if RPC not defined
 S FDA(19,"?1,",.01)=OPTION
 S FDA(19.05,"?+2,?1,",.01)=RPC
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q 1_U_RPC ; success
 ;
MSG(FLG) ; Write progress message
 D:+FLG EN^DDIOL($P(FLG,U,2)_" Registered to Option OR CPRS GUI CHART")
 D:'+FLG EN^DDIOL("RPC "_$P(FLG,U,2)_" DOES NOT EXIST Failed to Register to Option OR CPRS GUI CHART")
 Q
