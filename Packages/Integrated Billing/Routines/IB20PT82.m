IB20PT82 ;ALB/CPM - EXPORT ROUTINE 'DGPTF' ; 14-FEB-94
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
DGPTF ;ALB/JDS/AS - PTF LOAD/EDIT DRIVER ; 12/13/89 @8
 ;;5.3;Registration;**26**;Aug 13, 1993
 ;
 D LO^DGUTL
 I $D(^DISV(DUZ,"^DPT(")),$D(^("^DGPT(")) S A=+^("^DGPT("),B=+^("^DPT(") I $D(^DGPT(A,0)),$D(^DPT(B,0)) S:(+^DGPT(A,0)'=B&$D(^DGPT("B",B))) ^DISV(DUZ,"^DGPT(")=""
ASK W !! K DIC S DIC="^DGPT(",DIC(0)="EQMZA",DGPR=0,DIC("S")="I '$P(^DGPT(+Y,0),U,6)!($P(^(0),U,6)=1),$P(^(0),U,11)=1"
 D ^DIC G Q1:Y'>0 S PTF=+Y,DGREL=$S($D(^XUSEC("DG PTFREL",DUZ)):1,1:0)
 I '$D(^DGPT(PTF,"M",0))#2 S ^(0)="^45.02^^"
 K DIC S DFN=+Y(0),DGADM=+$P(Y(0),U,2),^DISV(DUZ,"^DPT(")=DFN,DGST=+$P(Y(0),U,6)
 N DGPMCA,DGPMAN D PM^DGPTUTL
 D:DGST=0 MT^DGPTUTL,INCOME^DGPTUTL1
 I DGST I 'DGREL!($D(DGQWK))!(DGST>1) W:$X>60 "   ???--Already ",$S(DGST=1:"Closed",DGST=2:"Released",1:"Transmitted") G ASK
 ;
EN1 ;
 K DGPTFE S DGPTFE=$P(^DGPT(PTF,0),"^",4)
 I 'DGPTFE,'DGST G UP:$P(DGPMAN,"^",16)'=PTF D:'$P(^DGPT(PTF,0),"^",5) SUF D LE^DGPTTS,DC
 I $D(DGQWK) D ^DGPTFQWK,Q1 S DGQWK=1 G DGPTF
 ;
GETD ;
 K A
 I $P(^DGPT(PTF,0),U,11)=1 D CEN^DGPTC1
 F I=0,.521,.11,.52,.321,.32,57,.3 S A(I)="" S:$D(^DPT(DFN,I))&('DGST) A(I)=^(I) I DGST S:$D(^DGP(45.84,PTF,$S('I:10,1:I))) A(I)=^($S('I:10,1:I))
 K B F I=0,101,70 S B(I)="" S:$D(^DGPT(PTF,I)) B(I)=^(I)
 S DGDD=+B(70),DGFC=+$P(B(0),U,3)
 S Y=DGDD D FMT^DGPTUTL
 S Y=DGADM D D^DGPTUTL S DGAD=Y,HEAD="Name: "_$P(A(0),U,1)_"  SSN: "_$P(A(0),U,9)_" Dt of Adm: "_DGAD
 S DGN=$S(DGST!DGPR:1,1:0)
 I DGPR S (DGST,DGPTFE)=1 G FAC^DGPTF1
 I DGPTFE,'DGST K DR S DIE="^DGPT(",DA=PTF,DR="2" D ^DIE K DR G Q:$D(Y) S DGADM=$P(^DGPT(PTF,0),U,2),^DISV(DUZ,"PTFAD",DFN)=DGADM,Y=DGADM D D^DGPTUTL S HEAD=$P(HEAD,DGAD,1)_Y
 G ^DGPTF1
 ;
Q I '$P(^DGPT(PTF,0),"^",4),'$P(^(0),U,6) W !,"  Updating TRANSFER DRGs" S DGADM=$P(^DGPT(PTF,0),U,2) D SUDO1^DGPTSUDO
 D Q1
 I $D(DGADPR)!($D(DGPTOUT)) K DGPTOUT Q
 G DGPTF
 ;
Q1 ; -- housekeeping
 I $D(IOM) S X=IOM X ^%ZOSF("RM")
 D KVAR^DGPTUTL1,KVAR^DGPTC1
 Q
 ;
SUF I $D(^DIC(42,+$P(DGPMAN,U,6),0)) S X=$P(^(0),U,3),X=$S(X="":"",X="D":"BU",X="NH":"9AA",1:"") Q:X=""  S $P(^DGPT(PTF,0),U,5)=X
 Q
ORDER ; -- order mvt ; I1 := #mvts+1 ; M() := mvt array
 N DGRT S DGRT=$S(I1<25:"MT",1:"^UTILITY(""DGPTMT"",$J)") K @DGRT
 F I=0:0 S I=$O(M(I)) Q:'I  S NU=+$P(M(I),U,10),NU=$S('NU:9999999+I,1:NU),NU=$S($D(@DGRT@(NU)):NU+(I*.1),1:NU) S @DGRT@(NU,I)=M(I)
 S K=0 F I=0:0 S I=$O(@DGRT@(I)) Q:'I  S K=K+1,J=$O(@DGRT@(I,0)) S M(K)=@DGRT@(I,J)
 K @DGRT Q
 ;
ADM S DFN=+^DGPT(DA,0),%=$O(^("M","AM",0)) I %<X&(%>0) K X W !,"Not after first movement"
 Q:'$D(X)  I $D(^DGPT("AAD",DFN,X))&($P(^DGPT(DA,0),U,2)'=X) K X W !,"There is already a PTF entry at that time"
 Q
 ;
