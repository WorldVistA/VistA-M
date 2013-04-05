%ZIS4 ;SFISC/RWF,AC - DEVICE HANDLER SPOOL SPECIFIC CODE (Cache) ;08/02/10  14:50
 ;;8.0;KERNEL;**34,59,69,191,278,293,440,499,524,546,543,584**;Jul 10, 1995;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
OPEN ;Called for TRM devices
 G OPN2:$D(IO(1,IO))
 S POP=0 D OP1 G NOPEN:'$D(IO(1,IO))
OPN2 ;
 I $D(%ZISHP),'$D(IOP) W !,$C(7)_" Routing to device "_$P(^%ZIS(1,%E,0),"^",1)_$S($D(^(1)):" "_$P(^(1),"^",1)_" ",1:"")
 Q
NOPEN ;
 I %ZIS'["D",$D(%ZISHP) S POP=1 Q
 I '$D(IOP) W $C(7)_"  [BUSY]" W "  ...  RETRY" S %=2,U="^" D YN^%ZIS1 G OPEN:%=1
 S POP=1 Q
 Q
OP1 N $ET S $ET="G OPNERR^%ZIS4"
 I $D(%ZISLOCK) L +@%ZISLOCK:5 E  S POP=1 Q
 O IO::%ZISTO S:$T IO(1,IO)="" S:'$T POP=1
 Q
OPNERR S POP=1,IO("LASTERR")=$G(IO("ERROR")),IO("ERROR")=$ZE,$EC=""
 Q
 ;
O ;Gets called for all devices
 N X,%A1
 D:%ZIS["L" ZIO
 I $D(IO("S")),$D(^%ZIS(2,IO("S"),10)),^(10)]"" U IO(0) D X10^ZISX ;Open Printer port
