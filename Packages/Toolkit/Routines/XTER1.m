XTER1 ;ISC-SF.SEA/JLI - Kernel Error Trap Display ;09/27/10  15:31
 ;;8.0;KERNEL;**8,392,431**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 S XTDV1=0
WRT S XTOUT=0 S:'$D(XTBLNK) $P(XTBLNK," ",133)=" " S:'$D(C) C=0 K:C=0 ^TMP($J,"XTER")
 D DV
 I '$D(%XTZLIN) S %XTY=$P(%XTZE,","),%XTX=$P(%XTY,"^") S:%XTX[">" %XTX=$P(%XTX,">",2)
 I '$D(%XTZLIN),%XTX'="" S X=$P($P(%XTY,"^",2),":") I X'="" X ^%ZOSF("TEST") I $T D
 . N XCNP,DIF
 . S XCNP=0,DIF="^TMP($J,""XTER1""," X ^%ZOSF("LOAD") S %XTY=$P(%XTX,"+",1) D
 . . I %XTY'="" F X=0:0 S X=$O(^TMP($J,"XTER1",X)) Q:X'>0  I $P(^(X,0)," ")=%XTY S X=X+$P(%XTX,"+",2),%XTZLIN=^TMP($J,"XTER1",X,0) Q
 . . I %XTY="" S X=+$P(%XTX,"+",2) Q:X'>0  S %XTZLIN=^TMP($J,"XTER1",X,0)
 S:'$D(%XTZLIN) %XTZLIN="" K ^TMP($J,"XTER1")
 I %XTZLIN'="" D ADD(""),ADD(%XTZLIN)
 ;I '$D(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV","B")) F XTI=0:0 S XTI=$O(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV",XTI)) Q:XTI'>0  S XTSYM=^(XTI,0),^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV","B",XTSYM,XTI)=""
 I '$D(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV","B")) D  ;p431
 . F XTI=0:0 S XTI=$O(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV",XTI)) Q:XTI'>0  S XTSYM=$P(^(XTI,0),"(") S:'$D(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV","B",XTSYM)) ^(XTSYM,XTI)=""
 ;I IO'=IO(0) S XTDV1=0 D DV ;p431
 D:'$G(XTMES)&'$G(XTPRNT) WRITER^XTER1A
 I IO'="",IO'=IO(0)!$G(XTPRNT) U IO W:$E($G(IOST))="C" @IOF S X="^L" G WRTA
 I $G(XTMES) S X="^L" G WRTA
 ;
 K ^TMP($J,"XTER") S C=0
 R !!,"Which symbol? > ",XTX:DTIME S:'$T!(XTX="") XTX="^"
 S:$E(XTX,1)="^" XTX=$TR(XTX,"ilmpqr","ILMPQR") ;uppercase
 G XTERR^XTER:XTX>0!(XTX="^"),END^XTER:XTX="^Q",MESG^XTER1A:XTX="^M",PRNT^XTER1A:XTX="^P" S X=XTX,XTX="",XTOUT=0
 I X="^I" D EN^XTER1B G WRT
 I X["?" S XTF="1,2,10,7,13,14,15,8,9" D HELP^XTER G WRT
 I X="$" S XTDV1=0 D DV G WRT
 I X="^R" G RESTOR^XTER2
 ;
WRTA ;Show All (^L)
 D WRT1 S:'$D(XTX) XTX=""
 Q:$G(XTMES)!$G(XTPRNT)  G:IO=IO(0)&(XTX'="^Q")&(XTX'="^q") WRT
 U IO(0) G END^XTER:XTX="^Q"!(XTX="^q"),XTERR^XTER
 ;
WRT1 ;
 S:'$D(IOSL) IOSL=24 D ADD(""),ADD("")
 S XTSYM=$S(X="^L":"",1:X),%XTYL=IOSL-4,XTI=0,XTC=1,X="",XTA=XTSYM,XTA=$S(XTA="":"",1:$E(XTA,1,$L(XTA)-1)_$C($A($E(XTA,$L(XTA)))-1)_"z")
 ;Find start by order thru B X-ref for Symbols, XTA=var name, XTB=var value
WF S:'%XTYL %XTYL=IOSL-4
 ;S (XTA,XTA1)=$O(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV","B",XTA)) S XTI=$S(XTSYM="":1,XTA'="":$O(^(XTA,0)),1:0)
 S XTA=$O(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV","B",XTA)) S XTI=$S(XTSYM="":1,XTA'="":$O(^(XTA,0)),1:0) ;p431
 I XTA=""!(XTSYM'=""&($E(XTA,1,$L(XTSYM))'=XTSYM)) D:XTSYM'=""&XTC ADD("No such symbol") D:'$G(XTPRNT) MORE^XTER1A Q
 S (XTA,XTA1)=^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV",XTI,0) ;p431
 D WV
 ;Show the rest in order
 F  S XTI=$O(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV",XTI)) Q:'XTI!(XTOUT)  S (XTA,XTA1)=^(XTI,0) Q:$E(XTA,1,$L(XTSYM))'=XTSYM  D WV
 Q
WV ;Write a variable
 S:'%XTYL %XTYL=IOSL-4
 S XTB=$S($D(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV",XTI,"D")):^("D"),1:"***  WARNING: this value was NOT recorded due to an ERROR WITHIN the TRAP ***")
 ;Check for long variables
 S XTL=$G(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV",XTI,"L")) I XTL>255 D ADD("**The following variables length is "_XTL_", only displaying first 255.**")
 S XTC=0 S:'$G(XTMES)&'$G(XTPRNT) %XTYL=%XTYL-1
 D:'%XTYL MORE^XTER1A Q:XTOUT  D:'%XTYL ADD("")
 S XTA1=XTA1_"=" K XTC1 I XTB?.PUNL,XTB'["\" S XTA1=XTA1_XTB,XTC1=""
 ;Change control char to \027 format
 I '$D(XTC1) S XTC1="" I $P(XTA1," ",2)="" F XTK=1:1 S XTZ=$E(XTB,XTK) Q:XTZ=""  S XTC1=XTC1_$S(XTZ'?1C:XTZ,1:"\"_$E($A(XTZ)+1000,2,4)) I XTZ="\" S XTC1=XTC1_"\"
 D SET D:XTL>255 ADD("**")
 Q
 ;
SET ;
 I ($L(XTA1)+$L(XTC1))<246 S XTA1=XTA1_XTC1,XTC1="" D ADD(XTA1) Q
 I $L(XTA1)>245 D ADD($E(XTA1,1,245)) S XTA1=$E(XTA1,246,$L(XTA1)) G SET
 I $L(XTA1)>0 D ADD(XTA1_$E(XTC1,1,(245-$L(XTA1)))) S XTC1=$E(XTC1,(245-$L(XTA1)+1),$L(XTC1)) G SET
 D ADD($E(XTC1,1,245)) S XTC1=$E(XTC1,246,$L(XTC1)) G SET
 Q
 ;
ADD(STR) ;Add STR to TMP global
 S C=C+1,^TMP($J,"XTER",C)=STR
 Q
 ;Header info
DV I $D(XTDV1),XTDV1=1 G DV1
 K %XTZLIN
 S %XTZE=^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZE"),%XTJOB=$G(^("J")),%XTIO=$G(^("I")),%XTZH=$G(^("ZH")),%XTZH1=$G(^("H")),%XTZGR=$G(^("GR")) S:$D(^("LINE")) %XTZLIN=^("LINE")
 I %XTZH1>0 S %H=%XTZH1 D YMD^%DTC S Y=X_% D DD^%DT S $P(%XTZH1,"^",2)=$P(Y,"@",1)_" "_$P(Y,"@",2)
 F %XTI=1:1:9 S %XTZH(%XTI)=$P(%XTZH,"^",%XTI)
 S %XTZH(3)=$P(%XTZH1,U,2)
 S %XTUCI=$P(%XTJOB,U,4)
 ;Build output
 S X="Process ID:  "_$P(%XTJOB,U,5)_"  ("_$P(%XTJOB,U)_")",X=X_$E(XTBLNK,1,40-$L(X))_%XTZH(3)
 D ADD(""),ADD(X)
 S %XTZ="Username\Process Name\UCI/VOL\\$ZA\$ZB\Current $IO\Current $ZIO\CPU time\Page Faults\Direct I/O\Buffered I/O"
 S %XTZ(1)=$P(%XTJOB,U,3),%XTZ(2)=$P(%XTJOB,U,2),%XTZ(3)=$S(%XTUCI]"":"["_%XTUCI_"]",1:"")
 S %XTZ(4)="",%XTZ(5)=$J($P(%XTIO,U,2),3),%XTZ(6)=$J($P(%XTIO,U,3),3)
 S %XTZ(7)=$P(%XTIO,U),%XTZ(8)=$P(%XTIO,U,4,99),%XTZ(9)=$J(%XTZH(1),6)
 S %XTZ(10)=$J(%XTZH(4),10),%XTZ(11)=$J(%XTZH(7),10),%XTZ(12)=$J(%XTZH(8),10)
 F %XTI=1:1:12 D
 . I %XTI#2 S X=""
 . S:%XTZ(%XTI)'?." " X=X_$P(%XTZ,"\",%XTI)_": "_%XTZ(%XTI) S:%XTI#2 X=$E(X_$E(XTBLNK,1,40),1,40)
 . I '(%XTI#2),X'?." " D ADD(""),ADD(X)
 . Q
DV1 S XTDV1=1 D ADD(""),ADD("$ZE= "_%XTZE)
 D:%XTZGR'="" ADD(""),ADD("Last Global Ref: "_%XTZGR) ;p431
 K X I $D(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZE2")) S X=^("ZE2")
 I $D(X) D ADD(""),ADD("%ZTER encountered an error while logging this error -- "),ADD("This may have caused some LOCAL VARIABLES to be lost."),ADD("This error was: "_X)
 Q
 ;
