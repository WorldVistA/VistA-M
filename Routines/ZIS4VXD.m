%ZIS4 ;SFISC/AC,RWF,MVB - DEVICE HANDLER SPOOL SPECIFIC CODE(VAX DSM) ;10/11/2001  10:44
 ;;8.0;KERNEL;**23,36,49,59,69,191**;JUL 03, 1995
 ;
OPEN G OPN2:$D(IO(1,IO))
 S POP=0 D OP1 G NOPEN:'$D(IO(1,IO))
OPN2 I $D(%ZISHP),'$D(IOP) W !,*7," Routing to device "_$P(^%ZIS(1,%E,0),"^",1)_$S($D(^(1)):" "_$P(^(1),"^",1)_" ",1:"")
 Q
NOPEN I %IS'["D",$D(%ZISHP)!(%ZISHG]"") S POP=1 Q
 I '$D(IOP) W *7,"  [BUSY]" W "  ...  RETRY" S %=2,U="^" D YN^%ZIS1 G OPEN:%=1
 S POP=1 Q
 Q
OP1 S $ZT="OPNERR^%ZIS4",$ZE=""
 L:$D(%ZISLOCK) +@%ZISLOCK:60
 O IO::%ZISTO S:$T IO(1,IO)="" S:'$T POP=1 L:$D(%ZISLOCK) -@%ZISLOCK
 Q
OPNERR S POP=1,IO("LASTERR")=$G(IO("ERROR")),IO("ERROR")=$ZE,$EC="" Q
 ;
O D:%IS["L" ZIO
 ;D:$D(%ZISIOS) ZISLPC^%ZIS Q:'%ZISB  ;No longer called in Kernel v8.
LCKGBL ;Lock Global
 I %ZTYPE="CHAN" N % S %=$G(^%ZIS(1,+%E,"GBL")) I %]"" L @("+^"_%_":0") S:'$T POP=1 I POP W:'$D(IOP) !,?5,*7,"[DEVICE IS BUSY]" Q
 I $D(IO("S")),$D(^%ZIS(2,IO("S"),10)),^(10)]"" U IO(0) D X10^ZISX
