XMC1 ;ISC-SF/GMB-Script Interpreter ;07/23/2002  10:15
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/THM
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; RESUME  XMSCRIPTRES     (was RES^XMC11)
ENT ;
 ; Expects as input:
 ; XMINST           Domain IEN
 ; XMSITE           Domain name
 ; XMB("SCR IEN")   Script IEN
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D C^XMCTRAP"
 E  S X="C^XMCTRAP",@^%ZOSF("TRAP")
 K ^TMP("XMY",$J),^TMP("XMY0",$J)
 N XMLER,XMLIN
 S ER=0,XMC("SHOW TRAN")="RS"
 D GET^XMCXT(0)
 I '$D(^XMBS(4.2999,XMINST,0)) D STAT^XMTDR(XMINST)
 ; *** how about L +^XMBS(4.2999,XMINST,3) ?
 I '$D(XMC("TALKMODE")) L +^DIC(4.2,XMINST,"XMNETSEND"):0 E  D  Q
 . D ERTRAN(42210) ;Netmail transmission in progress on another channel
 D IN
 L -^DIC(4.2,XMINST,"XMNETSEND")
 Q
IN ;To |1| from |2| beginning |3|
 D DOTRAN(42211,XMSITE,^XMB("NETNAME"),$$FMTE^XLFDT(DT,5))
 D DOTRAN(42212,$P(XMB("SCR REC"),U)) ;Script: |1|
 I $$USESCR(XMINST,.XMB) D
 . D EN(XMINST,XMSITE,$P(XMB("SCR REC"),U),"^DIC(4.2,"_XMINST_",1,"_XMB("SCR IEN")_",1,")
 E  D
 . N XMNETREC,X,XMC1,XMSCRN
 . S XMNETREC=$G(^XMB(1,1,"NETWORK"))
 . S XMSCRN=$P(XMB("SCR REC"),U)
 . D DOTRAN(42213) ;Creating transmission script 'on the fly' ...
 . S X="O H="_XMSITE_",P="_$P(^DIC(3.4,$P(XMNETREC,U,3),0),U)
 . S XMC1=$P(X," ",2,999)
 . D O Q:ER
 . S X="C "_$P(^XMB(4.6,$P(XMNETREC,U,4),0),U)
 . S XMC1=$P(X," ",2,999)
 . D C
 Q:$D(XMC("TALKMODE"))
 I ER,'$D(ER("MSG")),XMTRAN'="" D TRAN
 D DOTRAN(42214) ; Script Complete.
 I ER D DOTRAN(42215) ; Stopped because of error.
 D CLOSE^XMC1B
 Q
USESCR(XMINST,XMB) ; Function returns 1 if we should use the existing
 ; script, or 0 if we should build a TCP/IP script.
 Q:"^^SMTP^TCPCHAN^"'[(U_$P(XMB("SCR REC"),U,4)) 1  ; Use it
 N XMNETREC
 S XMNETREC=$G(^XMB(1,1,"NETWORK"))
 Q:'$P(XMNETREC,U,3)!'$P(XMNETREC,U,4) 1  ; Use it
 Q $O(^DIC(4.2,XMINST,1,XMB("SCR IEN"),1,0))>0  ;1=Use it; 0=Build it
EN(XMINST,XMSITE,XMSCRN,XMROOT) ;
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D C^XMCTRAP"
 E  S X="C^XMCTRAP",@^%ZOSF("TRAP")
 N XMCI
 S XMCI=0
 F  S XMCI=$O(@(XMROOT_XMCI_")")) Q:'XMCI  D INT(@(XMROOT_XMCI_",0)"),XMCI) Q:ER
 Q
INT(X,XMCI) ; Interpret the script line
 ; X    script line
 N XMC1
 S ER=0
 S:$E(X)?1L X=$$UP^XLFSTR(X)_$E(X,2,999)
 I "EFCXOHMDLTSW"'[$E(X)!(X="") D  Q
 . D ERTRAN(42216,X,XMCI) ;Invalid script command '|1|' at line |2|
 S XMC1=$P(X," ",2,999)
 D @$E(X)
 S:'$D(ER) ER=0
 Q
