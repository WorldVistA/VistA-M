SCMCUT ;ALB/JLU;General utility routine;8/17/99@1515
 ;;5.3;Scheduling;**177,205,204**;AUG 13, 1993
 ;
 ;This is a general utility routine for the PCMM application.  Any
 ;general purpose utility should be placed in this routine.
 ;
 ;
CLNLST(SER,ARY,ACT) ;
 ;This API is a function that returns the list of clients that
 ;can run with the server that is passed in.
 ;
 ;INPUTs:  SER --- This is the server to check for.  It needs to be in
 ;                 a patch format Ex. SD*5.3*177
 ;         ARY --- This is the array root the list will be returned in.
 ;                 If nothing is passed in a default will be used.  This
 ;                 array must be clean before it is passed to this API.
 ;                 No kills will be issued.
 ;                 Ex. ^TMP("PCMM CLIENT LIST",$J,"1.2.0.0")=effective dt
 ;                     ^TMP("PCMM CLIENT LIST",$J,"1.3.0.0")=effective dt
 ;         ACT --- This variable indicates whether to:
 ;                 1 - return only active clients (default)
 ;                 0 - return all clients
 ;
 ;OUTPUTS --- The output of this function call is the data in the array
 ;            variable but also the function itself.  It will either be
 ;            1 for a success or -1 with an error message.
 ;            Ex. "-1^not a valid server name"
 ;                "1"
 ;
 N RESULTS
 ;
 ;checking input parameters
 S SER=$G(SER)
 I SER']"" S RESULTS="-1^Server variable not defined." G CLNLSTQ
 S ARY=$G(ARY)
 I ARY']"" S ARY=$NA(^TMP("PCMM CLIENT LIST",$J))
 S ACT=$G(ACT,1)
 ;
 ;checking existance of server in PCMM SERVER PATCH file.
 I '$D(^SCTM(404.45,"B",SER)) S RESULTS="-1^This server is not in the PCMM SERVER PATCH file." G CLNLSTQ
 ;
 ;if ACT, checking if server is active
 I ACT,'$$ACTSER(SER) S RESULTS="-1^This server is not active." G CLNLSTQ
 ;
 ;loop through the server patches and build the list of clients.
 N CLT,SERIEN
 S CLT="",RESULTS="-1^No clients found for this Server."
 ;
 F  S CLT=$O(^SCTM(404.45,"ASER",SER,CLT)) Q:CLT=""  S SERIEN=$O(^SCTM(404.45,"ASER",SER,CLT,"")) Q:SERIEN=""  DO
 .N NOD5,NOD6
 .S NOD5=$G(^SCTM(404.45,SERIEN,0))
 .Q:NOD5=""
 .S NOD6=$G(^SCTM(404.46,$P(NOD5,U,2),0))
 .Q:NOD6=""
 .I ACT,$P(NOD6,U,2),$D(^SCTM(404.45,"ACT",SER,SERIEN)) S @ARY@($P(NOD6,U,1))=$P(NOD6,U,2,3),RESULTS=1
 .I 'ACT S @ARY@($P(NOD6,U,1))=$P(NOD6,U,2,3),RESULTS=1
 .Q
 ;
CLNLSTQ Q RESULTS
 ;
 ;
ACTCLT(CLT) ;Is this client active?
 ;This function call returns whether the client passed in is active or
 ;not .  It just tells the status of the client per its entry in PCMM 
 ;CLIENT PATCH file.  It does not relate in anyway to the PCMM SERVER
 ;PATCH file.
 ;
 ;INPUT:  CLT - This is the External Client version number
 ;
 ;OUTPUT: 1 - ACTIVE
 ;        0 - NOT ACTIVE
 ;       -1^ERROR DESCRIPTION
 ;
 N RESULTS
 S CLT=$G(CLT)
 I CLT']"" S RESULTS="-1^Client variable not defined." G ACTCLTQ
 ;
 N CLTIEN,ACT
 S CLTIEN=$O(^SCTM(404.46,"B",CLT,0))
 I CLTIEN="" S RESULTS="-1^Client not defined in PCMM CLIENT PATCH file." G ACTCLTQ
 S ACT=$P(^SCTM(404.46,CLTIEN,0),U,2)
 S RESULTS=$S(ACT:ACT,1:0) ;This was done so that a null would be zero
 ;
ACTCLTQ Q RESULTS
 ;
 ;
