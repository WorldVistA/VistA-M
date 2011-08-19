YTCESD ;ALB/ASF- CESD DEPRESSION SCALE ;7/17/03  10:20
 ;;5.01;MENTAL HEALTH;**70**;Dec 30, 1994
 ;
 N I,X,N,YSLFT,YSOUT,YTOUT,YSNX
 S YSNOITEM="DONE^YTREPT"
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)
 S R=0,S=""
 F I=1,2,3,5,6,7,9,10,11,13,14,15,17,18,19,20 S R=R+$E(X,I)
 F I=4,8,12,16 S:($E(X,I)'="X") R=R+(3-$E(X,I))
 S YSNX=$L(X,"X")-1
 Q:YSTY'["*"
 D DTA^YTREPT
 W !!?10,$P(^YTT(601,YSET,"P"),U)
 W !!,"CES-D score= ",R,"  A score of 16 or more is considered depressed."
 W:YSNX>3 !!,"Screen invalid: ",YSNX," missing items"
 W !
 F I=1:1:20 D
 . D:$Y+4>IOSL WAIT
 . W !?3,$E(^YTD(601.2,YSDFN,1,YSET,1,YSED,1),I)
 . I (I=4)!(I=8)!(I=12)!(I=16) W "-"
 . W ?6,^YTT(601,YSET,"Q",I,"T",1,0)
 . W:I=3 "..."
 W !!,"0= less than a day  1= 1-2 days  2= 3-4 days  3= 5-7 days"
 D:$Y+4>IOSL WAIT
DONE Q
CESD5 ;5 item screen
 N I,X,N,YSLFT,YSOUT,YTOUT,YSNX
 S YSNOITEM="DONE^YTREPT"
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)
 S R=0,S=""
 F I=1,2,3,4 S R=R+$E(X,I)
 S:($E(X,5)'="X") R=R+(3-$E(X,5))
 Q:YSTY'["*"
 D DTA^YTREPT
 W !!?10,$P(^YTT(601,YSET,"P"),U)
 W !!,"CES-D5 score= ",R,"  A score of 4 or more is a positive depression screen."
 W !
 F I=1:1:5 D
 . D:$Y+4>IOSL WAIT
 . W !?3,$E(^YTD(601.2,YSDFN,1,YSET,1,YSED,1),I)
 . I (I=5) W "-"
 . W ?6,$E(^YTT(601,YSET,"Q",I,"T",1,0),1,45)
 . W:I=1 " ..."
 W !!,"0= less than a day  1= 1-2 days  2= 3-4 days  3= 5-7 days"
 D:$Y+4>IOSL WAIT
 Q
WAIT ;
 ;  Added 5/6/94 LJA
 ;
 F I0=1:1:(IOSL-$Y-2) W !
 N DTOUT,DUOUT,DIRUT
 S DIR(0)="E" D ^DIR K DIR S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT),YSLFT=$D(DIRUT)
 W @IOF Q
