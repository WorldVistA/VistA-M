XWB2HL7 ;ISF/RWF - Remote RPC via HL7 ;08/24/09  14:32
 ;;1.1;RPC BROKER;**12,18,20,22,27,32,39,54**;Mar 28, 1997;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ; EN1^XLWB2HL7 is the entry point used by the Broker.
 ;
 ; Patch XWB*1.1*27 modified the EN1^XWB2HL7 call point.  However,
 ; the code associated with the original pre-modification version
 ; of the EN1 call point still exists in the XWB2HL7C routine.
 ; Please note that when the original EN1 code was moved to XWB2HL7C
 ; it was renamed OLDEN1.
 ;
EN1(RET,LOC,RPC,RPCVER,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) ; Call a remote RPC
 ; with 1-10 parameters.
 ; (This reworked EN1 emtry point replaces the original EN1 entry point,
 ; which was renamed OLDEN1.)
 ;
 N I,INX,N,PMAX,RPCIEN,X,XWBDVER,XWBESSO,XWBHDL,XWBHL7,XWBMSG
 N XWBPAR,XWBPCNT,XWBSEC,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 ;
 D SETUP(1) I $G(RET(1))'="" QUIT  ;->
 ;
 ; Queue up request... (OLDEN1 used DIRECT call)
 S ZTSAVE("*")="",ZTRTN="DEQ^XWB2HL7C",ZTDTH=$H,ZTIO=""
 S ZTDESC="RPC Broker queued call from EN1~XWB2HL7"
 D ^%ZTLOAD
 ;
 ; What happened?
 I $G(ZTSK)'>0 S RET(0)="-1^Failed to task" QUIT  ;->
 S RET(0)=XWBHDL
 D SETNODE^XWBDRPC(XWBHDL,"TASK",ZTSK)
 ;
 Q
 ;
 ;This is the Direct HL7 call point
DIRECT(RET,LOC,RPC,RPCVER,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)  ;Call a remote RPC
 N X,I,INX,N,XWBHL7,XWBPAR,XWBPCNT,XWBDVER,XWBESSO,XWBHDL,PMAX
 N XWBMSG,XWBSEC,RPCIEN
 ;Protect caller from HL7
 N HLMTIEN,HLDOM,HLECH,HLFS,HLINSTN,HLNEXT,HLNODE,HLPARAM,HLQ,HLQUIT
 D SETUP(1) I $G(RET(1))'="" Q
 ;(procedurename, query tag, error return, destination, Parameter array)
 D DIRECT^XWB2HL7A("ZREMOTE RPC",XWBHDL,.XWBMSG,LOC,.XWBPAR)
 I $P(XWBMSG,U,2) S RET(0)="-1^"_$P(XWBMSG,"^",3) Q
 I 'HLMTIEN S RET(0)="-1^No Message returned" Q
 D RETURN,RTNDATA^XWBDRPC(.RET,XWBHDL)
 Q
 ;
SETUP(XWBDIR) ;Check/setup for HL7 call
 S RET="",(XWBPAR,RPCIEN)="",XWBPCNT=0,XWBDVER=1,RPCVER=$G(RPCVER),PMAX=10
 ;Check that user can access remote system with ESSO
 S XWBESSO=$$GET^XUESSO1 I +XWBESSO<0 S RET(0)="",RET(1)=XWBESSO Q
 ;Check that the link is setup.
 I 'XWBDIR,'$$STAT^HLCSLM S RET(0)="",RET(1)="-1^Link Manager not running" Q
 I '$$CHKLL^HLUTIL(LOC) S RET(0)="",RET(1)="-1^Link not setup" Q
 ;Find local RPC here
 S RPCIEN=$$RPCIEN^XWBLIB(RPC) I RPCIEN'>0 S RET(0)="",RET(1)="-1^No Local RPC" Q
 F I=1:1:PMAX Q:'$D(@("P"_I))  S XWBPCNT=I
 ;Get any security info.
 S XWBSEC=3.14
 ;Do parameter conversion
 ;F IX=1:1:XWBPCNT I $G(^XWB(8994,RPCIEN,2,IX,2))]"" S N="P"_IX,X=@N,@(N_"=^(2)")
 ;Build value to send
 K XWBPAR S INX=1
 F N="RPC","RPCVER","XWBPCNT","XWBESSO","XWBDVER","XWBSEC" D
 . S XWBPAR(INX)=$$V2S(N)_$$V2S(@N),INX=INX+1
 ;Load parameters into a string
 F I=1:1:PMAX S N="P"_I Q:'$D(@N)  S X=$$LD(N),XWBPAR(INX)=X,INX=INX+1
 ;Build a handle to link request with return.
 S XWBHDL=$$HANDLE^XWBDRPC(),XWBMSG="" D ADDHDL^XWBDRPC(XWBHDL)
 Q
 ;
