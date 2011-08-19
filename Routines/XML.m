XML ;(WASH ISC)/THM/GJL-MailMan Physical link ;06/04/2002  08:26
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points (DBIA 1283):
 ; GET  - Set up variables for communications protocol in file 3.4
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; C     XMDXPROT
OPEN ;
 N Y
 I $G(XMCHAN)="" S XMCHAN="SCP"
 D GET Q:ER
 D OP Q:ER
 S:'$D(XMESC) XMESC="~"
 S:'$D(XMFS) XMFS=255
 S:'$D(XM) XM=""
 Q
GET ; Set up variables for communications protocol in file 3.4
 ; In:
 ; XMCHAN  - Name of the communications protocol
 ; Out:
 ; XMCHAN  - IEN of the communications protocol
 ; XMPROT  - Name of the communications protocol
 ; XMSEN   - Xecute this variable to send a line
 ; XMREC   - Xecute this variable to receive a line
 ; XMOPEN  - Xecute this variable to open the channel
 ; XMCLOSE - Xecute this variable to close the channel
 ; XMOS    - Operating System, used in ^XMLTCP
 N DIC,X
 S X=XMCHAN,DIC="^DIC(3.4,",DIC(0)="FO"
 D ^DIC I Y<0 D  Q
 . D ERTRAN^XMC1(42244,XMCHAN) ;Invalid Communications Protocol: '|1|'
 . S Y=XMTRAN
 S XMCHAN=+Y,XMPROT=$P(Y,U,2)
 S XMSEN=$G(^DIC(3.4,XMCHAN,1),"Q"),XMREC=$G(^(2),"Q"),XMOPEN=$G(^(3),"Q"),XMCLOSE=$G(^(4),"Q")
 S XMOS=^%ZOSF("OS")
 I XMOS["MSM" D
 . S XMOS("MSMVER")=$P($ZV," 4.0.",2)
 . S:+XMOS("MSMVER")=0 XMOS("MSMVER")=8
 Q
OP ;
 I "Q"'[$G(XMOPEN) X XMOPEN
 I 'XMC("BATCH"),'$D(XMQUIET) S X=255 X ^%ZOSF("RM")
 Q
C X ^%ZOSF("EON")
 I $D(XMCLOSE) X:$L(XMCLOSE) XMCLOSE
 Q
 ; The following has nothing to do with the above.
 ; These are used by the SCP Communications Protocol in file 3.4.
SEND ; Sends XMSG, returns ER=0 or 1, and XMLER=number of "soft" errors
 I $L(XMSG)>255 S XMLER=0,ER=1 G SRQ
 I XMSG'?.ANP F %=1:1:$L(XMSG) I $E(XMSG,%)?1C,$A(XMSG,%)'=9 S XMSG=$E(XMSG,1,%-1)_$E(XMSG,%+1,999) Q:XMSG?.ANP  S %=%-1
 D SRINIT S X=XMSG D SUM
 I $G(XMINST) D XMTSTAT^XMTDR(XMINST,"S",XMSG,0)
SL S XMLER=XMLER+1 I (XMLER+1)>XMLMAXER D NEWSTRAT
 I ER W XMLERR,$C(13) G SRQ
 D BUFLUSH W XMSG,$C(13) W XMLINE,U,XMSUM,$C(13) R XMLX:XMLTIME G:XMLX=(XMLINE_U_XMLACK) SRQ
 S XMLY=XMLX=(XMLINE_U_XMLNAK),XMLZ=0 D:'XMLY ENQ G SL:XMLY,SRQ
ENQ ; ACK/NAK garbled - try to re-establish contact
 S XMLZ=XMLZ+1 I XMLZ>XMLMAXER S (ER,XMLY)=1 Q
 D BUFLUSH W XMLENQ,$C(13) R XMLX:XMLTIME Q:XMLX=(XMLINE_U_XMLACK)
 I XMLX[XMLACK!(XMLX[XMLNAK),+XMLX=XMLINE!(+XMLX=XMLINE-1) S XMLY=1 Q
 H 1 G ENQ
REC ; Receives XMRG, returns ER=0 or 1, and XMLER=number of "soft" errors
 D SRINIT S:'$D(XMLAN) XMLAN=XMLINE_U_XMLNAK
 I $D(XMRG),$G(XMINST) D XMTSTAT^XMTDR(XMINST,"R",XMRG,0)
RL S XMLER=XMLER+1 I (XMLER+1)>XMLMAXER D NEWSTRAT I ER=1 G SRQ
 R XMRG#255:$S($D(XMSTIME):XMSTIME,1:XMLTIME)
 S XMLZ=$S('$T:-1,XMRG=XMLENQ:0,XMRG=XMLERR:2,1:1)
 S ER=XMLZ=2 G:XMLZ>1 SRQ I 'XMLZ D BUFLUSH W XMLAN,$C(13) G RL
 R XMLY:XMLTIME
 I +XMLY=XMLINE S X=XMRG D SUM S XMLZ=XMSUM=$P(XMLY,U,2) G RL2
 S XMLZ=0 I +XMLY=(XMLINE-1),XMLINE'=1 D BUFLUSH W +XMLY,U,XMLACK,$C(13) G RL
RL2 S XMLAN=XMLINE_U_$S(XMLZ:XMLACK,1:XMLNAK) D BUFLUSH W XMLAN,$C(13)
 G SRQ:XMLZ,RL
SRINIT ; Initialize variables for Send/Receive
 S XMLINE=$S('$D(XMLINE):1,1:XMLINE+1),XMLACK="ACK",XMLNAK="NAK"
 S XMLENQ=$C(9)_"ENQ"_$C(9),XMLERR=$C(9)_"ERROR"_$C(9)
 S XMLER=-1 ;soft error count
 S XMLMAXER=5 ;maximum allowable soft errors
 S XMLTIME=30 ;length of READ time
 S ER=0 ;non-recoverable error flag
 Q
NEWSTRAT ; Select new strategy, one or both machines may be slow
 I XMLMAXER=5 S ER=1 Q  ;already tried new strategy, give up.
 S XMTLER=$S('$D(XMTLER):XMLER,1:XMTLER+XMLER),XMLER=0 ;add to total
 S XMLMAXER=5 ;reduce allowable soft errors
 S XMLTIME=30 ;increase the READ time
 Q
SRQ ; Exit from Send/Receive
 S XMTLER=$S('$D(XMTLER):XMLER,1:XMTLER+XMLER) ;Total errors
 K XMLACK,XMLNAK,XMLENQ,XMLERR,XMLMAXER,XMLTIME,XMLX,XMLY,XMLZ
 Q
BUFLUSH ; Flush buffer
 Q:'$D(XMBFLUSH)
 X ^%ZOSF("TRMON") S X=$P($H,",",2) F %=1:1 R %:0 Q:'$T  S %=$P($H,",",2) S:%<X %=%+86400 Q:%-X>15
 X ^%ZOSF("TRMOFF")
 Q
SUM ; Calculate checksum, accounting also for the character's position
 S XMSUM=0 F %=1:1:$L(X) S XMSUM=XMSUM+($A(X,%)*%)
 Q
