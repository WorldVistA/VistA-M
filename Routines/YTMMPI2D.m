YTMMPI2D ;ASF/ASB=MMPI2 EXERIMENTAL CONTENT COMPONENTS ;1/17/96  14:20
 ;;5.01;MENTAL HEALTH;**10**;Dec 30, 1994
SCOR ;
 S (R,S)="" F J=107:1:138 D T0^YTMMPI2A S P=YSSX D LK^YTMMPI2A
 K A,YSTVL S YSSCALE=S,YSRAW=R
 D NV,WAIT^YTMMPI2B:IOST?1"C-".E Q:YSLFT
 D ASS,WAIT^YTMMPI2B:IOST?1"C-".E Q:YSLFT
 D ECC,WAIT^YTMMPI2B:IOST?1"C-".E Q:YSLFT
 Q
NV ;new validity scales
 D DTA^YTREPT W !!?25,"New Validity Scales",!!,?50,"Raw Score",?65,"T score"
 F J=137,138 S YSN=$P(^YTT(601,YSTEST,"S",J,0),U,2),R=$P(YSRAW,U,J-106),S=$P(YSSCALE,U,J-106) W !?3,$E($P(YSN," ",2,9),1,36)," (",$P(YSN," "),")",?50,$J(R,4),?65,$J(S,4) D:$Y+4>IOSL&(IOST?1"C-".E) WAIT^YTMMPI2B Q:YSLFT
 W !?8,"F(p) interpreted only in Inpatient or Correctional settings"
 Q
ASS ;additional scales
 W !!!?25,"Additional Supplementary Scales",!!,?50,"Raw Score",?65,"T score"
 F J=134,135,136 S YSN=$P(^YTT(601,YSTEST,"S",J,0),U,2),R=$P(YSRAW,U,J-106),S=$P(YSSCALE,U,J-106) W !?3,$E($P(YSN," ",2,9),1,36)," (",$P(YSN," "),")",?50,$J(R,4),?65,$J(S,4) D:$Y+4>IOSL&(IOST?1"C-".E) WAIT^YTMMPI2B Q:YSLFT
 W !?8,"MDS interpreted only when individual is married or separated"
 Q
ECC ;experimental content
 W !!!?25,"Experimental Content Component Scales",!!,?50,"Raw Score",?65,"T score"
 F J=107:1:133 D ECCW D:$Y+4>IOSL&(IOST?1"C-".E) WAIT^YTMMPI2B Q:YSLFT
 Q
ECCW ;
 W:J=107 !!,"Fears Subscales"
 W:J=109 !!,"Depression Subscales"
 W:J=113 !!,"Health Concerns Subscales"
 W:J=116 !!,"Bizarre Mentation Subscales"
 W:J=118 !!,"Anger Subscales"
 W:J=120 !!,"Cynicism Subscales"
 W:J=122 !!,"Antisocial Practices Subscales"
 W:J=124 !!,"Type A Subscales"
 W:J=126 !!,"Low Self-Esteem Subscales"
 W:J=128 !!,"Social Discomfort Subscales"
 W:J=130 !!,"Family Problems Subscales"
 W:J=132 !!,"Negative Treatment Indicator Subscales"
 S YSN=$P(^YTT(601,YSTEST,"S",J,0),U,2),R=$P(YSRAW,U,J-106),S=$P(YSSCALE,U,J-106) W !?3,$E($P(YSN," ",2,9),1,36)," (",$P(YSN," "),")",?50,$J(R,4),?65,$J(S,4)
