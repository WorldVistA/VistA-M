XMA21C ;(WASH ISC)/CAP- Input Transform (3.7,.3) Mail Name ;04/17/2002  07:14
 ;;8.0;MailMan;;Jun 28, 2002
 ;
 ;Input transform for field .3 in file 3.7 (Mail Name)
MNAME ;Change to all upper case
 I '$D(XMDUZ) N XMDUZ S XMDUZ=DUZ
 S X=$$UP^XLFSTR(X)
 I $L(X)<7!($L(X)>30) S %="Name cannot be "_$S($L(X)<7:"LESS THAN 7",1:"GREATER THAN 30")_" characters long." G QQ
 I X'?1.AN1"."1.AN1".".E,X'?1.AN,X'?1.AN1"."1.AN S %="Name must not contain punctuation other than a '.' and a maximum of two '.'s." G QQ
 ;
 L +^XMB(3.7,"C",X):1 E  Q:$D(ZTQUEUED)!$D(XMCHAN)  S %="Please try again, Some one else is enterring a mail name." G QQ
 ;
 ;Check if unique / inform user...
 I $D(^XMB(3.7,"C",X)) S %=$C(7)_"  >> Already in use" G QQ
 N % S %=$O(^XMB(3.7,"C",X)) I $E(%,1,$L(X))=X S %=$C(7)_"  >> This name is not unique -- it is a partial match to another name" G QQ
 ;
 ;Test if Name Server can find it elsewhere
 K XMY N XMA21C S XMA21C=X D WHO^XMA21 I $L($O(XMY(""))) S %="The string '"_XMA21C_"' identifies someone else." K XMY G QQ
 ;
 ;Put into x-ref so it cannot be used immediately
 S ^XMB(3.7,"C",X,XMDUZ)=""
 ;
 G Q
QQ D Q K X Q:$D(ZTQUEUED)!$D(XMCHAN)  W !!,$C(7),%,!! Q
Q L -^XMB(3.7,"C",X) Q
 ;
 ;EXECUTABLE HELP
HELP W !!,"Mail names are used as return addresses when you send a message to someone"
 W !,"whose mail box is in a different mail environment.  It could be different"
 W !,"machines in the same facility, an entirely separate facility or simply a"
 W !,"different configuration (or UCI) on the same machine."
 W !!,"The valid format for a mail name is one that is acceptable to all"
 W !,"mail systems.  It is therefore between 7 and 30 characters long, and"
 W !,"contains no punction other than periods.  It may contain up to two (2)"
 W !,"periods each of which must be preceeded and succeeded with at least"
 W !,"one alpha or numeric character."
 Q
