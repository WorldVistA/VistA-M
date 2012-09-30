YTMMPI2P ;SLC/DKG,ALB/ASF-TEST PKG: MMPI2 PROFILE; ;4/11/91  15:51
 ;;5.01;MENTAL HEALTH;**19,37**;Dec 30, 1994
A ;
 K YSAST S YSTV=110,YSBV=30,YSINC=2,YSLE=5 S Z1=0,X=YSSCALE,YSLFT=0 F J=1:1:YSNS S (A(J),YSA(J))=$P(X,U,J),YSAST(J)="" S:A(J)>YSTV YSAST(J)=">" S:A(J)>YSBV YSAST=">"
 S YSVS=3,YSHS="110,66,50,30^"
 F J=1:1:YSNS S Z1=$P(YSSNM,",",J),Z1=$P(Z1," "),$P(YSSNM,",",J)=Z1_YSAST(J)
 S YSSNM1="" F I=1:1:YSNS S YSSNM1=YSSNM1_$P($P(YSSNM,",",I)," ")_$S($L($P(YSSNM,",",I))>1:"",1:" ")_","
 F I=1:1 S J=$P(YSHS,",",I) Q:J=""  S H(I)=+J
 S YSLM=80-(YSNS*4+20)\2+5
 S YSLC1=9999,YSLV=YSTV,YSIN2=YSINC/2
 S YSHS=$O(H(-1)),H(-1)=-999
L ;
 F I=1:1:YSNS S B(I)=(A(I)'<(YSLV-YSIN2))&(A(I)<(YSLV+YSIN2)) I $D(C(I)) S:(C(I)'<(YSLV-YSIN2))&(C(I)<(YSLV+YSIN2)) B(I)=2
 S YSLL=$S(YSLC1'<YSLE:$J(YSLV,5,0),1:"     ")
W ;
 S YSWS=(H(YSHS)>(YSLV-YSIN2))&(H(YSHS)<(YSLV+YSIN2)) I YSWS D WS G:YSLFT END S YSHS=$O(H(YSHS))
 I 'YSWS D WL G:YSLFT END
 S YSLC1=YSLC1+1 S:YSLC1>YSLE YSLC1=1
 I YSLV>YSBV S YSLV=YSLV-YSINC GOTO L
END ;
 K A,B,YSA,YSTV,YSTVL,YSBV,YSINC,YSIN2,YSLE,YSVS,YSHS,V,H,YSLL,YSLC1,YSWS Q
WL ;
 D:IOST?1"C-".E WAIT:$Y>(IOSL-4) Q:YSLFT  W:'Z1 ! W ?YSLM,YSLL,"|" S Z1=0
 I YSSK="B" F I=1:1:YSNS W $S(B(I):$E($P(YSSNM1,",",I)_"   ",1,3),1:"   ") I I<YSNS W $S($D(V(I)):"|",1:" ")
 I YSSK="K" F I=1:1:YSNS W $S(B(I)=2:" + ",B(I):$E($P(YSSNM1,",",I)_"   ",1,3),1:"   ") I I<YSNS W $S($D(V(I)):"|",1:" ")
 I YSSK'="B"&(YSSK'="K") F I=1:1:YSNS S X="*   " S:$P(YSSNM,",",I)?1"TR".E&(YSSK="S") X=$S($P(YSRAW,U,I)<9:"F   ",$P(YSRAW,U,I)>9:"T   ",1:"#   ") W $S(B(I):X,1:"    ")
 W "|",$E(YSLL,3,5) Q
WS ;
 D:IOST?1"C-".E WAIT:$Y>(IOSL-4) Q:YSLFT  W:'Z1 ! W ?YSLM,YSLL,"|" S Z1=0
 I YSSK="B" F I=1:1:YSNS W $S(B(I):$P(YSSNM1,",",I)_"-",1:"---") I I<YSNS W $S($D(V(I)):"|",1:"-")
 I YSSK="K" F I=1:1:YSNS W "-",$S(B(I)=2:"+-",B(I):$P(YSSNM,",",I),1:"--") I I<YSNS W $S($D(V(I)):"|",1:"-")
 I YSSK'="B"&(YSSK'="K") F I=1:1:YSNS S X="*---" S:$P(YSSNM,",",I)?1"TR".E&(YSSK="S") X=$S($P(YSRAW,U,I)<9:"F---",$P(YSRAW,U,I)>9:"T---",1:"#---") W $S(B(I):X,1:"----")
 W "|",$E(YSLL,3,5) Q
 Q
