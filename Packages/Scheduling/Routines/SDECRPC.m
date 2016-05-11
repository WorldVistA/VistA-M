SDECRPC ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ;=================================================================
 ;
 ; Register/unregister RPCs within a given namespace to a context
REGNMSP(NMSP,CTX,DEL) ;EP
 N RPC,IEN,LEN
 S LEN=$L(NMSP),CTX=+$$GETOPT(CTX)
 I $G(DEL) D
 .S IEN=0
 .F  S IEN=$O(^DIC(19,CTX,"RPC","B",IEN)) Q:'IEN  D
 ..I $E($G(^XWB(8994,IEN,0)),1,LEN)=NMSP,$$REGRPC(IEN,CTX,1)
 E  D
 .Q:LEN<2
 .S RPC=NMSP
 .F  D:$L(RPC)  S RPC=$O(^XWB(8994,"B",RPC)) Q:NMSP'=$E(RPC,1,LEN)
 ..F IEN=0:0 S IEN=$O(^XWB(8994,"B",RPC,IEN)) Q:'IEN  I $$REGRPC(IEN,.CTX)
 Q
 ; Register/unregister an RPC to/from a context
 ; RPC = IEN or name of RPC
 ; CTX = IEN or name of context
 ; DEL = If nonzero, the RPC is unregistered (defaults to 0)
 ; Returns -1 if already registered; 0 if failed; 1 if succeeded
REGRPC(RPC,CTX,DEL) ;EP
 S RPC=+$$GETRPC(RPC)
 Q $S(RPC<1:0,1:$$REGMULT(19.05,"RPC",RPC,.CTX,.DEL))
 ; Add/remove a context to/from the ITEM multiple of another context.
REGCTX(SRC,DST,DEL) ;EP
 S SRC=+$$GETOPT(SRC)
 Q $S('SRC:0,1:$$REGMULT(19.01,10,SRC,.DST,.DEL))
 ; Add/delete an entry to/from a specified OPTION multiple.
 ; SFN = Subfile #
 ; NOD = Subnode for multiple
 ; ITM = Item IEN to add
 ; CTX = Option to add to
 ; DEL = Delete flag (optional)
REGMULT(SFN,NOD,ITM,CTX,DEL) ;
 N FDA,IEN
 S CTX=+$$GETOPT(CTX)
 S DEL=+$G(DEL)
 S IEN=+$O(^DIC(19,CTX,NOD,"B",ITM,0))
 Q:'IEN=DEL -1
 K ^TMP("DIERR",$J)
 I DEL S FDA(SFN,IEN_","_CTX_",",.01)="@"
 E  S FDA(SFN,"+1,"_CTX_",",.01)=ITM
 D UPDATE^DIE("","FDA")
 S FDA='$D(^TMP("DIERR",$J)) K ^($J)
 Q FDA
 ; Register a protocol to an extended action protocol
 ; Input: P-Parent protocol
 ;        C-Child protocol
REGPROT(P,C,ERR) ;EP
 N IENARY,PIEN,AIEN,FDA
 D
 .I '$L(P)!('$L(C)) S ERR="Missing input parameter" Q
 .S IENARY(1)=$$FIND1^DIC(101,"","",P)
 .S AIEN=$$FIND1^DIC(101,"","",C)
 .I 'IENARY(1)!'AIEN S ERR="Unknown protocol name" Q
 .S FDA(101.01,"?+2,"_IENARY(1)_",",.01)=AIEN
 .D UPDATE^DIE("S","FDA","IENARY","ERR")
 Q:$Q $G(ERR)=""
 Q
 ; Remove nonexistent RPCs from context
CLNRPC(CTX) ;EP
 N IEN
 S CTX=+$$GETOPT(CTX)
 F IEN=0:0 S IEN=$O(^DIC(19,CTX,"RPC","B",IEN)) Q:'IEN  D:'$D(^XWB(8994,IEN)) REGRPC(IEN,CTX,1)
 Q
 ; Return IEN of option
GETOPT(X) ;EP
 N Y
 Q:X=+X X
 S Y=$$FIND1^DIC(19,"","X",X)
 W:'Y "Cannot find option "_X,!!
 Q Y
 ; Return IEN of RPC
GETRPC(X) ;EP
 N Y
 Q:X=+X X
 S Y=$$FIND1^DIC(8994,"","X",X)
 W:'Y "Cannot find RPC "_X,!!
 Q Y