ACTSER(SER,ARY) ; 
 ; This function call is used to return the status of a server
 ;  or a list of active servers at the sight.
 ;  It does not return the IENs or multiples of 
 ;  the same server value.
 ;
 ;INPUTS  SER - [optional]: Test for a specific server version
 ;        ARY - [optional]: This is the array root that the list
 ;               is to be stored in, if SER is undefined.
 ;              If nothing is passed then the default will be used.
 ;              ^TMP("PCMM ACTIVE SERVERS",$J,SERVER NUMBER)=EFFECTIVE DT
 ;
 ;OUTPUTS 1 - a success
 ;        0 - none found.
 ;
 N RESULTS,LP,IEN
 S SER=$G(SER,"")
 I SER]"" S RESULTS=$D(^SCTM(404.45,"ACT",SER))>0 G ACTSERQ
 S ARY=$G(ARY,"^TMP(""PCMM ACTIVE SERVERS"",$J)")
 S RESULTS=0,LP=""
 ;
 I $O(^SCTM(404.45,"ACT",""))']"" G ACTSERQ
 ;
 F  S LP=$O(^SCTM(404.45,"ACT",LP)) Q:LP=""  S IEN=$O(^SCTM(404.45,"ACT",LP,"")) Q:IEN=""  DO
 .S IEN=$G(^SCTM(404.45,IEN,0))
 .Q:IEN=""
 .S @ARY@(LP)=$P(IEN,U,3)
 .S RESULTS=1
 .Q
 I SER]"" S RESULTS=$D(@ARY@(SER))
 ; 
ACTSERQ Q RESULTS
 ;
 ;
DISCLNTS() ;This function call is used to determine if all clients should
 ;be disabled.
 ;
 ;INPUTS  -- NONE
 ;OUTPUTS -- 1 means YES disable all clients
 ;           0 means NO
 ;
 N IEN,RESULTS
 S RESULTS=0
 ;
 S IEN=+$O(^SCTM(404.44,0))
 I 'IEN G DISQ
 S IEN=$G(^SCTM(404.44,IEN,1))
 S RESULTS=$S('$P(IEN,U,2):0,1:1)
 ;
DISQ Q RESULTS
 ;
UPCLNLST(SCX) ;update 404.46/404.45 with new client/server pair (if enabled)
 ; input  := SCX p1[required] : ServerPatch
 ;               p2[required] : ^ClientVersion
 ;               p3[optional] : ^EnabledOverride(1=bypass,0=no[default])
 ;               p4[optional] : ^ActiveServer(1=yes[default],0=no)
 ;               p5[optional] : ^ActiveClient(1=yes[default],0=no)
 ; output := SCRESULT : 1 = success
 ;                    : 0 = failure/not allowed
 ;
 N SCRESULT,SCSER,SCCLI,SCASER,SCACLI,SCBYPASS,SCIEN
 S SCRESULT=0
 ;
 ; parse
 S SCSER=$P(SCX,U)
 I SCSER']"" G UPCLNQ
 S SCCLI=$P(SCX,U,2)
 I SCCLI']"" G UPCLNQ
 S SCBYPASS=$P(SCX,U,3)
 S SCBYPASS=$S(SCBYPASS=1:1,1:0)
 S SCIEN=+$O(^SCTM(404.44,0))
 I 'SCIEN G UPCLNQ
 I 'SCBYPASS,$P($G(^SCTM(404.44,SCIEN,1)),U,3)=1 G UPCLNQ
 S SCASER=$P(SCX,U,4)
 S SCASER=$S(SCASER=0:0,1:1)
 S SCACLI=$P(SCX,U,5)
 S SCACLI=$S(SCACLI=0:0,1:1)
 ;
 ;update client file
 N SC1,SC1IEN,SC1ERR
 S SC1(1,404.46,"?+1,",.01)=SCCLI       ;client version
 S SC1(1,404.46,"?+1,",.02)=SCACLI      ;active?
 S SC1(1,404.46,"?+1,",.03)=DT          ;today
 D UPDATE^DIE("","SC1(1)","SC1IEN","SC1ERR")
 I $D(SC1ERR)!(+$G(SC1IEN(1))<0) G UPCLNQ
 ;
 ;update server file
 N SC2,SC2IEN,SC2ERR
 S SC2(1,404.45,"?+1,",.01)=SCSER       ;server version
 S SC2(1,404.45,"?+1,",.02)=SC1IEN(1)   ;ptr - client version
 S SC2(1,404.45,"?+1,",.03)=DT          ;today
 S SC2(1,404.45,"?+1,",.04)=SCASER      ;active?
 D UPDATE^DIE("","SC2(1)","SC2IEN","SC2ERR")
 I $D(SC2ERR)!(+$G(SC2IEN(1))<0) G UPCLNQ
 S SCRESULT=1
 ;
UPCLNQ Q SCRESULT
 ;
