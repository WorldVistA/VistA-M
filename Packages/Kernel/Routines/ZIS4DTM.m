%ZIS4 ;SFISC/GFT,RWF,MVB - DEVICE HANDLER SPOOL SPECIFIC CODE(DataTree Mumps) ;1/20/93  16:46
 ;;8.0;KERNEL;**23**;JUL 03, 1995
 ;
OPEN G OPN2:$D(IO(1,IO))
 S POP=0 D OP1 S:'POP IO(1,IO)="" G NOPEN:'$D(IO(1,IO))
OPN2 I $D(%ZISHP),'$D(IOP) W !,*7," Routing to device "_$P(^%ZIS(1,%E,0),"^",1)_$S($D(^(1)):" "_$P(^(1),"^",1)_" ",1:"")
 Q
NOPEN I %IS'["D",$D(%ZISHP)!(%ZISHG]"") S POP=1 Q
 I '$D(IOP) W *7,"  [BUSY]" W "  ...  RETRY" S %=2,U="^" D YN^%ZIS1 G OPEN:%=1
 S POP=1 Q
 Q
OP1 N X S X="OPNERR^%ZIS4",@^%ZOSF("TRAP")
 L:$D(%ZISLOC) +@%ZISLOCK:60
 O IO::%ZISTO S:'$T POP=1 L:$D(%ZISLOCK) -@%ZISLOCK Q
OPNERR S POP=1,IO("ERROR")=$ZE,IO("LASTERR")=$ZE Q
 ;
O ;D:$D(%ZISIOS) ZISLPC^%ZIS Q:'%ZISB  ;No longer called in Kernel v8.
OPRTPORT I $D(IO("S")),$D(^%ZIS(2,IO("S"),10)),^(10)]"" U IO(0) D X10^ZISX
OPAR I $D(IOP),%ZTYPE="HFS",$D(%IS("HFSIO")),$D(%IS("IOPAR")),%IS("HFSIO")]"" S IO=%IS("HFSIO"),%ZISOPAR=%IS("IOPAR")
 S %A=$S(%ZISOPAR]"":%ZISOPAR,%ZTYPE["TRM":"(WIDTH="_+%Z91_")",1:"")
 I %A=""&(%ZTYPE="HFS"!(%ZTYPE="SDP")!(%ZTYPE="SPL")) S POP=1 W:'$D(IOP) !,?5,"INVALID PARAMETERS",! Q
 S %A=%A_$S(%A["):":"",%ZTYPE["OTH"&($P(%ZTIME,"^",3)="n"):"",1:":"_%ZISTO),%A=""""_IO_""""_$E(":",%A]"")_%A
 D O1 I POP W:'$D(IOP) !,?5,*7,"[DEVICE IS BUSY]" Q
 S IO(1,IO)="" N DX,DY S (DX,DY)=0 U IO X:$D(^%ZOSF("XY"))&'(IO=IO(0)&'$D(ZTQUEUED)&'$D(IO("S"))) ^("XY") U:%IS'[0 IO(0) I %ZISUPAR]"" S %A1=""""_IO_""":"_%ZISUPAR U @%A1 U:%IS'[0 IO(0)
 G OXECUTE^%ZIS6
 ;
O1 N X S X="OPNERR^%ZIS4",@^%ZOSF("TRAP")
 L:$D(%ZISLOCK) +@%ZISLOCK:60
 O @%A S:'$T&(%A?.E1":".N) POP=1 L:$D(%ZISLOCK) -@%ZISLOCK Q
 ;
SPOOL ;%ZDA=pointer to ^XMB(3.51, %ZFN=spool file name.
 I $D(ZISDA) W:'$D(IOP) !?5,*7,"You may not Spool the printing of a Spool document" G N
 I $D(DUZ)[0 W:'$D(IOP) !,"Must be a valid user." G N
R S %ZY=-1 D NEWDOC^ZISPL1 G N:%ZY'>0
 S %ZDA=+%ZY,%ZFN=$P(%ZY(0),U,2),IO("DOC")=$P(%ZY(0),U,1)
 G OK:'%ZISB!$D(IO("Q"))
 I '$P(%ZY,"^",3),%ZFN]"" S %ZISMODE="R" D SPL G:%ZFN']"" N G DOC
 S %ZFN="SPL"_%ZDA_".TMP" S %ZISMODE="W" D SPL G:%ZFN']"" N
 S $P(^XMB(3.51,%ZDA,0),U,2)=%ZFN,^XMB(3.51,"C",%ZFN,%ZDA)=""
DOC S IO("SPOOL")=%ZDA,^XUTL("XQ",$J,"SPOOL")=%ZDA,IOF="#"
 I $D(^%ZIS(1,%ZISIOS,1)),$P(^(1),"^",8),$O(^("SPL",0)) S ^XUTL("XQ",$J,"ADSPL")=%ZISIOS,ZISPLAD=%ZISIOS
OK K %ZDA,%ZFN,%ZISMODE,%ZY Q
N K %ZDA,%ZFN,%ZISMODE,IO("DOC"),%ZY S POP=1 Q
 ;
SPL I IO]"" O IO:(%ZISMODE:%ZFN):0 S:$T IO(1,IO)=""
 E  D FREEDEV^%ZOSV1 G NOSPL:(IO=""),SPL
 Q
NOSPL W:'$D(IOP) !?5,*7,"Couldn't open the spool file." S %ZFN="" Q
 ;
CLOSE N %Z1 C:IO=IO(0)&(IO]"") IO K:IO=IO(0)&(IO]"") IO(1,IO) D FILE^ZISPL1 I %ZDA'>0 K ZISPLAD Q
 S %Z1=+$G(^XTV(8989.3,1,"SPL"))
 S %ZFN=$P(%ZS,"^",2) S %ZISMODE="R" D SPL Q:%ZFN']""  U IO S %ZCR=$C(13),%Y=""
 F %=0:0 R %X:5 Q:$ZIOS=3  S %2=%X D CL2
 C:IO]"" IO K:IO]"" IO(1,IO) D del^%dos(%ZFN):$P($ZVER,"/",2)'<4,CLOSE^ZISPL1
 K %Y,%X,%1,%ZISMODE,%ZFN
 Q
CL2 I %Z1<(%+1) S %=%+1,^XMBS(3.519,XS,2,%,0)="*** INCOMPLETE REPORT  -- SPOOL DOCUMENT LINE LIMIT EXCEEDED ***",$P(^XMB(3.51,%ZDA,0),"^",11)=1 Q
 I %2[$C(12) S %=%+1,^XMBS(3.519,XS,2,%,0)="|TOP|"
 S %=%+1,^XMBS(3.519,XS,2,%,0)=%2 Q
 ;
HFS G HFS^%ZISF
 ;
REWMT(IO,IOPAR) ;Rewind Magtape
 ;Unknown whether magtapes are supported
 Q 0
REWSDP(IO,IOPAR) ;Rewind SDP
 G REW1
REWHFS(IO,IOPAR) ;Rewind Host File
REW1 S X="HFSRWERR",@^%ZOSF("TRAP")
 U IO:(LFA=0)
 Q 1
REWERR ;Error encountered.
 Q 0
