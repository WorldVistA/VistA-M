%ZISF ;SFISC/AC - HOST FILES FOR Cache on NT & VMS ;06/07/10  15:08
 ;;8.0;KERNEL;**34,191,271,385,499,524,546**;Jul 10, 1995;Build 9
 ;Per VHA Directive 2004-038, this routine should not be modified
HFS ;Host File Server
 ;Calling parameters in %ZIS override Device file.
 Q:$D(IOP)&$D(%ZIS("HFSIO"))&$D(%ZIS("IOPAR"))
 N %
 ;Get file name
 I $D(%ZIS("HFSNAME")) S IO=%ZIS("HFSNAME"),%X=IO
 E  D ASKHFS ;Return name in %X
 ;Mode or actual parameters
H S:$D(%ZIS("HFSMODE")) %ZISOPAR=$$MODE(%ZIS("HFSMODE"))
H1 I $D(IO("Q"))!(%ZIS["Z") S IO("HFSIO")=""
 S:$L(%X) %ZIS("afn")=1
 S IO=$S($L(%X):%X,1:IO),IO=$$CHKNM(IO) ;See that we have a directory
 S:$D(IO("HFSIO")) IO("HFSIO")=IO
 I '$D(IOP)&$D(%ZIS("HFSNAME")) S %="    HOST FILE USED:  "_%ZIS("HFSNAME") W:$X+$L(%)>75 ! W %,!
 ;Check Ask Parameters
 D ASKPAR^%ZIS6,SETPAR^%ZIS3
 ;Check Ask IO Mode
HFSIOO I '$D(IOP),%ZTYPE="HFS",'$D(%ZIS("HFSMODE")),'$P(^%ZIS(1,%E,0),"^",4),%ZISOPAR="",$P($G(^%ZIS(1,%E,1)),"^",6) D
 . W:$X>19 ! W ?20,"INPUT/OUTPUT OPERATION: R//"
 Q:'$T  D SBR^%ZIS1 I $D(DTOUT)!$D(DFOUT)!$D(DUOUT) S POP=1 Q
 S:%X="" %X="R" S %X=$$UP^%ZIS1(%X)
 D HOPT:%X="?"!'$$CHECK(%X),HOPT1:%X="??" G HFSIOO:%X="?"!'$$CHECK(%X)
 S:%X]"" %ZISOPAR="("_$$MODE(%X)_")"
 Q
 ;
CHECK(X) ;Check that we have valid option
 N Y,%
 Q:(X["R")&(X["W") 0 ;Can't have both
 S Y=1 I $L($TR(X,"ANRW")) S Y=0
 Q Y
 ;
ASKHFS ;---Ask host file name here---
 I $D(%ZIS("B","HFS"))#2,%ZIS("B","HFS")]"" D
 .S IO=%ZIS("B","HFS") ;Set default host file name
 S %X='$P($G(^%ZIS(1,%E,1)),"^",5)
 S:'%X %X=""
 I $D(IOP)!%X!$D(%ZIS("HFSNAME")) S %X="" Q
ASKAGN W !,"HOST FILE NAME: "_IO_"//" D SBR^%ZIS1
 I %X?1."?".E W !,"ENTER HOST FILE NAME" G ASKAGN
 S:$D(DTOUT)!$D(DUOUT) POP=1
 Q
CHKNM(H)        ;Check the HFS name
 Q:$D(IO("Q")) H
 N N,P,F,%OS S N=H,%OS=$$OS^%ZOSV
 ;Find any path may have
 S P=$TR($RE(H),"\:[]","////"),F=$RE($P(P,"/")),P=$P(H,F,1)
 I %OS["VMS",((P'[":")&(P'["["))!(P["\") S N=$$DEFDIR^%ZISH("")_F ;VMS - disk:[directory]file
 I %OS["NT",'(P?1(1A1":\",1"\\").E) S N=$$DEFDIR^%ZISH("")_F ;NT - C:\DIR\FILE
 I %OS["UNIX",(P'["/") S N=$$DEFDIR^%ZISH("")_F ;UNIX/Linux - ./file or /mnt/dir/file
 Q N
 ;
MODE(X) ;Return value for %ZISOPAR.
 ;For VMS only, The H is for read SHARE. Going back to READ Stream mode.
 N Y,Q S Q=$C(34)
 I $ZV["VMS" S Y=$S(X="N":"NWS",X="W":"NWS",X="A":"AWS",1:"RHS")
 E  S Y=$S(X="N":"NWS",X="W":"NWS",X="A":"AWS",1:"RS")
 Q $S($L(Y):Q_Y_Q,1:Y)
 ;
HOPT W !,"You may enter a code that represents one of",!,"the following host file input/ouput operation:"
 W !?16,"R = READ ACCESS",!?16,"W = WRITE ACCESS",!?16,"N = NEWVERSION",!?16,"A = APPEND"
 Q
 ;
HOPT1 S %ZISI=$O(^DIC(9.2,"B","XUHFSPARAM-MVX",0)) Q:'%ZISI  Q:'$D(^DIC(9.2,+%ZISI,0))  Q:$P(^(0),"^",1)'="XUHFSPARAM-MVX"
 Q:$D(^DIC(9.2,+%ZISI,1))'>9  F %X=0:0 S %X=$O(^DIC(9.2,+%ZISI,1,%X)) Q:%X'>0  I $D(^(%X,0)) W !,^(0)
 W ! S %X="??"
 Q
