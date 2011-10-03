SCRPW23 ;RENO/KEITH - ACRP Ad Hoc Report (cont.) ; 15 Jul 98  02:38PM
 ;;5.3;Scheduling;**144,474**;AUG 13, 1993;Build 4
DIRB(SDFL) ;Get default values for range
 ;Required input: SDFL="F" for first, "L" for last
 N SDX S SDX=$O(SDPAR("X",SDS2,$S(SDDV:5,1:4),""),$S(SDFL="F":1,1:-1)) Q $S(SDX=""!'SDDV:SDX,1:SDPAR("X",SDS2,5,SDX))
 ;
RL ;Prompt for range or list
 N SDI,SDIRQ X:$L($P(SDACT,T,9)) $P(SDACT,T,9) S SDDV=0 S:$P(SDACT,T,2)="D" SDDV=1,SDPAR("X",SDS2,6)="D"
 I $P(SDPAR("X",SDS2,2),U)="N" D NULL Q
 I $P(SDPAR("X",SDS2,2),U)="L" D LST Q
RNG N SDR1,SDR2 D SUBT^SCRPW50("*** Item Range Selection ***")
R1 W !!,"Start with:" S SDR1=$$SEL($P(SDACT,T,2),$$DIRB("F")) Q:SDOUT!SDNUL
 S SDR2=$O(SDPAR("X",SDS2,$S(SDDV:5,1:4),""),-1) I $L(SDR2),$P(SDR1,U,$S(SDDV:1,1:2))]SDR2 F SDI=SDS1,"X" K SDPAR(SDI,SDS2,$S(SDDV:5,1:4),SDR2)
R2 W !!,"End with:" S SDR2=$$SEL($P(SDACT,T,2),$$DIRB("L")) Q:SDOUT!SDNUL
 I '$$RCOL() W !!,$C(7),"End value must collate after start value!" G R2
 F SDX="SDR1","SDR2" S SDPAR("X",SDS2,4,$P(@SDX,U,2),$P(@SDX,U))=""
 F SDX="SDR1","SDR2" S SDPAR("X",SDS2,5,$P(@SDX,U))=$P(@SDX,U,2)
 Q
 ;
RCOL() ;Determine range collation validity
 ;Output: 1=valid, 0=invalid
 I $P(SDR1,U,2)=+$P(SDR1,U,2),$P(SDR2,U,2)=+$P(SDR2,U,2) Q SDR1'>SDR2
 I SDDV Q $P(SDR1,U)'>$P(SDR2,U)
 Q $P(SDR1,U,2)']$P(SDR2,U,2)
 ;
NULL ;Set list for null value
 S SDPAR("X",SDS2,4,"~~~NONE~~~","~~~NONE~~~")="",SDPAR("X",SDS2,5,"~~~NONE~~~")="~~~NONE~~~" Q
 ;
LST I $D(SDPAR("X",SDS2,4)) D LST1
 D SUBT^SCRPW50("*** Item List Selection ***") W !
 F I=1:1:$P(SDACT,T,6) S SDX=$$SEL($P(SDACT,T,2)) Q:SDOUT!SDNUL  D LST0
 Q
 ;
LST0 I $D(SDPAR("X",SDS2,5,$P(SDX,U))) Q:$$LSD()
 S SDPAR("X",SDS2,5,$P(SDX,U))=$P(SDX,U,2),SDPAR("X",SDS2,4,$P(SDX,U,2),$P(SDX,U))=""
 Q
 ;
LSD() N DIR W !!,$C(7),$P(SDX,U,2)," is already selected." S DIR(0)="Y",DIR("A")="Do you want to delete it",DIR("B")="NO" D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q 0
 I Y D  W !,"   ...deleted." Q 1
 .F SDI=SDS1,"X" K SDPAR(SDI,SDS2,5,$P(SDX,U)),SDPAR(SDI,SDS2,4,$P(SDX,U,2),$P(SDX,U))
 .Q
 Q 0
 ;
LST1 ;List existing item selections
 N SDOUT,SDL,SDX S SDOUT=0,SDL=1,SDX="" W !,"Items currently selected:"
 F  S SDX=$O(SDPAR("X",SDS2,4,SDX)) Q:SDX=""!SDOUT  S SDL=SDL+1 W !?5,SDX D:SDL>15 WAIT^SCRPW22
 Q
 ;
SEL(SDTYP,SDIRB) ;Select items for list or range
 ;Required input: SDTYP=type of data (D, P, F, N, T, C, PP, S)
 ;Optional input: SDIRB=value for default prompt
 N SDX S SDX="" D @SDTYP Q SDX
 ;
D ;Get date values
 N DIR M DIR=SDIRQ S DIR(0)=$P(SDACT,T,4),DIR("A")="Select "_$P(SDACT,T) S:$L($G(SDIRB)) DIR("B")=SDIRB D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 I '$L(Y) S SDNUL=1 Q
 S SDX=Y X ^DD("DD") S SDX=SDX_U_Y X:$L($P(SDACT,T,8)) $P(SDACT,T,8) Q
 ;
