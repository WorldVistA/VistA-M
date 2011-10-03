XQUTL ;SEA/Luke - Menu System Utilities ;04/27/98  12:36
 ;;8.0;KERNEL;**46**;Jul 10, 1995
 ;
CSYN(XQUSR) ;Collect XQUSR's menu synonyms in ^XUTL("XQ",$J,"SYN")
 N %,XQSYN
 S (XQI,XQSOP,%)=0
 S XQSOP=$O(^VA(200,XQUSR,203,XQSOP)) Q:XQSOP=""  I $L($P(^(XQSOP,0),U,2)) S X=^(0) D
 .S ^XUTL("XQ",XQUSR,"SYN",$P(X,U,2))=+X_"^"_$P(^DIC(19,+X,0),U,2)
 .;W !?5,$P(X,U,2),?10,^XUTL("XQ",XQUSR,"SYN",$P(X,U,2))
 .Q
 Q
 ;
 ;
PSYN(XQUSR) ;Print XQUSR's collected synonyms
 N %
 I '$D(^XUTL("XQ",XQUSR,"SYN")) D CSYN(XQUSR)
 I '$D(^XUTL("XQ",XQUSR,"SYN")) W !?5,$P(^VA(200,XQUSR,0),",",2)_" "_$P(^(0),",")," has no synonyms defined.",! Q
 S %="" F  S %=$O(^XUTL("XQ",XQUSR,"SYN",%)) Q:%=""  W !?5,%,?12,$P(^(%),U,2)
 Q
 ;
 ;
KSNY ;Kill off all ^XUTL("XQ",duz,"SYN") nodes
 N %
 S %=0 F  S %=$O(^XUTL("XQ",%)) Q:%=""  K ^(%,"SYN")
 Q
 ;
 ;
DISPLAY ;Display the XQUIT MESSAGE field of the Option File
 I '$D(XQD) S XQD=XQY
 I $D(^DIC(19,XQD,21)) D
 .S XQIEN=XQD_","
 .S %=$$GET1^DIQ(19,XQIEN,21,"","XQUT")
 .D PRINT(.XQUT)
 .K XQUT
 .Q
 Q
 ;
PRINT(XQUT) ;Print out the array XQUT()
 N %,XQLN,XQNL,XQSL
 ;
 I '$D(IOSL)#2 S IOP="HOME" D ^%ZIS
 I '$D(IOSL)!('$L(IOSL)) S IOSL=20
 S XQSL=IOSL-3
 ;
 I '$D(IOM)#2 S IOP="HOME" D ^%ZIS
 I '$D(IOM)!('$L(IOM)) S IOM=80
 ;
 ;Count the lines and remove the tabs
 S XQNL=0
 F %=0:1 S XQLINE=$O(XQUT(%)) Q:XQLINE=""  D
 .S XQNL=XQNL+1
 .I XQUT(XQLINE)["|TAB|" D
 ..N T,L,X S T="|TAB|",L=XQUT(XQLINE),X=""
 ..F  S X=$P(L,T)_"     "_$P(L,T,2,99) Q:X'[T
 ..S XQUT(XQLINE)=X
 ..Q
 .Q
 ;
RESTART ;Write the lines of text to the screen
 S XQLINE=0
 I $D(IOF) W @IOF
 F %=1:1:XQNL Q:$D(XQEXIT)  D
 .S XQLINE=XQLINE+1
 .S:$L(XQUT(%))>IOM XQLINE=XQLINE+1
 .W !,XQUT(%) I XQLINE'<XQSL D
 ..D PAUSE(.XQSL)
 ..S XQLINE=0
 ..I $D(IOF) W @IOF
 ..Q
 .Q
 ;
 I '$D(XQEXIT) D
 .I XQLINE<XQSL-1 D
 ..W !!,"**> END OF MESSAGE"
 ..D PAUSE(.XQSL)
 ..Q
 .E  D PAUSE(.XQSL)
 .Q
 ;
 I $D(XQREST) K XQEXIT,XQREST G RESTART
 K XQEXIT,XQREST
 Q
 ;
PAUSE(XQSL) ;Pause after a screen load and allow the adjustment of XQSL
 N XQUR
 ;W !!,"     *****> XQSL = ",XQSL,"    XQLN = ",XQNL
 R !!,"RETURN to continue, ""^"" to halt, ""B"" to backup, or ""?"" for more options: ",XQUR:DTIME S:'$T XQUR=U
 I $E(XQUR,1)="?" S XQH=785 D EN^XQH S (XQREST,XQEXIT)=1
 I XQUR]"","+-"[$E(XQUR,1) S XQSL=XQSL+XQUR S (XQREST,XQEXIT)=""
 I XQUR]"","bB"[$E(XQUR,1) S (XQREST,XQEXIT)=1
 I XQUR=U S XQEXIT=""
 Q
 ;
HOLD ;Just hold the screen from moving until a RETURN is typed
 N %
 I $D(IOM) S %=(IOM-42)/2 S:(%'>1) %=1
 E  S %=1
 R !!?%,"Hit the ""Enter"" or ""Return"" Key to Continue",%:DTIME
 W !
 Q
