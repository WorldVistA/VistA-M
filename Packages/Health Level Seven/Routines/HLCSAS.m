HLCSAS ;ISCSF/RWF - MPI direct connect server ;09/23/2005  14:36
 ;;1.6;HEALTH LEVEL SEVEN;**43,89,120**;Oct 13,1995;Build 12
 Q
 ;HLCS is used to pass data around.
 ; 5500 is the standard VA port for the MPI_direct connect
LISTEN ;only for OpenM
 S $ETRAP="D ^%ZTER H"
 D LISTEN^%ZISTCPS(5500,"ONT^HLCSAS")
 Q
DSM ;%=device^HLDP
 S IO=$P(%,"^"),HLDP=$P(%,"^",2)
 O IO:(SHARE) U IO ;Setup TCP port
 S IO(0)="_NLA0:" O IO(0) ;Setup null device
 D SVR
 Q
CACHE ;%=device^HLDP
 S (IO,IO(0))="SYS$NET"
 S HLDP=$ZF("GETSYM","HLDP")
 O IO U IO:(::"-M")  ;Setup TCP port
 S IO(0)="_NLA0:" O IO(0) ;Setup null device
 D SVR
 Q
MSM ;Entry point from MSERVER
 ;S HLDP=ien
 S IO=56,IO(0)=46
 O 46 ;Null device
 D SVR C IO
 Q
ONT ;Cache/OpenM
 ;S HLDP=ien
 S IO=$I,IO(0)="//./nul"
 O IO(0)
 D SVR
 Q
 ;
SVR ;Entry point when we have a connect
 ;See that IO=TCP device, and IO(0) is Null device and Open.
 ;HLDP=ien of Logical Link
 N HCSA1,HCSER,HCSEXIT,HCSCMD,HCSDAT
 D SETUP Q:HCSER
 N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER H"
 D UPDT^HLCSTCP(1)
 F  D CREAD Q:HCSEXIT  D  Q:HCSEXIT
 . I HCSCMD="" S HCSA1("TCNT")=$G(HCSA1("TCNT"))+1 S:$$STOP^HLCSTCP!(HCSA1("TCNT")>10) HCSEXIT=1 Q
 . I HCSCMD'?4A D SEND("500 Bad CMD: "_$E(HCSCMD,1,20)) Q
 . I $T(@HCSCMD)="" D SEND("500 ") Q
 . S HCSA1("TCNT")=0
 . D @HCSCMD I $G(HCSER) D TRACE("ERROR: "_HCSER)
 . Q
 S:HCSEXIT IO("C")=1
 D TRACE("Exit"),UPDT^HLCSTCP(0)
 Q
HELO ;Process HELO
 S HCSA1("SITE")=$P(HCSDAT," ")
 ;Do any check on who is sending
 D SEND("220 "_$$KSP^XUPARAM("WHERE")_" Ready for "_HCSDAT)
 Q
 ;
NOOP ;
 D SEND("250 OK")
 Q
 ;
DATA ;Process DATA
 ; The DATA cmd can pass some parameters as well, this could be passed
 ; to the processing routine also.
 N P,I,DUZ,HLMID,HLTIEN,HLDT
 ;S DUZ=0,DUZ(0)="@"
 D TRACE("Get Data")
 S HCSA1("DATA")=HCSDAT,HCSIN=$NA(TMP("HCSI",$J)),HCSOUT=$NA(^TMP("HCSO",$J))
 K @HCSOUT
 D DATA^HLCSAS1(HCSIN,.HCSA1) QUIT:$G(HCSER)
 S P="" F I=1:1 Q:'$D(HCSA1("P"_I))  S P=P_"P"_I_"="_HCSA1("P"_I)_", "
 D TRACE("PARAM "_P)
 ;Use the Null Device
 U IO(0)
 ;Now call soneone to process the data
 I HCSA1("P1")="MPI" D ^MPIDIRQ(HCSIN,HCSOUT)
 I HCSA1("P1")="PING" M @HCSOUT=@HCSIN
 U IO ;Back to the TCP device
 D LLCNT^HLCSTCP(HLDP,2)
 Q
TURN ;Turn and send responce
 D SEND("220 OK")
 D SDATA^HLCSAS1(HCSOUT,HCSA1("P1"))
 D CREAD,TRACE("Data Sent ") ;Look for 220 ok
 Q
QUIT ;Process QUIT
 D TRACE("QUIT")
 S HCSMSG="",HCSEXIT=1
 Q
 ;
CREAD ;Read a string
 N $ETRAP S $ETRAP="S $EC="""" G CREX"
 N I S (Y,HCSDAT,HCSCMD)="",HCSER=0
 F I=0:1:255 R X#1:HLDREAD S:'$T HCSER=1 Q:X=$C(10)!HCSER  S Y=Y_X
 S Y=$TR(Y,$C(13,10)),HCSCMD=$P(Y," "),HCSDAT=$P(Y," ",2,99)
 D TRACE("Cmd Read "_Y)
 Q
CREX S HCSEXIT=1,HCSER="1 Error"
 Q
 ;
SEND(MSG) ;Send a cmd MSG
 N $ETRAP S $ETRAP="S $EC="""" D CREX"
 D TRACE("Cmd Send "_MSG)
 W MSG,$C(13,10),!
 Q
 ;
SETUP ;Setup needed variables
 K IO("C")
 S X=$$INIT^HLCSTCP
 I 'X D ^%ZTER S HCSER=1 Q
 S (HCSER,HCSEXIT)=0,HCSTRACE="S: ",HCSA1("P1")="TEXT"
 D TRACE(-1),TRACE("Server Setup")
 Q
 ;
TRACE(S1) ;
 Q
 N H,%
 I S1=-1 K ^TMP("HCSA",$J) Q
 S H=$P($H,",",2),H=(H\3600)_":"_(H#3600\60)_":"_(H#60)_" "
 L +^TMP("HCSA",$J) S %=$G(^TMP("HCSA",$J,0))+1,^(0)=%,^(%)=H_$G(HCSTRACE)_S1 L -^TMP("HCSA",$J)
 Q
 ;
