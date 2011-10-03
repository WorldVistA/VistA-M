YTMYER ;SLC/DKG-TEST PKG: MYERS-BRIGGS ;11/4/91  14:59
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 S YSRP=^YTD(601.2,YSDFN,1,YSET,1,YSED,1) F J=1:1:4,7,8 D SCR
 G:YSSX="F" V0 F J=5,6 D SCR
 S R(5)=R(5)+1 G V1
V0 F J=9,10 D SCR
 S R(5)=R(9),R(6)=R(10)
V1 S K="" F J=1:1:8 S K=K_R(J)_"^"
 I R(1)>R(2) S YSTY=" E",YSRT=R(1)-R(2)*2-1
 E  S YSTY=" I",YSRT=R(2)-R(1)*2+1
 I R(3)>R(4) S YSTY=YSTY_" S",YSRT=YSRT_"^"_(R(3)-R(4)*2-1)
 E  S YSTY=YSTY_" N",YSRT=YSRT_"^"_(R(4)-R(3)*2+1)
 I R(5)>R(6) S YSTY=YSTY_" T",YSRT=YSRT_"^"_(R(5)-R(6)*2-1)
 E  S YSTY=YSTY_" F",YSRT=YSRT_"^"_(R(6)-R(5)*2+1)
 I R(7)>R(8) S YSTY=YSTY_" J",YSRT=YSRT_"^"_(R(7)-R(8)*2-1)
 E  S YSTY=YSTY_" P",YSRT=YSRT_"^"_(R(8)-R(7)*2+1)
 S X=$P(^YTT(601,YSTEST,"P"),"^",1) D DTA^YTREPT W !!?(72-$L(X)\2),X,!! D W30,WI
 S X="    .     .     .     I     .     .     .    "
 S T1="EXTRAVERSION^INTROVERSION^     SENSING^INTUITION^    THINKING^FEELING^     JUDGING^PERCEPTIVE" F J=1:1:4 D GRP
 W ! D WI,W30
 I IOST?1"C".E D WAIT G:YSLFT END
 S T1=$E(T1,1,26)_$E(T1,32,49)_$E(T1,54,70)_$E(T1,76,93) W !!!! F J=1:1:4 D TYP
 ;I IOST?1"C".E D WAIT G:YSLFT END
 ;W !!!!!!?25,"--- ITEM RESPONSES ---",!! S YSIT=1,K=10 F I=1:1:12 D RLN
 ;S K=6 D RLN
END K I,YSIT,J,K,YSKK,L,P,R,YSRP,YSRT,T1,YSTY,W,X,Y,Z Q
RLN W ?1 F YSKK=1:1:K W $J(YSIT,3,0)," ",$E(YSRP,YSIT),"  " S YSIT=YSIT+1
 W ! Q
SCR S R(J)=0,Y=^YTT(601,YSTEST,"S",J,"K",1,0)
 F Z=1:1 S YSIT=$P(Y,",",Z) Q:YSIT=""  S L=$L(YSIT),W=$E(YSIT,L),P=$E(YSIT,L-1),YSIT=+YSIT S:$E(YSRP,YSIT)=P R(J)=R(J)+W
 Q
W30 W !?16,"60    40    20     0    20    40    60" Q
WI W !?17,"I     I     I     I     I     I     I" Q
GRP S L=$P(YSRT,"^",J)+3\4 I "INFP"[$E(YSTY,J*2) S L=L+23+$S(L>15:3,L>10:2,L>5:1,1:0) G G1
 S L=23-L-$S(L>15:3,L>10:2,L>5:1,1:0)
G1 S Y=$E(X,1,L-1)_"X"_$E(X,L+1,45),L=2*J-1
 W !!?1,$P(T1,"^",L),Y,$P(T1,"^",L+1) Q
TYP S L=2*J,K=$E(YSTY,L) S:"ESTJ"[K L=L-1
 W !!?26,K,"  ",$P(T1,"^",L),?41,$J($P(YSRT,"^",J),5,0) Q
WAIT F I0=1:1:(IOSL-$Y-2) W !
 ;%%%%   READER CALL NEEDED HERE%%%%
 R !,"Press return to continue or ""^"" to escape ",YSLFT:DTIME S YSTOUT='$T,YSUOUT=YSLFT["^" I YSTOUT!YSUOUT S YSLFT=1 W @IOF Q
