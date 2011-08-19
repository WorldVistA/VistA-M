%ZISF ;SFISC/AC - HOST FILES FOR MVX. ;6/21/93  15:40
 ;;8.0T13;KERNEL;;Aug 1, 1994
HFS ;Host File Server
 Q:$D(IOP)&$D(%IS("HFSIO"))&$D(%IS("IOPAR"))
 I $D(%ZIS("HFSNAME")) S IO=%ZIS("HFSNAME"),%X=IO
 E  D ASKHFS
H S:$D(%ZIS("HFSMODE")) %ZISOPAR=$$MODE^%ZISF(%ZIS("HFSMODE"))
H1 I $D(IO("Q"))!(%IS["Z") S IO("HFSIO")=""
 S IO=$S(%X]"":%X,1:IO) S:$D(IO("HFSIO")) IO("HFSIO")=IO
 W:'$D(IOP)&$D(%ZIS("HFSNAME")) "    HOST FILE TO USE:  "_%ZIS("HFSNAME"),!
 D ASKPAR^%ZIS6,SETPAR^%ZIS3
HFSIOO I '$D(IOP),%ZTYPE="HFS",'$D(%ZIS("HFSMODE")),'$P(^%ZIS(1,%E,0),"^",4),%ZISOPAR="",$D(^%ZIS(1,%E,1)),$P(^(1),"^",6) W ?45,"INPUT/OUTPUT OPERATION: RW//"
 Q:'$T  D SBR^%ZIS1 I $D(DTOUT)!$D(DFOUT)!$D(DUOUT) S POP=1 Q
 D HOPT:%X="?"!("NRWS"'[%X),HOPT1:%X="??" G HFSIOO:%X="?"!("NRWS"'[%X)
 S:%X]"" %ZISOPAR="("""_%X_""")" Q
 ;
ASKHFS ;---Ask host file name here---
 I $D(%IS("B","HFS"))#2,%IS("B","HFS")]"" D
 .S IO=%IS("B","HFS") ;Set default host file name
 S %X='$P($G(^%ZIS(1,%E,1)),"^",5)
 S:'%X %X=""
 Q:$D(IOP)!%X!$D(%ZIS("HFSNAME"))
ASKAGN W !,"HOST FILE NAME: "_IO_"//" D SBR^%ZIS1
 I %X?1."?".E W !,"ENTER HOST FILE NAME" G ASKAGN
 S:$D(DTOUT)!$D(DUOUT) POP=1
 Q
MODE(Y) ;Return %ZISOPAR in Y.
 N X S X=Y
 S Y=$S(X="R":"R",X="W":"N",X="RW":"RW",X="A":"RW",1:"N")
 Q Y
HOPT W !,"You may enter a string of codes that represents",!,"the following host file input/ouput operation:"
 W !?16,"R = READ ACCESS",!?16,"W = WRITE ACCESS",!?16,"N = NEWVERSION",!?16,"S = STREAM FORMAT",! Q
HOPT1 S %ZISI=$O(^DIC(9.2,"B","XUHFSPARAM-MVX",0)) Q:'%ZISI  Q:'$D(^DIC(9.2,+%ZISI,0))  Q:$P(^(0),"^",1)'="XUHFSPARAM-MVX"
 Q:$D(^DIC(9.2,+%ZISI,1))'>9  F %X=0:0 S %X=$O(^DIC(9.2,+%ZISI,1,%X)) Q:%X'>0  I $D(^(%X,0)) W !,^(0)
 W ! S %X="??" Q
