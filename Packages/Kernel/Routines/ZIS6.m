%ZIS6 ;SFISC/AC - DEVICE HANDLER -- RESOURCES ;10/14/2011
 ;;8.0;KERNEL;**24,49,69,118,127,136,440,546,585**;JUL 10, 1995;Build 22
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;Expect that IO is current device
OXECUTE ;Open Execute
 I $D(^%ZIS(2,%ZISIOST(0),2))=1 S %Y=^(2) D 2
ANSBAK ;Answer Back
 I $D(^%ZIS(2,%ZISIOST(0),102)) S %Y=^(102) D 2 E  S POP=1 D:'$D(IOP) SAY($C(7)_"[NOT ON LINE]") C:%ZISB IO K IO(1,IO) G QUIT
 I $D(%ZISMTR) X ^%ZOSF("MAGTAPE") U IO W:$D(%MT("REW")) @%MT("REW") U IO(0) K %MT
 G QUIT:'$D(IO("P"))
 I $F(IO("P"),"B"),$D(^%ZIS(2,%ZISIOST(0),7)) S %Y=$P(^(7),"^",1) I %Y]"" W @%Y
 S %Y=$F(IO("P"),"P") G QLTY:'%Y S %Y=+$E(IO("P"),%Y,99),%X=$S(%Y=16:12.1,%Y=10!(%Y=12):5,1:"") G QLTY:'%X
 S %Y=$S($D(^%ZIS(2,%ZISIOST(0),%X)):$P(^(%X),"^",$S(%Y=12:2,1:1)),1:"")
 I %Y]"" W @%Y
QLTY S %Y=$F(IO("P"),"Q") Q:'%Y  S %Y=+$E(IO("P"),%Y,99),%X=$S(%Y<0!(%Y>2):0,1:%Y+1)
 I %X S %Y=$S($D(^%ZIS(2,%ZISIOST(0),12.2)):$P(^(12.2),"^",%X),1:"") I %Y]""  W @%Y
QUIT U:%ZIS'[0 IO(0)
 Q
2 ;Do Execute code
 Q:%Y=""  I %ZIS'[0,$D(^%ZIS(1,+%H,"TYPE")),^("TYPE")["TRM" D OH Q:POP
 S %X=$T U IO D %Y^ZISX
 Q
OH ;Open Home
 Q:$S($L($G(IO(0))):$D(IO(1,IO(0))),1:0)
 N $ES,$ET S $ET="G OPNERR^%ZIS4"
 O IO(0)::0 S IO(1,IO(0))="" ;See that HOME DEVICE is open.
 Q
 ;
