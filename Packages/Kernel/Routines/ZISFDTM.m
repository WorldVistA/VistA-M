%ZISF ;SFISC/AC -- HOST FILES (DataTree) ;6/21/93  15:36
 ;;8.0;KERNEL;;JUL 10, 1995
 ;
HFS Q:$D(IOP)&$D(%IS("HFSIO"))&$D(%IS("IOPAR"))
 I $D(%ZIS("HFSNAME")) D  Q:'$D(%ZIS("HFSMODE"))
 .I $D(%ZIS("HFSMODE")) D  Q
 ..S %ZISOPAR=$$MODE^%ZISF(%ZIS("HFSNAME"),%ZIS("HFSMODE"))
 ..W:'$D(IOP) "    HOST FILE TO USE:  "_%ZIS("HFSNAME")
 ..S %X=%ZIS("HFSNAME") Q
 .S %X=%ZIS("HFSNAME")
 .W:'$D(IOP) "    HOST FILE TO USE:  "_%ZIS("HFSNAME"),! Q
 E  D ASKHFS
H S:$D(%ZIS("HFSMODE")) %ZISOPAR=$$MODE^%ZISF(%X,%ZIS("HFSMODE"))
H1 I $D(IO("Q"))!(%IS["Z") S IO("HFSIO")=""
 I %X="",%ZISOPAR="" W:'$D(IOP) !,"HOST FILE SPECIFICATION NOT DEFINED" S POP=1 Q
 I $E(%ZISOPAR)'="(",%ZISOPAR'[""":""" S %ZISOPAR="(""W"""_":"""_%ZISOPAR_""")"
 I $D(IO("HFSIO")) S IO("HFSIO")=IO
 D ASKPAR^%ZIS6,SETPAR^%ZIS3 Q:$D(IOP)
 I %ZTYPE="HFS",'$D(%ZIS("HFSMODE")),'$P(^%ZIS(1,%E,0),"^",4),$P($G(^%ZIS(1,%E,1)),"^",6) D HFSIOO Q:POP
 S %ZISMODE=$P($P(%ZISOPAR,""":""",1),"(""",2) Q:%ZISMODE="A"
 S %ZISFN=$P($P(%ZISOPAR,""":""",2),""")",1)
 D FREEDEV^%ZOSV1 I IO="" W:'$D(IOP) *7,"  No free I/O channels." S POP=1 Q
 D EXIST Q:%ZISFLG=1
 I '%ZISFLG W !,"File ",%ZISFN," does not exist!" S POP=1 Q
OVERWR W !!,"File ",%ZISFN," exists.  Overwrite" S U="^",%=2 D YN^%ZIS1
 I %=0 W !,"Answer YES or NO" G OVERWR
 S:%'=1 POP=1 Q
HFSIOO ;
 W:$X>40 ! W ?45,"INPUT/OUTPUT OPERATION: " D SBR^%ZIS1
 S %X=$ZCONVERT(%X,"U")
 I $D(DTOUT)!$D(DFOUT)!$D(DUOUT) S POP=1 Q
 I %X="?"!($F("?^R^W^A",%X)'>1) D HOPT
 I %X="??" S %ZISHFR="XUHFSPARAM-DTM" D HELPFR
 G HFSIOO:%X["?"!($F("?^R^W^A",%X)'>1)
 I %X]"" S %ZISOPAR="("""_%X_""":"_$P(%ZISOPAR,":",2,9)
 Q
HOPT W !,"Enter one of the following host file input/ouput operation:"
 W !,?16,"R = READ",!,?16,"W = WRITE",!,?16,"A = APPEND" Q
 ;
HELPFR S %ZISI=$O(^DIC(9.2,"B",%ZISHFR,0)) Q:'%ZISI  Q:'$D(^DIC(9.2,+%ZISI,0))  Q:$P(^(0),"^",1)'=%ZISHFR
 Q:$D(^DIC(9.2,+%ZISI,1))'>9  F %X=0:0 S %X=$O(^DIC(9.2,+%ZISI,1,%X)) Q:%X'>0  I $D(^(%X,0)) W !,^(0)
 W ! S %X="??" Q
 ;
HLP1 W !,"Enter a valid file name for the host operating system" Q
EXIST ;
 I $P($ZVER,"/",2)<4 S %ZISFLG=1 Q
 S %ZISFLG=($$files^%dos(%ZISFN)]"")
 I %ZISFLG&(%ZISMODE="W") S %ZISFLG=-1 Q
 I %ZISFLG=0&(%ZISMODE="R") Q
 S %ZISFLG=1
 Q
 ;
ASKHFS ;---Ask host file name---
 S %X='$P($G(^%ZIS(1,%E,1)),"^",5)
 Q:$D(IOP)!%X!$D(%ZIS("HFSNAME"))
 ;W !,"HOST FILE NAME: " W:%ZISOPAR]"" %ZISOPAR_"// " D SBR^%ZIS1
ASKAGN W !,"HOST FILE NAME: " D SBR^%ZIS1
 I %X?1."?".E S %ZISHFR="XUHFS-DTM" D HLP1 D:%X["??" HELPFR G ASKAGN
 I $D(DTOUT)!$D(DUOUT) S POP=1 Q
 I $E(%X)="""",%X'[""":""" S %X=$E(%X,2,$L(%X)-1)
 D SETOPAR
 Q
SETOPAR I %ZISOPAR?1"("1"""".A1""""1":"1"""".ANP1""""1")" S $P(%ZISOPAR,"""",4)=%X Q
 S %ZISOPAR=%X
 Q
MODE(X1,X2) ;Return value in Y
 N Y
 S Y="("_""""_$S(X2="RW":"M",X2="R":"R",X2="W":"W",X2="A":"A",1:"W")_""":"_""""_X1_""")"
 Q Y