OPAR I $D(IOP),%ZTYPE="HFS",$D(%IS("HFSIO")),$D(%IS("IOPAR")),%IS("HFSIO")]"" S IO=%IS("HFSIO"),%ZISOPAR=%IS("IOPAR")
 I %ZTYPE="CHAN",IO["::""TASK="!(IO["SYS$NET") D ODECNET Q:POP  G OXECUTE^%ZIS6
 S %A=%ZISOPAR_$S(%ZISOPAR["):":"",%ZTYPE["CHAN"&($P(%ZTIME,"^",3)="n"):"",1:":"_%ZISTO)
 N % S %(IO)="",%=$P($P($NA(%(IO)),"(",2),")")
 S %A=%_$E(":",%A]"")_%A
 D O1 I POP D  Q
 .I %ZTYPE="HFS",'$D(IOP),$G(IO("ERROR"))["file not found" W !,?5,*7,"[File Not Found]" Q
 .W:'$D(IOP) !,?5,*7,"[DEVICE IS BUSY]" Q
 ;S IO(1,IO)="" U IO S:'(IO=IO(0)&'$D(IO("S"))&'$D(ZTQUEUED)) $X=0,$Y=0 I %ZTYPE["TRM" U IO:(WIDTH=+%Z91)
 U IO S $X=0,$Y=0 I %ZTYPE["TRM" U IO:(WIDTH=+%Z91)
 I %ZISUPAR]"" S %A1=""""_IO_""":"_%ZISUPAR U @%A1
 ;U:%IS'[0 IO(0)
 G OXECUTE^%ZIS6
 ;
O1 S $ZT="OPNERR^%ZIS4"
 L:$D(%ZISLOCK) +@%ZISLOCK:60
 O @%A S:'$T&(%A?.E1":".N) POP=1 S:'POP IO(1,IO)="" L:$D(%ZISLOCK) -@%ZISLOCK
 S IO("ERROR")="" Q
 ;
ODECNET ;OPEN DECNET CHANNEL
 S $ZT="OPNERR^%ZIS4"
 L:$D(%ZISLOCK) +@%ZISLOCK:60 O IO L:$D(%ZISLOCK) -@%ZISLOCK
 S IO("ERROR")=""
 I IO="SYS$NET",$I="SYS$INPUT:;" S IO(0)=IO U IO Q
 Q
ZIO N % S %=$ZIO,%=$S(%["Host:":$P($P(%,"Host: ",2)," ")_":"_$P(%,"Port: ",2),1:%) S:%[" " %=$TR(%," ")
 S IO("ZIO")=% S:($ZIO["Host:")&'$D(IO("IP")) IO("IP")=$P(%,":")
 Q
 ;
SPOOL ;%ZDA=pointer to ^XMB(3.51, %ZFN=spool file name.
 I $D(ZISDA) W:'$D(IOP) !?5,*7,"You may not Spool the printing of a Spool document" G N
 I $D(DUZ)[0 W:'$D(IOP) !,"Must be a valid user." G N
R S %ZY=-1 D NEWDOC^ZISPL1 G N:%ZY'>0 S %ZDA=+%ZY,%ZFN=$P(%ZY(0),U,2),IO("DOC")=$P(%ZY(0),U,1) G OK:$D(IO("Q"))
 G:'%ZISB OK I '$P(%ZY,"^",3),%ZFN]"" D SPL3 G N:%ZFN']"",DOC
 S %ZFN=IO_"SPOOL_no_"_%ZDA_".TMP" D SPL2 G:%ZFN']"" N S $P(^XMB(3.51,%ZDA,0),U,2)=%ZFN,^XMB(3.51,"C",%ZFN,%ZDA)=""
DOC S IO=%ZFN,IO("SPOOL")=%ZDA,^XUTL("XQ",$J,"SPOOL")=%ZDA,IOF="#"
 I $D(^%ZIS(1,%ZISIOS,1)),$P(^(1),"^",8),$O(^("SPL",0)) S ^XUTL("XQ",$J,"ADSPL")=%ZISIOS,ZISPLAD=%ZISIOS
OK K %ZDA,%ZFN Q
N K %ZDA,%ZFN,IO("DOC") S POP=1 Q
 ;
SPL2 O %ZFN:(NEWVERSION:PROT=W:RWD) G:$ZA<0 SPL4 S IO(1,%ZFN)="" Q
 ;
SPL3 N $ETRAP S $ETRAP="S $EC="""" G SPL4^%ZIS4"
 O %ZFN:READONLY:1 S:'$T ZISPLQ=1 G:$ZA<0!('$T) SPL4 S IO(1,%ZFN)="" Q
 ;
SPL4 W:'$D(IOP)&'$D(ZTQUEUED) !?5,*7,"Couldn't open the spool file." S %ZFN="" Q
 ;
CLOSE N %Z1 C:IO]"" IO K:IO]"" IO(1,IO) D FILE^ZISPL1 I %ZDA'>0 K ZISPLAD Q
 S %ZFN=$P(%ZS,"^",2) D SPL3 Q:%ZFN']""  U %ZFN S %ZCR=$C(13),%Y="",$ZT="SPLEOF^%ZIS4"
 S %Z1=+$G(^XTV(8989.3,1,"SPL"))
 F %=0:0 R %X#255:5 Q:$ZA<0  S %2=%X D CL2 G:%Z1<% SPLEX
SPLEOF I $ZE'["ENDO" ZQ  ;Send error up
SPLEX C %ZFN:DELETE K:%ZFN]"" IO(1,%ZFN) D CLOSE^ZISPL1 K %Y,%X,%1,%ZFN Q
 ;
CL2 S %=%+1 I %Z1<% S ^XMBS(3.519,XS,2,%,0)="*** INCOMPLETE REPORT  -- SPOOL DOCUMENT LINE LIMIT EXCEEDED ***",$P(^XMB(3.51,%ZDA,0),"^",11)=1 Q
 I %2[$C(12) S ^XMBS(3.519,XS,2,%,0)="|TOP|" Q
 S ^XMBS(3.519,XS,2,%,0)=%2 Q
 ;
HFS G HFS^%ZISF
REWMT(IO,IOPAR) ;Rewind Magtape
 S X="REWERR^%ZIS4",@^%ZOSF("TRAP")
 U IO W *5
 Q 1
REWSDP(IO2,IOPAR) ;Rewind SDP
 G REW1
REWHFS(IO2,IOPAR) ;Rewind Host File.
REW1 ;N $ET S $ET="D REWERR^%ZIS4 Q 0"
 U IO2:DISCONNECT
 Q 1
REWERR ;Error encountered
 S IO("ERROR")=$EC,$EC=""
 Q