SAY(%SAY) ;
 Q:%ZIS[0  U IO(0) W %SAY U IO
 Q
RES1 ;Allocate a resource slot, Release in %ZISC.
 N A,L,X,%ZISD0
 S %ZISD0=$O(^%ZISL(3.54,"B",IO,0))
 I '%ZISD0 S %ZISD0=$$RADD(IO) ;New one
 L +^%ZISL(3.54,%ZISD0,0):2 I '$T S POP=1 W:'$D(IOP) *7,"  [NOT Available]" G RESX
RES2 S X=$P(^%ZISL(3.54,%ZISD0,0),"^",2)
 I X<1 S POP=1 W:'$D(IOP) *7,"  [NOT Available]" G RESX
 S X=$S(X>0:X-1,1:0),$P(^%ZISL(3.54,%ZISD0,0),"^",2)=X
 ;
R1 ;Grab a slot
 S IO(1,IO)="RES",A=$G(^%ZISL(3.54,%ZISD0,1,0),"^3.542^^")
 F L=1:1:%ZISRL I '$D(^%ZISL(3.54,%ZISD0,1,L,0)) Q
 I '$T K IO(1,IO) G RES2 ;No free slots
 S ^%ZISL(3.54,%ZISD0,1,L,0)=L_"^"_%ZISV_"^"_$J_"^"_$G(ZTSK)_"^"_$H,^%ZISL(3.54,"AJ",$J,%ZISD0,L)="",^%ZISL(3.54,%ZISD0,1,"B",L,L)=""
 S $P(A,"^",3,4)=L_U_($P(A,U,4)+1),^%ZISL(3.54,%ZISD0,1,0)=A
RESX L -^%ZISL(3.54,%ZISD0,0) Q
 ;
RADD(X) ;Add Resource
 N %1,%2
 S %1=$G(^%ZISL(3.54,0),"RESOURCE^3.54^^"),%2=$P(%1,U,3)
 F %2=%2:1 Q:'$D(^%ZISL(3.54,%2,0))
 S $P(^%ZISL(3.54,0),U,3,4)=%2_U_($P(%1,U,4)+1),^%ZISL(3.54,%2,0)=X_"^"_$G(%ZISRL,1),^%ZISL(3.54,"B",X,%2)=""
 Q %2
 ;
RESOK ;DEVOK check for RES devices, for all OS's.
 N %ZISD0,%ZISD1
 S Y=0,%ZISD0=$O(^%ZISL(3.54,"B",X,0))
 I '%ZISD0 S Y=-1,%ZISD0=$O(^%ZIS(1,"C",X,0)) Q:'%ZISD0  Q:'$D(^%ZIS(1,+%ZISD0,0))  Q:$P(^(0),"^")'=X  Q:'$D(^("TYPE"))  Q:^("TYPE")'="RES"  S Y=0 Q
 S X1=$G(^%ZISL(3.54,+%ZISD0,0))
 I $P(X1,"^",2)&(X=$P(X1,"^")) S Y=0 Q
 S Y=999 F %ZISD1=0:0 S %ZISD1=$O(^%ZISL(3.54,%ZISD0,1,%ZISD1)) Q:%ZISD1'>0  I $D(^(%ZISD1,0)) S Y=$P(^(0),"^",3) Q
 Q
 ;
Q G Q^%ZIS3
HG ;Was Hunt Group
 Q
SPL ;Spool type
 N %E,%Z D MARGN^%ZIS3 W:'$D(IOP) ! D SPOOL^%ZIS4:%ZIS'["T"
 G Q
MT D MARGN^%ZIS3,ASKPAR,AMTREW:'POP&'$D(IOP)&%ZISB W:'$D(IOP) ! D O^%ZIS4:'POP&(%ZISB&(%ZIS'["T")) ;Magtape type
 G Q
SDP ;Sequential disk processor type
 D MARGN^%ZIS3,ASKPAR W:'$D(IOP) ! D O^%ZIS4:'POP&(%ZISB&(%ZIS'["T"))
 G Q
HFS ;Host File Server type
 D MARGN^%ZIS3,HFS^%ZISF W:'$D(IOP) ! D O^%ZIS4:'POP&(%ZISB&(%ZIS'["T"))
 G Q
 ;
 ;**P585 START CJM
PQ ;Print Queue type
 D MARGN^%ZIS3,OPEN^ZISPQ
 G Q^%ZIS3
 Q
 ;**585 END CJM
 ;
RES ;Resources
 G Q:%ZIS["T" N X,X1 I %ZIS'["R"!'$D(IOP) S POP=1 W:'$D(IOP) *7,"  [NOT AVAILABLE]" Q
 G Q:$D(IO(1,IO)) I %ZIS["T" S X=IO,X1="RES" D DEVOK^%ZIS3 S:Y POP=1 G Q:POP
 D:%ZISB RES1 G Q
CHAN ;Network Channel type devices -- DecNet or TCP/IP devices.
 I IO="SYS$NET",$I="SYS$INPUT:;" S IO(0)=IO U IO ;DECNET Server Device
 D MARGN^%ZIS3:'POP,ASKPAR:'POP W:'$D(IOP) ! D O^%ZIS4:'POP&(%ZISB&(%ZIS'["T"))
 G Q
IMPC ;Imaging Work Station
BAR ;Bar Code
OTH ;Other Device type
 D MARGN^%ZIS3:'POP,ASKPAR:'POP W:'$D(IOP) ! D O^%ZIS4:'POP&(%ZISB&(%ZIS'["T"))
 G Q
 ;
ASKPAR ;Ask Parameters
 G SETPAR^%ZIS3:$D(IOP),SETPAR^%ZIS3:'$P(^%ZIS(1,%E,0),"^",4) W "  ADDRESS/PARAMETERS: " W:%ZISOPAR]"" %ZISOPAR_"// " D SBR^%ZIS1 D MSG1:%X="?" G ASKPAR:%X="?" S:%X]"" %ZISOPAR=%X I $D(DTOUT)!$D(DUOUT) S POP=1
 I POP,%ZISB&(%ZTYPE["TRM") C IO K IO(1,IO) Q
 Q:POP  G SETPAR^%ZIS3
 ;
AMTREW ;Mag Tape Rewind
 I %ZISB,%ZTYPE="MT",'$D(IOP) W "  REWIND" S %=2,U="^",%ZISDTIM=60 D YN^%ZIS1 K %ZISDTIM G AMTREW:%=0 I %=-1 S POP=1 Q
 S:%=1 %ZISMTR=1
 Q
MSG1 W !?5,"Enter the desired parameters needed to open the selected device.",!?25
 Q
 ;