C ; Call a subroutine
 D DOTRAN(X)
 N X,Y,DIC,XMNSCR,XMNSCRN,XMER
 S X=$P(XMC1,"("),DIC="^XMB(4.6,",DIC(0)="O" D ^DIC
 I Y<0 D  Q
 . D ERTRAN(42217,X) ;Script '|1|' cannot be found in file 4.6
 S XMNSCR=+Y,XMNSCRN=$P(Y,U,2)
 D DOTRAN(42218,XMNSCRN) ;Calling script '|1|' (file 4.6)
 D EN(XMINST,XMSITE,XMNSCRN,"^XMB(4.6,XMNSCR,1,")
 I ER D  Q  ; XMER may be set by the transmission script in file 4.6
 . I $D(XMER),'$D(ER("MSG")) D ERTRAN(XMER)
 D DOTRAN(42219,XMSCRN) ;Returning to script '|1|'.
 Q
DI ; Dial phone
 N XMC1,DIR,X,Y
 S DIR(0)="F^3:50"
 S DIR("A")=$$EZBLD^DIALOG(42220) ;Enter number(s) to dial
 D ^DIR Q:$D(DIRUT)
 S XMC1=Y
D ; Dial numbers sucessively (Strip all punctuation not in XMSTRIP string)
 D DIAL(XMC1)
 Q
