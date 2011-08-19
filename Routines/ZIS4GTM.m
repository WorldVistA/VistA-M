%ZIS4 ;ISF/RWF,DW - DEVICE HANDLER SPECIFIC CODE (GT.M for Unix/VMS) ;05/29/2008
 ;;8.0;KERNEL;**275,425,440,499**;Jul 10, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified
OPEN ;From %ZIS3 for TRM
 G OPN2:$D(IO(1,IO))
 S POP=0 D OP1 G NOPEN:'$D(IO(1,IO))
OPN2 ;
 I $D(%ZISHP),'$D(IOP) W !,*7," Routing to device "_$P(^%ZIS(1,%E,0),"^",1)_$S($D(^(1)):" "_$P(^(1),"^",1)_" ",1:"")
 Q
NOPEN I %IS'["D",$D(%ZISHP)!(%ZISHG]"") S POP=1 Q
 I '$D(IOP) W *7,"  [BUSY]" W "  ...  RETRY" S %=2,U="^" D YN^%ZIS1 G OPEN:%=1
 S POP=1 Q
 Q
 ;Why no open paraneters???
OP1 N $ET S $ET="G OPNERR^%ZIS4"
 I $D(%ZISLOCK) L +@%ZISLOCK:5 E  S POP=1 Q
 O IO::%ZISTO S:$T IO(1,IO)="" S:'$T POP=1
 Q
OPNERR ;Open Error
 S POP=1,IO("LASTERR")=$G(IO("ERROR")),IO("ERROR")=$$EC^%ZOSV,$EC=""
 Q
 ;
O ;From %ZIS6 for all types.
 D:%IS["L" ZIO
 I $D(IO("S")),$D(^%ZIS(2,IO("S"),10)),^(10)]"" U IO(0) D X10^ZISX ;Open Printer Port
OPAR I $D(IOP),%ZTYPE="HFS",$D(%IS("HFSIO")),$D(%IS("IOPAR")),%IS("HFSIO")]"" S IO=%IS("HFSIO"),%ZISOPAR=%IS("IOPAR")
 I %ZTYPE="CHAN" D TCPIP Q:POP  G OXECUTE^%ZIS6
 S %A=%ZISOPAR_$S(%ZISOPAR["):":"",1:":"_%ZISTO)
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
O1 N $ES,$ET S $ET="G OPNERR^%ZIS4"
 I $D(%ZISLOCK) L +@%ZISLOCK:5 E  S POP=1 Q
 O @%A S:'$T&(%A?.E1":".N) POP=1 S:'POP IO(1,IO)=""
 S IO("ERROR")="" Q
 ;
 ;Need to find out how to get IP address
ZIO N %,%1 S (%,%1)=$ZIO
 I $ZV["VMS",%["_TNA" D
 . S (%,%1)=$ZGETDVI($I,"TT_ACCPORNAM")
 . S %=$S(%["Host:":$P($P(%,"Host: ",2)," ")_":"_$P(%,"Port: ",2),1:%) S:%[" " %=$TR(%," ")
 I $ZV'["VMS" D
 . S (%,%1)=$ZTRNLNM("REMOTEHOST") S:$L(%) %1="Host:"_% S:'$L(%) %=$ZIO
 . S:%1'["Host" %1=$ZTRNLNM("SSH_CLIENT") S:$L(%1) %1="Host:"_$P(%1," ")
 S IO("ZIO")=% S:(%1["Host:")&'$D(IO("IP")) IO("IP")=$P(%1,":",2)
 Q
 ;
TCPIP ;For TCP/IP devices, should use ^%ZISTCP
 N %S
 S %ZISTO=$G(%ZISTO,3)
 S %A="IO:"_$S($E(%ZISOPAR)="(":"",1:"(")_%ZISOPAR_$S($E(%ZISOPAR,$L(%ZISOPAR))=")":"",1:")")_":%ZISTO:""SOCKET"""
 ;U $P W !,"%A=",%A
 O @%A I '$T S POP=1 Q  ;D O1 ;Do the open.
 U IO:(WIDTH=512:NOWRAP:EXCEPT="G OPNERR^%ZIS4") S %S=$KEY
 U $P ;W !,"$KEY=",%S
 Q
 ;
SPOOL ;%ZDA=pointer to ^XMB(3.51, %ZFN=spool file name.
 I $D(ZISDA) W:'$D(IOP) !?5,*7,"You may not Spool the printing of a Spool document" G N
 I $D(DUZ)[0 W:'$D(IOP) !,"Must be a valid user." G N
R S %ZY=-1 D NEWDOC^ZISPL1 G N:%ZY'>0
 S %ZDA=+%ZY,%ZFN=$P(%ZY(0),U,2),IO("DOC")=$P(%ZY(0),U,1) G OK:$D(IO("Q"))
 G:'%ZISB OK I '$P(%ZY,"^",3),$L(%ZFN) O %ZFN:(append:nowrap):2 G DOC
 S %ZFN=IO_"SPOOL_no_"_%ZDA_".TMP" D SPL2 G:%ZFN']"" N S $P(^XMB(3.51,%ZDA,0),U,2)=%ZFN,^XMB(3.51,"C",%ZFN,%ZDA)=""
DOC S IO=%ZFN,IO("SPOOL")=%ZDA,^XUTL("XQ",$J,"SPOOL")=%ZDA,IOF="#"
 I $D(^%ZIS(1,%ZISIOS,1)),$P(^(1),"^",8),$O(^("SPL",0)) S ^XUTL("XQ",$J,"ADSPL")=%ZISIOS,ZISPLAD=%ZISIOS
OK K %ZDA,%ZFN Q
N K %ZDA,%ZFN,IO("DOC") S POP=1 Q
 ;
SPL2 ;Open for write
 O %ZFN:(newversion:noreadonly:nowrap:exception="G SPL4"):2 G:$ZA<0 SPL4 S IO(1,%ZFN)="" Q
 ;
SPL3 ;Open for Read
 O %ZFN:(readonly:exception="G SPL4"):2 S:'$T ZISPLQ=1 G:'$T SPL4 S IO(1,%ZFN)="" Q
SPL4 W:'$D(IOP)&'$D(ZTQUEUED) !?5,*7,"Couldn't open the spool file." S %ZFN="" Q
 ;
CLOSE ;Close out the spool
 N %,%1,%Z1,%ZFN,%ZS,%ZDA,XS,%Y,%X
 I $L(IO) C IO K IO(1,IO)
 D FILE^ZISPL1 I %ZDA'>0 K ZISPLAD Q
 S %ZFN=$P(%ZS,"^",2) D SPL3 Q:%ZFN']""  S %ZCR=$C(13),%Y=""
 S %Z1=+$G(^XTV(8989.3,1,"SPL")),%=0
 U %ZFN F  R %X#255:5 Q:$ZEOF  S %2=%X D CL2 Q:%Z1<%
SPLEX C %ZFN:(DELETE) K:%ZFN]"" IO(1,%ZFN) D CLOSE^ZISPL1 K %Y,%X,%1,%ZFN Q
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
REWSDP(IO,IOPAR) ;Rewind SDP
 G REW1
REWHFS(IO,IOPAR) ;Rewind Host File.
REW1 S X="REWERR^%ZIS4",@^%ZOSF("TRAP")
 U IO:(REWIND)
 Q 1
REWERR ;Error encountered
 Q 0