LD(%V) ;Convert a var name into a transport string. Grabs from symbol table
 N %1,%2,%3,%4
 I $D(@%V)=1 Q $$V2S(%V)_$$V2S(@%V)
 S %1=$S($D(@%V)#2:$$V2S(N)_$$V2S(@N),1:"")
 F  S %V=$Q(@%V) Q:%V=""  S %3=$$V2S(%V),%4=$$V2S(@%V) S:$L(%1)+$L(%3)+$L(%4)>245 XWBPAR(INX)=%1,INX=INX+1,%1="" S %1=%1_%3_%4
 Q %1
V2S(V) ;Convert a value into L_value string
 Q $E(1000+$L(V),2,4)_V
 ;
S2V(S) ;Convert a string L_value into a value
 N D,L S L=+$E(S,1,3),D=""
 S:L D=$E(S,4,3+L) S S=$E(S,4+L,999)
 Q D
 ;
UD(%1) ;Unload strings into variables. Builds symbol table
 N %
 F  Q:%1=""  S %=$$S2V(.%1),@%=$$S2V(.%1)
 Q
 ;
 ;This is called by HL7 to process a RPC on the remote system.
 ;Call parameters
 ; 1. return the $NAME for the data
 ; 2. query tag
 ; 3. remote procedure name
 ; 4. parameter array
REMOTE(XWBY,XWBQT,XWBSPN,XWBPAR) ;Entry point on Remote system
 ;XWBY is the return data
 ;DUZ is NEWed to protect HL7
 N %,I,X,Y,ERR,RPC,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,XWBPCNT,XWBDVER,XWBRPC
 N RPC,RPCVER,XWBESSO,DUZ,$ESTACK,$ETRAP
 N XWBA1,XWBA2,XWBA3,XWBA4,XWBA5,XWBA6,XWBA7,XWBA8,XWBA9,XWBA10
 ;Set local error trap
 S $ETRAP="D ETRAP^XWB2HL7"
 ;See that leftover data in XUTL won't cause problems with %ZIS & HOME
 K ^XUTL("XQ",$J,"IO")
 ;Expand parameters into values
 F I=1:1 Q:'$D(XWBPAR(I))  D UD(XWBPAR(I)_$G(XWBPAR(I,1))) ;p54
 I '$D(RPC) S XWBY(0)="-1^Bad Message" G REX ;Bad msg
 S XWBRPC=0,XWBRPC=$$RPCGET(RPC,.XWBRPC) I XWBRPC'>0 S XWBY(0)="-1^RPC name not found" G REX
 I '$$RPCAVAIL^XWBLIB(XWBRPC,"R",RPCVER) S XWBY(0)="-1^RPC Access Blocked/Wrong Version at Remote Site" G REX
 ;Check any security info.
 ;I $D(XWBSEC),XWBSEC'=3.14 S XWBY(0)="-1^Invalid security" G REX
 ;Check and Setup the user
 D  I $G(XWBY(0))<0 G REX
 . I XWBRPC("USER")=1 S DUZ=.5,DUZ(0)="" Q
 . I '$$PUT^XUESSO1(XWBESSO) S XWBY(0)="-1^Bad User"
 ;Enter in Sign-on log
 D GETENV^%ZOSV S XWBSTATE("SLOG")=$$SLOG^XUS1($P(Y,U,2),,"",$P(Y,U),$P(Y,U,3),$P(XWBESSO,U,3),$P(XWBESSO,U,5))
 ;Do parameter conversion
 ;F IX=1:1:XWBPCNT I $G(^XWB(8994,XWBRPC,2,IX,3))]"" S N="P"_IX,X=@N,@(N_"=^(3)")
 S PAR=$$PARAM
 ;Save HL7 device
 I $L($G(IO)) S IO(1,IO)="",IO(0)=IO D SAVDEV^%ZISUTL("HL7HOME")
 ;Result returned in XWBY
 D CAPI(XWBRPC("RTAG"),XWBRPC("RNAM"),PAR)
 ;Restore HL7 Device
 D USE^%ZISUTL("HL7HOME"),RMDEV^%ZISUTL("HL7HOME")
