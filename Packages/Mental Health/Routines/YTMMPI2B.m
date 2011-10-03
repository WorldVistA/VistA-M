YTMMPI2B ;ALB/ASF-MMPI2 HARRIS:LINGOS,CRIT,OS ;6/19/03  14:43
 ;;5.01;MENTAL HEALTH;**10,31,76,70**;Dec 30, 1994
SCOR ;
 S (R,S)="" F J=44:1:84 D T0^YTMMPI2A S P=YSSX D LK^YTMMPI2A
 K A,YSTVL S YSSCALE=S,YSRAW=R
 D HL,WAIT:IOST?1"C-".E Q:YSLFT
 D SI Q:YSLFT
 ;D OS,WAIT:IOST?1"C-".E Q:YSLFT
 D NEWSC,WAIT:(IOST?1"C".E)&($Y+4>IOSL) Q:YSLFT
 D PSY5,WAIT:(IOST?1"C".E)&($Y+4>IOSL) Q:YSLFT
 D RCCLIN,WAIT:IOST?1"C".E Q:YSLFT
 ;I $D(^YTT(601,YSTEST,"S",107)) D ^YTMMPI2D,WAIT:IOST?1"C-".E Q:YSLFT
 D CRIT,WAIT:IOST?1"C-".E Q:YSLFT  D:(X(0)["X")!(X(1)["X")!(X(2)["X") OMIT,WAIT:IOST?1"C-".E Q:YSLFT  D NK^YTMMPI2P Q
HL ;HARRIS LINGOS
 D DTA^YTREPT W !!!?25,"Harris-Lingoes Subscales",!?10,"(to be used as an aid in interpreting the parent scale)",!!?50,"Raw Score",?65,"T Score"
 F J=44:1:71 S YSN=$P(^YTT(601,YSTEST,"S",J,0),U,2),R=$P(YSRAW,U,J-43),S=$P(YSSCALE,U,J-43) D:YSN?.E1"1".E HLPARNT W !?3,$E($P(YSN," ",2,9),1,36)," (",$P(YSN," "),")",?50,$J(R,4),?65,$J(S,4) D:$Y+4>IOSL&(IOST?1"C-".E) WAIT Q:YSLFT
 Q
HLPARNT ;
 W:J'=44 !! W !,$S(J=44:"Depression",J=49:"Hysteria",J=54:"Psychopathic Deviate",J=59:"Paranoia",J=62:"Schizophrenia",1:"Hypomania")," Subscales",! Q
WAIT ;
 I IOST'?1"C-".E D DTA^YTREPT Q
 ; %%  ANOTHER READER CALL ???? LOOK YSLFT = YSTOUT %%%
 W $C(7) R YSLFT:DTIME S YSTOUT='$T,YSUOUT=YSLFT["^"
 S:YSLFT["^"!'$T YSLFT=1 Q:YSLFT  S Z1=1 W # Q
SI ;
 D DTA^YTREPT W !!!?25,"Social Introversion Subscales",!?18,"(Ben-Porath, Hostetler, Butcher, and Graham)",!!?50,"Raw Score",?65,"T Score"
 F J=72:1:74 S YSN=$P(^YTT(601,YSTEST,"S",J,0),U,2),R=$P(YSRAW,U,J-43),S=$P(YSSCALE,U,J-43) W !?3,$E($P(YSN," ",2,9),1,36)," (",$P(YSN," "),")",?50,$J(R,4),?65,$J(S,4) D:$Y+4>IOSL WAIT Q:YSLFT
 Q
OS ;OBVIOUS SUBTLE
 W !!!!?25,"Wiener-Harmon Subtle-Obvious Subscales",!!?50,"Raw Score",?65,"T Score"
 F J=75:1:84 S YSN=$P(^YTT(601,YSTEST,"S",J,0),U,2),R=$P(YSRAW,U,J-43),S=$P(YSSCALE,U,J-43) W !?3,$E($P(YSN," ",2,9),1,36)," (",$P(YSN," "),")",?50,$J(R,4),?65,$J(S,4) D:$Y+4>IOSL WAIT Q:YSLFT
 S S=$P(YSSCALE,U,32,41) W !!?3,"Total T Score Difference (Obvious-Subtle): ",$P(S,U)+$P(S,U,3)+$P(S,U,5)+$P(S,U,7)+$P(S,U,9)-$P(S,U,2)-$P(S,U,4)-$P(S,U,6)-$P(S,U,8)-$P(S,U,10)
 Q
NEWSC ;scales AAS,AAP,marital,fp S,hostility
 Q:'$D(^YTT(601,YSTEST,"S",107))
 W !!?25,"Additional Supplementary Scales",!
 S (R,S)="" F J=107:1:112 D T0^YTMMPI2A S P=YSSX D LK^YTMMPI2A
 K A,YSTVL S YSSCALE=S,YSRAW=R
 F J=107:1:112 S YSN=$P(^YTT(601,YSTEST,"S",J,0),U,2),R=$P(YSRAW,U,J-106),S=$P(YSSCALE,U,J-106) W !?3,$E($P(YSN," ",2,9),1,36)," (",$P(YSN," "),")",?50,$J(R,4),?65,$J(S,4) D:$Y+4>IOSL WAIT Q:YSLFT
 W !!,"Uniform T scores are used for HS, D, Hy, Pd, Pa, Pt, Sc, Ma, and",!,"the Content Scales; all other MMPI-2 scales use linear T scores.",! Q
PSY5 ; ADDED 8/30/02 ASF
 Q:'$D(^YTT(601,YSTEST,"S",114))
 W !?25,"PSY-5 Personality Psychopathology Five",!?50,"Raw Score",?65,"T Score"
 S (R,S)="" F J=114:1:118 D T0^YTMMPI2A S P=YSSX D LK^YTMMPI2A
 K A,YSTVL S YSSCALE=S,YSRAW=R
 F J=114:1:118 S YSN=$P(^YTT(601,YSTEST,"S",J,0),U,2),R=$P(YSRAW,U,J-113),S=$P(YSSCALE,U,J-113) W !?3,YSN,?50,$J(R,4),?65,$J(S,4) D:$Y+4>IOSL WAIT Q:YSLFT
 Q
RCCLIN ;restructured clinical
 Q:$G(^YTT(601,YSTEST,"S",119,0))'?.E1"RC".E
 W !!?25,"RC Restructured Clinical Scales",!?50,"Raw Score",?65,"T Score"
 S (R,S)="" F J=119:1:127 D T0^YTMMPI2A S P=YSSX D LK^YTMMPI2A
 K A,YSTVL S YSSCALE=S,YSRAW=R
 F J=119:1:127 S YSN=$P(^YTT(601,YSTEST,"S",J,0),U,2),R=$P(YSRAW,U,J-118),S=$P(YSSCALE,U,J-118) W !?3,YSN,?50,$J(R,4),?65,$J(S,4) D:$Y+4>IOSL WAIT Q:YSLFT
 Q
CRIT ;CRITICAL ITEMS
 D DTA^YTREPT W !?25,"Critical Items",!! S N=0 F I=1:1 S N=$O(^YTT(601,YSTEST,"G",1,1,N)) Q:'N  W !,^(N,0)
 S YSCNT=0 F J=85,88,86,89,87,90 D CRIT1 Q:YSLFT
 Q:YSLFT  W !!!,YSCNT," Koss-Butcher Critical Items were endorsed."
 S YSCNT=0 F J=91:1:100,106 D CRIT1 Q:YSLFT
 Q:YSLFT  W !!!,YSCNT," Lachar-Wrobel Critical Items were endorsed."
 Q
CRIT1 ;
 S YSN=$P(^YTT(601,YSTEST,"S",J,0),U,2),YSKY=$S($D(^YTT(601,YSTEST,"S",J,YSSX_"K")):^(YSSX_"K"),1:^YTT(601,YSTEST,"S",J,"K",1,0))
 I $D(^YTT(601,YSTEST,"S",J,"K",2,0)) S YSKY=YSKY_^(0)
 S X(0)=^YTD(601.2,YSDFN,1,YSTEST,1,YSED,1),X(1)=^(2),X(2)=^(3) D:$Y+4>IOSL WAIT Q:YSLFT  W !!!,YSN,!
 F I=1:2 S YSIT=$P(YSKY,U,I) Q:YSIT'?1N.N  S B=$P(YSKY,U,I+1) I $E(X(YSIT\200),YSIT#200)=B S YSCNT=YSCNT+1 D L,WAIT:$Y+4>IOSL
 Q
L W !,$J(YSIT,5),". " F K=1:1 Q:'$D(^YTT(601,YSTEST,"Q",YSIT,"T",K))  W:K'=1 !?7 W ^YTT(601,YSTEST,"Q",YSIT,"T",K,0)
 W:B'="X" " (",B,")" Q
OMIT ;OMITTED ITEMS
 D DTA^YTREPT W !!!?25,"OMITTED ITEMS",!!!,"The following items were omitted by the client.  It may be helpful to",!,"discuss these items with this individual to determine the reason",!,"for non-compliance with test instructions.",!!!
 S B="X" F I=0,1,2 I X(I)["X" F J=1:1:$L(X(I)) I $E(X(I),J)="X" S YSIT=J+(200*I) D L
 D WAIT Q
VV ;
 S N=0 F  S N=$O(^YTT(601,202,"S",N)) Q:'N  S G=^(N,0) W !,N,?5,$P(G,U),?10,$P(G,U,2)
