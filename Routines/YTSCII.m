YTSCII ;SLC/DKG-TEST PKG: SCII ;4/11/91  15:13 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 D HDR W !?16,$P(^YTT(601,YSTEST,"P"),U),!!,"General Occupational Themes" D BOXTOP
 S YSRM="",X3=^YTT(601,YSTEST,"G",1,1,1,0),X1=^YTD(601.2,YSDFN,1,YSET,1,YSED,1),X2=^(2) F I=1:1:6 D THM
 I IOST?1"C-".E D WAIT^YSUTL Q:YSLFT=1  D HDR
BASINT ;
 W !!,"Basic Interest Scales" D BOXTOP F I=7:1:29 D THM I $Y+4>IOSL D:IOST?1"C-".E WAIT^YSUTL Q:YSLFT  D HDR W !,"Basic Interest Scales" D BOXTOP
 I IOST?1"C-".E D WAIT^YSUTL Q:YSLFT=1
 S YSLNE=".    .    .    .         .    .    .    ." D HDR,MHD F I=30:1:236 D OCC
 D SD,WAIT^YSUTL:IOST?1"C-".E Q:YSLFT=1  D HDR K YSLNE W !?22,"--- Administrative Indices ---",!!?39,"RESPONSE PERCENT",!?39,"LP     IP     DP",!
 S V=1,X=^YTT(601,YSTEST,"G",4,1,1,0) D ADM
 W !!!?26,"--- Special Scales ---",!! F I=237,238 D TSCR W !?21,$P(^YTT(601,YSTEST,"S",I,0),U,2),?50,$J(T,3,0)
 S:YSSX="M" L=15,K=8,X=^YTT(601,YSTEST,"G",5,1,1,0) S:YSSX="F" L=16,K=7,X=^YTT(601,YSTEST,"G",6,1,1,0)
 F J=1:1:L S P=$P(X,",",J),N=P S:N<0 N=N*-1 D Y I M=$S(P<0:3,1:1) S K=K-1
 S YSRM=YSRM_K
 W !!?21,"INFREQUENT RESPONSES",?50,$J(K,3) D:IOST?1"C-".E WAIT^YSUTL W !!!!!!!!!!!!! F I=1:1:5 W ^YTT(601,YSTEST,"G",7,1,I,0),!
 K A,G,YSLNE,I,YSIT,J,K,YSKK,L,M,N,P,YSPT,YSRM,YS10,YS25,YS50,YS75,YS90,YSBOX,YSOCNM,YSOCP,YSOCSX,YSOCAT,T,V,X,X1,X2,X3,X4,Y Q
TSCR ;
 S YSKK=1,T=0
S1 ;
 I $D(^YTT(601,YSTEST,"S",I,"K",YSKK,0))#2=0 S X=^YTT(601,YSTEST,"S",I,"M"),T=$J((T-$P(X,U)/$P(X,U,2)*10+50),0,0) K Y S YSRM=YSRM_T_"^" Q:I#60  S YSRM="" Q
 S Y=^YTT(601,YSTEST,"S",I,"K",YSKK,0),P=1
T1 ;
 S YSIT=$P(Y,U,P) I YSIT="" S YSKK=YSKK+1 G S1
 S A=$P(Y,U,P+1),P=P+2,M=$S(YSIT<201:$E(X1,YSIT),1:$E(X2,YSIT-200)) S:M?1N T=T+$E(A,M)-1 G T1
THM ;
 S X4=^YTT(601,YSTEST,"S",I,YSSX_"K") D TSCR F J=1:1:7 I T'>$P(X4,",",J) Q
 W !!,$P(^YTT(601,YSTEST,"S",I,0),U,2),?21,$J(T,3,0),?27,$P(X3,",",J) D BAR Q
MHD ;
 W !?25,"--- Occupational Scales ---"
SHD ;
 W !!?3,^YTT(601,YSTEST,"G",2,1,1,0),!?2,"F   M",?29,"F    M",?39,^YTT(601,YSTEST,"G",3,1,1,0)