OPAR I $D(IOP),%ZTYPE="HFS",$D(%ZIS("HFSIO")),$D(%ZIS("IOPAR")),%ZIS("HFSIO")]"" S IO=%ZIS("HFSIO"),%ZISOPAR=%ZIS("IOPAR")
 S %A=$S($L(%ZISOPAR):%ZISOPAR,%ZTYPE'["TRM":"",$E(%ZISIOST,1)="C":"("_+%Z91_":""C"")",$E(%ZISIOST,1,2)="PK":"("_+%Z91_":""P"")",1:+%Z91)
 S %A=%A_$S(%A["):":"",%ZTYPE["OTH"&($P(%ZTIME,"^",3)="n"):"",1:":"_%ZISTO),%A=""""_IO_""""_$E(":",%A]"")_%A
 D O1 I POP W:'$D(IOP) !,?5,$C(7)_"[Device is BUSY]" Q
 U IO S $X=0,$Y=0
 I $L(%ZISUPAR) S %A1=""""_IO_""":"_%ZISUPAR U @%A1
 G OXECUTE^%ZIS6
 ;
O1 N $ET S $ET="G OPNERR^%ZIS4"
 I $D(%ZISLOCK) L +@%ZISLOCK:5 E  S POP=1 Q
 O @%A S:'$T&(%A?.E1":".N) POP=1 S:'POP IO(1,IO)=""
 S IO("ERROR")=""
 Q
 ;Version 3 used ip/port, Version 4 has ip:port|xx
ZIO I $D(IO("IP")),$D(IO("ZIO")) Q  ;p499,p524
 N %,%1 S %=$ZIO,%1=$$VERSION^%ZOSV
 S IO("ZIO")=$S(%1<4:$I,1:$ZIO),%1=$S(%["/":"/",1:":")
 ;Drop prefix
 S:%["|TNT|" %=$E(%,6,999) S:%["|TNA|" %=$E(%,6,999)
 ;Get IP name or number
 S:$P(%,%1)["." IO("IP")=$P(%,%1)
 I $$OS^%ZOSV="VMS",$G(IO("IP"))="" S IO("IP")=$P($ZF("TRNLNM","SYS$REM_NODE"),":") ;For SSH, p499
 I $$OS^%ZOSV="UNIX",$G(IO("IP"))="" S IO("IP")=$P($SYSTEM.Util.GetEnviron("SSH_CLIENT")," ") ;For SSH, p543
 S:'$L(IO("ZIO")) IO("ZIO")=$G(IO("IP"))
 ;If have FQDN keep it in IO("CLNM") and get IP.
 ;I $L($G(IO("IP"))),IO("IP")'?1.3N1P1.3N1P1.3N1P1.3N S:'$D(IO("CLNM")) IO("CLNM")=IO("IP") S IO("IP")=$P($ZU(54,13,IO("IP")),",") ;p499,p546
 I $L($G(IO("IP"))),IO("IP")'?1.3N1P1.3N1P1.3N1P1.3N S:'$D(IO("CLNM")) IO("CLNM")=IO("IP") S IO("IP")=$P(##class(%Library.Function).IPAddresses(IO("IP")),",") ;Cache2010
 Q
 ;
SPOOL ;%ZDA=pointer to ^XMB(3.51, %ZFN=spool file Num/Name.
 N %ZOS S %ZOS=$$OS^%ZOSV
 I '$D(^XMB(3.51,0)) W:'$D(IOP) !?5,"The spooler files are not setup in this account." G NO
 I $D(ZISDA) W:'$D(IOP) !?5,$C(7)_"You may not Spool the printing of a Spool document" G NO
 I $D(DUZ)[0 W:'$D(IOP) !,"Must be a valid user." G NO
 ;Get entry in Spool Doc file
R S %ZY=-1 D NEWDOC^ZISPL1:$D(DUZ)=11 G NO:%ZY'>0 S %ZDA=+%ZY,%ZFN=$P(%ZY(0),U,2),IO("DOC")=$P(%ZY(0),U,1) G OK:$D(IO("Q"))
 G:'%ZISB OK I '$P(%ZY,"^",3),%ZFN]"" D SPL3 G NO:%ZFN<0,DOC
 I %ZOS="NT" D  G:%ZFN>255 NO
 . F %ZFN=1:1:260 I '$D(^XMB(3.51,"C",%ZFN))!$D(^(%ZFN,%ZDA)) Q:%ZFN<256  W:'$D(IOP) $C(7)_"  DELETE SOME OTHER DOCUMENT!" Q
 . Q:%ZFN>255  D SPL2 S $P(^XMB(3.51,%ZDA,0),U,2)=%ZFN,^XMB(3.51,"C",%ZFN,%ZDA)=""
 I %ZOS'="NT" D  G:%ZFN=-1 NO ;For VMS & UNIT p546
 . S %ZFN=IO_"SPOOL_no_"_%ZDA_".TMP" D SPL2 Q:%ZFN=-1  S $P(^XMB(3.51,%ZDA,0),U,2)=%ZFN,^XMB(3.51,"C",%ZFN,%ZDA)="",IO=%ZFN
DOC S IO("SPOOL")=%ZDA,^XUTL("XQ",$J,"SPOOL")=%ZDA
 I $D(^%ZIS(1,%ZISIOS,1)),$P(^(1),"^",8),$O(^("SPL",0)) S ^XUTL("XQ",$J,"ADSPL")=%ZISIOS,ZISPLAD=%ZISIOS
OK K %ZDA,%ZFN Q
NO K %ZDA,%ZFN,IO("DOC") S POP=1 Q
 ;
SPL2 ;Open for output
 I %ZOS="NT" O IO:(%ZFN:0) S IO(1,IO)="",^SPOOL(0,IO("DOC"),%ZFN)="",^SPOOL(%ZFN,0)=IO("DOC")_"{"_$H Q
 ;VMS
 O %ZFN:("WNS"):2 G:'$T SPL4 S IO(1,%ZFN)="" Q
 ;
SPL3 ;Open to read
 I %ZOS="NT" G SPL4:'$D(^SPOOL(%ZFN,2147483647)) O IO:(%ZFN:$P(^(2147483647),"{",3)):1 S:'$T ZISPLQ=1 K ^(2147483647) S IO(1,IO)="" Q
 ;VMS
 N $ETRAP S $ETRAP="S $EC="""" G SPL4^%ZIS4"
 O %ZFN:"R":1 S:'$T ZISPLQ=1 G:$ZA<0!('$T) SPL4 S IO(1,%ZFN)="" Q
 ;
SPL4 W:'$D(IOP) !,"Spool file already open" S %ZFN=-1 Q
 ;
CLOSE ;Handle Close and copy to Global
 N %,%ZOS,%Z1,%ZCR,%2,%3,%X,%Y,ZTSK,%ZFN S %ZOS=$$OS^%ZOSV
 I %ZOS="NT",IO=2,$D(IO(1,IO)) K IO(1,IO) C IO
 I %ZOS="VMS",$L(IO),$D(IO(1,IO)) U IO S %ZFN=$ZIO C IO K IO(1,IO)
 I %ZOS="UNIX",$L(IO),$D(IO(1,IO)) C IO K IO(1,IO)
 ;See that ZTSK is set so we will move to the global now.
 S ZTSK=$G(ZTSK,1) D FILE^ZISPL1 I %ZDA'>0 K ZISPLAD Q
 G:%ZOS'="NT" CLVMS ;p546
 S %ZFN=$P(%ZS,"^",2),%ZCR=$C(13),%Y="",%=0,%3=$P(^SPOOL(%ZFN,2147483647),"{",3)
 S %Z1=+$G(^XTV(8989.3,1,"SPL"))
 F %2=1:1:%3 Q:'$D(^SPOOL(%ZFN,%2))  S %X=^SPOOL(%ZFN,%2) D
 . I %Z1<% D LIMIT S %2=%3 Q
 . I %X[$C(13,12) D:$L($P(%X,$C(13))) ADD($P(%X,$C(13))) D ADD("|TOP|") Q
 . D ADD($P(%X,$C(13),1))
 K ^SPOOL(%ZFN),^SPOOL(0,$P(%ZS,U,1)),%Y,%X,%1,%2,%3 D CLOSE^ZISPL1
 Q
ADD(L) S %=%+1,^XMBS(3.519,XS,2,%,0)=L
 Q
LIMIT D ADD("*** INCOMPLETE REPORT  -- SPOOL DOCUMENT LINE LIMIT EXCEEDED ***") S $P(^XMB(3.51,%ZDA,0),"^",11)=1
 Q
CLVMS ;Close for Cache VMS & Linux
 N $ES,$ET S $ET="D:$EC'[""ENDOF"" ^%ZTER,UNWIND^%ZTER S $EC="""" D SPLEX^%ZIS4,UNWIND^%ZTER"
 ;Check Cache version, if 2008 use $ZU, else use system object
 I '$G(XUOSVER) N XUOSVER S XUOSVER=$$VERSION^%ZOSV
 S %ZA=$S(XUOSVER<2010:$ZU(68,40,1),1:##class(%SYSTEM.Process).SetZEOF(1)) ;Handle EOF like DSM
 ;%ZFN Could be set at the top
 S %ZFN=$S($G(%ZFN)]"":%ZFN,1:$P(%ZS,"^",2)) D SPL3 Q:%ZFN']""  U %ZFN S %ZCR=$C(13),%Y=""
 S %Z1=+$G(^XTV(8989.3,1,"SPL")),%=0
 F  R %X#255:5 Q:$ZEOF<0  D  G:%Z1<% SPLEX
 . I %Z1<% D LIMIT Q
 . I %X[$C(12) D  Q
 . . S %Y=$P(%X,$C(12)) D:$L(%Y) ADD(%Y),ADD("|TOP|")
 . . S %Y=$P(%X,$C(12),2) D:$L(%Y) ADD(%Y)
 . . Q
 . D ADD(%X)
 . Q
SPLEX C %ZFN:"D" K:%ZFN]"" IO(1,%ZFN) D CLOSE^ZISPL1 K %Y,%X,%1,%ZFN Q
 ;
 ;
HFS G HFS^%ZISF
REWMT(IO2,IOPAR) ;Rewind Magtape
 N $ETRAP S $ET="G REWERR^%ZIS4"
 U IO2 W *5
 Q 1
REWSDP(IO2,IOPAR) ;Rewind SDP
 G REW1
REWHFS(IO2,IOPAR) ;Rewind Host File.
REW1 ;ZIS set % to the current $I so need to update % if = IO
 N NIO,OP,$ETRAP
 S $ET="G REWERR^%ZIS4"
 C IO2 ;You do a rewind to read the file.
 S OP=$S($ZV["VMS":"RV",1:"RS")
 O IO2:(OP):1 S IO(1,IO2)=""
 Q 1
REWERR ;Error encountered
 S IO("ERROR")=$EC,$ECODE=""
 Q 0