P ;Get pointer values ;SD*5.3*474 added PSCRN to screen certain status types
 N DIC M DIC=SDIRQ S DIC=$P(SDACT,T,3),DIC(0)="AEMQ",DIC("S")=$P(SDACT,T,4) K:'$L(DIC("S")) DIC("S") D:DIC="^SD(409.63," PSCRN D ^DIC I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 I Y'>0 S SDNUL=1 Q
 S SDX=Y X:$L($P(SDACT,T,8)) $P(SDACT,T,8) Q
 ;
PSCRN ;screen out the 4 cancellation type status' SD*5.3*474
 S DIC("S")="I $P(^(0),U,2)'=""C"",$P(^(0),U,2)'=""CA"",$P(^(0),U,2)'=""PC"",$P(^(0),U,2)'=""PCA"""
 Q
 ;
F ;Get field values
 N DIR M DIR=SDIRQ S DIR(0)=$P(SDACT,T,3) S:$L($G(SDIRB)) DIR("B")=SDIRB D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 I '$D(DIR("B")),X="" S SDNUL=1 Q
 S SDX=Y_U_$G(Y(0)) X:$L($P(SDACT,T,8)) $P(SDACT,T,8) Q
 ;
N ;Get number value
 N DIR M DIR=SDIRQ S DIR(0)=$P(SDACT,T,4),DIR("A")="Select "_$P(SDACT,T) S:$L($G(SDIRB)) DIR("B")=SDIRB D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 I Y'?1.N S SDNUL=1 Q
 S SDX=Y_U_Y X:$L($P(SDACT,T,8)) $P(SDACT,T,8) Q
 ;
T ;Get text value
 N DIR M DIR=SDIRQ S DIR(0)=$P(SDACT,T,4),DIR("A")="Select "_$P(SDACT,T) S:$L($G(SDIRB)) DIR("B")=SDIRB D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 I '$L(Y) S SDNUL=1 Q
 S SDX=Y_U_Y X:$L($P(SDACT,T,8)) $P(SDACT,T,8) Q
 ;
C ;Get computed value
 D @($P(SDACT,T,4)) X:$L($P(SDACT,T,8)) $P(SDACT,T,8) Q
 ;
PP ;Get pointer value from file multiple
 N DIC M DIC=SDIRQ S DIC=$P($P(SDACT,T,3),";"),DIC(0)="AEMQ",DIC("B")=$P($G(SDIRB),";") K:'$L(DIC("B")) DIC("B") D ^DIC I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 I Y<1 S SDNUL=1 Q
 S SDX=Y,DIC=DIC_+SDX_$P($P(SDACT,T,3),";",2),DIC("B")=$P($G(SDIRB),";",2) K:'$L(DIC("B")) DIC("B") D ^DIC I $D(DTOUT)!$D(DUOUT) S SDX="",SDOUT=1 Q
 I Y<1 S SDX="",SDNUL=1 Q
 S SDX=+SDX_";"_+Y_U_$P(SDX,U,2)_" / "_$P(Y,U,2) X:$L($P(SDACT,T,8)) $P(SDACT,T,8) Q
 ;
S ;Get set-of-codes value
 N DIR M DIR=SDIRQ X $P(SDACT,T,3) S DIR("A")="Select "_$P(SDACT,T) S:$L($G(SDIRB)) DIR("B")=SDIRB D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 I '$L(Y) S SDNUL=1 Q
 S SDX=Y_U_Y(0) X:$L($P(SDACT,T,8)) $P(SDACT,T,8) Q
 ;
VCP(SDX) ;Validate Stop Code credit pair
 ;Required input: SDX=6 digit numeric value
 ;Output: 1=valid credit pair, 0=invalid credit pair
 G:SDX'?6N VCPQ G:'$D(^DIC(40.7,"C",$E(SDX,1,3))) VCPQ G:'$D(^DIC(40.7,"C",$E(SDX,4,6)))&($E(SDX,4,6)'="000") VCPQ
 Q 1
 ;
VCPQ W $C(7),"   ??",!,"This response must be a 6 digit numeric value",!,"that represents two valid stop codes!" Q 0
 ;
PLIST ;Print category list
 N ZTSAVE D EN^XUTMDEVQ("PLST^SCRPW23","CATEGORY LIST",.ZTSAVE) Q
PLST ;Print category list
 D:'$D(^TMP("SCRPW",$J,"SEL")) BLD^SCRPW21
 S I=0 F  S I=$O(^TMP("SCRPW",$J,"SEL",1,I)) Q:'I  S X1=$O(^TMP("SCRPW",$J,"SEL",1,I,"")) W !!,$P(^TMP("SCRPW",$J,"SEL",1,I,X1),"~") D PLST1
 K I,II,X1,X2,^TMP("SCRPW",$J) Q
 ;
