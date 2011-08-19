%ZIS4 ;SFISC/GFT,RWF,AC - DEVICE HANDLER SPOOL SPECIFIC CODE (M/SQL) ;4/8/92  13:51
 ;;8.0;KERNEL;**23**;JUL 03, 1995
 ;
OPEN G OPN2:$D(IO(1,IO)) I %IS["T" L +^%ZTSCH("DEV",IO):0 G NOPEN:'$T,NOPEN:$D(^%ZTSCH("DEV",IO))#2,NOPEN:$D(^%ZTSCH("IO",IO))
 S POP=0 D OP1 S:'POP IO(1,IO)="" G NOPEN:'$D(IO(1,IO)) I %IS["T" S ^%ZTSCH("DEV",IO)=$H L -^%ZTSCH("DEV",IO)
OPN2 I $D(%ZISHP),'$D(IOP) W !,*7," Routing to device "_$P(^%ZIS(1,%E,0),"^",1)_$S($D(^(1)):" "_$P(^(1),"^",1)_" ",1:"")
 Q
NOPEN L:%IS["T" -^%ZTSCH("DEV",IO) I %IS'["D",$D(%ZISHP)!(%ZISHG]"") S POP=1 Q
 I '$D(IOP) W *7,"  [BUSY]" W "  ...  RETRY" S %=2,U="^" D YN^%ZIS1 G OPEN:%=1
 K:%E'=%H ^XUTL("ZISPARAM",IO)
 S POP=1 Q
 Q
OP1 N X S X="OPNERR^%ZIS4",@^%ZOSF("TRAP")
 L:$D(%ZISLOCK) +@%ZISLOCK:60
 O IO::%ZISTO S:'$T POP=1 L:$D(%ZISLOCK) -@%ZISLOCK Q
OPNERR S POP=1,IO("ERROR")=$ZE,IO("LASTERR")=$ZE Q
 ;
O ;D:$D(%ZISIOS) ZISLPC^%ZIS Q:'%ZISB  ;No longer called in Kernel v8.
OPRTPORT I $D(IO("S")),$D(^%ZIS(2,IO("S"),10)),^(10)]"" U IO(0) D X10^ZISX
OPAR I $D(IOP),%ZTYPE="HFS",$D(%IS("HFSIO")),$D(%IS("IOPAR")),%IS("HFSIO")]"" S IO=%IS("HFSIO"),%ZISOPAR=%IS("IOPAR")
 S %A=$S(%ZISOPAR]"":%ZISOPAR,%ZTYPE'["TRM":"",%ZISIOST?1"C".E:"("_+%Z91_":""C"")",%ZISIOST?1"PK".E:"("_+%Z91_":""P"")",1:+%Z91)
 S %A=%A_$S(%A["):":"",%ZTYPE["OTH"&($P(%ZTIME,"^",3)="n"):"",1:":"_%ZISTO),%A=""""_IO_""""_$E(":",%A]"")_%A
 D O1 I POP W:'$D(IOP) !,?5,*7,"[DEVICE IS BUSY]" Q
 S IO(1,IO)="" N DX,DY S (DX,DY)=0 U IO X:$D(^%ZOSF("XY"))&'(IO=IO(0)&'$D(ZTQUEUED)) ^("XY") U:%IS'[0 IO(0) I %ZISUPAR]"" S %A1=""""_IO_""":"_%ZISUPAR U @%A1 U:%IS'[0 IO(0)
 G OXECUTE^%ZIS6
 ;
O1 N X S X="OPNERR^%ZIS4",@^%ZOSF("TRAP")
 L:$D(%ZISLOCK) +@%ZISLOCK:60
 O @%A S:'$T&(%A?.E1":".N) POP=1 L:$D(%ZISLOCK) -@%ZISLOCK Q
 ;
SPOOL ;%ZDA=pointer to ^XMB(3.51, %ZFN=spool file num.
 I '$D(^XMB(3.51,0)) W:'$D(IOP) !?5,"The spooler files are not setup in this account." G N
 I $D(ZISDA) W:'$D(IOP) !?5,*7,"You may not Spool the printing of a Spool document" G N
R S %ZY=-1 D NEWDOC^ZISPL1:$D(DUZ)=11 G N:%ZY'>0 S %ZDA=+%ZY,%ZFN=$P(%ZY(0),U,2),IO("DOC")=$P(%ZY(0),U,1) G OK:$D(IO("Q"))
 G:'%ZISB OK I '$P(Y,"^",3),%ZFN D SPL3 G N:%ZFN<0,DOC
 F %ZFN=1:1 I '$D(^XMB(3.51,"C",%ZFN))!$D(^(%ZFN,%ZDA)) Q:%ZFN<256  W:'$D(IOP) *7,"  DELETE SOME OTHER DOCUMENT!" G N
 D SPL2 S $P(^XMB(3.51,%ZDA,0),U,2)=%ZFN,^XMB(3.51,"C",%ZFN,%ZDA)=""
DOC S IO("SPOOL")=%ZDA,^XUTL("XQ",$J,"SPOOL")=%ZDA
 I $D(^%ZIS(1,%ZISIOS,1)),$P(^(1),"^",8),$O(^("SPL",0)) S ^XUTL("XQ",$J,"ADSPL")=%ZISIOS,ZISPLAD=%ZISIOS
OK K %ZDA,%ZFN Q
N K %ZDA,%ZFN,IO("DOC") S POP=1 Q
SPL2 O IO:(%ZFN:0) S IO(1,IO)="",^SPOOL(0,IO("DOC"),%ZFN)="",^SPOOL(%ZFN,0)=IO("DOC")_"{"_$H Q
SPL3 G SPL4:'$D(^SPOOL(%ZFN,2147483647)) O IO:(%ZFN:$P(^(2147483647),"{",3)) K ^(2147483647) S IO(1,IO)="" Q
SPL4 W:'$D(IOP) !,"Spool file already open" S %ZFN=-1 Q
CLOSE N %Z1 C:IO=IO(0) IO K:IO=IO(0) IO(1,IO) D FILE^ZISPL1 I %ZDA'>0 K ZISPLAD Q
 S %ZFN=$P(%ZS,"^",2),%ZCR=$C(13),%Y="",%=0,%3=$P(^SPOOL(%ZFN,2147483647),"{",3)-1
 S %Z1=+$G(^XTV(8989.3,1,"SPL"))
 F %2=1:1:%3 S %X=^SPOOL(%ZFN,%2),%=%+1 D LIMIT:%Z1<% Q:%Z1<%  S ^XMBS(3.519,XS,2,%,0)=$S($C(13,10)[%X:"",%X[$C(12):"|TOP|",1:$P(%X,$C(13),1))
 K ^SPOOL(%ZFN),^SPOOL(0,$P(%ZS,U,1)),%Y,%X,%1,%2,%3 D CLOSE^ZISPL1
 Q
LIMIT S ^XMBS(3.519,XS,2,%,0)="*** INCOMPLETE REPORT  -- SPOOL DOCUMENT LINE LIMIT EXCEEDED ***",$P(^XMB(3.51,%ZDA,0),"^",11)=1 Q
HFS G HFS^%ZISF