DIAL(XMNUMS) ;
 N XMSEP,XMI,XMNUM
 S XMSEP=$S($L($G(XMFIELD)):XMFIELD,1:$S($G(XMSTRIP)[",":";",1:","))
 F XMI=1:1 S XMNUM=$P(XMNUMS,XMSEP,XMI) Q:XMNUM=""  D DIALTRY(XMNUM) Q:'ER
 K XMSTRIP,XMFIELD
 Q
DIALTRY(XMNUM) ;
 N XMPHONE,XMI,XMDIGIT,Y
 S XMPHONE=""
 F XMI=1:1:$L(XMNUM) S XMDIGIT=$E(XMNUM,XMI) I $S(XMDIGIT'?1P:1,$G(XMSTRIP)[XMDIGIT:1,1:0) S XMPHONE=XMPHONE_XMDIGIT
 S ER=0
 D DOTRAN(42221,XMPHONE) ;Dialing |1|
 I '$D(XMDIAL) D ERTRAN(42222) Q  ;Call failed: no XMDIAL
 X XMDIAL
 I ER D ERTRAN($S($D(Y):42222.1,1:42222.2),$G(Y)) ;Call failed: |1| or unknown reason
 Q
E ; Set error message to be displayed.
 S ER("MSG")=XMC1
 D DOTRAN(42223,ER("MSG")) ;Error message set to '|1|'
 Q
F ; Flush buffer
 D DOTRAN(42224) ;Flushing buffer
 G BUFLUSH^XML
 Q
H ; Hang up phone
 D DOTRAN(42225) ;Hanging up phone
 Q:'$D(XMHANG)
 X XMHANG
 Q
L ; Look for string
 D LOOK^XMC1A
 Q
M ; Send mail
 D DOTRAN(42226) ;Beginning sender-SMTP service
 D ENTER^XMS
 I ER D DOTRAN("ER="_ER_" - ER(""MSG"")="_$G(ER("MSG")))
 Q
O ; Open device, protocol, and host
 D DOTRAN(X)
 D OPEN^XMC1B X:'ER XMOPEN
 I ER D DOTRAN(42227) Q  ;Open failed
 D DOTRAN(42228,XMSITE) ;Channel opened to |1|
 D FLUSH
 D DOTRAN(42229,XMC("DEVICE"),XMPROT) ;Device '|1|', Protocol '|2|' (file 3.4)
 N XMFDA,XMIENS
 S XMIENS=XMINST_","
 S XMFDA(4.2999,XMIENS,1)=$H
 S XMFDA(4.2999,XMIENS,6)=IO ; Device
 D FILE^DIE("","XMFDA")
 Q
FLUSH ; Flush buffer
 Q:'$D(XMBFLUSH)
 N XMLX
 F  R XMLX:0 Q:'$T
 Q
S ; Send line
 I XMC1?1"@".E D  Q:ER
 . N XMSAVE
 . S XMSAVE=XMC1
 . D INDIR(.XMC1) Q:ER
 . D DOTRAN(42230,XMSAVE,XMC1) ;Transforming '|1|' to '|2|'
 I XMC("SHOW TRAN")["S" D DOTRAN("S: "_XMC1)
 I XMC1["~" S XMC1=$$RTRAN^XMCU1(XMC1)
 W XMC1,$C(13)
 Q
INDIR(XMC1) ; GET INDIRECT REFERENCE
 N XMREF
 S XMREF=$P(XMC1,"@",2,99)
 I '$D(@XMREF) D ERTRAN(42231,XMREF) Q  ;Undefined reference to |1|
 S XMC1=@XMREF
 Q
T ;
 Q:'$D(XMC("TALKMODE"))
 S XMCI=999999
 D DOTRAN(42232) ;Entering Talk mode
 Q
W ; Wait a number of seconds
 D DOTRAN(42233,XMC1) ;Waiting |1| seconds
 H +XMC1
 Q
X ; Execute a line of code
 D DOTRAN(42234,XMC1) ;Xecuting |1|
 X XMC1
 Q:'ER
 I $E(XMC1,1,2)'="O ",$E(XMC1,1,14)'="D CALL^%ZISTCP" Q
 D ERTRAN(42235,XMHOST) S ER=25 ;Can't connect using IP address |1|
 Q
ERTRAN(XMDIALOG,XM1,XM2,XM3) ;
 D DOTRAN(XMDIALOG,.XM1,.XM2,.XM3)
 S ER=1
 I '$D(ER("MSG")) S ER("MSG")=XMTRAN
 Q
DOTRAN(XMDIALOG,XM1,XM2,XM3) ;
 N XMPARM
 S:$D(XM1) XMPARM(1)=XM1 S:$D(XM2) XMPARM(2)=XM2 S:$D(XM3) XMPARM(3)=XM3
 S XMTRAN=$S(+XMDIALOG=XMDIALOG:$$EZBLD^DIALOG(XMDIALOG,.XMPARM),1:XMDIALOG)
 ; fall through...
TRAN ;
 N XMTIME,XMAUDIT
 S XMTIME=$P($H,",",2)
 S XMAUDIT=$E($TR($J(XMTIME\3600,2)_":"_$J(XMTIME#3600\60,2)_":"_$J(XMTIME#60,2)," ","0")_" "_XMTRAN,1,245)
 ; Trace / Debug transmission problems
 ; Field 8.2 in file 4.3 says whether to audit.
 I $G(XMC("AUDIT")) S XMC("AUDIT","I")=$G(XMC("AUDIT","I"))+1,^TMP("XMC",XMC("AUDIT"),XMC("AUDIT","I"),0)=XMAUDIT
 Q:$G(XM)'["D"
 U IO(0)
 W !,XMAUDIT
 W:$G(XMLER) "("_XMLER_")"
 I IO'="",IOT'="RES" U IO
 Q
RESUME ; Resume script processing
 N I,DIR,X,Y
 S:'$D(XMCI) XMCI=0
 D ^%ZIS Q:POP
 S I=0
 F  S I=$O(^DIC(4.2,XMINST,1,XMB("SCR IEN"),1,I)) Q:I=""  W !,$J(I,2),$S(I=XMCI:"->",1:"  "),^(I,0)
 S DIR(0)="N^1:"_$O(^DIC(4.2,XMINST,1,XMB("SCR IEN"),1,""),-1)
 S DIR("A")=$$EZBLD^DIALOG(42236) ;Resume script processing from line
 S DIR("B")=XMCI
 D ^DIR Q:$D(DIRUT)
 S XMCI=Y
 D DOTRAN(42237,XMCI) ;Resuming script from line |1|
 S XMCI=XMCI-.1
 U IO
 G IN
 Q