DTA ;
 S YSDTA=$P(^YTD(601.2,YSDFN,1,YSET,1,YSHD,0),U,5) S:YSDTA'="" YSDTA=$$FMTE^XLFDT(YSDTA,"5ZD")
 S YSHDR=$E(YSHDR,1,43)_" "_YSSX_" AGE "_$J(YSAGE,2,0)_" "_$$FMTE^XLFDT(DT,"5ZD")_" "_$$FMTE^XLFDT(YSHD,"5ZD")
 W YSHDR," ",YSDTA W ! W:$D(YSAST) "'<' OR '>' indicates 'T' out of table range" W ?53,"PRINTED  ENTERED  " W:YSDTA'="" "ADMIN" Q
WAIT ;
 ; %%  ANOTHER READER CALL ???? LOOK YSLFT = YSTOUT %%%
 Q:IOST'?1"C-".E  W $C(7) R YSLFT:DTIME S YSTOUT='$T,YSUOUT=YSLFT["^" S:YSLFT["^"!'$T YSLFT=1 Q:YSLFT  S Z1=1 W # Q
 Q
NK ;NON-K CORRECTED
 S J=100 F I=4,7,10,11,12 S J=J+1,A(J)=$P(YSRNK,U,I),S="" D LK^YTMMPI2A S C(I)=+S
HD ;
 S (S,YSSCALE)=YSSCALEB,DOT=YSHD,YSNS=13,V(3)="",YSSK="K",YSSNM="L ,F ,K ,HS,D ,HY,PD,MF,PA,PT,SC,MA,SI"
 W @IOF,!!?25,"K and Non-K Corrected Profile",! D ^YTMMPI2P Q:YSLFT
BOTTM ;
 W !?YSLM+6 F I=1:1:YSNS W $E($P(YSSNM,",",I)_"    ",1,4)
 W !?2,"Raw Score:" F I=1:1:YSNS W $J($P(YSRNK,U,I),4) W:I=3 " "
 S X=$P(YSRNK,U,3) W !!?2,"K Corr.",?27,$J(X*.5,2,0),?$X+10,$J(X*.4,2,0),?$X+10,$J(X,2),"  ",$J(X,2),"  ",$J(X*.2,2,0)
 W !!?2,"T Score:  " F I=1:1:YSNS W $J($P(S,U,I),4) W:I=3 " "
 W !!?2,"+Non-K Corr.",!?3,"T Score:",?26,$J(C(4),3),?$X+9,$J(C(7),3),?$X+9,$J(C(10),3)," ",$J(C(11),3)," ",$J(C(12),3)
 W !!?2,"? Cannot Say (Raw): ",YSQR K A,C,S,YSRAW,YSNRK
 W !! D DTA,WAIT,CR G:YSLFT END^YTMMPI2 S YSFORM=1 D IR^YTREPT
 D ^YTMMPI2C ;Print user comments
 Q
CR ;COPYRIGHT
 I $P(^YTT(601,YSTEST,0),U,6)]"" S YSCH=$P(^(0),U,6),Y=$P(^(0),U,7) D DD^%DT S YSCD=Y I $D(^YTT(601.3,YSCH,0)) S YSCHN=YSCH,YSCH=$P(^(0),U) D CR^YTDRIV
 I IOST'?1"C-".E D WPO
 Q
WPO ;
 ;WRITE PRINTED BY - ORDERED BY ------MJD 10/15/96
 N YSI
 F YSI=1:1:IOSL-$Y-5 W !
 W !,"Printed by: ",$P(^VA(200,DUZ,0),U),!
 S YSORD=$P(^YTD(601.2,YSDFN,1,YSET,1,YSED,0),U,3)
 I YSORD,$D(^VA(200,YSORD,0)) W "Ordered by: ",$P(^(0),U)
 Q
