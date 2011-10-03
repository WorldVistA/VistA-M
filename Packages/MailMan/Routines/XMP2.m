XMP2 ;(WASH ISC)/GM/CAP-PackMan Print/Install/Summarize/Compare ;04/17/2002  11:07
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; XC     XMPCOM - Compare message
 ; XI     XMPINS - Install message
 ; XP     XMPPRT - Print message
 ; XS     XMPSUM - Summarize message
 ;;XMP2 IS INSTALLED AS XMP2Z TO AVOID CLOBBER ERRORS / FILE AS XMP2
 Q
 ;
LIST ;LIST MESSAGE
 S XCN=.999 F M=1:1 D NT Q:+XCN'=XCN  W !,X
 Q
 ;
 ;
PP ;PRETTY PRINT
 S:'$D(XCN) XCN=.999 S XCN=+XCN K XMOUT
 F I=1:1 D NT Q:XCN'=+XCN  Q:$E(X)="$"  D @($P("P1,G1,G2,K1",",",%1)) Q:$D(XMOUT)
 Q
 ;
P1 Q:X?1"KEY ;;;".E
 I XMP2="T" W !,$P(X," ",1)_" " S X=$P(X," ",2,99)
 E  W !,$P(X," ",1)," ",?8 S X=$P(X," ",2,999)
