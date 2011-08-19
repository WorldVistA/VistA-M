XMCD ;(WASH ISC)/THM-Communications Diagnostics ;04/17/2002  08:27
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; DIALER  XMDXMODEM
 ; TRAN    XMDXSCRIPT
 ; SMTP    XMDXSMTP
 Q
DIALER ; Test the modem autodialer
 W !!,"This tests the modem autodialer by allowing you to enter a phone number"
 W !,"which this program will then dial on the selected modem.",!!
 N XMABORT,XMPHONE,XMHANG,XMSTAT,XMDIAL,DIR,X,Y
 S (XMABORT,ER)=0
 F  D ^%ZIS Q:POP  D  Q:XMABORT
 . D D1^XMC1B
 . U IO(0)
 . I XMC("MODEM")="" W !,$C(7),"This device has no modem defined for it." Q
 . W !,^%ZIS(2,XMC("MODEM"),0)," is the defined modem for device ",IO
 . I $L(XMSTAT) W !,"Checking status..." U IO X XMSTAT U IO(0) W " Status: ",Y
 . I '$L(XMDIAL) W !,"No dialer logic specified for this modem type" Q
 . I '$L(XMHANG) W !,"No hangup logic specified for this modem type",$C(7) Q
 . F  D  Q:XMABORT!'ER
 . . K DIR,X,Y
 . . S DIR(0)="F^3:30"
 . . S DIR("A")="Enter the phone number to dial"
 . . D ^DIR I $D(DIRUT) S XMABORT=1 Q
 . . S XMPHONE=Y
 . . U IO X XMDIAL U IO(0)
 . . I ER W !,$C(7),"Call failed: ",Y
 . Q:XMABORT
 . W !,"Successful.  Now hanging up ..."
 . U IO X XMHANG U IO(0)
 . I ER W !,$C(7),"Hang up unsuccessful" Q
 . W !,"Hang up successful."
 D KILL^XMC
 Q
SMTP ; SMTP Tester
 W !!,"This procedure will test the Simple Mail Transfer Protocol,"
 W !,"allowing you to interactively enter each of the SMTP commands."
 W !,"The messages will not actually be delivered to the named recipients."
 W !,"That which you type will be preceded with an 'S: '."
 W !,"The SMTP responses will be preceded with an 'R: '"
 W !!,"Terminate the session with a QUIT command",!!
 D TST^XMR
 Q
TRAN ; Test transmission error rates, speeds
 N XMSECURE,%X,%Y
 W !!,"This will test a link by executing the script, then sending 20 lines"
 W !,"in echo test mode.  It will report the number of recoverable and "
 W !,"unrecoverable errors, as well as the transmission efficiency."
 D LOADCODE^XMJMCODE
 S %X="XMSECURE(",%Y="^TMP(""XMS"",$J,""S""," D %XY^%RCR
 K XMSECURE
 S XMC("TEST")=1
 D PLAY^XMCX
 K XMC("TEST"),^TMP("XMS",$J,"S")
 D KILL^XMC
 Q
