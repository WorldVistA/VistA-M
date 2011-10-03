XWBCAGNT ;ISC-SF/EG,RWF - Connect to Remote TCP Client Agent ;2/12/98  16:15<<= NOT VERIFIED >
 ;;1.1;RPC BROKER;**2**;Mar 28, 1997
 Q
 ;
CMD(XWBRET,QUES,PARAM) ;Call daemon and get responce <e.f.>
 N IPA,SOCK S XWBRET="",IPA=$G(IO("IP")),SOCK=9200 Q:IPA="" 0
 I $G(IO)="" D HOME^%ZIS
 D CALL^%ZISTCP(IPA,SOCK,3) I POP Q 0
 D SEND(QUES,$G(PARAM)),REC(.XWBRET)
 D CLOSE^%ZISTCP
 Q 1
 ;
OPEN(IP,SKT) ; - connect to remote <extrinsic function>
 D HOME^%ZIS:'$D(IO(0)),SAVDEV^%ZISUTL("XWBCAGENT HOME")
 D CALL^%ZISTCP(IP,SKT,3)
 Q
 ;
SEND(S,P) ; - send message <procedure>
 N $ETRAP S $ETRAP="S $EC="""" Q"
 S S=$$SETMSG(S,$G(P))
 U IO W S,!
 Q
 ;
REC(BODY) ; - receive message <extrinsic function>
 N LEN,Y
 U IO S BODY("HDR")="~",BODY("HDR")=$$SREAD(5) ; -- get header
 Q:BODY("HDR")'="{XWB}"  ; -- quit if no responce
 S LEN=$$SREAD(5),BODY("ID")=$$SREAD(+LEN) ; -- get PID
 S LEN=$$SREAD(5),BODY(0)=$$SREAD(+LEN) ; -- get rpc name
 S LEN=$$SREAD(5) D:+LEN BREAD(+LEN,.BODY) ; -- get rpc parameter
 S LEN=$$SREAD(1) ; -- read terminator
 Q
 ;
SETMSG(S,PAR) ; - format message <extrinsic function>
 N L,F,PID
 IF ('$D(S))!('$D(PAR)) Q ""
 S F=100000
 S PID=$J
 S L=$L(PID)
 S PID=$E(F+L,2,6)_PID
 S L=$L(S),S=$E(F+L,2,6)_S
 S L=$L(PAR),PAR=$E(F+L,2,6)_PAR
 Q "{XWB}"_PID_S_PAR_$C(23)
 ;
CLOSE ; - close device <procedure>
 D CLOSE^%ZISTCP,USE^%ZISUTL("XWBCAGENT HOME"),RMDEV^%ZISUTL("XWBCAGENT HOME")
 Q
 ;
BREAD(L,B) ;read tcp buffer, L is length <extrinsic function>
 N E,X,T,DONE,XWBTIME,Y,IX,$ETRAP S $ETRAP="S $EC="""" Q"
 S (T,E,DONE)=0,XWBTIME=10,IX=1,B=L,L=$S(L<256:L,1:128) Q:L'>0 ""
BR2 R X#L:XWBTIME
 S E=X
 IF $L(E)<L F  D  Q:DONE
 . IF $L(E)=L S DONE=1 Q
 . R X#(L-$L(E)):XWBTIME
 . S E=E_X
 S B(IX)=E,T=T+$L(E)
 I T'=B S L=$S(B-T>255:128,1:B-T),IX=IX+1 G BR2
 Q
 ;
SREAD(L) ;read short tcp buffer, L is length <extrinsic function>
 N C,E,X,DONE,XWBTIME,$ETRAP S $ETRAP="S $EC="""" Q """""
 S (C,E,DONE)=0,XWBTIME=10 Q:L'>0 ""
 R X#L:XWBTIME
 S E=X IF $L(E)<L R X#(L-$L(E)):XWBTIME S E=E_X
 Q E
 ;
