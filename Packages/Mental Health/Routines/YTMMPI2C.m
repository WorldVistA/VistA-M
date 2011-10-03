YTMMPI2C ;DALISC/LJA - Show Comments ;11/09/93 10:37
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
COMM ;  YSDFN,YSET,YSED -- req
 QUIT:'($G(YSDFN)*$G(YSET)*$G(YSED))  ;->
 QUIT:$O(^YTD(601.2,+YSDFN,1,+YSET,1,+YSED,"R",0))'>0  ;->
 ;
 ;  Comment's   0 NODE, AUTHOR, DATE, IEN, LINE NO, TEXT OF LINE,
 ;              NO OF LINES, TRANSCRIBER
 N YTC0,YTCA,YTCDT,YTCIEN,YTCLNO,YTCLTXT,YTNL,YTCT
 N YTOK,YTX
 ;
 ;  Display of ITEM RESPONSES just completed...
 F  QUIT:(IOSL-$Y)<3  W !
 I IOST["C-" D  QUIT:'YTOK  ;->
 .  S YTOK=1
 .  K DIR S DIR(0)="EA"
 .  S DIR("A")="Hit RETURN to view Clinician Comments, or '^' to exit... "
 .  D ^DIR K DIR
 .  I +Y'=1 S YTOK=0
 W @IOF,?35,"Clinician Comments",!
 S X="",$P(X,"-",IOM+1)="" W X,!
 ;
LOOP S YTCIEN=0,YTOK=1
 F  S YTCIEN=$O(^YTD(601.2,+YSDFN,1,+YSET,1,+YSED,"R",YTCIEN)) QUIT:YTCIEN'>0!('YTOK)  D
 .  S YTC0=$G(^YTD(601.2,+YSDFN,1,+YSET,1,+YSED,"R",+YTCIEN,0))
 .  QUIT:YTC0']""  ;->
 .
 .  ;  Date of comment
 .  S Y=$P(YTC0,U,2)\1 S Y=$S(Y?7N:Y,1:"") D:Y?7N DD^%DT S YTCDT=Y
 .
 .  ;  Transcriber
 .  S X=+$P(YTC0,U,3),YTCT=$S(X>0:X,1:"")
 .  I YTCT>0 D
 .  .  S DA=+YTCT,DR=.01,DIQ="YTX",DIQ(0)="E",DIC="^VA(200,"
 .  .  K YTX D EN^DIQ1
 .  .  S YTCT=$G(YTX(200,+DA,.01,"E"))
 .
 .  ;  Author
 .  S X=+$P(YTC0,U,4),YTCA=$S(X>0:X,1:"")
 .  I YTCA>0 D
 .  .  S DA=+YTCA,DR=.01,DIQ="YTX",DIQ(0)="E",DIC="^VA(200,"
 .  .  K YTX D EN^DIQ1
 .  .  S YTCA=$G(YTX(200,+DA,.01,"E"))
 .
 .  ;  Number of Lines of comment...
 .  S YTNL=+$P($G(^YTD(601.2,+YSDFN,1,+YSET,1,+YSED,"R",+YTCIEN,1,0)),U,4)
 .
 .  ;  Loop thru lines of text, displaying them...
 .  S YTCLNO=0 K YTCLTXT
 .  F  S YTCLNO=$O(^YTD(601.2,+YSDFN,1,+YSET,1,+YSED,"R",+YTCIEN,1,YTCLNO)) QUIT:YTCLNO'>0!('YTOK)  D
 .  .  D COMMHEAD:'$D(YTCLTXT)
 .  .  S YTCLTXT=$G(^YTD(601.2,+YSDFN,1,+YSET,1,+YSED,"R",+YTCIEN,1,+YTCLNO,0))
 .  .  D CKPOS QUIT:'YTOK  ;->
 .  .  W YTCLTXT,!
 QUIT:'YTOK  ;-->  User must have entered an up-arrow...
 D COMMBT
 I IOST["C-" D WAIT
 QUIT
 ;
CKPOS ;
 ;  Check position on page
 I (IOSL-$Y)>5 QUIT  ;->
 D COMMBT
 I IOST["C-" D WAIT QUIT:'YTOK  ;->
 W @IOF,?29,"Clinician Comments continued...",!
 S X="",$P(X,"-",IOM+1)="" W X,! K X
 QUIT
 ;
WAIT ;
 ;  Added 5/6/94 LJA
 N A,B,B1,C,D,E,E1,F,F1,G,G1,H,I,J,J1,J2,J3,J4,K,L,L1,L2,M,N
 N N1,N2,N3,N4,P,P0,P1,P3,R,R1,S,S1,T,T1,T2,TT,V,V1,V2,V3
 N V4,V5,V6,W,X,X0,X1,X2,X3,X4,X7,X8,X9,Y,Y1,Y2,Z,Z1,Z3
 ;
 S YTOK=0
 I IOST'["C-" S YTOK=1 QUIT  ;->
 F  QUIT:(IOSL-$Y)<4  W !
 N DIR
 K DIR S DIR(0)="EA",DIR("A")="Hit RETURN to continue, or '^' to exit... "
 D ^DIR
 QUIT:+Y'=1  ;->
 S YTOK=1
 QUIT
 ;
COMMBT ;
 F  QUIT:(IOSL-$Y)<4  W !
 S X="",$P(X,"-",IOM+1)="" W X,!
 W YSSSN,?20,YSNM,?55,YSSEX,$S(YSSEX="F":"emale",1:"ale"),?70,"Age: ",YSAGE
 QUIT
 ;
COMMHEAD ;
 W:$Y>1 !
 W YTCDT,?15,"Author: ",$E(YTCA,1,20),?45,"Transcriber: ",$E(YTCT,1,20),!
 QUIT
 ;
EOR ;YTMMPI2C - Show Comments ;11/8/93 15:40
