XMC11 ;(WASH ISC)/THM-DECNET Communications Protocol Tools ;04/17/2002  07:51
 ;;8.0;MailMan;;Jun 28, 2002
 Q
 ;ENS and ENR are used by DECNET Communications Protocol in file 3.4
ENS ;Send
 I $G(XMINST) D XMTSTAT^XMTDR(XMINST,"S",XMSG)
 Q
ENR ;Receive
 I $G(XMINST) D XMTSTAT^XMTDR(XMINST,"R",XMRG)
 Q
 ;   *** THE FOLLOWING ARE NOT USED ***
IMM ;Immediate mode interpreter
 S XMC("SHOW TRAN")="RS"
 I $G(XMC("AUDIT")) K ^TMP("XMC",XMC("AUDIT")),XMC("AUDIT","I")
 F  R !!,"Script command: ",X:DTIME Q:X=""  D INT^XMC1(X,"you entered") U IO(0) W "  ",$S(ER:"Failed",1:"OK")
 Q
CHRS ;Christening operation
 N XMINST,XMSITE,DIC,X,Y,DIR
 I '$D(^XMB("NETNAME")) D  Q
 . W !!,$C(7),"This domain is not yet christened. It cannot christen others"
 . W !,"until initialized and christened by a parent domain."
 W !!,"This process will create a new subordinate domain to this domain"
 W !,"and update network relationships both there and here, as well as"
 W !,"inform this domain's parent."
 W !!,"Do you really want to do this? NO// "
 R X:DTIME Q:"Yy"'[$S($L(X):$E(X),1:1)
C W !!!,"Enter the name of the subordinate domain which you wish to christen"
 S DIC=4.2,DIC(0)="AEQMZ"
 D ^DIC Q:Y<0
 S XMINST=+Y,XMSITE=$P(Y,U,2)
 S XMC("CHRISTEN")=^XMB("NETNAME")_","_XMSITE
 S XM="D"
 D ENT^XMC1
 K XMC("CHRISTEN")
 Q
