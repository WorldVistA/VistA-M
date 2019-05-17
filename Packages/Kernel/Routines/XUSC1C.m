XUSC1C ;ISCSF/RWF - Client Interface to Server services.;04/17/14  11:43
 ;;8.0;KERNEL;**283,580,642**;Jul 10, 1995;Build 6
 ;Per VA Directive 6402, this routine should not be modified.
 ;Return 0 = OK, else -1^msg
EN(INPUT,OUTPUT,TYPE) ;Call to connect to Server
 N X,Y,XUSCCMD,XUSCDAT,XUSCER,XUSCTIME,XUSCTRC,XUSCEXIT
 D SETUP
 D TRACE("IP:"_XUSC("IP")_" Port: "_XUSC("SOCK"))
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^XUSC1C"
 D OPEN G:XUSC("STAT") ERR
 D HELO G:XUSC("STAT") ERR
 ;D SERV G:XUSC("STAT") ERR
 D DATA G:XUSC("STAT") ERR
 D TURN G:XUSC("STAT") ERR
 D GET G:XUSC("STAT") ERR
 D QUIT
 Q 0
ERR ;Report back an error
 D TRACE("ERROR "_XUSC("STAT"))
 D:'POP QUIT
 Q XUSC("STAT")
 ;
ERROR ;Trap an error
 S XUSC("STAT")="-1^M error: "_$ECODE
 D ^%ZTER G UNWIND^%ZTER
 ;
OPEN ;Open connection
 N IPCNT,IPA
 D TRACE("Make Connection")
 F IPCNT=1:1 S IPA=$P(XUSC("IP"),",",IPCNT) Q:IPA=""  D
 . I '$$VALIDATE^XLFIPV(IPA) S IPA=$P($$ADDRESS^XLFNSLK(IPA),",")  ;p642 ICR#5844
 . I '$$VALIDATE^XLFIPV(IPA) Q  ;p642 ICR#5844
 . D TRACE("Call IP "_IPA)
 . F XUSCCNT=0:1:5 D  Q:'POP
 . . D CALL^%ZISTCP(IPA,XUSC("SOCK"),1)
 I POP S XUSC("STAT")="-1^Initial Connection Failed" Q
 D TRACE("Got Connection")
 U IO
 Q
HELO ;start conversation
 N I ;p638
 S X=$$POST("HELO "_$$KSP^XUPARAM("WHERE"))
 I $E(X,1)'=2 S XUSC("STAT")="-1^Initial HELO Failed",XUSC("REC")=X
 I $E(X,1,3)="421" S XUSC("STAT")="-1^Busy"
 F I=0:1:5 Q:$E(XUSCCMD,1,3)=220  D CREAD^XUSC1S ;p642 quit after 6 tries (read failed)
 Q
SERV ;Requested Service
 D TRACE("Service Request: "_TYPE)
 S X=$$POST("SERV "_TYPE)
 I $E(X,1)'=2 S XUSC("STAT")="-1^"_X,XUSC("REC")=X
 Q
DATA ;Send data
 D TRACE("Send Data")
 D SDATA^XUSC1S1(INPUT,$G(TYPE,"MPI")),CREAD^XUSC1S
 I $E(XUSCCMD,1)'=2 S XUSC("STAT")="-1^No 220 after send "_XUSCDAT Q
 Q
 ;
TURN ;Turn channel
 S X=$$POST("TURN ") I $E(X,1)'=2 S XUSC("STAT")="-1^No 220 after Turn"
 Q
GET ;Get responce
 D CREAD^XUSC1S I XUSCCMD[220 G GET
 I XUSCCMD'["DATA" S XUSC("STAT")="-1^No DATA cmd "_XUSCCMD Q
 D DATA^XUSC1S1(OUTPUT)
 Q
QUIT ;Shut down
 D SEND^XUSC1S("QUIT ")
 D CLOSE^%ZISTCP
 Q
POST(MSG) ;Send a command and get responce
 D SEND^XUSC1S(MSG)
 D CREAD^XUSC1S
 Q XUSCCMD
 ;
TRACE(S1) ;
 N %,H
 I S1=-1 K ^TMP("XUSC1",$J) Q
 Q:'$G(XUSCDBUG)
 S H=$P($H,",",2),H=(H\3600)_":"_(H#3600\60)_":"_(H#60)_" "
 L +^TMP("XUSC1",$J):1
 S %=$G(^TMP("XUSC1",$J,0))+1,^(0)=%,^(%)=H_XUSCTRC_S1
 L -^TMP("XUSC1",$J)
 Q
SETUP ;
 S (XUSC("STAT"),XUSCEXIT)=0,XUSCTIME=30,XUSCTRC="C: "
 S XUSCDBUG=$$GET^XPAR("SYS","XUSC1 DEBUG",,"Q")
 D TRACE(-1),TRACE("Client Setup")
 Q
