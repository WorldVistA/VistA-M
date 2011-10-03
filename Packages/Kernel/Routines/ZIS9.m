%ZIS9 ;SLC/RWF - Collect screen paramiters ; 7/28/88  10:59 ;7/28/88  10:43 AM
 ;;6.13;Copyright 1989 by VA, ISC-SF
A S %ZIE=0 D CHKTYPE G Q:%ZIE
 S %Z0=IOST(0),U="^",IOSC(%Z0)=$P(^%ZIS(2,%Z0,0),U,1),IOSC(%Z0,"LF")="*10"
 S %Z=^(1) F %=1:1:5 S IOSC(%Z0,$P("IOM^IOF^IOSL^BS^XY",U,%))=$P(%Z,U,%)
 F %=2,3,4,10,11 S IOSC(%Z0,$P("^OPEN^CLOSE^ONLINE^^^^^^PPO^PPC",U,%))=$S($D(^(%)):^(%),1:"")
 S %Z=$S($D(^(5)):^(5),1:"") F %=1:1:9 S IOSC(%Z0,$P("10P^12P^HOME^RVON^RVOFF^EOL^EOP^BON^BOFF",U,%))=$P(%Z,U,%)
 S %Z=$S($D(^(6)):^(6),1:"") F %=1:1:7 S IOSC(%Z0,$P("RESET^HUP^HDWN^UON^UOFF^RLF^PROP",U,%))=$P(%Z,U,%)
 S %Z=$S($D(^(7)):^(7),1:"") F %=1,2,3 S IOSC(%Z0,$P("INHI^INLOW^INORM",U,%))=$P(%Z,U,%)
 S IOSC(%Z0,"16P")=$S($D(^(12.1)):^(12.1),1:"")
 F %=1,2 S IOSC(%Z0,$P("DHDW^SHSW",U,%))=$S($D(^(407+%)):^(407+%),1:"")
Q K %Z0,%,%ZIE Q
CHKTYPE G NOTYPE:$D(IOST(0))[0,NOTYPE:'IOST(0),NOTYPE:$D(^%ZIS(2,IOST(0),0))[0
 Q
NOTYPE S %ZIE=1 Q
GETYPE ;
 S %IS="N0" D ^%ZIS Q
