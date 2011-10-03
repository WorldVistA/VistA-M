YTALUSE ;ALB/ASF TEST-AUDIT ALCOHOL SCREEN ;4/30/97  09:25
 ;;5.01;MENTAL HEALTH;**31**;Dec 30, 1994
SCOR ;
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)
 S R=0 F I=1:1:8 S R=R+$E(X,I)
 S X1=$S($E(X,9)=1:2,$E(X,9)=2:4,1:0) S R=R+X1
 S X1=$S($E(X,10)=1:2,$E(X,10)=2:4,1:0) S R=R+X1
 D REPT^YTREPT
 W !!,"A score of 8 or more indicates a strong likelihood of hazardous",!,"or harmful alcohol consumption."
 QUIT
