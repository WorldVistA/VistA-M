XMM2 ;(WASH ISC)/THM-CERMATEK INFO MATE 212A MODEM ;7/10/89  12:46 ;
 ;;8.0;MailMan;;Jun 28, 2002
O ;DON'T USE "UNLISTEN COMMAND", LEAVE COMMAND CHARACTER TO BE CONTROL-N
 ;THIS PROTOCOL USES ONLY DIAL, END, QUERY, AND RESET COMMANDS
 Q
DIAL ;
 W $C(14),"Q",! R %:1 I %["O" S ER=0,Y="Already off-hook" Q
 W $C(14),"D '",XMPHONE,"'",! S ER=1 R %:30 I '$T S Y="Timeout" Q
 R X:30 I '$T S Y="Timeout" Q
 I X["A" S Y="Connected",ER=0 Q
 I X["B" S Y="Busy" Q
 I X["N" S Y="No Answer" Q
 I X["X" S Y="No dial tone detected" Q
 S Y="Info-mate modem status: '"_X_"'" Q
HANG ; HANG UP MODEM
 W $C(14),"E",!,$C(14),! R X:15 I '$T S Y="Timeout",ER=1 Q
 S ER=0,Y="Successfully hung up" Q
RESET ; RESET MODEM
 W $C(14),"R",!,$C(14),!
 Q
STATUS ; DISPLAY INFO-MATE STATUS INFO
 W $C(14),"Q ",! R X:5 I '$T S Y="Timeout-modem probably not active.",ER=1 Q
EN S Y="",%=$P(X,"/",1),J="OCHMLSARDUXZ"
 S K="Offhook,connected,1200 baud,300 baud,110 baud,Self test enabled,Analog test enabled,Remote originated loop,Digital loop,Unlisten enabled,Command echos,Remote digital loop enabled"
 F I=1:1 S A=$E(J,I) Q:A=""  S:%[A Y=Y_$P(K,",",I)_", "
 S Y=Y_$P(X,"/",2)_" errors."
 Q
