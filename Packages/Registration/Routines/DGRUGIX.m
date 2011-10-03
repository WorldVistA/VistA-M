DGRUGIX ;ALB/BOK/MLI - RUG-II INDEX BY DATE ; 9 FEB 88
 ;;5.3;Registration;**89**;Aug 13, 1993
 D LO^DGUTL,Q,ASK
Q W ! K %,%DT,%Y,^UTILITY($J),CT,D,DFN,DG1,DGA,DGAD,DGB,DGC,DGCT,DGD
 K DGED,DGEND,DGG,DGH,DGI,DGIFN,DGIN,DGLN,DGN,DGNEW,DGNOW,DGP,DGPG
 K DGPGM,DGPT,DGQ,DGR,DGS,DGSD,DGSRT,DGST,DGTD,DGVAR,DGW,DGWD,DGWD1
 K DGWR,DGX,DGYR,DGZ,DIC,I,I1,J,POP,R,DGCL,SEL,VAUTNI,VAUTSTR,VAUTVB
 K DGWWU,VAIN,VAUTD,VAUTN,VAUTP,VAERR,X,Y,Z,DIV
 D KVAR^VADPT,CLOSE^DGUTQ
 Q
ASK S DGQ=0,X=""
 W !!,"Sort by (A)ssessment or (T)ransfer/Admission Date: T//" S Z="^TRANSFER/ADMISSION^ASSESSMENT"
 R X:DTIME
 Q:X["^"!('$T)
 I X="" S X="T" W X
 D IN^DGHELP
 I %=-1 W !!,?12,"CHOOSE FROM:",!?12,"A - Date range for the search is by Assessment Date",!?12,"T - Date range is by Transfer or admission date",! S %="" G ASK
 S DGX=$S(X="T":"AC",1:"AA")
DAT S %DT(0)="-DT",%DT="AEPX",%DT("A")="START DATE: " D ^%DT Q:X["^"  G:Y<0 DAT S DGSD=Y-.1
 S %DT("A")="  END DATE: ",%DT(0)=DGSD+.1,%DT="AEPX" D ^%DT Q:X["^"  G:Y<0 DAT S DGED=Y_.9
 K DIC
 D ASK2^SDDIV Q:Y<0
 N ERR S ERR=$$CHOSE^DGRUGU1() I +ERR<0 G QUIT^DGRUGPP1
 S SEL=$P(ERR,"^",2)
 S VAUTSTR="RUG group",VAUTNI=2,VAUTVB="DGR",DIC="^DG(45.91,"
 D FIRST^VAUTOMA Q:Y<0
 S VAUTNI=2,DIC("S")="I $D(^DG(45.9,""B"",+Y))"
 D PATIENT^VAUTOMA Q:Y<0
 S DGCT=0 F J=1:0:20 W !,"Enter Category: " W:($O(DGCT(0))="") "ALL// " R X:DTIME Q:(X="")!(X="^")!('$T)  W:X["?" "  Enter a category or 'return' when all categories",!,"have been selected" D CL Q:(X="^")!('$T)  I Y>0 S DGCT(Y)=Y(0),J=J+1
 Q:(X="^")!('$T)
 I X="",($O(DGCT(0))="") S DGCT=1
OK W !!,"You have selected output for:",!!?4,$S(DGX="AA":"Assessment",1:"Transfer/Admission")," dates between "
 S Y=$P(DGSD,".",1)+1
 D DT^DIQ
 W " and "
 S Y=$P(DGED,".",1)
 D DT^DIQ
 W !,?4,"Patients: ",$S(VAUTN:"ALL",1:"") X:'VAUTN "S X=""VAUTN"" D M"
 I SEL="R"!(SEL="B") W !,?4,"Divisions for Wards: ",$S(VAUTD:"ALL",1:"") X:'VAUTD "S X=""VAUTD"" D M"
 I $D(DGW) I ($O(DGW(0))'="")!(DGW) W !?4,"Wards: ",$S(DGW:"ALL",1:"") I 'DGW S X="DGW" D M
 I $D(DGCL) I ($O(DGCL(0))'="")!(DGCL) W !?4,"CNH Locations: ",$S(DGCL:"ALL",1:"") I 'DGCL S X="DGCL" D M
 W !,?4,"RUG-II Groups: ",$S(DGR:"ALL",1:"") X:'DGR "S X=""DGR"" D M"
 W !,?4,"Categories: ",$S(DGCT:"ALL",1:"") I 'DGCT S X="DGCT" D M
 W !!,"IS THIS CORRECT" S %=1 D YN^DICN G OK:%Y["?",Q:%'=1
 S DGPGM="1^DGRUGIX",DGVAR="DGSD^DGED^DGR^DGX^VAUTD#^VAUTN#^DGR#^DGCT#^DGW#^DGCL#"
 W !!,*7,"This output requires 132 columns!",!
 D ZIS^DGUTQ G:POP Q
 U IO
 S X=132 X ^%ZOSF("RM")
 D 1,CLOSE^DGUTQ
 Q
 ;
1 D DATE^DGRUGIX1
 S (DGPG,DGH,^UTILITY($J,"TOT"))=0
 F I=1:1:17 S ^UTILITY($J,"TOT",I)=0
 F D=DGSD:0 S D=$O(^DG(45.9,DGX,D)) Q:D'>0!(D>DGED)  F DGIFN=0:0 S DGIFN=$O(^DG(45.9,DGX,D,DGIFN)) Q:DGIFN'>0  I $D(^DG(45.9,DGIFN,0)) S DFN=$P(^(0),U) I $D(^DPT(DFN,0))&($D(VAUTN(DFN))!(VAUTN)) D CS
 S DGWD=0
 F DGWD1=0:0 D:DGWD'=0 H^DGRUGIX1 S DGWD=$O(^UTILITY($J,"I",DGWD)) Q:DGWD=""  D INIT F DGG=0:0 S DGG=$O(^UTILITY($J,"I",DGWD,DGG)) Q:DGG'>0  F DFN=0:0 S DFN=$O(^UTILITY($J,"I",DGWD,DGG,DFN)) Q:DFN'>0  D CONT
 I '$D(^UTILITY($J,"I")) W:$E(IOST)="C" @IOF W !,"***RUG-II INDEX REPORTS--NO MATCHES FOUND***" D Q Q
 I $D(DGW),DGW=0 S I="",I=$O(DGW(I)),J=$O(DGW(I)) G:J="" Q
 D H^DGRUGIX1
 G Q
 ;
CS I $D(^DG(45.9,DGIFN,"R")),$D(^("C")),($P(^("C"),U)'=5) D
 .S R=^("R")
 .I $P($G(^DG(45.9,DGIFN,0)),"^",6)'=3 Q:'$D(DGW)  Q:(DGW=0)&('+$O(DGW(0)))  Q:(DGR'=1)&('$D(DGR(+$P(R,U))))  S DGWD1=+$P(R,U),DGWD=$S($D(^DIC(42,+DGWD1,0)):$P(^(0),U),1:0)
 .I $P($G(^DG(45.9,DGIFN,0)),"^",6)=3 Q:'$D(DGCL)  Q:(DGCL=0)&('+$O(DGCL(0)))  Q:(DGCL'=1)&('$D(DGCL(+$P(R,U))))  S DGWD1=+$P(R,U),DGWD=$S($D(^FBAAV(+DGWD1,0)):$P(^(0),U),1:0)
 .Q:'$D(DGWD)  ;bad pointer
 .S DGG=$P(R,U,2),CT=$P(R,U,4)
 .I DGWD'=0,DGG,CT&(DGR!($D(DGR(DGG))))&(DGCT!($D(DGCT(CT)))) D
 ..I $D(DGW),($P($G(^DG(45.9,DGIFN,0)),"^",6)'=3) D
 ...I DGW!($D(DGW(DGWD1))) I VAUTD=1!($D(VAUTD(+$P($G(^DIC(42,DGWD1,0)),"^",11)))) D S
 ..I $D(DGCL),($P($G(^DG(45.9,DGIFN,0)),"^",6)=3)&(DGCL)!($D(DGCL(DGWD1))) D S
 Q
S S DGN=$E($P(^DPT(DFN,0),U),1,25),DGS=$P(^(0),U,9)
 S DGB=$P(^(0),U,3),DGP=$P(^DG(45.9,DGIFN,0),U,6)
 S:DGX="AA" DGD=$P(^(0),U,7)
 S:DGX="AC" DGD=$P(^(0),U,2)
 S ^UTILITY($J,"I",DGWD,DGG,DFN,D)=DGN_"^"_DGS_"^"_DGD_"^"_DGP_"^"_DGB_"^"_CT
 Q
CONT F D=0:0 S D=$O(^UTILITY($J,"I",DGWD,DGG,DFN,D)) Q:D'>0  D 1^DGRUGIX1
 Q
CL I X["?" W !,"Choose from (H)eavy Rehabilitation, (S)pecial Care, (C)linical Complex",!,"(B)ehavioral, or (P)hysical: " R X:DTIME Q:'$T
 S Z="^HEAVY REHABILITATION^SPECIAL CARE^CLINICAL COMPLEX^BEHAVIORAL^PHYSICAL",DGZ=Z G:X["?" CL I X="^" S DGQ=1 Q
 Q:X=""  D IN^DGHELP I %=-1 S X="?" G CL
 S Y=$S(X="H":1,X="S":2,X="C":3,X="B":4,X="P":5,1:0),Y(0)=$P(DGZ,"^",Y+1) G:'Y CL
 Q
M S I=0,I=$O(@(X_"(I)"))
 Q:I=""
 W @(X_"(I)")
 F I1=I:0 S I=$O(@(X_"(I)")) Q:I=""  W ", ",@(X_"(I)")
 Q
INIT S ^UTILITY($J,"W",DGWD)=0 F I=1:1:17 S ^UTILITY($J,"W",DGWD,I)=0
 Q
