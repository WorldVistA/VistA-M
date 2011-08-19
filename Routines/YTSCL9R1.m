YTSCL9R1 ;ALB/ASF-SCL90 R CONTINUED ;1/5/96  08:54
 ;;5.01;MENTAL HEALTH;**10**;Dec 30, 1994
 D DTA^YTREPT ;header
 W !?25,"SCL-90-R CLINICAL PROFILE",!?3,"T-score",?70,"Percentile"
A ;
 K YSAST S YSNS=12,YSTV=80,YSBV=30,YSINC=1,YSLE=5 S X=S(2),YSLFT=0
 F J=1:1:9,11,12,13 S A(J)=$P(X,U,J),YSAST(J)="" S:A(J)>YSTV!(A(J)<YSBV) YSAST(J)=">"
 S YSVS=3,YSHS="80,50,30^"
 F I=1:1 S J=$P(YSHS,",",I) Q:J=""  S H(I)=+J
 S YSLM=80-(YSNS*4+20)\2+5
 S YSLC1=9999,YSLV=YSTV,YSIN2=YSINC/2
 S YSHS=$O(H(-1)),H(-1)=-999
L ;
 F I=1:1:9,11,12,13 S B(I)=(A(I)'<(YSLV-YSIN2))&(A(I)<(YSLV+YSIN2))
 S YSLL=$S(YSLC1'<YSLE:$J(YSLV,5,0),1:"     ")
W ;
 S YSWS=(H(YSHS)>(YSLV-YSIN2))&(H(YSHS)<(YSLV+YSIN2)) I YSWS D WS G:YSLFT END S YSHS=$O(H(YSHS))
 I 'YSWS D WL G:YSLFT END
 S YSLC1=YSLC1+1 S:YSLC1>YSLE YSLC1=1
 I YSLV>YSBV S YSLV=YSLV-YSINC GOTO L
END ;
 K A,B,YSA,YSTV,YSTVL,YSBV,YSINC,YSIN2,YSLE,YSVS,YSHS,V,H,YSLL,YSLC1,YSWS Q
WL ;
 D:IOST?1"C-".E SCR^YTREPT:$Y>(IOSL-4) Q:YSUOUT!YSTOUT
  W !?5,YSLL,"|"
 F I=1:1:9,11,12,13 W $S(B(I):"  *"_$E(YSAST(I)_"  ",1,2),1:"     ") W:I=9 "|"
 ;W "|",YSLL Q
 W "|",$S(YSLV=30:2,YSLV=35:7,YSLV=40:16,YSLV=45:30,YSLV=50:50,YSLV=55:70,YSLV=60:84,YSLV=65:93,YSLV=70:98,YSLV=75:99,1:"") Q
WS ;
 D:IOST?1"C-".E SCR^YTREPT:$Y>(IOSL-4) Q:YSUOUT!YSTOUT
 W !?5,YSLL,"|"
 F I=1:1:9,11,12,13 W $S(B(I):"--*"_$E(YSAST(I)_"--",1,2),1:"-----") W:I=9 "|"
 W "|",$S(YSLV=30:2,YSLV=35:7,YSLV=40:16,YSLV=45:30,YSLV=50:50,YSLV=55:70,YSLV=60:84,YSLV=65:93,YSLV=70:98,YSLV=75:99,1:"") Q
 Q
BOTTOM ;
 W !,?11 F I=1:1:9,11,12,13 W " "_$P($P(^YTT(601,YSTEST,"S",I,0),U,2),";")_" "
 W !!," T non-pt." F I=1:1:9,11,12,13 W $J($P(S(2),U,I),5,0) W $S(I=6:" ",I=11:" ",1:"")
 W !," Raw Score" F I=1:1:9,11,12 W $J($P(R,U,I),5,2) W $S(I=6:" ",I=11:" ",1:"")
 W $J($P(R,U,13),5,0)
 W !," T out-pt." F I=1:1:9,11,12,13 W $J($P(S(1),U,I),5,0) W $S(I=6:" ",I=11:" ",1:"")
 W !," T in-pt. " F I=1:1:9,11,12,13 W $J($P(S(3),U,I),5,0) W $S(I=6:" ",I=11:" ",1:"")
 D:IOST?1"C-".E SCR^YTREPT Q:YSUOUT!YSTOUT
 Q
NOTE ;symptoms of note (4 or 3)
 D DTA^YTREPT
 D RD^YTSCL9R
 W !!?10,"SYMPTOMS OF NOTE"
 W !!?3,"The patient endorsed 'Extremely' distressd for the following:"
 I $L(X,4)=1 W !!?5,"No items endorsed 'extremely' distressed."
 E  F I=1:1:90 W:$E(X,I)=4 !?3,$J(I,2)_". "_^YTT(601,YSTEST,"Q",I,"T",3,0) D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 Q:YSUOUT!YSTOUT
 W !!?3,"The patient endorsed 'moderately' distressd for the following:"
 I $L(X,3)=1 W !!?5,"No items endorsed 'moderately' distressed."
 E  F I=1:1:90 W:$E(X,I)=3 !?3,$J(I,2)_". "_^YTT(601,YSTEST,"Q",I,"T",3,0) D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 W !!?3,$L(X,"X")-1," item"_$S($L(X,"X")=2:" was",1:"s were")_" ommitted."
