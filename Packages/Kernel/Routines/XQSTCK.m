XQSTCK ;Luke/SEA - Stack utilities ;3/11/94  13:50 [ 07/30/94  10:48 PM ]
 ;;8.0;KERNEL;;Jul 10, 1995
PUSH(XQY,XQPSM,XQY0) ;Add an option to the stack
 S XQSTPT=^XUTL("XQ",$J,"T")
 S XQSTPT=XQSTPT+1
 S ^XUTL("XQ",$J,XQSTPT)=XQY_XQPSM_U_XQY0,^("T")=XQSTPT
 I $P(XQY0,U,14),$D(^DIC(19,XQY,20)),$L(^(20)) X ^(20)
 I $D(XQUIT) S TITLE="Menu Error",MESS="'XQUIT' Encountered at Option "_$P(XQY0,U,2)_" ["_$P(XQY0,U)_"]" D POP^XQGP(MESS,TITLE),P1 K XQUIT Q
 I $P(XQY0,U,17),$D(^DIC(19,XQY,26)),$L(^(26)) X ^(26)
 Q
 ;
POP ;Pop one level on the stack
 I $P(XQY0,U,15),$D(^DIC(19,XQY,15)),$L(^(15)) X ^(15)
P1 S XQSTPT=^XUTL("XQ",$J,"T")
 S XQSTPT=XQSTPT-1
 I XQSTPT=0 S XQSTPT=1
 S %=^XUTL("XQ",$J,XQSTPT),XQY=+%,XQY0=$P(%,XQPSM,2,99)
 I '$D(XQUIT),$P(XQY0,U,17),$D(^DIC(19,XQY,26)),$L(^(26)) X ^(26)
 S ^XUTL("XQ",$J,"T")=XQSTPT
 Q
 ;
XACT ;Execute Exit Actions and Headers: input X=option number, no output.
 Q:'$D(^DIC(19,+XQEX,0))
 I $D(^DIC(19,+XQEX,15)),$L(^(15)) X ^(15)
 I $D(^DIC(19,+XQEX,26)),$L(^(26)) X ^(26)
 Q
 ;
PM ;Put primary menu in stack position 1
 D GET I $D(XQFAIL) G OUT
 ;
 S ^XUTL("XQ",$J,1)=XQPM_XQPSM_U_XQY0
 S (XQY,XQDIC)=XQPM,XQPSM="P"_XQPM
 S ^XUTL("XQ",$J,"T")=1
 ;S XQSTPT=1
 G OUT
 Q
 ;
PM1 ;Put primary menu in some other stack position
 ;called by XQGUI to start Option Selection Window
 D GET I $D(XQFAIL) G OUT
 ;
 S XQTT=^XUTL("XQ",$J,"T")
 F XQI=1:1:XQTT I +^XUTL("XQ",$J,XQI)=XQPM S ^XUTL("XQ",$J,"T")=XQI,XQI=0 Q
 G:XQI=0 OUT
 ;
 I XQI>0,$P(^XUTL("XQ",$J,XQTT),U,3)'="XQGUI" S XQTT=XQTT+1
 S ^XUTL("XQ",$J,XQTT)=XQPM_XQPSM_U_XQY0
 S ^XUTL("XQ",$J,"T")=XQTT
 G OUT
 Q
 ;
GET ;Get the Primary Menu Option and set XQY0,XQDIC,XQPSM
 I '$D(DUZ)#2 D NODUZ S XQFAIL="" Q
 S XQPM=$G(^VA(200,DUZ,201)),XQPM=+XQPM I XQPM'>0 D NOPM S XQFAIL="" Q
 S (XQY,XQDIC)=XQPM,XQPSM="P"_XQPM
 ;
 S XQY0=$P(^XUTL("XQO","P"_XQPM,"^",XQPM),U,2,99)
 I '$L(XQY0) D NOXUTL S XQYO=$G(^XUTL("XQO","P"_XQPM,"^",XQPM))
 I '$L(XQY0) S XQY=XQPM D SET^XQCHK
 I XQY'>0 D FAIL S XQFAIL="" Q
 Q
 ;
NOPM ;This user has no primary menu
 S XQER=" No primary menu "
 Q
 ;
NODUZ ;There is no user connected with this process
 S XQER=" No user (DUZ) "
 Q
 ;
NOXUTL ;No ^XUTL("XQO","P"_XQPM) on this system
 I $D(^XTMP("XQO","P"_XQMP)) M ^XUTL("XQO","P"_XQPM)=^XTMP("XQO","P"_XQPM)
 Q
 ;
FAIL ;Absolute and utter failure
 S XQER=$S('$D(XQER):"",'$L(XQER):"",1:XQER)
 D ^XQDATE
 S ^XUTL("XQ",$J,XQNO)=" Failed: "_"^"_%Y_XQER
 Q
 ;
OUT ;Exit point for all subroutines
 K %,%Y,XQER,XQI,XQPM,XQTT
 Q