REX ;Exit from remote.
 ;What to do to data in XWBY for HL7 return.
 K ^TMP("XWBR",$J)
 I '$D(XWBY) S XWBY(0)="-1^Application failed to return any data"
 I $D(XWBY)>9 D
 . M ^TMP("XWBR",$J)=XWBY K XWBY S XWBY=$NA(^TMP("XWBR",$J))
 I $D(XWBY)=1,$E(XWBY)'="^" D
 . S ^TMP("XWBR",$J,0)=XWBY K XWBY S XWBY=$NA(^TMP("XWBR",$J))
 ;If XWBY is a $NA value just return it.
 I $D(XWBSTATE("SLOG")) D LOUT^XUSCLEAN(XWBSTATE("SLOG"))
 Q
 ;
CAPI(TAG,NAM,PAR) ;make API call
 ;DUZ was setup in Remote
 N HL,HLA,HLERR,HLL,HLMTIENS,IO,R,$ES,$ET ;p39
 S $ET="D CAPIER^XWB2HL7"
 S R=TAG_"^"_NAM_"(.XWBY"_$S(PAR="":")",1:","_PAR_")")
 ;Ready to call RPC?  Setup the Null device
 S IOP="NULL",%ZIS="H0N" D ^%ZIS
 D @R
 ;Close the NULL device
 S IO("C")=1 D ^%ZISC
 ;Return data is in XWBY.
 Q
 ;
CAPIER ;Handle a error in called RPC
 S XWBY(0)="-1^Remote Error: "_$E($$EC^%ZOSV,1,200) ;Grab the error first
 D ^%ZTER ;record
 S IO("C")=1 D ^%ZISC ;Close the NULL device
 D UNWIND^%ZTER ;Unwind stack and return to HL7
 Q
 ;
