XQCS ;SEA/Luke - Client/Server Utilities ;01/07/2003  13:53
 ;;8.0;KERNEL;**15,28,82,116,115,177,188,157,253**;Jul 10, 1995
 ;
CHK(XQUSR,XQOPT,XQRPC) ;Check to see if this user can run this RPC from
 ;this option.  Called by XWBSEC and XUSRB.
 ;
 ;Input: XQUSR-DUZ of user
 ;       XQOPT - name or IEN of the option
 ;       XQRPC - name or IEN of the remote procedure.  If this
 ;               variable is null no check is made to see if a
 ;               procedure is allowed.  That is, we only look
 ;               to see if the option is there and  if the user
 ;               has been assigned access to it.
 ;
 ;Output: XQMES - returned as 1 if the user is allowed to use this
 ;        option (and RPC is valid if XQRPC input variable is not
 ;        null), or as a message string explaining why the option
 ;        or RPC is not allowed.
 ;
 ;Rules: If M code exsists in ^DIC(19,option#,"RPC",rpc#,1) the
 ;       RULES field for a corresponding RPC, the software sets
 ;       the flag XQRPCOK to 1 and executes the field's code.
 ;       If the flag is returned as less than 1, the request for
 ;       use of that RPC is denied.  Rules are written by the
 ;       package developer and are not required.
 ;
 ;
 N %,X,XQCY0,XQDIC,XQKEY,XQRPCOK,XQPM,XQSM,XQSMY,XQYSAV
 ;
 S XQMES=1
 D OPT I 'XQMES Q XQMES
 I ($G(XQY0)'="XUS SIGNON")&(XQUSR>0) D USER I 'XQMES Q XQMES
 S %=$G(XQRPC) I %]"" S XQRPC=% D RPC I 'XQMES Q XQMES
 Q XQMES
 ;
 ;
OPT ;See if the option is there and is a broker type option
 I XQOPT'=+XQOPT S XQOPT=$O(^DIC(19,"B",XQOPT,0))
 I XQOPT'>0 S XQMES="No such option in the ""B"" cross reference of the Option File." Q
 I $G(MODE)="CHECK" D OPT1 Q
 I '$D(^TMP("XQCS",$J)) S XQOPT=$$OPTLK($P(^DIC(19,XQOPT,0),U))
 Q
OPT1 ;
 I XQOPT'=+XQOPT S XQOPT=$O(^DIC(19,"B",XQOPT,0)) I XQOPT'>0 S XQMES="No such option in the ""B"" cross reference of the Option File." Q
 I '$D(^DIC(19,XQOPT,0)) S XQMES="No such option in the Option File."  Q
 ;I $P(^DIC(19,XQOPT,0),U,4)'="B" S XQMES="This option is not a Client/Server-type option."  Q
 ;
 ;Check for Out-Of-Order, etc.  Patch XU*8*38 7/16/96
 ;
 S XQCY0=^DIC(19,XQOPT,0) ;W XQCY0
 I $L($P(XQCY0,U,3)) S XQMES="Option out of order with message: "_$P(XQCY0,U,3)_"."  Q
 I $L($P(XQCY0,U,6)) S %=$P(XQCY0,U,6) I '$D(^XUSEC(%,DUZ)) S XQMES="Option locked, "_$P(^VA(200,DUZ,0),U)_" does not hold the key."  Q
 I $L($P(XQCY0,U,16)) I $D(^DIC(19,XQOPT,3)),^(3)]"" S %=^(3) I $D(^XUSEC(%,DUZ)) S XQMES="Reverse lock, "_$P(^VA(200,DUZ,0),U)_" holds the key."  Q
 I $L($P(XQCY0,U,9)) S XQZ=$P(XQCY0,U,9) D ^XQDATE S (XX,X)=% D XQO^XQ92 I X=""!(XX'=X) S XQMES="This option is time restricted."  Q
 I $D(^DIC(19,+XQOPT,3.91)),$P(^(3.91,0),U,4)>1 S:$D(XQY) XQYSAV=XQY D ^XQDATE S X=%,XQY=+XQOPT D ^XQ92 S:$D(XQYSAV) XQY=XQYSAV I X="" S XQMES="This option is time restricted."  Q
 ;End patch 38
 Q
 ;
OPTLK(V) ;Lookup a Option in the file, Return it's IEN
 N XQOPT S XQOPT=$O(^DIC(19,"B",V,0)) I XQOPT'>0 Q ""
 I '$D(XQMES) N XQMES S XQMES=1
 N XQCS,XQCSO S XQCS(XQOPT)="" N XQOPT K ^TMP("XQCS",$J)
 F  S XQOPT=$O(XQCS("")) Q:XQOPT=""  K XQCS(XQOPT) I '$D(XQCSO(XQOPT)) D OPT1 D:XQMES  I 'XQMES Q
 . N I,J F I=0:0 S I=$O(^DIC(19,XQOPT,"RPC",I)) Q:I'>0  K J S J=^(I,0) S:$D(^(1)) J(1)=^(1) I '$D(^TMP("XQCS",$J,+J)) S ^TMP("XQCS",$J,+J,0)=J I $D(J(1)) S ^(1)=J(1)
 . F I=0:0 S I=$O(^DIC(19,XQOPT,10,I)) Q:I'>0  S J=+^(I,0) I $P(^DIC(19,J,0),U,4)="B" S XQCS(J)=""
 . S XQCSO(XQOPT)=""
 . Q
 Q $O(^DIC(19,"B",V,0))
 ;
RPC ;See if rpc exsists, is registered, is locked, etc.
 ; I '$D(^DIC(19,XQOPT,"RPC",0)) S XQMES="No RPC subfile defined for the option "_$P(^DIC(19,XQOPT,0),U)_"." Q
 ; I $P(^DIC(19,XQOPT,"RPC",0),U,4)<1 S XQMES="No remote procedure calls registered for the option "_$P(^DIC(19,XQOPT,0),U)_"." Q
 I XQRPC'=+XQRPC S XQRPC=$O(^XWB(8994,"B",XQRPC,0)) I XQRPC'>0 S XQMES="No RPC by that name in the ""B"" cross-reference of the Remote Procedure File." Q
 I '$D(^XWB(8994,XQRPC,0)) S XQMES="No such procedure in the Remote Procedure File." Q
 ; I '$D(^DIC(19,XQOPT,"RPC","B",XQRPC)) S XQMES="The remote procedure "_$P(^XWB(8994,XQRPC,0),U)_" is not registered to the option "_$P(^DIC(19,XQOPT,0),U)_"." Q
 I '$D(^TMP("XQCS",$J,XQRPC)) S XQMES="The remote procedure "_$P(^XWB(8994,XQRPC,0),U)_" is not registered to the option "_$P(^DIC(19,XQOPT,0),U)_"." Q
 ; S %=$O(^DIC(19,XQOPT,"RPC","B",XQRPC,0)),XQKEY=$P(^DIC(19,XQOPT,"RPC",%,0),U,2)
 S XQKEY=$P(^TMP("XQCS",$J,XQRPC,0),U,2)
 I $L(XQKEY) I '$D(^XUSEC(XQKEY,XQUSR)) S XQMES="Remote procedure is locked." Q
 ;
RULES ;Check the rules for this RPC
 ;S %=$O(^DIC(19,XQOPT,"RPC","B",XQRPC,0))
 ;I $D(^DIC(19,XQOPT,"RPC",%,1)),$L(^(1)) D
 I $D(^TMP("XQCS",$J,XQRPC,1)),$L(^(1)) D
 . S XQRPCOK=1
 . X ^TMP("XQCS",$J,XQRPC,1)
 . I XQRPCOK<1 S XQMES="Remote procedure request failed rules test."
 . Q
 Q
 ;
 ;
 ;
USER ;See if XQUSR has been assigned access this option or not
 ;
 N XQYES
 S XQMES=1,(XQSMY,%,XQYES)=0
 ;
TOP ;See if XQOPT is on top level of a tree: primary, secondary, or common
 S XQPM=+$G(^VA(200,XQUSR,201)) I XQOPT=XQPM Q
 ;
 ;Check the Common Options (XUCOMMAND)
 I $D(^DIC(19,"B","XUCOMMAND")) D
 . N XQCOM
 . S XQCOM=$O(^DIC(19,"B","XUCOMMAND",0))
 . I $D(^DIC(19,XQCOM,10,"B",XQOPT)) S XQYES=1
 . I XQYES Q
 . I '$D(^XUTL("XQO","PXU",0)) S %=$$BUILD("PXU")
 . I $D(^XUTL("XQO","PXU","^",XQOPT)) S XQYES=1
 . Q
 I XQYES Q
 ;
 ;
 I $D(^VA(200,XQUSR,203,0)),$P(^(0),U,4)>0 S XQSMY=1 D
 . S XQDIC="U"_XQUSR I $S('$D(^XUTL("XQO",XQDIC,0)):1,'$D(^VA(200,XQUSR,203.1)):1,1:^VA(200,XQUSR,203.1)'=$P(^XUTL("XQO",XQDIC,0),U,2)) D ^XQSET
 . S (XQSM,%)=0
 . F  Q:%  S XQSM=$O(^XUTL("XQO",XQDIC,"^",XQSM)) Q:XQSM=""  I XQSM=XQOPT S XQYES=1 Q
 . Q
 I XQYES Q
 ;
DEEP ;See if it's under the top somewhere - start with primary tree
 I XQPM>0 D
 .S XQDIC="P"_XQPM
 .S XQYES=$S($D(^XUTL("XQO",XQDIC,"^",XQOPT)):1,$D(^DIC(19,"AXQ",XQDIC,"^",XQOPT)):1,1:0)
 .Q
 I XQYES Q
 ;
 ;Check secondary trees
 S (XQSM,%)=0
 I XQSMY F  Q:XQYES  S XQSM=$O(^XUTL("XQO","U"_XQUSR,"^",XQSM)) Q:XQSM=""  D
 .S XQDIC="P"_XQSM
 .S XQYES=$S($D(^XUTL("XQO",XQDIC,"^",XQOPT)):1,$D(^DIC(19,"AXQ",XQDIC,"^",XQOPT)):1,1:0)
 . Q
 I XQYES Q
 ;
 I $L(XQMES<5) S XQMES="User "_$P(^VA(200,XQUSR,0),U)_" does not have access to option "_$P(^DIC(19,XQOPT,0),U)
 Q
 ;
 ;End of main program
 ;
BUILD(XQDIC)   ;A missing ^XUTL node brings us here
 I $D(^DIC(19,"AXQ",XQDIC)) D
 .L +^DIC(19,"AXQ",XQDIC):5
 .I '$D(^XUTL("XQO",XQDIC)) M ^XUTL("XQO",XQDIC)=^DIC(19,"AXQ",XQDIC)
 .L -^DIC(19,"AXQ",XQDIC)
 .Q
 I $D(^XUTL("XQO",XQDIC,0)) Q 1
 ;
 ;If they are not even in ^DIC the make them from scratch
 I '$D(^DIC(19,"AXQ",XQDIC)) D
 .;D REACT^XQ84(DUZ)
 .S XQMES="Your menus are being rebuilt.  Please try again later."
 Q 0
