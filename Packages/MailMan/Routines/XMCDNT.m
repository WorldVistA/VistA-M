XMCDNT ;(HINES ISC)/EEJ-NT Communications Diagnostics (shareware) ;08/28/2002  09:40
 ;;8.0;MailMan;**3**;Jun 28, 2002
 ;EEJ,hines ISC.  Will test mailers in other domains for TCP/IP
 N XMHOST,XMRG,DIR,X,Y
 D HOME^%ZIS
 W !,"TCP/IP Tester",!
 S DIR(0)="F^3:30"
 S DIR("A")="Enter the TCP/IP address of remote site"
 D ^DIR Q:$D(DIRUT)
 S XMHOST=Y
 W !,"Trying Connection..."
 D CALL^%ZISTCP(XMHOST,25) I POP W !,"TCP/IP link not open" Q
 U IO(0) W !!,"Connection OPEN, Testing...",!
 U IO R XMRG:10
 I XMRG["220" U IO(0) W !,XMRG,"     Successful."
 E  U IO(0) W !,"No answer from mailer at ",XMHOST
 U IO W "QUIT",$C(13,10),!
 D CLOSE^%ZISTCP
 Q