WR Q:'$D(^(0))  S DGNODE=^(0),DGADM=$P(DGNODE,U,2) W "  Admitted: ",$E(DGADM,4,5)_"-"_$E(DGADM,6,7)_"-",$E(DGADM,2,3)," "
 F DGZ=6,4 S %=";"_$S($D(^DD(45,DGZ,0)):$P(^(0),U,3),1:"") W $P($P(%,";"_$P(DGNODE,U,DGZ)_":",2),";",1)_" "
 K DGNODE,DGZ Q
 ;
DC S DGPDN=$S($D(^DGPM(+$P(DGPMAN,"^",17),0)):^(0),1:"")
 S DGDC=+DGPDN,DG72=$S($D(^DG(405.2,+$P(DGPDN,"^",18),0)):$P(^(0),"^",8),1:0),DGTY=$S(DGDC:1,1:"")
 I DGDC F I=0:0 S I=$O(^DGPM("APMV",DFN,DGPMCA,I)) Q:I'>0  I $D(^DGPM(+$O(^(I,0)),0)),$P(^(0),"^",2)=2 S J=U_$P(^(0),"^",18)_U,DGTY=$S("^43^44^13^45^"[J:4,"^1^"[J:2,"^2^3^"[J:3,1:1) Q
 S X=$S($D(^DGPT(PTF,70)):^(70),1:"")
 S DR="70///"_$S(DGDC:"/"_DGDC,'X:"",1:"@")_$S(DG72:";72////"_DG72,1:"")_";72.1///"_$S(DGTY:"/"_DGTY,'$P(X,"^",14):"",1:"@"),DIE="^DGPT(",DA=PTF D ^DIE
 I DGDC>DT,$P(DGPDN,"^",18)=42 W:'$D(ZTQUEUED) !,"Discharge 'While ASIH' is in the future."
 K DG72,DGTY,DGPDN Q
 ;
UP S DIE="^DGPT(",DR="4///F",DA=PTF D ^DIE W !,"Pointer from Patient file is incorrect. Record changed to Fee Basis",! S DGPTFE=1 G GETD