SD ;
 W !?38,"10   15   25   30        40   45   55   I" Q
BOXTOP ;
 W ?38,"30        40        50        60        70" Q
OCC ;
 S G=$P(^YTT(601,YSTEST,"S",I,0),U,2),YSOCP=$P(G,";",2),YSOCSX=$P(G,";",3) S G=$P(G,";"),YSOCAT(YSOCSX)=$E(G,1,3),YSOCNM=$E(G,5,25) D TSCR S T(YSOCSX)=T D GRAF G:YSOCP'="" OCCX
 I YSOCSX="F" S I=I+1 G OCC
 W !,YSOCAT("F")," ",YSOCAT("M")," ",YSOCNM,?28,$J(T("F"),3),?33,$J(T("M"),3,0) D LN Q
OCCX ;
 I YSOCSX="M" W !?4,$P(G,";"),?28,$J(YSOCP,3),?33,$J(T,3,0) D LN:YSSX="M",FRMFD:YSSX="F" Q
 I YSOCSX="F" W !,YSOCAT("F"),"     ",YSOCNM,?28,$J(T,3),?33,$J(YSOCP,3) D LN:YSSX="F",FRMFD:YSSX="M" Q
LN ;
 W "  ",$E(YSLNE,1,A(YSSX)-1),"X",$E(YSLNE,A(YSSX)+1,99)
FRMFD ;
 Q:$Y+4<IOSL  S YSLFT=0 D SD,WAIT^YSUTL:IOST?1"C-".E Q:YSLFT  D HDR,SHD
 Q
GRAF ; similarity table same sex only
 I T>58 S A(YSOCSX)=41 Q
 I T>55 S A(YSOCSX)=T-55+36 Q
 I T>45 S A(YSOCSX)=$J(T-45/2,0,0)+31 Q
 I T>40 S A(YSOCSX)=T-40+26 Q
 I T>30 S A(YSOCSX)=T-30+16 Q
 I T>25 S A(YSOCSX)=T-25+11 Q
 I T>15 S A(YSOCSX)=$J(T-15/2,0,0)+6 Q
 S A(YSOCSX)=T-9 S:A(YSOCSX)<1 A(YSOCSX)=1 Q
HDR ;
 D DTA^YTREPT W ! Q
ADM ;
 S J=1 F N=1:1:3 S YSPT(N)=0
A1 ;
 S L=$P("131,36,51,39,24,30,14",",",J) F N=1:1:3 S P(N)=0
 F N=V:1:V+L-1 D Y I M S P(M)=P(M)+1
 F N=1:1:3 S YSPT(N)=YSPT(N)+P(N),P(N)=$J(100*P(N)/L,3,0)
 S V=V+L W !?19,$P(X,",",J),?38,P(1),?45,P(2),?52,P(3)
 S J=J+1 I J<8 G A1
 F N=1:1:3 S YSPT(N)=$J(100*YSPT(N)/325,3,0)
 W !?19,$P(X,",",8),?38,YSPT(1),?45,YSPT(2),?52,YSPT(3) K P,YSPT Q
Y ;
 S M=$S(N<201:$E(X1,N),1:$E(X2,N-200)) Q
 ;
BAR ;Percentile Bar graph based on sex distribution
 S G1="",$P(G1,"-",25)="",G=^YTT(601,YSTEST,"S",I,YSSX_"S"),YS10=+G,YS25=$P(G,",",2),YS50=$P(G,",",3),YS75=$P(G,",",4),YS90=$P(G,",",5)
 S YSBOX=$E("            ",1,YS10-30)_$E(G1,1,YS25-YS10)_"I"_$E(G1,1,YS50-YS25-1)_"|"_$E(G1,1,YS75-YS50-1)_"I"_$E(G1,1,YS90-YS75),YSBOX=$E(YSBOX_"               ",1,40)
 W ?38,$E(YSBOX,1,T-30)_"*"_$E(YSBOX,T-28,99) Q