PLST1 S II=0 F  S II=$O(^TMP("SCRPW",$J,"SEL",2,X1,II)) Q:'II  S X2=$O(^TMP("SCRPW",$J,"SEL",2,X1,II,"")) W !?4,$P(^TMP("SCRPW",$J,"SEL",2,X1,II,X2),"~")
 Q
 ;
DISP0 ;Return to full screen scrolling
 Q:$E(IOST)'="C"
 D ENS^%ZISS S SDRM=^%ZOSF("RM"),SDXY=^%ZOSF("XY"),(IOTM,IOBM)=0 W $$XY(IOSTBM,1),@IOF N DX,DY,X S (DX,DY)=0 X SDXY S X=IOM X SDRM Q
 ;
DISP(SDTOP,SDBOT) ;Create centered scrolling region
 ;Required input: SDTOP=text to center at top of screen
 ;Required input: SDBOT(n)=numbered array of text to display at bottom of screen
 N X D DISP0 S X=0 X SDRM W $$XY(IORVON) F I=1:1:(78-$L(SDTOP)\2) W "-"
 W " ",SDTOP," " F  W "-" Q:$X>79
 W $$XY(IORVOFF) S IOTM=3 W $$XY(IOSTBM,1) S (C,I)="" F  S I=$O(SDBOT(I)) Q:I=""  S C=C+1
 F  W ! Q:$Y>(IOSL-C)
 S II=$O(SDBOT("")) Q:II=""  W $$XY(IORVON) F I=1:1:(78-$L(SDBOT(II))\2) W "-"
 W " ",SDBOT(II)," " F  W "-" Q:$X>79
 W $$XY(IORVOFF) F  S II=$O(SDBOT(II)) Q:II=""  W !,$E(SDBOT(II),1,80)
 S IOBM=(IOSL-C-1) W $$XY(IOSTBM,1) Q
 ;
XY(X,SDI) ;Maintain $X, $Y
 ;Required input: X=screen handling variable to write
 ;Optional input: SDI=1 (to specify the use of indirection)
 N DX,DY S DX=$X,DY=$Y
 I $G(SDI) W @X X SDXY Q ""
 W X X SDXY Q ""
 ;
DIR(DIR,SDLEV,SDEXE,SDS,SDO,SDPFL,SDA) ;Ask questions!
 ;Required input: DIR array (pass by reference)
 ;Required input: SDLEV=level to build DIR(0) for large sets
 ;Optional input: SDEXE=code to execute prior to ^DIR
 ;Optional input: SDS=subscript lookup value for level 2 (required for level 2)
 ;Optional input: SDO="O" to indicate input is optional
 ;Optional input: SDPFL=print field level (1,2) for print field prompts
 ;Optional input: SDA=1 to force single item selection prompt
 X:$L($G(SDEXE)) SDEXE I '$D(DIR(0)) D @("DIR"_SDLEV)
 I '$G(SDA),$E(DIR(0))="S",$L(DIR(0),":")=2 Q $P($P(DIR(0),U,2),":")_U_$P(DIR(0),":",2)
 D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q ""
 I X="" S SDNUL=1 Q ""
 Q Y_U_$S($L($G(Y(0))):Y(0),1:Y)
 ;
DIR1 N X,I,II S X="",I=0 F  S I=$O(^TMP("SCRPW",$J,"SEL",1,I)) Q:'I  S II="" F  S II=$O(^TMP("SCRPW",$J,"SEL",1,I,II)) Q:II=""  S:$$PFL1() X=X_";"_II_":"_$P(^TMP("SCRPW",$J,"SEL",1,I,II),T)
 S DIR(0)="S"_$G(SDO)_"^"_$E(X,2,245) Q
 ;
DIR2 N X,I,II S X="",I=0 F  S I=$O(^TMP("SCRPW",$J,"SEL",2,SDS,I)) Q:'I  S II="" F  S II=$O(^TMP("SCRPW",$J,"SEL",2,SDS,I,II)) Q:II=""  S:$$PFL2() X=X_";"_II_":"_$P(^TMP("SCRPW",$J,"SEL",2,SDS,I,II),T)
 S DIR(0)="S"_$G(SDO)_"^"_$E(X,2,245) Q
 ;
PFL1() ;Print field level 1 evaluator
 Q:'$G(SDPFL) 1
 Q $P(^TMP("SCRPW",$J,"SEL",1,I,II),T,2)>(SDPFL-1)
 ;
PFL2() ;Print field level 2 evaluator
 Q:'$G(SDPFL) 1
 Q $P(^TMP("SCRPW",$J,"SEL",2,SDS,I,II),T,2)>(SDPFL-1)
 ;
DIRB1(S1,S2,SDEF) ;Set DIR("B")
 ;Required input: S1, S2=subscript values
 ;Optional input: SDEF=default value
 S DIR("B")=$S($D(SDPAR(S1,S2)):$P(SDPAR(S1,S2),U,2),1:$G(SDEF))
 K:'$L(DIR("B")) DIR("B") Q
