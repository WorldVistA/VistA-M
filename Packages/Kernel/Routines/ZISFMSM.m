%ZISF ;SFISC/AC - HOST FILE CODE FOR MSM ;05/07/98  10:56
 ;;8.0;KERNEL;**104**;JUL 10, 1995
HFS Q:$D(IOP)&$D(%IS("HFSIO"))&$D(%IS("IOPAR"))
 I $D(%ZIS("HFSNAME")) D  Q:$D(%ZIS("HFSMODE"))
 .I $D(%ZIS("HFSMODE")) D
 ..S %ZISOPAR=$$MODE^%ZISF(%ZIS("HFSNAME"),%ZIS("HFSMODE"))
 ..W:'$D(IOP) "    HOST FILE TO USE:  "_%ZIS("HFSNAME") Q
 .S %X=%ZIS("HFSNAME") D SETOPAR
 .W:'$D(IOP) "    HOST FILE TO USE:  "_%ZIS("HFSNAME"),! Q
 E  D ASKHFS ;Note the HFS name is part of the IO parameter string
H S:$D(%ZIS("HFSMODE")) %ZISOPAR=$$MODE^%ZISF(%X,%ZIS("HFSMODE"))
H1 S:$D(IO("Q"))!(%IS["Z") IO("HFSIO")=""
 S:$E(%ZISOPAR)'="(" %ZISOPAR="("""_%ZISOPAR_""":""W"")"
 S:$D(IO("HFSIO")) IO("HFSIO")=IO
 D ASKPAR^%ZIS6,SETPAR^%ZIS3 K %ZY
HFSIOO Q:$D(%ZIS("HFSMODE"))
 I '$D(IOP),$$ASKHFSIO(%E) W ?45,"INPUT/OUTPUT OPERATION: "
 Q:'$T  D SBR^%ZIS1 I $D(DTOUT)!$D(DFOUT)!$D(DUOUT) S POP=1 Q
 D HOPT(1):%X="?"!($F("?^R^W^M^A",%X)'>1),HOPT1:%X="??" G HFSIOO:%X="?"!($F("?^R^W^M^A",%X)'>1)
 S $P(%ZISOPAR,"""",4)=%X Q
 ;
HOPT(X) ;Display Input/Output operation -- X=1 for scroll, X=2 for MWAPI.
 I X=1 D
 .W !,"Enter one of the following host file input/ouput operation:"
 .W !,?16,"R = READ",!,?16,"W = WRITE",!,?16,"M = READ/WRITE",!,?16,"A =  APPEND" Q
 E  D
 .K TMP("ZISGHFS","G","HFSOPER","CHOICE")
 .S TMP("ZISGHFS","G","HFSOPER","CHOICE","1^R")="READ"
 .S TMP("ZISGHFS","G","HFSOPER","CHOICE","2^W")="WRITE"
 .S TMP("ZISGHFS","G","HFSOPER","CHOICE","3^M")="READ/WRITE"
 .S TMP("ZISGHFS","G","HFSOPER","CHOICE","4^A")="APPEND"
 Q
HOPT1 S %ZISI=$O(^DIC(9.2,"B","XUHFSPARAM-MSM",0)) Q:'%ZISI  Q:'$D(^DIC(9.2,+%ZISI,0))  Q:$P(^(0),"^",1)'="XUHFSPARAM-MSM"
 Q:$D(^DIC(9.2,+%ZISI,1))'>9  F %X=0:0 S %X=$O(^DIC(9.2,+%ZISI,1,%X)) Q:%X'>0  I $D(^(%X,0)) W !,^(0)
 W ! S %X="??" Q
 ;
CHKNM(H) ;Check HFS name for dir
 I $$OSTYPE^%ZOSV<3 S H=$TR(H,"/","\") ;for DOS/NT only
 I H[":"!(H["\")!(H["/") Q H
 Q $$DEFDIR^%ZISH("")_H
 ;
ASKHFS ;---Ask host file name here---
 S %X='$P($G(^%ZIS(1,%E,1)),"^",5)
 S:'%X %X=""
 Q:$D(IOP)!%X!$D(%ZIS("HFSNAME"))
ASKAGN W !,"HOST FILE NAME: " S %ZY=$$GETHFSNM(%ZISOPAR)
 W:%ZY]"" %ZY_"//" D SBR^%ZIS1
 I %X?1."?".E W !,"ENTER HOST FILE NAME" G ASKAGN
 I $D(DTOUT)!$D(DUOUT) K %ZY S POP=1 Q
 S %X=$S(%X]"":%X,1:%ZY)
 I %X="" W *7,!,"You must enter the name of a host file" G ASKAGN
 D SETOPAR Q
 ;
SETOPAR ;Set the file name into %ZISOPAR
 S %X=$$CHKNM(%X)
 I %ZISOPAR?1"("1"""".ANP1""""1":"1"""".AN1""""1")" S $P(%ZISOPAR,"""",2)=%X Q
 S %ZISOPAR=%X
 Q
MODE(X1,X2) ;Return value in Y
 N Y
 S Y="("_""""_X1_""":"_""""_$S(X2="RW":"M",X2="R":"R",X2="W":"W",X2="A":"A",1:"W")_""")"
 Q Y
ASKHFSIO(DA)       ;
 I $G(^%ZIS(1,DA,"TYPE"))="HFS",'$D(%ZIS("HFSMODE")),'$P(^(0),"^",4),$P($G(^(1)),"^",6) Q 1
 Q 0
GETHFSNM(X)        ;Extract host file name from variable X.
 N Y
 S Y=X
 S:Y?1"("1"""".ANP1""""1":"1"""".AN1""""1")" Y=$P(Y,"""",2)
 I $D(%IS("B","HFS"))#2,%IS("B","HFS")]"" S Y=%IS("B","HFS")
 Q Y
