%ZIS3 ;SFISC/AC,RWF -- DEVICE HANDLER(DEVICE TYPES & PARAMETERS) ;06/09/10  17:47
 ;;8.0;KERNEL;**18,36,69,104,391,440,499,546**;JUL 10, 1995;Build 9
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;Call with a Go from ^%ZIS2
 I %ZIS'["T",$G(^%ZIS(1,+%E,"POX"))]"" D XPOX^ZISX(%E) ;Pre-Open
 I $D(%ZISQUIT) S POP=1 K %ZISQUIT
 S %ZISCHK=1
 ;See if need to lock.
 K %ZISLOCK
 I %ZIS'["T",+$G(^%ZIS(1,+%E,"GBL")) S %ZISLOCK=$NA(^%ZIS("lock",IO))
 ;
 I 'POP G TRM:(%ZTYPE["TRM"),@(%ZTYPE_"^%ZIS6") ;Jump to next part
 ;
Q ;%ZIS6 Returns here
 ;See if need to un-lock.
 I $D(%ZISUOUT) K %ZISUOUT,%ZISHP,%ZISHPOP Q
 I POP S:%ZIS'["T" IO=""
 Q  ;Return to %ZIS1
 ;
VTRM ;Virtual terminal type
TRM ;Terminal type
 D MARGN:'POP,SETPAR:'POP ;Terminal type
 I 'POP,%ZIS'["T",%ZISB=1,'$D(IOP),IO'=IO(0),'$D(IO("Q")),%ZIS["Q" D AQUE
 D W("")
 I '$D(IO("Q")),'POP,%ZISB,%ZIS'["T" D O^%ZIS4
 G Q
DEVOK N X,Y,X1 ;Not sure this is needed
 S X=IO,X1=%ZTYPE
 D DEVOK^%ZOSV I Y=-99!(Y=0)!(Y=$J) Q
 I Y>0 S POP=1 D:(%ZIS["D") W($C(7)_"[Device Unavailable]") Q
 I Y=-1 S IO="",POP=1 D:(%ZIS["D") W($C(7)_"[Device does not Exist or Unavailable]") Q
 Q
 ;
MARGN ;Get the margin and page length
 S %A=$P(%Y,";",1)
 I %A?1A.ANP D SUBIEN(.%A,1) I $D(^%ZIS(2,%A,1)) K %Z91 D ST(1) S %Y=$P(%Y,";",2,9),%ZISMY=$P(%ZISMY,";",2,9) G MARGN
 I %A>3 S $P(%Z91,"^")=$S(%A>255:255,1:+%A)
 I $P(%Y,";",2) S $P(%Z91,"^",3)=+$S($P(%Y,";",2)>65534:65534,1:$P(%Y,";",2)) ;Cache fix for $Y#65535 wrap
 ;
ALTP I '$D(IO("P")) Q:%A>3  G ASKMAR:%ZTYPE["TRM" Q
 S %X=$F(IO("P"),"M") I %X S %A=+$E(IO("P"),%X,99),$P(%Z91,"^")=$S(%A>255:255,1:%A)
 S %X=$F(IO("P"),"L") I %X S $P(%Z91,"^",3)=+$E(IO("P"),%X,99)
 Q:%A>3!(%ZTYPE'["TRM")
ASKMAR I %ZIS["M",'$D(IOP),$S(%E=%H:+$P(%Z,"^",3),1:1),$P(%Z,"^",4) W "    Right Margin: " W:$P(%Z91,"^")]"" +%Z91,"// "
 E  Q
 D SBR^%ZIS1 I '$D(DTOUT)&'$D(DUOUT) S:%X=""&($P(%Z91,"^")]"") %X=+%Z91 G ASKMAR:%X'?1.N S $P(%Z91,"^")=$S(%X>255:255,1:%X) Q
 S POP=1 I %ZISB&(%ZTYPE["TRM") D C Q
 Q
 ;
W(%) ;Write text
 Q:$D(IOP)
 W !,%
 Q
 ;
C ;Close open device
 I IO'=$G(IO(0)),$D(IO(1,IO)) C IO K IO(1,IO)
 Q
 ;
SETPAR S:$L(%ZISOPAR)&($E(%ZISOPAR)'="(") %ZISOPAR="("_%ZISOPAR_")"
 Q
 ;
AQUE ;Ask about Queueing
 W ! S %=$S($D(IO("Q")):1,1:2)
 I $D(IO("Q")) W !,"Previously, you have selected queueing."
 W !,"Do you "_$S($D(IO("Q")):"STILL ",1:"")_"want your output QUEUED"
 D YN^%ZIS1 G AQUE:%=0 Q:$D(IO("Q"))
 I %=-1 S POP=1,%ZISHPOP=1,%ZISUOUT=1 D C Q
 I %=1 S IO("Q")=1 D C Q
 Q
 ;
ST(%ZISTP) ;
 S %ZISIOST(0)=%A,%ZISIOST=$P($G(^%ZIS(2,%A,0)),"^")
 S:'$D(%Z91) %Z91=$P($G(^%ZIS(2,%A,1),"132^#^60^$C(8)"),"^",1,4),$P(%Z91,"^",5)=$G(^("XY"))
 Q:%ZISTP
STP N %B ;%E is a pointer to the Device file
 S %B=$G(^%ZIS(1,%E,91))
 S:$P(%B,"^")]"" $P(%Z91,"^")=+%B S:$P(%B,"^",3)]"" $P(%Z91,"^",3)=$P(%B,"^",3) ;S $P(%Z91,"^",5)=$G(^%ZIS(2,%ZISIOST(0),"XY"))
 Q
SUBIEN(%1,%) ;Return Subtype ien. %1 is call by Ref.
 N %XX,%YY
 I $D(^%ZIS(2,"B",%1))>9 S %1=+$O(^%ZIS(2,"B",%1,0)) Q
 I '$G(%) S X="" Q
 S %XX=%1 D 2^%ZIS5 S %1=+%YY
 Q
SUBTYPE(%A) ;Called from %ZISH
 N %ZISIOST,%Z91
 S:$G(%A)="" %A="P-OTHER"
 D SUBIEN(.%A),ST(1)
 S IOM=$P(%Z91,U,1),IOF=$P(%Z91,U,2),IOSL=$P(%Z91,U,3),IOST=%ZISIOST,IOST(0)=%ZISIOST(0),IOBS="$C(8)"
 S:IOST="" IOST="P-OTHER",IOST(0)=0
 Q
