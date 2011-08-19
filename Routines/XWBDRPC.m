XWBDRPC ;ISF/RWF - Deferred RPCs, used by XWB2HL7 ;01/14/2003  09:27
 ;;1.1;RPC BROKER;**12,20,32**;Mar 28, 1997
 Q
 ;This is the entry point used by the Broker
EN1(RET,RPC,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) ;Call a deferred RPC with 1-7 parameters.
 N X,I,INX,N,XWBPAR,XWBPCNT,XWBDVER,XWBHDL
 N XWBMSG,ZTSAVE,ZTDTH,ZTIO,ZTRTN,ZTSK,ZTDESC
 S RET="",(XWBPAR,RPCIEN)="",XWBPCNT=0,XWBDVER=1
 ;Find RPC.
 S RPCIEN=$$RPCIEN^XWBLIB($P(RPC,"^")) I RPCIEN'>0 S RET(0)="",RET(1)="-1^RPC not found" Q
 ;Check if RPC is active
 I '$$RPCAVAIL^XWBLIB(RPCIEN,"L") S RET(0)="-1^RPC Access Blocked" Q
 ;Build a handle to link request with return.
 S XWBHDL=$$HANDLE()
 F I=1:1:10 Q:'$D(@("P"_I))  S XWBPCNT=I
 ;Build ZTSAVE
 F N="RPC","XWBHDL","XWBPCNT","P1","P2","P3","P4","P5","P6","P7","P8","P9","P10" Q:'$D(@N)  S ZTSAVE(N)="" S:$D(@N)>9 ZTSAVE(N_"(")=""
 S ZTDESC="Deferred RPC - "_RPC
 S ZTRTN="DQ^XWBDRPC",ZTIO="NULL",ZTDTH=(+$H_",10") ;run first
 ;Call Taskman
 D ^%ZTLOAD
 S RET(0)=XWBHDL
 I ZTSK>0 D SETNODE(XWBHDL,"TASKID",ZTSK)
 Q
 ;
 ;This is called by TaskMan to process a RPC.
DQ ;
 N $ES,$ET S $ET="D ERR^XWBDRPC"
 N %,%1,%2,IX,X,Y,ERR,PAR
 S IX=0,XWBAPVER=+$P(RPC,"^",2),RPC=$P(RPC,"^")
 S XWBRPC=0,XWBRPC=$$RPCGET(RPC,.XWBRPC) I XWBRPC'>0 S XWBY(0)="-1^RPC name not found" G REX
 S PAR=$$PARAM D SETNODE(XWBHDL,"WRAP",XWBRPC("WRAP"))
 S X=$$HDLSTA(XWBHDL,"0^Running") ;Tell user we started
 ;Result returned in XWBY
 D CAPI(XWBRPC("RTAG"),XWBRPC("RNAM"),PAR)
REX ;Exit from RPC
 ;Check to see if our handle is still good.
 I $$HDLSTA(XWBHDL,"0^LoadRestlts")<0 S XWBY(0)="-1^Abort" Q
 ;Move data into XTMP for application to pick up.
 I $D(XWBY)>9 D
 . S %1="XWBY"
 . F  S %1=$Q(@%1) Q:%1=""  D PLACE(XWBHDL,@%1)
 I $D(XWBY)=1,$E(XWBY)'="^" D PLACE(XWBHDL,XWBY)
 ;If XWBY is a $NA value just return it.
 I $D(XWBY)=1,$E(XWBY)="^" D
 . S %1=XWBY,%2=$E(XWBY,1,$L(XWBY)-1)
 . F  S %1=$Q(@%1) Q:%1'[%2  D PLACE(XWBHDL,@%1)
 S X=$$HDLSTA(XWBHDL,"1^Done")
 Q
 ;
CAPI(TAG,NAM,PAR) ;make API call
 N R
 S R=TAG_"^"_NAM_"(.XWBY"_$S(PAR="":")",1:","_PAR_")")
 ;Ready to call RPC?
 D @R
 ;Return data in XWBY
 Q
 ;
ERR ;Handle an error
 D ^%ZTER ;Record error
 I $D(XWBHDL) S X=$$HDLSTA(XWBHDL,"-1^Error: "_$E($$EC^%ZOSV,1,200))
 D UNWIND^%ZTER
 ;
