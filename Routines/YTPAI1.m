YTPAI1 ;ALB/ASF-PAI TEST PROFILE ;11/7/95  13:45 ;
 ;;5.01;MENTAL HEALTH;**10**;Dec 30, 1994
A ;setup
 K YSAST S YSTV=100,YSBV=28,YSINC=2,YSLE=5 F J=1:1:53 S A(J)=$P(S,U,J) S:A(J)>YSTV A(J)=YSTV S:A(J)<YSBV A(J)=YSBV S:A(J)#2 A(J)=A(J)-1
 S YSVS=1,YSHS="100,70,50,28"
 F I=1:1 S J=$P(YSHS,",",I) Q:J=""  S H(I)=+J
 S YSLC1=9999,YSLV=YSTV,YSIN2=YSINC/2
 S YSHS=$O(H(-1)),H(-1)=-999
TOP ;
 D DTA^YTREPT
 W !!?30,"PAI Full Scale Profile"
 W !?19,"1  2  3  4  5  6  7  8  9 10 11   A  B  C  D  E   Y  Z"
L ;loop thru graph
 F I=1,2,3,4,5,9,13,17,21,25,29,33,38,42,43,44,48:1:53 S B(I)=(A(I)'<(YSLV-YSIN2))&(A(I)<(YSLV+YSIN2)) I $D(C(I)) S:(C(I)'<(YSLV-YSIN2))&(C(I)<(YSLV+YSIN2)) B(I)=2
 S YSLL=$S(YSLV=100:">99",YSLV=98:98,YSLV=28:"<30",YSLV#10=0:YSLV,1:"  ")
W ;
 S YSWS=(H(YSHS)>(YSLV-YSIN2))&(H(YSHS)<(YSLV+YSIN2)) I YSWS D WS G:YSLFT END S YSHS=$O(H(YSHS))
 I 'YSWS D WL G:YSLFT END
 S YSLC1=YSLC1+1 S:YSLC1>YSLE YSLC1=1
 I YSLV>YSBV S YSLV=YSLV-YSINC GOTO L
 D BOTTOM
END ;
 Q  ;K A,B,YSA,YSTV,YSTVL,YSBV,YSINC,YSIN2,YSLE,YSVS,YSHS,V,H,YSLL,YSLC1,YSWS Q
WL ;
 D:IOST?1"C-".E SCR^YTREPT:$Y>(IOSL-4) Q:YSUOUT!YSTOUT
  W !,$J(YSLL,4),"|"
 F I=1,2,3,4,5,9,13,17,21,25,29,33,38,42,43,44,48:1:53 S C=$S(A(I)>$P(^YTT(601,YSTEST,"S",I,"M"),U,3):" * ",1:" + ") W $S(B(I):C,1:"   ") W:I=4!(I=43)!(I=51) "|"
 W "|",YSLL Q
WS ;
 D:IOST?1"C-".E SCR^YTREPT:$Y>(IOSL-4) Q:YSUOUT!YSTOUT
 W !,$J(YSLL,4),"|"
 F I=1,2,3,4,5,9,13,17,21,25,29,33,38,42,43,44,48:1:53 S C=$S(A(I)>$P(^YTT(601,YSTEST,"S",I,"M"),U,3):"-*-",1:"-+-") W $S(B(I):C,1:"---") W:I=4!(I=43)!(I=51) "|"
 W "|",YSLL Q
 Q
BOTTOM ;
 Q:YSUOUT!YSTOUT
 W !?6,"I  I  N  P   S  A  A  D  M  P  S  B  A  A  D   A  S  S  N  R   D  W"
 W !?6,"C  N  I  I   O  N  R  E  A  A  C  O  N  L  R   G  U  T  O  X   O  R"
 W !?6,"N  F  M  M   M  X  D  P  N  R  Z  R  T  C  G   G  I  R  N  R   M  M"
TS ;
 W !!?2,"T   "
 F I=1,3,5,13,21,29,38,43,48,50,52 W $S(I=5!(I=48)!(I=52):" ",1:""),$P(S,U,I),"    "
 W !?9 F I=2,4,9,17,25,33,42,44,49,51,53 W $S(I=9!(I=44)!(I=53):" ",1:""),$P(S,U,I),"    "
RS ;
 W !!," Raw " F I=1,2,3,4,5,9,13,17,21,25,29,33,38,42,43,44,48:1:53 W:I=5!(I=44)!(I=52) " " W $J($P(R,U,I),3)
 D BTEXT
 Q
IR ;responses
 D RD^YTPAI
 W !?30,"PAI Item Responses",!
 F K=1:1:43 Q:YSLFT  D:IOST?1"C-".E SCR^YTREPT:$Y+4>IOSL W ! F J=0:1:7 S I=J*43+K D IR1
 Q
IR1 W $J(I,4),". "
IR2 W $S($E(X,I)=1:"F ",$E(X,I)=2:"ST",$E(X,I)=3:"MT",$E(X,I)=4:"VT",1:" X")," "
 Q
SUBS ;sub scales
 D DTA^YTREPT
 W !!?25,"PAI Subscale Profile"
 W !?38,"<+3    4    5    6    7    8    9    9>"
 W !?30,"Raw    T",?40,"0....0....0....0....0....0....0....9"
 S YSLN="         |         |               "
 S YSLAST="SOM"
 F I=1:1:53 I $P(^YTT(601,YSTEST,"S",I,0),U,2)?3U1"-".E D SS1
 D RD^YTPAI W !!?2,"Missing Items = ",$L(X,"X")-1
 D BTEXT
 Q
SS1 ;
 D:IOST?1"C-".E SCR^YTREPT:$Y>(IOSL-4) Q:YSUOUT!YSTOUT
 I YSLAST'=$E($P(^YTT(601,YSTEST,"S",I,0),U,2),1,3) W ! S YSLAST=$E($P(^YTT(601,YSTEST,"S",I,0),U,2),1,3)
 W !?2,$P(^YTT(601,YSTEST,"S",I,0),U,2),?30,$J($P(R,U,I),3),$J($P(S,U,I),5)
 S C=$S($P(S,U,I)>$P(^YTT(601,YSTEST,"S",I,"M"),U,3):"*",1:"+")
 S Y1=$P(S,U,I),Y=$S(Y1>98:100,Y1<30:30,1:Y1) S:Y#2 Y=Y-1
 S Y1=Y-30/2,YSLN1=$E(YSLN,1,Y1-1)_C_$E(YSLN,Y1+1,99)
 W ?41,YSLN1
 Q
BTEXT ;
 W ! S Y=0 F  S Y=$O(^YTT(601,YSTEST,"G",2,1,Y)) Q:Y'>0  W !,^(Y,0)
CC W !,"Copyright (c) 1989, 1990, 1991 by Psychological Assessment Resources Inc.",!,"Reproduced by permission."