P2 I $Y+5>IOSL K DIR S DIR(0)="E" D:'$D(ZTQUEUED) ^DIR:$E(IOST)="C"&$S('$D(XMP):1,'XMP:1,1:0) K DIR,DIRUT W @IOF I $D(DTOUT)!$D(DUOUT) S XMOUT=1 Q
 I $G(XMP2(0))=1 W "=" K XMP2(0)
 I $X+$L(X)+1<IOM!(IOM<22) W X Q
 F J=(IOM-$X-1):-1:20 Q:"),@_:"[$E(X,J)  Q:J<20  I $E(X,J)?1P Q:$E(X,J-2)'=" "
 W $E(X,1,J),!,?10 S X=$E(X,J+1,999)
 G P2
 ;
XT S XMP2="T" G 1
 ;
XP S XMP2="P"
1 I $D(XMLOAD) W $C(7),!,"YOU CAN NOT PRINT a message while you are creating it." Q
 S XCF=1 D MM,SP G SC
 ;
XR S XMP2="R" G 0
 ;
XI S XMP2="I"
0 D MM S XCF=2 G ENH^XMP2A
 ;
ENI D ^XMP3 G Q:X=U D S G Q:XMP2'="I"
 I $D(XMINIT),$P(XMR,U,7)="X" D @XMINIT
 I $D(XMINTEG) D @XMINTEG
Q K XMA0,XMB0,XMP2,XMPASS,XMPKIDS,XMINIT,XMINTEG Q
 ;
XC S XCF=3,XMP2="C" D MM,SP G SC ; Compare Message (DOPT 9)
 ;
XS S XCF=0,XMP2="S" D MM,SP G SC
 ;
SP G DEV^XMPH ; Output where? Queued by default. AND !!!  Runs @XMP2 opt.
 ;
SC K XMP2 Q
 ;
 ;
 ; From DEV+2^XMPH and ZTASK+4^XMPH only   for EVERYTHING!!!!  XMP2=What
S S XCN=.999 G ENTR^XMP2A:XMP2="R",ENTT^XMP2A:XMP2="T" I '$D(XMR) S XMR=^XMB(3.9,XMZ,0)
 F I=1:1 D NT Q:+XCN'=XCN  D:$E(X)="$" S1:X'["$TXT" Q:+XCN'=XCN  I $D(XMOUT) K XMOUT Q
 Q
 ;
S1 Q:$E(X,1,5)="$END "!($E(X,1,5)'?1"$"3U1" ")
 I XMP2="I",$P(XMR,U,7)["X",$E(X,1,9)'="$END ROU ",$E(X,1,5)'="$ROU " S XMOUT=1 Q
 S T=$E(X,2,4),A=$T(@T) I A="" W $C(7),"Unknown identifier '",A,"'" K A Q
 W:XCF=1 @IOF W !,"Line ",XCN,?10,"Message #"_XMZ,?29 W:XCF $P(",Unloading,Comparing,Verifying",",",XCF) W " ",$P(A,";;",2),"  ",$E(X,5,999)
 I XCF=0 D:$E(A,1,3)="KID" K2 Q
 S A=$P($T(@T+XCF),";;",2,999) I A=";" W !,"Not implemented yet" Q
 I $E(X,1,4)="$ROU",'$D(XMINIT),XMP2="I" S %=$P(X," ",2) S:%?.1"^".AN1"INIT" XMINIT="^"_% I %?.1"^".AN1"NTEG" S XMINTEG="^"_%
 X A K A Q
 ;
NT S XCN=$O(^XMB(3.9,XMZ,2,XCN)) Q:+XCN'=XCN  S X=^(XCN,0) D:$E(X)="$" CHECK^XMPSEC Q
 ;
MM S (DIE,DIF)="^XMB(3.9,XMZ,2," Q
 ;
G1 W !,X D NT Q:+XCN'=XCN  G P2
 ;
G2 W !,X D NT Q:+XCN'=XCN  S XMP2(0)=1 G P2
 ;
K1 ;print KIDS Distribution routines
 F  S XCN=$O(^XMB(3.9,XMZ,2,XCN)) Q:+XCN'=XCN  S X=^(XCN,0) Q:$E(X)="$"  D:X?1"""RTN"","""1.8AN1""")"
 .S XCN=XCN+1,X1=$E(X,1,$L(X)-1) W !,"Routine  ",$TR($P(X1,",",2),"""")
 .F  S XCN=$O(^XMB(3.9,XMZ,2,XCN)) Q:+XCN'=XCN  S X=^(XCN,0) Q:$P(X,",",1,2)'=X1  S XCN=$O(^XMB(3.9,XMZ,2,XCN)),X=^(XCN,0) D P1 Q:$D(XMOUT)
 .S:XCN=+XCN XCN=XCN-1
 S XMOUT=1 Q
 ;
K2 ;print summary of KIDS Distribution
 Q:$T(XMP2^XPDDP)=""  K ^TMP($J,"BLD"),M
 F  S XCN=$O(^XMB(3.9,XMZ,2,XCN)) Q:+XCN'=XCN  S X=^(XCN,0) Q:$E(X)="$"  I X?1"""BLD"","1.N1",0)" S XCN=$O(^XMB(3.9,XMZ,2,XCN)),M=^(XCN,0) Q
 Q:'$D(M)  S @("^TMP("_$J_","_X)=M,X1=$P(X,",",1,2)
 F  S XCN=$O(^XMB(3.9,XMZ,2,XCN)) Q:+XCN'=XCN  S X=^(XCN,0) Q:$P(X,",",1,2)'=X1  S XCN=$O(^XMB(3.9,XMZ,2,XCN)),M=^(XCN,0),@("^TMP("_$J_","_X)=M
 D XMP2^XPDDP("TMP("_$J_","_X1_")",$P(X1,",",2))
 S XMOUT=1 Q
 ;
SAVE D NT Q:"$END "_T=$P(X," ",1,2)  S X1=X D NT Q:"$END "_T=$P(X," ",1,2)
 ;I $A(X)=126 S %=X D NT S X=%_$E(X,2,999) ; Set by ^DIFROM1, but DIFROM is no longer used.
 S @X1=$E(X,2-$G(XMP2(0)),999)
 G SAVE
 ;
BEG S %=0,ROU=$E(X,6,99),^TMP("XMS",$J,ROU,0,1)="""" F %0=1:1 D NT Q:$E(X)="$"  S ^TMP("XMS",$J,ROU,0,%0)=X,%=%+$L(X)
 S ^TMP("XMS",$J,ROU,0)=%,%0=%0-1 Q
 ;
COMP D NT Q:$E(X)="$"
 S X1=X D NT Q:$E(X)="$"
 ;
 ;Globals
 ;I $A(X)=126 S %=$E(X,2,999) D NT S X=%_$E(X,2,999) ; Set by ^DIFROM1, but DIFROM is no longer used.
 I '$D(@X1) W !,"Node '",X1,"' not on disk." G COMP
 S Y=@X1,B=$E(X,2-$G(XMP2(0)),999)
 G COMP:Y=B
 W !,"Node: ",X1,!,"Disk:    ",Y
 W !,"Message: ",$E(X,2-$G(XMP2(0)),99)
 S X=$E(X,2,999) F J=1:1:$L(X) Q:$E(X,J)'=$E(Y,J)
 W !,?12+J,"^"
 G COMP
 ;
 ;TAG ;;Description of type of PackMan Data
 ;    ;;Executable Print Code
 ;    ;;Executable Installation code
 ;    ;;Executable Comparison to Installed
 ;    ;;Executable Verification code
 ;
ROU ;;Routine
 ;;S %1=1 D PP
 ;;S X=$P(X," ",2) S:X="XMP2" X="XMP2Z" S DIE="^XMB(3.9,XMZ,2," X ^%ZOSF("SAVE") W:X="XMP2Z" !,$C(7),"CHANGE NAME OF ROUTINE XMP2Z TO XMP2"
 ;;D LOAD^XMPC
 ;;G BEG
DDD ;;Data Dictionary
 ;;S %1=2 D PP
 ;;D SAVE
 ;;D COMP
 ;;
OPT ;;Options
 ;;S %1=2 D PP
 ;;D SAVE
 ;;Q
 ;;
HEL ;;Help Frames
 ;;S %1=2 D PP
 ;;D SAVE
 ;;Q
 ;;
BUL ;;Bulletins
 ;;S %1=2 D PP
 ;;D SAVE
 ;;Q
 ;;
KEY ;;Security keys
 ;;S %1=2 D PP
 ;;D SAVE
 ;;Q
 ;;
FUN ;;Functions
 ;;S %1=2 D PP
 ;;D SAVE
 ;;Q
 ;;
PKG ;;Package File
 ;;S %1=2 D PP
 ;;D SAVE
 ;;Q
 ;;
RTN ;;Routine Documentation
 ;;S %1=2 D PP
 ;;D SAVE
 ;;Q
 ;;
DIE ;;Input Templates
 ;;S %1=2 D PP
 ;;D SAVE
 ;;Q
 ;;
DIP ;;Print Templates
 ;;S %1=2 D PP
 ;;D SAVE
 ;;Q
 ;;
DIB ;;Sort Templates
 ;;S %1=2 D PP
 ;;D SAVE
 ;;Q
 ;;
GLB ;;Global
 ;;S %1=2 D PP
 ;;D SAVE
 ;;D COMP
 ;;
DTA ;;FileMan Data
 ;;S %1=1 D PP
 ;;D SAVE
 ;;Q
 ;;
TXT ;;Text
 ;;Q
 ;;Q
 ;;Q
 ;;Q
GLO ;;Global
 ;;S %1=3 D PP
 ;;S XMP2(0)=1 D SAVE K XMP2(0)
 ;;S XMP2(0)=1 D COMP K XMP2(0)
 ;;Q
KID ;;KIDS Distribution
 ;;S %1=4 D PP
 ;;I $T(XMP2^XPDIPM)]"" D XMP2^XPDIPM
 ;;;
 ;;;