RTNDATA(RET,HDL) ;Return the data under a handle
 N I,N,RD,WRAP S RET="" K ^TMP($J,"XWB")
 I $G(HDL)="" S RET(0)="-1^Bad Handle" Q
 S N=$$CHKHDL^XWBDRPC(HDL) I N<1 S RET(0)=N Q
 I N'["Done" S RET(0)="-1^Not DONE" Q
 ;Default is to return an array, switch to global if to big
 S N=(^XTMP(HDL,"CNT")>100)
 S I=0,RD=$S(N:$NA(^TMP($J,"XWB")),1:"RET")
 ;Move into a TMP global, Global is killed in XWBTCPC
 I N S RET=$NA(^TMP($J,"XWB")),I=$$RTRNFMT^XWBLIB(4) ;Make return a global
 I N M ^TMP($J,"XWB")=^XTMP(HDL,"D")
 I 'N F  S RET(I)=$G(^XTMP(HDL,"D",I)),I=$O(^XTMP(HDL,"D",I)) Q:I'>0
 Q
 ;
CLEAR(RET,HDL) ;Clear the data under a handle
 K ^XTMP(HDL),^TMP("XWBHDL",$J,HDL)
 S RET(0)=1
 Q
 ;
CLEARALL(RET) ;Clear ALL the data for this job.
 N X
 S X="" F  S X=$O(^TMP("XWBHDL",$J,X)) Q:X=""  D CLEAR(.RET,X)
 Q
 ;
RPCGET(N,R) ;Convert RPC name to IEN and parameters.
 N T,T0
 S T=$G(N) Q:T="" "-1^No RPC name"
 S T=$$RPCIEN^XWBLIB(T) Q:T'>0 "-1^Bad RPC name"
 Q:'$D(R) T
 S T0=$G(^XWB(8994,T,0)),R("IEN")=T,R("NAME")=$P(T0,"^")
 S R("RTAG")=$P(T0,"^",2),R("RNAM")=$P(T0,"^",3)
 S R("RTNTYPE")=$P(T0,"^",4),R("WRAP")=$P(T0,"^",8)
 Q T
 ;
PARAM() ;Build remote parameter list
 N I,%,X,A S X=""
 F I=1:1:XWBPCNT S %="P"_I,A="XWBA"_I Q:'$D(@%)  K @A D
 . I $D(@%)=1 S X=X_%_"," Q
 . S X=X_"."_A_"," M @A=@% Q
 Q $E(X,1,$L(X)-1)
 ;
ADDHDL(HL) ;Add a handle to local set
 S ^TMP("XWBHDL",$J,HL)=""
 Q
 ;
HANDLE() ;Return a unique handle into ^XTMP
 N %H,A,J,HL
 S %H=$H,J="XWBDRPC"_($J#2048)_"-"_(%H#7*86400+$P(%H,",",2))_"_",A=-1
HAN2 S A=A+1,HL=J_A L +^XTMP(HL):0 I '$T G HAN2
 I $D(^XTMP(HL)) L -^XTMP(HL) G HAN2
 S ^XTMP(HL,0)=$$HTFM^XLFDT(%H+2)_"^"_$G(DT) L -^XTMP(HL)
 S ^XTMP(HL,"STATUS")="0^New",^("CNT")=0
 Q HL
 ;
HDLSTA(HL,STATUS) ;update the status node in XTMP
 Q:'$D(^XTMP(HL)) -1
 L +^XTMP(HL):5
 S ^XTMP(HL,"STATUS")=STATUS
 L -^XTMP(HL)
 Q 1
 ;
PLACE(HL,DATA) ;Called to place each line of data.
 N IX
 Q:'$D(^XTMP(HL,"CNT"))
 S IX=+$G(^XTMP(HL,"CNT")),^XTMP(HL,"D",IX)=DATA,^XTMP(HL,"CNT")=IX+1
 Q
 ;
RPCCHK(RET,HDL) ;RPC handle status check.
 S RET(0)=$$CHKHDL(HDL)
 Q
 ;
CHKHDL(HL) ;Return the status of a handle
 Q:'$D(^XTMP(HL)) "-1^Bad Handle"
 L +^XTMP(HL):1 I '$T Q "0^Busy"
 N % S %=$G(^XTMP(HL,"STATUS"),"0^Null")
 L -^XTMP(HL)
 Q %
 ;
GETNODE(HL,ND) ;Get a status node
 Q $G(^XTMP(HL,ND))
 ;
SETNODE(HL,ND,DATA) ;Set a status node
 S ^XTMP(HL,ND)=DATA
 Q
 ;