RETURN ;This tag is called by HL7 when the data returns from the remote system
 ;Need to get the MSG id that we added so we know where to place the
 ;results. Set in XWB RPC SERVER SEND protocol.
 N $ES,$ETRAP S $ETRAP="D ^%ZTER D UNWIND^%ZTER"
 N XWBHDL,XWB1,XWB2,I,J,X
 Q:'$D(HLNEXT)
 ;Now to find the MSA line
 F I=1:1 X HLNEXT Q:HLQUIT'>0  S X(I)=HLNODE Q:"MSA"=$E(HLNODE,1,3)
 I HLNODE'["MSA" Q  ;Something wrong
 I $P(HLNODE,U,2)'="AA" G REJECT
 ;Now to find the QAK line
 F I=I+1:1 X HLNEXT Q:HLQUIT'>0  S X(I)=HLNODE Q:"QAK"=$E(HLNODE,1,3)
 I HLNODE'["QAK" Q  ;Something wrong
 ;Get the handle
 S XWBHDL=$P(HLNODE,"^",2)
 Q:$$CHKHDL^XWBDRPC(XWBHDL)["-1"  ;XTMP missing
 ;Now to place the data
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D:$E(HLNODE,1,3)="RDT"
 . S X=$E(HLNODE,5,999),J=0 F  S J=$O(HLNODE(J)) Q:'J  S X=X_HLNODE(J)
 . D PLACE(XWBHDL,X)
 . Q
 ;
 S X=$$HDLSTA^XWBDRPC(XWBHDL,"1^Done")
 Q
 ;
REJECT ;Handle some kind of reject on remote system
 N HDL,MID,MSG,X
 S HDL="XWBDRPC",MID=$P(HLNODE,U,3),MSG="-1^"_$P(HLNODE,U,4) ;Save reason
 F  S HDL=$O(^XTMP(HDL)),X="" Q:HDL'["XWBDRPC"  S X=$$GETNODE^XWBDRPC(HDL,"MSGID") Q:X=MID
 Q:X=""  ;Didn't find Handle
 S X=$$HDLSTA^XWBDRPC(HDL,MSG)
 Q
 ;
PLACE(HL,DATA) ;Called by HL7 to place each line of data.
 N IX
 S IX=+$G(^XTMP(HL,"CNT")),^XTMP(HL,"D",IX)=DATA,^XTMP(HL,"CNT")=IX+1 ;p32
 Q
 ;
RPCGET(N,R) ;Convert RPC name to IEN and parameters.
 N T,T0
 S T=$G(N) Q:T="" "-1^No RPC name"
 S T=$$RPCIEN^XWBLIB(T) Q:T'>0 "-1^Bad RPC name"
 Q:'$D(R) T
 S T0=$G(^XWB(8994,T,0)),R("IEN")=T,R("NAME")=$P(T0,"^")
 S R("RTAG")=$P(T0,"^",2),R("RNAM")=$P(T0,"^",3)
 S R("XWBPTYPE")=$P(T0,"^",4),R("XWBWRAP")=$P(T0,"^",8),R("USER")=$P(T0,"^",10)
 ;S XWBPCNT=0 F I=0:0 S I=$O(^XWB(8994,T,1,I)) Q:I'>0  S XWBPCNT=XWBPCNT+1
 Q T
PARAM() ;Build remote parameter list
 N I,%,X,A S X=""
 F I=1:1:XWBPCNT S %="P"_I,A="XWBA"_I Q:'$D(@%)  K @A D
 . I $D(@%)=1 S X=X_%_"," Q
 . S X=X_"."_A_"," M @A=@% Q
 Q $E(X,1,$L(X)-1)
 ;
 ;
RPCCHK(RET,HDL) ;RPC call to check a handle status
 N S,M,Z
 I $G(HDL)="" S RET(0)="-1^Bad Handle" Q
 S RET(0)=$$CHKHDL^XWBDRPC(HDL),S=$$GETNODE(HDL,"MSGID")
 I RET(0)'["Done",$L(S) D  S $P(RET(1),"^",3)=Z
 . S RET(1)=$$MSGSTAT^HLUTIL(S),M=+RET(1),Z=""
 . I M=1 S Z=$S($P(RET(1),"^",5)>1:"NOT first in queue",1:"First in queue")
 . I M=1.5 S Z="Opening connection"_$S($P(RET(1),"^",6):", open failed "_$P(RET(1),"^",6)_" times.",1:"")
 . I M=1.7 S Z="Sent, awaiting responce"
 . I M=2 S Z="Awaiting application ACK"
 Q
 ;
GETNODE(%1,%2) ;Pass to XWBDRPC
 Q $$GETNODE^XWBDRPC(%1,%2)
 ;
ETRAP ;Handle errors in the RPC at the remote site.
 K ^TMP("XWBR",$J),XWBY
 S ^TMP("XWBR",$J,0)="-1^Trapped Error at remote site.  "_$$EC^%ZOSV,XWBY=$NA(^TMP("XWBR",$J))
 S XWBY=$NA(^TMP("XWBR",$J)) ;Setup the return data.
 ;Record the error, and exit to caller
 D ^%ZTER,UNWIND^%ZTER
 Q
