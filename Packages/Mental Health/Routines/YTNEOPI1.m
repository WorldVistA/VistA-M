YTNEOPI1 ;ALB/ASF-NEO PI-R TEST PROFILE ;7/28/95  12:56 ;
 ;;5.01;MENTAL HEALTH;**10**;Dec 30, 1994
A ;setup
 K YSAST S YSTV=75,YSBV=25,YSINC=1,YSLE=5 F J=31,32,33,34,35,1:1:30 S A(J)=$P(S,U,J) S:A(J)>YSTV A(J)=YSTV S:A(J)<YSBV A(J)=YSBV
 S YSVS=1,YSHS="75,65,55,45,35,25^"
 S Z1="123456123456123456123456123456NEOAC"
 S Z2=" VERY HIGH   HIGH     AVERAGE     LOW    VERY  LOW"
 S Z3="N N N N N N E E E E E E O O O O O O A A A A A A C C C C C C"
 S Z4="1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6"
 F I=1:1 S J=$P(YSHS,",",I) Q:J=""  S H(I)=+J
 S YSLC1=9999,YSLV=YSTV,YSIN2=YSINC/2
 S YSHS=$O(H(-1)),H(-1)=-999
TOP ;
 D DTA^YTREPT
 W !!?30,"NEO PI-R Profile",!?5,"Factors"
 W ?16,Z3,!?5,"N E O A C",?16,Z4
L ;loop thru graph
 F I=31:1:35,1:1:30 S B(I)=(A(I)'<(YSLV-YSIN2))&(A(I)<(YSLV+YSIN2)) I $D(C(I)) S:(C(I)'<(YSLV-YSIN2))&(C(I)<(YSLV+YSIN2)) B(I)=2
 S YSLL=$S(YSLV=75:">74",YSLV=25:"<26",YSLV#10=0:YSLV,1:"  ")
W ;
 S YSWS=(H(YSHS)>(YSLV-YSIN2))&(H(YSHS)<(YSLV+YSIN2)) I YSWS D WS G:YSLFT END S YSHS=$O(H(YSHS))
 I 'YSWS D WL G:YSLFT END
 S YSLC1=YSLC1+1 S:YSLC1>YSLE YSLC1=1
 I YSLV>YSBV S YSLV=YSLV-YSINC GOTO L
 D BOTTOM
END ;
 K A,B,YSA,YSTV,YSTVL,YSBV,YSINC,YSIN2,YSLE,YSVS,YSHS,V,H,YSLL,YSLC1,YSWS Q
WL ;
 D:IOST?1"C-".E SCR^YTREPT:$Y>(IOSL-4) Q:YSUOUT!YSTOUT
  W !,$J($E(Z2,(76-YSLV))_YSLL,4),"|"
 F I=31:1:35,1:1:30 W $S(B(I):$E(Z1,I)_" ",1:"  ") W:I=35 "|"
 W "|",YSLL Q
WS ;
 D:IOST?1"C-".E SCR^YTREPT:$Y>(IOSL-4) Q:YSUOUT!YSTOUT
 W !,$J(YSLL,4),"|"
 F I=31:1:35,1:1:30 W $S(B(I):$E(Z1,I)_"-",1:"--") W:I=35 "|"
 W "|",YSLL Q
 Q
BOTTOM ;
 Q:YSUOUT!YSTOUT
 W !?5,"N E O A C",?16,Z3,!?16,Z4
 W !!,"Copyright (c) 1985, 1988, 1992, 1994 by Psychological Assessment Resources Inc.",!,"Reproduced by permission."
 Q
IR ;responses
 D RD^YTNEOPI
 W !?30,"NEO PI-R Item Responses",!
 F K=1:1:30 Q:YSLFT  D:IOST?1"C-".E SCR^YTREPT:$Y+4>IOSL W ! F J=0,30,60,90,120,150,180,210 S I=J+K D IR1
 W !,"  Validity A. " S I=241 D IR2
 S X=$E(X,1,240)
 W !!?30,"Summary of Responses",!?3
 F J=1,2,3,4,5,"X" S J1=$L(X,J)-1/240*100 W $S(J=1:"SD",J=2:"D",J=3:"N",J=4:"A",J=5:"SA",1:"X"),": ",$J(J1,5,2),"%   "
 Q
IR1 W $J(I,4),". "
IR2 W $S($E(X,I)=1:"SD",$E(X,I)=2:" D",$E(X,I)=3:" N",$E(X,I)=4:" A",$E(X,I)=5:"SA",1:" X")," "
 Q
VALD ;validity index
 D DTA^YTREPT W !!?30,"Validity Indices",!
 D RD^YTNEOPI
 I $L($E(X,1,240),"X")>42 W !,"Profile not scored as respondant has skipped more",!,"than 41 items.",! Q
 S YSVFLAG=0
 D SS,241,YN,RAND,VTXT
 Q
VTXT I YSVFLAG=0 W !,"Validity indices are within normal limits and the obtained",!,"test data appear to be valid.",! Q
 Q:YSVFLAG=1
 W !,"TEST RESULTS ARE NOT CONSIDERED VALID. The profile will",!,"be printed but it should only be used if the administrator has reason to"
 W !,"believe that the profile is valid despite these indications of inaccurate",!,"or random responding."
 Q
241 S Y=$E(X,241) I (Y<3)!(Y="X") S YSVFLAG=2 W !,"The respondant has denied answering the questions honestly and accurately."
 Q
RAND ;randon resp
 S Y=$E(X,1,240) I (Y?.E7"1".E)!(Y?.E10"2".E)!(Y?.E11"3".E)!(Y?.E15"4".E)!(Y?.E10"5".E) S YSVFLAG=2 W !,"The rater has used the same response option repeatedly in a manner",!,"that suggests random responding."
 Q
YN ;yea_nea
 S Y=$E(X,1,240),Y=($L(Y,5)-1)+($L(Y,4)-1)
 I Y>149 S YSVFLAG=1 W !,"This profile should be interpreted with CAUTION because a strong acquiescence",!,"bias may have influnced the results."
 I Y<51 S YSVFLAG=1 W !,"This profile should be interpreted with CAUTION because a strong nay-saying",!,"bias may have influnced the results."
 Q
SS ;scale skips
 F I=1:1:30 D SS1:$P(YSXK,U,I)>3
 Q
SS1 I 'YSVFLAG S YSVFLAG=1 W !,"The following facet scale(s) have more than 3 skipped items:"
 W !?3,$P(^YTT(601,YSTEST,"S",I,0),U,2)
 Q
