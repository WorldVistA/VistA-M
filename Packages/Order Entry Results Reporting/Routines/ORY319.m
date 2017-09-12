ORY319 ;SLC/SLCOIFO-Pre and Post-init for patch OR*3*319 ; 9/15/09 8:02am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**319**;Dec 17, 1997;Build 13
 ;
POST ; post-init process
 N CPRSOPT,RPCIEN S CPRSOPT=$$CPRSOPT,RPCIEN=$$RPCIEN("ORVW FACLIST")
 I '+$D(CPRSOPT) D  Q
 .W "CPRS option not found",!
 .D NOTCOMP
 I '+$D(RPCIEN) D  Q
 .W "RPC not found",!
 .D NOTCOMP
 ;
 I +$$RPCNOPT(CPRSOPT,RPCIEN) D  Q
 .W "RPC already in option",!
 .D COMPLETE
 W "Inserting RPC in option",!
 I '$$INSERT(CPRSOPT,RPCIEN) D  Q
 .D NOTCOMP
 D COMPLETE
 Q
RPCNOPT(OPTIEN,RPCIEN) ;
 Q $O(^DIC(19,OPTIEN,"RPC","B",RPCIEN,0))
 ;
INSERT(OPTIEN,RPCIEN) ;
 N REC,ERR
 S REC(19.05,"+1,"_OPTIEN_",",.01)=RPCIEN
 D UPDATE^DIE("","REC","","ERR")
 I +$D(ERR) D  Q 0
 .W "=== ERROR ===",!
 .ZW ERR
 Q 1
 ;
CPRSOPT() ;Finds the IEN of the "OR CPRS GUI CHART" option
 N OPTNAME S OPTNAME="OR CPRS GUI CHART"
 W "Looking for '"_OPTNAME_"'..."
 N INDEX,ERR S INDEX=$$FIND1^DIC(19,"","X",OPTNAME,"B","","ERR")
 I +$D(ERR) D  Q 0
 .W "ERROR TRYING TO FIND OPTION",!
 .ZW ERR
 W "Found option",!
 Q INDEX
 ;
RPCIEN(RPCNAME) ; Returns the ICN of the given RPC name
 W "Looking for RPC '"_RPCNAME_"'..."
 N INDEX,ERR S INDEX=$$FIND1^DIC(8994,"","X",RPCNAME,"B","","ERR")
 I +$D(ERR) D  Q 0
 .W "ERROR TRYING TO FIND RPC '"_RPCNAME_"'",!
 .ZW ERR
 W "Found RPC",!
 Q INDEX
 ;
NOTCOMP ; Not Completed Message
 W "Post-install NOT COMPLETED!"
 Q
 ;
COMPLETE ; Completed Message
 W "Post-install COMPLETED normally"
 Q
 ;
